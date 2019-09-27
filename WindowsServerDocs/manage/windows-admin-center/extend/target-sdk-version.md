---
title: Target a different version of the Windows Admin Center SDK
description: Target a different version of the Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Target a different version of the Windows Admin Center SDK

>Applies To: Windows Admin Center, Windows Admin Center Preview

Keeping your extension up to date with SDK changes and platform changes is easy.  We use [NPM tags](https://www.npmjs.com/package/@microsoft/windows-admin-center-sdk) to organize the release of new features into SDK versions.

There are three SDK versions you can choose from:

* ```latest``` – this SDK package aligns with the current GA release of Windows Admin Center
* ```insider``` –  this SDK package aligns with the current preview release of Windows Admin Center (available at Windows Server Insider Preview)
* ```next``` – this SDK package contains the most recent functionality

> [!NOTE]
> Find out more about the different [versions](https://aka.ms/WACDownloadPage) of Windows Admin Center that are available to download.

## Targeting SDK version on a new project

When creating a new extension, you can include the ```--version``` parameter to target a different version of the SDK:

```
wac create --company "{!Company Name}" --tool "{!Tool Name}" --version {!version}
```

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!Company Name}``` | Your company name (with spaces) | ```Contoso Inc``` |
| ```{!Tool Name}``` | Your tool name (with spaces) | ```Manage Foo Works``` |
| ```{!version}``` | SDK Version | ```latest``` |

Here's an example creating a new extension targeting ```insider```:

```
wac create --company "Contoso Inc" --tool "Manage Foo Works" --version insider
```

## Targeting SDK version on an existing project

To modify an existing project to target a different SDK version, modify the following line in ```package.json```:

```
"@microsoft/windows-admin-center-sdk": "latest",
```
In this example, replace ```latest``` with your desired SDK version, i.e. ```insider```:

```
"@microsoft/windows-admin-center-sdk": "insider",
```

Then run ```npm install``` to update references throughout your project.