<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DemoMbPseudofrm.Default" %>

<!DOCTYPE html>

<html>

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
        integrity="sha256-7ZWbZUAi97rkirk4DcEp4GWDPkWpRMcNaEyXGsNXjLg=" crossorigin="anonymous">
    <title>Demo Mb PseudoForm</title>
    <style>
        .navbar-brand {
            height: 46px;
        }

        form {
            padding-top: 62px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark fm-light fixed-top">
                <div class="container justify-content-between">
                    <a class="navbar-brand p-0 d-flex align-items-center" href="#">
                        <svg id="Livello_1" class="me-2 h-100" data-name="Livello 1"
                            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 435.93 485.88">
                            <defs>
                                <style>
                                    .cls-1 {
                                        fill: #ffa300;
                                    }
                                </style>
                            </defs>
                            <path class="cls-1"
                                d="M326.24,485.88H62.16c16.51-31,33.09-62.05,49.5-93.15,3.18-6,5.9-12.32,8.52-18.63,2-4.72.79-5.5-4-6.37-5.43-1-11.21-2.22-15.83-5C90.11,356.57,83,347.24,77.77,336.58a18.48,18.48,0,0,1-2.22-7.1c-.58-16.64.2-33.4,8.3-48.2,4.3-7.86,4-13.15-1.06-20-4.74-6.46-8.26-14-6-22.48a41.74,41.74,0,0,0-2.29-28.36c-5.69-12.77-12.22-25.15-18.24-37.77-5.76-12.08-14.35-19.23-28.6-18.22-5.5.39-9.85-2.21-12.23-7.78a7.42,7.42,0,0,0-4.75-3.48c-9.59-2-13.62-9-8.37-17.22A87.73,87.73,0,0,1,18.7,106.73c17.4-15,37.89-25,59.35-32.48C123.84,58.29,169.67,42.37,216,28,258,15,301,5.12,344.9.6a111.08,111.08,0,0,1,29.76.89c10.58,1.82,14.62,11,10.79,21-1.37,3.57-1.34,6.35,1.86,8.82,3.8,2.94,3.26,6.24.36,9.45-3.24,3.58-6.31,7.39-9.94,10.54-8.56,7.41-11.13,16.68-9.36,27.47A117.26,117.26,0,0,0,370.93,91c4.46,16.06,8.94,32.11,13.68,48.09a139.08,139.08,0,0,0,6.82,18.72c2,4.43,2.34,8.2-.56,12.13-3.31,4.47-3.41,9.23-2.54,14.67,1,5.93,1.62,12.42.14,18.08-2,7.57-2.11,14,3,20.14,2.24,2.67,4.24,5.58,6.67,8.07,10.62,10.83,21.23,21.67,32.09,32.24,6,5.85,6.22,13.05,5.24,20.34-.31,2.27-2.94,4.87-5.18,6.11a112.25,112.25,0,0,1-15.06,6.6c-7.88,2.94-10.9,7.46-10.22,15.81.39,4.65,1,12.35.68,17-.3,3.83-5.07,4.51-5.88,8.32-.48,2.26,2.87.92,3.6,2.92,2.18,6,1.45,15.23-3.38,20.14a21.11,21.11,0,0,0-3.95,6.33A11,11,0,0,0,397,378c7.41,10.92,3.15,26.36-7,32.18a228.42,228.42,0,0,1-41.87,18.59c-11.09,3.67-23.19,4.34-34.87,6.09-4.12.62-6.64,2.33-6.42,6.65.29,6,1,11.89,1.29,17.84.45,9.17,3.56,16.74,11.81,21.66A63.45,63.45,0,0,1,326.24,485.88Z" />
                        </svg>
                        <span class="h3 fw-light">sistem<span class="fw-bold">interattivi</span></span>
                    </a>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                    </div>
                    <ul class="navbar-nav ms-auto mb-2 mb-md-0 justify-content-end">

                        <li class="nav-item">
                            <asp:LinkButton ID="LinkButton_gb" runat="server" ClientIDMode="Static"
                                OnClick="LinkButton_gb_Click"
                                Visible="<%# Lang == DemoMbPseudofrm.Language.Italiano %>" CssClass="nav-link">
									<img src="assets/img/gb.svg" alt="Bandiera inglese"
										style="height: 12px; vertical-align: baseline">
									ENG
                            </asp:LinkButton>
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton ID="LinkButton_it" runat="server" ClientIDMode="Static"
                                OnClick="LinkButton_gb_Click"
                                Visible="<%# Lang == DemoMbPseudofrm.Language.English %>" CssClass="nav-link">
									<img src="assets/img/it.svg" alt="Bandiera italina"
										style="height: 12px; vertical-align: baseline">
									IT
                            </asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="text-bg-secondary py-5 flex-grow-0">
                <div class="container">
                    <h1 class="display-4 d-flex justify-content-between align-items-center">
                        <span class="<%# Lang == DemoMbPseudofrm.Language.Italiano ? " d-none" : "" %>">PseudoForm
								Samples</span>
                        <span class="<%# Lang == DemoMbPseudofrm.Language.English ? " d-none" : "" %>">Esempi
								PseudoForm</span>
                        <img class="<%# Lang == DemoMbPseudofrm.Language.English ? " d-none" : "" %>"
                            src="assets/img/it.svg" style="height: 2rem;" alt="">
                        <img class="<%# Lang == DemoMbPseudofrm.Language.Italiano ? " d-none" : "" %>"
                            src="assets/img/gb.svg" style="height: 2rem;" alt="">
                    </h1>
                </div>
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col">
                        <asp:PlaceHolder ID="PlaceHolder_It" runat="server"
                            Visible="<%# Lang == DemoMbPseudofrm.Language.Italiano %>">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="sample1-tab" data-bs-toggle="tab"
                                        data-bs-target="#sample1" type="button" role="tab" aria-controls="sample1"
                                        aria-selected="true">
                                        1 - Lavora con noi</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="sample2-tab" data-bs-toggle="tab"
                                        data-bs-target="#sample2" type="button" role="tab" aria-controls="profile"
                                        aria-selected="false">
                                        2 - Prenotazione t-shirt</button>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content px-2 px-lg-5 pt-3 border border-top-0">
                                <div class="tab-pane active" id="sample1" role="tabpanel"
                                    aria-labelledby="sample1-tab" data-mb-ride="pseudo-form"
                                    data-mb-action="api/PseudoForm">
                                    <input type="hidden" name="Lingua" value="it" data-mb-detail="lang" />
                                    <input type="hidden" name="Titolo" value="Proposta di candidatura"
                                        data-mb-detail="mail-title" />
                                    <input type="hidden" name="CustomSpec" value="candidatura"
                                        data-mb-detail="customer-spec" />
                                    <h1 class="h3 text-center mt-0 mb-0">Lavora con noi</h1>
                                    <p class="mb-3 text-center">
                                        <small>Inviaci una proposta di candidatura allegando il tuo
												curriculum</small>
                                    </p>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="small mt-2" for="nome-cognome">Cognome*</label>
                                            <input type="text" name="cognome" class="form-control form-control-lg"
                                                aria-label="Cognome" placeholder="Inserisci il tuo cognome!"
                                                data-mb-detail="required">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="small mt-2" for="nome-cognome">Nome*</label>
                                            <input type="text" name="nome" class="form-control form-control-lg"
                                                aria-label="Nome" placeholder="Inserisci il tuo Nome!"
                                                data-mb-detail="required">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="small mt-2" for="e-mail">e-mail*</label>
                                            <input type="text" name="e-mail" class="form-control form-control-lg"
                                                aria-label="Indirizzo email" placeholder="Inserisci la tua e-mail!"
                                                data-mb-detail="from-mail">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="small mt-2" for="telefono">Telefono o cellulare</label>
                                            <input type="text" name="telefono" class="form-control form-control-lg"
                                                aria-label="Telefono o cellulare">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="small mt-2" for="e-mail">Data di nascita</label>
                                            <input type="date" name="born-on" class="form-control form-control-lg"
                                                aria-label="Data di nascita"
                                                placeholder="Inserisci la tua data di nascita"
                                                data-mb-detail="required">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="small mt-2" for="titolo-studio">Titolo di studio</label>
                                            <select class="form-select form-select-lg" name="titolo-studio"
                                                aria-label="Titolo di studio">
                                                <option value="Media inferiore">Media inferiore</option>
                                                <option value="Diploma di media superiore">Diploma di media
														superiore</option>
                                                <option value="Laurea">Laurea</option>
                                                <option value="Titoli post laurea">Titolo post laurea</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-auto">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sesso"
                                                    value="Maschio" aria-label="Sesso" checked>
                                                <label class="form-check-label" for="">Maschio</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sesso"
                                                    value="Femmina" aria-label="Sesso">
                                                <label class="form-check-label" for="">Femmina</label>
                                            </div>
                                        </div>
                                        <div class="col mb-3">
                                            <label class="custom-file">
                                                Allega curriculum
													(pdf max 2 Mb)
													<input type="file" name="curriculum" class="custom-file-input"
                                                        aria-label="Curriculum">
                                                <span class="custom-file-control"></span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col">
                                            <label class="small mt-2" for="messaggio">Note</label>
                                            <textarea name="messaggio" class="form-control form-control-lg"
                                                aria-label="Note" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-auto mx-auto">
                                            <button type="button" class="btn btn-outline-success mb-2"
                                                data-mb-toggle="submit">
                                                Invia la candidatura
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="sample2" role="tabpanel" aria-labelledby="sample2-tab">
                                    <div data-mb-ride="pseudo-form" data-mb-action="api/PseudoForm"
                                        id="pseudoForm2">
                                        <input type="hidden" name="Lingua" value="it" data-mb-detail="lang" />
                                        <input type="hidden" name="Titolo" value="Prenotazione T-shirt"
                                            data-mb-detail="mail-title" />
                                        <input type="hidden" name="CustomSpec" value="prenotazione"
                                            data-mb-detail="customer-spec" />
                                        <h1 class="h4 text-center mt-3 mb-0">Prenota la <a href="#" data-bs-toggle="modal"
                                            data-bs-target="#t-shirts">maglietta</a> ufficiale</h1>
                                        <p class="mb-3 text-center">
                                            <small>Potrai ritirare e pagare le t-shirt prenotate preso la segreteria
													al tuo arrivo</small>
                                        </p>
                                        <div class="row">
                                            <div class="col-sm-6 col-lg">
                                                <label class="small mt-2">Nome*</label>
                                                <input class="form-control form-control-sm" name="first_name"
                                                    type="text" maxlength="100" aria-label="Nome"
                                                    data-mb-detail="required">
                                            </div>
                                            <div class="col-sm-6 col-lg">
                                                <label class="small mt-2">Cognome*</label>
                                                <input class="form-control form-control-sm" name="last_name"
                                                    type="text" maxlength="100" aria-label="Cognome"
                                                    data-mb-detail="required">
                                            </div>
                                            <div class="col-sm-6 col-lg">
                                                <label class="small mt-2">Email*</label>
                                                <input name="email" class="form-control form-control-sm"
                                                    type="email" maxlength="128" aria-label="Indirizzo e-mail"
                                                    data-mb-detail="from-mail">
                                            </div>
                                            <div class="col-sm-6 col-lg-auto">
                                                <label class="small mt-2">Cellulare*</label>
                                                <input class="form-control form-control-sm" name="mobile"
                                                    type="text" size="15" aria-label="Cellulare"
                                                    data-mb-detail="required">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-auto">
                                                <label class="small mt-2">CAP*</label>
                                                <input class="form-control form-control-sm" name="cap" type="text"
                                                    size="5" aria-label="CAP" data-mb-detail="required">
                                            </div>
                                            <div class="col-sm">
                                                <label class="small mt-2">Indirizzo*</label>
                                                <input class="form-control form-control-sm" name="city" type="text"
                                                    maxlength="128" aria-label="Indirizzo"
                                                    data-mb-detail="required">
                                            </div>
                                            <div class="col-sm-auto">
                                                <label class="small mt-2">Provincia</label>
                                                <select class="form-select form-select-sm" name="provincia"
                                                    aria-label="Provincia" data-mb-detail="required">
                                                    <option selected="selected" value=""></option>
                                                    <option value="Agrigento">Agrigento</option>
                                                    <option value="Alessandria">Alessandria</option>
                                                    <option value="Ancona">Ancona</option>
                                                    <option value="Aosta">Aosta</option>
                                                    <option value="Arezzo">Arezzo</option>
                                                    <option value="Ascoli Piceno">Ascoli Piceno</option>
                                                    <option value="Asti">Asti</option>
                                                    <option value="Avellino">Avellino</option>
                                                    <option value="Bari">Bari</option>
                                                    <option value="Barletta-Andria-Trani">Barletta-Andria-Trani
                                                    </option>
                                                    <option value="Belluno">Belluno</option>
                                                    <option value="Benevento">Benevento</option>
                                                    <option value="Bergamo">Bergamo</option>
                                                    <option value="Biella">Biella</option>
                                                    <option value="Bologna">Bologna</option>
                                                    <option value="Bolzano">Bolzano</option>
                                                    <option value="Brescia">Brescia</option>
                                                    <option value="Brindisi">Brindisi</option>
                                                    <option value="Cagliari">Cagliari</option>
                                                    <option value="Caltanissetta">Caltanissetta</option>
                                                    <option value="Campobasso">Campobasso</option>
                                                    <option value="Caserta">Caserta</option>
                                                    <option value="Catania">Catania</option>
                                                    <option value="Catanzaro">Catanzaro</option>
                                                    <option value="Chieti">Chieti</option>
                                                    <option value="Como">Como</option>
                                                    <option value="Cosenza">Cosenza</option>
                                                    <option value="Cremona">Cremona</option>
                                                    <option value="Crotone">Crotone</option>
                                                    <option value="Cuneo">Cuneo</option>
                                                    <option value="Enna">Enna</option>
                                                    <option value="Fermo">Fermo</option>
                                                    <option value="Ferrara">Ferrara</option>
                                                    <option value="Firenze">Firenze</option>
                                                    <option value="Foggia">Foggia</option>
                                                    <option value="Forlì-Cesena">Forlì-Cesena</option>
                                                    <option value="Frosinone">Frosinone</option>
                                                    <option value="Genova">Genova</option>
                                                    <option value="Gorizia">Gorizia</option>
                                                    <option value="Grosseto">Grosseto</option>
                                                    <option value="Imperia">Imperia</option>
                                                    <option value="Isernia">Isernia</option>
                                                    <option value="L’Aquila">L’Aquila</option>
                                                    <option value="La Spezia">La Spezia</option>
                                                    <option value="Latina">Latina</option>
                                                    <option value="Lecce">Lecce</option>
                                                    <option value="Lecco">Lecco</option>
                                                    <option value="Livorno">Livorno</option>
                                                    <option value="Lodi">Lodi</option>
                                                    <option value="Lucca">Lucca</option>
                                                    <option value="Macerata">Macerata</option>
                                                    <option value="Mantova">Mantova</option>
                                                    <option value="Massa-Carrara">Massa-Carrara</option>
                                                    <option value="Matera">Matera</option>
                                                    <option value="Messina">Messina</option>
                                                    <option value="Milano">Milano</option>
                                                    <option value="Modena">Modena</option>
                                                    <option value="Monza e Brianza">Monza e Brianza</option>
                                                    <option value="Napoli">Napoli</option>
                                                    <option value="Novara">Novara</option>
                                                    <option value="Nuoro">Nuoro</option>
                                                    <option value="Ogliastra">Ogliastra</option>
                                                    <option value="Oristano">Oristano</option>
                                                    <option value="Padova">Padova</option>
                                                    <option value="Palermo">Palermo</option>
                                                    <option value="Parma">Parma</option>
                                                    <option value="Pavia">Pavia</option>
                                                    <option value="Perugia">Perugia</option>
                                                    <option value="Pesaro-Urbino">Pesaro-Urbino</option>
                                                    <option value="Pescara">Pescara</option>
                                                    <option value="Piacenza">Piacenza</option>
                                                    <option value="Pisa">Pisa</option>
                                                    <option value="Pistoia">Pistoia</option>
                                                    <option value="Pordenone">Pordenone</option>
                                                    <option value="Potenza">Potenza</option>
                                                    <option value="Prato">Prato</option>
                                                    <option value="Ragusa">Ragusa</option>
                                                    <option value="Ravenna">Ravenna</option>
                                                    <option value="Reggio Calabria">Reggio Calabria</option>
                                                    <option value="Reggio Emilia">Reggio Emilia</option>
                                                    <option value="Rieti">Rieti</option>
                                                    <option value="Rimini">Rimini</option>
                                                    <option value="Roma">Roma</option>
                                                    <option value="Rovigo">Rovigo</option>
                                                    <option value="Salerno">Salerno</option>
                                                    <option value="Sassari">Sassari</option>
                                                    <option value="Savona">Savona</option>
                                                    <option value="Siena">Siena</option>
                                                    <option value="Siracusa">Siracusa</option>
                                                    <option value="Sondrio">Sondrio</option>
                                                    <option value="Sud Sardegna">Sud Sardegna</option>
                                                    <option value="Taranto">Taranto</option>
                                                    <option value="Teramo">Teramo</option>
                                                    <option value="Terni">Terni</option>
                                                    <option value="Torino">Torino</option>
                                                    <option value="Trapani">Trapani</option>
                                                    <option value="Trento">Trento</option>
                                                    <option value="Treviso">Treviso</option>
                                                    <option value="Trieste">Trieste</option>
                                                    <option value="Udine">Udine</option>
                                                    <option value="Varese">Varese</option>
                                                    <option value="Venezia">Venezia</option>
                                                    <option value="Verbano-Cusio-Ossola">Verbano-Cusio-Ossola
                                                    </option>
                                                    <option value="Vercelli">Vercelli</option>
                                                    <option value="Verona">Verona</option>
                                                    <option value="Vibo Valentia">Vibo Valentia</option>
                                                    <option value="Vicenza">Vicenza</option>
                                                    <option value="Viterbo">Viterbo</option>
                                                </select>
                                            </div>
                                        </div>
                                        <h6 class="mb-0 mt-3">Prenotazione t-shirt modello donna</h6>
                                        <div class="row justify-content-center">
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia XS</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt XS donna"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia S</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt S donna"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia M</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt M donna"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia L</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt L donna"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia XL</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt XL donna"
                                                    value="0">
                                            </div>
                                        </div>
                                        <h6 class="mb-0 mt-3">Prenotazione t-shirt modello uomo</h6>
                                        <div class="row justify-content-center">
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia S</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt S uomo"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia M</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt M uomo"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia L</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt L uomo"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia XL</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt XL uomo"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Taglia XXL</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="Quantità t-shirt XXL uomo"
                                                    value="0">
                                            </div>
                                        </div>
                                        <div class="row justify-content-center">
                                            <div class="col">
                                                <label class="small mt-2">T-shirt totali</label>
                                                <input name="Totale" class="form-control form-control-sm required"
                                                    type="number" min="0" max="10" step="1"
                                                    aria-label="Totale t-shirt prenotate" value="0"
                                                    readonly="readonly">
                                            </div>
                                            <div class="col">
                                                <label class="small mt-2">Totale spesa</label>
                                                <input name="TotaleSpesa" class="form-control form-control-sm"
                                                    type="text" aria-label="Totale costo" value="0 €"
                                                    readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="row justify-content-center">
                                            <div class="col-auto">
                                                <div class="form-check form-switch mt-3">
                                                    <input type="checkbox" class="form-check-input" name="Privacy"
                                                        id="PrivacyprenotazioneTshirt">
                                                    <label class="form-check-label" for="PrivacyprenotazioneTshirt">
                                                        Dichiaro di avere letto <a href="#">l'informativa sulla
																privacy</a> e di approvarne il contenuto.</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row my-3">
                                            <div class="col-auto mx-auto">
                                                <button type="button" class="btn btn-outline-success mb-2"
                                                    data-mb-toggle="submit">
                                                    Prenota
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="PlaceHolder_En" runat="server"
                            Visible="<%# Lang == DemoMbPseudofrm.Language.English %>">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" id="myTab-en" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="sample1-tab-en" data-bs-toggle="tab"
                                        data-bs-target="#sample1-en" type="button" role="tab" aria-controls="sample1"
                                        aria-selected="true">
                                        1 - Work with us</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="sample2-tab-en" data-bs-toggle="tab"
                                        data-bs-target="#sample2-en" type="button" role="tab" aria-controls="profile"
                                        aria-selected="false">
                                        2 - T-shirt booking</button>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content px-2 px-lg-5 pt-3 border border-top-0">
                                <div class="tab-pane active" id="sample1-en" role="tabpanel"
                                    aria-labelledby="sample1-tab" data-mb-ride="pseudo-form"
                                    data-mb-action="api/PseudoForm">
                                    <input type="hidden" name="Lingua" value="en" data-mb-detail="lang" />
                                    <input type="hidden" name="Titolo" value="Application proposal"
                                        data-mb-detail="mail-title" />
                                    <input type="hidden" name="CustomSpec" value="candidatura"
                                        data-mb-detail="customer-spec" />
                                    <h1 class="h3 text-center mt-0 mb-0">Work with us</h1>
                                    <p class="mb-3 text-center">
                                        <small>Send us an application proposal</small>
                                    </p>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="small mt-2" for="nome-cognome">Surname*</label>
                                            <input type="text" name="cognome" class="form-control form-control-lg"
                                                aria-label="Surname" placeholder="Enter your surname!"
                                                data-mb-detail="required">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="small mt-2" for="nome-cognome">First Name*</label>
                                            <input type="text" name="nome" class="form-control form-control-lg"
                                                aria-label="First Name" placeholder="Insert your name!"
                                                data-mb-detail="required">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="small mt-2" for="e-mail">E-mail address*</label>
                                            <input type="text" name="e-mail" class="form-control form-control-lg"
                                                aria-label="E-mail address" placeholder="Insert your email address!"
                                                data-mb-detail="from-mail">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="small mt-2" for="telefono">Phone or mobile phone</label>
                                            <input type="text" name="telefono" class="form-control form-control-lg"
                                                aria-label="Phone or mobile phone">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="small mt-2" for="e-mail">Date of birth*</label>
                                            <input type="date" name="born-on" class="form-control form-control-lg"
                                                aria-label="Date of birth"
                                                placeholder="Insert your date of birth"
                                                data-mb-detail="required">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="small mt-2" for="titolo-studio">Degrees/Diplomas</label>
                                            <select class="form-select form-select-lg" name="titolo-studio"
                                                aria-label="Degrees/Diplomas">
                                                <option value="Certificate of Junior High School">Certificate of Junior High School</option>
                                                <option value="High School certificate">High School certificate</option>
                                                <option value="College degree">College degree</option>
                                                <option value=" Post Graduate Diploma">Post Graduate Diploma</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-auto">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sesso"
                                                    value="Male" aria-label="Gender" checked>
                                                <label class="form-check-label" for="">Male</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sesso"
                                                    value="Female" aria-label="Gender">
                                                <label class="form-check-label" for="">Female</label>
                                            </div>
                                        </div>
                                        <div class="col mb-3">
                                            <label class="custom-file">
                                                Attach your curriculum
													(pdf max 2 Mb)
													<input type="file" name="curriculum" class="custom-file-input"
                                                        aria-label="Curriculum">
                                                <span class="custom-file-control"></span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col">
                                            <label class="small mt-2" for="messaggio">Notes</label>
                                            <textarea name="messaggio" class="form-control form-control-lg"
                                                aria-label="Notes" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-auto mx-auto">
                                            <button type="button" class="btn btn-outline-success mb-2"
                                                data-mb-toggle="submit">
                                                Send the proposal
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="sample2-en" role="tabpanel" aria-labelledby="sample2-tab">
                                    <div data-mb-ride="pseudo-form" data-mb-action="api/PseudoForm"
                                        id="pseudoForm2-en">
                                        <input type="hidden" name="Lingua" value="en" data-mb-detail="lang" />
                                        <input type="hidden" name="Titolo" value="T-shirt Booking"
                                            data-mb-detail="mail-title" />
                                        <input type="hidden" name="CustomSpec" value="prenotazione"
                                            data-mb-detail="customer-spec" />
                                        <h1 class="h4 text-center mt-3 mb-0">Book the official<a href="#" data-bs-toggle="modal"
                                            data-bs-target="#t-shirts">T-shirt</a> </h1>
                                        <p class="mb-3 text-center">
                                            <small>You can collect and pay the t-shirts booked at the customer desk
													upon your arrival</small>
                                        </p>
                                        <div class="row">
                                            <div class="col-sm-6 col-lg">
                                                <label class="small mt-2">First Name*</label>
                                                <input class="form-control form-control-sm" name="first_name"
                                                    type="text" maxlength="100" aria-label="First Name"
                                                    data-mb-detail="required">
                                            </div>
                                            <div class="col-sm-6 col-lg">
                                                <label class="small mt-2">Last Name*</label>
                                                <input class="form-control form-control-sm" name="last_name"
                                                    type="text" maxlength="100" aria-label="Last Name"
                                                    data-mb-detail="required">
                                            </div>
                                            <div class="col-sm-6 col-lg">
                                                <label class="small mt-2">Email*</label>
                                                <input name="email" class="form-control form-control-sm"
                                                    type="email" maxlength="128" aria-label="E-mail address"
                                                    data-mb-detail="from-mail">
                                            </div>
                                            <div class="col-sm-6 col-lg-auto">
                                                <label class="small mt-2">Cell phone*</label>
                                                <input class="form-control form-control-sm" name="mobile"
                                                    type="text" size="15" aria-label="Cell phone"
                                                    data-mb-detail="required">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-auto">
                                                <label class="small mt-2">CAP*</label>
                                                <input class="form-control form-control-sm" name="cap" type="text"
                                                    size="5" aria-label="CAP" data-mb-detail="required">
                                            </div>
                                            <div class="col-sm">
                                                <label class="small mt-2">Address*</label>
                                                <input class="form-control form-control-sm" name="city" type="text"
                                                    maxlength="128" aria-label="Address"
                                                    data-mb-detail="required">
                                            </div>
                                            <div class="col-sm-auto">
                                                <label class="small mt-2">Provincia</label>
                                                <select class="form-select form-select-sm" name="provincia"
                                                    aria-label="Provincia" data-mb-detail="required">
                                                    <option selected="selected" value=""></option>
                                                    <option value="Agrigento">Agrigento</option>
                                                    <option value="Alessandria">Alessandria</option>
                                                    <option value="Ancona">Ancona</option>
                                                    <option value="Aosta">Aosta</option>
                                                    <option value="Arezzo">Arezzo</option>
                                                    <option value="Ascoli Piceno">Ascoli Piceno</option>
                                                    <option value="Asti">Asti</option>
                                                    <option value="Avellino">Avellino</option>
                                                    <option value="Bari">Bari</option>
                                                    <option value="Barletta-Andria-Trani">Barletta-Andria-Trani
                                                    </option>
                                                    <option value="Belluno">Belluno</option>
                                                    <option value="Benevento">Benevento</option>
                                                    <option value="Bergamo">Bergamo</option>
                                                    <option value="Biella">Biella</option>
                                                    <option value="Bologna">Bologna</option>
                                                    <option value="Bolzano">Bolzano</option>
                                                    <option value="Brescia">Brescia</option>
                                                    <option value="Brindisi">Brindisi</option>
                                                    <option value="Cagliari">Cagliari</option>
                                                    <option value="Caltanissetta">Caltanissetta</option>
                                                    <option value="Campobasso">Campobasso</option>
                                                    <option value="Caserta">Caserta</option>
                                                    <option value="Catania">Catania</option>
                                                    <option value="Catanzaro">Catanzaro</option>
                                                    <option value="Chieti">Chieti</option>
                                                    <option value="Como">Como</option>
                                                    <option value="Cosenza">Cosenza</option>
                                                    <option value="Cremona">Cremona</option>
                                                    <option value="Crotone">Crotone</option>
                                                    <option value="Cuneo">Cuneo</option>
                                                    <option value="Enna">Enna</option>
                                                    <option value="Fermo">Fermo</option>
                                                    <option value="Ferrara">Ferrara</option>
                                                    <option value="Firenze">Firenze</option>
                                                    <option value="Foggia">Foggia</option>
                                                    <option value="Forlì-Cesena">Forlì-Cesena</option>
                                                    <option value="Frosinone">Frosinone</option>
                                                    <option value="Genova">Genova</option>
                                                    <option value="Gorizia">Gorizia</option>
                                                    <option value="Grosseto">Grosseto</option>
                                                    <option value="Imperia">Imperia</option>
                                                    <option value="Isernia">Isernia</option>
                                                    <option value="L’Aquila">L’Aquila</option>
                                                    <option value="La Spezia">La Spezia</option>
                                                    <option value="Latina">Latina</option>
                                                    <option value="Lecce">Lecce</option>
                                                    <option value="Lecco">Lecco</option>
                                                    <option value="Livorno">Livorno</option>
                                                    <option value="Lodi">Lodi</option>
                                                    <option value="Lucca">Lucca</option>
                                                    <option value="Macerata">Macerata</option>
                                                    <option value="Mantova">Mantova</option>
                                                    <option value="Massa-Carrara">Massa-Carrara</option>
                                                    <option value="Matera">Matera</option>
                                                    <option value="Messina">Messina</option>
                                                    <option value="Milano">Milano</option>
                                                    <option value="Modena">Modena</option>
                                                    <option value="Monza e Brianza">Monza e Brianza</option>
                                                    <option value="Napoli">Napoli</option>
                                                    <option value="Novara">Novara</option>
                                                    <option value="Nuoro">Nuoro</option>
                                                    <option value="Ogliastra">Ogliastra</option>
                                                    <option value="Oristano">Oristano</option>
                                                    <option value="Padova">Padova</option>
                                                    <option value="Palermo">Palermo</option>
                                                    <option value="Parma">Parma</option>
                                                    <option value="Pavia">Pavia</option>
                                                    <option value="Perugia">Perugia</option>
                                                    <option value="Pesaro-Urbino">Pesaro-Urbino</option>
                                                    <option value="Pescara">Pescara</option>
                                                    <option value="Piacenza">Piacenza</option>
                                                    <option value="Pisa">Pisa</option>
                                                    <option value="Pistoia">Pistoia</option>
                                                    <option value="Pordenone">Pordenone</option>
                                                    <option value="Potenza">Potenza</option>
                                                    <option value="Prato">Prato</option>
                                                    <option value="Ragusa">Ragusa</option>
                                                    <option value="Ravenna">Ravenna</option>
                                                    <option value="Reggio Calabria">Reggio Calabria</option>
                                                    <option value="Reggio Emilia">Reggio Emilia</option>
                                                    <option value="Rieti">Rieti</option>
                                                    <option value="Rimini">Rimini</option>
                                                    <option value="Roma">Roma</option>
                                                    <option value="Rovigo">Rovigo</option>
                                                    <option value="Salerno">Salerno</option>
                                                    <option value="Sassari">Sassari</option>
                                                    <option value="Savona">Savona</option>
                                                    <option value="Siena">Siena</option>
                                                    <option value="Siracusa">Siracusa</option>
                                                    <option value="Sondrio">Sondrio</option>
                                                    <option value="Sud Sardegna">Sud Sardegna</option>
                                                    <option value="Taranto">Taranto</option>
                                                    <option value="Teramo">Teramo</option>
                                                    <option value="Terni">Terni</option>
                                                    <option value="Torino">Torino</option>
                                                    <option value="Trapani">Trapani</option>
                                                    <option value="Trento">Trento</option>
                                                    <option value="Treviso">Treviso</option>
                                                    <option value="Trieste">Trieste</option>
                                                    <option value="Udine">Udine</option>
                                                    <option value="Varese">Varese</option>
                                                    <option value="Venezia">Venezia</option>
                                                    <option value="Verbano-Cusio-Ossola">Verbano-Cusio-Ossola
                                                    </option>
                                                    <option value="Vercelli">Vercelli</option>
                                                    <option value="Verona">Verona</option>
                                                    <option value="Vibo Valentia">Vibo Valentia</option>
                                                    <option value="Vicenza">Vicenza</option>
                                                    <option value="Viterbo">Viterbo</option>
                                                </select>
                                            </div>
                                        </div>
                                        <h6 class="mb-0 mt-3">Reservation T-shirt Woman</h6>
                                        <div class="row justify-content-center">
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size xs</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity XS Woman"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size S</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity S Woman"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size M</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity M Woman"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size L</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity L Woman"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size XL</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity XL Woman"
                                                    value="0">
                                            </div>
                                        </div>
                                        <h6 class="mb-0 mt-3">Reservation T-shirt Men</h6>
                                        <div class="row justify-content-center">
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size s</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity S men"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size M</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity M men"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size L</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity L men"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size XL</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity XL men"
                                                    value="0">
                                            </div>
                                            <div class="col-6 col-md">
                                                <label class="small mt-2">Size XXL</label>
                                                <input class="form-control form-control-sm booked" type="number"
                                                    min="0" max="10" step="1" aria-label="T-shirt quantity XXL men"
                                                    value="0">
                                            </div>
                                        </div>
                                        <div class="row justify-content-center">
                                            <div class="col">
                                                <label class="small mt-2">Total t-shirt</label>
                                                <input name="Totale" class="form-control form-control-sm required"
                                                    type="number" min="0" max="10" step="1"
                                                    aria-label="Total booked t-shirts" value="0"
                                                    readonly="readonly">
                                            </div>
                                            <div class="col">
                                                <label class="small mt-2">Total cost</label>
                                                <input name="TotaleSpesa" class="form-control form-control-sm"
                                                    type="text" aria-label="Total cost" value="0 €"
                                                    readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="row justify-content-center">
                                            <div class="col-auto">
                                                <div class="form-check form-switch mt-3">
                                                    <input type="checkbox" class="form-check-input" name="Privacy"
                                                        id="PrivacyprenotazioneTshirt-en">
                                                    <label class="form-check-label"
                                                        for="PrivacyprenotazioneTshirt-en">
                                                        I declare that I have read <a href="#">the information on
																privacy </a>and to approve the content.</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row my-3">
                                            <div class="col-auto mx-auto">
                                                <button type="button" class="btn btn-outline-success mb-2"
                                                    data-mb-toggle="submit">
                                                    Send reservation
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal T-shirt -->
        <div class="modal fade" id="t-shirts" tabindex="-1" role="dialog" aria-labelledby="modalTitleId"
            aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="modal-title" id="modalTitleId">SNE official T-shirt</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body pb-5">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col">
                                    <img src="assets/img/frmmina-fronte.jpg" alt="t-shirt female" class="img-fluid">
                                </div>
                                <div class="col">
                                    <img src="assets/img/femmina-retro.jpg" alt="t-shirt female" class="img-fluid">
                                </div>
                                <div class="col">
                                    <img src="assets/img/maschio-fronte.jpg" alt="t-shirt male" class="img-fluid">
                                </div>
                                <div class="col">
                                    <img src="assets/img/maschio-retro.jpg" alt="t-shirt male" class="img-fluid">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha256-wMCQIK229gKxbUg3QWa544ypI4OoFlC2qQl8Q8xD8x8=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@magicbruno/swalstrap5@1.0.8/dist/js/swalstrap5_all.min.js"
        integrity="sha256-kzBJaIS7T0+BxR6rprDQHi7SvW2lwytbftf1EFhk7FA=" crossorigin="anonymous"></script>
    <script src="assets/js/MB_PseudoForm.js"></script>
    <script>

        // Pseudoforms containers
        const pseudoForm1 = document.getElementById("sample1");
        const pseudoForm2 = document.getElementById("pseudoForm2");
        const pseudoForm1_en = document.getElementById("sample1-en");
        const pseudoForm2_en = document.getElementById("pseudoForm2-en");

        // Update sums in booking t-shirts pseudoform
        const updateValues = (event) => {
            const target = event.target;
            const changed = event.detail;
            if (changed.type == 'number') {
                const bookings = target.querySelectorAll('.booked');
                let total = 0;
                bookings.forEach(element => {
                    const n = parseInt(element.value) || 0;
                    total += n;
                })
                target.querySelector('[name="Totale"]').value = total;
                target.querySelector('[name="TotaleSpesa"]').value = (total * 10) + ' €';
            }
        }

        // Response on submitting data
        const onSubmitted = (event) => {
            const result = event.detail;
            if (result.Success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Ok!',
                    text: 'E mail spedita con successo.'
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Errore!',
                    text: result.Message
                });
            }
        }

        const onSubmitted_en = (event) => {
            const result = event.detail;
            if (result.Success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Ok!',
                    text: 'E-mail sended succesfully.'
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: result.Message
                });
            }
        }

        // Validate data
        if (pseudoForm1) {
            pseudoForm1.addEventListener('validate.mb.pseudoform', event => {
                const values = event.detail;
                if (!values.getValue('e-mail')) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Errore!',
                        text: 'È necessario inserire un indirizzo e-mail!'
                    });
                } else {
                    let attachment = values.item(values.indexOf('curriculum'));
                    if (attachment) {
                        let len = attachment.Value.length;
                        if (len > (2 * 1024 * 1024)) {
                            event.preventDefault();
                            Swal.fire({
                                icon: 'error',
                                title: 'Errore!',
                                text: 'Il file allegato devessere inferiore a 2 Mb !'
                            });
                        } else if (len) {
                            let temp = attachment.Value.split(',');
                            if (temp[0].indexOf('pdf') == -1) {
                                event.preventDefault();
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Errore!',
                                    text: 'È consentito inviare solo pdf!'
                                });
                            }
                        }
                    }
                }
            });
            pseudoForm1.addEventListener('submitted.mb.pseudoform', onSubmitted);
        }

        if (pseudoForm1_en) {
            pseudoForm1_en.addEventListener('validate.mb.pseudoform', event => {
                const values = event.detail;
                if (!values.getValue('e-mail')) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'You need to enter an e-mail address!'
                    });
                } else {
                    let attachment = values.item(values.indexOf('curriculum'));
                    if (attachment) {
                        let len = attachment.Value.length;
                        if (len > (2 * 1024 * 1024)) {
                            event.preventDefault();
                            Swal.fire({
                                icon: 'error',
                                title: 'Error!',
                                text: 'The attached file must be less than 2 MB!'
                            });
                        } else if (len) {
                            let temp = attachment.Value.split(',');
                            if (temp[0].indexOf('pdf') == -1) {
                                event.preventDefault();
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error!',
                                    text: 'Only pdf files are allowed!'
                                });
                            }
                        }
                    }
                }
            });
            pseudoForm1_en.addEventListener('submitted.mb.pseudoform', onSubmitted_en);
        }

        if (pseudoForm2) {
            pseudoForm2.addEventListener('validate.mb.pseudoform', event => {
                const values = event.detail;
                let check1 = values.getValue('Privacy');
                let check2 = parseInt(values.getValue('Totale')) || 0;
                if (check1 !== true) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Errore!',
                        text: 'È necessario leggere ed approvare esplicitamente l\'informativa sulla privacy!'
                    });
                } else if (check2 == 0) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Errore!',
                        text: 'Devi prenotare al meno una t-shirt!'
                    });
                }
            });
            pseudoForm2.addEventListener('change.mb.pseudoform', updateValues);
            pseudoForm2.addEventListener('submitted.mb.pseudoform', onSubmitted);
        }

        if (pseudoForm2_en) {
            pseudoForm2_en.addEventListener('validate.mb.pseudoform', event => {
                const values = event.detail;
                let check1 = values.getValue('Privacy');
                let check2 = parseInt(values.getValue('Totale')) || 0;
                if (check1 !== true) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'It is necessary to explicitly read and approve the privacy policy!'
                    });
                } else if (check2 == 0) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'You have to book a t-shirt at least!'
                    });
                }
            });
            pseudoForm2_en.addEventListener('change.mb.pseudoform', updateValues);
            pseudoForm2_en.addEventListener('submitted.mb.pseudoform', onSubmitted_en);
        }

    </script>
</body>

</html>
