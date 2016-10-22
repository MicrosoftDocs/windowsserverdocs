---
title: Create permanent shared objects
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7acbe703-4d0e-4158-bfd5-681fd69875bf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Create permanent shared objects

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This user right determines which accounts can be used by processes to create a directory object by using the object manager. Directory objects include Active Directory objects, files and folders, printers, registry keys, processes, and threads. Users who have this capability can create permanent shared objects, including devices, semaphores, and mutexes. This user right is useful to kernel-mode components that extend the object namespace. Because components that are running in kernel-mode inherently have this user right assigned to them, it is not necessary to specifically assign it.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeCreatePermanentPrivilege

### Possible values

-   User-defined list of accounts

-   Not Defined

### Best practices

1.  Users who have the **Create permanent shared objects** user right could create new shared objects and expose sensitive data to the network. Therefore, do not assign this right to any users.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default, **LocalSystem** is the only account that has this right.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not Defined|
|Default Domain Controller Policy|Not Defined|
|Stand-Alone Server Default Settings|Not Defined|
|Domain Controller Effective Default Settings|**LocalSystem**|
|Member Server Effective Default Settings|**LocalSystem**|
|Client Computer Effective Default Settings|**LocalSystem**|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes different features and tools available to help you manage this policy.

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
Users who have the **Create permanent shared objects** user right could create new shared objects and expose sensitive data to the network.

### Countermeasure
Do not assign the **Create permanent shared objects** user right to any users. Processes that require this user right should use the System account, which already includes this user right, instead of a separate user account.

### Potential impact
None. Not Defined is the default configuration.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


