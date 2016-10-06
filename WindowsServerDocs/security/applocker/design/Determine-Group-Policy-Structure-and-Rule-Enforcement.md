---
title: Determine Group Policy Structure and Rule Enforcement
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58fd62a5-4878-4b31-9957-f209f18f8a69
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Determine Group Policy Structure and Rule Enforcement

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This overview topic describes the process to follow when you are planning to deploy AppLocker rules.

You should review the following topics to learn how to structure AppLocker rules for the targeted business groups in your organization:

-   [Understand AppLocker Enforcement Settings](Understand-AppLocker-Enforcement-Settings.md)

    This topic describes the AppLocker enforcement settings for rule collections.

-   [Understand AppLocker Rules and Enforcement Setting Inheritance in Group Policy](Understand-AppLocker-Rules-and-Enforcement-Setting-Inheritance-in-Group-Policy.md)

    This topic describes what you need to investigate, determine, and record in your application control policies plan.

When you are determining how many Group Policy Objects (GPOs) to create when you apply an AppLocker policy in your organization, you should consider the following:

-   Whether you are creating new GPOs or using existing GPOs

-   Whether you are implementing Software Restriction Policies (SRP) policies and AppLocker policies in the same GPO

-   GPO naming conventions

-   GPO size limits

> [!NOTE]
> There is no default limit on the number of AppLocker rules that you can create. However, in  Windows Server 2008 R2 , GPOs have a 2 MB size limit for performance. In subsequent versions, that limit is raised to 100 MB.

After you have determined your Group Policy structure and rule enforcement, record your findings as explained in [Document Group Policy Structure and AppLocker Rule Enforcement](Document-Group-Policy-Structure-and-AppLocker-Rule-Enforcement.md).


