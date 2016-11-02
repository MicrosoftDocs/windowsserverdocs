---
title: Deploy applocker Policies by Using the Enforce Rules Setting
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a7a9652a-884b-4145-b199-d59dabf4d394
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Deploy applocker Policies by Using the Enforce Rules Setting

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to deploy applocker policies by using the enforcement setting method in  Windows Server 2012  and Windows 8.

## Background and prerequisites
These procedures assume that you have already deployed applocker policies with the enforcement set to **Audit only**, and you have been collecting data through the applocker event logs and other channels to determine what effect these policies have on your environment and the policy's adherence to your application control design.

For information about the applocker policy enforcement setting, see [Understanding applocker Enforcement Settings](http://technet.microsoft.com/library/ee449488(WS.10).aspx).

For information about how to plan an applocker policy deployment, see [applocker Policies Design Guide](http://go.microsoft.com/fwlink/?LinkId=215004).

## Step 1: Retrieve the applocker policy
Updating an applocker policy that is currently enforced in your production environment can have unintended results. Using Group Policy, you can export the policy from the Group Policy Object (GPO) and then update the rule or rules by using applocker on your applocker reference or test computer. For the procedure to do this, see [Export an applocker Policy from a GPO](policies/export-an-applocker-policy-from-a-gpo.md) and [Import an applocker Policy into a GPO](policies/import-an-applocker-policy-into-a-gpo.md). For local applocker policies, you can update the rule or rules by using the Local Security policy snap-in on your applocker reference or test computer. For the procedures to do this, see [Export an applocker Policy to an XML File](policies/export-an-applocker-policy-to-an-xml-file.md) and [Import an applocker Policy from Another Computer](policies/import-an-applocker-policy-from-another-computer.md).

## Step 2: Alter the enforcement setting
Rule enforcement is applied only to a collection of rules, not to individual rules. applocker divides the rules into collections: executable files, Windows Installer files, packaged apps, scripts, and DLL files. By default, if enforcement is not configured and rules are present in a rule collection, those rules are enforced. For information about the enforcement setting, see [Understanding applocker Enforcement Settings](http://technet.microsoft.com/library/ee449488(WS.10).aspx). For the procedure to alter the enforcement setting, see [Configure an applocker Policy for Audit Only](policies/configure-an-applocker-policy-for-audit-only.md).

## Step 3: Update the policy
You can edit an applocker policy by adding, changing, or removing rules. However, you cannot specify a version for the applocker policy by importing additional rules. To ensure version control when modifying an applocker policy, use Group Policy management software that allows you to create versions of GPOs. An example of this type of software is the Advanced Group Policy Management feature from the Microsoft Desktop Optimization Pack. For more information about Advanced Group Policy Management, see [Advanced Group Policy Management Overview](http://go.microsoft.com/fwlink/?LinkId=145013) (http://go.microsoft.com/fwlink/?LinkId=145013).

> [!CAUTION]
> You should not edit an applocker rule collection while it is being enforced in Group Policy. Because applocker controls what files are allowed to run, making changes to a live policy can create unexpected behavior.

For the procedure to update the GPO, see [Import an applocker Policy into a GPO](policies/import-an-applocker-policy-into-a-gpo.md).

For the procedures to distribute policies for local computers by using the Local Security Policy snap-in, see [Export an applocker Policy to an XML File](policies/export-an-applocker-policy-to-an-xml-file.md) and [Import an applocker Policy from Another Computer](policies/import-an-applocker-policy-from-another-computer.md).

## Step 4: Monitor the effect of the policy
When a policy is deployed, it is important to monitor the actual implementation of that policy. You can do this by monitoring your support organization's application access request activity and reviewing the applocker event logs. To monitor the effect of the policy, see [View the applocker Log in Event Viewer](monitor-application-usage-with-applocker.md#BKMK_AppLkr_View_Log) and [Review applocker Events with Get-applockerFileInformation](monitor-application-usage-with-applocker.md#BKMK_AppLkr_Review_Events).

## Additional resources

-   For steps to perform other applocker policy tasks, see [Administer applocker](administer-applocker.md).



