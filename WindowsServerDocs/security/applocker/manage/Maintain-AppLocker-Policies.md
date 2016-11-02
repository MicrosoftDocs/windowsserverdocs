---
title: Maintain applocker Policies
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 45d86fc8-5281-4b3f-9ef3-ef3da61f56c8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Maintain applocker Policies

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to maintain rules within applocker policies in  Windows Server 2012  and Windows 8.

Common applocker maintenance scenarios include:

-   A new application is deployed, and you need to update an applocker policy.

-   A new version of an application is deployed, and you need to either update an applocker policy or create a new rule to update the policy.

-   An application is no longer supported by your organization, so you need to prevent it from being used.

-   An application appears to be blocked but should be allowed.

-   An application appears to be allowed but should be blocked.

-   A single user or small subset of users needs to use a specific application that is blocked.

There are two methods you can use to maintain applocker policies:

-   [Maintaining applocker policies by using Group Policy](#BKMK_AppLkr_Use_GP)

-   [Maintaining applocker policies on the local computer](#BKMK_AppLkr_Use_LocSnapin)

As new applications are deployed or existing applications are removed by your organization or updated by the software publisher, you might need to make revisions to your rules and update the Group Policy Object (GPO) to ensure that your policy is current.

You can edit an applocker policy by adding, changing, or removing rules. However, you cannot specify a version for the applocker policy by importing additional rules. To ensure version control when modifying an applocker policy, use Group Policy management software that allows you to create versions of GPOs, such as Microsoft Advanced Group Policy Management (AGPM). For more information about AGPM, see [Advanced Group Policy Management Overview](http://go.microsoft.com/fwlink/?LinkId=145013) (http://go.microsoft.com/fwlink/?LinkId=145013).

> [!CAUTION]
> You should not edit an applocker rule collection while it is being enforced in Group Policy. Because applocker controls what files are allowed to run, making changes to a live policy can create unexpected behavior.

## <a name="BKMK_AppLkr_Use_GP"></a>Maintaining applocker policies by using Group Policy
For every scenario, the steps to maintain an applocker policy distributed by Group Policy include the following tasks.

### Step 1: Understand the current behavior of the policy
Before modifying a policy, evaluate how the policy is currently implemented. For example, if a new version of the application is deployed, you can use **Test-applockerPolicy** to verify the effectiveness of your current policy for that application. To read the procedures necessary to understand the current behavior of the policy, see [Discovering the Effect of an applocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx). Updating your applocker planning document will help you track your findings. For information about creating this document, see [Creating Your applocker Planning Document](http://technet.microsoft.com/library/ee449479(WS.10).aspx). For information about **Test-applockerPolicy** and examples of how to use it, see [Test-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169000) (http://go.microsoft.com/fwlink/?LinkId=169000).

> [!NOTE]
> These documents apply to  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8, and  Windows 7  operating systems.

### Step 2: Export the applocker policy from the GPO
Updating an applocker policy that is currently enforced in your production environment can have unintended results. Therefore, export the policy from the GPO and update the rule or rules by using applocker on your applocker reference or test computer. To prepare an applocker policy for modification, see [Export an applocker Policy from a GPO](policies/export-an-applocker-policy-from-a-gpo.md)

### Step 3: Update the applocker policy by editing the appropriate applocker rule
After the applocker policy has been exported from the GPO into the applocker reference or test computer, or has been accessed on the local computer, the specific rules can be modified as required.

To modify applocker rules, see the following:

-   [Edit applocker Rules](rules/edit-applocker-rules.md)

-   [Merge applocker Policies by Using Set-applockerPolicy](policies/merge-applocker-policies-by-using-set-applockerpolicy.md) or [Merge applocker Policies Manually](policies/merge-applocker-policies-manually.md)

-   [Delete an applocker Rule](rules/delete-an-applocker-rule.md)

-   [Enforce applocker Rules](rules/enforce-applocker-rules.md)

### Step 4: Test the applocker policy
You should test each collection of rules to ensure that the rules perform as intended. (Because applocker rules are inherited from linked GPOs, you should deploy all rules for simultaneous testing in all test GPOs.) For steps to perform this testing, see [Test and Update an applocker Policy](test-and-update-an-applocker-policy.md).

### Step 5: Import the applocker policy into the GPO
After testing, import the applocker policy back into the GPO for implementation. To update the GPO with a modified applocker policy, see [Import an applocker Policy into a GPO](policies/import-an-applocker-policy-into-a-gpo.md).

### Step 6: Monitor the resulting policy behavior
After deploying a policy, evaluate the policy's effectiveness.  For steps to understand the new behavior of the policy, see [Discovering the Effect of an applocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx).

## <a name="BKMK_AppLkr_Use_LocSnapin"></a>Maintaining applocker policies by using the Local Security Policy snap-in
For every scenario, the steps to maintain an applocker policy by using the Local Group Policy Editor or the Local Security Policy snap-in include the following tasks.

### Step 1: Understand the current behavior of the policy
Before modifying a policy, evaluate how the policy is currently implemented. To read the procedures necessary to understand the current behavior of the policy, see [Monitor Application Usage with applocker](monitor-application-usage-with-applocker.md). Updating your applocker planning document will help you track your findings. For information about creating this document, see [Creating Your applocker Planning Document](http://technet.microsoft.com/library/ee449479(WS.10).aspx).

> [!NOTE]
> The applocker Planning Guide applies to  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8 and  Windows 7 .

### Step 2: Update the applocker policy by modifying the appropriate applocker rule
Rules are grouped into a collection, which can have the policy enforcement setting applied to it. By default, applocker rules do not allow users to open or run any files that are not specifically allowed.

To modify applocker rules, see the appropriate topic listed on [Administer applocker](administer-applocker.md).

### Step 3: Test the applocker policy
You should test each collection of rules to ensure that the rules perform as intended. For steps to perform this testing, see [Test and Update an applocker Policy](test-and-update-an-applocker-policy.md).

### Step 4: Deploy the policy with the modified rule
You can export and then import applocker policies to deploy the policy to other computers running Windows 8 or  Windows Server 2012 . To perform this task, see [Export an applocker Policy to an XML File](policies/export-an-applocker-policy-to-an-xml-file.md) and [Import an applocker Policy from Another Computer](policies/import-an-applocker-policy-from-another-computer.md).

### Step 5: Monitor the resulting policy behavior
After deploying a policy, evaluate the policy's effectiveness.  For steps to understand the new behavior of the policy, see Discovering the Effect of an applocker Policy in [Discovering the Effect of an applocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx).

> [!NOTE]
> This topic applies to  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8 and  Windows 7 .

## Additional resources

-   For steps to perform other applocker policy tasks, see [Administer applocker](administer-applocker.md).

