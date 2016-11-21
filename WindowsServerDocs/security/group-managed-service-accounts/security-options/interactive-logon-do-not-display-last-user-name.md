---
title: Interactive logon: Do not display last user name
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a9b72cab-9407-4510-8971-faf1d26b6764
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Interactive logon: Do not display last user name

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This security setting determines whether the name of the last user to log on to the computer is displayed on the Secure Desktop.

If this policy is enabled, the full name of the last user to successfully log on is not displayed on the Secure Desktop, nor is the user' logon tile displayed. Additionally, if the **Switch user** feature is used, the full name and logon tile are not displayed. The logon screen requests a qualified domain account name (or local user name) and password.

If this policy is disabled, the full name of the last user to log on is displayed, and the user' logon tile is displayed. This behavior is the same when the **Switch user** feature is used.

### Possible values

-   Enabled

-   Disabled

-   Not defined

### Best practices
Your implementation of this policy depends on your security requirements for displayed logon information. If you have running computers that store sensitive data, with monitors displayed in unsecured locations, or if you have computers with sensitive data that are remotely accessed, revealing logged on user' full names or domain account names might contradict your overall security policy.

Depending on your security policy, you might also want to enable the **Interactive logon: Display user information when the session is locked** policy, which will prevent the Windows operating system from displaying the logon name when the session is locked or started.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**

### Default values

|Server type or Group Policy object (GPO)|Default value|
|-----------------------|---------|
|Default domain policy|Disabled|
|Default domain controller policy|Disabled|
|Stand-alone server default settings|Disabled|
|Domain controller effective default settings|Disabled|
|Member server effective default settings|Disabled|
|Effective GPO default settings on client computers|Disabled|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2008 and Windows Vista.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Policy conflict considerations
None.

### Group Policy
This policy setting can be configured by using the Group Policy Management Console (GPMC) to be distributed through Group Policy Objects (GPOs). If this policy is not contained in a distributed GPO, this policy can be configured on the local computer by using the Local Security Policy snap-in.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
An attacker with access to the console (for example, someone with physical access or someone who can connect to the computer through Remote Desktop Session Host (RD Session Host)) could view the name of the last user who logged on. The attacker could then try to guess the password, use a dictionary, or use a brute-force attack to try to log on.

### Countermeasure
Enable the **Interactive logon: Do not display last user name** setting.

### Potential impact
Users must always type their user names and passwords when they log on locally or to the domain. The logon tiles of all logged on users are not displayed.


