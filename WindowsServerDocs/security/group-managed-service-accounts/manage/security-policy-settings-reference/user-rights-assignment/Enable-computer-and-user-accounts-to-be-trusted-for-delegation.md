---
title: Enable computer and user accounts to be trusted for delegation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: abbef368-4566-45c9-946a-400cb621ffc9
---
# Enable computer and user accounts to be trusted for delegation
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which users can set the **Trusted for Delegation** setting on a user or computer object.

Security account delegation provides the ability to connect to multiple servers, and each server change retains the authentication credentials of the original client. Delegation of authentication is a capability that client and server applications use when they have multiple tiers. It allows a public\-facing service to use client credentials to authenticate to an application or database service. For this configuration to be possible, the client and the server must run under accounts that are trusted for delegation.

Only administrators who have the **Enable computer and user accounts to be trusted for delegation** credential can set up delegation. Domain admins and Enterprise admins have this credential. The procedure to allow a user to be trusted for delegation depends on the functionality level of the domain.

The user or computer object that is granted this right must have write access to the account control flags. A server process running on a computer \(or under a user context\) that is trusted for delegation can access resources on another computer by using the delegated credentials of a client. However, the client account must have Write access to the account control flags on the object.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeEnableDelegationPrivilege

### Possible values

-   User\-defined list of accounts

-   Not defined

### Best practices

1.  There is no reason to assign this user right to anyone on member servers and workstations that belong to a domain because it has no meaning in those contexts. It is only relevant on domain controllers and stand\-alone computers.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand\-Alone Server Default Settings|Not defined|
|Domain Controller Effective Default Settings|Administrators|
|Member Server Effective Default Settings|Administrators|
|Client Computer Effective Default Settings|Administrators|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic. However, configuring this policy setting might have different effects on servers if those servers have different domain functional levels.

## Policy management
This section describes features, tools and guidance to help you manage this policy.

Modifying this setting might affect compatibility with clients, services, and applications.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

### Group Policy
This user right is defined in the Default Domain Controller Group Policy Object \(GPO\) and in the local security policy of workstations and servers.

Settings are applied in the following order through a Group Policy Object \(GPO\), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Misuse of the **Enable computer and user accounts to be trusted for delegation** user right could allow unauthorized users to impersonate other users on the network. An attacker could exploit this privilege to gain access to network resources and make it difficult to determine what has happened after a security incident.

### Countermeasure
The **Enable computer and user accounts to be trusted for delegation** user right should be assigned only if there is a clear need for its functionality. When you assign this right, you should investigate the use of constrained delegation to control what the delegated accounts can do. On domain controllers, this right is assigned to the Administrators group by default.

> [!NOTE]
> There is no reason to assign this user right to anyone on member servers and workstations that belong to a domain because it has no meaning in those contexts. It is only relevant on domain controllers and stand\-alone computers.

### Potential impact
None. Not defined is the default configuration.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


