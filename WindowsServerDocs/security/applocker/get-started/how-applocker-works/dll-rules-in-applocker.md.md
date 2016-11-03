---
title: DLL Rules in AppLocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 878a2a24-59b5-4742-8515-5c62e72b4164
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# DLL Rules in AppLocker

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the file formats and available default rules for the DLL rule collection.

AppLocker defines DLL rules to include only the following file formats:

-   .dll

-   .ocx

The following table lists the default rules that are available for the DLL rule collection.

|Purpose|Name|User|Rule condition type|
|------|----|----|------------|
|Allows members of the local Administrators group to run all DLLs|(Default Rule) All DLLs|BUILTIN\Administrators|Path: *|
|Allow all users to run DLLs in the Windows folder|(Default Rule) Microsoft Windows DLLs|Everyone|Path: %windir%\\*|
|Allow all users to run DLLs in the Program Files folder|(Default Rule) All DLLs located in the Program Files folder|Everyone|Path: %programfiles%\\*|

> [!IMPORTANT]
> If you use DLL rules, a DLL allow rule has to be created for each DLL that is used by all of the allowed applications.

> [!CAUTION]
> When DLL rules are used, AppLocker must check each DLL that an application loads. Therefore, users may experience a reduction in performance if DLL rules are used.

## See Also
[Understanding AppLocker Default Rules](understanding-applocker-default-rules.md)


