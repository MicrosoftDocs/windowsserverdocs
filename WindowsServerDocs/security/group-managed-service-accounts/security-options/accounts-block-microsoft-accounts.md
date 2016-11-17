---
title: Accounts: Block Microsoft accounts
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 96687699-c026-4008-9c1e-8d47eb3a10f4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Accounts: Block Microsoft accounts

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, management, and security considerations for this policy setting.

## Reference
This policy setting prevents users from adding new Microsoft accounts on a computer.

If you click the **Users can???t add Microsoft accounts** setting option, users will not be able to create new Microsoft accounts on a computer, switch a local account to a Microsoft account, or connect a domain account to a Microsoft account. This is the preferred option if you need to limit the use of Microsoft accounts in your enterprise.

If you click the **Users can???t add or log on with Microsoft accounts** setting option, existing Microsoft account users will not be able to log on to Windows. Selecting this option might make it impossible for an existing administrator to log on to a computer and manage the system.

If you disable or do not configure this policy (recommended), users will be able to use Microsoft accounts with Windows.

### Possible values

-   This policy is disabled

-   Users can???t add Microsoft accounts

-   Users can???t add or log on with Microsoft accounts

By default, this setting is not defined on domain controllers and disabled on stand-alone servers.

### Best practices

-   By disabling or not configuring this policy setting on the client computer, users will be able to use their Microsoft account, local account, or domain account for their sign-in session to Windows. It also enables the user to connect a local or domain account to a Microsoft account. This provides a convenient option for your users.

-   If you need to limit the use of Microsoft accounts in your organization, click the **Users can???t add Microsoft accounts** setting option so that users will not be able to create new Microsoft accounts on a computer, switch a local account to a Microsoft account, or connect a domain account to a Microsoft account.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
This policy setting was introduced in Windows Server 2012 and Windows 8.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
Because this policy setting was introduced to control sign-in options for Windows Server 2012 and Windows 8, it has no affect on earlier Windows operating systems.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of the countermeasure implementation.

### Vulnerability
Although Microsoft accounts are password-protected, they also have the potential of greater exposure outside of the enterprise. Additionally, if the owner of a Microsoft account is not easily distinguishable, auditing and forensics become more difficult on computers running Windows Server 2012 and Windows 8.

### Countermeasure
Require only domain accounts in your enterprise by limiting the use of Microsoft accounts. Click the **Users can???t add Microsoft accounts** setting option so that users will not be able to create new Microsoft accounts on a computer, switch a local account to a Microsoft account, or connect a domain account to a Microsoft account.

### Potential impact
Establishing greater control over accounts in your organization can give you more secure management capabilities, including procedures around password resets.

## See Also
[Security Options](security-options.md)


