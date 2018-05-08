---
title: Develop a tool extension
description: Develop a tool extension Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 05/03/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Develop a tool extension

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

A tool extension is the primary way that users interact with Windows Admin Center to manage a connection, such as a server or cluster. When you click on a connection in the Windows Admin Center home screen and connect, you will then be presented with a list of tools in the left navigation pane. When you click on a tool, the tool extension is loaded and displayed in the right pane.

When a tool extension is loaded, it can execute WMI calls or PowerShell scripts on a target server or cluster and display information in the UI or execute commands based on user input. Tool extensions define which solutions it should be displayed for, resulting in a different set of tools for each solution.

> [!NOTE]
> Not familiar with the different extension types? Learn more about the [extensibility architecture and extension types](understand-extensions.md).

## Follow these steps to create a tool extension

- [Prepare](prepare-development-environment.md) your development environment
    - [Clone](prepare-development-environment.md#clone-extension-template) the extension template 
    - [Prepare](prepare-development-environment.md#prepare-extension-template-for-use) the extension template to use as your project
- Add your content to the project

## Example projects

Check out these tool examples available on our [GitHub site](https://github.com/Microsoft/windows-admin-center-sdk/):

* [Developer Tools](https://github.com/Microsoft/windows-admin-center-sdk/tree/master/windows-admin-center-developer-tools) is a sample extension containing a rich collection of sample functionality and tool examples that you can browse and use in your own extension. Developer Tools is a fully functioning extension that can be side-loaded into Windows Admin Center in Developer Mode.

* [IFrame Example](https://github.com/Microsoft/windows-admin-center-sdk/tree/master/iframe-example) is a sample extension containing the configuration necessary to load an existing web application into Windows Admin Center in an IFrame. Use this as a guide in building your own tool extension that uses an IFrame.

