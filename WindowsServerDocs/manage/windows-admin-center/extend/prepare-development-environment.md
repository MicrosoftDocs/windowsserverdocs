---
title: Preparing your development environment
description: Preparing your development environment Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 05/02/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Preparing your development environment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

Let’s get started developing extensions with the Windows Admin Center SDK!  In this document, we’ll cover the process end-to-end to get your environment up and running to build and test an extension for Windows Admin Center.

> [!NOTE]
> New to the Windows Admin Center SDK?  Learn more about [Extensions for Windows Admin Center](extensibility-overview.md)

To prepare your development environment, perform the following steps:

## Install prerequisites

To begin developing with the SDK, download and install the following prerequisites:

* [Windows Admin Center](https://aka.ms/wacdownload)
* Visual Studio or [Visual Studio Code](http://code.visualstudio.com)
* [Node Package Manager](https://npmjs.com/get-npm) (for downloading build dependencies)
* [Nuget](https://www.nuget.org/downloads) (for publishing extensions)

> [!NOTE]
> You need to install and run Windows Admin Center in Dev Mode to follow the steps below. Dev Mode allows Windows Admin Center to load unsigned extension packages.
>
>  To enable Dev Mode, install Windows Admin Center from the command line with the parameter DEV_MODE=1. In the example below, replace ```<version>``` with the version you are installing, i.e. ```WindowsAdminCenter1804.msi```.
>
> ```msiexec /i WindowsAdminCenter<version>.msi DEV_MODE=1```

## Install dependencies

Next, install or update dependencies required for your project, with Node Package Manager. These dependencies will be installed globally, and will be available for all projects.

```
npm install npm@5.5.1 -g
npm install @angular/cli@1.6.5 -g
npm install -g gulp
npm install typescript@2.5.3 -g
npm install tslint@5.7.0 -g
```

## Clone extension template

[Windows Admin Center Extension Template](https://github.com/Microsoft/windows-admin-center-extension-template) is an empty project you can use to build your own custom extension for Windows Admin Center. This project contains the minimum components required to build either a Solution or a Tool extension that can be loaded into Windows Admin Center.

Navigate to the extension template on [GitHub](https://github.com/Microsoft/windows-admin-center-extension-template) and clone the template to your local development environment.

## Prepare extension template for use

### Update placeholder values

The first step after you have cloned the extension template project is to update placeholder values throughout the project. The recommended way to do this is a global find and replace with an editor like Visual Studio Code.

Replace the entire placeholder value with your value. For example, replace ```{!company-name}``` with ```contoso-inc```, removing these characters: ```{! } ```

#### Affected files
The following files will be affected:

* \package.json
* \src\app\app-routing-module.ts
* \src\main.ts
* \src\resources\strings\strings.resjson
* \src\manifest.json

In later steps, these newly created files will be affected:

* \src\app\\{!module-name}\\{!module-name}.routing.ts
* \src\app\\{!module-name}\\{!module-name}.module.ts

#### Values to replace

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!company-name}``` | Your company name (lower case, spaces replaced with dashes) | ```contoso-inc``` |
| ```{!product-name}``` | Your product name (lower case, spaces replaced with dashes) | ```manage-foo-works``` |
| ```{!ProductName}``` | Your product name (spaces removed) | ```ManageFooWorks``` |
| ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal``` |
| ```{!ModuleName}``` | Your module name (spaces removed) | ```ManageFooWorksPortal``` |
| ```{!product-title}``` | Your product title | ```Manage Foo Works``` |
| ```{!product-description}``` | Your product's description | ```Manage Foo Works management portal.```|
| ```{!product-display-name}``` | Your product's display name | ```Manage Foo Works (TM)``` |
| ```{!product-about}``` | Text for about dialog | ```Manage Foo Works``` |
| ```{!product-about-description}``` | Text for about dialog description | ```Contoso Inc's Manage Foo Works, contact foo@contoso.inc for more info.``` |


### Rename project folder

Rename parent folder ```\windows-admin-center-extension-template``` to your desired name.

| Original folder name | New folder name | New folder name (example) |
| -------------------- | --------------- | ------------------------- |
| ```windows-admin-center-extension-template``` | ```{!company-name}-{!product-name}``` | ```contoso-inc-manage-foo-works``` |

### Install dependencies with NPM

Install local dependencies for your project:

```
npm install
```

### Create modules and components with Angular CLI

If you are new to Angular, it is highly recommended that you read the documentation on the Angular.Io website to learn about Angular and NgModule. For more information about NgModule, go here: https://angular.io/guide/ngmodule

* More information about generating a new module in Angular CLI: https://github.com/angular/angular-cli/wiki/generate-module
* More information about generating a new component in Angular CLI: https://github.com/angular/angular-cli/wiki/generate-component

Use the same module name that you used in the step [Update placeholder values](#update-placeholder-values):

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!ModuleName}``` | Your module name (spaces removed) | ```ManageFooWorksPortal``` |

>[!NOTE]
>"ManageFooWorksPortal" is an example module name. Replace this with your module name when executing these commands.

```
cd \src\app
ng generate module ManageFooWorksPortal
ng generate component ManageFooWorksPortal
```

### Add routing information

If you are new to Angular, it is highly recommended you learn about Angular Routing and Navigation. The sections below define necessary routing elements that enable Windows Admin Center to navigate to your extension and between views in your extension in response to user activity. To learn more, go here: https://angular.io/guide/router

Use the same module name that you used in the step [Update placeholder values](#update-placeholder-values).

#### Add content to new routing file

* Browse to the module folder that was created by  ``` ng generate ``` in the previous step.

* Create a new file ```{!module-name}.routing.ts```, following this naming convention:  

    | Value | Explanation | Example filename |
    | ----- | ----------- | ------- |
    | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.routing.ts``` |

    
* Add this content to the file just created:

    ``` ts
    import { NgModule } from '@angular/core';
    import { RouterModule, Routes } from '@angular/router';
    import { {!ModuleName}Component } from './{!module-name}.component';

    const routes: Routes = [
        {
            path: '',
            component: {!ModuleName}Component,
            // if the component has child components that need to be routed to, include them in the children array.
            children: [
                {
                    path: '', 
                    redirectTo: 'base',
                    pathMatch: 'full'
                },
                {
                    path: 'base', 
                    component: {!ModuleChildName}Component
                }
            ]
    }];

    @NgModule({
        imports: [
            RouterModule.forChild(routes)
        ],
        exports: [
            RouterModule
        ]
    })
    export class Routing { }
    ```

* Replace values in the file just created with your desired values:

    | Value | Explanation | Example |
    | ----- | ----------- | ------- |
    | ```{!ModuleName}``` | Your module name (spaces removed) | ```ManageFooWorksPortal``` |
    | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal``` |
    | ```{!ModuleChildName}``` | Your module's child name (spaces removed) | ```ManageFooWorksPortalSplash``` |

* Delete the following block if you aren't planning on creating any children components. Otherwise, replace the template text with your desired name:

    ``` ts
    ,{
        path: 'base', 
        component: {!ModuleChildName}Component
    }
    ```
#### Add content to new module file

Open file ```{!module-name}.module.ts```, found with the following naming convention:

| Value | Explanation | Example filename |
| ----- | ----------- | ------- |
| ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.module.ts``` |

* Add content to the file:

    ``` ts
    import { Routing } from './{!module-name}.routing';
    ```
       
* Replace values in the content just added with your desired values:

    | Value | Explanation | Example |
    | ----- | ----------- | ------- |
    | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal``` |

* Modify the imports statement to import Routing:

    | Original value | New value |
    | -------------- | --------- |
    | ```imports: [ CommonModule ]``` | ```imports: [ CommonModule, Routing ]``` |
        
- Make sure ```import``` statements are alphabetized by source.

#### Add content to new component file

Open file ```{!module-name}.component.ts```, found with the following naming convention:

| Value | Explanation | Example filename |
| ----- | ----------- | ------- |
| ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.component.ts``` |

* Modify content in the file to the following:

    ``` ts
    constructor() {
        // TODO
    }
    
    public ngOnInit() {
        // TODO
    }
    ```

## Build and side load template

Build and side load the extension template to make sure your modifications were successful. To build the extension, open a command window, change directory to the unpacked source directory "cd C:\<your root>\msft-sme-developer-tools", and then you're ready to build.

*	Build and serve with gulp:

    ```
    gulp build
    gulp serve -p 4201
    ```
    
Note that you need to choose a port that is currently free. Make sure you do not attempt to use the port that Windows Admin Center is running on.

Your project can be side loaded into a local instance of Windows Admin Center for testing by attaching the locally served project into Windows Admin Center.

*	Launch Windows Admin Center in a web browser 
*	Open the debugger (F12)
*	Open the Console and type the following command:

    ```
    MsftSme.sideLoad("http://localhost:4201")
    ```
    
*	Refresh the web browser

Your project will now be visible in the Tools list with (side loaded) next to the name.

## Next steps

Now that your environment is prepared, you are ready to start customizing content in your project.

- Learn more about developing a [tool extension](develop-tool.md)
- Learn more about developing a [solution extension](develop-solution.md)
- Learn how to create a [gateway plugin](develop-gateway-plugin.md)

## More resources

Here are some additional topics you may be interested in:

- [Control your tool's visibility](guides/dynamic-tool-display.md)
- [Strings and localization](guides/strings-localization.md)
- [Using PowerShell in your extension](guides/powershell.md)
- [CSS icon guide](guides/cssicons.md)

