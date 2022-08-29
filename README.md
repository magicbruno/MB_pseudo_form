# Interceptor
Interceptor  provides a way to asynchronously observe when a target elements intersect (enter or exit from) the document's viewport.

Intersection information is needed for many reasons, such as:

- Lazy-loading of images or other content as a page is scrolled.
- Implementing "infinite scrolling" web sites, where more and more content is loaded and rendered as you scroll, so that the user doesn't have to flip through pages.
- Reporting of visibility of advertisements in order to calculate ad revenues.
- Deciding whether or not to perform tasks or animation processes based on whether or not the user will see the result.

Interceptor, to  achieve its purpose, use [Intersection Observer API](https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API) supported by all modern browsers (see [caniuse.com](https://caniuse.com/?search=intersectionObserver)).

In case Intersection Observer isn't available, interceptor will handle *observed elements* like they was always visible in the viewport.

## Getting started
You can load Interceptor directly by CDN
```
<script src="https://cdn.jsdelivr.net/npm/@magicbruno/interceptor@1.0.0/dist/interceptor.min.js" 
    integrity="sha256-u42Lk+YdUFJOJeCx7ihJsbyI9uEUE9cTDjleJKlMc4k=" 
    crossorigin="anonymous"></script>
```
or install it with npm 
```
npm install @magicbruno/interceptor@1.0.0
```
or clone the repository from GitHub: 
```
git clone https://github.com/magicbruno/Interceptor.git
```
or [download the zip archive](https://github.com/magicbruno/Interceptor/archive/refs/heads/main.zip).

## How it Works
First you must create an instance of Interceptor that will perform the task of *observing* one or more elements and associating an action with them.
```
const interceptor = new Interceptor();
```
Target elements must have the attribute `data-interceptor="name"` where *name* is an arbitrary *interceptor name* that you must assign. Elements with the same *interceptor name* will share the same action.

To add an element or a group of elements to the interceptor watch list, you must apply the `Interceptor.observe()` method to the created instance
```
interceptor.observe(name, action);
```
where *name* is the value assigned to data-interceptor attribute and action may be a `string` or a `function` and will be performed every time there will be a change in target element intersection with the document viewport.

If action is a `string` it will be interpreted as the name of class that will be toggled on element visibility (added to the target element when it is in viewport and removed when it is offscreen).

If action is a `function` it will be called with two parameter: the target element itself and the intersection ratio that is the percentage of target element visible in the viewport as a number between 0.0 (not in viewport) e 1.0 (entirely in viewport).

In this example Interceptor is used to start animation of every *skill bar* when become visible in the viewport. See full example [here](demo.html):
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
All elements with `data-interceptor="skill"` are added to the watch list. When the action is called if the element is entirely in the document viewport (ratio === 1) the bar width is animated to percentage obtained from data-percentage attribute, if it is offscreen (ratio === 0) the bar width is set to 0.

Instead of repeatedly invoking the `Interceptor.observe` method you can achieve the same result by calling the constructor with an array of objects as the first parameter. Every object in the array will have two properties `name` and `action` corresponding to `Interceptor.observe` method parameters.

### Thresholds
Rather than reporting every infinitesimal change in how much a target element is visible, the Intersection Observer API uses thresholds. 

For default Interceptor use as thresholds [0,1.0] that is changes are reported only when the target element is entirely inside the viewport and when it is entirely offscreen.

When you create an Interceptor, you can provide, as second  parameter, your own thresholds. Then, the API reports changes to visibility which cross these thresholds.

For example, if you want to be informed every time a target's visibility passes backward or forward through each 25% mark, you would specify the array [0, 0.25, 0.5, 0.75, 1] as the list of thresholds when creating the interceptor.

> #### Warning
> If you *observe* an element that is exactly as tall as the viewport or whose height is auto and so may be higher then viewport height, you could never receive a ratio of 1, because a part of the element itself will be always offscreen.

### rootMargin
rootMargin is a string which specifies a set of offsets to add to the root's bounding_box when calculating intersections, effectively shrinking or growing the root for calculation purposes. The syntax is approximately the same as that for the CSS margin property.

When you create an interceptor, you can pass a rootMargin as the third parameter. 

The default is "0px 0px 0px 0px".

# References
## Constructor
### Interceptor()
#### Syntax
```
new Interceptor(); 
new Interceptor(watchList);
new Interceptor(watchList, threshold);
new Interceptor(watchList, threshold, rootMargin);
```
The Interceptor() constructor creates and returns a new Interceptor object.

If watchList is specified, all elements groups defined by the name property of all objects in the array will be watched and will be associated with corresponding actions, if not it is defaulted to [].

The threshold, if specified, are checked to ensure that they're all in the range 0.0 and 1.0 inclusive, and the threshold list is sorted in ascending numeric order. If the threshold list is empty, it's set to the array [0.0,1.0].

The rootMargin, if specified, is checked to ensure it's syntactically correct. If not specified, or an empty string, the default is 0px 0px 0px 0px.
#### Parameters
|Parameter|Type|Description|
|---|---|---|
|`watchList`|`Array of objects`|Objects have two properties: `name`, `action`|
|`threshold`|`Array of number`|An array of numbers between 0.0 and 1.0, specifying a ratio of intersection area to total viewport for the observed target. A value of 0.0 means that even a single visible pixel counts as the target being visible. 1.0 means that the entire target element is visible|
|`rootMargin`|`string`|A string which specifies a set of offsets to add to the root's bounding_box when calculating intersections, effectively shrinking or growing the root for calculation purposes. The syntax is approximately the same as that for the CSS margin property. The default is "0px 0px 0px 0px".|
#### watchList object properties

|Property|Type|Description|
|---|---|---|
|`name`|`string`|Identify all elements with attribute data-interceptor=*name*|
|`action`|`string` or `function`|If `string` it will be interpreted as the name of class that will be toggled on element visibility (added to the target element when it is in viewport and removed when it is offscreen). If action is a `function` it will be called with two parameter: the target element itself and the intersection ratio that is the percentage of target element visible in the viewport as a number between 0.0 (not in viewport) e 1.0 (entirely in viewport).|

## Methods
### Interceptor.observe()
#### Syntax
```
observe(name, action);
```
The Interceptor method observe() adds an element group to the set of target elements being watched by the Interceptor. One interceptor has one set of thresholds, but can watch multiple target elements for visibility changes in keeping with those.
#### Parameters

|Parameter|Type|Description|
|---|---|---|
|`name`|`string`|Add all element with attribute data-interceptor=*name* to the set of target elements|
|`action`|`string` or `function`|Associated an action to element group identified wit `name`. If `string` it will be interpreted as the name of class that will be toggled on element visibility (added to the target element when it is in viewport and removed when it is offscreen). If action is a `function` it will be called with two parameter: the target element itself and the intersection ratio that is the percentage of target element visible in the viewport as a number between 0.0 (not in viewport) e 1.0 (entirely in viewport).|

### Interceptor.unobserve()
#### Syntax
```
unobserve(name);
```
The Interceptor method unobserve() instructs the Interceptor to stop observing the specified target element group.
#### Parameters

|Parameter|Type|Description|
|---|---|---|
|`name`|`string`|Remove all elements with attribute data-interceptor=*name* from the set of target elements|

### Interceptor.disconnect()
#### Syntax
```
disconnect(name);
```
The Interceptor method disconnect() stops watching all of its target elements for visibility changes.

