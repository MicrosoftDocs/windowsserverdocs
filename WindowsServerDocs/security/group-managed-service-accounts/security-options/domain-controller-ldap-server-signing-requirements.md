---
title: Domain controller: LDAP server signing requirements
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9702ce61-7f25-46ff-bdcf-9385b0ea98d2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Domain controller: LDAP server signing requirements

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This policy setting determines whether the Lightweight Directory Access Protocol (LDAP) server requires LDAP clients to negotiate data signing.

Unsigned network traffic is susceptible to man-in-the-middle attacks, where an intruder captures packets between the server and the client computer and modifies them before forwarding them to the client computer. In the case of an LDAP server, this means that a malicious user can cause a client computer to make decisions based on false records from the LDAP directory. You can lower the risk of a malicious user accomplishing this in a corporate network by implementing strong physical security measures to protect the network infrastructure. Furthermore, implementing Internet Protocol security (IPsec) Authentication Header mode, which provides mutual authentication and packet integrity for IP traffic, can make all types of man-in-the-middle attacks extremely difficult.

This setting does not have any impact on LDAP simple bind or LDAP simple bind through SSL.

If signing is required, then LDAP simple bind and LDAP simple bind through SSL requests are rejected. No LDAP client computers running Windows XP Professional or servers running Windows Server 2003 use LDAP simple bind or LDAP simple bind through SSL to bind to directory service.

> [!CAUTION]
> If you set the server to Require signature, you must also set the client computer. Not setting the client computer results in loss of connection with the server.

### Possible values

-   None. Data signatures are not required to bind with the server. If the client computer requests data signing, the server supports it.

-   Require signature. The LDAP data-signing option must be negotiated unless Transport Layer Security/Secure Sockets Layer (TLS/SSL) is in use.

-   Not defined.

### Best practices

1.  It is advisable to set **Domain controller: LDAP server signing requirements** to **Require signature**. Clients that do not support LDAP signing will be unable to execute LDAP queries against the domain controllers.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy's property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not defined|
|DC Effective Default Settings|None|
|Member Server Effective Default Settings|None|
|Client Computer Effective Default Settings|None|

### Operating system version differences
Modifying this setting may affect compatibility with clients, services, and applications. 

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Unsigned network traffic is susceptible to man-in-the-middle attacks. In such attacks, an intruder captures packets between the server and the client computer, modifies them, and then forwards them to the client computer. Where LDAP servers are concerned, an attacker could cause a client computer to make decisions that are based on false records from the LDAP directory. To lower the risk of such an intrusion in an organization's network, you can implement strong physical security measures to protect the network infrastructure. You could also implement Internet Protocol security (IPsec) Authentication Header mode, which performs mutual authentication and packet integrity for IP traffic to make all types of man-in-the-middle attacks extremely difficult.

### Countermeasure
Configure the **Domain controller: LDAP server signing requirements** setting to **Require signature**.

### Potential impact
Client computers that do not support LDAP signing cannot run LDAP queries against the domain controllers.


