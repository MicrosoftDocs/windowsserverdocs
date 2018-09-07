---
title: Prepare your development environment
description: Preparing your development environment Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.localizationpriority: medium
ms.date: 08/07/2018
ms.prod: windows-server-threshold
---

# Prepare your development environment

>Applies To: Windows Admin Center Preview

> [!NOTE]
> While the Windows Admin Center SDK is in public preview, parts of this document only apply to [Windows Admin Center Preview](https://aka.ms/WACDownloadPage) and the corresponding [insider release](target-sdk-version.md) of Windows Admin Center SDK.

Let’s get started developing extensions with the Windows Admin Center SDK!  In this document, we’ll cover the process to get your environment up and running to build and test an extension for Windows Admin Center.

> [!NOTE]
> New to the Windows Admin Center SDK?  Learn more about [Extensions for Windows Admin Center](extensibility-overview.md)

To prepare your development environment, perform the following steps:

## Install prerequisites

To begin developing with the SDK, download and install the following prerequisites:

* [Windows Admin Center](https://aka.ms/windowsadmincenter)
* Visual Studio or [Visual Studio Code](http://code.visualstudio.com)
* [Node Package Manager](https://npmjs.com/get-npm) (for downloading build dependencies)
* [Nuget](https://www.nuget.org/downloads) (for publishing extensions)

> [!NOTE]
> You need to install and run Windows Admin Center in Dev Mode to follow the steps below. Dev Mode allows Windows Admin Center to load unsigned extension packages.
>
>  To enable Dev Mode, install Windows Admin Center from the command line with the parameter DEV_MODE=1. In the example below, replace ```<version>``` with the version you are installing, i.e. ```WindowsAdminCenter1804.msi```.
>
> ```msiexec /i WindowsAdminCenter<version>.msi DEV_MODE=1```

## Install global dependencies

Next, install or update dependencies required for your projects, with Node Package Manager. These dependencies will be installed globally, and will be available for all projects.

```
npm install -g npm

npm install -g @angular/cli@1.6.5

npm install -g gulp
npm install -g typescript
npm install -g tslint
npm install -g windows-admin-center-cli
```

>[!NOTE]
>You can install a later version of @angular/cli, however be aware that if you install a version greater than 1.6.5, you will receive a warning during the gulp build step that the local cli version does not match the installed version.

## Next steps

Now that your environment is prepared, you are ready to start creating content.

- Create a [tool](develop-tool.md) extension
- Create a [solution](develop-solution.md) extension
- Create a [gateway plugin](develop-gateway-plugin.md)
- Learn more with our [guides](guides.md)
