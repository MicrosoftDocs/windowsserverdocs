---
title: Domain member: Digitally encrypt or sign secure channel data (always)
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb11f689-0deb-4198-9a34-d420b1452407
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Domain member: Digitally encrypt or sign secure channel data (always)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This setting determines whether all secure channel traffic that is initiated by the domain member meets minimum security requirements. Specifically, it determines whether all secure channel traffic that is initiated by the domain member must be signed or encrypted. Logon information that is transmitted over the secure channel is always encrypted regardless of whether the encryption of all other secure channel traffic is negotiated.

The following policy settings determine whether a secure channel can be established with a domain controller that is not capable of signing or encrypting secure channel traffic:

-   Domain member: Digitally encrypt or sign secure channel data (always)

-   Domain member: Digitally encrypt secure channel data (when possible)

-   Domain member: Digitally sign secure channel data (when possible)

Setting **Domain member: Digitally encrypt or sign secure channel data (always)** to **Enabled** prevents establishing a secure channel with any domain controller that cannot sign or encrypt all secure channel data.

To protect authentication traffic from man-in-the-middle, replay, and other types of network attacks, Windows-based computers create a communication channel through NetLogon called secure channels. These channels authenticate computer accounts. They also authenticate user accounts when a remote user connects to a network resource and the user account exists in a trusted domain. This is called pass-through authentication, and it allows a computer running the Windows operating system that has joined a domain to have access to the user account database in its domain and in any trusted domains.

To enable the **Domain member: Digitally encrypt or sign secure channel data (always)** policy setting on a member workstation or server, all domain controllers in the domain that the member belongs to must be capable of signing or encrypting all secure-channel data.

Enabling the **Domain member: Digitally encrypt or sign secure channel data (always)** policy setting automatically enables the **Domain member: Digitally sign secure channel data (when possible)** policy setting.

When a computer running  Windows Server 2008 R2 ,  Windows Server 2008 , or Windows Server 2003 joins a domain, a computer account is created. After joining the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time it restarts. This secure channel is used to perform operations such as NTLM pass-through authentication and LSA SID/name Lookup. Requests that are sent on the secure channel are authenticated???and sensitive information such as passwords are encrypted???but the integrity of the channel is not checked, and not all information is encrypted. If a system is set to always encrypt or sign secure channel data, a secure channel cannot be established with a domain controller that is not capable of signing or encrypting all secure channel traffic. If the computer is configured to encrypt or sign secure channel data when possible, a secure channel can be established, but the level of encryption and signing is negotiated.

### Possible values

-   Enabled

    The policy **Domain member: Digitally sign secure channel data (when possible)** is assumed to be enabled regardless of its current setting. This ensures that the domain member attempts to negotiate at least signing of the secure channel traffic.

-   Disabled

    The encryption and signing of all secure channel traffic is negotiated with the domain controller, in which case the level of signing and encryption depends on the version of the domain controller and the settings of the following policies:

    1.  **Domain member: Digitally encrypt secure channel data (when possible)**

    2.  **Domain member: Digitally sign secure channel data (when possible)**

-   Not defined

### Best practices

-   Set **Domain member: Digitally encrypt or sign secure channel data (always)** to **Enabled**.

-   Set **Domain member: Digitally encrypt secure channel data (when possible)** to **Enabled**.

-   Set **Domain member: Digitally sign secure channel data (when possible)** to **Enabled**.

You can enable this policy setting after you eliminate all Windows 95, Windows 98, and Windows Millennium Edition clients from the domain and upgrade all Windows NT 4.0 servers and domain controllers from trusted or trusting domains to Windows NT 4.0 with SP6a.

> [!NOTE]
> You can enable the policy settings **Domain member: Digitally encrypt secure channel data (when possible)** and **Domain member: Digitally sign secure channel data (when possible)** on all computers in the domain that support these policy settings without affecting earlier-version clients and applications.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Enabled|
|Stand-Alone Server Default Settings|Enabled|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Enabled|
|Client Computer Effective Default Settings|Enabled|

### Operating system version differences
Modifying this setting may affect compatibility with clients, services, and applications, including those running in operating systems earlier than Windows 2000 Server.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
Distribution of this policy through Group Policy overrides the Local Security Policy setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
When a computer joins a domain, a computer account is created. After it joins the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time it restarts. Requests that are sent on the secure channel are authenticated???and sensitive information such as passwords are encrypted???but the channel is not integrity-checked, and not all information is encrypted. If a computer is configured to always encrypt or sign secure channel data but the domain controller cannot sign or encrypt any portion of the secure channel data, the computer and domain controller cannot establish a secure channel. If the computer is configured to encrypt or sign secure channel data, when possible, a secure channel can be established, but the level of encryption and signing is negotiated.

### Countermeasure
Select one of the following settings as appropriate for your environment to configure the computers in your domain to encrypt or sign secure channel data.

-   **Domain member: Digitally encrypt or sign secure channel data (always)**

-   **Domain member: Digitally encrypt secure channel data (when possible)**

-   **Domain member: Digitally sign secure channel data (when possible)**

### Potential impact
Digital encryption and signing of the secure channel is a good idea where it is supported. The secure channel protects domain credentials as they are sent to the domain controller. However, operating systems earlier than Windows NT 4.0 with SP6a support digital encryption and signing of the secure channel. Client computers running Windows 98 Second Edition do not support it unless they have the Active Directory Client Extension installed). Therefore, you cannot enable the **Domain member: Digitally encrypt or sign secure channel data (always)** policy setting on domain controllers that support client computers running Windows 98 as members of the domain. The potential impact of such a setting can include making it impossible to create or delete trust relationships with earlier versions, disabling logons from earlier-version clients, and not being able to authenticate other domains' users from a trusted domain that is running an earlier version of the Windows operating system.

-   The ability to create or delete trust relationships with client computers running versions of Windows earlier than Windows NT 4.0 with SP6a is disabled.

-   Logons from client computers running versions of Windows earlier than Windows NT 4.0 with SP6a are disabled.

-   The ability to authenticate other domains' users from a domain controller running a version of Windows earlier than Windows NT 4.0 with SP6a in a trusted domain is disabled.

You can enable this policy setting after you eliminate all client computers running Windows 95 or Windows 98 from the domain and upgrade all servers running Windows NT 4.0 and domain controllers from trusted/trusting domains to Windows NT 4.0 with SP6a. You can enable the policy settings **Domain member: Digitally encrypt secure channel data (when possible)** and **Domain member: Digitally encrypt sign channel data (when possible)** on all computers in the domain that support them and client computers running versions of the Windows operating system earlier than Windows NT 4.0 with SP6a. Applications that run on these versions of the Windows operating system are not affected.


