---
title: Deny log on through Remote Desktop Services
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 46a487c2-efa2-441d-85e8-901a2d64b77e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Deny log on through Remote Desktop Services

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which users are prevented from logging on to the computer through a remote desktop connection through Remote Desktop Services. It is possible for a user to establish a remote desktop connection to a particular server, but not be able to log on to the console of that server.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeDenyRemoteInteractiveLogonRight

### Possible values

-   User-defined list of accounts

-   Not defined

### Best practices

1.  To control who can open a remote desktop connection and log on to the computer, add the user account to or remove user accounts from the Remote Desktop Users group.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not defined|
|Domain Controller Effective Default Settings|Not defined|
|Member Server Effective Default Settings|Not defined|
|Client Computer Effective Default Settings|Not defined|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Remote Desktop Services was formerly named Terminal Services. The naming difference does not impact how this policy setting works.

> [!NOTE]
> This setting is not compatible with computers running Windows 2000 Server with Service Pack 1 or earlier.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

The **Remote System** property controls settings for Remote Desktop Services (**Allow or prevent remote connections to the computer**) and for Remote Assistance (**Allow Remote Assistance connections to this computer**).

### Group Policy
This policy setting supersedes the **Allow log on through Remote Desktop Services** policy setting if a user account is subject to both policies.

Group Policy settings are applied in the following order. They overwrite settings on the local computer at the next Group Policy update.

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  Organizational unit policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Any account with the right to log on through Remote Desktop Services could be used to log on to the remote console of the computer. If this user right is not restricted to legitimate users who need to log on to the console of the computer, malicious users might download and run software that elevates their user rights.

### Countermeasure
Assign the **Deny log on through Remote Desktop Services** user right to the built-in local guest account and all service accounts. If you have installed optional components, such as ASP.NET, you may want to assign this user right to additional accounts that are required by those components.

### Potential impact
If you assign the **Deny log on through Remote Desktop Services** user right to other groups, you could limit the abilities of users who are assigned to specific administrative roles in your environment. Accounts that have this user right cannot connect to the computer through Remote Desktop Services or Remote Assistance. You should confirm that delegated tasks are not negatively affected.

## See Also
[User Rights Assignment](user-rights-assignment.md)


