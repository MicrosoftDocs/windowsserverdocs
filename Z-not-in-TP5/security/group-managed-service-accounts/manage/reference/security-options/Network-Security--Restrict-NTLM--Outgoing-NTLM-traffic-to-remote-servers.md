---
title: Network Security: Restrict NTLM: Outgoing NTLM traffic to remote servers
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7565459d-ebf7-470c-b655-6a97551ef73a
---
# Network Security: Restrict NTLM: Outgoing NTLM traffic to remote servers
This security policy reference topic for the IT professional describes the best practices, location, values, management aspects, and security considerations for this policy setting.

## Reference
The **Network Security: Restrict NTLM: Outgoing NTLM traffic to remote servers** policy setting allows you to deny or audit outgoing NTLM traffic from a computer running Windows 7 or Windows Server 2008 R2 to any remote server running the Windows operating system.

> [!WARNING]
> Modifying this policy setting may affect compatibility with client computers, services, and applications.

### <a name="BKMK_ResOutNTLM_PossVals"></a>Possible values

-   **Allow all**

    The computer can authenticate identities to a remote server by using NTLM authentication because no restrictions exist.

-   **Audit all**

    The computer that sends the NTLM authentication request to a remote server logs an event for each request. This allows you to identify those servers that receive NTLM authentication requests from the client computer.

-   **Deny all**

    The computer cannot authenticate any identities to a remote server by using NTLM authentication. You can use the **Network security: Restrict NTLM: Add remote server exceptions for NTLM authentication** policy setting to define a list of remote servers to which client computers are allowed to use NTLM authentication while denying others. This setting will also log an event on the computer that is making the authentication request.

-   Not defined

    This is the same as **Allow all**, and the computer will allow all NTLM authentication requests when the policy is deployed. See the [Group Policy](#BKMK_NTLM_GroupPolicy) section for additional information.

### Best practices
If you select **Deny all**, the client computer cannot authenticate identities to a remote server by using NTLM authentication. First, select **Audit all** and then review the Operational log to understand which servers are involved in these authentication attempts. You can then add those server names to a server exception list by using the **Network security: Restrict NTLM: Add remote server exceptions for NTLM authentication** policy setting.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**

### Default values

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default domain policy|Not defined|
|Default domain controller policy|Not defined|
|Stand-alone server default settings|Not defined|
|Domain controller effective default settings|Not defined|
|Member server effective default settings|Not defined|
|Client computer effective default settings|Not defined|

### Operating system version differences
This policy setting was introduced in  Windows Server 2008 R2  and  Windows 7 .

## Policy management
This section describes different features and tools available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a restart when saved locally or distributed through Group Policy.

### <a name="BKMK_NTLM_GroupPolicy"></a>Group Policy
Setting and deploying this policy using Group Policy takes precedence over the setting on the local computer. If the Group Policy is set to **Not Configured**, local settings will apply.

### Auditing
View the Operational log to see if this policy is functioning as intended. Audit and block events are recorded on this computer in the Operational log located in **Applications and Services Log\Microsoft\Windows\NTLM**.

There are no Security Audit Event policies that can be configured to view event output from this policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

NTLM and NTLMv2 authentication is vulnerable to a variety of malicious attacks, including SMB replay, man-in-the-middle attacks, and brute force attacks. Reducing and eliminating NTLM authentication from your environment forces the Windows operating system to use more secure protocols, such as the Kerberos version 5 protocol, or different authentication mechanisms, such as smart cards.

### Vulnerability
Malicious attacks on NTLM authentication traffic that result in a compromised server or domain controller can occur only if the server or domain controller handles NTLM requests. If those requests are denied, this attack vector is eliminated.

### Countermeasure
When it has been determined that the NTLM authentication protocol should not be used within a network because you are required to use a more secure protocol such as Kerberos, then you can select from several options to restrict NTLM usage to servers.

### Potential impact
If you configure this policy setting to deny all requests, numerous NTLM authentication requests to remote servers could fail, which could degrade productivity. Before implementing this restriction through this policy setting, select **Audit all** so that you can review the log for the potential impact, perform an analysis of servers, and create an exception list of servers to exclude from this policy setting by using **Network security: Restrict NTLM: Add remote server exceptions for NTLM authentication**.


