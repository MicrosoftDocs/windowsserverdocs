---
title: Microsoft network server - Disconnect clients when logon hours expire
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3be03533-24c5-4253-9bea-b85cd0e04bdc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Microsoft network server: Disconnect clients when logon hours expire

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This policy setting enables or disables the forced disconnection of users who are connected to the local computer outside their user account's valid logon hours. It affects the SMB component. If you enable this policy setting, client computer sessions with the SMB service are forcibly disconnected when the client's logon hours expire. If you disable this policy setting, established client computer sessions are maintained after the client computer's logon hours expire.

### Possible values

-   Enabled

    Client computer sessions with the SMB service are forcibly disconnected when the client computer's logon hours expire. If logon hours are not used in your organization, enabling this policy setting will have no impact.

-   Disabled

    The system maintains an established client computer session after the client computer's logon hours have expired.

-   Not defined

### Best practices

1.  If you enable this policy setting, you should also enable **Network security: Force logoff when logon hours expire**.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy's property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Enabled|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Enabled|
|Client Computer Effective Default Settings|Enabled|

### Operating system version differences
The default setting of this policy in operating systems previous to Windows Server 2008 and Windows Vista is Disabled for stand-alone servers and client computers.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
When using Group Policy to distribute this policy setting, the default is different for Windows operating systems prior to Windows Server 2008.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If your organization configures logon hours for users, it makes sense to enable this policy setting. Otherwise, users who should not have access to network resources outside of their logon hours can continue to use those resources with sessions that were established during allowed hours.

### Countermeasure
Enable the **Microsoft network server: Disconnect clients when logon hours expire** setting.

### Potential impact
If logon hours are not used in your organization, this policy setting has no impact. If logon hours are used, existing user sessions are forcibly terminated when their logon hours expire.


