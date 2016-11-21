---
title: Accounts: Guest account status
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f7e2456-cd59-449e-aea4-15af11b440c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Accounts: Guest account status

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting

## Reference
The **Accounts: Guest account status** policy setting determines whether the Guest account is enabled or disabled.

This account allows unauthenticated network users to gain access to the system by logging on as a Guest with no password. Unauthorized users can access any resources that are accessible to the Guest account over the network. This means that any network shared folders with permissions that allow access to the Guest account, the Guests group, or the Everyone group will be accessible over the network. This can lead to the exposure or corruption of data.

### Possible values

-   Enabled

-   Disabled

-   Not defined

### Best practices
Set **Accounts: Guest account status** to Disabled so that the built-in Guest account is no longer usable. All network users will have to authenticate before they can access shared resources on the system. If the Guest account is disabled and **Network access: Sharing and security model for local accounts** is set to **Guest only**, network logons'uch as those performed by the SMB Service???will fail.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The default Guest account allows unauthenticated network users to log on as a Guest with no password. These unauthorized users could access any resources that are accessible to the Guest account over the network. This capability means that any shared folders with permissions that allow access to the Guest account, the Guests group, or the Everyone group are accessible over the network, which could lead to the exposure or corruption of data.

### Countermeasure
Disable the **Accounts: Guest account status** setting so that the built-in Guest account cannot be used.

### Potential impact
All network users must be authenticated before they can access shared resources. If you disable the Guest account and the **Network Access: Sharing and Security Model** option is set to **Guest Only**, network logons, such as those performed by the Microsoft Network Server (SMB Service), fail. This policy setting should have little impact on most organizations because it is the default setting in the  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003,  Windows 7 , Windows Vista, Windows XP, and Microsoft Windows 2000 operating systems.


