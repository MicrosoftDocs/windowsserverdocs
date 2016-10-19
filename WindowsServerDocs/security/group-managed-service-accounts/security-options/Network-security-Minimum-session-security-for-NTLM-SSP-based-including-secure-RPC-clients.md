---
title: Network security: Minimum session security for NTLM SSP based (including secure RPC) clients
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9cb13ceb-dd15-4cb3-b82e-5df4ebe4fd37
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network security: Minimum session security for NTLM SSP based (including secure RPC) clients

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting allows a client computer to require the negotiation of 128-bit encryption or NTLMv2 session security. These values are dependent on the **Network security: LAN Manager Authentication Level policy** setting value.

### Possible values

-   Require NTLMv2 session security

    The connection fails if strong encryption (128-bit) is not negotiated.

-   Require 128-bit encryption

    The connection fails if the NTLMv2 protocol is not negotiated.

### Best practices
Practices in setting this policy are dependent on your security requirements.

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
In Windows Server 2008 and earlier versions of the Windows operating system, no requirements were set. But in computers running  Windows Server 2008 R2 **Require 128-bit encryption** is the default.

In  Windows Server 2008 R2  and  Windows 7 , only 128-bit encryption or NTLMv2 session security options are available.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Policy conflicts
The settings for this security policy are dependent on the **Network security: LAN Manager Authentication Level policy** setting value. For information about this policy, see [Network security: LAN Manager authentication level](Network-security-LAN-Manager-authentication-level.md).

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Network traffic that uses the NTLM Security Support Provider (NTLM SSP) could be exposed such that an attacker who has gained access to the network can create man-in-the-middle attacks.

### Countermeasure
Enable all options that are available for the **Network security: Minimum session security for NTLM SSP based (including secure RPC) clients policy** setting.

### Potential impact
Client computers that enforce these settings cannot communicate with older servers that do not support them.


