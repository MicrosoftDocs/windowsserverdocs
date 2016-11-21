---
title: Log on as a batch job
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 06adae4a-63e0-4582-9c0a-aee716030bc9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Log on as a batch job

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which accounts can log on by using a batch-queue tool such as the Task Scheduler service. When an administrator uses the Add Scheduled Task Wizard to schedule a task to run under a particular user name and password, that user is automatically assigned the **Log on as a batch job** user right. When the scheduled time arrives, the Task Scheduler service logs on the user as a batch job instead of as an interactive user, and the task runs in the user's security context.

This policy setting is provides compatibility with older versions of Windows.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeBatchLogonRight

### Possible values

-   User-defined list of accounts

-   Default values

-   Not Defined

### Best practices

1.  Use discretion when assigning this right to specific users for security reasons. The default settings are sufficient in most cases.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default, this setting is for Administrators, Backup Operators, and Performance Log Users on domain controllers and on stand-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Administrators<br /><br />Backup Operators<br /><br />Performance Log Users|
|Stand-Alone Server Default Settings|Administrators<br /><br />Backup Operators<br /><br />Performance Log Users|
|Domain Controller Effective Default Settings|Administrators<br /><br />Backup Operators<br /><br />Performance Log Users|
|Member Server Effective Default Settings|Administrators<br /><br />Backup Operators<br /><br />Performance Log Users|
|Client Computer Effective Default Settings|Administrators|

### Operating system version differences
In  Windows Server 2008 R2 , the Performance Log Users group was added as a default group for this policy setting. No other changes were made in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

### Group Policy
Task Scheduler automatically grants this right when a user schedules a task. To override this behavior use the [Deny log on as a batch job](deny-log-on-as-a-batch-job.md) User Rights Assignment setting.

Group Policy settings are applied in the following order, which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The **Log on as a batch job** user right presents a low-risk vulnerability. For most organizations, the default settings are sufficient. Members of the local Administrators group have this right by default.

### Countermeasure
You should allow the computer to manage this user right automatically if you want to allow scheduled tasks to run for specific user accounts. If you do not want to use the Task Scheduler in this manner, configure the **Log on as a batch job** user right for only the Local Service account.

For IIS servers, you should configure this policy locally instead of through domain???based Group Policy settings so that you can ensure the local IUSR_*<ComputerName>* and IWAM_*<ComputerName>* accounts have this user right.

### Potential impact
If you configure the **Log on as a batch job** setting by using domain-based Group Policy settings, the computer cannot assign the user right to accounts that are used for scheduled jobs in the Task Scheduler. If you install optional components such as ASP.NET or IIS, you may need to assign this user right to additional accounts that are required by those components. For example, IIS requires assignment of this user right to the IIS_WPG group and the IUSR_*<ComputerName>*, ASPNET, and IWAM_*<ComputerName>* accounts. If this user right is not assigned to this group and these accounts, IIS cannot run some COM objects that are necessary for proper functionality.

## See Also
[User Rights Assignment](user-rights-assignment.md)


