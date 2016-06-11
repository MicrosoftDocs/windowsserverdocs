---
title: Administer AppLocker
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fdf79e90-8318-41cc-8601-8bf83726b93f
---
# Administer AppLocker
This topic provides links to specific procedures to use when administering AppLocker policies and rules in those operating system versions designated in the **Applies To** list at the beginning of this topic.

AppLocker helps administrators control how users can access and use files, such as executable files, packaged apps, scripts, Windows Installer files, and DLLs. Using AppLocker, you can:

-   Define rules based on file attributes derived from the digital signature, including the publisher, product name, file name, and file version. For example, you can create rules based on the publisher attribute that is persistent through updates, or you can create rules for a specific version of a file.

-   Assign a rule to a security group or an individual user.

-   Create exceptions to rules. For example, you can create a rule that allows all Windows processes to run except Registry Editor \(Regedit.exe\).

-   Use audit\-only mode to deploy the policy and understand its impact before enforcing it.

-   Import and export rules. The import and export affects the entire policy. For example, if you export a policy, all of the rules from all of the rule collections are exported, including the enforcement settings for the rule collections. If you import a policy, the existing policy is overwritten.

-   Simplify creating and managing AppLocker rules by using AppLocker PowerShell cmdlets.

> [!NOTE]
> For more information about enhanced capabilities of AppLocker to control Windows apps, see [Packaged Apps and Packaged App Installer Rules in AppLocker](Packaged-Apps-and-Packaged-App-Installer-Rules-in-AppLocker.md).

The following topics are included to administer AppLocker:

-   [Maintain AppLocker Policies]()

-   [Edit an AppLocker Policy]()

-   [Test and Update an AppLocker Policy]()

-   [Deploy AppLocker Policies by Using the Enforce Rules Setting]()

-   [Use the AppLocker Windows PowerShell Cmdlets]()

-   [Optimize AppLocker Performance]()

-   [Monitor Application Usage with AppLocker]()

-   [Use AppLocker and Software Restriction Policies in the Same Domain]()

-   [Manage Packaged Apps with AppLocker]()

-   **How to work with policies**

    -   [Configure an AppLocker Policy for Audit Only]()

    -   [Configure an AppLocker Policy for Enforce Rules]()

    -   [Display a Custom URL Message When Users Try to Run a Blocked Application]()

    -   [Export an AppLocker Policy from a GPO]()

    -   [Export an AppLocker Policy to an XML File]()

    -   [Import an AppLocker Policy from Another Computer]()

    -   [Import an AppLocker Policy into a GPO]()

    -   [Merge AppLocker Policies by Using Set-ApplockerPolicy]()

    -   [Merge AppLocker Policies Manually]()

    -   [Refresh an AppLocker Policy]()

    -   [Test an AppLocker Policy by Using Test-AppLockerPolicy]()

-   **How to work with rules**

    -   [Create a Rule That Uses a File Hash Condition]()

    -   [Create a Rule That Uses a Path Condition]()

    -   [Create a Rule That Uses a Publisher Condition]()

    -   [Create AppLocker Default Rules]()

    -   [Configure Exceptions for an AppLocker Rule]()

    -   [Create a Rule for Packaged Apps]()

    -   [Delete an AppLocker Rule]()

    -   [Edit AppLocker Rules]()

    -   [Enable the DLL Rule Collection]()

    -   [Enforce AppLocker Rules]()

    -   [Run the Automatically Generate Rules Wizard]()

## <a name="BKMK_Using_Snapins"></a>Using the MMC snap\-ins to administer AppLocker
You can administer AppLocker policies by using the Group Policy Management Console to create or edit a Group Policy Object \(GPO\), or to create or edit an AppLocker policy on a local computer by using the Local Group Policy Editor snap\-in or the Local Security Policy snap\-in.

### Administer Applocker using Group Policy
You must have Edit Setting permission to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission. Also, the Group Policy Management feature must be installed on the computer.

1.  On the **Start** screen, type**gpmc.msc** or open the Group Policy Management Console \(GPMC\).

2.  Locate the GPO that contains the AppLocker policy to modify, right\-click the GPO, and click **Edit**.

3.  In the console tree, double\-click **Application Control Policies**, double\-click **AppLocker**, and then click the rule collection that you want to create the rule for.

### Administer AppLocker on the local computer

1.  On the **Start** screen, type**secpol.msc** or **gpedit.msc**.

2.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3.  In the console tree of the snap\-in, double\-click **Application Control Policies**, double\-click **AppLocker**, and then click the rule collection that you want to create the rule for.

## Using Windows PowerShell to administer AppLocker
For how\-to information about administering AppLocker with Windows PowerShell, see [Use the AppLocker Windows PowerShell Cmdlets](). For reference information and examples how to administer AppLocker with Windows PowerShell, see the [AppLocker PowerShell Command Reference](http://technet.microsoft.com/library/ee424349(WS.10).aspx).


