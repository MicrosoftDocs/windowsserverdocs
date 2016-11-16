---
title: Understanding AppLocker Default Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5165bd80-0ab1-4718-9f6a-fc6697d21b7b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Understanding AppLocker Default Rules

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for IT professional describes the set of rules that can be used to ensure that required Windows system files are allowed to run when the policy is applied.

AppLocker includes default rules for each rule collection. These rules are intended to help ensure that the files that are required for Windows to operate properly are allowed in an AppLocker rule collection.

> [!IMPORTANT]
> You can use the default rules as a template when creating your own rules. However, these rules are only meant to function as a starter policy when you are first testing AppLocker rules so that the system files in the Windows folders will be allowed to run.

If you require additional application security, you might need to modify the rules created from the built-in default rule collection. For example, the default rule to allow all users to run .exe files in the Windows folder is based on a path condition that allows all files within the Windows folder to run. The Windows folder contains a Temp subfolder to which the Users group is given the following permissions:

-   Traverse Folder/Execute File

-   Create Files/Write Data

-   Create Folders/Append Data

These permissions settings are applied to this folder for application compatibility. However, because any user can create files in this location, allowing applications to be run from this location might conflict with your organization's security policy.

For information about each default rule in AppLocker, see:

-   [Executable Rules in AppLocker](executable-rules-in-applocker.md)

-   [Windows Installer Rules in AppLocker](windows-installer-rules-in-applocker.md)

-   [Script Rules in AppLocker](script-rules-in-applocker.md)

-   [DLL Rules in AppLocker](dll-rules-in-applocker.md)

-   [Packaged Apps and Packaged App Installer Rules in AppLocker](../../../access-control/packaged-apps-and-packaged-app-installer-rules-in-applocker.md)

## See Also
[How AppLocker Works](../how-applocker-works.md)


