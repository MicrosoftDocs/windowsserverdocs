---
title: Use AppLocker and Software Restriction Policies in the Same Domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a6862ebf-29ea-44b8-9e64-cc4789ed8423
---
# Use AppLocker and Software Restriction Policies in the Same Domain
This topic for the IT professional describes concepts and procedures to help you manage your application control strategy using Software Restriction Policies and AppLocker.  
  
## Using AppLocker and Software Restriction Policies in the same domain  
AppLocker is supported on systems running Windows 7 and above. Software Restriction Policies \(SRP\) is supported on systems running Windows Vista or earlier. You can continue to use SRP for application control on your pre\-Windows 7 computers, but use AppLocker for computers running Windows Server 2008 R2, Windows 7 and later. It is recommended that you author AppLocker and SRP rules in separate GPOs and target the GPO with SRP policies to systems running Windows Vista or earlier. When both SRP and AppLocker policies are applied to computers running Windows Server 2008 R2, Windows 7 and later, the SRP policies are ignored.  
  
The following table compares the features and functions of Software Restriction Policies \(SRP\) and AppLocker.  
  
|Application control function|SRP|AppLocker|  
|--------------------------------|-------|-------------|  
|Scope|SRP policies can be applied to all Windows operating systems beginning with Windows XP and Windows Server 2003.|AppLocker policies apply only to Windows Server 2008 R2, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows 7, and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].|  
|Policy creation|SRP policies are maintained through Group Policy and only the administrator of the GPO can update the SRP policy. The administrator on the local computer can modify the SRP policies defined in the local GPO.|AppLocker policies are maintained through Group Policy and only the administrator of the GPO can update the policy. The administrator on the local computer can modify the AppLocker policies defined in the local GPO.<br /><br />AppLocker permits customization of error messages to direct users to a Web page for help.|  
|Policy maintenance|SRP policies must be updated by using the Local Security Policy snap\-in \(if the policies are created locally\) or the Group Policy Management Console \(GPMC\).|AppLocker policies can be updated by using the Local Security Policy snap\-in \(if the policies are created locally\), or the GPMC, or the Windows PowerShell AppLocker cmdlets.|  
|Policy application|SRP policies are distributed through Group Policy.|AppLocker policies are distributed through Group Policy.|  
|Enforcement mode|SRP works in the “deny list mode” where administrators can create rules for files that they do not want to allow in this Enterprise whereas the rest of the file are allowed to run by default.<br /><br />SRP can also be configured in the “allow list mode” such that the by default all files are blocked and administrators need to create allow rules for files that they want to allow.|AppLocker by default works in the “allow list mode” where only those files are allowed to run for which there is a matching allow rule.|  
|File types that can be controlled|SRP can control the following file types:<br /><br />-   Executables<br />-   Dlls<br />-   Scripts<br />-   Windows Installers<br /><br />SRP cannot control each file type separately. All SRP rules are in a single rule collection.|AppLocker can control the following file types on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and later versions:<br /><br />-   Executables<br />-   Dlls<br />-   Scripts<br />-   Windows Installers<br /><br />Packaged apps and installersWere added beginning with[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]<br /><br />AppLocker maintains a separate rule collection for each of the five file types.|  
|Designated file types|SRP supports an extensible list of file types that are considered executable. Administrators can add extensions for files that should be considered executable.|AppLocker does not support this. AppLocker currently supports the following file extensions:<br /><br />-   Executables \(.exe, .com\)<br />-   Dlls \(.ocx, .dll\)<br />-   Scripts \(.vbs, .js, .ps1, .cmd, .bat\)<br />-   Windows Installers \(.msi, .mst, .msp\)<br />-   Packaged app installers \(.appx\)|  
|Rule types|SRP supports four types of rules:<br /><br />-   Hash<br />-   Path<br />-   Signature<br />-   Internet zone|AppLocker supports three types of rules:<br /><br />-   Hash<br />-   Path<br />-   Publisher|  
|Editing the hash value|In Windows XP, SRP allows administrators to provide custom hash values.<br /><br />Beginning with Windows 7, and Windows Server 2008 R2, you can only select the file to hash, not provide the hash value.|AppLocker computes the hash value itself. Internally it uses the SHA2 Authenticode hash for Portable Executables \(Exe and Dll\) and Windows Installers and a SHA2 flat file hash for the rest.|  
|Support for different security levels|With SRP administrators can specify the permissions with which an app can run. So, an administrator can configure a rule such that notepad always runs with restricted permissions and never with administrative privileges.<br /><br />SRP on Windows Vista and earlier supported multiple security levels. On Windows 7 that list was restricted to just two levels: Disallowed and Unrestricted \(Basic User translates to Disallowed\).|AppLocker does not support security levels.|  
|Manage [!INCLUDE[applocker_modernapp](../Token/applocker_modernapp_md.md)]s and [!INCLUDE[applocker_pkg](../Token/applocker_pkg_md.md)]s.|Unable|.appx is a valid file type which AppLocker can manage.|  
|Targeting a rule to a user or a group of users|SRP rules apply to all users on a particular computer.|AppLocker rules can be targeted to a specific user or a group of users.|  
|Support for rule exceptions|SRP does not support rule exceptions|AppLocker rules can have exceptions which allows administrators to create rules such as “Allow everything from Windows except for Regedit.exe”.|  
|Support for audit mode|SRP does not support audit mode. The only way to test SRP policies is to set up a test environment and run a few experiments.|AppLocker supports audit mode which allows administrators to test the effect of their policy in the real production environment without impacting the user experience. Once you are satisfied with the results, you can start enforcing the policy.|  
|Support for exporting and importing policies|SRP does not support policy import\/export.|AppLocker supports the importing and exporting of policies. This allows you to create AppLocker policy on a sample computer, test it out and then export that policy and import it back into the desired GPO.|  
|Rule enforcement|Internally, SRP rules enforcement happens in the user\-mode which is less secure.|Internally, AppLocker rules for Exes and Dlls are enforced in the kernel\-mode which is more secure than enforcing them in the user\-mode.|  
  
## See Also  
[AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)  
  
