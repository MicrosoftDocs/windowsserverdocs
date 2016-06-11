---
title: Determine Your Application Control Objectives
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b362690d-496a-4ae0-88b0-a4edba0e307a
---
# Determine Your Application Control Objectives
This topic helps you with the decisions you need to make to determine what applications to control and how to control them by comparing Software Restriction Policies and AppLocker.

AppLocker is very effective for organizations with application restriction requirements whose environments have a simple topography and the application control policy goals are straightforward. For example, AppLocker can benefit an environment where non\-employees have access to computers connected to the organizational network, such as a school or library. Large organizations also benefit from AppLocker policy deployment when the goal is to achieve a detailed level of control on the desktop computers that they manage for a relatively small number of applications.

There are management and maintenance costs associated with a list of allowed applications. In addition, the purpose of application control policies is to allow or prevent employees from using applications that might actually be productivity tools. Keeping employees or users productive while implementing the policies can cost time and effort. Lastly, creating user support processes and network support processes to keep the organization productive are also concerns.

Use the following table to develop your own objectives and determine which application control feature best addresses those objectives.

|Application control function|SRP|AppLocker|
|--------------------------------|-------|-------------|
|Scope|SRP policies can be applied to all Windows operating systems beginning with Windows XP and Windows Server 2003.|AppLocker policies apply only to the support versions of Windows listed in [Requirements to Use AppLocker]().|
|Policy creation|SRP policies are maintained through Group Policy and only the administrator of the GPO can update the SRP policy. The administrator on the local computer can modify the SRP policies defined in the local GPO.|AppLocker policies are maintained through Group Policy and only the administrator of the GPO can update the policy. The administrator on the local computer can modify the AppLocker policies defined in the local GPO.<br /><br />AppLocker permits customization of error messages to direct users to a Web page for help.|
|Policy maintenance|SRP policies must be updated by using the Local Security Policy snap\-in \(if the policies are created locally\) or the Group Policy Management Console \(GPMC\).|AppLocker policies can be updated by using the Local Security Policy snap\-in \(if the policies are created locally\), or the GPMC, or the Windows PowerShell AppLocker cmdlets.|
|Policy application|SRP policies are distributed through Group Policy.|AppLocker policies are distributed through Group Policy.|
|Enforcement mode|SRP works in the “deny list mode” where administrators can create rules for files that they do not want to allow in this Enterprise whereas the rest of the file are allowed to run by default.<br /><br />SRP can also be configured in the “allow list mode” such that the by default all files are blocked and administrators need to create allow rules for files that they want to allow.|AppLocker by default works in the “allow list mode” where only those files are allowed to run for which there is a matching allow rule.|
|File types that can be controlled|SRP can control the following file types:<br /><br />-   Executables<br />-   Dlls<br />-   Scripts<br />-   Windows Installers<br /><br />SRP cannot control each file type separately. All SRP rules are in a single rule collection.|AppLocker can control the following file types:<br /><br />-   Executables<br />-   Dlls<br />-   Scripts<br />-   Windows Installers<br />-   Packaged apps and installers \(but not in  Windows Server 2008 R2  and  Windows 7  \).<br /><br />AppLocker maintains a separate rule collection for each of the five file types.|
|Designated file types|SRP supports an extensible list of file types that are considered executable. Administrators can add extensions for files that should be considered executable.|AppLocker does not support this. AppLocker currently supports the following file extensions:<br /><br />-   Executables \(.exe, .com\)<br />-   Dlls \(.ocx, .dll\)<br />-   Scripts \(.vbs, .js, .ps1, .cmd, .bat\)<br />-   Windows Installers \(.msi, .mst, .msp\)<br />-   Packaged app installers \(.appx\)|
|Rule types|SRP supports four types of rules:<br /><br />-   Hash<br />-   Path<br />-   Signature<br />-   Internet zone|AppLocker supports three types of rules:<br /><br />-   Hash<br />-   Path<br />-   Publisher|
|Editing the hash value|SRP allows administrators to select a file to hash.|AppLocker computes the hash value itself. Internally it uses the SHA2 Authenticode hash for Portable Executables \(Exe and Dll\) and Windows Installers and a SHA2 flat file hash for the rest.|
|Support for different security levels|With SRP administrators can specify the permissions with which an app can run. So, an administrator can configure a rule such that notepad always runs with restricted permissions and never with administrative privileges.<br /><br />SRP on Windows Vista and earlier supported multiple security levels. On Windows 7 that list was restricted to just two levels: Disallowed and Unrestricted \(Basic User translates to Disallowed\).|AppLocker does not support security levels.|
|Manage Packaged apps and Packaged app installers.|Unable|.appx is a valid file type which AppLocker can manage.|
|Targeting a rule to a user or a group of users|SRP rules apply to all users on a particular computer.|AppLocker rules can be targeted to a specific user or a group of users.|
|Support for rule exceptions|SRP does not support rule exceptions|AppLocker rules can have exceptions which allow administrators to create rules such as “Allow everything from Windows except for Regedit.exe”.|
|Support for audit mode|SRP does not support audit mode. The only way to test SRP policies is to set up a test environment and run a few experiments.|AppLocker supports audit mode which allows administrators to test the effect of their policy in the real production environment without impacting the user experience. Once you are satisfied with the results, you can start enforcing the policy.|
|Support for exporting and importing policies|SRP does not support policy import\/export.|AppLocker supports the importing and exporting of policies. This allows you to create AppLocker policy on a sample computer, test it out and then export that policy and import it back into the desired GPO.|
|Rule enforcement|Internally, SRP rules enforcement happens in the user\-mode which is less secure.|Internally, AppLocker rules for Exes and Dlls are enforced in the kernel\-mode which is more secure than enforcing them in the user\-mode.|

For information about the capabilities of Software Restriction Policies, see [Software Restriction Policies Technical Overview]().

For information about the capabilities of AppLocker, see [AppLocker Technical Overview](assetId:///358610e4-88b2-40d0-b34d-dfd7ddee0ed9).


