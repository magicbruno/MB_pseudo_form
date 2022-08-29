# Interceptor
Interceptor consente di *osservare* in modo asincrono quando un elemento HTML interseca (entra o esce da) la *viewport* del documento.

Interceptor può essere utile in molti casi:

- Quando si voglio caricare le immagini solo quando lo scroll della pagina le fa apparire nella viewport (*lazy loading*).
- Quando si vuole implementare in un sito Web il cosiddetto *Infinite Scrolling*, in cui ulteriori contenuti vengono caricati quando l'utente scrollando arriva in fondo alla pagina.
- Quando si vuole controllare il reale numero di visualizzazione dei banner pubblicitari.
- Quando si vogliono fare partire determinati processi (come, ad esempio, un animazione) quando l'elemento coinvolto entra nella viewport .

Interceptor, per raggiungere il suo scopo, utilizza [Intersection Observer API](https://developer.mozilla.org/en-us/docs/web/api/intersection_observer_api) supportato da tutti i browser moderni (vedi [Caniuse.com](https://caniuse.com/?Search=IntersectionObserver)).

Nel caso in cui IntersectionObserver non sia disponibile, Interceptor gestirà gli *elementi osservati* come se fossero sempre visibili nella viewport.

## Getting started
È possibile caricare interceptor direttamente da CDN
```
<script src="https://cdn.jsdelivr.net/npm/@magicbruno/interceptor@1.0.0/dist/interceptor.min.js" 
    integrity="sha256-u42Lk+YdUFJOJeCx7ihJsbyI9uEUE9cTDjleJKlMc4k=" 
    crossorigin="anonymous"></script>
```
o installalo con NPM 
```
npm install @magicbruno/interceptor@1.0.0
```
o clonare il repository da Github: 
```
git clone https://github.com/magicbruno/Interceptor.git
```
o [scaricare l'archivio zip](https://github.com/magicbruno/Interceptor/archive/refs/heads/main.zip).

## Come funziona
Innanzitutto bisogna creare un'istanza di Interceptor che eseguirà il compito di *osservare* uno o più elementi e associare un'azione al fatto che entrino od escano dalla viewport.
```
const interceptor = new Interceptor();
```
Gli elementi target devono avere l'attributo `data-interceptor="nome"` dove *nome* è *un nome Interceptor* arbitrario che devi assegnare a tuo piacimento. Gli elementi con lo stesso *nome Interceptor* condivideranno la stessa azione.

Per aggiungere un elemento o un gruppo di elementi alla lista di controllo Interceptor, è necessario applicare il metodo `Interceptor.observe ()` all'istanza creata
```
interceptor.observe(nome, azione);
```
Laddove *nome* è il valore assegnato all'attributo `data-interceptor` e azione può essere una *stringa* o una *funzione* e verrà eseguita ogni volta che ci sarà una modifica dell'intersezione dell'elemento target con la viewport del documento.

Se l'azione è una *stringa* verrà interpretata come il nome di una classe che verrà attivata a secondo della visibilità dell'elemento (aggiunto all'elemento target quando è nella viewport e rimossa quando è offscreen).

Se l'azione è una `funzione` verrà chiamata con due parametri: il primo è l'elemento osservato, il secondo, il cosiddetto interception ratio, è un numero tra 0.0 e 1.0 che indica quale percentuale dell'elemento è visibile nella viewport.

In questo esempio, Interceptor viene utilizzato per far partire l'animazione di ogni *skill bar* quando diventa visibile nella viewport. Vedi l'esempio completo [qui](demo.html):
```
interceptor.observe('skill', (target, ratio) => {
      let percent = target.dataset.percent;
      if (ratio === 0) {
        target.style.setProperty('--bar-width', '0');
      } else if (ratio === 1) {
        target.style.setProperty('--bar-width', percent);
      }
    }
});
```
Tutti gli elementi con `data-interceptor="skill"` vengono aggiunti alla lista di controllo. Quando l'azione viene chiamata, se l'elemento è interamente nella viewport del documento (ratio === 1) la larghezza della barra è animata fino alla percentuale ottenuta dall'attributo `data-percentage`, se è offscreen (rapporto === 0) la larghezza della barra è impostata su 0.

Invece di invocare ripetutamente il metodo `interceptor.observe` puoi ottenere lo stesso risultato chiamando il `constructor` con una matrice di oggetti come primo parametro. Ogni oggetto nell'array avrà due proprietà `name` e `action` corrispondenti ai parametri del metodo `interceptor.observe`.

### Thresholds (soglie)
Invece che segnalare ogni cambiamento infinitesimale di quanto un elemento target è visibile nella viewport, the Intersection Observer API usa delle *soglie* (thresholds). Solo quando la percentuale visibile dell'elemento raggiunge queste soglie il cambiamento viene segnalato. 

Le soglie predefinite di Interceptor sono 0 e 1.0 (rappresentate nell'array [0,1.0]), cioè le modifiche sono riportate solo quando l'elemento target è interamente all'interno del punto di vista (1.0) e quando è interamente fuori dallo schermo (0.0).

Quando crei un interceptor, puoi fornire, come secondo parametro, le tue soglie. L'API riporterà le modifiche di visibilità secondo queste soglie.

Ad esempio, se desideri che Interceptor segnali l'entrata e l'uscita degli oggetti dalla viewport ogni 25% (oggetto non visibile, visibile per un quarto, visibile a metà, ecc.), devi specificare  l'array [0, 0.25, 0.5, 0.75, 1] come elenco di soglie (threshold) quando crei l'interceptor.

> #### Attenzione
> Se *osservi* un elemento che è esattamente alto quanto la viewport o la cui altezza è `auto` e quindi potrebbe essere più alta dell'altezza del vista, potresti non ricevere mai un `ratio` di 1, perché una parte dell'elemento stesso sarà sempre fuori dallo schermo.

### rootMargin
`rootMargin` è una stringa che specifica i margini da aggiungere alla viewport durante il calcolo delle intersezioni, riducendo o allargando i bordi della viewport. La sintassi è approssimativamente uguale a quella per la proprietà del margine CSS.

Quando si crea un intercettore, è possibile passare un rootmargin come terzo parametro.

La rootMargin predefinita è "0px 0px 0px 0px".

# Guida di riferimento
## Constructor
### Interceptor()
#### Sintassi
```
new Interceptor(); 
new Interceptor(watchList);
new Interceptor(watchList, threshold);
new Interceptor(watchList, threshold, rootMargin);
```
Il costruttore Interceptor() crea e restituisce un nuovo oggetto Interceptor.

Se `watchList` viene specificato, tutti i gruppi di elementi definiti dalla proprietà `name` di tutti gli oggetti nell'array saranno *osservati* e saranno associati alle `action` corrispondenti. Per default watchList è [], cioè gli elementi da *osservare* verranno definiti successivamente.

`threshold`, se impostato, deve essere un array di valori tra 0,0 e 1.0 inclusi. L'elenco delle soglia viene ordinato in ordine crescente. Se l'elenco di soglia è vuoto, è impostato sul array [0.0,1.0].

Il rootMargin, se specificato, deve essere sintatticamente corretto. Il valore predefinito è `'0px 0px 0px 0px'`.
#### Parameters
|Parametro|Tipo|Descrizione|
|---|---|---|
|`watchList`|`Array of objects`|Gli oggetti hanno due proprietà: `name`, `action`|
|`threshold`|`Array of number`|Un array di numeri tra 0.0 e 1.0, che specificano il rapporto tra area di intersezione visibile e quella totale dell'elemento osservato. Un valore di 0,0 significa l'oggetto viene considerato visibile se anche un solo pixel è visibile. 1.0 significa che l'intero elemento target è visibile|
|`rootMargin`|`string`|Una stringa che specifica i margini da aggiungere alla viewport durante il calcolo delle intersezioni, riducendo o crescendo l'are su cui avviene il calcolo. La sintassi è approssimativamente uguale a quella per la proprietà `margin` in CSS. L'impostazione predefinita è `"0px 0px 0px 0px"`.|
#### watchList object properties

|Proprietà|Tipo|Descrizione|
|---|---|---|
|`name`|`string`|Identifica tutti gli elementi con l'attributo data-interceptor=*name*|
|`action`|`string` or `function`|Se `String` verrà interpretato come il nome della classe che verrà impostata secondo la visibilità degli elementi (aggiunta all'elemento target quando visibile e rimossa quando offscreen). Se l'azione è una `funzione` verrà richiamata con due parametri: il primo è l'elemento osservato, il secondo, il cosiddetto interception ratio, è un numero tra 0.0 e 1.0 che indica quale percentuale dell'elemento è visibile nella viewport.|

## Metodi
### Interceptor.observe()
#### Sintassi
```
observe(name, action);
```
Il metodo Interceptor.observe() aggiunge un gruppo di elementi all'insieme di elementi target osservati dall'oggetto interceptor. Un interceptor ha una unica serie di threshold, ma può monitorare più elementi target.

#### Parametri

|Parametro|Tipo|Descrizione|
|---|---|---|
|`name`|`string`|Aggiungi tutto l'elemento con attributo data-interceptor=*name* all'insieme degli elementi monitorati|
|`action`|`string` or `function`|Associated an action to element group identified wit `name`. If `string` it will be interpreted as the name of class that will be toggled on element visibility (added to the target element when it is in viewport and removed when it is offscreen). Se `String` verrà interpretato come il nome della classe che verrà impostata secondo la visibilità degli elementi (aggiunta all'elemento target quando visibile e rimossa quando offscreen). Se l'azione è una `funzione` verrà richiamata con due parametri: il primo è l'elemento osservato, il secondo, il cosiddetto interception ratio, è un numero tra 0.0 e 1.0 che indica quale percentuale dell'elemento è visibile nella viewport.|

### Interceptor.unobserve()
#### Syntax
```
unobserve(name);
```
Il metodo Interceptor.unobserve() indica all'interceptor di smettere di *osservare* il gruppo di elementi specificato.
#### Parameters

|Parametro|Tipo|Descrizione|
|---|---|---|
|`name`|`string`|Rimuovi tutti gli elementi con attributo data-interceptor=*name* dall'insieme di elementi target osservati|

### Interceptor.disconnect()
#### Syntax
```
disconnect(name);
```
Il metodo Interceptor.disconnect() smette di *osservare* l'insieme degli elementi target monitorati dal interceptor.

