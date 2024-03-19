---
description: Learn about event log monitoring in Active Directory to improve security
title: Monitoring Active Directory for Signs of Compromise
author: iainfoulds
ms.author: daveba
ms.date: 02/01/2023
ms.topic: article
---
# Monitoring Active Directory for Signs of Compromise

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

*Law Number Five: Eternal vigilance is the price of security.* - [10 Immutable Laws of Security Administration](/previous-versions/cc722488(v=technet.10))

A solid event log monitoring system is a crucial part of any secure Active Directory design. Many computer security compromises could be discovered early in the event if the targets enacted appropriate event log monitoring and alerting. Independent reports have long supported this conclusion. For example, the [2009 Verizon Data Breach Report](http://www.verizonbusiness.com/resources/security/reports/2009_databreach_rp.pdf) states:

"The apparent ineffectiveness of event monitoring and log analysis continues to be somewhat of an enigma. The opportunity for detection is there; investigators noted that 66 percent of victims had sufficient evidence available within their logs to discover the breach had they been more diligent in analyzing such resources."

This lack of monitoring active event logs remains a consistent weakness in many companies' security defense plans. The [2012 Verizon Data Breach report](http://www.verizonbusiness.com/resources/reports/rp_data-breach-investigations-report-2012_en_xg.pdf) found that even though 85 percent of breaches took several weeks to be noticed, 84 percent of victims had evidence of the breach in their event logs.

## Windows Audit Policy

The following are links to the Microsoft official enterprise support blog. The content of these blogs provides advice, guidance, and recommendations about auditing to assist you in enhancing the security of your Active Directory infrastructure and are a valuable resource when designing an audit policy.

* [Global Object Access Auditing is Magic](/archive/blogs/askds/global-object-access-auditing-is-magic) - Describes a control mechanism called Advanced Audit Policy Configuration added to Windows 7 and Windows Server 2008 R2 that lets you set what types of data you want to audit easily without having to juggle scripts and auditpol.exe.
* [Introducing Auditing Changes in Windows 2008](/archive/blogs/askds/introducing-auditing-changes-in-windows-2008) - Introduces the auditing changes made in Windows Server 2008.
* [Cool Auditing Tricks in Vista and 2008](/archive/blogs/askds/cool-auditing-tricks-in-vista-and-2008) - Explains interesting auditing features of Windows Vista and Windows Server 2008 that can be used for troubleshooting problems or seeing what's happening in your environment.
* [One-Stop Shop for Auditing in Windows Server 2008 and Windows Vista](/archive/blogs/askds/one-stop-shop-for-auditing-in-windows-server-2008-and-windows-vista) - Contains a compilation of auditing features and information contained in Windows Server 2008 and Windows Vista.

The following links provide information about improvements to Windows auditing in Windows 8 and Windows Server 2012, and information about AD DS auditing in Windows Server 2008.

* [What's New in Security Auditing](/previous-versions/orphan-topics/ws.11/hh849638(v=ws.11)) - Provides an overview of new security auditing features in Windows 8 and Windows Server 2012.
* [AD DS Auditing Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731607(v=ws.10)) - Describes the new Active Directory Domain Services (AD DS) auditing feature in Windows Server 2008. Also provides procedures to implement this new feature.

### Windows Audit Categories

Prior to Windows Vista and Windows Server 2008, Windows had only nine event log audit policy categories:

* Account Logon Events
* Account Management
* Directory Service Access
* Logon Events
* Object Access
* Policy Change
* Privilege Use
* Process Tracking
* System Events

These nine traditional audit categories comprise an audit policy. Each audit policy category can be enabled for Success, Failure, or Success and Failure events. Their descriptions are included in the next section.

#### Audit Policy Category Descriptions

The audit policy categories enable the following event log message types.

##### Audit Account Logon Events

Audit Account Logon Events report each instance of a security principal (for example, user, computer, or service account) that's logging on to or logging off from one computer when another computer is used to validate the account. Account logon events are generated when a domain security principal account is authenticated on a domain controller. Authentication of a local user on a local computer generates a logon event that's logged in the local security log. No account logoff events are logged.

This category generates a lot of "noise" because Windows is constantly having accounts logging on to and off of the local and remote computers during the normal course of business. Despite this inconvenience, every security plan should include the success and failure of this audit category.

##### Audit Account Management

This audit setting determines whether to track management of users and groups. For example, users and groups should be tracked when a user or computer account, a security group, or a distribution group is created, changed, or deleted. Users and groups should also be tracked when a user or computer account is renamed, disabled, or enabled, and when a user or computer password is changed. An event can be generated for users or groups added to or removed from other groups.

##### Audit Directory Service Access

This policy setting determines whether to audit security principal access to an Active Directory object that has its own specified system access control list (SACL). In general, this category should only be enabled on domain controllers. This setting generates a lot of "noise" if enabled.

##### Audit Logon Events

Logon events are generated when a local security principal is authenticated on a local computer. Logon Events records domain logons that occur on the local computer. Account logoff events are not generated. When enabled, Logon Events generates a lot of "noise," but this policy nevertheless should be enabled by default in any security auditing plan.

##### Audit Object Access

Object Access can generate events when subsequently defined objects with auditing enabled are accessed (for example, Opened, Read, Renamed, Deleted, or Closed). After the main auditing category is enabled, the administrator must individually define which objects will have auditing enabled. Many Windows system objects come with auditing enabled, so enabling this category will usually begin to generate events before the administrator has defined any.

This category is very "noisy" and will generate five to 10 events for each object access. It can be difficult for administrators new to object auditing to gain useful information. It should only be enabled when needed.

##### Auditing Policy Change

This policy setting determines whether to audit every incidence of a change to user rights assignment policies, Windows Firewall policies, Trust policies, or changes to the audit policy. This category should be enabled on all computers. It generates very little "noise."

##### Audit Privilege Use

There are dozens of user rights and permissions in Windows (for example, Logon as a Batch Job and Act as Part of the Operating System). This policy setting determines whether to audit each instance of a security principal by exercising a user right or privilege. Enabling this category results in a lot of "noise," but it can be helpful in tracking security principal accounts using elevated privileges.

##### Audit Process Tracking

This policy setting determines whether to audit detailed process tracking information for events such as program activation, process exit, handle duplication, and indirect object access. It's useful for tracking malicious users and the programs they use.

Enabling Audit Process Tracking generates a large number of events, so typically it's set to **No Auditing**. However, this setting can provide a great benefit during an incident response from the detailed log of the processes started and the time they were launched. For domain controllers and other single-role infrastructure servers, this category can be safely turned on all the time. Single role servers don't generate much process tracking traffic during the normal course of their duties. As such, they can be enabled to capture unauthorized events if they occur.

##### System Events Audit

System Events is almost a generic catch-all category, registering various events that impact the computer, its system security, or the security log. It includes events for computer shutdowns and restarts, power failures, system time changes, authentication package initializations, audit log clearings, impersonation issues, and a host of other general events. In general, enabling this audit category generates a lot of "noise," but it generates enough very useful events that it's difficult to ever recommend not enabling it.

#### Advanced Audit Policies

Starting with Windows Vista and Windows Server 2008, Microsoft improved the way event log category selections can be made by creating subcategories under each main audit category. Subcategories allow auditing to be far more granular than it could otherwise by using the main categories. By using subcategories, you can enable only portions of a particular main category and skip generating events that aren't useful. Each audit policy subcategory can be enabled for Success, Failure, or Success and Failure events.

To list all the available auditing subcategories, review the Advanced Audit Policy container in a Group Policy Object or type the following command on any computer running Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows 8, Windows 7, or Windows Vista:

`auditpol /list /subcategory:*`

To get a list of currently configured auditing subcategories on a computer running Windows Server 2012, Windows Server 2008 R2, or Windows 2008, type the following command:

`auditpol /get /category:*`

The following screenshot shows an example of auditpol.exe listing the current audit policy.

![Screenshot that shows an example of auditpol.exe listing the current audit policy.](media/Monitoring-Active-Directory-for-Signs-of-Compromise/SAD_5.gif)

> [!NOTE]
> Group Policy does not always accurately report the status of all enabled auditing policies, whereas auditpol.exe does. See [Getting the Effective Audit Policy in Windows 7 and 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731607(v=ws.10)) for more details.

Each main category has multiple subcategories. Below is a list of categories, their subcategories and descriptions of their functions.

### Auditing Subcategories Descriptions

Audit policy subcategories enable the following event log message types:

#### Account Logon

##### Credential Validation

This subcategory reports the results of validation tests on credentials submitted for a user account logon request. These events occur on the computer that's authoritative for the credentials. For domain accounts, the domain controller is authoritative; for local accounts the local computer is authoritative.

In domain environments, most of the account logon events are logged in the security log of the domain controllers that are authoritative for the domain accounts. However, these events can occur on other computers in the organization when local accounts are used to log on.

##### Kerberos Service Ticket Operations

This subcategory reports events generated by Kerberos ticket request processes on the domain controller that's authoritative for the domain account.

##### Kerberos Authentication Service

This subcategory reports events generated by the Kerberos authentication service. These events occur on the computer that's authoritative for the credentials.

##### Other Account Logon Events

This subcategory reports the events that occur in response to credentials submitted for a user account logon request that don't relate to credential validation or Kerberos tickets. These events occur on the computer that's authoritative for the credentials. For domain accounts, the domain controller is authoritative, whereas for local accounts, the local computer is authoritative.

In domain environments, most account logon events are logged in the security log of the domain controllers that are authoritative for the domain accounts. However, these events can occur on other computers in the organization when local accounts are used to log on. Examples can include the following:

* Remote Desktop Services session disconnections
* New Remote Desktop Services sessions
* Locking and unlocking a workstation
* Invoking a screen saver
* Dismissing a screen saver
* Detection of a Kerberos replay attack, in which a Kerberos request with identical information is received twice
* Access to a wireless network granted to a user or computer account
* Access to a wired 802.1x network granted to a user or computer account

#### Account Management

##### User Account Management

This subcategory reports each event of user account management, such as:

* User account created, changed, or deleted
* User account renamed, disabled, or enabled
* Password set or changed

If this audit policy setting is enabled, administrators can track events to detect malicious, accidental, and authorized creation of user accounts.

##### Computer Account Management

This subcategory reports each event of computer account management, such as when a computer account is created, changed, deleted, renamed, disabled, or enabled.

##### Security Group Management

This subcategory reports each event of security group management, such as when a security group is created, changed, or deleted or when a member is added to or removed from a security group. If this audit policy setting is enabled, administrators can track events to detect malicious, accidental, and authorized creation of security group accounts.

##### Distribution Group Management

This subcategory reports each event of distribution group management, such as when a distribution group is created, changed, or deleted or when a member is added to or removed from a distribution group. If this audit policy setting is enabled, administrators can track events to detect malicious, accidental, and authorized creation of group accounts.

##### Application Group Management

This subcategory reports each event of application group management on a computer, such as when an application group is created, changed, or deleted or when a member is added to or removed from an application group. If this audit policy setting is enabled, administrators can track events to detect malicious, accidental, and authorized creation of application group accounts.

##### Other Account Management Events

This subcategory reports other account management events.

#### Detailed Process Tracking

Detailed Process Tracking monitoring includes both creation and termination of processes. 

##### Process Creation

This subcategory reports the creation of a process and the name of the user or program that created it.

##### Process Termination

This subcategory reports when a process terminates.

##### DPAPI Activity

This subcategory reports encrypt or decrypt calls into the data protection application programming interface (DPAPI). DPAPI is used to protect secret information such as stored password and key information.

##### RPC Events

This subcategory reports remote procedure call (RPC) connection events.

#### Directory Service Access

##### Directory Service Access

This subcategory reports when an AD DS object is accessed. Only objects with configured SACLs cause audit events to be generated, and only when they are accessed in a manner that matches the SACL entries. These events are similar to the directory service access events in earlier versions of Windows Server. This subcategory applies only to domain controllers.

##### Directory Service Changes

This subcategory reports changes to objects in AD DS. The types of changes that are reported are create, modify, move, and undelete operations that are performed on an object. Directory service change auditing, where appropriate, indicates the old and new values of the changed properties of the objects that were changed. Only objects with SACLs cause audit events to be generated, and only when they are accessed in a manner that matches their SACL entries. Some objects and properties don't cause audit events to be generated due to settings on the object class in the schema. This subcategory applies only to domain controllers.

##### Directory Service Replication

This subcategory reports when replication between two domain controllers begins and ends.

##### Detailed Directory Service Replication

This subcategory reports detailed information about the information replicated between domain controllers. These events can be very high in volume.

#### Logon/Logoff

##### Logon

This subcategory reports when a user attempts to log on to the system. These events occur on the accessed computer. For interactive logons, the generation of these events occurs on the computer the user is logged on to. If a network logon takes place to access a share, these events generate on the computer that hosts the accessed resource. If this setting is configured to **No auditing**, it's difficult or impossible to determine which user has accessed or attempted to access organization computers.

##### Network Policy Server

This subcategory reports events generated by RADIUS (IAS) and Network Access Protection (NAP) user access requests. These requests can be **Grant**, **Deny**, **Discard**, **Quarantine**, **Lock**, and **Unlock**. Auditing this setting will result in a medium or high volume of records on NPS and IAS servers.

##### IPsec Main Mode

This subcategory reports the results of Internet Key Exchange (IKE) protocol and Authenticated Internet Protocol (AuthIP) during Main Mode negotiations.

##### IPsec Extended Mode

This subcategory reports the results of AuthIP during Extended Mode negotiations.

##### Other Logon/Logoff Events

This subcategory reports other logon and logoff-related events, such as Remote Desktop Services session disconnects and reconnects, using RunAs to run processes under a different account, and locking and unlocking a workstation.

##### Logoff

This subcategory reports when a user logs off the system. These events occur on the accessed computer. For interactive logons, the generation of these events occurs on the computer the user is logged on to. If a network logon takes place to access a share, these events generate on the computer that hosts the accessed resource. If this setting is configured to **No auditing**, it's difficult or impossible to determine which user has accessed or attempted to access organization computers.

##### Account Lockout

This subcategory reports when a user's account is locked out as a result of too many failed logon attempts.

##### IPsec Quick Mode

This subcategory reports the results of IKE protocol and AuthIP during Quick Mode negotiations.

##### Special Logon

This subcategory reports when a special logon is used. A special logon is a logon that has administrator equivalent privileges and can be used to elevate a process to a higher level.

#### Policy Change

##### Audit Policy Change

This subcategory reports changes in audit policy including SACL changes.

##### Authentication Policy Change

This subcategory reports changes in authentication policy.

##### Authorization Policy Change

This subcategory reports changes in authorization policy including permissions (DACL) changes.

##### MPSSVC Rule-Level Policy Change

This subcategory reports changes in policy rules used by the Microsoft Protection Service (MPSSVC.exe). This service is used by Windows Firewall.

##### Filtering Platform Policy Change

This subcategory reports the addition and removal of objects from WFP, including startup filters. These events can be very high in volume.

##### Other Policy Change Events

This subcategory reports other types of security policy changes such as configuration of the Trusted Platform Module (TPM) or cryptographic providers.

#### Privilege Use

Privilege Use covers both sensitive and nonsensitive privileges.

##### Sensitive Privilege Use

This subcategory reports when a user account or service uses a sensitive privilege. A sensitive privilege includes the following user rights:

* Act as part of the operating system
* Back up files and directories
* Create a token object, debug programs
* Enable computer and user accounts to be trusted for delegation
* Generate security audits, impersonate a client after authentication
* Load and unload device drivers
* Manage auditing and security log
* Modify firmware environment values
* Replace a process-level token, restore files and directories
* Take ownership of files or other objects. 

Auditing this subcategory will create a high volume of events.

##### Nonsensitive Privilege Use

This subcategory reports when a user account or service uses a nonsensitive privilege. A nonsensitive privilege includes the following user rights: 

* Access Credential Manager as a trusted caller
* Access this computer from the network
* Add workstations to domain
* Adjust memory quotas for a process
* Allow log on locally
* Allow log on through Remote Desktop Services
* Bypass traverse checking
* Change the system time
* Create a pagefile
* Create global objects
* Create permanent shared objects
* Create symbolic links
* Deny access this computer from the network
* Deny log on as a batch job
* Deny log on as a service
* Deny log on locally
* Deny log on through Remote Desktop Services
* Force shutdown from a remote system
* Increase a process working set
* Increase scheduling priority
* Lock pages in memory
* Log on as a batch job
* Log on as a service
* Modify an object label
* Perform volume maintenance tasks
* Profile single process
* Profile system performance
* Remove computer from docking station
* Shut down the system
* Synchronize directory service data. 

Auditing this subcategory will create a very high volume of events.

##### Other Privilege Use Events

This security policy setting is not currently used.

#### Object Access

The Object Access category includes File System and Registry subcategories.

##### File System

This subcategory reports when file system objects are accessed. Only file system objects with SACLs cause audit events to be generated, and only when they are accessed in a manner matching their SACL entries. By itself, this policy setting won't cause auditing of any events. It determines whether to audit the event of a user who accesses a file system object that has a specified system access control list (SACL), effectively enabling auditing to take place.

If the audit object access setting is configured to **Success**, an audit entry is generated each time that a user successfully accesses an object with a specified SACL. If this policy setting is configured to **Failure**, an audit entry is generated each time that a user fails in an attempt to access an object with a specified SACL.

##### Registry

This subcategory reports when registry objects are accessed. Only registry objects with SACLs cause audit events to be generated, and only when they are accessed in a manner matching their SACL entries. By itself, this policy setting won't cause auditing of any events.

##### Kernel Object

This subcategory reports when kernel objects such as processes and mutexes are accessed. Only kernel objects with SACLs cause audit events to be generated, and only when they are accessed in a manner matching their SACL entries. Typically kernel objects are only given SACLs if the AuditBaseObjects or AuditBaseDirectories auditing options are enabled.

##### SAM

This subcategory reports when local Security Accounts Manager (SAM) authentication database objects are accessed.

##### Certification Services

This subcategory reports when Certification Services operations are performed.

##### Application Generated

This subcategory reports when applications attempt to generate audit events by using the Windows auditing application programming interfaces (APIs).

##### Handle Manipulation

This subcategory reports when a handle to an object is opened or closed. Only objects with SACLs cause these events to be generated, and only if the attempted handle operation matches the SACL entries. Handle Manipulation events are only generated for object types where the corresponding object access subcategory is enabled (for example, file system or registry).

##### File Share

This subcategory reports when a file share is accessed. By itself, this policy setting won't cause auditing of any events. It determines whether to audit the event of a user who accesses a file share object that has a specified system access control list (SACL), effectively enabling auditing to take place.

##### Filtering Platform Packet Drop

This subcategory reports when packets are dropped by Windows Filtering Platform (WFP). These events can be very high in volume.

##### Filtering Platform Connection

This subcategory reports when connections are allowed or blocked by WFP. These events can be high in volume.

##### Other Object Access Events

This subcategory reports other object access-related events such as Task Scheduler jobs and COM+ objects.

#### System

##### Security State Change

This subcategory reports changes in security state of the system, such as when the security subsystem starts and stops.

##### Security System Extension

This subcategory reports the loading of extension code such as authentication packages by the security subsystem.

##### System Integrity

This subcategory reports on violations of integrity of the security subsystem.

###### IPsec Driver

This subcategory reports on the activities of the Internet Protocol security (IPsec) driver.

##### Other System Events

This subcategory reports on other system events.

For more information about the subcategory descriptions, refer to the [Microsoft Security Compliance Manager tool](/previous-versions/tn-archive/cc677002(v=technet.10)).

Each organization should review the previous covered categories and subcategories and enable the ones which best fit their environment. Changes to audit policy should always be tested prior to deployment in a production environment.

## Configuring Windows Audit Policy

Windows audit policy can be set using group policies, auditpol.exe, APIs, or registry edits. The recommended methods for configuring audit policy for most companies are Group Policy or auditpol.exe. Setting a system's audit policy requires administrator-level account permissions or the appropriate delegated permissions.

> [!NOTE]
> The **Manage auditing and security log** privilege must be given to security principals (Administrators have it by default) to allow the modification of object access auditing options of individual resources, such as files, Active Directory objects, and registry keys.

### Setting Windows Audit Policy by Using Group Policy

To set audit policy using group policies, configure the appropriate audit categories located under **Computer Configuration\Windows Settings\Security Settings\Local Policies\Audit Policy** (see the following screenshot for an example from the Local Group Policy Editor (gpedit.msc)). Each audit policy category can be enabled for **Success**, **Failure**, or **Success** and Failure events.

![monitoring AD](media/Monitoring-Active-Directory-for-Signs-of-Compromise/SAD_6.gif)

Advanced Audit Policy can be set by using Active Directory or local group policies. To set Advanced Audit Policy, configure the appropriate subcategories located under **Computer Configuration\Windows Settings\Security Settings\Advanced Audit Policy** (see the following screenshot for an example from the Local Group Policy Editor (gpedit.msc)). Each audit policy subcategory can be enabled for **Success**, **Failure**, or **Success** and **Failure** events.

![Screenshot that shows an example from the Local Group Policy Editor (gpedit.msc).](media/Monitoring-Active-Directory-for-Signs-of-Compromise/SAD_7.gif)

### Setting Windows Audit Policy Using Auditpol.exe

Auditpol.exe (for setting Windows audit policy) was introduced in Windows Server 2008 and Windows Vista. Initially, only auditpol.exe could be used to set Advanced Audit Policy, but Group Policy can be used in Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008, Windows 8, and Windows 7.

Auditpol.exe is a command-line utility. The syntax is as follows:

`auditpol /set /<Category|Subcategory>:<audit category> /<success|failure:> /<enable|disable>`

Auditpol.exe syntax examples:

`auditpol /set /subcategory:"user account management" /success:enable /failure:enable`

`auditpol /set /subcategory:"logon" /success:enable /failure:enable`

`auditpol /set /subcategory:"IPSEC Main Mode" /failure:enable`

> [!NOTE]
> Auditpol.exe sets Advanced Audit Policy locally. If local policy conflicts with Active Directory or local Group Policy, Group Policy settings usually prevail over auditpol.exe settings. When multiple group or local policy conflicts exist, only one policy will prevail (that is, replace). Audit policies won't merge.

#### Scripting Auditpol

Microsoft provides a [sample script](/troubleshoot/windows-server/group-policy/configure-group-policies-set-security) for administrators who want to set Advanced Audit Policy by using a script instead of manually typing in each auditpol.exe command.

**Note** Group Policy does not always accurately report the status of all enabled auditing policies, whereas auditpol.exe does. See [Getting the Effective Audit Policy in Windows 7 and Windows 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731607(v=ws.10)) for more details.

#### Other Auditpol Commands

Auditpol.exe can be used to save and restore a local audit policy, and to view other auditing related commands. Here are the other **auditpol** commands.

`auditpol /clear` - Used to clear and reset local audit policies

`auditpol /backup /file:<filename>` - Used to back up a current local audit policy to a binary file

`auditpol /restore /file:<filename>` - Used to import a previously saved audit policy file to a local audit policy

`auditpol /<get/set> /option:<CrashOnAuditFail> /<enable/disable>` - If this audit policy setting is enabled, it causes the system to immediately stop (with STOP: C0000244 {Audit Failed} message) if a security audit can't be logged for any reason. Typically, an event fails to be logged when the security audit log is full and the retention method specified for the security log is **Do Not Overwrite Events** or **Overwrite Events by Days**. Usually this policy is only enabled in environments that need higher assurance that the security log is logging. If enabled, administrators must closely watch security log size and rotate logs as required. It can also be set with Group Policy by modifying the security option **Audit: Shut down system immediately if unable to log security audits** (default=disabled).

`auditpol /<get/set> /option:<AuditBaseObjects> /<enable/disable>` - This audit policy setting determines whether to audit the access of global system objects. If this policy is enabled, it causes system objects, such as mutexes, events, semaphores, and DOS devices to be created with a default system access control list (SACL). Most administrators consider auditing global system objects to be too "noisy," and they'll only enable it if malicious hacking is suspected. Only named objects are given a SACL. If the audit object access audit policy (or Kernel Object audit subcategory) is also enabled, access to these system objects is audited. When configuring this security setting, change won't take effect until you restart Windows. This policy can also be set with Group Policy by modifying the security option Audit the access of global system objects (default=disabled).

`auditpol /<get/set> /option:<AuditBaseDirectories> /<enable/disable>` - This audit policy setting specifies that named kernel objects (such as mutexes and semaphores) are to be given SACLs when they are created. AuditBaseDirectories affects container objects while AuditBaseObjects affects objects that can't contain other objects.

`auditpol /<get/set> /option:<FullPrivilegeAuditing> /<enable/disable>` -  This audit policy setting specifies whether the client generates an event when one or more of the following privileges are assigned to a user security token: 

* AssignPrimaryTokenPrivilege
* AuditPrivilege
* BackupPrivilege
* CreateTokenPrivilege
* DebugPrivilege
* EnableDelegationPrivilege
* ImpersonatePrivilege
* LoadDriverPrivilege
* RestorePrivilege
* SecurityPrivilege
* SystemEnvironmentPrivilege
* TakeOwnershipPrivilege
* TcbPrivilege. 

If this option is not enabled (default=Disabled), the BackupPrivilege and RestorePrivilege privileges aren't recorded. Enabling this option can make the security log extremely noisy (sometimes hundreds of events per second) during a backup operation. This policy can also be set with Group Policy by modifying the security option **Audit: Audit the use of Backup and Restore privilege**.

> [!NOTE]
> Some information provided here is taken from the Microsoft [Audit Option Type](/openspecs/windows_protocols/ms-gpac/262a2bed-93d4-4c04-abec-cf06e9ec72fd) and the Microsoft SCM tool.

## Enforcing Traditional Auditing or Advanced Auditing

In Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows 8, Windows 7, and Windows Vista, administrators can choose to enable the nine traditional categories or to use the subcategories. It's a binary choice that must be made in each Windows system. Either the main categories can be enabled or the subcategories; it can't be both.

To prevent the legacy traditional category policy from overwriting audit policy subcategories, you must enable the **Force audit policy subcategory settings(Windows Vista or later) to override audit policy category settings** policy setting located under **Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**.

We recommend that the subcategories be enabled and configured instead of the nine main categories. This requires that a Group Policy setting be enabled (to allow subcategories to override the auditing categories) along with configuring the different subcategories that support auditing policies.

Auditing subcategories can be configured by using several methods, including Group Policy and the command-line program, auditpol.exe.

## Next steps

* [Auditing and Compliance in Windows Server 2008](/previous-versions/technet-magazine/cc194392(v=msdn.10))

* [How to use Group Policy to configure detailed security auditing settings for Windows Vista-based and Windows Server 2008-based computers in a Windows Server 2008 domain, in a Windows Server 2003 domain, or in a Windows 2000 domain](/troubleshoot/windows-server/group-policy/configure-group-policies-set-security)

* [Advanced Security Audit Policy Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd408940(v=ws.10))
