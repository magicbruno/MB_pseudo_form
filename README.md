# MB_PseudoForm
Mb_PseudoForm allows you to organize `input`, `select` and `textarea` elements in a container (typically a DIV element) and to send data entered by the user to a server using an "Ajax Request".

Mb_PseudForm can be useful:

- in all situations when you want to send the user's input to the server without unloading the page.
- in particular if you want to create entry modules in a WebForm ASP.NET application without using the Asp form (see the example in the demo folder)

`Mb_PseudForm` sends data in the form as a list of objects. This allows you to build generic handlers server side, independent of the structure of the input module to elaborate. 

The attached demo is a WebForm ASP.NET application where an API Controller transforms any group of data entered by the user into a formatted email that is sent to the site staff.

## Getting started
`MB_PseudoForm` can be loaded directly from CDN,
```
<script src="https://cdn.jsdelivr.net/npm/@magicbruno/mb_pseudoform@1.0.0/dist/MB_PseudoForm.min.js"></script>
```
installed via NPM,
```
npm install @magicbruno/mb_pseudoform@1.0.0
```
or you can clone the GitHub repository: 
```
git clone https://github.com/magicbruno/MB_PseudoForm.git
```

## How does it work
A pseudo form is an HTML element (for example a `div` element) that contains `input`, `select` and `textarea` elements and at least one clickable element (`<Button>` or `<a>`) which will submit the data.

Minimum conditions because an HTML element becomes a pseudo form are:
- that the handler intended to receive data server-side is defined using the `data-mb-action` attribute to be applied to the element itself
- that the element contains a * Submit Button * defined by assigning to an element `<Button>` or to an element `<a>` the attribute `data-mb-toggle="submit `.


```
<div id="sample1-en" data-mb-action="api/PseudoForm">
  <!-- Input fields -->
  <button type="button" data-mb-toggle="submit">Invia dati</button>
</div>
```
### Initialization

You can activate the pseudo form via javascript (`pform` can be a CSS selector or an HTML element)
```
const myPseudoForm = new MB_PseudoForm(pForm) ;
```
or simply by assigning the attribute `data-mb-ride="pseudo-form"` to the element.

```
<div id="sample1-en" data-mb-action="api/PseudoForm" data-mb-ride="pseudo-form">
  <!-- Input fields -->
  <button type="button" data-mb-toggle="submit">Invia dati</button>
</div>
```
## Properties and methods

It could be useful to illustrate how the pseudo form works. For more details, we recommend examining the code directly. It's clear and fully commented.

MB_PseudoForm is based on three Javascript classes:
- `MB_PseudoForm`, the main class
- `MB_PseudoFormValue` which defines the object in which the user's entered fields are transformed for sending the server
- `ValuesList` which provides some methods to manage a list of `MB_PseudoFormValue` 

### MB_PseudoFormValue
MB_PseudoFormValue provides 5 properties that reflect the characteristics and value of the fields compiled by the user.

|Property | Type | Description |
|---|---|---|
|`Name`|`string`|Reflects the content of the attribute `name` of the element. If the `name` attribute is not present, the `id` attribute will be used.|
|`Type`|`string`|Reflects the content of the property `type`  of the element.|
|`Value`|`any`|If the element is a `checkbox`, it's' `true` if selected, otherwise `false`. If the element is an input of type `file`, `Value` is the content of the file coded as DataUrlBase64. In other cases it reflects the content of the property `value` of the element.|
|`Label`|`string`|Reflects the content of the attribute `aria-label` of the element. If the attribute is not present it returns the same value that `Name`|
|`Detail`|`string`|If the element is an input of type `file`, it returns  the original file name. In other cases it can be used to transfer to the server additional information on that field (see demo)|

The the pseudo form fields are transformed into MB_PseudoFormValue objects using the asynchronous static method `MB_Pseudoformvalue.CreateAsync` which returns a `Promise` that resolves with the created object. 

### ValuesList
The value returned by the `MB_PseudoForm.collectData` method (see below), which collects the fields compiled by the user as a list of `MB_PseudoFormValue` objects is an instance of the `ValueList` class.

The `ValueList` class exposes only one property, `length` (which returns the length of the list) and offers some methods that help to manage it.

| Method | Type returned | Description |
|---|---|---|
|`item(i)`|`MB_PseudoFormValue`|**Parameter**: *i* `number`. Returns the  `MB_PseudoFormValue` object with index *i*|
|`push(obj)`|`number`|**Parameter**: *obj* `MB_PseudoFormValue`. Add a `MB_PseudoFormValue` object to the list. If there is already an object with the same `Name`, the present object is replaced by the one inserted. Returns the new length of the list.|
|`remove(name)`|`boolean`|**Parameter**: *name* `string`. Removes the object with `Name` = *name* from the list. It returns `true` if the object has been removed `false` if it has not been found on the list.|
|`indexOf(name)`|`number`|**Parameter**: *name* `string`. Search the list with the object with `Name` = *name*. If object is found, it returns its index otherwise `-1`.|
|`getValue(name)`|`any`|**Parameter**: *name* `string`. Search the list with the object with `Name` = *name*. If found, returns it's `Value`, otherwise `null`.|
|`clear()`|`none`|Clear the list|

### MB_PseudoForm
>In general, it should not be necessary to directly access the properties and methods of `MB_PseudoForm`. The interface with the pseudo form is guaranteed by the events (`change.mb.pseudoform`, `validate.mb.pseudoform` e `submitted.mb.pseudoform`) which are dispatched in the key moments of the process.  

#### **Properties**
| Property | Type | Description |
|---|---|---|
|`pseudoForm`|`HTML element`|Readonly property. Returns the HTML element on which the pseudo form was built.|
|`submit`|`HTML element`|Readonly property. Returns the HTML element that is used as *Submit Button*|
|`inputs`|`static NodeList`|Readonly property. Returns the list of elements (`input`, `select` e `textarea`) which are part of the pseudo form as a [static NodeList](https://developer.mozilla.org/en-US/docs/Web/API/NodeList).|
|`pendingChanges`|`boolean`|It returns `true` if at least one input element has been changed. It is automatically reset when the data is sent to the server. It can be reset (set to `false`) also programmatically.|

#### **Methods**
| Method | Type returned | Description |
|---|---|---|
|`collectData`|`Promise`|Asynchronous method. The Promise returned resolves the list of values entered by the user as a `ValueList`. |
|`submitData`|none|It allows you to programmatically send the pseudo form to the server. It dispatches a  `validate.mb.pseudoform` event (cancelable) immediately before sending data and a `submitted.mb.pseudoform` event immediately after receiving the response from the server.|

#### **Events**
All events are sent to the HTML element on which the pseudo form is built. To manage them, therefore, just add an event listener to the element itself:

```
<div id="sample1-en" data-mb-action="api/PseudoForm" data-mb-ride="pseudo-form">
  <!-- Input fields -->
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
| Event | Description |
|---|---|
|`change.mb.pseudoform`|It is dispatched every time a pseudo form field is modified. The `detail` property of the event contains the HTML element whose `value` has been modified. |
|`validate.mb.pseudoform`|It is dispatched immediately before the data is sent to the server.The detail property of the event contains the `ValueList` which is about to be sent. It allows you to validate the data before sending. To extract information on specific fields, the `ValueList` class methods can be applied to the list. To cancel sending process, apply the `preventDefault` method to the event|
|`submitted.mb.pseudoform`|It is issued after the data is sent and either you have received the response from the server, or an error occurs. In the case of response from the server, the `detail` event property contains the response, in case of error contains an object with four properties: `Success` (`Boolean`, set to `false`), `Message` (`string`, contains the error message), `Exitcode` and `Data` currently not used (see demo for live example).|

## Demo
In the demo folder of the project you will find a simple ASP.NET Web Application that shows how to use `MB_PseudoForm` together with an API controller to generate, starting from a `MB_PseudoForm`, a formatted email with the information inserted by the user to send to the site staff and a thanksgiving email sent to the user himself.

### Using the demo
Clone the GIT repository on your computer
```
git clone https://github.com/magicbruno/MB_PseudoForm.git
```
or [download it](https://github.com/magicbruno/MB_pseudo_form/archive/refs/heads/main.zip).

Open `/demo/demo.sln` in Visual Studio.

Before running the application you must configure the SMTP server that the controller will use to send the generated email messages.

Open `Web.config` in **Visual Studio** editor and in the `appSettings` section enter the data:
```
	<appSettings>
    <!-- Enter URL of the smtp server -->
		<add key="SmtpServer" value="..."/>
    <!-- Insert smtp credentials -->
		<add key="SmtpUsername" value="..."/>
		<add key="SmtpPassword" value="..."/>
    <!-- Change the SSL settings if necessary -->
		<add key="SmtpPort" value="25"/>
		<add key="SmtpUseSSL" value="false"/>
    <!-- Sender of the messages sent by the server -->
		<add key="DefaultSmtpFromMail" value="..."/>
    <!-- Staff mailbox -->
		<add key="MailTo" value="..."/>
	</appSettings>
```
Then launch the application in Iis Express by pressing <kbd>f5</kbd> o <kbd>ctrl</kbd> + <kbd>f5</kbd>.

> ## Note
> To use the API controller `/ApiControllers/PseudoFormController.cs` in your project you could have to install the package [Microsoft.AspNet.WebApi](https://www.nuget.org/packages/Microsoft.AspNet.WebApi). You must also add the classes `/ApiControllers/ApiControllerResponse.cs` and `/ApiControllers/PseudoFormModel.cs` to the project. More information about ASP.NET Web Api [here](https://docs.microsoft.com/it-it/aspnet/web-api/).

