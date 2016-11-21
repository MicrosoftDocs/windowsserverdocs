---
title: Perform volume maintenance tasks
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 83c1d2cc-86f1-4498-bdb2-12570cb023c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Perform volume maintenance tasks

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which users can perform volume or disk management tasks, such as defragmenting an existing volume, creating or removing volumes, and running the Disk Cleanup tool.

Use caution when assigning this user right. Users with this user right can explore disks and extend files in to memory that contains other data. When the extended files are opened, the user might be able to read and modify the acquired data.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeManageVolumePrivilege

### Possible values

-   User-defined list of accounts

-   Not Defined

### Best practices

1.  Ensure that only the local Administrators group is assigned the **Perform volume maintenance tasks** user right.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default this setting is Administrators on domain controllers and on stand-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Administrators|
|Stand-Alone Server Default Settings|Administrators|
|DC Effective Default Settings|Administrators|
|Member Server Effective Default Settings|Administrators|
|Client Computer Effective Default Settings|Administrators|

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
A user who is assigned the **Perform volume maintenance tasks** user right could delete a volume, which could result in the loss of data or a denial-of- service condition. Also, disk maintenance tasks can be used to modify data on the disk, such as user rights assignments that might lead to escalation of privileges.

### Countermeasure
Ensure that only the local Administrators group is assigned the **Perform volume maintenance tasks** user right.

### Potential impact
None. Restricting the **Perform volume maintenance tasks** user right to the local Administrators group is the default configuration.

## See Also
[User Rights Assignment](user-rights-assignment.md)


