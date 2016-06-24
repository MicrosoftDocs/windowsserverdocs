---
title: Restore files and directories
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51120bf8-7547-436d-9fa3-304ad9b61ea8
---
# Restore files and directories
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This security setting determines which users can bypass file, directory, registry, and other persistent object permissions when they restore backed up files and directories, and it determines which users can set valid security principals as the owner of an object.

Granting this user right to an account is similar to granting the account the following permissions to all files and folders on the system:

-   **Traverse folder / execute file**

-   **Write**

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeRestorePrivilege

### Possible values

-   User-defined list of accounts

-   Defaults

-   Not Defined

### Best practices

1.  Users with this user right can overwrite registry settings, hide data, and gain ownership of system objects, so only assign this user right to trusted users.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default, this right is granted to the Administrators, Backup Operators, and Server Operators groups on domain controllers, and to the Administrators and Backup Operators groups on stand-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy||
|Default Domain Controller Policy|Administrators<br /><br />Backup Operators<br /><br />Server Operators|
|Stand-Alone Server Default Settings|Administrators<br /><br />Backup Operators|
|Domain Controller Effective Default Settings|Administrators<br /><br />Backup Operators<br /><br />Server Operators|
|Member Server Effective Default Settings|Administrators<br /><br />Backup Operators|
|Client Computer Effective Default Settings|Administrators<br /><br />Backup Operators|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

### Group Policy
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
An attacker with the **Restore files and directories** user right could restore sensitive data to a computer and overwrite data that is more recent, which could lead to loss of important data, data corruption, or a denial-of-service condition. Attackers could overwrite executable files that are used by legitimate administrators or system services with versions that include malicious software to grant themselves elevated privileges, compromise data, or install programs that provide continued access to the computer.

> [!NOTE]
> Even if the following countermeasure is configured, an attacker could restore data to a computer in a domain that is controlled by the attacker. Therefore, it is critical that organizations carefully protect the media that are used to back up data.

### Countermeasure
Ensure that only the local Administrators group is assigned the **Restore files and directories** user right unless your organization has clearly defined roles for backup and for restore personnel.

### Potential impact
If you remove the **Restore files and directories** user right from the Backup Operators group and other accounts, users who are not members of the local Administrators group cannot load data backups. If restoring backups is delegated to a subset of IT staff in your organization, you should verify that this change does not negatively affect the ability of your organization's personnel to do their jobs.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


