---
title: Target a different version of the Windows Admin Center SDK
description: Target a different version of the Windows Admin Center SDK (Project Honolulu)
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 09/18/2018
---

# Target a different version of the Windows Admin Center SDK

>Applies to: Windows Admin Center, Windows Admin Center Preview

Keeping your extension up to date with SDK changes and platform changes is easy.  We use [NuGet Package Manager tags](https://www.npmjs.com/package/@microsoft/windows-admin-center-sdk?activeTab=versions) to organize the release of new features into SDK versions.

There are two SDK versions you can choose from and three which are deprecated:

* ```latest``` – this SDK package aligns with the current GA release of Windows Admin Center and is the most stable
* ```experimental``` – this SDK package contains the most recent changes and functionality, but might be unstable
* ```insider``` –  this SDK package has been deprecated, use latest or experimental instead
* ```next``` – this SDK package has been deprecated, use latest or experimental instead
* ```legacy``` – this SDK package has been deprecated, use latest or experimental instead

> [!NOTE]
> Find out more about the different [versions](../overview.md) of Windows Admin Center that are available to download.

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

Here's an example creating a new extension targeting ```experimental```:

```
wac create --company "Contoso Inc" --tool "Manage Foo Works" --version experimental
```

> [!NOTE]
> We recommend developers building new extensions use the ```latest``` SDK version for stability.

## Targeting SDK version on an existing project

To modify an existing project to target a different SDK version, modify the following line in ```package.json```:

```
"@microsoft/windows-admin-center-sdk": "latest",
```
In this example, replace ```latest``` with your desired SDK version, i.e. ```experimental```:

```
"@microsoft/windows-admin-center-sdk": "experimental",
```

Then run ```npm install``` to update references throughout your project.
