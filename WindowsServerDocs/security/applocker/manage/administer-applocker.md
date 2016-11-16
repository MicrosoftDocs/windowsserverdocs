---
title: Administer AppLocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fdf79e90-8318-41cc-8601-8bf83726b93f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Administer AppLocker

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic provides links to specific procedures to use when administering AppLocker policies and rules in those operating system versions designated in the **Applies To** list at the beginning of this topic.

AppLocker helps administrators control how users can access and use files, such as executable files, packaged apps, scripts, Windows Installer files, and DLLs. Using AppLocker, you can:

-   Define rules based on file attributes derived from the digital signature, including the publisher, product name, file name, and file version. For example, you can create rules based on the publisher attribute that is persistent through updates, or you can create rules for a specific version of a file.

-   Assign a rule to a security group or an individual user.

-   Create exceptions to rules. For example, you can create a rule that allows all Windows processes to run except Registry Editor (Regedit.exe).

-   Use audit-only mode to deploy the policy and understand its impact before enforcing it.

-   Import and export rules. The import and export affects the entire policy. For example, if you export a policy, all of the rules from all of the rule collections are exported, including the enforcement settings for the rule collections. If you import a policy, the existing policy is overwritten.

-   Simplify creating and managing AppLocker rules by using AppLocker PowerShell cmdlets.

> [!NOTE]
> For more information about enhanced capabilities of AppLocker to control Windows apps, see [Packaged Apps and Packaged App Installer Rules in AppLocker](../../access-control/packaged-apps-and-packaged-app-installer-rules-in-applocker.md).

The following topics are included to administer AppLocker:

-   [Maintain AppLocker Policies](maintain-applocker-policies.md)

-   [Edit an AppLocker Policy](edit-an-applocker-policy.md)

-   [Test and Update an AppLocker Policy](test-and-update-an-applocker-policy.md)

-   [Deploy AppLocker Policies by Using the Enforce Rules Setting](deploy-applocker-policies-by-using-the-enforce-rules-setting.md)

-   [Use the AppLocker Windows PowerShell Cmdlets](use-the-applocker-windows-powershell-cmdlets.md)

-   [Optimize AppLocker Performance](optimize-applocker-performance.md)

-   [Monitor Application Usage with AppLocker](monitor-application-usage-with-applocker.md)

-   [Use AppLocker and Software Restriction Policies in the Same Domain](use-applocker-and-software-restriction-policies-in-the-same-domain.md)

-   [Manage Packaged Apps with AppLocker](manage-packaged-apps-with-applocker.md)

-   **How to work with policies**

    -   [Configure an AppLocker Policy for Audit Only](policies/configure-an-applocker-policy-for-audit-only.md)

    -   [Configure an AppLocker Policy for Enforce Rules](policies/configure-an-applocker-policy-for-enforce-rules.md)

    -   [Display a Custom URL Message When Users Try to Run a Blocked Application](policies/display-a-custom-url-message-when-users-try-to-run-a-blocked-application.md)

    -   [Export an AppLocker Policy from a GPO](policies/export-an-applocker-policy-from-a-gpo.md)

    -   [Export an AppLocker Policy to an XML File](policies/export-an-applocker-policy-to-an-xml-file.md)

    -   [Import an AppLocker Policy from Another Computer](policies/import-an-applocker-policy-from-another-computer.md)

    -   [Import an AppLocker Policy into a GPO](policies/import-an-applocker-policy-into-a-gpo.md)

    -   [Merge AppLocker Policies by Using Set-applockerPolicy](policies/merge-applocker-policies-by-using-set-applockerpolicy.md)

    -   [Merge AppLocker Policies Manually](policies/merge-applocker-policies-manually.md)

    -   [Refresh an AppLocker Policy](policies/refresh-an-applocker-policy.md)

    -   [Test an AppLocker Policy by Using Test-applockerPolicy](policies/test-an-applocker-policy-by-using-test-applockerpolicy.md)

-   **How to work with rules**

    -   [Create a Rule That Uses a File Hash Condition](rules/create-a-rule-that-uses-a-file-hash-condition.md)

    -   [Create a Rule That Uses a Path Condition](rules/create-a-rule-that-uses-a-path-condition.md)

    -   [Create a Rule That Uses a Publisher Condition](rules/create-a-rule-that-uses-a-publisher-condition.md)

    -   [Create AppLocker Default Rules](rules/create-applocker-default-rules.md)

    -   [Configure Exceptions for an AppLocker Rule](rules/configure-exceptions-for-an-applocker-rule.md)

    -   [Create a Rule for Packaged Apps](rules/create-a-rule-for-packaged-apps.md)

    -   [Delete an AppLocker Rule](rules/delete-an-applocker-rule.md)

    -   [Edit AppLocker Rules](rules/edit-applocker-rules.md)

    -   [Enable the DLL Rule Collection](rules/enable-the-dll-rule-collection.md)

    -   [Enforce AppLocker Rules](rules/enforce-applocker-rules.md)

    -   [Run the Automatically Generate Rules Wizard](rules/run-the-automatically-generate-rules-wizard.md)

## <a name="BKMK_Using_Snapins"></a>Using the MMC snap-ins to administer AppLocker
You can administer AppLocker policies by using the Group Policy Management Console to create or edit a Group Policy Object (GPO), or to create or edit an AppLocker policy on a local computer by using the Local Group Policy Editor snap-in or the Local Security Policy snap-in.

### Administer AppLocker using Group Policy
You must have Edit Setting permission to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission. Also, the Group Policy Management feature must be installed on the computer.

1.  On the **Start** screen, type**gpmc.msc** or open the Group Policy Management Console (GPMC).

2.  Locate the GPO that contains the AppLocker policy to modify, right-click the GPO, and click **Edit**.

3.  In the console tree, double-click **Application Control Policies**, double-click **AppLocker**, and then click the rule collection that you want to create the rule for.

### Administer AppLocker on the local computer

1.  On the **Start** screen, type**secpol.msc** or **gpedit.msc**.

2.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3.  In the console tree of the snap-in, double-click **Application Control Policies**, double-click **AppLocker**, and then click the rule collection that you want to create the rule for.

## Using Windows PowerShell to administer AppLocker
For how-to information about administering AppLocker with Windows PowerShell, see [Use the AppLocker Windows PowerShell Cmdlets](use-the-applocker-windows-powershell-cmdlets.md). For reference information and examples how to administer AppLocker with Windows PowerShell, see the [AppLocker PowerShell Command Reference](http://technet.microsoft.com/library/ee424349(WS.10).aspx).


