---
title: Work with Software Restriction Policies Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-software-restriction-policies
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4a8047d5-9bb9-4bed-bc8f-583a237731e2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Work with Software Restriction Policies Rules

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes procedures working with certificate, path, internet zone and hash rules using Software Restriction Policies.

## Introduction
With software restriction policies, you can protect your computing environment from untrusted software by identifying and specifying what software is allowed to run. You can define a default security level of **Unrestricted** or **Disallowed** for a Group Policy Object (GPO) so that software is either allowed or not allowed to run by default. You can make exceptions to this default security level by creating software restriction policies rules for specific software. For example, if the default security level is set to **Disallowed**, you can create rules that allow specific software to run. The types of rules are as follows:

-   **Certificate rules**

    For procedures, see [Working with certificate rules](#BKMK_Cert_Rules).

-   **Hash rules**

    For procedures, see [Working with hash rules](#BKMK_Hash_Rules).

-   **Internet zone rules**

    For procedures, see [Working with Internet Zone rules](#BKMK_Internet_Zone_Rules).

-   **Path rules**

    For procedures, see [Working with path rules](#BKMK_Path_Rules).

For information about other tasks to manage Software Restriction Policies, see [Administer Software Restriction Policies](administer-software-restriction-policies.md).

## <a name="BKMK_Cert_Rules"></a>Working with certificate rules
Software restriction policies can also identify software by its signing certificate. You can create a certificate rule that identifies software and then allows or does not allow the software to run, depending on the security level. For example, you can use certificate rules to automatically trust software from a trusted source in a domain without prompting the user. You can also use certificate rules to run files in disallowed areas of your operating system. Certificate rules are not enabled by default.

When rules are created for the domain using Group Policy, you must have permissions to create or modify a Group Policy Object. If you are creating rules for the local computer, you must have administrative credentials on that computer.

#### To create a certificate rule

1.  Open Software Restriction Policies.

2.  In either the console tree or the details pane, right-click **Additional Rules**, and then click **New Certificate Rule**.

3.  Click **Browse**, and then select a certificate or signed file.

4.  In **Security level**, click either **Disallowed** or **Unrestricted**.

5.  In **Description**, type a description for this rule, and then click **OK**.

> [!NOTE]
> -   It might be necessary to create a new software restriction policy setting for the Group Policy Object (GPO) if you have not already done so.
> -   Certificate rules are not enabled by default.
> -   The only file types that are affected by certificate rules are those that are listed in **Designated file types** in the details pane for Software Restriction Policies. There is one list of designated file types that is shared by all rules.
> -   For software restriction policies to take effect, users must update policy settings by logging off from and logging on to their computers.
> -   When more than one software restriction policies rule is applied to policy settings, there is a precedence of rules for handling conflicts.

### Enabling certificate rules
There are different procedures for enabling certificate rules depending on your environment:

-   [For your local computer](#BKMK_1)

-   [For a Group Policy Object, and you are on a server that is joined to a domain](#BKMK_2)

-   [For a Group Policy Object, and you are on a domain controller or a on workstation that has the Remote Server Administration Tools installed](#BKMK_3)

-   [For only domain controllers, and you are on a domain controller or on a workstation that has the Remote Server Administration Tools Pack installed](#BKMK_4)

#### <a name="BKMK_1"></a>To enable certificate rules for your local computer

1.  Open Local Security Settings.

2.  In the console tree, click **Security Options** located under Security Settings/Local Policies.

3.  In the details pane, double-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.

4.  Do one of the following, and then click **OK**:

    -   To enable certificate rules, click **Enabled**.

    -   To disable certificate rules, click **Disabled**.

#### <a name="BKMK_2"></a>To enable certificate rules For a Group Policy Object, and you are on a server that is joined to a domain

1.  Open Microsoft Management Console (MMC).

2.  On the **File** menu, click **Add/Remove snap-in**, and then click **Add**.

3.  Click **Local Group Policy Object Editor**, and then click **Add**.

4.  In **Select Group Policy Object**, click **Browse**.

5.  In **Browse for a Group Policy Object**, select a Group Policy Object (GPO) in the appropriate domain, site, or organizational unit-or create a new one, and then click **Finish**.

6.  Click **Close**, and then click **OK**.

7.  In the console tree, click **Security Options** located under *GroupPolicyObject* [*ComputerName*] Policy/Computer Configuration/Windows Settings/Security Settings/Local Policies/.

8.  In the details pane, double-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.

9. If this policy setting has not yet been defined, select the **Define these policy settings** check box.

10. Do one of the following, and then click **OK**:

    -   To enable certificate rules, click **Enabled**.

    -   To disable certificate rules, click **Disabled**.

#### <a name="BKMK_3"></a>To enable certificate rules for a Group Policy Object, and you are on a domain controller or on a workstation that has the Remote Server Administration Tools installed

1.  Open Active Directory Users and Computers.

2.  In the console tree, right-click the Group Policy Object (GPO) for which you want to enable certificate rules.

3.  Click **Properties**, and then click the **Group Policy** tab.

4.  Click **Edit** to open the GPO that you want to edit. You can also click **New** to create a new GPO, and then click **Edit**.

5.  In the console tree, click **Security Options** located under *GroupPolicyObject*[*ComputerName*] Policy/Computer Configuration/Windows Settings/Security Settings/Local Policies.

6.  In the details pane, double-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.

7.  If this policy setting has not yet been defined, select the **Define these policy settings** check box.

8.  Do one of the following, and then click **OK**:

    -   To enable certificate rules, click **Enabled**.

    -   To disable certificate rules, click **Disabled**.

#### <a name="BKMK_4"></a>To enable certificate rules for only domain controllers, and you are on a domain controller or on a workstation that has the Remote Server Administration Tools installed

1.  Open Domain Controller Security Settings.

2.  In the console tree, click **Security Options** located under *GroupPolicyObject* [*ComputerName*] Policy/Computer Configuration/Windows Settings/Security Settings/Local Policies.

3.  In the details pane, double-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.

4.  If this policy setting has not yet been defined, select the **Define these policy settings** check box.

5.  Do one of the following, and then click **OK**:

    -   To enable certificate rules, click **Enabled**.

    -   To disable certificate rules, click **Disabled**.

> [!NOTE]
> You must perform this procedure before certificate rules can take effect.

### Set trusted publisher options
Software signing is being used by a growing number of software publishers and application developers to verify that their applications come from a trusted source. However, many users do not understand or pay little attention to the signing certificates associated with applications that they install.

The policy settings in the **Trusted Publishers** tab of the certificate path validation policy allows administrators to control which certificates can be accepted as coming from a trusted publisher.

##### To configure the trusted publishers policy settings for a local computer

1.  On the **Start** screen, type**gpedit.msc** and then press ENTER.

2.  In the console tree under **Local Computer Policy\Computer Configuration\Windows Settings\Security Settings**, click **Public Key Policies**.

3.  Double-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.

4.  Select the **Define these policy settings** check box, select the policy settings that you want to apply, and then click **OK** to apply the new settings.

##### To configure the trusted publishers policy settings for a domain

1.  Open **Group Policy Management**.

2.  In the console tree, double-click **Group Policy Objects** in the forest and domain containing the **Default Domain Policy** Group Policy Object (GPO) that you want to edit.

3.  Right-click the **Default Domain Policy** GPO, and then click **Edit**.

4.  In the console tree under **Computer Configuration\Windows Settings\Security Settings**, click **Public Key Policies**.

5.  Double-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.

6.  Select the **Define these policy settings** check box, select the policy settings that you want to apply, and then click **OK** to apply the new settings.

##### To allow only administrators to manage certificates used for code signing for a local computer

1.  On the **Start** screen, type, **gpedit.msc** in the **Search programs and files** or in Windows 8, on the Desktop, and then press ENTER.

2.  In the console tree under **Default Domain Policy** or **Local Computer Policy**, double-click **Computer Configuration**, **Windows Settings**, and **Security Settings**, and then click **Public Key Policies**.

3.  Double-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.

4.  Select the **Define these policy settings** check box.

5.  Under **Trusted publisher management**, click **Allow only all administrators to manage Trusted Publishers**, and then click **OK** to apply the new settings.

##### To allow only administrators to manage certificates used for code signing for a domain

1.  Open **Group Policy Management**.

2.  In the console tree, double-click **Group Policy Objects** in the forest and domain containing the **Default Domain Policy** GPO that you want to edit.

3.  Right-click the **Default Domain Policy** GPO, and then click **Edit**.

4.  In the console tree under **Computer Configuration\Windows Settings\Security Settings**, click **Public Key Policies**.

5.  Double-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.

6.  Select the **Define these policy settings** check box, implement the changes you want, and then click **OK** to apply the new settings.

## <a name="BKMK_Hash_Rules"></a>Working with hash rules
A hash is a series of bytes with a fixed length that uniquely identifies a software program or file. The hash is computed by a hash algorithm. When a hash rule is created for a software program, software restriction policies calculate a hash of the program. When a user tries to open a software program, a hash of the program is compared to existing hash rules for software restriction policies. The hash of a software program is always the same, regardless of where the program is located on the computer. However, if a software program is altered in any way, its hash also changes, and it no longer matches the hash in the hash rule for software restriction policies.

For example, you can create a hash rule and set the security level to **Disallowed** to prevent users from running a certain file. A file can be renamed or moved to another folder and still result in the same hash. However, any changes to the file itself also change its hash value and allow the file to bypass restrictions.

#### To create a hash rule

1.  Open Software Restriction Policies.

2.  In either the console tree or the details pane, right-click **Additional Rules**, and then click **New Hash Rule**.

3.  Click **Browse** to find a file.

    > [!NOTE]
    > In Windows XP it is possible to paste a pre-calculated hash in **File hash**. In  Windows Server 2008 R2 ,  Windows 7  and later versions, this option is not available.

4.  In **Security level**, click either **Disallowed** or **Unrestricted**.

5.  In **Description**, type a description for this rule, and then click **OK**.

> [!NOTE]
> -   It may be necessary to create a new software restriction policy setting for the Group Policy Object (GPO) if you have not already done so.
> -   A hash rule can be created for a virus or a Trojan horse to prevent them from running.
> -   If you want other people to use a hash rule so that a virus cannot run, calculate the hash of the virus by using software restriction policies, and then e-mail the hash value to the other people. Never e-mail the virus itself.
> -   If a virus has been sent through e-mail, you can also create a path rule to prevent execution of e-mail attachments.
> -   A file that is renamed or moved to another folder results in the same hash. Any change to the file itself results in a different hash.
> -   The only file types that are affected by hash rules are those that are listed in **Designated File Types** in the details pane for Software Restriction Policies. There is one list of designated file types that is shared by all rules.
> -   For software restriction policies to take effect, users must update policy settings by logging off from and logging on to their computers.
> -   When more than one software restriction policies rule is applied to policy settings, there is a precedence of rules for handling conflicts.

## <a name="BKMK_Internet_Zone_Rules"></a>Working with Internet Zone rules
Internet zone rules apply only to Windows Installer packages. A zone rule can identify software from a zone that is specified through Internet Explorer. These zones are Internet, Local intranet, Restricted sites, Trusted sites, and My Computer. An Internet Zone rule is designed to prevent users from downloading and installing software.

#### To create an Internet zone rule

1.  Open Software Restriction Policies.

2.  In either the console tree or the details pane, right-click **Additional Rules**, and then click **New Internet Zone Rule**.

3.  In **Internet zone**, click an Internet zone.

4.  In **Security level**, click either **Disallowed** or **Unrestricted**, and then click **OK**.

> [!NOTE]
> -   It may be necessary to create a new software restriction policy setting for the Group Policy Object (GPO) if you have not already done so.
> -   Zone rules only apply to files with an .msi file type, which are Windows Installer packages.
> -   For software restriction policies to take effect, users must update policy settings by logging off from and logging on to their computers.
> -   When more than one software restriction policies rule is applied to policy settings, there is a precedence of rules for handling conflicts.

## <a name="BKMK_Path_Rules"></a>Working with path rules
A path rule identifies software by its file path. For example, if you have a computer that has a default security level of **Disallowed**, you can still grant unrestricted access to a specific folder for each user. You can create a path rule by using the file path and setting the security level of the path rule to **Unrestricted**. Some common paths for this type of rule are %userprofile%, %windir%, %appdata%, %programfiles%, and %temp%. You can also create registry path rules that use the registry key of the software as its path.

Because these rules are specified by the path, if a software program is moved, the path rule no longer applies.

#### To create a path rule

1.  Open Software Restriction Policies.

2.  In either the console tree or the details pane, right-click **Additional Rules**, and then click **New Path Rule**.

3.  In **Path**, type a path, or click **Browse** to find a file or folder.

4.  In **Security level**, click either **Disallowed** or **Unrestricted**.

5.  In **Description**, type a description for this rule, and then click **OK**.

> [!CAUTION]
> -   On certain folders, such as the Windows folder, setting the security level to **Disallowed** can adversely affect the operation of your operating system. Make sure that you do not disallow a crucial component of the operating system or one of its dependent programs.

> [!NOTE]
> -   It may be necessary to create new software restriction policies for the Group Policy Object (GPO) if you have not already done so.
> -   If you create a path rule for software with a security level of **Disallowed**, users can still run the software by copying it to another location.
> -   The wildcard characters that are supported by the path rule are * and ?.
> -   You can use environment variables, such as %programfiles% or %systemroot%, in the path rule.
> -   If you want to create a path rule for software when you do not know where it is stored on a computer but you have its registry key, you can create a registry path rule.
> -   To prevent users from executing e-mail attachments, you can create a path rule for your e-mail program's attachment directory that prevents users from running e-mail attachments.
> -   The only file types that are affected by path rules are those that are listed in **Designated File Types** in the details pane for Software Restriction Policies. There is one list of designated file types that is shared by all rules.
> -   For software restriction policies to take effect, users must update policy settings by logging off from and logging on to their computers.
> -   When more than one software restriction policies rule is applied to policy settings, there is a precedence of rules for handling conflicts.

#### To create a registry path rule

1.  On the **Start** screen, type regedit.

2.  In the console tree, right-click the registry key that you want to create a rule for, and then click **Copy Key Name**. Note the value name in the details pane.

3.  Open Software Restriction Policies.

4.  In either the console tree or the details pane, right-click **Additional Rules**, and then click **New Path Rule**.

5.  In **Path**, paste the registry key name, followed by the value name.

6.  Enclose the registry path in percent signs (%), for example, %HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PlatformSDK\Directories\InstallDir%.

7.  In **Security level**, click either **Disallowed** or **Unrestricted**.

8.  In **Description**, type a description for this rule, and then click **OK**.


