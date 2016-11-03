---
title: Create AppLocker Default Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3bdbe001-4475-4cfd-a6e5-b1f08646b77f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Create AppLocker Default Rules

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to create a standard set of AppLocker rules that will allow Windows system files to run in Windows Server 2012 and Windows 8.

AppLocker includes default rules for each rule collection. These rules are intended to help ensure that the files that are required for Windows to operate properly are allowed to run.

> [!IMPORTANT]
> You can use the default rules as a template when creating your own rules to allow files within the Windows folders to run. However, these rules are only meant to function as a starter policy when you are first testing AppLocker rules. The default rules can be modified in the same way as other AppLocker rule types.

You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object (GPO) or by using the Local Security Policy snap-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap-ins to administer AppLocker, see [Using the MMC snap-ins to administer AppLocker](../administer-applocker.md#BKMK_Using_Snapins).

#### To create default rules

1.  In the console tree of the snap-in, double-click **Application Control Policies**, and then double-click **AppLocker**.

2.  Right-click the appropriate rule type for which you want to automatically generate default rules. You can automatically generate rules for executable, Windows Installer, script rules and Packaged app rules.

3.  Click **Create Default Rules**.


