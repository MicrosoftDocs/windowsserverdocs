---
title: User Rights Assignment
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4846ac83-9bba-4008-a041-565f43b54c99
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# User Rights Assignment

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This reference topic for the IT professional provides an overview and links to information about the User Rights Assignment security policy settings user rights that are available in the Windows operating system.  
  
User rights govern the methods by which a user can log on to a system. User rights are applied at the local computer level, and they allow users to perform tasks on a computer or in a domain. User rights include logon rights and permissions. Logon rights control who is authorized to log on to a computer and how they can log on. User rights permissions control access to computer and domain resources, and they can override permissions that have been set on specific objects. User rights are managed in Group Policy under the **User Rights Assignment** item.  
  
Each user right has a constant name and a Group Policy name associated with it. The constant names are used when referring to the user right in log events. You can configure the user rights assignment settings in the following location within the Group Policy Management Console (GPMC) under **Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment**, or on the local computer by using the Local Group Policy Editor (gpedit.msc).  
  
For information about setting security policies, see [How to Configure Security Policy Settings](../how-to-configure-security-policy-settings.md).  
  
The following table links to each security policy setting and provides the constant name for each. Setting descriptions contain reference information, best practices for configuring the policy setting, default values, differences between operating system versions, and considerations for policy management and security.  
  
|Group Policy Setting|Constant Name|  
|------------|---------|  
|[Access Credential Manager as a trusted caller](access-credential-manager-as-a-trusted-caller.md)|SeTrustedCredManAccessPrivilege|  
|[Access this computer from the network](access-this-computer-from-the-network.md)|SeNetworkLogonRight|  
|[Act as part of the operating system](act-as-part-of-the-operating-system.md)|SeTcbPrivilege|  
|[Add workstations to domain](add-workstations-to-domain.md)|SeMachineAccountPrivilege|  
|[Adjust memory quotas for a process](adjust-memory-quotas-for-a-process.md)|SeIncreaseQuotaPrivilege|  
|[Allow log on locally](allow-log-on-locally.md)|SeInteractiveLogonRight|  
|[Allow log on through Remote Desktop Services](allow-log-on-through-remote-desktop-services.md)|SeRemoteInteractiveLogonRight|  
|[Back up files and directories](back-up-files-and-directories.md)|SeBackupPrivilege|  
|[Bypass traverse checking](bypass-traverse-checking.md)|SeChangeNotifyPrivilege|  
|[Change the system time](change-the-system-time.md)|SeSystemtimePrivilege|  
|[Change the time zone](change-the-time-zone.md)|SeTimeZonePrivilege|  
|[Create a pagefile](create-a-pagefile.md)|SeCreatePagefilePrivilege|  
|[Create a token object](create-a-token-object.md)|SeCreateTokenPrivilege|  
|[Create global objects](create-global-objects.md)|SeCreateGlobalPrivilege|  
|[Create permanent shared objects](create-permanent-shared-objects.md)|SeCreatePermanentPrivilege|  
|[Create symbolic links](create-symbolic-links.md)|SeCreateSymbolicLinkPrivilege|  
|[Debug programs](debug-programs.md)|SeDebugPrivilege|  
|[Deny access to this computer from the network](deny-access-to-this-computer-from-the-network.md)|SeDenyNetworkLogonRight|  
|[Deny log on as a batch job](deny-log-on-as-a-batch-job.md)|SeDenyBatchLogonRight|  
|[Deny log on as a service](deny-log-on-as-a-service.md)|SeDenyServiceLogonRight|  
|[Deny log on locally](deny-log-on-locally.md)|SeDenyInteractiveLogonRight|  
|[Deny log on through Remote Desktop Services](deny-log-on-through-remote-desktop-services.md)|SeDenyRemoteInteractiveLogonRight|  
|[Enable computer and user accounts to be trusted for delegation](enable-computer-and-user-accounts-to-be-trusted-for-delegation.md)|SeEnableDelegationPrivilege|  
|[Force shutdown from a remote system](force-shutdown-from-a-remote-system.md)|SeRemoteShutdownPrivilege|  
|[Generate security audits](generate-security-audits.md)|SeAuditPrivilege|  
|[Impersonate a client after authentication](impersonate-a-client-after-authentication.md)|SeImpersonatePrivilege|  
|[Increase a process working set](increase-a-process-working-set.md)|SeIncreaseWorkingSetPrivilege|  
|[Increase scheduling priority](increase-scheduling-priority.md)|SeIncreaseBasePriorityPrivilege|  
|[Load and unload device drivers](load-and-unload-device-drivers.md)|SeLoadDriverPrivilege|  
|[Lock pages in memory](lock-pages-in-memory.md)|SeLockMemoryPrivilege|  
|[Log on as a batch job](log-on-as-a-batch-job.md)|SeBatchLogonRight|  
|[Log on as a service](log-on-as-a-service.md)|SeServiceLogonRight|  
|[Manage auditing and security log](manage-auditing-and-security-log.md)|SeSecurityPrivilege|  
|[Modify an object label](modify-an-object-label.md)|SeRelabelPrivilege|  
|[Modify firmware environment values](modify-firmware-environment-values.md)|SeSystemEnvironmentPrivilege|  
|[Perform volume maintenance tasks](perform-volume-maintenance-tasks.md)|SeManageVolumePrivilege|  
|[Profile single process](profile-single-process.md)|SeProfileSingleProcessPrivilege|  
|[Profile system performance](profile-system-performance.md)|SeSystemProfilePrivilege|  
|[Remove computer from docking station](remove-computer-from-docking-station.md)|SeUndockPrivilege|  
|[Replace a process level token](replace-a-process-level-token.md)|SeAssignPrimaryTokenPrivilege|  
|[Restore files and directories](restore-files-and-directories.md)|SeRestorePrivilege|  
|[Synchronize directory service data](synchronize-directory-service-data.md)|SeSyncAgentPrivilege|  
|[Take ownership of files or other objects](take-ownership-of-files-or-other-objects.md)|SeTakeOwnershipPrivilege|  
  

