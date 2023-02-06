---
title: Prepare your development environment
description: Preparing your development environment Windows Admin Center SDK (Project Honolulu)
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.localizationpriority: medium
ms.date: 12/20/2021
---

# Prepare your development environment

>Applies to: Windows Admin Center, Windows Admin Center Preview

Let's get started developing extensions with the Windows Admin Center SDK!  In this document, we'll cover the process to get your environment up and running to build and test an extension for Windows Admin Center.

> [!NOTE]
> New to the Windows Admin Center SDK?  Learn more about [Extensions for Windows Admin Center](extensibility-overview.md)

To prepare your development environment, perform the following steps:

## Install prerequisites

To begin developing with the SDK, download and install the following prerequisites:

* [Windows Admin Center](../overview.md) (GA or preview version)
* Visual Studio or [Visual Studio Code](https://code.visualstudio.com)
* [Node.js](https://nodejs.org/en/download/release/v12.18.2) (download and install the .msi file for version 12.18.2)
* [Node Package Manager](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) (6.14.5 or later)
* [NuGet](https://www.nuget.org/downloads) (for publishing extensions)

> [!NOTE]
> You need to install and run Windows Admin Center in Dev Mode to follow the steps below. Dev Mode allows Windows Admin Center to load unsigned extension packages. Windows Admin Center can only be installed in Dev Mode on a Windows 10 machine.
>
>  To enable Dev Mode, install Windows Admin Center from the command line with the parameter DEV_MODE=1. In the example below, replace ```<version>``` with the version you are installing, i.e. ```WindowsAdminCenter1809.msi```.
>
> ```msiexec /i WindowsAdminCenter<version>.msi DEV_MODE=1```
> 
> If you have already installed Windows Admin Center without enabling Dev Mode, you can edit the value of the Dev Mode property using Registry Editor. Properties for Windows Admin Center can be found under the following path:
>
>  ```Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManagementGateway```

## Install global dependencies

Next, install or update dependencies required for your projects, with Node Package Manager. These dependencies will be installed globally, and will be available for all projects.

```
npm install -g @angular/cli@11.2.14

npm install -g gulp
npm install -g typescript
npm install -g tslint
npm install -g @microsoft/windows-admin-center-sdk@latest
```

>[!NOTE]
>You can install a later version of @angular/cli, however be aware that if you install a version greater than 11.2.14, you will receive a warning during the gulp build step that the local cli version does not match the installed version.

## Next steps

Now that your environment is prepared, you are ready to start creating content.

- Create a [tool](develop-tool.md) extension
- Create a [solution](develop-solution.md) extension
- Create a [gateway plugin](develop-gateway-plugin.md)
- Learn more with our [guides](guides.md)

## SDK design toolkit

Check out our Windows Admin Center [SDK design toolkit](https://github.com/Microsoft/windows-admin-center-sdk/blob/master/WindowsAdminCenterDesignToolkit.zip)! This toolkit is designed to help you rapidly mock up extensions in PowerPoint using Windows Admin Center styles, controls, and page templates. See what your extension can look like in Windows Admin Center before you start coding!
