---
title: Add a module to a tool extension
description: Develop a tool extension in Windows Admin Center SDK (Project Honolulu) - Add a module to a tool extension.
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/01/2023
---

# Add a module to a tool extension

Applies to: Windows Admin Center, Windows Admin Center Preview

In this article, add an empty module to a tool extension we've created with the Windows Admin Center CLI.

## Prepare your environment

If you haven't already done it, follow the directions in develop a [tool](../develop-tool.md) (or [solution](../develop-solution.md)) extension to prepare your environment and create a new, empty tool extension.

## Use the Angular CLI to create a module (and component)

If you're new to Angular, we encourage you to read the documentation on the Angular website to learn about Angular and NgModule. See [NgModule](https://angular.io/guide/ngmodule) for guidance.

To learn more:

- [Generating a new module in Angular CLI](https://github.com/angular/angular-cli/wiki/generate-module).
- [Generating a new component in Angular CLI](https://github.com/angular/angular-cli/wiki/generate-component).

Open a command prompt, change directory to .\src\app in your project, and then run the following commands, replacing ```{!ModuleName}``` with your module name (spaces removed).

```
cd .\src\app
ng generate module {!ModuleName}
ng generate component {!ModuleName}
```

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!ModuleName}``` | Your module name (spaces removed) | ```ManageFooWorksPortal``` |

Example usage:

```powershell
cd .\src\app
ng generate module ManageFooWorksPortal
ng generate component ManageFooWorksPortal
```

## Add routing information

If you're new to Angular, we recommended you learn about Angular Routing and Navigation. The following sections define necessary routing elements that enable Windows Admin Center to navigate to your extension and between views in your extension in response to user activity. To learn more, see the [Router guidance](https://angular.io/guide/router)

Use the same module name that you used in the preceding step.

### Add content to new routing file

1. Browse to the module folder created by  ``` ng generate ``` in the previous step.

1. Create a new file ```{!module-name}.routing.ts```, following this naming convention:

    | Value | Explanation | Example filename |
    | ----- | ----------- | ------- |
    | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.routing.ts``` |

1. Add this content to the file created:

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

1. Replace values in the file created with your desired values:

    | Value | Explanation | Example |
    | ----- | ----------- | ------- |
    | ```{!ModuleName}``` | Your module name (spaces removed) | ```ManageFooWorksPortal``` |
    | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal``` |

### Add content to new module file

1. Open file ```{!module-name}.module.ts```, found with the following naming convention:

   | Value | Explanation | Example filename |
   | ----- | ----------- | ------- |
   | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.module.ts``` |

1. Add content to the file:

    ``` ts
    import { Routing } from './{!module-name}.routing';
    ```

1. Replace values in the content just added with your desired values:

    | Value | Explanation | Example |
    | ----- | ----------- | ------- |
    | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal``` |

1. Modify the imports statement to import Routing:

    | Original value | New value |
    | -------------- | --------- |
    | ```imports: [ CommonModule ]``` | ```imports: [ CommonModule, Routing ]``` |

1. Make sure ```import``` statements are alphabetized by source.

### Add content to new component TypeScript file

1. Open file ```{!module-name}.component.ts```, found with the following naming convention:

   | Value | Explanation | Example filename |
   | ----- | ----------- | ------- |
   | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.component.ts``` |

1. Modify content in the file to match the following example.

   ``` ts
   constructor() {
       // TODO
   }
   
   public ngOnInit() {
       // TODO
   }
   ```

### Update app-routing.module.ts

1. Open file ```app-routing.module.ts```, and modify the default path so it loads the new module you created. Find the entry for ```path: ''```, and update  ```loadChildren``` to load your module instead of the default module:

   | Value | Explanation | Example |
   | ----- | ----------- | ------- |
   | ```{!ModuleName}``` | Your module name (spaces removed) | ```ManageFooWorksPortal``` |
   | ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal``` |

   ``` ts
       {
           path: '',
           loadChildren: 'app/{!module-name}/{!module-name}.module#{!ModuleName}Module'
       },
   ```

   Here's an example of an updated default path:

   ``` ts
       {
           path: '',
           loadChildren: 'app/manage-foo-works-portal/manage-foo-works-portal.module#ManageFooWorksPortalModule'
       },
   ```

## Build and side load your extension

You have now added a module to your extension. Next, you can [build and side load](../develop-tool.md#build-and-side-load-your-extension) your extension in Windows Admin Center to see the results.
