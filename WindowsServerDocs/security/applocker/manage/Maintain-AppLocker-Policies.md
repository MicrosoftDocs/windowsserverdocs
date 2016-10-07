---
title: Maintain AppLocker Policies
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
# Maintain AppLocker Policies

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to maintain rules within AppLocker policies in  Windows Server 2012  and Windows 8.

Common AppLocker maintenance scenarios include:

-   A new application is deployed, and you need to update an AppLocker policy.

-   A new version of an application is deployed, and you need to either update an AppLocker policy or create a new rule to update the policy.

-   An application is no longer supported by your organization, so you need to prevent it from being used.

-   An application appears to be blocked but should be allowed.

-   An application appears to be allowed but should be blocked.

-   A single user or small subset of users needs to use a specific application that is blocked.

There are two methods you can use to maintain AppLocker policies:

-   [Maintaining AppLocker policies by using Group Policy](#BKMK_AppLkr_Use_GP)

-   [Maintaining AppLocker policies on the local computer](#BKMK_AppLkr_Use_LocSnapin)

As new applications are deployed or existing applications are removed by your organization or updated by the software publisher, you might need to make revisions to your rules and update the Group Policy Object (GPO) to ensure that your policy is current.

You can edit an AppLocker policy by adding, changing, or removing rules. However, you cannot specify a version for the AppLocker policy by importing additional rules. To ensure version control when modifying an AppLocker policy, use Group Policy management software that allows you to create versions of GPOs, such as Microsoft Advanced Group Policy Management (AGPM). For more information about AGPM, see [Advanced Group Policy Management Overview](http://go.microsoft.com/fwlink/?LinkId=145013) (http://go.microsoft.com/fwlink/?LinkId=145013).

> [!CAUTION]
> You should not edit an AppLocker rule collection while it is being enforced in Group Policy. Because AppLocker controls what files are allowed to run, making changes to a live policy can create unexpected behavior.

## <a name="BKMK_AppLkr_Use_GP"></a>Maintaining AppLocker policies by using Group Policy
For every scenario, the steps to maintain an AppLocker policy distributed by Group Policy include the following tasks.

### Step 1: Understand the current behavior of the policy
Before modifying a policy, evaluate how the policy is currently implemented. For example, if a new version of the application is deployed, you can use **Test-AppLockerPolicy** to verify the effectiveness of your current policy for that application. To read the procedures necessary to understand the current behavior of the policy, see [Discovering the Effect of an AppLocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx). Updating your AppLocker planning document will help you track your findings. For information about creating this document, see [Creating Your AppLocker Planning Document](http://technet.microsoft.com/library/ee449479(WS.10).aspx). For information about **Test-AppLockerPolicy** and examples of how to use it, see [Test-AppLockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169000) (http://go.microsoft.com/fwlink/?LinkId=169000).

> [!NOTE]
> These documents apply to  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8, and  Windows 7  operating systems.

### Step 2: Export the AppLocker policy from the GPO
Updating an AppLocker policy that is currently enforced in your production environment can have unintended results. Therefore, export the policy from the GPO and update the rule or rules by using AppLocker on your AppLocker reference or test computer. To prepare an AppLocker policy for modification, see [Export an AppLocker Policy from a GPO](policies/Export-an-AppLocker-Policy-from-a-GPO.md)

### Step 3: Update the AppLocker policy by editing the appropriate AppLocker rule
After the AppLocker policy has been exported from the GPO into the AppLocker reference or test computer, or has been accessed on the local computer, the specific rules can be modified as required.

To modify AppLocker rules, see the following:

-   [Edit AppLocker Rules](rules/Edit-AppLocker-Rules.md)

-   [Merge AppLocker Policies by Using Set-ApplockerPolicy](policies/Merge-AppLocker-Policies-by-Using-Set-ApplockerPolicy.md) or [Merge AppLocker Policies Manually](policies/Merge-AppLocker-Policies-Manually.md)

-   [Delete an AppLocker Rule](rules/Delete-an-AppLocker-Rule.md)

-   [Enforce AppLocker Rules](rules/Enforce-AppLocker-Rules.md)

### Step 4: Test the AppLocker policy
You should test each collection of rules to ensure that the rules perform as intended. (Because AppLocker rules are inherited from linked GPOs, you should deploy all rules for simultaneous testing in all test GPOs.) For steps to perform this testing, see [Test and Update an AppLocker Policy](Test-and-Update-an-AppLocker-Policy.md).

### Step 5: Import the AppLocker policy into the GPO
After testing, import the AppLocker policy back into the GPO for implementation. To update the GPO with a modified AppLocker policy, see [Import an AppLocker Policy into a GPO](policies/Import-an-AppLocker-Policy-into-a-GPO.md).

### Step 6: Monitor the resulting policy behavior
After deploying a policy, evaluate the policy's effectiveness.  For steps to understand the new behavior of the policy, see [Discovering the Effect of an AppLocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx).

## <a name="BKMK_AppLkr_Use_LocSnapin"></a>Maintaining AppLocker policies by using the Local Security Policy snap-in
For every scenario, the steps to maintain an AppLocker policy by using the Local Group Policy Editor or the Local Security Policy snap-in include the following tasks.

### Step 1: Understand the current behavior of the policy
Before modifying a policy, evaluate how the policy is currently implemented. To read the procedures necessary to understand the current behavior of the policy, see [Monitor Application Usage with AppLocker](Monitor-Application-Usage-with-AppLocker.md). Updating your AppLocker planning document will help you track your findings. For information about creating this document, see [Creating Your AppLocker Planning Document](http://technet.microsoft.com/library/ee449479(WS.10).aspx).

> [!NOTE]
> The AppLocker Planning Guide applies to  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8 and  Windows 7 .

### Step 2: Update the AppLocker policy by modifying the appropriate AppLocker rule
Rules are grouped into a collection, which can have the policy enforcement setting applied to it. By default, AppLocker rules do not allow users to open or run any files that are not specifically allowed.

To modify AppLocker rules, see the appropriate topic listed on [Administer AppLocker](Administer-AppLocker.md).

### Step 3: Test the AppLocker policy
You should test each collection of rules to ensure that the rules perform as intended. For steps to perform this testing, see [Test and Update an AppLocker Policy](Test-and-Update-an-AppLocker-Policy.md).

### Step 4: Deploy the policy with the modified rule
You can export and then import AppLocker policies to deploy the policy to other computers running Windows 8 or  Windows Server 2012 . To perform this task, see [Export an AppLocker Policy to an XML File](policies/Export-an-AppLocker-Policy-to-an-XML-File.md) and [Import an AppLocker Policy from Another Computer](policies/Import-an-AppLocker-Policy-from-Another-Computer.md).

### Step 5: Monitor the resulting policy behavior
After deploying a policy, evaluate the policy's effectiveness.  For steps to understand the new behavior of the policy, see Discovering the Effect of an AppLocker Policy in [Discovering the Effect of an AppLocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx).

> [!NOTE]
> This topic applies to  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8 and  Windows 7 .

## Additional resources

-   For steps to perform other AppLocker policy tasks, see [Administer AppLocker](Administer-AppLocker.md).

## See Also
[AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)


