---
title: Network Security: Restrict NTLM: Incoming NTLM Traffic
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ba63358-9329-4469-b3cd-2f72f34166a3
---
# Network Security: Restrict NTLM: Incoming NTLM Traffic
This security policy reference topic for the IT professional describes the best practices, location, values, management aspects, and security considerations for this policy setting.

## Reference
The **Network Security: Restrict NTLM: Incoming NTLM Traffic** policy setting allows you to deny or allow incoming NTLM traffic from client computers, other member servers, or a domain controller.

### <a name="BKMK_PossVal_Incoming"></a>Possible values

-   **Allow all**

    The server will allow all NTLM authentication requests.

-   **Deny all domain accounts**

    The server will deny NTLM authentication requests for domain logon, return an NTLM blocked error message to the client computer, and log the error, but the server will allow local account logon.

-   **Deny all accounts**

    The server will deny NTLM authentication requests from all incoming traffic \(whether domain account logon or local account logon\), return an NTLM blocked error message to the client computer, and log the error.

-   Not defined

    This is the same as **Allow all**, and the server will allow all NTLM authentication requests. See the [Group Policy](#BKMK_GroupPolicy) section for additional information.

### Best practices
If you select **Deny all domain accounts** or **Deny all accounts**, incoming NTLM traffic to the member server will be restricted. It is better to set the **Network Security: Restrict NTLM: Audit Incoming NTLM Traffic** policy setting and then review the Operational log to understand what authentication attempts are made to the member servers, and subsequently what client applications are using NTLM.

### Location
*GPO\_name***\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options**

### Default values

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default domain policy|Not defined|
|Default domain controller policy|Not defined|
|Stand\-alone server default settings|Not defined|
|Domain controller effective default settings|Not defined|
|Member server effective default settings|Not defined|
|Client computer effective default settings|Not defined|

### Operating system version differences
This policy setting was introduced in [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)].

## Policy management
This section describes different features and tools available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a restart when saved locally or distributed through Group Policy.

### <a name="BKMK_GroupPolicy"></a>Group Policy
Setting and deploying this policy using Group Policy takes precedence over the setting on the local computer. If the Group Policy is set to **Not Configured**, local settings will apply.

### Auditing
View the Operational log to see if this policy is functioning as intended. Audit and block events are recorded on this computer in the Operational log located in **Applications and Services Log\\Microsoft\\Windows\\NTLM**.

There are no Security Audit Event policies that can be configured to view event output from this policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

NTLM and NTLMv2 authentication is vulnerable to a variety of malicious attacks, including SMB replay, man\-in\-the\-middle attacks, and brute force attacks. Reducing and eliminating NTLM authentication from your environment forces the Windows operating system to use more secure protocols, such as the Kerberos version 5 protocol, or different authentication mechanisms, such as smart cards.

### Vulnerability
Malicious attacks on NTLM authentication traffic that result in a compromised server can occur only if the server handles NTLM requests. If those requests are denied, brute force attacks on NTLM are eliminated.

### Countermeasure
When it has been determined that the NTLM authentication protocol should not be used within a network because you are required to use a more secure protocol such as Kerberos, you can select one of several options that this security policy setting offers to restrict NTLM usage.

### Potential impact
If you configure this policy setting, numerous NTLM authentication requests could fail within your network, which could degrade productivity. Before implementing this change through this policy setting, set **Network security: Restrict NTLM: Audit Incoming NTLM Traffic** to the same option so that you can review the log for the potential impact, perform an analysis of servers, and create an exception list of servers to exclude from this policy setting **Network security: Restrict NTLM: Add server exceptions in this domain**.


