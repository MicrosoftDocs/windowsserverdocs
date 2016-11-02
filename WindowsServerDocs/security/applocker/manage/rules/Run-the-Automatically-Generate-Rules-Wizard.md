---
title: Run the Automatically Generate Rules Wizard
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 602ecf0a-b0e6-47cb-bf4b-3c13233a611f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Run the Automatically Generate Rules Wizard

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes steps to run the wizard to create applocker rules on a reference computer in  Windows Server 2012  and Windows 8.

applocker allows you to automatically generate rules for all files within a folder. It will scan the specified folder and create the condition types that you choose for each file in that folder.

You can perform this task by using the Group Policy Management Console for an applocker policy in a Group Policy Object (GPO) or by using the Local Security Policy snap-in for an applocker policy on a local computer or in a security template. For information how to use these MMC snap-ins to administer applocker, see [Using the MMC snap-ins to administer applocker](../administer-applocker.md#BKMK_Using_Snapins).

### <a name="BKMK_RunAGRwizardGPO"></a>To automatically generate rules

1.  In the console tree of the snap-in, double-click **Application Control Policies**, and then double-click **applocker**.

2.  Right-click the appropriate rule type for which you want to automatically generate rules. You can automatically generate rules for executable, Windows Installer, script and Packaged app rules.

3.  Click **Automatically Generate Rules**.

4.  On the **Folder and Permissions** page, click **Browse** to choose the folder to be analyzed. By default, this is the Program Files folder.

5.  Click **Select** to choose the security group in which the default rules should be applied. By default, this is the **Everyone** group.

6.  The wizard provides a name in the **Name to identify this set of rules** box based on the name of the folder that you have selected. Accept the provided name or type a different name, and then click **Next**.

7.  On the **Rule Preferences** page, choose the conditions that you want the wizard to use while creating rules, and then click **Next**. For more information about rule conditions, see [Understanding applocker Rule Condition Types](../../get-started/how-applocker-works/understanding-applocker-rule-condition-types.md).

    > [!NOTE]
    > The **Reduce the number of rules created by grouping similar files** check box is selected by default. This helps you organize applocker rules and reduce the number of rules that you create by performing the following operations for the rule condition that you select:
    > 
    > -   One publisher condition is created for all files that have the same publisher and product name.
    > -   One path condition is created for the folder that you select. For example, if you select *C:\Program Files\ProgramName\\* and the files in that folder are not signed, the wizard creates a rule for *%programfiles%\ProgramName\\\**.
    > -   One file hash condition is created that contains all of the file hashes. When rule grouping is disabled, the wizard creates a file hash rule for each file.

8.  Review the files that were analyzed and the rules that will be automatically created. To make changes, click **Previous** to return to the page where you can change your selections. After reviewing the rules, click **Create**.

> [!NOTE]
> If you are running the wizard to create your first rules for a GPO, you will be prompted to create the default rules, which allow critical system files to run, after completing the wizard. You may edit the default rules at any time. If your organization has decided to edit the default rules or create custom rules to allow the Windows system files to run, ensure that you delete the default rules after replacing them with your custom rules.


