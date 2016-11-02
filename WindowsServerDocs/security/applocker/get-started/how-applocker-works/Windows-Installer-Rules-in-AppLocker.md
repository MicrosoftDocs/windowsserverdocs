---
title: Windows Installer Rules in AppLocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d31b6575-7ed3-4142-aef9-803c3d30388a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Windows Installer Rules in AppLocker

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the file formats and available default rules for the Windows Installer rule collection.

AppLocker defines Windows Installer rules to include only the following file formats:

-   .msi

-   .msp

-   .mst

The purpose of this collection is to allow you to control the installation of files on client computers and servers through Group Policy or the Local Security Policy snap-in. The following table lists the default rules that are available for the Windows Installer rule collection.

|Purpose|Name|User|Rule condition type|
|------|----|----|------------|
|Allow members of the local Administrators group to run all Windows Installer files|(Default Rule) All Windows Installer files|BUILTIN\Administrators|Path: *|
|Allow all users to run Windows Installer files that are digitally signed|(Default Rule) All digitally signed Windows Installer files|Everyone|Publisher: * (all signed files)|
|Allow all users to run Windows Installer files that are located in the Windows Installer folder|(Default Rule) All Windows Installer files in %systemdrive%\Windows\Installer|Everyone|Path:  %windir%\Installer\\*|

## See Also
[Understanding AppLocker Default Rules](understanding-applocker-default-rules.md)


