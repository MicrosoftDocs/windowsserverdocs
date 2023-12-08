---
title: Upgrade Windows Admin Center extensions to Angular 15
description: Guide on how to upgrade existing Windows Admin Center extensions to Angular 15
ms.technology: manage
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 11/30/2023
ms.prod: windows-server
---

# Upgrade existing Windows Admin Center extensions to Angular 15

Windows Admin Center has upgraded to Angular 15! This upgrade brings in the latest in features, security, and performance, and we're excited to have it available for you. So far, the shell of Windows Admin Center has been upgraded, and it's now your turn to update your extensions. 

We strongly recommend upgrading your extensions to the latest Angular version we support. All the new fixes and updates to our shell and SDK are only available for extensions on Angular 15. 

Follow the steps in this document to get your extension updated. If you run into any issues during this process, reach out to your Microsoft contact and they'll assist you in routing the request.

## Preliminary steps
Before beginning the upgrade to Angular 15, it's essential to ensure that your project is using ESLint and that your environment is set up properly.

> [!NOTE]
> If your extension is still running Angular 7, [upgrade to Angular 11](.\upgrade-to-angular-11.md) before reading the rest of this guide. 

### Transitioning from TSLint to ESLint
Historically, Windows Admin Center has used the extensible tool TSLint to check TypeScript code for readability, maintainability, and functionality errors. TSLint has been deprecated and replaced by ESLint, a more powerful and widely supported tool. Windows Admin Center has shifted to using ESLint.

To determine whether you're using TSLint or ESLint as the linter for your extension, navigate to the root directory of your extension project:
- If there's a file titled **.eslintrc.json**, you're using ESLint. Skip ahead to **Configuring your environment for upgrade**.
- If there's a file titled **tslint.json**, you're using TSLint. Continue on to learn how to migrate to ESLint.

We've created a command in the SDK to help with automating the transition to ESLint. To use it, follow these steps:
1. Navigate to the root of your extension project.
2. Pull down the latest version of the SDK by running `npm install -g @microsoft/windows-admin-center-sdk@latest`
3. Run `npm install`.
4. Run `wac eslint`.
5. Fix any violations by running `npx lint --fix` or by making manual changes.

### Configuring your environment for upgrade
Before beginning the upgrade to Angular 15, you need to configure your developer environment with the latest Windows Admin Center shell and development tools, including upgrading your version of Node.

To manage your versions of Node, we suggest using [Node Version Manager](https://github.com/coreybutler/nvm-windows). Follow the instructions to install nvm-windows on your machine. The version should be 1.1.11 or later, as older versions may not support the Node.js versions necessary for this upgrade. 

Once installed, you can prepare your environment by running these commands:
```
nvm install 16.14.0
nvm use 16.14.0
npm i -g gulp-cli
npm i -g @angular/cli@15.2.9
npm i -g vsts-npm-auth
npm i -g typescript@4.8.2
```

> [!NOTE]
> If you want to continue to make changes in Angular 11, you'll want to use Node 12.18.3. These versions are incompatible for use at the same time, so you must toggle your global version to run build commands in each environment. 
> 
> To change your node version back to the Angular 11 configuration, you can run the following commands:
> ```
> nvm install 12.18.3
> nvm use 12.18.3
> npm i -g gulp-cli
> npm i -g @angular/cli@11.2.13
> npm i -g vsts-npm-auth
> npm i -g typescript@4.1.5
> ```

When toggling node versions, you may lose all global node settings, including your VSTS authentication. 

To restore VSTS authentication, run ``` vsts-npm-auth -config .npmrc ``` at the root of your repository.

## Automated upgrade process
To facilitate a smoother upgrade from Angular 11 to Angular 15, we've developed a CLI command as a part of our SDK that automates much of the upgrade process.

Before proceeding with the automatic upgrade steps, make sure your environment is set up correctly, and you've switched to Angular 15. When you're ready to upgrade, follow these steps:
1. Make sure you have the latest version of the WAC CLI by running `npm install -g @microsoft/windows-admin-center-sdk@latest`.
2. Run `wac angular15Upgrade`.

### Post upgrade actions
After you run the upgrade command, a `log.txt` file will be generated at the root of your project. This file contains information on further actions.

After running the upgrade command, be sure to stage your changes. This command is designed to be run multiple times if necessary. 

You should now be able to run and test your extension as normal. 

## Troubleshooting scenarios
Some of the errors you may receive while debugging in the build step may be hard to diagnose. Here's some of the most common errors and how to mitigate them:

- **AjaxResponse requires 1 type argument**
    - To fix this issue, try staging your current changes and then rerun the upgrade command. The upgrade command should've fixed this, but there might be edge cases. Ensure you manually fix these errors by changing `AjaxResponse` to `AjaxResponse<any>`.

- **CSS syntax error in custom CSS files**
    ```cmd
    File path: C:/Branches/msft-sme-containers/src/app/containers-inventory/containers-inventory.component.css
            Type: css-syntax-error
            Line: undefined
            Char: undefined
            Message: Warning: ▲ [WARNING] Unexpected ">" [css-syntax-error]
        C:/Branches/msft-sme-containers/src/app/containers-inventory/containers-inventory.component.css:1:7:
        1 │ :host >>> .summary-container {
                    ^
    ```
     - To fix this issue, try staging your current changes and then rerun the upgrade command. The upgrade command should automatically handle this, but if it doesn't

- **Dependency warnings**
 
    ```
    Build at: 2023-11-14T19:31:35.361Z - Hash: 069ae6fa11d268d6 - Time: 32165ms
    [11:31:35] Warning: C:\Branches\msft-sme-containers\node_modules\@msft-sme\core\data\crypto.js depends on 'base64-arraybuffer'. CommonJS or AMD dependencies can cause optimization bailouts.      
    For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies

    Warning: C:\Branches\msft-sme-containers\node_modules\@msft-sme\event-viewer\dist\fesm2020\msft-sme-event-viewer-lib.mjs depends on 'file-saver'. CommonJS or AMD dependencies can cause optimization bailouts.
    For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies

    Warning: C:\Branches\msft-sme-containers\node_modules\@msft-sme\powershell-console\__ivy_ngcc__\dist\fesm2015\msft-sme-powershell-console-lib.js depends on 'xterm'. CommonJS or AMD dependencies can cause optimization bailouts.
    For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies

    Warning: C:\Branches\msft-sme-containers\node_modules\@msft-sme\powershell-console\__ivy_ngcc__\dist\fesm2015\msft-sme-powershell-console-lib.js depends on 'xterm-addon-fit'. CommonJS or AMD dependencies can cause optimization bailouts.
    For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies
    ```
    - These issues must be fixed manually. Navigate to `angular.json`, look for `"allowedCommonJsDependencies"`, and add all dependency items into the array. In this case, it would be: `"allowedCommonJsDependencies": ["base64-arraybuffer", "file-saver", "xterm", "xterm-addon-fit"]`

## Other considerations when upgrading extensions to Angular 15

- Sideloading of the shell and extensions shouldn't be affected when working with two branches of shell.
- When using copyTarget, be aware of which shell branch you're in. Only use this command in the 4.0 branch if the extension you're working with is also upgraded to Angular 15.
- If the repo has been upgraded to Angular 15, then use the latest 4.x.0 version of shell libraries. Otherwise continue to use the latest 2.x.0 version.

You can tell if a repo is upgraded by looking at the package.json file.

## Releasing your upgraded extension
Once your extension has been tested in Windows Admin Center desktop and service mode, send an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Package%20Review) to coordinate the release of your upgraded extension.