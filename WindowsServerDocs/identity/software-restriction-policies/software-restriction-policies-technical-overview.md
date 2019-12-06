---
title: Software Restriction Policies Technical Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-software-restriction-policies
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc7013b0-0efd-40fd-bd6d-75128adbd0b8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Software Restriction Policies Technical Overview

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes software restriction policies, when and how to use the feature, what changes have been implemented in past releases, and provides links to additional resources to help you create and deploy software restriction policies beginning with Windows Server 2008 and Windows Vista.

## Introduction
Software restriction policies provide administrators with a Group Policy-driven mechanism to identify software and control its ability to run on the local computer. These policies can be used to protect computers running Microsoft Windows operating systems (beginning with Windows Server 2003 and Windows XP Professional) against known conflicts and safeguard the computers against security threats such as malicious viruses and Trojan horse programs. You can also use software restriction policies to create a highly restricted configuration for computers, in which you allow only specifically identified applications to run. Software restriction policies are integrated with Microsoft Active Directory and Group Policy. You can also create software restriction policies on stand-alone computers.

Software restriction policies are trust policies, which are regulations set by an administrator to restrict scripts and other code that is not fully trusted from running. The Software Restriction Policies extension to the Local Group Policy Editor provides a single user interface through which the settings for restricting the use of applications can be managed on the local computer or throughout a domain.

## Procedures

-   [Administer Software Restriction Policies](administer-software-restriction-policies.md)

    -   [Determine Allow-Deny List and Application Inventory for Software Restriction Policies](determine-allow-deny-list-and-application-inventory-for-software-restriction-policies.md)

    -   [Work with Software Restriction Policies Rules](work-with-software-restriction-policies-rules.md)

    -   [Use Software Restriction Policies to Help Protect Your Computer Against an Email Virus](use-software-restriction-policies-to-help-protect-your-computer-against-an-email-virus.md)

-   [Troubleshoot Software Restriction Policies](troubleshoot-software-restriction-policies.md)

## Software restriction policy usage scenarios
Business users collaborate by using e-mail, instant messaging, and peer-to-peer applications. As these collaborations increase, especially with the use of the Internet in business computing, so do the threats from malicious code, such as worms, viruses, and malicious user or attacker threats.

Users might receive hostile code in many forms, ranging from native Windows executable files (.exe files), to macros in documents (such as .doc files), to scripts (such as .vbs files). Malicious users or attackers often use social engineering methods to get users to run code containing viruses and worms. (Social engineering is a term for tricking people into revealing their password or some form of security information.) If such code is activated, it can generate denial-of-service attacks on the network, send sensitive or private data to the Internet, put the security of the computer at risk, or damage the contents of the hard disk drive.

IT organizations and users must be able to determine which software is safe to run and which is not. With the large numbers and forms that hostile code can take, this becomes a difficult task.

To help protect their network computers from both hostile code and unknown or unsupported software, organizations can implement software restriction policies as part of their overall security strategy.

Administrators can use software restriction policies for the following tasks:

-   Define what is trusted code

-   Design a flexible Group Policy for regulating scripts, executable files, and ActiveX controls

Software restriction policies are enforced by the operating system and by applications (such as scripting applications) that comply with software restriction policies.

Specifically, administrators can use software restriction policies for the following purposes:

-   Specify which software (executable files) can run on client computers

-   Prevent users from running specific programs on shared computers

-   Specify who can add trusted publishers to client computers

-   Set the scope of the software restriction policies (specify whether policies affect all users or a subset of users on client computers)

-   Prevent executable files from running on the local computer, organizational unit (OU), site, or domain. This would be appropriate in cases when you are not using software restriction policies to address potential issues with malicious users.

## <a name="BKMK_Diffs_Changes"></a>Differences and changes in functionality
There are no changes in functionality in SRP for Windows Server 2012 and Windows 8.

**Supported versions**

Software Restriction Policies can only be configured on and applied to computers running at least Windows Server 2003, including  Windows Server 2012 , and at least Windows XP, including Windows 8.

> [!NOTE]
> Certain editions of the Windows client operating system beginning with Windows Vista do not have Software Restrictions Policies. Computers not administered in a domain by Group Policy might not receive distributed policies.

**Comparing application control functions in Software Restriction Policies and AppLocker**

The following table compares the features and functions of the Software Restriction Policies (SRP) feature and AppLocker.

|Application control function|SRP|AppLocker|
|----------------|----|-------|
|Scope|SRP policies can be applied to all Windows operating systems beginning with Windows XP and Windows Server 2003.|AppLocker policies apply only to Windows Server 2008 R2,  Windows Server 2012 , Windows 7, and Windows 8.|
|Policy creation|SRP policies are maintained through Group Policy and only the administrator of the GPO can update the SRP policy. The administrator on the local computer can modify the SRP policies defined in the local GPO.|AppLocker policies are maintained through Group Policy and only the administrator of the GPO can update the policy. The administrator on the local computer can modify the AppLocker policies defined in the local GPO.<br /><br />AppLocker permits customization of error messages to direct users to a Web page for help.|
|Policy maintenance|SRP policies must be updated by using the Local Security Policy snap-in (if the policies are created locally) or the Group Policy Management Console (GPMC).|AppLocker policies can be updated by using the Local Security Policy snap-in (if the policies are created locally), or the GPMC, or the Windows PowerShell AppLocker cmdlets.|
|Policy application|SRP policies are distributed through Group Policy.|AppLocker policies are distributed through Group Policy.|
|Enforcement mode|SRP works in the "deny list mode" where administrators can create rules for files that they do not want to allow in this Enterprise whereas the rest of the file are allowed to run by default.<br /><br />SRP can also be configured in the "allow list mode" such that the by default all files are blocked and administrators need to create allow rules for files that they want to allow.|AppLocker by default works in the "allow list mode" where only those files are allowed to run for which there is a matching allow rule.|
|File types that can be controlled|SRP can control the following file types:<br /><br />-   Executables<br />-   Dlls<br />-   Scripts<br />-   Windows Installers<br /><br />SRP cannot control each file type separately. All SRP rules are in a single rule collection.|AppLocker can control the following file types:<br /><br />-   Executables<br />-   Dlls<br />-   Scripts<br />-   Windows Installers<br />-   Packaged apps and installers ( Windows Server 2012  and Windows 8)<br /><br />AppLocker maintains a separate rule collection for each of the five file types.|
|Designated file types|SRP supports an extensible list of file types that are considered executable. Administrators can add extensions for files that should be considered executable.|AppLocker does not support this. AppLocker currently supports the following file extensions:<br /><br />-   Executables (.exe, .com)<br />-   Dlls (.ocx, .dll)<br />-   Scripts (.vbs, .js, .ps1, .cmd, .bat)<br />-   Windows Installers (.msi, .mst, .msp)<br />-   Packaged app installers (.appx)|
|Rule types|SRP supports four types of rules:<br /><br />-   Hash<br />-   Path<br />-   Signature<br />-   Internet zone|AppLocker supports three types of rules:<br /><br />-   Hash<br />-   Path<br />-   Publisher|
|Editing the hash value|SRP allows administrators to provide custom hash values.|AppLocker computes the hash value itself. Internally it uses the SHA1 Authenticode hash for Portable Executables (Exe and Dll) and Windows Installers and a SHA1 flat file hash for the rest.|
|Support for different security levels|With SRP administrators can specify the permissions with which an app can run. So, an administrator can configure a rule such that notepad always runs with restricted permissions and never with administrative privileges.<br /><br />SRP on Windows Vista and earlier supported multiple security levels. On Windows 7 that list was restricted to just two levels: Disallowed and Unrestricted (Basic User translates to Disallowed).|AppLocker does not support security levels.|
|Manage Packaged apps and Packaged app installers|Unable|.appx is a valid file type which AppLocker can manage.|
|Targeting a rule to a user or a group of users|SRP rules apply to all users on a particular computer.|AppLocker rules can be targeted to a specific user or a group of users.|
|Support for rule exceptions|SRP does not support rule exceptions|AppLocker rules can have exceptions which allow administrators to create rules such as "Allow everything from Windows except for Regedit.exe".|
|Support for audit mode|SRP does not support audit mode. The only way to test SRP policies is to set up a test environment and run a few experiments.|AppLocker supports audit mode which allows administrators to test the effect of their policy in the real production environment without impacting the user experience. Once you are satisfied with the results, you can start enforcing the policy.|
|Support for exporting and importing policies|SRP does not support policy import/export.|AppLocker supports the importing and exporting of policies. This allows you to create AppLocker policy on a sample computer, test it out and then export that policy and import it back into the desired GPO.|
|Rule enforcement|Internally, SRP rules enforcement happens in the user-mode which is less secure.|Internally, AppLocker rules for Exes and Dlls are enforced in the kernel-mode which is more secure than enforcing them in the user-mode.|

## System requirements
Software restriction policies can only be configured on and applied to computers running at least Windows Server 2003, and at least Windows XP. Group Policy is required to distribute Group Policy Objects that contain software restriction policies.

## Software restriction policies components and architecture
Software restriction policies provide a mechanism for the operating system and applications compliant with software restriction policies to restrict the runtime execution of software programs.

At a high level, software restriction policies consist of the following components:

-   Software restriction policies API. The Application Programming Interfaces (APIs) are used to create and configure the rules that constitute the software restriction policy. There also are software restriction policies APIs for querying, processing, and enforcing software restriction policies.

-   A software restriction policies management tool. This consists of the **Software Restriction Policies** extension of the **Local Group Policy Object Editor** snap-in, which administrators use to create and edit the software restriction policies.

-   A set of operating system APIs and applications that call the software restriction policies APIs to provide enforcement of the software restriction policies at runtime.

-   Active Directory and Group Policy. Software restriction policies depend on the Group Policy infrastructure to propagate the software restriction policies from the Active Directory to the appropriate clients, and for scoping and filtering the application of these policies to the appropriate target computers.

-   Authenticode and WinVerify Trust APIs which are used to process signed executable files.

-   Event Viewer. The functions used by software restriction policies log events to the Event Viewer logs.

-   Resultant Set of Policies (RSoP), which can aid in the diagnosing of the effective policy that will be applied to a client.

For more information about SRP architecture, how SRP manages rules, processes and interactions, see [How Software Restriction Policies Work](https://technet.microsoft.com/library/cc786941(v=WS.10).aspx) in the Windows Server 2003 Technical Library.

## <a name="BKMK_Best_Practices"></a>Best practices

### Do not modify the default domain policy.

-   If you do not edit the default domain policy, you always have the option of reapplying the default domain policy if something goes wrong with your customized domain policy.

### Create a separate Group Policy Object for software restriction policies.

-   If you create a separate Group Policy Object (GPO) for software restriction policies, you can disable software restriction policies in an emergency without disabling the rest of your domain policy.

### If you experience problems with applied policy settings, restart Windows in Safe Mode.

-   Software restriction policies do not apply when Windows is started in Safe Mode. If you accidentally lock down a workstation with software restriction policies, restart the computer in Safe Mode, log on as a local administrator, modify the policy, run **gpupdate**, restart the computer, and then log on normally.

### Use caution when defining a default setting of Disallowed.

-   When you define a default setting of **Disallowed**, all software is disallowed except for software that has been explicitly allowed. Any file that you want to open has to have a software restriction policies rule that allows it to open.

-   To protect administrators from locking themselves out of the system, when the default security level is set to **Disallowed**, four registry path rules are automatically created. You can delete or modify these registry path rules; however, this is not recommended.

### For best security, use access control lists in conjunction with software restriction policies.

-   Users might try to circumvent software restriction policies by renaming or moving disallowed files or by overwriting unrestricted files. As a result, it is recommended that you use access control lists (ACLs) to deny users the access necessary to perform these tasks.

### Test new policy settings thoroughly in test environments before applying the policy settings to your domain.

-   New policy settings might act differently than originally expected. Testing diminishes the chance of encountering a problem when you deploy policy settings across your network.

-   You can set up a test domain, separate from your organization's domain, in which to test new policy settings. You can also test the policy settings by creating a test GPO and linking it to a test organizational unit. When you have thoroughly tested the policy settings with test users, you can link the test GPO to your domain.

-   Do not set programs or files to **Disallowed** without testing to see what the effect may be. Restrictions on certain files can seriously affect the operation of your computer or network.

-   Information that is entered incorrectly or typing mistakes can result in a policy setting that does not perform as expected. Testing new policy settings before applying them can prevent unexpected behavior.

### Filter user policy settings based on membership in security groups.

-   You can specify users or groups for which you do not want a policy setting to apply by clearing the **Apply Group Policy** and **Read** check boxes, which are located on the **Security** tab of the properties dialog box for the GPO.

-   When the Read permission is denied, the policy setting is not downloaded by the computer. As a result, less bandwidth is consumed by downloading unnecessary policy settings, which enables the network to function more quickly. To deny the Read permission, select **Deny** for the **Read** check box, which is located on the **Security** tab of the properties dialog box for the GPO.

### Do not link to a GPO in another domain or site.

-   Linking to a GPO in another domain or site can result in poor performance.

## Additional resources

|Content type|References|
|--------|-------|
|**Planning**|[Software Restriction Policies Technical Reference](https://technet.microsoft.com/library/cc728085(v=WS.10).aspx)|
|**Operations**|[Administer Software Restriction Policies](administer-software-restriction-policies.md)|
|**Troubleshooting**|[Software Restriction Policies Troubleshooting (2003)](https://technet.microsoft.com/library/cc737011(v=WS.10).aspx)|
|**Security**|[Threats and Countermeasures for Software Restriction Polices (2008)](https://technet.microsoft.com/library/dd349795(v=WS.10).aspx)<br /><br />[Threats and Countermeasures for Software Restriction Polices (2008 R2)](https://technet.microsoft.com/library/hh125926(v=WS.10).aspx)|
|**Tools and settings**|[Software Restriction Policies Tools and Settings (2003)](https://technet.microsoft.com/library/cc782454(v=WS.10).aspx)|
|**Community resources**|[Application Lockdown with Software Restriction Policies](https://technet.microsoft.com/magazine/2008.06.srp.aspx?pr=blog)|


