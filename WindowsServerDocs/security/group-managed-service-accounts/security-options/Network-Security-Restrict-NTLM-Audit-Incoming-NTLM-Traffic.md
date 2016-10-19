---
title: Network Security: Restrict NTLM: Audit Incoming NTLM Traffic
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2121f03a-a714-424e-a435-30d55c2eea91
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network Security: Restrict NTLM: Audit Incoming NTLM Traffic

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, management aspects, and security considerations for this policy setting.

## Reference
The **Network Security: Restrict NTLM: Audit Incoming NTLM Traffic** policy setting allows you to audit incoming NTLM traffic.

When this audit policy is enabled within Group Policy, it is enforced on any server where that Group Policy is distributed. The events will be recorded in the Operational log located in **Applications and Services Log\Microsoft\Windows\NTLM**. Using an audit event collection system can help you collect the events for analysis more efficiently.

When you enable this policy on a server, only authentication traffic to that server will be logged.

When you enable this audit policy, it functions in the same way as the **Network Security: Restrict NTLM: Incoming NTLM Traffic** policy, but it does not actually block any traffic. Therefore, you can use it effectively to understand the authentication traffic in your environment, and when you are ready to block that traffic, you can enable the **Network Security: Restrict NTLM: Incoming NTLM Traffic** policy setting and select **Deny all accounts** or **Deny all domain accounts**.

### Possible values

-   Disable

    The server on which this policy is set will not log events for incoming NTLM traffic.

-   Enable auditing for domain accounts

    The server on which this policy is set will log events for NTLM pass-through authentication requests only for accounts in the domain that would be blocked when the **Network Security: Restrict NTLM: Incoming NTLM traffic** policy setting is set to **Deny all domain accounts**.

-   Enable auditing for all accounts

    The server on which this policy is set will log events for all NTLM authentication requests that would be blocked when the **Network Security: Restrict NTLM: Incoming NTLM traffic** policy setting is set to **Deny all accounts**.

-   Not defined

    This is the same as **Disable**, and it results in no auditing of NTLM traffic. See the [Group Policy](#BKMK_NTLM_GroupPolicy) section for additional information.

### Best practices
Depending on your environment and the duration of your testing, monitor the log size regularly.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**

### Default values

|Server type or GPO|Default value|
|-----------|---------|
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
View the Operational log to see if this policy is functioning as intended. Audit and block events are recorded on this computer in the Operational log located in **Applications and Services Log\Microsoft\Windows\NTLM**. Using an audit event collection system can help you collect the events for analysis more efficiently.

There are no Security Audit Event policies that can be configured to view output from this policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

NTLM and NTLMv2 authentication is vulnerable to a variety of malicious attacks, including SMB replay, man-in-the-middle attacks, and brute force attacks. Reducing and eliminating NTLM authentication from your environment forces the Windows operating system to use more secure protocols, such as the Kerberos version 5 protocol, or different authentication mechanisms, such as smart cards.

### Vulnerability
Enabling this policy setting will reveal through logging which servers and client computers within your network or domain handle NTLM traffic. The identity of these computers can be used in malicious ways if NTLM authentication traffic is compromised. The policy setting does not prevent or mitigate any vulnerability because it is for audit purposes only.

### Countermeasure
Restrict access to the log files when this policy setting is enabled in your production environment.

### Potential impact
If you do not enable or configure this policy setting, no NTLM authentication traffic information will be logged. If you do enable this policy setting, only auditing functions will occur; no security enhancements will be implemented.


