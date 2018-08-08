---
title: Prepare your development environment
description: Preparing your development environment Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 06/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Prepare your development environment

>Applies To: Windows Admin Center, Windows Admin Center Preview

Let’s get started developing extensions with the Windows Admin Center SDK!  In this document, we’ll cover the process end-to-end to get your environment up and running to build and test an extension for Windows Admin Center.

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

## Install dependencies

Next, install or update dependencies required for your project, with Node Package Manager. These dependencies will be installed globally, and will be available for all projects.

```
npm install npm -g

npm install @angular/cli@1.6.5 -g

npm install -g gulp
npm install typescript -g
npm install tslint -g
npm install -g windows-admin-center-cli
```

>[!NOTE]
>You can install a later version of @angular/cli, however be aware that if you install a version greater than 1.6.5, you will receive a warning during the gulp build step that the local cli version does not match the installed version.

## Create new extension with the Windows Admin Center CLI ##

Once you have all the dependencies installed, you are ready to create your new extension.  Create or browse to a folder that contains your project files, open a command prompt, and set that folder as the working directory.  Using the Windows Admin Center CLI, create a new extension with the following syntax:

```
wac create --company <Your Company> --tool <Your Tool>
```

This creates a new folder inside the current working directory using the name you specified for your tool, copies all the necessary template files into your project, and configures the files with your company and tool name.  

Next, cd into the folder just created, then install the local dependencies required by the template by running the following command:

```
npm install
```

Once this completes, you've set up everything you need to load a new extension into Windows Admin Center.  All that is left is to build and side load the extension template. 

## Build and side load template

Build and side load the extension template to make sure your modifications were successful. To build the extension, open a command window, change directory to your source directory, then you're ready to build.

* Build and serve with gulp:

    ```
    gulp build
    gulp serve -p 4201
    ```

Note that you need to choose a port that is currently free. Make sure you do not attempt to use the port that Windows Admin Center is running on.

Your project can be side loaded into a local instance of Windows Admin Center for testing by attaching the locally served project into Windows Admin Center.

* Launch Windows Admin Center in a web browser
* Open the debugger (F12)
* Open the Console and type the following command:

    ```
    MsftSme.sideLoad("http://localhost:4201")
    ```

*	Refresh the web browser

Your project will now be visible in the Tools list with (side loaded) next to the name.

>[!NOTE]
>An [alternate way](extension-template.md) to create an extension is to clone our Extension Template from GitHub, then prepare the extension for use manually.  (All of these steps are covered by the Windows Admin Center CLI).

## Next steps

Now that your environment is prepared, you are ready to start customizing content in your project.

- Create a [tool](develop-tool.md) extension
- Create a [solution](develop-solution.md) extension
- Create a [gateway plugin](develop-gateway-plugin.md)
- Learn more with our [guides](guides.md)
