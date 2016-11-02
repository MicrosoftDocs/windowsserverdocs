---
title: Configure an applocker Policy for Enforce Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 01a3773d-68c6-45ea-8b0e-fd5792659acd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Configure an applocker Policy for Enforce Rules

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to enable the applocker policy enforcement setting in  Windows Server 2012  and Windows 8.

> [!NOTE]
> When applocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited.

For information about how applocker policies are applied within a GPO structure, see [Understanding applocker Rules and Enforcement Setting Inheritance in Group Policy](http://technet.microsoft.com/library/ee449492(WS.10).aspx).

You can perform this task by using the Group Policy Management Console for an applocker policy in a Group Policy Object (GPO) or by using the Local Security Policy snap-in for an applocker policy on a local computer or in a security template. For information how to use these MMC snap-ins to administer applocker, see [Using the MMC snap-ins to administer applocker](../administer-applocker.md#BKMK_Using_Snapins).

#### To enable the Enforce rules enforcement setting

1.  In the console tree of the snap-in under **Computer Configuration\Windows Settings\Security Settings\Application Control Policies**, right-click **applocker**, and then click **Properties**.

2.  On the **Enforcement** tab of the **applocker Properties** dialog box, select the **Configured** check box for the rule collection that you are editing, and then verify that **Enforce rules** is selected.

3.  Click **OK**.

For information about viewing the events generated from rules enforcement, see [View the applocker Log in Event Viewer](../monitor-application-usage-with-applocker.md#BKMK_AppLkr_View_Log).


