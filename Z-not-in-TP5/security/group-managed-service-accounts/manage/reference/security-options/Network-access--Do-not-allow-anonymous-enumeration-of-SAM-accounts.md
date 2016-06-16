---
title: Network access: Do not allow anonymous enumeration of SAM accounts
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 830458c7-6773-47d4-ae88-5eca7d4bb141
---
# Network access: Do not allow anonymous enumeration of SAM accounts
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This policy setting determines which additional permissions will be assigned for anonymous connections to the computer. Windows allows anonymous users to perform certain activities, such as enumerating the names of domain accounts and network shares. This is convenient, for example, when an administrator wants to give access to users in a trusted domain that does not maintain a reciprocal trust.

This policy setting has no impact on domain controllers.

Misuse of this policy setting is a common error that can cause data loss or problems with data access or security.

### Possible values

-   Enabled

    It will be impossible to establish trusts with Windows NT 4.0–based domains. This value will also cause problems with earlier\-version client computers \(such as those running Windows NT 3.51 and Windows 95\) that are trying to use resources on the server.

-   Disabled

    No additional permissions can be assigned by the administrator for anonymous connections to the computer. Anonymous connections will rely on default permissions.

-   Not defined

### Best practices

1.  Best practices are dependent on your security goals and policies.

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
Windows 2000 Server has a similar policy setting named **Additional Restrictions for Anonymous Connections** managed a registry entry **RestrictAnonymous**, located in the HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\LSA key. In Windows Server 2003, the policy settings **Network access: Do not allow anonymous enumeration of SAM accounts** and **Network access: Do not allow anonymous enumeration of SAM accounts and shares** replace the Windows 2000 policy setting. They manage the registry entries **RestrictAnonymousSAM** and **RestrictAnonymous**, respectively, both located in the HKEY\_LOCAL\_MACHINE\\System\\CurrentControlSet\\Control\\Lsa\\ key.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Policy conflicts
Even with this policy setting enabled, anonymous users will have access to resources with permissions that explicitly include the built\-in group, ANONYMOUS LOGON \(on systems earlier than Windows Server 2008 and Windows Vista\).

### Group Policy
This policy has no impact on domain controllers.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
An unauthorized user could anonymously list account names and use the information to perform social engineering attacks or attempt to guess passwords. Social engineering attackers try to deceive users in some way to obtain passwords or some form of security information.

### Countermeasure
Enable the **Network access: Do not allow anonymous enumeration of SAM accounts** setting.

### Potential impact
It is impossible to establish trusts with Windows NT 4.0–based domains. Also, client computers that run earlier versions of the Windows operating system, such as Windows NT 3.51 and Windows 95, experience problems when they try to use resources on the server.


