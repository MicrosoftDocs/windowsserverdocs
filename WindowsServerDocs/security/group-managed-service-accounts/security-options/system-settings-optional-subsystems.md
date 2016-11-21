---
title: System settings: Optional subsystems
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe64095d-663f-43ff-a162-bde465144b5c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# System settings: Optional subsystems

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines which subsystems support your applications. You can use this security setting to specify as many subsystems as your environment demands.

The subsystem introduces a security risk that is related to processes that can potentially persist across logons. If a user starts a process and then logs out, the next user who logs on to the system might access the process that the previous user started. This is dangerous, because the process started by the first user can retain that user's system user rights; therefore, anything that the second user does using that process is performed with the user rights of the first user. This makes it difficult to trace who creates processes and objects, which is essential for post-security incident forensics.

### Possible values

-   User-defined list of subsystems

-   Not defined

### Best practices

1.  Set this policy setting to a null value. The default value is **POSIX**, so applications that rely on the POSIX subsystem will no longer run. For example, Microsoft Services for UNIX 3.0 installs an updated version of the POSIX subsystem. Reset this policy setting in Group Policy for any servers that use Services for UNIX 3.0.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|POSIX|
|DC Effective Default Settings|POSIX|
|Member Server Effective Default Settings|POSIX|
|Client Computer Effective Default Settings|POSIX|

### Operating system version differences
There are no differences for this policy between operating systems beginning with Windows Server 2003.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The POSIX subsystem is an Institute of Electrical and Electronic Engineers (IEEE) standard that defines a set of operating system services. The POSIX subsystem is required if the server supports applications that use that subsystem.

The POSIX subsystem introduces a security risk that relates to processes that can potentially persist across logons. If a user starts a process and then logs out, there is a potential that the next user who logs on to the computer could access the previous user's process. This would allow the second user to take actions on the process by using the privileges of the first user.

### Countermeasure
Configure the **System settings: Optional subsystems setting** to a null value. The default value is POSIX.

### Potential impact
Applications that rely on the POSIX subsystem no longer operate. For example, Microsoft Services for UNIX (SFU) installs an updated version of the POSIX subsystem that is required, so you must reconfigure this setting in Group Policy for any servers that use SFU.


