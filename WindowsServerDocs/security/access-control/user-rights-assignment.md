---
title: User Rights Assignment
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-access-control
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

For information about setting security policies, see [How to Configure Security Policy Settings](../group-managed-service-accounts/how-to-configure-security-policy-settings.md).

The following table links to each security policy setting and provides the constant name for each. Setting descriptions contain reference information, best practices for configuring the policy setting, default values, differences between operating system versions, and considerations for policy management and security.

|Group Policy Setting|Constant Name|
|------------|---------|
|[Access Credential Manager as a trusted caller](../group-managed-service-accounts/user-rights-assignment/access-credential-manager-as-a-trusted-caller.md)|SeTrustedCredManAccessPrivilege|
|[Access this computer from the network](access-this-computer-from-the-network.md)|SeNetworkLogonRight|
|[Act as part of the operating system](../group-managed-service-accounts/user-rights-assignment/act-as-part-of-the-operating-system.md)|SeTcbPrivilege|
|[Add workstations to domain](add-workstations-to-domain.md)|SeMachineAccountPrivilege|
|[Adjust memory quotas for a process](../group-managed-service-accounts/user-rights-assignment/adjust-memory-quotas-for-a-process.md)|SeIncreaseQuotaPrivilege|
|[Allow log on locally](../group-managed-service-accounts/user-rights-assignment/allow-log-on-locally.md)|SeInteractiveLogonRight|
|[Allow log on through Remote Desktop Services](../group-managed-service-accounts/user-rights-assignment/allow-log-on-through-remote-desktop-services.md)|SeRemoteInteractiveLogonRight|
|[Back up files and directories](../group-managed-service-accounts/user-rights-assignment/back-up-files-and-directories.md)|SeBackupPrivilege|
|[Bypass traverse checking](bypass-traverse-checking.md)|SeChangeNotifyPrivilege|
|[Change the system time](../group-managed-service-accounts/user-rights-assignment/change-the-system-time.md)|SeSystemtimePrivilege|
|[Change the time zone](../group-managed-service-accounts/user-rights-assignment/change-the-time-zone.md)|SeTimeZonePrivilege|
|[Create a pagefile](../group-managed-service-accounts/user-rights-assignment/create-a-pagefile.md)|SeCreatePagefilePrivilege|
|[Create a token object](../group-managed-service-accounts/user-rights-assignment/create-a-token-object.md)|SeCreateTokenPrivilege|
|[Create global objects](../group-managed-service-accounts/user-rights-assignment/create-global-objects.md)|SeCreateGlobalPrivilege|
|[Create permanent shared objects](../group-managed-service-accounts/user-rights-assignment/create-permanent-shared-objects.md)|SeCreatePermanentPrivilege|
|[Create symbolic links](../group-managed-service-accounts/user-rights-assignment/create-symbolic-links.md)|SeCreateSymbolicLinkPrivilege|
|[Debug programs](../group-managed-service-accounts/user-rights-assignment/debug-programs.md)|SeDebugPrivilege|
|[Deny access to this computer from the network](../group-managed-service-accounts/user-rights-assignment/deny-access-to-this-computer-from-the-network.md)|SeDenyNetworkLogonRight|
|[Deny log on as a batch job](../group-managed-service-accounts/user-rights-assignment/deny-log-on-as-a-batch-job.md)|SeDenyBatchLogonRight|
|[Deny log on as a service](../group-managed-service-accounts/user-rights-assignment/deny-log-on-as-a-service.md)|SeDenyServiceLogonRight|
|[Deny log on locally](../group-managed-service-accounts/user-rights-assignment/deny-log-on-locally.md)|SeDenyInteractiveLogonRight|
|[Deny log on through Remote Desktop Services](../group-managed-service-accounts/user-rights-assignment/deny-log-on-through-remote-desktop-services.md)|SeDenyRemoteInteractiveLogonRight|
|[Enable computer and user accounts to be trusted for delegation](../group-managed-service-accounts/user-rights-assignment/enable-computer-and-user-accounts-to-be-trusted-for-delegation.md)|SeEnableDelegationPrivilege|
|[Force shutdown from a remote system](../group-managed-service-accounts/user-rights-assignment/force-shutdown-from-a-remote-system.md)|SeRemoteShutdownPrivilege|
|[Generate security audits](../group-managed-service-accounts/user-rights-assignment/generate-security-audits.md)|SeAuditPrivilege|
|[Impersonate a client after authentication](../group-managed-service-accounts/user-rights-assignment/impersonate-a-client-after-authentication.md)|SeImpersonatePrivilege|
|[Increase a process working set](../group-managed-service-accounts/user-rights-assignment/increase-a-process-working-set.md)|SeIncreaseWorkingSetPrivilege|
|[Increase scheduling priority](../group-managed-service-accounts/user-rights-assignment/increase-scheduling-priority.md)|SeIncreaseBasePriorityPrivilege|
|[Load and unload device drivers](../group-managed-service-accounts/user-rights-assignment/load-and-unload-device-drivers.md)|SeLoadDriverPrivilege|
|[Lock pages in memory](../group-managed-service-accounts/user-rights-assignment/lock-pages-in-memory.md)|SeLockMemoryPrivilege|
|[Log on as a batch job](../group-managed-service-accounts/user-rights-assignment/log-on-as-a-batch-job.md)|SeBatchLogonRight|
|[Log on as a service](../group-managed-service-accounts/user-rights-assignment/log-on-as-a-service.md)|SeServiceLogonRight|
|[Manage auditing and security log](../group-managed-service-accounts/user-rights-assignment/manage-auditing-and-security-log.md)|SeSecurityPrivilege|
|[Modify an object label](../group-managed-service-accounts/user-rights-assignment/modify-an-object-label.md)|SeRelabelPrivilege|
|[Modify firmware environment values](../group-managed-service-accounts/user-rights-assignment/modify-firmware-environment-values.md)|SeSystemEnvironmentPrivilege|
|[Perform volume maintenance tasks](../group-managed-service-accounts/user-rights-assignment/perform-volume-maintenance-tasks.md)|SeManageVolumePrivilege|
|[Profile single process](../group-managed-service-accounts/user-rights-assignment/profile-single-process.md)|SeProfileSingleProcessPrivilege|
|[Profile system performance](../group-managed-service-accounts/user-rights-assignment/profile-system-performance.md)|SeSystemProfilePrivilege|
|[Remove computer from docking station](../group-managed-service-accounts/user-rights-assignment/remove-computer-from-docking-station.md)|SeUndockPrivilege|
|[Replace a process level token](../group-managed-service-accounts/user-rights-assignment/replace-a-process-level-token.md)|SeAssignPrimaryTokenPrivilege|
|[Restore files and directories](../group-managed-service-accounts/user-rights-assignment/restore-files-and-directories.md)|SeRestorePrivilege|
|[Shut down the system](../group-managed-service-accounts/user-rights-assignment/shut-down-the-system.md)|SeShutdownPrivilege|
|[Synchronize directory service data](../group-managed-service-accounts/user-rights-assignment/synchronize-directory-service-data.md)|SeSyncAgentPrivilege|
|[Take ownership of files or other objects](../group-managed-service-accounts/user-rights-assignment/take-ownership-of-files-or-other-objects.md)|SeTakeOwnershipPrivilege|


