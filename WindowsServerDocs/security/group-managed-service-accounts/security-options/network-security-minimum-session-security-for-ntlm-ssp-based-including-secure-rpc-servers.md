---
title: Network security: Minimum session security for NTLM SSP based (including secure RPC) servers
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c954992-35aa-4831-b016-47b429554642
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network security: Minimum session security for NTLM SSP based (including secure RPC) servers

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting allows a client computer to require the negotiation of 128-bit encryption or NTLMv2 session security. These values are dependent on the **Network security: LAN Manager Authentication Level policy** setting value.

Setting all of these values for this policy setting will help protect network traffic that uses the NTLM Security Support Provider (NTLM SSP) from being exposed or tampered with by a malicious user who has gained access to the same network. That is, these settings help protect against man-in-the-middle attacks.

### Possible values

-   Require 128-bit encryption. The connection fails if strong encryption (128-bit) is not negotiated.

-   Require NTLMv2 session security. The connection fails if the NTLMv2 protocol is not negotiated.

-   Not Defined.

### Best practices

1.  Enable all values that are available for this security policy. Legacy client computers that do not support these policy settings will be unable to communicate with the server.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Require 128-bit encryption|
|DC Effective Default Settings|Require 128-bit encryption|
|Member Server Effective Default Settings|Require 128-bit encryption|
|Client Computer Effective Default Settings|Require 128-bit encryption|

### Operating system version differences
In Windows Server 2008 and earlier versions, no requirements were set. But in later versions of the Windows operating system, **Require 128-bit encryption** is the default.

In  Windows Server 2008 R2  and  Windows 7 , only 128-bit encryption or NTLMv2 session security options are available.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Policy dependencies
The settings for this security policy are dependent on the **Network security: LAN Manager Authentication Level policy** setting value. For information about this policy, see [Network security: LAN Manager authentication level](network-security-lan-manager-authentication-level.md).

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Network traffic that uses the NTLM Security Support Provider (NTLM SSP) could be exposed such that an attacker who has gained access to the network can create man-in-the-middle attacks.

### Countermeasure
Enable all options that are available for the **Network security: Minimum session security for NTLM SSP based (including secure RPC) servers** policy setting.

### Potential impact
Older client computers that do not support these security settings cannot communicate with the computer on which this policy is set.


