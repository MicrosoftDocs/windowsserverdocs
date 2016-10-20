---
title: Network security: Force logoff when logon hours expire
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 525410db-f024-4876-8874-b76b80408517
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network security: Force logoff when logon hours expire

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting. This information applies to computers running at least the Windows Server 2008 operating system.

## Reference
This security setting determines whether to disconnect users who are connected to the local computer outside their user account's valid logon hours. This setting affects the Server Message Block (SMB) component.

This policy setting does not apply to Administrator accounts, but it behaves as an account policy. For domain accounts, there can be only one account policy. The account policy must be defined in the Default Domain Policy, and it is enforced by the domain controllers that make up the domain. A domain controller always pulls the account policy from the Default Domain Policy Group Policy Object (GPO), even if there is a different account policy that is applied to the organizational unit that contains the domain controller. By default, workstations and servers that are joined to a domain (for example, member computers) also receive the same account policy for their local accounts. However, local account policies for member computers can be different from the domain account policy by defining an account policy for the organizational unit that contains the member computers. Kerberos settings are not applied to member computers.

### Possible values

-   Enabled

    When enabled, this policy causes client sessions with the SMB server to be forcibly disconnected when the client's logon hours expire.

-   Disabled

    When disabled, this policy allows for the continuation of an established client session after the client's logon hours have expired.

-   Not defined

### Best practices

1.  Set **Network security: Force logoff when logon hours expire** to Enabled. SMB sessions will be terminated on member servers when a user's logon time expires, and the user will be unable to log on to the system until their next scheduled access time begins.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Disabled|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If you disable this policy setting, users can remain connected to the computer outside of their allotted logon hours.

### Countermeasure
Enable the **Network security: Force logoff when logon hours expire** setting. This policy setting does not apply to administrator accounts.

### Potential impact
When a user's logon time expires, SMB sessions terminate. The user cannot log on to the computer until the next scheduled access time commences.


