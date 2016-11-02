---
title: Working with AppLocker Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd7104a3-a4ba-43bf-8641-f4ad318939cd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Working with AppLocker Rules

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

## Procedures

-   [Create a Rule That Uses a File Hash Condition](create-a-rule-that-uses-a-file-hash-condition.md)

-   [Create a Rule That Uses a Path Condition](create-a-rule-that-uses-a-path-condition.md)

-   [Create a Rule That Uses a Publisher Condition](create-a-rule-that-uses-a-publisher-condition.md)

-   [Create a Rule for Packaged Apps](create-a-rule-for-packaged-apps.md)

-   [Create AppLocker Default Rules](create-applocker-default-rules.md)

-   [Configure Exceptions for an AppLocker Rule](configure-exceptions-for-an-applocker-rule.md)

-   [Delete an AppLocker Rule](delete-an-applocker-rule.md)

-   [Edit AppLocker Rules](edit-applocker-rules.md)

-   [Enable the DLL Rule Collection](enable-the-dll-rule-collection.md)

-   [Enforce AppLocker Rules](enforce-applocker-rules.md)

-   [Run the Automatically Generate Rules Wizard](run-the-automatically-generate-rules-wizard.md)

The three AppLocker enforcement modes are described in the following table. The enforcement mode setting defined here can be overwritten by the setting derived from a linked Group Policy Object \(GPO\) with a higher precedence.

-   Not Configured

    This is the default setting which means that the rules defined here will be enforced unless a linked GPO with a higher precedence has a different value for this setting

-   Enforce Rules

    Rules are enforced.

-   Audit

    Rules are audited but not enforced. When a user runs an application that is affected by an AppLocker rule, the application is allowed to run and the information about the application is added to the AppLocker event log. The Audit\-only enforcement mode helps you determine which applications will be affected by the policy before the policy is enforced. When the AppLocker policy for a rule collection is set to Audit only, rules for that rule collection are not enforced

When AppLocker policies from various GPOs are merged, the rules from all the GPOs are merged and the enforcement mode setting of the winning GPO is applied.

For information about GPOs and Group Policy inheritance, see the Group Policy Planning and Deployment Guide [http:\/\/go.microsoft.com\/fwlink\/p\/?linkid\=143138](http://go.microsoft.com/fwlink/p/?linkid=143138).

## Rule collections
The AppLocker user interface is accessed through the Microsoft Management Console \(MMC\), and it is organized into rule collections, which are Executable files, Scripts, Windows Installer files, Packaged apps and packaged app installers, and DLL files. These collections give the administrator an easy way to differentiate the rules for different types of applications. The following  lists the file formats that are included in each rule collection.

-   Executable Files: \(.exe; .com\)

-   Scripts \(.ps1; .bat; .cmd; .vbs; .js\)

-   Windows Installer files \(.msi; .msp; .mst\)

-   Packaged apps and packaged app installers \(.appx\)

-   DLL files \(.dll; .ocx\)

> [!IMPORTANT]
> If you use DLL rules, you need to create an allow rule for each DLL that is used by all of the allowed applications.
> 
> When DLL rules are used, AppLocker must check each DLL that an application loads. Therefore, users may experience a reduction in performance if DLL rules are used.
> 
> The DLL rule collection is not enabled by default. To learn how to enable the DLL rule collection, see [DLL rule collection](#BKMK_DLLruleCollections).

## Rule conditions
Rule conditions are criteria that help AppLocker identify the applications to which the rule applies. The three primary rule conditions are publisher, path, and file hash.

-   [Publisher](#BKMK_Publisher): Identifies an application based on its digital signature

-   [Path](#BKMK_Path): Identifies an application by its location in the file system of the computer or on the network

-   [File hash](#BKMK_FileHash): Represents the system computed cryptographic hash of the identified file

### <a name="BKMK_Publisher"></a>Publisher
This condition identifies an application based on its digital signature and extended attributes when available. The digital signature contains information about the company that created the application \(the publisher\). Executable files, Dlls, Windows installers, packaged apps and packaged app installers also have extended attributes, which are obtained from the binary resource. In case of Executable files, Dlls and Windows installers these attributes contain the name of the product that the file is a part of, the original name of the file as supplied by the publisher and the version number of the file. In case of packaged apps and packaged app installers these extended attributes contain the name and the version of the application package.

> [!NOTE]
> Rules created in the packaged apps and packaged app installers rule collection can only have publisher conditions since Windows does not support unsigned packaged apps and packaged app installers.

> [!NOTE]
> Use a publisher rule condition when possible because they can survive application updates as well as a change in the location of files.

When you select a reference file for a publisher condition, the wizard creates a rule that specifies the publisher, product, file name, and version number. You can make the rule more generic by moving the slider up or by using a wildcard character \(\*\) in the product, file name, or version number fields.

> [!NOTE]
> To enter custom values for any of the fields of a publisher rule condition in the Create Rules Wizard, you must select the **Use custom values** check box. When this check box is selected, you cannot use the slider.

The **File version** and **Package version** control whether a user can run a specific version, earlier versions, or later versions of the application. You can choose a version number and then configure the following options:

-   **Exactly.** The rule applies only to this version of the application.

-   **And above.** The rule applies to this version and all later versions.

-   **And below.** The rule applies to this version and all earlier versions.

The following describes how a publisher condition is applied.

-   All signed files: All files that are signed by any publisher.

-   Publisher only: All files that are signed by the named publisher.

-   Publisher and product name: All files for the specified product that are signed by the named publisher.

-   Publisher and product name, and file name: Any version of the named file or package for the named product that are signed by the publisher.

-   Publisher, product name, file name, and file version
                      \-\-Exactly\-\-: The specified version of the named file or package for the named product that are signed by the publisher.

-   Publisher, product name, file name, and file version
                      \-\-And Above\-\-: The specified version of the named file or package and any new releases for the product that are signed by the publisher.

-   Publisher, product name, file name, and file version
                      \-\-And Below\-\-: The specified version of the named file or package and any earlier versions for the product that are signed by the publisher.

-   Custom: You can edit the Publisher, Product name, File name, Version Package name, and Package version fields to create a custom rule.

### <a name="BKMK_Path"></a>Path
This rule condition identifies an application by its location in the file system of the computer or on the network.

AppLocker uses custom path variables for well\-known paths, such as Program Files and Windows.

The following table details these path variables.

|Windows directory or disk|AppLocker path variable|Windows environment variable|
|---------------|--------------|----------------|
|Windows|%WINDIR%|%SystemRoot%|
|System32|%SYSTEM32%|%SystemDirectory%|
|Windows installation directory|%OSDRIVE%|%SystemDrive%|
|Program Files|%PROGRAMFILES%|%ProgramFiles% and<br /><br />%ProgramFiles\(x86\)%|
|Removable media \(for example, a CD or DVD\)|%REMOVABLE%||
|Removable storage device \(for example, a USB flash drive\)|%HOT%||

> [!IMPORTANT]
> Because a path rule condition can be configured to include a large number of folders and files, path conditions should be carefully planned. For example, if an allow rule with a path condition includes a folder location that non\-administrators are allowed to write data into, a user can copy unapproved files into that location and run the files. For this reason, it is a best practice to not create path conditions for standard user writable locations, such as a user profile.

### <a name="BKMK_FileHash"></a>File hash
When you choose the file hash rule condition, the system computes a cryptographic hash of the identified file. The advantage of this rule condition is that because each file has a unique hash, a file hash rule condition applies to only one file. The disadvantage is that each time the file is updated \(such as a security update or upgrade\) the file's hash will change. As a result, you must manually update file hash rules.

## AppLocker default rules
AppLocker allows you to generate default rules for each rule collection.

Executable default rule types include:

-   Allow members of the local **Administrators** group to run all applications.

-   Allow members of the **Everyone** group to run applications that are located in the Windows folder.

-   Allow members of the **Everyone** group to run applications that are located in the Program Files folder.

Script default rule types include:

-   Allow members of the local **Administrators** group to run all scripts.

-   Allow members of the **Everyone** group to run scripts that are located in the Program Files folder.

-   Allow members of the **Everyone** group to run scripts that are located in the Windows folder.

Windows Installer default rule types include:

-   Allow members of the local **Administrators** group to run all Windows Installer files.

-   Allow members of the **Everyone** group to run all digitally signed Windows Installer files.

-   Allow members of the **Everyone** group to run all Windows Installer files that are located in the Windows\\Installer folder.

DLL default rule types:

-   Allow members of the local **Administrators** group to run all DLLs.

-   Allow members of the **Everyone** group to run DLLs that are located in the Program Files folder.

-   Allow members of the **Everyone** group to run DLLs that are located in the Windows folder.

Packaged apps default rule types:

-   Allow members of the **Everyone** group to install and run all signed packaged apps and packaged app installers.

## AppLocker rule behavior
If no AppLocker rules for a specific rule collection exist, all files with that file format are allowed to run. However, when an AppLocker rule for a specific rule collection is created, only the files explicitly allowed in a rule are permitted to run. For example, if you create an executable rule that allows .exe files in *%SystemDrive%\\FilePath* to run, only executable files located in that path are allowed to run.

A rule can be configured to use allow or deny actions:

-   **Allow.** You can specify which files are allowed to run in your environment, and for which users or groups of users. You can also configure exceptions to identify files that are excluded from the rule.

-   **Deny.** You can specify which files are *not* allowed to run in your environment, and for which users or groups of users. You can also configure exceptions to identify files that are excluded from the rule.

> [!IMPORTANT]
> For a best practice, use allow actions with exceptions.  You can use a combination of allow and deny actions but understand that deny actions override allow actions in all cases, and can be circumvented.

> [!IMPORTANT]
> If you join a computer running  Windows Server 2012  or Windows 8 to a domain that already enforces AppLocker rules for Executables, users will not be able to run any packaged apps unless you also create rules for packaged apps. If you want to allow any packaged apps in your environment while continuing to control Executables, you should create the default rules for packaged apps and set the enforcement mode to Audit\-only for the packaged apps rule collection.

## Rule exceptions
You can apply AppLocker rules to individual users or to a group of users. If you apply a rule to a group of users, all users in that group are affected by that rule. If you need to allow a subset of a user group to use an application, you can create a special rule for that subset. For example, the rule "Allow Everyone to run Windows except Registry Editor" allows everyone in the organization to run the Windows operating system, but it does not allow anyone to run Registry Editor.

The effect of this rule would prevent users such as Help Desk personnel from running a program that is necessary for their support tasks. To resolve this problem, create a second rule that applies to the Help Desk user group: "Allow Help Desk to run Registry Editor." If you create a deny rule that does not allow any users to run Registry Editor, the deny rule will override the second rule that allows the Help Desk user group to run Registry Editor.

## <a name="BKMK_DLLruleCollections"></a>DLL rule collection
Because the DLL rule collection is not enabled by default, you must perform the following procedure before you can create and enforce DLL rules.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

#### To enable the DLL rule collection

1.  On the **Start** screen, type**secpol.msc** in the **Search programs and files** box, and then press ENTER.

2.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3.  In the console tree, double\-click **Application Control Policies**, right\-click **AppLocker**, and then click **Properties**.

4.  Click the **Advanced** tab, select the **Enable the DLL rule collection** check box, and then click **OK**.

    > [!IMPORTANT]
    > Before you enforce DLL rules, make sure that there are allow rules for each DLL that is used by any of the allowed applications.

## AppLocker wizards
You can create rules by using two AppLocker wizards:

1.  The Create Rules Wizard enables you to create one rule at a time.

2.  The Automatically Generate Rules Wizard allows you to create multiple rules at one time. You can either select a folder and let the wizard create rules for the relevant files within that folder or in case of packaged apps let the wizard create rules for all packaged apps installed on the computer. You can also specify the user or group to which to apply the rules. This wizard automatically generates allow rules only.

## Additional considerations

-   By default, AppLocker rules do not allow users to open or run any files that are not specifically allowed. Administrators should maintain an up\-to\-date list of allowed applications.

-   There are two types of AppLocker conditions that do not persist following an update of an application:

    -   **File hash condition.** File hash rule conditions can be used with any application because a cryptographic hash value of the application is generated at the time the rule is created. However, the hash value is specific to that exact version of the application. If there are several versions of the application in use within the organization, you need to create file hash conditions for each version in use and for any new versions that are released.

    -   **A publisher condition with a specific product version set.** If you create a publisher rule condition that uses the **Exactly** version option, the rule cannot persist if a new version of the application is installed. A new publisher condition must be created, or the version must be edited in the rule to be made less specific.

-   If an application is not digitally signed, you cannot use a publisher rule condition for that application.

-   AppLocker rules cannot be used to manage computers running a Windows operating system earlier than  Windows Server 2008 R2  or  Windows 7 . Software Restriction Policies must be used instead. If AppLocker rules are defined in a Group Policy Object \(GPO\), only those rules are applied. To ensure interoperability between Software Restriction Policies rules and AppLocker rules, define Software Restriction Policies rules and AppLocker rules in different GPOs.

-   The packaged apps and packaged apps installer rule collection is available only on  Windows Server 2012  and Windows 8.

-   When the rules for the Executable rule collection are enforced and the packaged apps and packaged app installers rule collection does not contain any rules, no packaged apps and packaged app installers are allowed to run. In order to allow any packaged apps and packaged app installers you must create rules for the packaged apps and packaged app installers rule collection.

-   When an AppLocker rule collection is set to **Audit only**, the rules are not enforced. When a user runs an application that is included in the rule, the application is opened and runs normally, and information about that application is added to the AppLocker event log.

-   A custom configured URL can be included in the message that is displayed when an application is blocked.

-   Expect an increase in the number of Help Desk calls initially because of blocked applications until users understand that they cannot run applications that are not allowed.




