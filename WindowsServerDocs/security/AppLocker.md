---
title: applocker
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 40da294b-501b-4357-a047-a8ff391e0ca1
---
# applocker
This topic describes the controls on the applocker user interface to help you create and maintain application control policies by using applocker in  Windows Server 2012 R2  and Windows 8.1.

## About applocker
You can use applocker as part of your overall security strategy for the following scenarios:

-   Help prevent malicious software \(malware\) and unsupported applications from affecting computers in your environment.

-   Prevent users from installing and using unauthorized applications.

-   Implement application control policies to satisfy portions of your security policy or compliance requirements in your organization.

For more information, see [applocker Overview \[Server\]](assetId:///358610e4-88b2-40d0-b34d-dfd7ddee0ed9).

### In this topic
[Enforcement modes](#BKMK_Enforcement)

[Rule collections](#BKMK_RuleCollections)

[Rule conditions](#BKMK_RuleConditions)

[Default rules](#BKMK_DefaultRules)

[applocker rule behavior](#BKMK_Behavior)

[Rule exceptions](#BKMK_RuleExceptions)

[DLL rule collection](#BKMK_DLLRules)

[applocker wizards](#BKMK_Wizards)

[Additional considerations](#BKMK_AddConsiderations)

[Additional resources](#BKMK_AddResources)

## <a name="BKMK_Enforcement"></a>Enforcement modes
The three applocker enforcement modes are described in the following table. The enforcement mode settings that are defined here can be overwritten by a setting that is derived from a linked Group Policy Object \(GPO\) with a higher precedence.

|Enforcement mode|Description|
|--------------------|---------------|
|**Not configured**|This is the default setting, which means that the rules defined here will be enforced unless a linked GPO with a higher precedence has a different value for this setting.|
|**Enforce rules**|Rules are enforced.|
|**Audit only**|Rules are audited but not enforced. When a user runs an application that is affected by an applocker rule, the application is allowed to run, and the information about the application is added to the applocker event log. The Audit\-only enforcement mode helps you determine which applications will be affected by the policy before the policy is enforced. When the applocker policy for a rule collection is set to **Audit only**, rules for that rule collection are not enforced.|

When applocker policies from various GPOs are merged, the rules from all the GPOs are merged and the enforcement mode setting of the winning GPO is applied.

For information about GPOs and Group Policy inheritance, see the [Group Policy Planning and Deployment Guide](http://go.microsoft.com/fwlink/p/?linkid=143138).

## <a name="BKMK_RuleCollections"></a>Rule collections
The applocker user interface is accessed through the Microsoft Management Console \(MMC\), and it is organized into rule collections, which are Executable files, Scripts, Windows Installer files, Packaged apps, Packaged app installers and DLL files. These collections give the administrator an easy way to differentiate the rules for different types of applications. The following table lists the file formats that are included in each rule collection.

|Rule collection|Associated file formats|
|-------------------|---------------------------|
|Executable files|.exe<br /><br />.com|
|Scripts|.ps1<br /><br />.bat<br /><br />.cmd<br /><br />.vbs<br /><br />.js|
|Windows Installer files|.msi<br /><br />.msp<br /><br />.mst|
|Appx \(Packaged apps and Packaged app installers\)|.appx|
|DLL files|.dll<br /><br />.ocx|

> [!IMPORTANT]
> If you use DLL rules, you need to create an Allow rule for each DLL that is used by all of the allowed applications.
> 
> When DLL rules are used, applocker must check each DLL that an application loads. Therefore, users may experience a reduction in performance if DLL rules are used.
> 
> The DLL rule collection is not enabled by default. To learn how to enable the DLL rule collection, see [DLL rule collection](#BKMK_DLLRules).

## <a name="BKMK_RuleConditions"></a>Rule conditions
Rule conditions are criteria that help applocker identify the applications to which the rule applies. The three primary rule conditions are Publisher, Path, and File hash.

-   [Publisher](#BKMK_Publisher): Identifies an application based on its digital signature

-   [Path](#BKMK_Path): Identifies an application by its location in the file system of the computer or on the network

-   [File hash](#BKMK_FileHash): Represents the system\-computed cryptographic hash of the identified file

### <a name="BKMK_Publisher"></a>Publisher
This condition identifies an application based on its digital signature and extended attributes when available. The digital signature contains information about the company that created the application \(the publisher\). Executable files, DLLs, Windows installers, Packaged apps, and Packaged app installers also have extended attributes, which are obtained from the binary resource. Attributes for executable files, DLLs, and Windows installers contain the name of the product that the file is a part of, the original name of the file as supplied by the publisher, and the version number of the file. In Packaged apps and Packaged app installers, these extended attributes contain the name and the version of the application package.

> [!NOTE]
> Rules that are created in the Packaged app and Packaged app installer rule collection can only have the Publisher condition because Windows does not support unsigned Packaged apps or Packaged app installers.

> [!NOTE]
> Use a Publisher rule condition when possible because they can survive application updates in addition to a change in the location of files.

When you select a reference file for a Publisher condition, the wizard creates a rule that specifies the publisher, product, file name, and version number. You can make the rule more generic by moving the slider up or by using a wildcard character \(\*\) in the product, file name, or version number fields.

> [!NOTE]
> To enter custom values for any of the fields of a Publisher rule condition in the Create Rules Wizard, you must select the **Use custom values** check box. When this check box is selected, you cannot use the slider.

The **File version** and **Package version** control whether a user can run a specific version, earlier versions, or later versions of the application. You can choose a version number and then configure the following options:

-   **Exactly**. The rule applies only to this version of the application.

-   **And above**. The rule applies to this version and all later versions.

-   **And below**. The rule applies to this version and all earlier versions.

The following table describes how a Publisher condition is applied.

|Option|The publisher condition allows or denies…|
|----------|---------------------------------------------|
|**All signed files**|All files that are signed by a publisher.|
|**Publisher only**|All files that are signed by the named publisher.|
|**Publisher and product name**|All files for the specified product that are signed by the named publisher.|
|**Publisher and product name, and file name**|Any version of the named file or package for the named product that are signed by the publisher.|
|**Publisher, product name, file name, and file version**<br /><br />**Exactly**|The specified version of the named file or package for the named product that are signed by the publisher.|
|**Publisher, product name, file name, and file version**<br /><br />**And above**|The specified version of the named file or package and any new releases for the product that are signed by the publisher.|
|**Publisher, product name, file name, and file version**<br /><br />**And below**|The specified version of the named file or package and any earlier versions for the product that are signed by the publisher.|
|**Custom**|You can edit the **Publisher**, **Product name**, **File name**, **VersionPackage name**, and **Package version** fields to create a custom rule.|

### <a name="BKMK_Path"></a>Path
This rule condition identifies an application by its location in the file system of the computer or on the network.

applocker uses custom path variables for well\-known paths, such as **Program Files** and **Windows**.

The following table details these path variables.

|Windows directory or disk|applocker path variable|Windows environment variable|
|-----------------------------|---------------------------|--------------------------------|
|Windows|%WINDIR%|%SystemRoot%|
|System32|%SYSTEM32%|%SystemDirectory%|
|Windows installation directory|%OSDRIVE%|%SystemDrive%|
|Program Files|%PROGRAMFILES%|%ProgramFiles% and<br /><br />%ProgramFiles\(x86\)%|
|Removable media \(for example, a CD or DVD\)|%REMOVABLE%||
|Removable storage device \(for example, a USB flash drive\)|%HOT%||

> [!IMPORTANT]
> Because a Path rule condition can be configured to include a large number of folders and files, Path conditions should be carefully planned. For example, if an Allow rule with a Path condition includes a folder location where non\-administrators are allowed to write data, a user can copy unapproved files into that location and run the files. For this reason, it is a best practice to not create path conditions for standard user writable locations, such as a user profile.

### <a name="BKMK_FileHash"></a>File hash
When you choose the File hash rule condition, the system computes a cryptographic hash of the identified file. The advantage of this rule condition is that because each file has a unique hash, a File hash rule condition applies to only one file. The disadvantage is that each time the file is updated \(such as a security update or upgrade\) the file's hash will change. As a result, you must manually update File hash rules.

## <a name="BKMK_DefaultRules"></a>Default rules
applocker allows you to generate default rules for each rule collection.

Executable default rule types include:

-   Allow members of the local **Administrators** group to run all applications.

-   Allow members of the **Everyone** group to run applications that are located in the **Windows** folder.

-   Allow members of the **Everyone** group to run applications that are located in the **Program Files** folder.

Script default rule types include:

-   Allow members of the local **Administrators** group to run all scripts.

-   Allow members of the **Everyone** group to run scripts that are located in the **Windows** folder.

-   Allow members of the **Everyone** group to run scripts that are located in the **Program Files** folder.

Windows Installer default rule types include:

-   Allow members of the local **Administrators** group to run all Windows Installer files.

-   Allow members of the **Everyone** group to run all digitally signed Windows Installer files.

-   Allow members of the **Everyone** group to run all Windows Installer files that are located in the Windows\\Installer folder.

DLL default rule types:

-   Allow members of the local **Administrators** group to run all DLLs.

-   Allow members of the **Everyone** group to run DLLs that are located in the **Windows** folder.

-   Allow members of the **Everyone** group to run DLLs that are located in the **Program Files** folder.

The Packaged app default rule types:

-   Allow members of the **Everyone** group to install and run all signed Packaged apps and Packaged app installers.

## <a name="BKMK_Behavior"></a>applocker rule behavior
If no applocker rules for a specific rule collection exist, all files with that file format are allowed to run. However, when an applocker rule for a specific rule collection is created, only the files explicitly allowed in a rule are permitted to run. For example, if you create an executable rule that allows .exe files in *%SystemDrive%\\FilePath* to run, only executable files located in that path are allowed to run.

A rule can be configured to use allow or deny actions:

-   **Allow**. You can specify which files are allowed to run in your environment, and for which users or groups of users. You can also configure exceptions to identify files that are excluded from the rule.

-   **Deny**. You can specify which files are not allowed to run in your environment, and for which users or groups of users. You can also configure exceptions to identify files that are excluded from the rule.

> [!IMPORTANT]
> For a best practice, use Allow actions with exceptions. You can use a combination of Allow and Deny actions, but Deny actions override Allow actions in all cases, and combined actions can be circumvented.

> [!IMPORTANT]
> If you want to allow any Packaged apps in your environment while continuing to control executables, you should create default rules for Packaged apps and set the enforcement mode to Audit\-only for the Packaged app rule collection.

## <a name="BKMK_RuleExceptions"></a>Rule exceptions
You can apply applocker rules to individual users or to a group of users. If you apply a rule to a group of users, all users in that group are affected by that rule. If you need to allow a subset of a user group to use an application, you can create a special rule for that subset. For example, the rule "Allow Everyone to run Windows except Registry Editor" allows everyone in the organization to run the Windows operating system, but it does not allow anyone to run Registry Editor.

The effect of this rule would prevent users such as Help Desk personnel from running a program that is necessary for their support tasks. To resolve this problem, create a second rule that applies to the Help Desk user group: "Allow Help Desk to run Registry Editor." If you create a Deny rule that does not allow any users to run Registry Editor, the Deny rule will override the second rule that allows the Help Desk user group to run Registry Editor.

## <a name="BKMK_DLLRules"></a>DLL rule collection
Because the DLL rule collection is not enabled by default, you must perform the following procedure before you can create and enforce DLL rules.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

#### To enable the DLL rule collection

1.  On the **Start** screen, click the **Apps** arrow. On the **Apps** screen, type**secpol.msc**, and then press ENTER.

2.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3.  In the console tree, double\-click **Application Control Policies**, right\-click **applocker**, and then click **Properties**.

4.  Click the **Advanced** tab, select the **Enable the DLL rule collection** check box, and then click **OK**.

    > [!IMPORTANT]
    > Before you enforce DLL rules, make sure that there are Allow rules for each DLL that is used by any of the allowed applications.

## <a name="BKMK_Wizards"></a>applocker wizards
You can create rules by using two applocker wizards:

1.  The Create Rules Wizard enables you to create one rule at a time.

2.  The Automatically Generate Rules Wizard allows you to create multiple rules at one time. You can select a folder and let the wizard create rules for the relevant files within that folder, or in case of Packaged apps, you can let the wizard create rules for all Packaged apps that are installed on the computer. You can also specify the user or group to which to apply the rules. This wizard automatically generates Allow rules only.

## <a name="BKMK_AddConsiderations"></a>Additional considerations

-   By default, applocker rules do not allow users to open or run any files that are not specifically allowed. Administrators should maintain an up\-to\-date list of allowed applications.

-   There are two types of applocker conditions that do not persist following an update of an application:

    -   **File hash condition**. File hash rule conditions can be used with any application because a cryptographic hash value of the application is generated at the time the rule is created. However, the hash value is specific to that exact version of the application. If there are several versions of the application in use within the organization, you need to create file hash conditions for each version in use and for any new versions that are released.

    -   **A publisher condition with a specific product version set**. If you create a publisher rule condition that uses the **Exactly** version option, the rule cannot persist if a new version of the application is installed. A new publisher condition must be created, or the version must be edited in the rule to be made less specific.

-   If an application is not digitally signed, you cannot use a Publisher rule condition for that application.

-   applocker rules cannot be used to manage computers running a Windows operating system earlier than  Windows Server 2008 R2  or  Windows 7 . Software Restriction Policies must be used instead. If applocker rules are defined in a Group Policy Object \(GPO\), only those rules are applied. To ensure interoperability between Software Restriction Policies rules and applocker rules, define Software Restriction Policies rules and applocker rules in different GPOs.

-   The Packaged app and Packaged app installer rule collection is not available in  Windows Server 2008 R2  or  Windows 7 .

-   When the rules for the executable rule  collection are enforced and the Packaged app and Packaged app installer rule collection does not contain any rules, no Packaged apps or Packaged app installers are allowed to run. To allow Packaged apps or Packaged app installers, you must create rules for the Packaged app and Packaged app installer rule collection.

-   When an applocker rule collection is set to **Audit only**, the rules are not enforced. When a user runs an application that is included in the rule, the application is opened and runs normally, and information about that application is added to the applocker event log.

-   A custom configured URL can be included in the message that is displayed when an application is blocked.

> [!NOTE]
> Expect an increase in the number of Help Desk calls initially because of blocked applications until users understand that they cannot run applications that are not allowed.

## <a name="BKMK_AddResources"></a>Additional resources
The following table lists and describes resources for you to manage security policies using applocker.

|Resource|Windows Server 2008 R2 and Windows 7| Windows Server 2012 R2 ,  Windows Server 2012 , Windows 8.1 and Windows 8|
|------------|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Product evaluation|[Frequently Asked Questions](http://technet.microsoft.com/library/ee619725(WS.10).aspx)<br /><br />[applocker Step\-by\-Step Guide](http://technet.microsoft.com/library/dd723686(WS.10).aspx)|[Frequently Asked Questions](http://technet.microsoft.com/library/ee619725(WS.10).aspx)<br /><br />[applocker Step\-by\-Step Guide](http://technet.microsoft.com/library/dd723686(WS.10).aspx)|
|Procedures|[applocker Operations Guide](http://technet.microsoft.com/library/ee791916(WS.10).aspx)|[Administer applocker](applocker/administer-applocker.md)<br /><br />[Manage Packaged Apps with applocker](applocker/manage/administer-applocker/manage-packaged-apps-with-applocker.md)|
|Scripting|[Using the applocker Windows PowerShell Cmdlets](http://technet.microsoft.com/library/ee791828(WS.10).aspx)|[Using the applocker Windows PowerShell Cmdlets](http://technet.microsoft.com/library/ee791828(WS.10).aspx)|
|Technical content|[applocker Technical Reference](http://technet.microsoft.com/library/ee844115(v=WS.10).aspx)|[applocker Technical Reference](http://technet.microsoft.com/library/ee844115(v=WS.10).aspx)|
|Design, planning, and deployment|[applocker Policies Design Guide](http://technet.microsoft.com/library/ee449480(WS.10).aspx)<br /><br />[applocker Policies Deployment Guide](http://technet.microsoft.com/library/ee791890(WS.10).aspx)|[applocker Policies Design Guide](http://technet.microsoft.com/library/ee449480(WS.10).aspx)<br /><br />[applocker Policies Deployment Guide](http://technet.microsoft.com/library/ee791890(WS.10).aspx)|
|General information and additional resources|[applocker Documentation for Windows 7 and Windows Server 2008 R2](http://technet.microsoft.com/library/dd723678(v=WS.10).aspx)|[applocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)|


