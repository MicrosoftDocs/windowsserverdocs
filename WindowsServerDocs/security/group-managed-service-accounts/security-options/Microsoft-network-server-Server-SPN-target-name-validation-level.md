---
title: Microsoft network server: Server SPN target name validation level
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb0e40fd-c7f9-4422-98e3-ed82b0280adf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Microsoft network server: Server SPN target name validation level

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, and values, policy management and security considerations for this policy setting.

## Reference
This policy setting controls the level of validation that a server with shared folders or printers performs on the service principal name (SPN) that is provided by the client computer when the client computer establishes a session by using the Server Message Block (SMB) protocol. The level of validation can help prevent a class of attacks against SMB services (referred to as SMB relay attacks). This setting will affect both SMB1 and SMB2.

Servers that use SMB  provide availability to their file systems and other resources, such as printers, to networked client computers. Most servers that use SMB validate user access to resources by using NT Domain authentication (NTLMv1 and NTLMv2) and the Kerberos protocol.

Windows Server 2008 and Windows Vista support SMB protocol (SMB 2.0 or SMB2).  Windows Server 2008 R2  and  Windows 7  supports SMB 2.0, SMB2 and SMB 2.1.

### Possible values
The options for validation levels are:

-   **Off**

    The SPN from a SMB client is not required or validated by the SMB server.

-   **Accept if provided by client**

    The SMB server will accept and validate the SPN provided by the SMB client and allow a session to be established if it matches the SMB server???s list of SPN???s. If the SPN does not match, the session request for that SMB client will be denied.

-   **Required from client**

    The SMB client must send a SPN name in session setup, and the SPN name provided must match the SMB server that is being requested to establish a connection. If no SPN is provided by the client computer, or the SPN provided does not match, the session is denied.

The default setting is Off.

### Best practices
This setting affects the server SMB behavior, and its implementation should be carefully evaluated and tested to prevent disruptions to file and print serving capabilities.

> [!NOTE]
> All Windows operating systems support a client-side SMB component and a server-side SMB component.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or Group Policy object (GPO)|Default value|
|-----------------------|---------|
|Default domain policy|Off|
|Default domain controller policy|Off|
|Stand-alone server default settings|Off|
|Domain controller effective default settings|Validation level check not implemented|
|Member server effective default settings|Validation level check not implemented|
|Effective GPO default settings on client computers|Validation level check not implemented|

### Operating system version differences
This policy was introduced in Windows Server 2008 and Windows Vista, and it can be applied through Group Policy to all Windows server operating systems beginning with Windows Server 2003 and Windows XP.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Policy conflict considerations
None.

### Group Policy
This policy setting can be configured by using the Group Policy Management Console (GPMC) to be distributed through Group Policy Objects (GPOs). If this policy is not contained in a distributed GPO, this policy can be configured on the local computer by using the Local Security Policy snap-in.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
This policy setting controls the level of validation that a server with shared folders or printers performs on the service principal name (SPN) that is provided by the client computer when the client computer establishes a session by using the SMB protocol. The level of validation can help prevent a class of attacks against SMB servers (referred to as SMB relay attacks). This setting will affect both SMB1 and SMB2.

### Countermeasure
For countermeasures that are appropriate to your environment, see **Possible values** above.

### Potential impact
All Windows operating systems support a client-side SMB component and a server-side SMB component. This setting affects the server SMB behavior, and its implementation should be carefully evaluated and tested to prevent disruptions to file and print serving capabilities.

Because the SMB protocol is widely deployed, setting the options to **Accept if provided by client** or **Required from client** will prevent some clients from successfully authenticating to some servers in your environment.


