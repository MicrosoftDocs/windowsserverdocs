---
title: Software Restriction Policies Help
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3595e4ee-3841-43c0-8211-b53470203190
---
# Software Restriction Policies Help
This topic for the IT professional contains procedures for administering application control policies by using Software Restriction Policies \(SRPs\).  
  
Software Restriction Policies is a Group Policy\-based feature that identifies software programs running on computers in a domain, and controls the ability of those programs to run. You use software restriction policies to create a highly restricted configuration for computers, in which you allow only specifically identified applications to run. These are integrated with Active Directory Domain Services and Group Policy, but they can also be configured on stand\-alone computers.  
  
This topic contains the following procedures:  
  
-   [How to create new software restriction policies](#BKMK_Create_SRP)  
  
-   [How to add or delete a designated file type](#BKMK_Add_Del)  
  
-   [How to prevent software restriction policies from applying to local administrators](#BKMK_Prevent_Admin)  
  
-   [How to change the default security level of software restriction policies](#BKMK_Sec_Lvl)  
  
-   [How to apply software restriction policies to DLLs](#BKMK_Apply_SRP_DLLs)  
  
-   [How to work with SRP rules](#BKMK_WorkingWithRules)  
  
For information about using SRPs to design a portion of your application security strategy, see [Determine Allow\/Deny List and Application Inventory for Software Restriction Policies](../Topic/Determine-Allow-Deny-List-and-Application-Inventory-for-Software-Restriction-Policies.md).  
  
## <a name="BKMK_Create_SRP"></a>How to create new software restriction policies  
Follow this procedure if you want to create new SRPs.  
  
> [!NOTE]  
> -   Different administrative credentials are required to perform this procedure, depending on your environment:  
>   
>     -   If you create new software restriction policies for your local computer: [!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
>     -   If you create new software restriction policies for a computer that is joined to a domain, members of the Domain Admins group can perform this procedure.  
  
#### To create a new SRP  
  
1.  Open Software Restriction Policies.  
  
2.  On the **Action** menu, click **New Software Restriction Policies**.  
  
> [!WARNING]  
> -   If software restriction policies have already been created for a Group Policy Object \(GPO\), the **New Software Restriction Policies** command does not appear on the **Action** menu. To delete the software restriction policies that are applied to a GPO, in the console tree, right\-click **Software Restriction Policies**, and then click **Delete Software Restriction Policies**. When you delete software restriction policies for a GPO, you also delete all software restriction policy rules for that GPO. After you delete software restriction policies, you can create new software restriction policies for that GPO.  
  
## <a name="BKMK_Add_Del"></a>How to add or delete a designated file type  
  
#### To add or delete a file type  
  
1.  Open Software Restriction Policies.  
  
2.  In the details pane, double\-click **Designated File Types**.  
  
3.  Do one of the following:  
  
    -   To add a file type, in **File name extension**, type the file name extension, and then click **Add**.  
  
    -   To delete a file type, in **Designated file types**, click the file type, and then click **Remove**.  
  
> [!NOTE]  
> -   Different administrative credentials are required to perform this procedure, depending on the environment in which you add or delete a designated file type:  
>   
>     -   If you add or delete a designated file type for your local computer: [!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
>     -   If you create new software restriction policies for a computer that is joined to a domain, you must be a member of the Domain Admins group.  
> -   It may be necessary to create a new software restriction policy setting for the Group Policy Object \(GPO\) if you have not already done so.  
> -   For a GPO, the list of designated file types is shared by all rules for Computer Configuration and for User Configuration.  
  
## <a name="BKMK_Prevent_Admin"></a>How to prevent software restriction policies from applying to local administrators  
  
#### To exempt local administrators  
  
1.  Open Software Restriction Policies.  
  
2.  In the details pane, double\-click **Enforcement**.  
  
3.  Under **Apply software restriction policies to the following users**, click **All users except local administrators**.  
  
> [!WARNING]  
> -   [!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
> -   It may be necessary to create a new software restriction policy setting for the Group Policy Object \(GPO\) if you have not already done so.  
> -   If it is common for users to be members of the local Administrators group on their computers in your organization, you may not want to enable this option.  
> -   If you are defining a software restriction policy setting for your local computer, use this procedure to prevent local administrators from having software restriction policies applied to them. If you are defining a software restriction policy setting for your network, filter user policy settings based on membership in security groups using Group Policy.  
  
## <a name="BKMK_Sec_Lvl"></a>How to change the default security level of software restriction policies  
  
#### To change the default security level  
  
1.  Open Software Restriction Policies.  
  
2.  In the details pane, double\-click **Security Levels**.  
  
3.  Right\-click the security level that you want to set as the default, and then click **Set as default**.  
  
> [!CAUTION]  
> In certain directories, setting the default security level to **Disallowed** can adversely affect your operating system.  
  
> [!NOTE]  
> -   Different administrative credentials are required to perform this procedure, depending on the environment for which you change the default security level of software restriction policies.  
> -   It may be necessary to create a new software restriction policy setting for this Group Policy Object \(GPO\) if you have not already done so.  
> -   In the details pane, the current default security level is indicated by a black circle with a check mark in it. If you right\-click the current default security level, the **Set as default** command does not appear in the menu.  
> -   Software restriction policy rules are created to specify exceptions to the default security level. When the default security level is set to **Unrestricted**, rules can specify software that is not allowed to run. When the default security level is set to **Disallowed**, rules can specify software that is allowed to run.  
> -   At installation, the default security level of software restriction policies on all files on your system is set to **Unrestricted**.  
  
## <a name="BKMK_Apply_SRP_DLLs"></a>How to apply software restriction policies to DLLs  
  
#### To apply policies to DLLs  
  
1.  Open Software Restriction Policies.  
  
2.  In the details pane, double\-click **Enforcement**.  
  
3.  Under **Apply software restriction policies to the following**, click **All software files**.  
  
> [!NOTE]  
> -   To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group can perform this procedure.  
> -   By default, software restriction policies do not check dynamic\-link libraries \(DLLs\). Checking DLLs can decrease system performance, because software restriction policies must be evaluated every time a DLL is loaded. However, you may decide to check DLLs if you are concerned about receiving a virus that targets DLLs. If the default security level is set to **Disallowed**, and you enable DLL checking, you must create software restriction policy rules that allow each DLL to run.  
  
## <a name="BKMK_WorkingWithRules"></a>How to work with SRP rules  
With software restriction policies, you can protect your computing environment from untrusted software by identifying and specifying which software is allowed to run. You can define a default security level of **Unrestricted** or **Disallowed** for a Group Policy Object \(GPO\) so that software is allowed or not allowed to run by default. You can make exceptions to this default security level by creating software restriction policy rules for specific software. For example, if the default security level is set to **Disallowed**, you can create rules that allow specific software to run. The types of rules are:  
  
-   **Certificate rules**  
  
    For procedures, see [Working with certificate rules](#BKMK_Cert_Rules).  
  
-   **Hash rules**  
  
    For procedures, see [Working with hash rules](#BKMK_Hash_Rules).  
  
-   **Internet zone rules**  
  
    For procedures, see [Working with Internet zone rules](#BKMK_Internet_Zone_Rules).  
  
-   **Path rules**  
  
    For procedures, see [Working with path rules](#BKMK_Path_Rules).  
  
### <a name="BKMK_Cert_Rules"></a>Working with certificate rules  
Software restriction policies can identify software by its signing certificate. You can create a certificate rule that identifies software and then allows or does not allow the software to run, depending on the security level. For example, you can use certificate rules to automatically trust software from a trusted source in a domain without prompting the user. You can also use certificate rules to run files in disallowed areas of your operating system.  
  
Certificate rules are not enabled by default. When rules are created for the domain by using Group Policy, you must have permissions to create or modify a Group Policy Object. If you are creating rules for the local computer, you must have administrative credentials on that computer.  
  
##### To create a certificate rule  
  
1.  Open Software Restriction Policies.  
  
2.  In the console tree or the details pane, right\-click **Additional Rules**, and then click **New Certificate Rule**.  
  
3.  Click **Browse**, and then select a certificate or signed file.  
  
4.  In **Security level**, click **Disallowed** or **Unrestricted**.  
  
5.  In **Description**, type a description for this rule, and then click **OK**.  
  
> [!NOTE]  
> -   It might be necessary to create a new software restriction policy setting for the Group Policy Object \(GPO\) if you have not already done so.  
> -   Certificate rules are not enabled by default.  
> -   The only file types that are affected by certificate rules are those that are listed in **Designated file types** in the details pane for Software Restriction Policies. There is one list of designated file types that is shared by all rules.  
> -   For software restriction policies to take effect, users must update policy settings by logging off and then logging on to their computers.  
> -   When more than one software restriction policy rule is applied to policy settings, there is a precedence of rules for handling conflicts.  
  
#### Enabling certificate rules  
There are different procedures for enabling certificate rules depending on your environment:  
  
-   [To enable rules for your local computer](#BKMK_CertRuleLocal)  
  
-   [To enable certificate rules for a GPO from a server joined to a domain](#BKMK_CertRuleDomain)  
  
-   [To enable certificate rules for a GPO from a domain controller or workstation that has the RSAT](#BKMK_CertRuleRSAT)  
  
-   [To enable certificate rules for only domain controllers from a domain controller or workstation that has the RSAT installed](#BKMK_CertRuleRSAT2)  
  
##### <a name="BKMK_CertRuleLocal"></a>To enable rules for your local computer  
  
1.  Open Local Security Settings.  
  
2.  In the console tree, click **Security Settings**, click **Local Policies**, and then click **Security Options**.  
  
3.  In the details pane, double\-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.  
  
4.  Do one of the following, and then click **OK**:  
  
    -   To enable certificate rules, click **Enabled**.  
  
    -   To disable certificate rules, click **Disabled**.  
  
##### <a name="BKMK_CertRuleDomain"></a>To enable certificate rules for a GPO from a server joined to a domain  
  
1.  Open Microsoft Management Console \(MMC\).  
  
2.  On the **File** menu, click **Add\/Remove snap\-in**, and then click **Add**.  
  
3.  Click **Local Group Policy Object Editor**, and then click **Add**.  
  
4.  In **Select Group Policy Object**, click **Browse**.  
  
5.  In **Browse for a Group Policy Object**, select a Group Policy Object \(GPO\) in the appropriate domain, site, or organizational unit \(or create a new one\), and then click **Finish**.  
  
6.  Click **Close**, and then click **OK**.  
  
7.  In the console tree, click **Security Options** located under *GroupPolicyObject**\[ComputerName\]* Policy\/Computer Configuration\/Windows Settings\/Security Settings\/Local Policies\/.  
  
8.  In the details pane, double\-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.  
  
9. If this policy setting has not yet been defined, select the **Define these policy settings** check box.  
  
10. Do one of the following, and then click **OK**:  
  
    -   To enable certificate rules, click **Enabled**.  
  
    -   To disable certificate rules, click **Disabled**.  
  
##### <a name="BKMK_CertRuleRSAT"></a>To enable certificate rules for a GPO from a domain controller or workstation that has the RSAT  
  
1.  Open Active Directory Users and Computers.  
  
2.  In the console tree, right\-click the Group Policy Object \(GPO\) for which you want to enable certificate rules.  
  
3.  Click **Properties**, and then click the **Group Policy** tab.  
  
4.  Click **Edit** to open the GPO that you want to edit. You can also click **New** to create a new GPO, and then click **Edit**.  
  
5.  In the console tree, click **Security Options** located under *GroupPolicyObject**\[ComputerName\]* Policy\/Computer Configuration\/Windows Settings\/Security Settings\/Local Policies.  
  
6.  In the details pane, double\-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.  
  
7.  If this policy setting has not yet been defined, select the **Define these policy settings** check box.  
  
8.  Do one of the following, and then click **OK**:  
  
    -   To enable certificate rules, click **Enabled**.  
  
    -   To disable certificate rules, click **Disabled**.  
  
##### <a name="BKMK_CertRuleRSAT2"></a>To enable certificate rules for only domain controllers from a domain controller or workstation that has the RSAT installed  
  
1.  Open Domain Controller Security Settings.  
  
2.  In the console tree, click **Security Options** located under *GroupPolicyObject* \[*ComputerName*\] Policy\/Computer Configuration\/Windows Settings\/Security Settings\/Local Policies.  
  
3.  In the details pane, double\-click **System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies**.  
  
4.  If this policy setting has not yet been defined, select the **Define these policy settings** check box.  
  
5.  Do one of the following, and then click **OK**:  
  
    -   To enable certificate rules, click **Enabled**.  
  
    -   To disable certificate rules, click **Disabled**.  
  
> [!NOTE]  
> You must perform this procedure before certificate rules can take effect.  
  
#### Setting trusted publisher options  
Software signing is being used by a growing number of software publishers and application developers to verify that their applications come from a trusted source. However, many users do not understand or they pay little attention to the signing certificates that are associated with applications they install.  
  
The policy settings that are listed on the **Trusted Publishers** tab of the certificate path validation policy allows administrators to control which certificates can be accepted as coming from a trusted publisher.  
  
###### To configure the trusted publishers policy settings for a local computer  
  
1.  [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**gpedit.msc** and then press ENTER.  
  
2.  In the console tree under **Local Computer Policy\\Computer Configuration\\Windows Settings\\Security Settings**, click **Public Key Policies**.  
  
3.  Double\-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.  
  
4.  Select the **Define these policy settings** check box, select the policy settings that you want to apply, and then click **OK** to apply the new settings.  
  
###### To configure the trusted publishers policy settings for a domain  
  
1.  Open **Group Policy Management**.  
  
2.  In the console tree, double\-click **Group Policy Objects** in the domain that contains the **Default Domain Policy** GPO that you want to edit.  
  
3.  Right\-click the **Default Domain Policy** GPO, and then click **Edit**.  
  
4.  In the console tree under **Computer Configuration\\Windows Settings\\Security Settings**, click **Public Key Policies**.  
  
5.  Double\-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.  
  
6.  Select the **Define these policy settings** check box, select the policy settings that you want to apply, and then click **OK** to apply the new settings.  
  
###### To allow only administrators to manage certificates used for code signing for a local computer  
  
1.  [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**gpedit.msc**, and then press ENTER.  
  
2.  In the console tree under **Default Domain Policy** or **Local Computer Policy**, double\-click **Computer Configuration**, click **Windows Settings**, click **Security Settings**, and then click **Public Key Policies**.  
  
3.  Double\-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.  
  
4.  Select the **Define these policy settings** check box.  
  
5.  Under **Trusted publisher management**, click **Allow only all administrators to manage Trusted Publishers**, and then click **OK** to apply the new settings.  
  
###### To allow only administrators to manage certificates used for code signing for a domain  
  
1.  Open **Group Policy Management**.  
  
2.  In the console tree, double\-click **Group Policy Objects** in the domain that contains the **Default Domain Policy** GPO that you want to edit.  
  
3.  Right\-click the **Default Domain Policy** GPO, and then click **Edit**.  
  
4.  In the console tree under **Computer Configuration\\Windows Settings\\Security Settings**, click **Public Key Policies**.  
  
5.  Double\-click **Certificate Path Validation Settings**, and then click the **Trusted Publishers** tab.  
  
6.  Select the **Define these policy settings** check box, implement the changes you want, and then click **OK** to apply the new settings.  
  
### <a name="BKMK_Hash_Rules"></a>Working with hash rules  
A hash is a series of bytes with a fixed length that uniquely identifies a software program or file. The hash is computed by a hash algorithm. When a hash rule is created for a software program, software restriction policies calculate a hash of the program. When a user tries to open a software program, a hash of the program is compared to existing hash rules for software restriction policies.  
  
The hash of a software program is always the same, regardless of where the program is located on the computer. However, if a software program is altered in any way, its hash also changes, and it no longer matches the hash in the hash rule for software restriction policies.  
  
For example, you can create a hash rule and set the security level to **Disallowed** to prevent users from running a certain file. A file can be renamed or moved to another folder and still result in the same hash. However, any changes to the file itself also change its hash value and allow the file to bypass restrictions.  
  
##### To create a hash rule  
  
1.  Open Software Restriction Policies.  
  
2.  In the console tree or the details pane, right\-click **Additional Rules**, and then click **New Hash Rule**.  
  
3.  Click **Browse** to find a file, or paste a precalculated hash in **File hash**.  
  
4.  In **Security level**, click **Disallowed** or **Unrestricted**.  
  
5.  In **Description**, type a description for this rule, and then click **OK**.  
  
> [!NOTE]  
> -   It may be necessary to create a new software restriction policy setting for the Group Policy Object \(GPO\) if you have not already done so.  
> -   A hash rule can be created for a virus or a Trojan horse to prevent them from running.  
> -   If you want other people to use a hash rule so that a virus cannot run, calculate the hash of the virus by using software restriction policies, and then email the hash value to them. Never email the virusitself.  
> -   If a virus has been sent through email, you can also create a path rule to prevent the email attachments from running.  
> -   A file that is renamed or moved to another folder results in the same hash. Any change to the file results in a different hash.  
> -   The only file types that are affected by hash rules are those that are listed in **Designated File Types** in the details pane for Software Restriction Policies. There is one list of designated file types that is shared by all rules.  
> -   For software restriction policies to take effect, users must update policy settings by logging off and then logging on to their computers.  
> -   When more than one software restriction policy rule is applied to policy settings, there is a precedence of rules for handling conflicts.  
  
### <a name="BKMK_Internet_Zone_Rules"></a>Working with Internet zone rules  
Internet zone rules apply only to Windows Installer packages. A zone rule can identify software from a zone that is specified through Internet Explorer. These zones are Internet, Local intranet, Restricted sites, Trusted sites, and My Computer. An Internet zone rule is designed to prevent users from downloading and installing software.  
  
##### To create an Internet zone rule  
  
1.  Open Software Restriction Policies.  
  
2.  In the console tree or the details pane, right\-click **Additional Rules**, and then click **New Internet Zone Rule**.  
  
3.  In **Internet zone**, click an Internet zone.  
  
4.  In **Security level**, click **Disallowed** or **Unrestricted**, and then click **OK**.  
  
> [!NOTE]  
> -   It may be necessary to create a new software restriction policy setting for the Group Policy Object \(GPO\) if you have not already done so.  
> -   Zone rules only apply to files with an .msi file type, which are Windows Installer packages.  
> -   For software restriction policies to take effect, users must update policy settings by logging off and then logging on to their computers.  
> -   When more than one software restriction policy rule is applied to policy settings, there is a precedence of rules for handling conflicts.  
  
### <a name="BKMK_Path_Rules"></a>Working with path rules  
A path rule identifies software by its file path. For example, if you have a computer that has a default security level of **Disallowed**, you can still grant unrestricted access to a specific folder for each user. You can create a path rule by using the file path and setting the security level of the path rule to **Unrestricted**.  
  
Some common paths for this type of rule are %userprofile%, %windir%, %appdata%, %programfiles%, and %temp%. You can also create registry path rules that use the registry key of the software as its path.  
  
Because these rules are specified by the path, if a software program is moved, the path rule no longer applies.  
  
##### To create a path rule  
  
1.  Open Software Restriction Policies.  
  
2.  In the console tree or the details pane, right\-click **Additional Rules**, and then click **New Path Rule**.  
  
3.  In **Path**, type a path, or click **Browse** to find a file or folder.  
  
4.  In **Security level**, click **Disallowed** or **Unrestricted**.  
  
5.  In **Description**, type a description for this rule, and then click **OK**.  
  
> [!CAUTION]  
> -   For certain folders \(such as the Windows folder\), setting the security level to **Disallowed** can adversely affect the operation of your operating system. Make sure that you do not disallow a crucial component of the operating system or one of its dependent programs.  
  
> [!NOTE]  
> -   It may be necessary to create new software restriction policies for the Group Policy Object \(GPO\) if you have not already done so.  
> -   If you create a path rule for software with a security level of **Disallowed**, users can still run the software by copying it to another location.  
> -   The wildcard characters that are supported by the path rule are \* and ?.  
> -   You can use environment variables, such as %programfiles% or %systemroot%, in the path rule.  
> -   If you want to create a path rule for software when you do not know where it is stored on a computer but you have its registry key, you can create a registry path rule.  
> -   To prevent users from executing email attachments, you can create a path rule for your email program's attachment directory that prevents users from running email attachments.  
> -   The only file types that are affected by path rules are those that are listed in **Designated File Types** in the details pane for Software Restriction Policies. There is one list of designated file types that is shared by all rules.  
> -   For software restriction policies to take effect, users must update policy settings by logging off and then logging on to their computers.  
> -   When more than one software restriction policy rule is applied to policy settings, there is a precedence of rules for handling conflicts.  
  
##### To create a registry path rule  
  
1.  [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**regedit**.  
  
2.  In the console tree, right\-click the registry key that you want to create a rule for, and then click **Copy Key Name**. Note the value name in the details pane.  
  
3.  Open Software Restriction Policies.  
  
4.  In the console tree or the details pane, right\-click **Additional Rules**, and then click **New Path Rule**.  
  
5.  In **Path**, paste the registry key, followed by the value name.  
  
6.  Enclose the registry path in percent signs \(%\), for example, %HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\PlatformSDK\\Directories\\InstallDir%.  
  
7.  In **Security level**, click **Disallowed** or **Unrestricted**.  
  
8.  In **Description**, type a description for this rule, and then click **OK**.  
  
