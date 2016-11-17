---
title: Domain controller: Refuse machine account password changes
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fb0a0da0-7b8b-47bb-93d7-41f11d36589f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Domain controller: Refuse machine account password changes

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This policy setting enables or disables blocking a domain controller from accepting password change requests for computer accounts. By default, member computers change their computer account passwords every 30 days. If enabled, the domain controller will refuse computer account password change requests.

### Possible values

-   Enabled

    When enabled, this setting does not allow a domain controller to accept any changes to a computer account's password.

-   Disabled

    When disabled, this setting allows a domain controller to accept any changes to a computer account's password.

-   Not defined

    Same as Disabled.

### Best practices

1.  Enabling this policy setting on all domain controllers in a domain prevents domain members from changing their computer account passwords. This, in turn, leaves those passwords susceptible to attack. Make sure that this conforms to your overall security policy for the domain.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not defined|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Not applicable|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If you enable this policy setting on all domain controllers in a domain, domain members cannot change their computer account passwords, and those passwords are more susceptible to attack.

### Countermeasure
Disable the **Domain controller: Refuse machine account password changes** setting.

### Potential impact
None. This is the default configuration.


