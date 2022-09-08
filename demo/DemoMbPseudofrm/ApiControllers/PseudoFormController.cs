using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Net.Mime;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Web;
using System.Web.Http;

namespace DemoMbPseudofrm.ApiControllers
{
    public class PseudoFormController : ApiController
    {
        private enum Sentences
        {
            MissingField, InvalidEmail, MissingEmail, MissingUrl, MessageComingFrom, MailHeader, ResponseSubject, MailSignature, MissingSender, ResponseToUser
        }

        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "Null", "Nothing" };
        }

        // POST api/<controller>
        public ApiControllerResponse Post([FromBody] PseudoFormModelCollection pseudoForm)
        {
            ApiControllerResponse response = new ApiControllerResponse()
            {
                Success = true,
                Exitcode = 0,
                Message = "",
                Data = null
            };
            try
            {
                // Smtp server settings
                // Below smtp settings are recovered from Web.config. You may hardcode here, instead.
                string smtpServer = ConfigurationManager.AppSettings["SmtpServer"];
                string smtpUsername = ConfigurationManager.AppSettings["SmtpUsername"];
                string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"];
                string defaultSmtpFromMail = ConfigurationManager.AppSettings["DefaultSmtpFromMail"];
                string mailTo = ConfigurationManager.AppSettings["MailTo"];
                if (!int.TryParse(ConfigurationManager.AppSettings["SmtpPort"], out int smtpPort))
                    smtpPort = 25;
                if(!bool.TryParse(ConfigurationManager.AppSettings["SmtpUseSSL"], out bool smtpUseSSL))
                    smtpUseSSL = false;

                // Mail body initialization
                string notificaAdminBody = "<p>";

                // Mail title (optional, see below)
                string notificaAdminTitle = "";

                // To make customer automatic answer more specific
                string notificaUserBodySpec = "email";

                // Localization
                string lang = "en";

                // Check if smtp is configured
                if (string.IsNullOrEmpty(smtpServer) || string.IsNullOrEmpty(smtpUsername) || string.IsNullOrEmpty(smtpPassword))
                    throw new Exception("Smtp not configured!");
                if (string.IsNullOrEmpty(defaultSmtpFromMail))
                    defaultSmtpFromMail = smtpUsername;
                if(string.IsNullOrEmpty(mailTo))
                    mailTo = smtpUsername;

                // Create mail message from customer to staff
                MailMessage notificaAdmin = new MailMessage();

                // Create automatic answer to customer
                MailMessage notificaUser = new MailMessage();

                // Create and configure smtp client
                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.EnableSsl = smtpUseSSL;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                

                PseudoFormModel pitem  = pseudoForm.GetByDetail("lang");
                if(pitem != null)
                    lang = pitem.Value;

                // Parse PseudoFormModel list
                foreach (PseudoFormModel item in pseudoForm)
                {
                    // The custom attribute data-mb-detail (reflected by the PseudoFormModel.Detail property) let you handle
                    // some fields in special mode.
                    // Il field is required, I check that is not empty
                    if (item.Detail == "required")
                    {
                        if (string.IsNullOrEmpty(item.Value))
                            //throw new ArgumentException(string.Format("Missing mandatory field ({0})!", item.Name));
                            throw new ArgumentException(string.Format(Translate(Sentences.MissingField, lang), item.Label));
                    }
                    // If item.Detail is "from-mail" I check if it's not empty and set the sender of mail to staff and 
                    // the destination of automatic answer mail
                    else if (item.Detail == "from-mail")
                    {
                        if (string.IsNullOrEmpty(item.Value))
                            //throw new ArgumentException(string.Format("Missing mandatory field ({0})!", item.Name));
                            throw new ArgumentException(string.Format(Translate(Sentences.MissingField, lang), item.Label));
                        else if(IsValidMailAddress(item.Value))
                        {
                            notificaAdmin.From = new MailAddress(item.Value);
                            notificaUser.To.Add(item.Value);
                        }                          
                        else
                            //throw new ArgumentException(string.Format("Not valid email address: {0}!", item.Value));
                            throw new ArgumentException(string.Format(Translate(Sentences.InvalidEmail, lang), item.Value));
                    }

                    // row to add to mail body
                    string bodyRow = "";

                    // attribute type of input fields
                    switch (item.Type)
                    {
                        // Checks if valid email address
                        case "email":
                            if(IsValidMailAddress(item.Value))
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            else
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, Translate(Sentences.InvalidEmail, lang));
                            break;
                        // Try to convert to decimal localized number. If fails leaves unchanged
                        case "number":
                            if (decimal.TryParse(item.Value, out decimal val))
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, val);
                            else
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            break;
                        // Try to convert to localized date. If fails leaves unchanged
                        case "date":
                            if (DateTime.TryParse(item.Value, out DateTime d))
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, d.ToString("dd/MM/yyyy"));
                            else
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            break;

                        case "url":
                            if (string.IsNullOrEmpty(item.Value))
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, Translate(Sentences.MissingUrl, lang));
                            else
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            break;

                        case "checkbox":
                            if (Boolean.TryParse(item.Value, out bool b))
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, b);
                            else
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            break;
                        // Converts base64 encoded data to binary and attaches as file to the mail message
                        case "file":
                            if (!string.IsNullOrEmpty(item.Value))
                            {
                                // FileReader.readAsDataURL() result cannot be directly decoded as Base64 without first removing 
                                // the Data-URL declaration preceding the Base64-encoded data. This removes "data:*/*;base64," from the result.
                                string[] base64 = item.Value.Split(new char[] { ',' });
                                byte[] bytes = Convert.FromBase64String(base64[1]);
                                MemoryStream strm = new MemoryStream(bytes);
                                Attachment data = new Attachment(strm, item.Detail);
                                ContentDisposition disposition = data.ContentDisposition;
                                data.ContentId = item.Detail;
                                data.ContentDisposition.Inline = true;
                                notificaAdmin.Attachments.Add(data);
                            }
                            break;
                        // Hidden input fields are processed like other. You may handle in some special mode using
                        // data-mb-detail attribute. Here a hidden input with data-mb-detail="mail-title" is used to 
                        // add a title to the mail (Example "Mail order" or "Subscription request") and hidden input
                        // with data-mb-detail="customer-spec" may be use to make the answer to customer more specific 
                        // substituting generic "message" word with "order" or "subscription request".
                        case "hidden":
                            if (item.Detail == "mail-title")
                                notificaAdminTitle = string.Format("<h1>{0}</h1>", item.Value);
                            else if (item.Detail == "customer-spec")
                                notificaUserBodySpec = item.Value;
                            //else if (item.Detail == "lang")
                            //    lang = item.Value;
                            else if(item.Detail != "lang")
                                bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            break;
                        default:
                            bodyRow = string.Format("<strong>{0}</strong>: {1}<br />", item.Label, item.Value);
                            break;
                    }
                    notificaAdminBody += bodyRow;
                }

                // Adding signature
                notificaAdminBody += String.Format(Translate(Sentences.MailSignature, lang), HttpContext.Current.Request.Url.Host);

                // Check if sender mail address was found during PseudoForm parsing
                if (notificaAdmin.From == null )
                    throw new ArgumentException(Translate(Sentences.MissingSender, lang));

                // Mail to staff 
                notificaAdmin.To.Add(mailTo);
                notificaAdmin.Subject = string.Format(Translate(Sentences.MessageComingFrom, lang), HttpContext.Current.Request.Url.Host);
                notificaAdmin.IsBodyHtml = true;
                notificaAdmin.Body = string.Format(Translate(Sentences.MailHeader, lang), 
                    HttpContext.Current.Request.Url.Host, notificaAdminTitle) +
                    notificaAdminBody;

                // Force security protocol TLS 1.2
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                smtp.Send(notificaAdmin);

                // Answer to customer
                notificaUser.From = new MailAddress(defaultSmtpFromMail);
                notificaUser.Subject = string.Format(Translate(Sentences.ResponseSubject, lang), notificaUserBodySpec, 
                    HttpContext.Current.Request.Url.Host);
                notificaUser.IsBodyHtml = true;
                notificaUser.Body = String.Format(Translate(Sentences.ResponseToUser, lang), HttpContext.Current.Request.Url.Host, 
                                                    notificaUserBodySpec);
                smtp.Send(notificaUser);
                
                // Formatted email body is returned with response
                response.Data = notificaAdmin.Body;

            }
            catch (Exception e)
            {
                response.Success = false;
                response.Exitcode = e.HResult;
                response.Message = e.Message;
            }

            return response;
        }

        private static  Boolean IsValidMailAddress(String pThis) => pThis == null ? false : new EmailAddressAttribute().IsValid(pThis);

        private static string Translate (Sentences sentence, string lang)
        {
            string translated = "";

            if (lang != "it")
            {
                switch (sentence)
                {
                    case Sentences.MissingField:
                        translated = "Missing mandatory field ({0})!";
                        break;
                    case Sentences.InvalidEmail:
                        translated = "Not valid email address: {0}!";
                        break;
                    case Sentences.MissingEmail:
                        translated = "Missing or invalid email";
                        break;
                    case Sentences.MissingUrl:
                        translated = "Missing or invalid url";
                        break;
                    case Sentences.MessageComingFrom:
                        translated = "Message coming from {0}.";
                        break;
                    case Sentences.MailHeader:
                        translated = "<p>This is a customer's email message received from the site {0}:</p>{1}";
                        break;
                    case Sentences.ResponseSubject:
                        translated = "R: Your {0} to {1}";
                        break;
                    case Sentences.MailSignature:
                        translated = @"</p><p>The staff of {0}";
                        break;
                    case Sentences.MissingSender:
                        translated = "Missing sender email address";
                        break;
                    case Sentences.ResponseToUser:
                        translated = @"<p>Dear Customer, <br />
                                        Your {1} was received successfully by the staff of {0}. </p>
                                        <p>You will be contacted shortly. </p>
                                        <p>Best regards </p>
                                        <p>The staff</p>";
                        break;

                } 
            }
            else 
            {
                switch (sentence)
                {
                    case Sentences.MissingField:
                        translated = "Campo obbligatorio mancante: {0}";
                        break;
                    case Sentences.InvalidEmail:
                        translated = "Indirizzo email non valido: {0}";
                        break;
                    case Sentences.MissingEmail:
                        translated = "Email mancante o non valida";
                        break;
                    case Sentences.MissingUrl:
                        translated = "URL mancante o non valido";
                        break;
                    case Sentences.MessageComingFrom:
                        translated = "Messaggio proveniente da {0}.";
                        break;
                    case Sentences.MailHeader:
                        translated = "<p>Questo è un messaggio di posta elettronica inviato da un utente e proveniente dal sito {0}:</p>{1}";
                        break;
                    case Sentences.ResponseSubject:
                        translated = "R: Tuo {0} a {1}";
                        break;
                    case Sentences.MailSignature:
                        translated = @"</p><p>Lo staff di {0}";
                        break;
                    case Sentences.MissingSender:
                        translated = "Manca l'Indirizzo e-mail del mittente";
                        break;
                    case Sentences.ResponseToUser:
                        translated = @"<p>Caro cliente, <br />
                                        La tua {1} è stata ricevuta correttamente dallo staff di {0}.</p>
                                        <p> Verrai contattato a breve.</p>
                                        <p> Cordiali saluti </p>
                                        <p> Lo staff </p>";
                        break;
                }
            }

            return translated;
        }
    }
}