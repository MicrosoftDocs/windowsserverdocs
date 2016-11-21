---
title: Domain member: Digitally sign secure channel data (when possible)
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e55ebf7d-a00e-4103-a1fd-a0162ab7334b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Domain member: Digitally sign secure channel data (when possible)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This setting determines whether all secure channel traffic that is initiated by the domain member meets minimum security requirements. Specifically, it determines whether all secure channel traffic that is initiated by the domain member must be signed. Logon information that is transmitted over the secure channel is always encrypted regardless of whether the encryption of all other secure channel traffic is negotiated.

The following policy settings determine whether a secure channel can be established with a domain controller that is not capable of signing or encrypting secure channel traffic:

-   **Domain member: Digitally encrypt or sign secure channel data (always)**

-   **Domain member: Digitally encrypt secure channel data (when possible)**

-   **Domain member: Digitally sign secure channel data (when possible)**

Setting **Domain member: Digitally encrypt or sign secure channel data (always)** to **Enabled** prevents establishing a secure channel with any domain controller that cannot sign or encrypt all secure channel data.

To protect authentication traffic from man-in-the-middle, replay, and other types of network attacks, Windows-based computers create a communication channel through NetLogon called secure channels. These channels authenticate computer accounts. They also authenticate user accounts when a remote user connects to a network resource and the user account exists in a trusted domain. This is called pass-through authentication, and it allows a computer running the Windows operating system that has joined a domain to have access to the user account database in its domain and in any trusted domains.

Enabling the **Domain member: Digitally encrypt or sign secure channel data (always)** policy setting automatically enables the **Domain member: Digitally sign secure channel data (when possible)** policy setting.

When a computer running  Windows Server 2008 R2 ,  Windows Server 2008 , or Windows Server 2003 joins a domain, a computer account is created. After joining the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time it restarts. This secure channel is used to perform operations such as NTLM pass through authentication and LSA SID/name Lookup. Requests that are sent on the secure channel are authenticated???and sensitive information such as passwords are encrypted???but the integrity of the channel is not checked, and not all information is encrypted. If a system is set to always encrypt or sign secure channel data, a secure channel cannot be established with a domain controller that is not capable of signing or encrypting all secure channel traffic. If the computer is configured to encrypt or sign secure channel data when possible, a secure channel can be established, but the level of encryption and signing is negotiated.

### Possible values

-   Enabled

    The domain member will request signing of all secure channel traffic. If the Domain Controller supports signing of all secure channel traffic, then all secure channel traffic will be signed which ensures that it cannot be tampered with in transit.

-   Disabled

    Signing will not be negotiated unless the policy **Domain member: Digitally encrypt or sign secure channel data (always)** is enabled.

-   Not defined

### Best practices

-   Set **Domain member: Digitally encrypt or sign secure channel data (always)** to **Enabled**.

-   Set **Domain member: Digitally encrypt secure channel data (when possible)** to **Enabled**.

-   Set **Domain member: Digitally sign secure channel data (when possible)** to **Enabled**.

> [!NOTE]
> You can enable the other two policy settings, **Domain member: Digitally encrypt secure channel data (when possible)** and **Domain member: Digitally sign secure channel data (when possible)**, on all computers in the domain that support these policy settings without affecting earlier-version clients and applications.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Enabled|
|Stand-Alone Server Default Settings|Enabled|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Enabled|
|Client Computer Effective Default Settings|Enabled|

### Operating system version differences
Modifying this setting may affect compatibility with clients, services, and applications, including those running in operating systems earlier than  Windows Server 2008 .

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
Distribution of this policy through Group Policy does not override the Local Security Policy setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
When a computer joins a domain, a computer account is created. After it joins the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time it restarts. Requests that are sent on the secure channel are authenticated???and sensitive information such as passwords are encrypted???but the channel is not integrity-checked, and not all information is encrypted. If a computer is configured to always encrypt or sign secure channel data but the domain controller cannot sign or encrypt any portion of the secure channel data, the computer and domain controller cannot establish a secure channel. If the computer is configured to encrypt or sign secure channel data when possible, a secure channel can be established, but the level of encryption and signing is negotiated.

### Countermeasure
Because these policies are closely related and useful depending on your environment, select one of the following settings as appropriate to configure the computers in your domain to encrypt or sign secure channel data when possible.

-   **Domain member: Digitally encrypt or sign secure channel data (always)**

-   **Domain member: Digitally encrypt secure channel data (when possible)**

-   **Domain member: Digitally sign secure channel data (when possible)**

### Potential impact
Digital signing of the secure channel is a good idea where it is supported. The secure channel protects domain credentials as they are sent to the domain controller. However, operating systems earlier than Windows NT 4.0 with SP6a do not support digital encryption and signing of the secure channel. Client computers running Windows 98 Second Edition do not support it unless they have the Active Directory Client Extension installed.  Therefore, enabling this policy where it is unsupported on these systems will have no affect.


