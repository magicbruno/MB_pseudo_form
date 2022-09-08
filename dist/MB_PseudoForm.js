/*=====================================
 * MB_PseudoForm 1.0.0
 * 
 * (c) 2022 - Bruno Migliaretti
 ======================================*/

(function (win, doc) {
    "use strict";
    /**
     * class ValuesList
     * Store a list of MB_PseudoFormValue in its list property
     * Offer some methods to handle this list
     */
    class ValuesList {
        constructor() {
            this.list = [];
        };
        list = [];

        // Returns the length of the list
        get length() {
            return this.list.length;
        }

        // Returns item i of the list
        item(i) {
            return this.list[i];
        }

        // Add a MB_PseudoFormValue to the list passing values
        // If exists an item in the list with provided Name, the item is overwritten with new values
        add(name, value, type = '', label = '', detail = '') {
            let i = this.indexOf(name);
            if (i == -1)
                this.list.push({ Name: name, Value: value, Type: type, Label: label, Detail: detail });
            else
                this.list[i] = { Name: name, Value: value, Type: type, Label: label, Detail: detail };
            return (i === -1);
        }

        // Add a MB_PseudoFormValue to the list passing the object
        // If exists an item in the list with provided Name, the item is overwritten 
        push(element) {
            let i = this.indexOf(element.name);
            if (i == -1)
                this.list.push(element);
            else
                this.list[i] = element;
            return this.length;
        }

        // Removes the item with the provided Name
        remove(name) {
            let i = this.indexOf(name);
            if (i > -1) {
                this.list.splice(i, 1);
            };
            return (i > -1);
        }

        // Returns the index of the item with provided Name, -1 if no item is found
        indexOf(name) {
            for (var i = 0; i < this.list.length; i++) {
                let entry = this.list[i];
                if (entry.Name === name)
                    return i;
            }
            return -1;
        }

        // Returns the Value of the item with provided Name, null if no item is found 
        getValue(name) {
            let i = this.indexOf(name);
            if (i > -1)
                return this.list[i].Value;
            return null;
        }

        // Clears the list
        clear() {
            this.list.splice(0, this.list.length);
        }
    }

    /**
     * class MB_PseudoFormValue
     * Wraps elements (input, select, textarea) of e pseudo form into MB_PseudoFormValue object
     * 
     */
    class MB_PseudoFormValue {
        constructor(name, value, type, label, detail) {
            this.initValues(name, value, type, label, detail);
        }
        // element "name" attribute (id id name is not provided)
        Name = '';
        // element "value" property 
        Value = null;
        // element "type" attribute
        Type = '';
        // element "aria-label" attribute (name if aria-label is not provided)
        Label = '';
        // element custom data-mb-detail attribute
        Detail = '';

        // Create object from values
        initValues(name, value, type = '', label = '', detail = '') {
            this.Name = name;
            this.Value = value;
            this.Type = type;
            this.Label = label;
            this.Detail = detail;
        }
        /**
         * Async static method that create an object from the html element
         * @param {*} element HTML element
         * @returns Promise resolving a MB_PseudoFormValue object
         */
        static createAsync(element) {
            let name = element.name || element.id;
            let type = element.type || '';
            let tagName = element.tagName;
            let label = element.ariaLabel || name;
            let value = null;
            let detail = '';

            if (element.files)
                if (element.files.length > 0)
                    detail = element.files[0].name;
            if (type != 'file')
                detail = element.dataset.mbDetail || '';

            return new Promise((resolve, reject) => {
                try {
                    if (tagName == 'select' || tagName == 'textarea') {
                        value = element.value;
                        // Multiple select  is not supported
                        if (type == 'select-multiple')
                            console.warn('Multiple selections are not supported! Only first selection will be processed.')
                        resolve(new MB_PseudoFormValue(name, value, type, label, detail));
                    } else {
                        switch (type) {
                            // If a file is selected Value property contains DataUrlBase64 encoded file content
                            case 'file':
                                if (element.files) {
                                    // Multiple file is not supported
                                    if (element.files.length > 1)
                                        console.warn('Multiple files input is not supported! Only first file selected will be processed.');
                                    if(element.files.length > 0) {
                                        let file = element.files[0];
                                        const reader = new FileReader();
                                        reader.onloadend = () => {
                                            let value = reader.result;
                                            resolve(new MB_PseudoFormValue(name, value, type, label, detail));
                                        }; 
                                        reader.readAsDataURL(file);                                        
                                    } else {
                                        resolve(new MB_PseudoFormValue(name, value, type, label, detail));
                                    }
                                }
                                break;
                            case 'radio':
                                if (element.checked)
                                    value = element.value;
                                    resolve(new MB_PseudoFormValue(name, value, type, label, detail));
                                break;
                            case 'checkbox':
                                // For checkboxes Value contains true if checked, false if unchecked
                                value = element.checked;
                                resolve(new MB_PseudoFormValue(name, value, type, label, detail));
                                break;
                            // Ignored types
                            case 'submit':
                            case 'button':
                            case 'image':
                            case 'reset':
                                resolve(new MB_PseudoFormValue(name, null, type, label, detail));
                                break;
                            // all other types
                            default:
                                value = element.value;
                                resolve(new MB_PseudoFormValue(name, value, type, label, detail));
                                break;
                        }
                        
                    }
                } catch (error) {
                    reject(error);
                }
            })
        }
    }

    /**
     * class MB_PseudoForm
     * Main class
     */
    class MB_PseudoForm {
        constructor(selector, settings) {
            this.init(selector, settings);
        };
        // Pseudo form container
        form = null;
        // Submit button
        _submit = null;
        // Some Value is changed
        pendingChanges = false;
        // Submit controller
        endPoint = '';
        // ValuesList object
        values = null;

        // List of elements
        get inputs () {
            return this.form.querySelectorAll('input, select, textarea');
        }

        // Alias 
        get pseudoForm() {
            return this.form;
        }

        get submit() {
            return this._submit;
        }

        /**
         * Init Pseudo Form
         * @param {*} selector Selector (string) or DOM element
         */
        init(selector) {
            const self = this;
            
            // Pseudo Form
            if (typeof selector === 'string')
                this.form = doc.querySelector(selector);
            else if (typeof selector === 'object' && selector.tagName)
                this.form = selector;
            else
                throw 'MB_PseudoForm error: You must provide a selector or a HTML element as parameter!';
            // Submit button
            this._submit = this.form.querySelector('[data-mb-toggle="submit"]');
            if (!this.submit)
                throw 'MB_PseudoForm error: You must include a submit button (an element with data-mb-toggle="submit")!';

            this.submit.addEventListener('click', () => {
                self.submitData();
            });

            // Init ValuesList values
            this.values = new ValuesList();
            // Request Controller
            this.endPoint = this.form.dataset.mbAction;

            // Create change event
            this.inputs.forEach(element => {
                element.addEventListener('change', event => {
                    self.pendingChanges = true;
                    let customChangeEvt = new CustomEvent('change.mb.pseudoform', { detail: event.target });
                    self.form.dispatchEvent(customChangeEvt);
                })
            })
        }

        // Submit values list to server
        submitData() {
            const self = this;
            this.collectData().then(values => {
                // Cancelable validate event. Yuo can cancel operation before submit
                let validateEvent = new CustomEvent('validate.mb.pseudoform', { cancelable: true, detail: values });

                if (this.form.dispatchEvent(validateEvent)) {
                    var myHeaders = new Headers();
                    myHeaders.append("Content-Type", "application/json");

                    // Values are sended in JSON format in the body of the request
                    var raw = JSON.stringify(values.list);

                    var requestOptions = {
                        method: 'POST',
                        headers: myHeaders,
                        body: raw,
                        redirect: 'follow'
                    };
                    // A submitted.mb.pseudoform custom event is dispatched whether the request 
                    // is successful whether an error occurs
                    fetch(this.endPoint, requestOptions)
                        .then(response => response.json())
                        .then(result => {
                            let eventSubmitted = new CustomEvent('submitted.mb.pseudoform', { detail: result });
                            self.form.dispatchEvent(eventSubmitted);
                            self.pendingChanges = false;
                        })
                        .catch(error => {
                            let eventSubmitted = new CustomEvent('submitted.mb.pseudoform', {
                                detail: {
                                    Success: false,
                                    Message: error,
                                    Exitcode: -1,
                                    Data: null
                                }
                            });
                            self.form.dispatchEvent(eventSubmitted);
                        });
                }
            }).catch(error => console.error(error));


        }

        // Asynchronously collect data and returns a Promise
        collectData() {
            this.values.clear();
            const self = this;
            return new Promise((resolve, reject) => {
                this._collect().then(inputValues => {
                    inputValues.forEach(ival => {
                        if(ival.Value !== null)
                            self.values.push(ival);
                    });
                    resolve(self.values);
                }).catch(error => reject(error));  
            })      
        }

        // Helper for collectData. 
        _collect() {
            const promises = [];
            this.inputs.forEach(input => {
                promises.push(MB_PseudoFormValue.createAsync(input));
            });
            return new Promise((resolve, reject) => {
                Promise.all(promises).then(values => resolve(values)).catch(error => reject(error));
            })
        }
    }

    win.MB_PseudoForm = MB_PseudoForm;

    win.pseudoForms = [];
    doc.addEventListener('DOMContentLoaded', () => {
        const myForms = doc.querySelectorAll('[data-mb-ride="pseudo-form"]');
        myForms.forEach(element => {
            try {
                win.pseudoForms.push(new MB_PseudoForm(element));
            } catch (error) {
                console.error(`Can't create MB_PseudoForm: ${error}`);
            }
        });
    })

})(window, document);