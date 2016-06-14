---
title: Network security: Do not store LAN Manager hash value on next password change
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f52c7bb1-a00b-467a-8e6d-c404a0346e40
---
# Network security: Do not store LAN Manager hash value on next password change
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting. This information applies to computers running at least the Windows Server 2008 operating system.

## Reference
This policy setting determines whether LAN Manager is prevented from storing hash values for the new password the next time the password is changed. Hash values are a representation of the password after the encryption algorithm is applied that corresponds to the format that is specified by the algorithm. To decrypt the hash value, the encryption algorithm must be determined and then reversed. The LAN Manager hash is relatively weak and prone to attack compared to the cryptographically stronger NTLM hash. Because the LM hash is stored on the local computer in the security database, the passwords can be compromised if the security database, Security Accounts Manager \(SAM\), is attacked.

By attacking the SAM file, attackers can potentially gain access to user names and password hashes. Attackers can use a password\-cracking tool to determine what the password is. After they have access to this information, they can use it to gain access to resources on your network by impersonating users. Enabling this policy setting will not prevent these types of attacks, but it will make them much more difficult.

### Possible values

-   Enabled

-   Disabled

-   Not defined

### Best practices

1.  Set **Network security: Do not store LAN Manager hash value on next password change** to **Enabled**.

2.  Require all users to set new passwords the next time they log on to the domain so that LAN Manager hashes are removed. Legacy operating systems \(such as Windows 95, Windows 98, and Windows Millennium Edition\) will fail, as will some non\-Microsoft applications.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand\-Alone Server Default Settings|Enabled|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Enabled|
|Client Computer Effective Default Settings|Enabled|

### Operating system version differences
On Windows operating systems before Windows Server 2008 and Windows Vista, the default for this policy was Disabled.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The SAM file can be targeted by attackers who seek access to user names and password hashes. Such attacks use special tools to discover passwords, which can then be used to impersonate users and gain access to resources on your network. These types of attacks are not prevented by enabling this policy setting because LAN Manager hashes are much weaker than NTLM hashes, but it is much more difficult for these attacks to succeed.

### Countermeasure
Enable the **Network security: Do not store LAN Manager hash value on next password change** setting. Require all users to set new passwords the next time they log on to the domain so that LAN Manager hashes are removed.

### Potential impact
Earlier operating systems such as Windows 95, Windows 98, and Windows Millennium Edition, as well as some non\-Microsoft applications, cannot connect to the system.


