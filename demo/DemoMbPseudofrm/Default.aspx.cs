using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DemoMbPseudofrm
{
    public partial class Default : System.Web.UI.Page
    {
        private Language _lang = Language.English;
        public Language Lang
        {
            get 
            { 
                //if (ViewState["lang"] == null)
                //    ViewState["lang"] = Language.English;
                //return (Language)ViewState["lang"];
                return _lang;
            }

            set
            {
                //ViewState["lang"] = value;ù
                _lang = value;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                DataBindChildren();
        }

        protected void LinkButton_gb_Click(object sender, EventArgs e)
        {
            if ((LinkButton) sender == LinkButton_gb)
                Lang = Language.English;
            else
                Lang = Language.Italiano;

            //if (Lang == Language.English)
            //    Lang = Language.Italiano;
            //else
            //    Lang = Language.English;
            DataBindChildren();
        }
    }

    public enum Language
    {
        English, Italiano
    }
}