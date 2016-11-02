---
title: Administer applocker
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
# Administer applocker

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic provides links to specific procedures to use when administering applocker policies and rules in those operating system versions designated in the **Applies To** list at the beginning of this topic.

applocker helps administrators control how users can access and use files, such as executable files, packaged apps, scripts, Windows Installer files, and DLLs. Using applocker, you can:

-   Define rules based on file attributes derived from the digital signature, including the publisher, product name, file name, and file version. For example, you can create rules based on the publisher attribute that is persistent through updates, or you can create rules for a specific version of a file.

-   Assign a rule to a security group or an individual user.

-   Create exceptions to rules. For example, you can create a rule that allows all Windows processes to run except Registry Editor (Regedit.exe).

-   Use audit-only mode to deploy the policy and understand its impact before enforcing it.

-   Import and export rules. The import and export affects the entire policy. For example, if you export a policy, all of the rules from all of the rule collections are exported, including the enforcement settings for the rule collections. If you import a policy, the existing policy is overwritten.

-   Simplify creating and managing applocker rules by using applocker PowerShell cmdlets.

> [!NOTE]
> For more information about enhanced capabilities of applocker to control Windows apps, see [Packaged Apps and Packaged App Installer Rules in applocker](../../access-control/packaged-apps-and-packaged-app-installer-rules-in-applocker.md).

The following topics are included to administer applocker:

-   [Maintain applocker Policies](maintain-applocker-policies.md)

-   [Edit an applocker Policy](edit-an-applocker-policy.md)

-   [Test and Update an applocker Policy](test-and-update-an-applocker-policy.md)

-   [Deploy applocker Policies by Using the Enforce Rules Setting](deploy-applocker-policies-by-using-the-enforce-rules-setting.md)

-   [Use the applocker Windows PowerShell Cmdlets](use-the-applocker-windows-powershell-cmdlets.md)

-   [Optimize applocker Performance](optimize-applocker-performance.md)

-   [Monitor Application Usage with applocker](monitor-application-usage-with-applocker.md)

-   [Use applocker and Software Restriction Policies in the Same Domain](use-applocker-and-software-restriction-policies-in-the-same-domain.md)

-   [Manage Packaged Apps with applocker](manage-packaged-apps-with-applocker.md)

-   **How to work with policies**

    -   [Configure an applocker Policy for Audit Only](policies/configure-an-applocker-policy-for-audit-only.md)

    -   [Configure an applocker Policy for Enforce Rules](policies/configure-an-applocker-policy-for-enforce-rules.md)

    -   [Display a Custom URL Message When Users Try to Run a Blocked Application](policies/display-a-custom-url-message-when-users-try-to-run-a-blocked-application.md)

    -   [Export an applocker Policy from a GPO](policies/export-an-applocker-policy-from-a-gpo.md)

    -   [Export an applocker Policy to an XML File](policies/export-an-applocker-policy-to-an-xml-file.md)

    -   [Import an applocker Policy from Another Computer](policies/import-an-applocker-policy-from-another-computer.md)

    -   [Import an applocker Policy into a GPO](policies/import-an-applocker-policy-into-a-gpo.md)

    -   [Merge applocker Policies by Using Set-applockerPolicy](policies/merge-applocker-policies-by-using-set-applockerpolicy.md)

    -   [Merge applocker Policies Manually](policies/merge-applocker-policies-manually.md)

    -   [Refresh an applocker Policy](policies/refresh-an-applocker-policy.md)

    -   [Test an applocker Policy by Using Test-applockerPolicy](policies/test-an-applocker-policy-by-using-test-applockerpolicy.md)

-   **How to work with rules**

    -   [Create a Rule That Uses a File Hash Condition](rules/create-a-rule-that-uses-a-file-hash-condition.md)

    -   [Create a Rule That Uses a Path Condition](rules/create-a-rule-that-uses-a-path-condition.md)

    -   [Create a Rule That Uses a Publisher Condition](rules/create-a-rule-that-uses-a-publisher-condition.md)

    -   [Create applocker Default Rules](rules/create-applocker-default-rules.md)

    -   [Configure Exceptions for an applocker Rule](rules/configure-exceptions-for-an-applocker-rule.md)

    -   [Create a Rule for Packaged Apps](rules/create-a-rule-for-packaged-apps.md)

    -   [Delete an applocker Rule](rules/delete-an-applocker-rule.md)

    -   [Edit applocker Rules](rules/edit-applocker-rules.md)

    -   [Enable the DLL Rule Collection](rules/enable-the-dll-rule-collection.md)

    -   [Enforce applocker Rules](rules/enforce-applocker-rules.md)

    -   [Run the Automatically Generate Rules Wizard](rules/run-the-automatically-generate-rules-wizard.md)

## <a name="BKMK_Using_Snapins"></a>Using the MMC snap-ins to administer applocker
You can administer applocker policies by using the Group Policy Management Console to create or edit a Group Policy Object (GPO), or to create or edit an applocker policy on a local computer by using the Local Group Policy Editor snap-in or the Local Security Policy snap-in.

### Administer applocker using Group Policy
You must have Edit Setting permission to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission. Also, the Group Policy Management feature must be installed on the computer.

1.  On the **Start** screen, type**gpmc.msc** or open the Group Policy Management Console (GPMC).

2.  Locate the GPO that contains the applocker policy to modify, right-click the GPO, and click **Edit**.

3.  In the console tree, double-click **Application Control Policies**, double-click **applocker**, and then click the rule collection that you want to create the rule for.

### Administer applocker on the local computer

1.  On the **Start** screen, type**secpol.msc** or **gpedit.msc**.

2.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3.  In the console tree of the snap-in, double-click **Application Control Policies**, double-click **applocker**, and then click the rule collection that you want to create the rule for.

## Using Windows PowerShell to administer applocker
For how-to information about administering applocker with Windows PowerShell, see [Use the applocker Windows PowerShell Cmdlets](use-the-applocker-windows-powershell-cmdlets.md). For reference information and examples how to administer applocker with Windows PowerShell, see the [applocker PowerShell Command Reference](http://technet.microsoft.com/library/ee424349(WS.10).aspx).


