---
title: Domain member - Require strong (Windows 2000 or later) session key
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7b70a41e-d8a3-409a-bbc6-04f478af7051
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Domain member: Require strong (Windows 2000 or later) session key

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
The **Domain member: Require strong (Windows 2000 or later) session key** policy setting determines whether a secure channel can be established with a domain controller that is not capable of encrypting secure channel traffic with a strong, 128-bit session key. Enabling this policy setting prevents establishing a secure channel with any domain controller that cannot encrypt secure channel data with a strong key. Disabling this policy setting allows 64-bit session keys.

Whenever possible, you should take advantage of these stronger session keys to help protect secure channel communications from eavesdropping and session-hijacking network attacks. Eavesdropping is a form of hacking in which network data is read or altered in transit. The data can be modified to hide or change the name of the sender, or it can be redirected.

### Possible values

-   Enabled

    When enabled on a member workstation or server, all domain controllers in the domain that the member belongs to must be capable of encrypting secure channel data with a strong, 128-bit key. This means that all such domain controllers must be running the  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003, or Windows 2000 operating system.

-   Disabled

    Allows 64-bit session keys to be used.

-   Not defined.

### Best practices

1.  It is advisable to set **Domain member: Require strong (Windows 2000 or later) session key** to Enabled. Enabling this policy setting ensures that all outgoing secure channel traffic will require a strong encryption key. Disabling this policy setting requires that key strength be negotiated. Only enable this option if the domain controllers in all trusted domains support strong keys. By default, this value is disabled.

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
Modifying this setting may affect compatibility with clients, services, and applications running on Windows operating systems beginning with Windows 2000 Server.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
Misuse of this policy setting is a common error that can cause data loss or problems with data access or security.

You will not be able to join computers that have this policy setting enabled to Windows NT 4.0 domains, nor will you be able to join computers that do not support this policy setting to domains where the domain controllers have this policy setting enabled.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Session keys that are used to establish secure channel communications between domain controllers and member computers are much stronger in  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003, and Windows 2000 than they were in previous Windows operating systems.

Whenever possible, you should take advantage of these stronger session keys to help protect secure channel communications from attacks that attempt to hijack network sessions and eavesdrop. (Eavesdropping is a form of hacking in which network data is read or altered in transit. The data can be modified to hide or change the sender, or be redirected.)

### Countermeasure
Enable the **Domain member: Require strong (Windows 2000 or later) session key** setting.

If you enable this policy setting, all outgoing secure channel traffic requires a strong encryption key. If you disable this policy setting, the key strength is negotiated. You should enable this policy setting only if the domain controllers in all trusted domains support strong keys. By default, this policy setting is disabled.

### Potential impact
Computers that have this policy setting enabled cannot join Windows NT 4.0 domains, and trusts between Active Directory domains and Windows NT domains may not work properly. Also, computers that do not support this policy setting cannot join domains in which the domain controllers have this policy setting enabled.


