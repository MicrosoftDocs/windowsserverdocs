---
title: Download and Install SDK for Windows Admin Center
description: Download and Install SDK for Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Download and Install SDK for Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

# Getting Started with Windows Admin Center Extensions

Let’s get started with the Windows Admin Center Extensions SDK!  In this document, we’ll cover installing prerequisites, downloading SDK source code, building and side loading your extension, and renaming your extension.

## Extensions SDK Prerequisites

Before you start developing in Windows Admin Center Extensions, download and install the following prerequisites:

- Windows Admin Center, available [here](http://aka.ms/WindowsAdminCenter)
- Visual Studio or [Visual Studio Code](http://code.visualstudio.com)
- [Node Package Manager](https://npmjs.com/get-npm) (for downloading build dependencies)  
- [Nuget](https://www.nuget.org/downloads) (for publishing extensions)

## Download Source Code

The source code and dependencies are available from the Windows Admin Center team, currently under NDA.

## Install Dependencies

Install dependencies for your project with npm.
-	Install global dependencies for your project:
	```
	npm install npm@5.5.1 -g
	npm install @angular/cli@1.6.5 -g
	npm install -g gulp
    npm install typescript@2.5.3 -g
    npm install tslint@5.7.0 -g

	```

- Install local dependencies for your project (project.json):
    ```
    npm install
    ```

## Build Sample Extension

To build the sample extension, open a command window, change directory to the unpacked source directory "cd C:\<your root>\msft-sme-developer-tools", and then you're ready to build.

-	Build and serve with gulp:
	``` js
	gulp build
	gulp serve -p 4201
	```

Note that you need to choose a port that is currently free.  Make sure you do not attempt to use the port that Windows Admin Center is running on.

## Side Loading Sample Extension

Your project can be side loaded into a local instance of Windows Admin Center for testing by attaching the locally served project into Windows Admin Center.  
-	Launch Windows Admin Center in a web browser 
-	Open the debugger (F12)
-	Open the Console and type the following command:
	``` ts
	MsftSme.sideLoad("http://localhost:4201")
	```
-	Refresh the web browser
Your project will now be visible in the Tools list with (side loaded) next to the name.