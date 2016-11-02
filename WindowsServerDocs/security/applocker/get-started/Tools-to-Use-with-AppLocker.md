---
title: Tools to Use with applocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2f60e286-ec46-4846-8c1e-e1d6721ec91d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Tools to Use with applocker

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the tools available to create and administer applocker policies.

The following tools can help you administer the application control policies created by using applocker on the local computer or by using Group Policy. For information about the basic requirements for using applocker, see [Requirements to Use applocker](requirements-to-use-applocker.md).

-   **applocker Local Security Policy MMC snap-in**

    The applocker rules can be maintained by using the Local Security Policy snap-in (secpol.msc) of the Microsoft Management Console (MMC). For procedures to create, modify, and delete applocker rules, see [Working with applocker Rules](../manage/rules/working-with-applocker-rules.md).

-   **Generate Default Rules tool**

    applocker includes default rules for each rule collection accessed through the Local Security Policy snap-in. These rules are intended to help ensure that the files that are required for Windows to operate properly are allowed in an applocker rule collection. For information about how to use this tool, see [Create applocker Default Rules](../manage/rules/create-applocker-default-rules.md).

-   **Automatically Generate applocker Rules wizard**

    By using the Local Security Policy snap-in, you can automatically generate rules for all files within a folder. The wizard will scan the specified folder and create the condition types that you choose for each file in that folder. For information about how to use this wizard, see [Run the Automatically Generate Rules Wizard](../manage/rules/run-the-automatically-generate-rules-wizard.md).

-   **Group Policy**

    You can edit an applocker  policy by adding, changing, or removing rules by using the Group Policy Management Console (GPMC).

    If you want additional features to manage applocker policies, such as version control, use Group Policy management software that allows you to create versions of Group Policy Objects (GPOs). An example of this type of software is the Advanced Group Policy Management feature from the Microsoft Desktop Optimization Pack. For more information about Advanced Group Policy Management, see [Advanced Group Policy Management Overview](http://go.microsoft.com/fwlink/?LinkId=145013) (http://go.microsoft.com/fwlink/?LinkId=145013).

-   **Remote Server Administration Tools (RSAT)**

    You can use a computer with a supported operating system that has the Remote Server Administration Tools (RSAT) installed to create and maintain applocker policies. To download RSAT, see [Remote Server Administration Tools for Windows 7](http://go.microsoft.com/fwlink/?LinkID=153874) (http://go.microsoft.com/fwlink/?LinkID=153874) or [Remote Server Administration Tools for Windows 8](http://www.microsoft.com/download/details.aspx?id=28972).

-   **Event Viewer**

    The applocker log contains information about applications that are affected by applocker rules. For information about using Event Viewer to review the applocker logs, see [Using Event Viewer with applocker](how-applocker-works/using-event-viewer-with-applocker.md), and [View the applocker Log in Event Viewer](../manage/monitor-application-usage-with-applocker.md#BKMK_AppLkr_View_Log).

-   **applocker PowerShell cmdlets**

    The applocker Windows PowerShell cmdlets are designed to streamline the administration of applocker policy. They can be used to help create, test, maintain, and troubleshoot an applocker policy. The cmdlets are intended to be used in conjunction with the applocker user interface that is accessed through the Local Security Policy snap-in and the GPMC. For information about the cmdlets, see the [applocker PowerShell Command Reference](http://technet.microsoft.com/library/hh847210.aspx).

## See Also
[applocker Technical Reference](applocker-technical-reference.md)


