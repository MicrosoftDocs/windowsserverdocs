---
title: Domain member: Maximum machine account password age
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b3ceb773-045b-4cd1-847e-22de34731db9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Domain member: Maximum machine account password age

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
The **Domain member: Maximum machine account password age** policy setting determines the maximum allowable age for a computer account password.

In Active Directory???based domains, each computer has an account and password, just like every user. By default, the domain members automatically change their domain password every 30 days. Increasing this interval significantly, or setting it to **0** so that the computers no longer change their passwords, gives a malicious user more time to undertake a brute-force password-guessing attack against one of the computer accounts.

### Possible values

-   User-defined number of days between 0 and 999

-   Not defined.

### Best practices

1.  It is often advisable to set **Domain member: Maximum machine account password age** to about 30 days.

2.  Some organizations prebuild computers and then store them for later use or ship them to remote locations. If the computer's account has expired, it will no longer be able to authenticate with the domain. Computers that cannot authenticate with the domain must be removed from the domain and rejoined to it. For this reason, some organizations might want to create a special organizational unit (OU) for computers that are prebuilt, and configure the value for this policy setting to a larger number of days.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|30 days|
|DC Effective Default Settings|30 days|
|Member Server Effective Default Settings|30 days|
|Client Computer Effective Default Settings|30 days|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003. This setting also applies to Windows 2000 computers, but it is not available through the Security Configuration Manager tools on Windows 2000 computers.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
In Active Directory???based domains, each computer has an account and password, just as every user does. By default, the domain members automatically change their domain password every 30 days. If you increase this interval significantly, or set it to 0 so that the computers no longer change their passwords, an attacker has more time to undertake a brute-force attack to guess the password of one or more computer accounts.

### Countermeasure
Configure the **Domain member: Maximum machine account password age** setting to 30 days.

### Potential impact
None. This is the default configuration.


