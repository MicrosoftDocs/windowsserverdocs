---
title: Interactive logon: Prompt user to change password before expiration
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9f8448ce-9c78-4411-afb6-2826d453507a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Interactive logon: Prompt user to change password before expiration

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
The **Interactive logon: Prompt user to change password before expiration** policy setting determines how many days in advance users are warned that their passwords are about to expire. With this advance warning, the user has time to construct a password that is sufficiently strong.

### Possible values

-   A user-defined number of days from 0 through 999.

-   Not defined.

### Best practices

1.  Configure user passwords to expire periodically. Users will need warning that their passwords are going to expire, or they might inadvertently get locked out of the system. This could lead to confusion for users who access the network locally, or make it impossible for users who access the network through dial-up or virtual private network (VPN) connections to log on.

2.  Set **Interactive logon: Prompt user to change password before expiration** to 5 days. When their password expiration date is 5 or fewer days away, users will see a dialog box each time they log on to the domain.

3.  Do not set the value to 0, which results in displaying the password expiration warning every time the user logs on.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|14 days *|
|DC Effective Default Settings|14 days *|
|Member Server Effective Default Settings|14 days *|
|Client Computer Effective Default Settings|14 days *|

### Operating system version differences
Beginning with Windows Server 2008 R2 and Windows 7, the default value changed to 5 days.

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
If user passwords are configured to expire periodically in your organization, users need to be warned when this is about to happen, or they may be locked out of the computer inadvertently when their passwords expire. This condition could lead to confusion for users who access the network locally, or make it impossible for users to access your organization's network through dial-up or virtual private network (VPN) connections.

### Countermeasure
Configure the **Interactive logon: Prompt user to change password before expiration** setting to 14 days.

### Potential impact
Users see a dialog-box prompt to change their password each time that they log on to the domain when their password is configured to expire in 14 or fewer days.


