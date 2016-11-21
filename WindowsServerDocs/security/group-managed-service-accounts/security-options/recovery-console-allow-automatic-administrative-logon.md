---
title: Recovery console: Allow automatic administrative logon
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3751c94c-e5b1-4997-8bc9-993401b18477
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Recovery console: Allow automatic administrative logon

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting,

## Reference
This policy setting determines whether the Administrator account password must be provided before access to the computer is granted. If you enable this setting, the Administrator account is automatically logged on to the computer at the Recovery Console; no password is required.

The Recovery Console can be very useful when troubleshooting and repairing systems that cannot be restarted. However, enabling this policy setting so a user can automatically log on to the console is dangerous. Anyone can walk up to the server, shut it down by disconnecting the power, reboot it, select **Recovery Console** from the **Restart** menu, and then assume full control of the server.

### Possible values

-   Enabled

    The Administrator account is automatically logged on to the computer at the Recovery Console; no password is required

-   Disabled

    Automatic administrative logon is not allowed.

-   Not defined

    Automatic administrative logon is not allowed.

### Best practices

1.  Set **Recovery Console: Allow automatic administrative logon** to **Disabled**. This requires a user to enter a user name and password to access the Recovery Console account.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy's property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
There are differences in this policy between Windows operating systems beginning with Windows Server 2003.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
Setting and deploying this policy using Group Policy takes precedence over the setting on the local computer.

### Policy conflicts
None.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The Recovery Console can be very useful when you must troubleshoot and repair computers that do not start. However, allowing automatic logon to the Recovery Console can make it possible for someone to assume full control of the server.

### Countermeasure
Disable the **Recovery console: Allow automatic administrative logon** setting.

### Potential impact
Users must enter a user name and password to access the Recovery Console.


