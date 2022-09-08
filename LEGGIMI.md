# MB_PseudoForm
MB_PseudoForm consente di organizzare degli elementi input, select e textarea compilabili dall'utente in un contenitore (tipicamente un elemento div) e di inviare dati inseriti dall'utente ad un server per l'elaborazione utilizzando un "Ajax Request". 

MB_PseudoForm può essere utile:

- In tutte le situazioni in cui desidero inviare l'input dell'utente al server senza scaricare la pagina.
- In particolare se voglio creare dei moduli di immissione in applicazioni .net di tipo WebForm senza utilizzare il form principale (vedi l'esempio nella cartella demo)

MB_PseudoForm invia i dati sotto forma di lista di oggetti. Questo consente di costruire lato server handlers generici, indipendenti dalla struttura del modulo di input da elaborare. Ad esempio, il demo allegato è una applicazione WebForm dove un API controller trasforma un qualsiasi gruppo di dati compilati dall'utente in una email formattata che viene inviata allo staff del sito.

## Getting started
È possibile caricare MB_PseudoForm direttamente da CDN
```
<script src="https://cdn.jsdelivr.net/npm/@magicbruno/mb_pseudoform@1.0.0/dist/MB_PseudoForm.min.js"></script>
```
o installato con NPM 
```
npm install @magicbruno/mb_pseudoform@1.0.0
```
o clonare il repository da Github: 
```
git clone https://github.com/magicbruno/MB_PseudoForm.git
```

## Come funziona
Uno pseudo form è un elemento HTML (per esempio un elemento div) che contiene degli elementi `input`, `select` e `textarea` e almeno un elemento cliccabile (`<button>` o `<a>`) che ha la funzione di inviare i dati.

Condizioni minime perché un elemento HTML diventi uno pseudo form  sono:
- Che sia definito l'*handler* destinato a ricevere i dati lato server utilizzando l'attributo `data-mb-action` da applicare all'elemento stesso
- Che l'elemento contenga un *submit button* definito assegnando ad un elemento `<button>` o a un elemento `<a>` l'attributo `data-mb-toggle="submit"`.


```
<div id="sample1-en" data-mb-action="api/PseudoForm">
  <!-- Campi di input -->
  <button type="button" data-mb-toggle="submit">Invia dati</button>
</div>
```
### Attivazione

Si può attivare lo pseudo form via Javascript (`pForm` può essere indifferentemente un selettore CSS o un elemento HTML)
```
const myPseudoForm = new MB_PseudoForm(pForm) ;
```
o semplicemente assegnando all'elemento l'attributo `data-mb-ride="pseudo-form"`.

```
<div id="sample1-en" data-mb-action="api/PseudoForm" data-mb-ride="pseudo-form">
  <!-- Campi di input -->
  <button type="button" data-mb-toggle="submit">Invia dati</button>
</div>
```
## Proprietà e metodi

Può essere utile illustrare alcune caratteristiche base del funzionamento dello pseudo form. Per maggiori dettagli consigliamo di esaminare direttamente il codice che è scritto in modo molto chiaro e ampiamente commentato.

MB_PseudoForm si basa sul funzionamento di tre classi Javascript:
- `MB_PseudoForm`, la classe principale
- `MB_PseudoFormValue` che definisce l'oggetto in cui vengono trasformati i campi compilati dell'utente per l'invio al server
- `ValuesList` che fornisce alcuni metodi per gestire una lista di `MB_PseudoFormValue` 

### MB_PseudoFormValue
MB_PseudoFormValue espone 5 proprietà che riflettono caratteristiche e valore dei campi compilati dall'utente.

|Proprietà|Tipo|Descrizione|
|---|---|---|
|`Name`|`string`|Riflette il contenuto dell'attributo `name` dell'elemento. Nel caso l'attributo `name` non sia presente, viene usato l'`id` dell'elemento.|
|`Type`|`string`|Riflette il contenuto della proprietà `type` dell'elemento.|
|`Value`|`any`|Se l'elemento è una `checkbox` è `true` se selezionata, altrimenti `false`. Se l'elemento è un `input` di tipo `file` restituisce il contenuto del file codificato come DataUrlBase64. Negli altri casi riflette il contenuto della proprietà `value` dell'elemento.|
|`Label`|`string`|Riflette il contenuto dell'attributo `aria-label` dell'elemento. Nel caso l'attributo `aria-label` non sia presente restituisce lo stesso valore di `Name`|
|`Detail`|`string`|Se l'elemento è un `input` di tipo `file` restituisce in nome originale del file. Negli altri casi può essere usata per passare al server informazioni aggiuntive su quel campo (vedi demo)|

I campi che compongono lo pseudo form sono trasformati in oggetti MB_PseudoFormValue utilizzando il metodo statico asincrono `MB_PseudoFormValue.createAsync` che restituisce una Promise che si risolve con l'oggetto creato. 

### ValuesList
Il valore restituito dal metodo  `MB_PseudoForm.collectData` (vedi sotto), che raccoglie i campi compilati dall'utente come lista di oggetti `MB_PseudoFormValue` è un'istanza della classe `ValueList`.

La classe `ValueList` espone una sola proprietà, `length`, che restituisce la lunghezza della lista e offre alcuni metodi che aiutano a gestirla.

|Metodo|Tipo restituito|Descrizione|
|---|---|---|
|`item(i)`|`MB_PseudoFormValue`|**Parametro**: *i* `number`. Restituisce l'oggetto `MB_PseudoFormValue` con indice *i*|
|`push(obj)`|`number`|**Parametro**: *obj* `MB_PseudoFormValue`. Aggiunge un oggetto `MB_PseudoFormValue` alla lista. Se esiste già un'oggetto che lo stesso `Name`, l'oggetto presente viene sostituito da quello inserito. Restituisce la nuova lunghezza della lista|
|`remove(name)`|`boolean`|**Parametro**: *name* `string`. Rimuove dalla lista l'oggetto con `Name` = *name*. Restituisce `true` se l'oggetto è stato rimosso `false` se non è stato trovato nella lista|
|`indexOf(name)`|`number`|**Parametro**: *name* `string`. Cerca dalla lista l'oggetto con `Name` = *name*. Ne restituisce l'indice se l'oggetto è stato trovato altrimenti `-1`.|
|`getValue(name)`|`any`|**Parametro**: *name* `string`. Cerca dalla lista l'oggetto con `Name` = *name* e restituisce il suo `Value`.|
|`clear()`|nessuno|Svuota la lista|

### MB_PseudoForm
In generale non dovrebbe essere necessario accedere direttamente alle proprietà e ai metodi di MB_PseudoForm. L'interfaccia con lo pseudo form è garantita dagli eventi (`change.mb.pseudoform`, `validate.mb.pseudoform` e `submitted.mb.pseudoform`) che vengono emessi nei momenti chiave del processo.  

#### **Proprietà**
|Proprietà|Tipo|Descrizione|
|---|---|---|
|`pseudoForm`|`HTML element`|Proprietà a sola lettura. Restituisce l'elemento HTML su cui è stato costruito lo pseudo form|
|`submit`|`HTML element`|Proprietà a sola lettura. Restituisce l'elemento HTML che viene usato come *submit button*|
|`inputs`|`static NodeList`|Proprietà a sola lettura. Restituisce la lista degli elementi (`input`, `select` e `textarea`) che fanno parte dello pseudo form in formato [static NodeList](https://developer.mozilla.org/en-US/docs/Web/API/NodeList)|
|`pendingChanges`|`boolean`|Restituisce `true` se almeno un elemento di input è stato modificato. Viene automaticamente resettata quando i dati vengono inviati. Può essere resettata (impostata a `false`) anche programmaticamente.|

#### **Metodi**
|Metodo|Tipo restituito|Descrizione|
|---|---|---|
|`collectData`|`Promise`|Metodo asincrono. La Promise restituita si risolve con l'elenco dei valori immessi dall'utente sotto forma di `ValueList`. |
|`submitData`|nessuno|Consente di inviare programmaticamente lo pseudo form al server. Emette un evento `validate.mb.pseudoform` (cancellabile) subito prima dell'invio e un evento `submitted.mb.pseudoform` subito dopo aver ricevuto la risposta dal server.|

#### **Eventi**
Tutti gli eventi sono inviati all'elemento HTML su cui viene costruito lo pseudo form. Per gestirli, quindi, basta aggiungere un gestore di eventi  all'elemento stesso:

```
<div id="sample1-en" data-mb-action="api/PseudoForm" data-mb-ride="pseudo-form">
  <!-- Campi di input -->
  <button type="button" data-mb-toggle="submit">Invia dati</button>
</div>
....
<script>
  const myForm = document.getElementById("sample1-en");
  myForm.addEventListener('validate.mb.pseudoform', event => {
    const values = event.detail;
    // .......
  })
</script>
```
|Evento|Descrizione|
|---|---|
|`change.mb.pseudoform`|Viene emesso ogni volta che un campo dello pseudo form viene modificato. La proprietà `detail` dell'evento contiene l'elemento HTML il cui valore è stato modificato. |
|`validate.mb.pseudoform`|Viene emesso subito prima che i dati vengano mandati al server. La proprietà `detail` dell'evento contiene la `ValueList` che sta per essere inviata. Consente di validare i dati prima dell'invio. Per estrarre informazione su campi specifici si possono applicare alla lista i metodi della classe `ValueList`. Se si applica il metodo `preventDefault` all'evento, l'invio viene cancellato.|
|`submitted.mb.pseudoform`|Viene emesso dopo che i dati vengano inviati e o si riceve la risposta dal server, o si verifica un errore. Nel caso di risposta dal server, la proprietà dell'evento detail contiene la risposta, in caso di errore contiene un oggetto con quattro proprietà `Success` (`boolean`, impostata su `false`), `Message` (`string`, contiene il messaggio di errore), `Exitcode` e `Data` attualmente non usate. (vedi demo).|

## Demo
Nella cartella demo del progetto troverete una semplice applicazione web ASP.NET che dimostra come utilizzare MB_PseudoForm congiuntamente a un API Controller per generare, partendo da un MB_PseudoForm, una mail formattata con le informazione inserite dall'utente e inviata allo staff del sito, e una mail di ringraziamento inviata all'utente stesso.

### Utilizzare il demo
Clona il repository git sul tuo computer
```
git clone https://github.com/magicbruno/MB_PseudoForm.git
```
oppure [scaricalo](https://github.com/magicbruno/MB_pseudo_form/archive/refs/heads/main.zip).

Apri `/demo/demo.sln` in Visual Studio.

Prima di eseguire l'applicazione devi configurare il server smtp che il controller utilizzerà per inviare i messaggi email generati.

Apri nell'editor di **Visual Studio** `Web.config` e nella sezione `appSettings` inserisci i dati:
```
	<appSettings>
    <!-- Inserisci url del server -->
		<add key="SmtpServer" value="..."/>
    <!-- Inserisci credenziali di accesso -->
		<add key="SmtpUsername" value="..."/>
		<add key="SmtpPassword" value="..."/>
    <!-- Modifica le impostazioni ssl se necessario -->
		<add key="SmtpPort" value="25"/>
		<add key="SmtpUseSSL" value="false"/>
    <!-- Mittente dei messaggi inviati dal server -->
		<add key="DefaultSmtpFromMail" value="..."/>
    <!-- Casella di posta dello staff -->
		<add key="MailTo" value="..."/>
	</appSettings>
```
Quindi lancia l'applicazione in Iis Express premendo <kbd>f5</kbd> o <kbd>ctrl</kbd> + <kbd>f5</kbd>.

> ## Nota
> Per usare l'api controller `/ApiControllers/PseudoFormController.cs` in un tuo progetto devi installare il pacchetto [Microsoft.AspNet.WebApi](https://www.nuget.org/packages/Microsoft.AspNet.WebApi) e aggiungere al progetto anche le classi `/ApiControllers/ApiControllerResponse.cs` e` /ApiControllers/PseudoFormModel.cs`. Maggiori informazioni su ASP.NET Web API [qui](https://docs.microsoft.com/it-it/aspnet/web-api/).

