---
title: Administer applocker
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
# Administer applocker
This topic provides links to specific procedures to use when administering applocker policies and rules in those operating system versions designated in the **Applies To** list at the beginning of this topic.

applocker helps administrators control how users can access and use files, such as executable files, packaged apps, scripts, Windows Installer files, and DLLs. Using applocker, you can:

-   Define rules based on file attributes derived from the digital signature, including the publisher, product name, file name, and file version. For example, you can create rules based on the publisher attribute that is persistent through updates, or you can create rules for a specific version of a file.

-   Assign a rule to a security group or an individual user.

-   Create exceptions to rules. For example, you can create a rule that allows all Windows processes to run except Registry Editor \(Regedit.exe\).

-   Use audit\-only mode to deploy the policy and understand its impact before enforcing it.

-   Import and export rules. The import and export affects the entire policy. For example, if you export a policy, all of the rules from all of the rule collections are exported, including the enforcement settings for the rule collections. If you import a policy, the existing policy is overwritten.

-   Simplify creating and managing applocker rules by using applocker PowerShell cmdlets.

> [!NOTE]
> For more information about enhanced capabilities of applocker to control Windows apps, see [Packaged Apps and Packaged App Installer Rules in applocker](Packaged-Apps-and-Packaged-App-Installer-Rules-in-applocker.md).

The following topics are included to administer applocker:

-   [Maintain applocker Policies]()

-   [Edit an applocker Policy]()

-   [Test and Update an applocker Policy]()

-   [Deploy applocker Policies by Using the Enforce Rules Setting]()

-   [Use the applocker Windows PowerShell Cmdlets]()

-   [Optimize applocker Performance]()

-   [Monitor Application Usage with applocker]()

-   [Use applocker and Software Restriction Policies in the Same Domain]()

-   [Manage Packaged Apps with applocker]()

-   **How to work with policies**

    -   [Configure an applocker Policy for Audit Only]()

    -   [Configure an applocker Policy for Enforce Rules]()

    -   [Display a Custom URL Message When Users Try to Run a Blocked Application]()

    -   [Export an applocker Policy from a GPO]()

    -   [Export an applocker Policy to an XML File]()

    -   [Import an applocker Policy from Another Computer]()

    -   [Import an applocker Policy into a GPO]()

    -   [Merge applocker Policies by Using Set-applockerPolicy]()

    -   [Merge applocker Policies Manually]()

    -   [Refresh an applocker Policy]()

    -   [Test an applocker Policy by Using Test-applockerPolicy]()

-   **How to work with rules**

    -   [Create a Rule That Uses a File Hash Condition]()

    -   [Create a Rule That Uses a Path Condition]()

    -   [Create a Rule That Uses a Publisher Condition]()

    -   [Create applocker Default Rules]()

    -   [Configure Exceptions for an applocker Rule]()

    -   [Create a Rule for Packaged Apps]()

    -   [Delete an applocker Rule]()

    -   [Edit applocker Rules]()

    -   [Enable the DLL Rule Collection]()

    -   [Enforce applocker Rules]()

    -   [Run the Automatically Generate Rules Wizard]()

## <a name="BKMK_Using_Snapins"></a>Using the MMC snap\-ins to administer applocker
You can administer applocker policies by using the Group Policy Management Console to create or edit a Group Policy Object \(GPO\), or to create or edit an applocker policy on a local computer by using the Local Group Policy Editor snap\-in or the Local Security Policy snap\-in.

### Administer applocker using Group Policy
You must have Edit Setting permission to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission. Also, the Group Policy Management feature must be installed on the computer.

1.  On the **Start** screen, type**gpmc.msc** or open the Group Policy Management Console \(GPMC\).

2.  Locate the GPO that contains the applocker policy to modify, right\-click the GPO, and click **Edit**.

3.  In the console tree, double\-click **Application Control Policies**, double\-click **applocker**, and then click the rule collection that you want to create the rule for.

### Administer applocker on the local computer

1.  On the **Start** screen, type**secpol.msc** or **gpedit.msc**.

2.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3.  In the console tree of the snap\-in, double\-click **Application Control Policies**, double\-click **applocker**, and then click the rule collection that you want to create the rule for.

## Using Windows PowerShell to administer applocker
For how\-to information about administering applocker with Windows PowerShell, see [Use the applocker Windows PowerShell Cmdlets](). For reference information and examples how to administer applocker with Windows PowerShell, see the [applocker PowerShell Command Reference](http://technet.microsoft.com/library/ee424349(WS.10).aspx).


