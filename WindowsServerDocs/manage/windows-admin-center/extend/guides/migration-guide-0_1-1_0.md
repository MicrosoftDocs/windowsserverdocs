---
title: Migrate from Windows Admin Center SDK 0.1 to 1.0
description: This guide will help you migrate from Windows Admin Center SDK version 0.1 to 1.0
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 02/26/2019
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Migrate from Windows Admin Center SDK 0.1 to 1.0

>Applies To: Windows Admin Center Preview

This guide will help you migrate from Windows Admin Center SDK version 0.1 to 1.0.  

## 1. Learn about new controls with the Dev Guide extension

Windows Admin Center version 1902 and later includes the **Dev Guide** extension, which you can use to find examples of controls (including newly available controls) and scenarios to help you build your own extension.  Dev Guide replaces the **Developer Tools** extension from earlier versions of the SDK.

### Use the Dev Guide in Windows Admin Center

Dev Guide is available as a solution in Windows Admin Center version 1902 and later.  Dev Guide is pre-installed, but it needs to be enabled via settings.

**Enable Dev Guide in Windows Admin Center:**

* Open Windows Admin Center (version 1902 and later)
* Click on the **Settings** icon in the top right corner of the window
* Select the **Advanced** tab
* Under *Experiment Keys*, click **Add**
* Enter a new value ```msft.sme.shell.devguide``` in the empty field that was created by the previous step
* Click **Save and Reload**

**Open Dev Guide in Windows Admin Center:**

* Open Windows Admin Center (version 1902 and later)
* Click the drop-down in the top left to show all solution types
* Select the **Dev Guide** solution 
    * If you don't see the solution listed, make sure you have enabled the dev guide (see section above) and have reloaded Windows Admin Center.
* Browse the content of Dev Guide by selecting one of the tabs
    * **Landing:** Contains code samples for *Manage As* and *Notification* scenarios
    * **Controls:** Contains examples of each available control in the SDK
    * **Pipes:** Contains examples of available converter and formatter functions
    * **Styles:** Contains examples of CSS styles available in the SDK
    * **MsftSme:** Contains examples and guidance for advanced scenarios 

### Browse the source code of Dev Guide on GitHub

You can browse the [source code](https://github.com/Microsoft/windows-admin-center-sdk/) of Dev Guide on GitHub to find example HTML, CSS, and TypeScript code samples.

## 2. Prepare your development environment for the latest SDK

Install or update node.js version [10.15.1 LTS or later](https://nodejs.org/en/).

Update the Windows Admin Center CLI to the latest version:

[//]: # "npm uninstall -g windows-admin-center-cli@next"

``` cmd
npm uninstall -g windows-admin-center-cli
npm install -g windows-admin-center-cli
```

Update your global dependencies to these versions:

``` cmd
npm install npm@6.4.1 -g
npm install @angular/cli@7.1.2 -g
npm install gulp -g
npm install typescript@3.1.6 -g
npm install tslint@5.11.0 -g
```

## 3. Create a new project with the latest SDK

Use the Windows Admin Center CLI to create a new project targeting the ```next``` version (SDK 1.0):

[//]: # "wac create --company 'Contoso Inc' --tool 'Manage Foo Works' --version experimental"

``` cmd
wac create --company "Contoso Inc" --tool "Manage Foo Works" --version next
```

Next, change directory into the folder just created, then install required local dependencies by running ```npm install ```.

## 4. Modify an existing project to use the latest SDK

IMPORTANT: Make a backup of your project before continuing.

Modify the following line in ```package.json``` to target the ```next``` version (SDK 1.0):

[//]: # "'@microsoft/windows-admin-center-sdk': 'experimental'"

``` json
"@microsoft/windows-admin-center-sdk": "next",
```

Then run ```npm install``` to update references throughout your project.

## 5. Use the SDK CLI to fix common migration issues

IMPORTANT: Make a backup of your project before continuing.

From the root folder of your project, run the following CLI command on your project to fix common migration issues automatically:

``` cmd
wac updateSeven --update
```

This CLI command addresses the following issues automatically:

* Regenerate ```package-lock.json```
* Update files in the angular compilation environment:
    - ```.gitignore```
    - ```tslint.json```
    - ```tsconfig.json```
    - ```tsconfig.inline.json```
    - ```ng-package.json```
    - ```angular.json```
    - ```src\tsconfig.app.json```
    - ```src\tsconfig.lib.json```
    - ```src\tsconfig.spec.json```

## 6. Use the SDK CLI to understand common migration issues

From the root folder of your project, run the following CLI command to audit your project and find common migration issues that need to be addressed manually:

``` cmd
wac updateSeven --audit
```

This will find instances of the following issues in your project:

### Replace usage of the following CSS classes with these sme classes:

| Old CSS class | New CSS class |
| -- | -- |
| .auto-flex-size |  .sme-position-flex-auto |
| .border-all |  .sme-border-inset-sm AND .sme-border-color-base-90 |
| .border-bottom |  .sme-border-bottom-sm AND .sme-border-bottom-color-base-90 |
| .border-horizontal |  .sme-border-horizontal-sm AND .sme-border-horizontal-color-base-90 |
| .border-left |  .sme-border-left-sm AND .sme-border-left-color-base-90 |
| .border-right |  .sme-border-right-sm AND .sme-border-right-color-base-90 |
| .border-top |  .sme-border-top-sm AND .sme-border-top-color-base-90 |
| .border-vertical |  .sme-border-vertical-sm AND .sme-border-vertical-color-base-90 |
| .break-word |  .sme-arrange-ws-wrap |
| .btn |  .sme-button OR button |
| .btn-primary |  .sme-button.sme-button-primary OR .button.sme-button-primary |
| .color-dark |  .sme-color-alt |
| .color-light |  .sme-color-base |
| .color-light-gray |  .sme-color-base-90 |
| .fixed-flex-size |  .sme-position-flex-none |
| .flex-layout |  .sme-arrange-stack-h OR .sme-arrange-stack-v |
| .font-bold |  .sme-font-emphasis1 |
| .highlight |  .sme-background-color-yellow |
| .horizontal |  .sme-arrange-stack-h |
| .no-scroll |  .sme-position-flex-auto |
| .nowrap |  .sme-arrange-stack-h OR .sme-arrange-stack-v |
| .relative |  .sme-layout-relative |
| .relative-center |  .sme-layout-absolute .sme-position-center |
| .reverse |  .sme-arrange-stack-reversed |
| .stretch-absolute |  .sme-layout-absolute .sme-position-inset-none |
| .stretch-fixed |  .sme-layout-fixed .sme-position-inset-none |
| .stretch-vertical |  .sme-position-stretch-v |
| .stretch-width |  .sme-position-stretch-h |
| .vertical |  .sme-arrange-stack-v |
| .vertical-scroll-only |  .sme-arrange-overflow-hide-x sme-arrange-overflow-auto-y |
| .wrap |  .sme-arrange-wrapstack-h OR .sme-arrange-wrapstack-v |

### Replace usage of the following components with these sme components:

| Old component | New component |
| -- | -- |
| .alert |  sme-alert |
| .alert-danger |  sme-alert |
| .breadCrumb |  sme-alert |
| .checkbox |  sme-form-field[type="checkbox"] |
| .combobox |  sme-form-field[type="select"] |
| .dashboard |  sme-layout-content-zone-padded sme-arrange-stack-h |
| .details-panel |  sme-property-grid |
| .details-panel-container |  sme-property-grid |
| .details-tab |  sme-property-grid OR sme-pivot |
| .details-wrapper |  sme-property-grid |
| .disabled |  sme-disabled |
| .form-buttons | sme-form-field |
| .form-control | sme-form-field |
| .form-controls | sme-form-field |
| .form-group | sme-form-field |
| .form-group-label | sme-form-field |
| .form-input | sme-form-field |
| .form-stretch | sme-form-field |
| .input-file | sme-form-field |
| .nav-tabs |  sme-pivot |
| .radio |  sme-form-field[type="radio"] |
| .required-clue | sme-form-field |
| .searchbox |  sme-form-field[type="search"] |
| .toggle-switch |  sme-form-field[type="toggle-switch"] |
| .tool-container |  sme-layout-content-zone OR sme-layout-content-zone-padded |

### These CSS classes are deprecated and are no longer supported:

| Old class | Deprecated |
| -- | -- |
| .acceptable | (deprecated) |
| .color-error | (deprecated) |
| .color-info | (deprecated) |
| .color-success | (deprecated) |
| .color-warning | (deprecated) |
| .delete-button | (deprecated) |
| .details-content | (deprecated) |
| .error-cover | (deprecated) |
| .error-message | (deprecated) |
| .guided-pane-button | (deprecated) |
| .header-container | (deprecated) |
| .icon-win | (deprecated) |
| .indent | (deprecated) |
| .invalid | (deprecated) |
| .item-list | (deprecated) |
| .modal-scrollable | (deprecated) |
| .multi-section | (deprecated) |
| .no-action-bar | (deprecated) |
| .overflow-margins | (deprecated) |
| .overflow-tool | (deprecated) |
| .progress-cover | (deprecated) |
| .right-panel | (deprecated) |
| .rollup | (deprecated) |
| .rollup-status | (deprecated) |
| .rollup-title | (deprecated) |
| .rollup-value | (deprecated) |
| .searchbox-action-bar | (deprecated) |
| .size-h-1 | (deprecated) |
| .size-h-2 | (deprecated) |
| .size-h-3 | (deprecated) |
| .size-h-4 | (deprecated) |
| .size-h-full | (deprecated) |
| .size-h-half | (deprecated) |
| .size-v-1 | (deprecated) |
| .size-v-2 | (deprecated) |
| .size-v-3 | (deprecated) |
| .size-v-4 | (deprecated) |
| .status-icon | (deprecated) |
| .svg-16px | (deprecated) |
| .table-indent | (deprecated) |
| .table-sm | (deprecated) |
| .thin | (deprecated) |
| .tile | (deprecated) |
| .tile-body | (deprecated) |
| .tile-content | (deprecated) |
| .tile-footer | (deprecated) |
| .tile-header | (deprecated) |
| .tile-layout | (deprecated) |
| .tile-table | (deprecated) |
| .toolbar | (deprecated) |
| .tool-bar | (deprecated) |
| .tool-header | (deprecated) |
| .tool-header-box | (deprecated) |
| .tool-pane | (deprecated) |
| .usage-bar | (deprecated) |
| .usage-bar-area | (deprecated) |
| .usage-bar-background | (deprecated) |
| .usage-bar-title | (deprecated) |
| .usage-bar-value | (deprecated) |
| .usage-chart | (deprecated) |
| .usage-message | (deprecated) |
| .usage-message-area | (deprecated) |
| .usage-message-title | (deprecated) |
| .warning | (deprecated) |
| .white-space | (deprecated) |

## 7. Understand and resolve issues with observable objects

### Update  ```rxjs``` function use for observable objects

These are some common function names that have been changed, there may be others in your project.

* Update ```Observable.empty()``` to ```empty()```
* Update ```Observable.of()``` to ```of()```
* Update ```.switchMap()``` to ```.pipe(switchMap())```
* Update ```.map()``` to ```.pipe(map())```
* Update ```flatMap()``` to ```mergeMap()```


### Resolve runtime issues with ```.map()``` and ```.filter()``` functions on observable objects

If the compiler cannot properly identify an ```observable``` object's type, ```.map()``` and ```.filter()``` functions from the ```array``` object might be mapped instead to your object, causing errors at runtime.  Make sure that your functions return an ```observable``` object specifying an explicit data type to avoid this issue.

```any``` and no return type can cause this problem, look for code with these patterns:

``` ts
public getMyObservable(): any { //any return type can cause issues
 ...
}

public getMyObservable() { //no return type can cause issues
...
}
```

## 8. Resolve other common issues

These techniques will help resolve other common issues:

* Run ```ng lint --fix``` to fix common lint issues
* Run ```gulp build``` repeatedly to incrementally fix issues that ```gulp build``` can resolve automatically

## 9. Build and serve your project

Run the following commands to build and serve your project with the latest version (SDK 1.0):

``` cmd
gulp build
gulp serve --port 4201
```

## 10. Turn on dark theme in Windows Admin Center

To turn on dark theme in Windows Admin Center version 1902 and later, follow these steps:

* Open Windows Admin Center (version 1902 and later)
* Click on the **Settings** icon in the top right corner of the window
* Select the **Advanced** tab
* Under *Experiment Keys*, click **Add**
* Enter a new value ```msft.sme.shell.personalization``` in the empty field that was created by the previous step
* Click **Save and Reload**
* Settings will now have a new tab, **Personalization**.  Select this tab
* Change **Colors** to **Dark mode (preview)**
