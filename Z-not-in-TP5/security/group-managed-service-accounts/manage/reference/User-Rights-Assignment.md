---
title: User Rights Assignment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4846ac83-9bba-4008-a041-565f43b54c99
---
# User Rights Assignment
This reference topic for the IT professional provides an overview and links to information about the User Rights Assignment security policy settings user rights that are available in the Windows operating system.

User rights govern the methods by which a user can log on to a system. User rights are applied at the local computer level, and they allow users to perform tasks on a computer or in a domain. User rights include logon rights and permissions. Logon rights control who is authorized to log on to a computer and how they can log on. User rights permissions control access to computer and domain resources, and they can override permissions that have been set on specific objects. User rights are managed in Group Policy under the **User Rights Assignment** item.

Each user right has a constant name and a Group Policy name associated with it. The constant names are used when referring to the user right in log events. You can configure the user rights assignment settings in the following location within the Group Policy Management Console (GPMC) under **Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment**, or on the local computer by using the Local Group Policy Editor (gpedit.msc).

For information about setting security policies, see [How to Configure Security Policy Settings](How-to-Configure-Security-Policy-Settings.md).

The following table links to each security policy setting and provides the constant name for each. Setting descriptions contain reference information, best practices for configuring the policy setting, default values, differences between operating system versions, and considerations for policy management and security.

|Group Policy Setting|Constant Name|
|------------------------|-----------------|
|[Access Credential Manager as a trusted caller](Access-Credential-Manager-as-a-trusted-caller.md)|SeTrustedCredManAccessPrivilege|
|[Access this computer from the network](Access-this-computer-from-the-network.md)|SeNetworkLogonRight|
|[Act as part of the operating system](Act-as-part-of-the-operating-system.md)|SeTcbPrivilege|
|[Add workstations to domain](Add-workstations-to-domain.md)|SeMachineAccountPrivilege|
|[Adjust memory quotas for a process](Adjust-memory-quotas-for-a-process.md)|SeIncreaseQuotaPrivilege|
|[Allow log on locally](Allow-log-on-locally.md)|SeInteractiveLogonRight|
|[Allow log on through Remote Desktop Services](Allow-log-on-through-Remote-Desktop-Services.md)|SeRemoteInteractiveLogonRight|
|[Back up files and directories](Back-up-files-and-directories.md)|SeBackupPrivilege|
|[Bypass traverse checking](Bypass-traverse-checking.md)|SeChangeNotifyPrivilege|
|[Change the system time](Change-the-system-time.md)|SeSystemtimePrivilege|
|[Change the time zone](Change-the-time-zone.md)|SeTimeZonePrivilege|
|[Create a pagefile](Create-a-pagefile.md)|SeCreatePagefilePrivilege|
|[Create a token object](Create-a-token-object.md)|SeCreateTokenPrivilege|
|[Create global objects](Create-global-objects.md)|SeCreateGlobalPrivilege|
|[Create permanent shared objects](Create-permanent-shared-objects.md)|SeCreatePermanentPrivilege|
|[Create symbolic links](Create-symbolic-links.md)|SeCreateSymbolicLinkPrivilege|
|[Debug programs](Debug-programs.md)|SeDebugPrivilege|
|[Deny access to this computer from the network](Deny-access-to-this-computer-from-the-network.md)|SeDenyNetworkLogonRight|
|[Deny log on as a batch job](Deny-log-on-as-a-batch-job.md)|SeDenyBatchLogonRight|
|[Deny log on as a service](Deny-log-on-as-a-service.md)|SeDenyServiceLogonRight|
|[Deny log on locally](Deny-log-on-locally.md)|SeDenyInteractiveLogonRight|
|[Deny log on through Remote Desktop Services](Deny-log-on-through-Remote-Desktop-Services.md)|SeDenyRemoteInteractiveLogonRight|
|[Enable computer and user accounts to be trusted for delegation](Enable-computer-and-user-accounts-to-be-trusted-for-delegation.md)|SeEnableDelegationPrivilege|
|[Force shutdown from a remote system](Force-shutdown-from-a-remote-system.md)|SeRemoteShutdownPrivilege|
|[Generate security audits](Generate-security-audits.md)|SeAuditPrivilege|
|[Impersonate a client after authentication](Impersonate-a-client-after-authentication.md)|SeImpersonatePrivilege|
|[Increase a process working set](Increase-a-process-working-set.md)|SeIncreaseWorkingSetPrivilege|
|[Increase scheduling priority](Increase-scheduling-priority.md)|SeIncreaseBasePriorityPrivilege|
|[Load and unload device drivers](Load-and-unload-device-drivers.md)|SeLoadDriverPrivilege|
|[Lock pages in memory](Lock-pages-in-memory.md)|SeLockMemoryPrivilege|
|[Log on as a batch job](Log-on-as-a-batch-job.md)|SeBatchLogonRight|
|[Log on as a service](Log-on-as-a-service.md)|SeServiceLogonRight|
|[Manage auditing and security log](Manage-auditing-and-security-log.md)|SeSecurityPrivilege|
|[Modify an object label](Modify-an-object-label.md)|SeRelabelPrivilege|
|[Modify firmware environment values](Modify-firmware-environment-values.md)|SeSystemEnvironmentPrivilege|
|[Perform volume maintenance tasks](Perform-volume-maintenance-tasks.md)|SeManageVolumePrivilege|
|[Profile single process](Profile-single-process.md)|SeProfileSingleProcessPrivilege|
|[Profile system performance](Profile-system-performance.md)|SeSystemProfilePrivilege|
|[Remove computer from docking station](Remove-computer-from-docking-station.md)|SeUndockPrivilege|
|[Replace a process level token](Replace-a-process-level-token.md)|SeAssignPrimaryTokenPrivilege|
|[Restore files and directories](Restore-files-and-directories.md)|SeRestorePrivilege|
|[Shut down the system](Shut-down-the-system.md)|SeShutdownPrivilege|
|[Synchronize directory service data](Synchronize-directory-service-data.md)|SeSyncAgentPrivilege|
|[Take ownership of files or other objects](Take-ownership-of-files-or-other-objects.md)|SeTakeOwnershipPrivilege|


