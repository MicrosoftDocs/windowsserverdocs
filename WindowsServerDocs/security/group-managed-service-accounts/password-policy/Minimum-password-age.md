---
title: Minimum password age
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b037457-3182-447a-98df-e0d2ad669baa
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Minimum password age

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
The **Minimum password age** policy setting determines the period of time (in days) that a password can be used before the system requires the user to change it. You can set passwords to expire after a number of days between 1 and 999, or you can specify that passwords never expire by setting the number of days to 0. If **Maximum password age** is between 1 and 999 days, the minimum password age must be less than the maximum password age. If **Maximum password age** is set to 0, **Minimum password age** can be any value between 0 and 998 days.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

### Possible values

-   User-specified number of days between 0 and 998

-   Not defined

### Best practices
Set **Minimum password age** to a value of 2 days. Setting the number of days to 0 allows immediate password changes, which is not recommended.

If an administrator sets a password for a user and wants that user to change the administrator-defined password, the administrator must select the **User must change password at next logon** check box. Otherwise, the user will not be able to change the password until the number of days specified by **Minimum password age**.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy**

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or Group Policy Object (GPO)|Default value|
|-----------------------|---------|
|Default domain policy|1 day|
|Default domain controller policy|Not defined|
|Stand-alone server default settings|0 days|
|Domain controller effective default settings|1 day|
|Member server effective default settings|1 day|
|Effective GPO default settings on client computers|1 day|

### Operating system version differences
There are no differences in the way this policy setting works between supported versions of Windows.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Users may have favorite passwords that they like to use because they are easy to remember and they believe that their password choice is secure from compromise. Unfortunately, passwords can be compromised and if an attacker is targeting a specific individual user account, with knowledge of data about that user, reuse of old passwords can cause a security breach.

To address password reuse, you must use a combination of security settings. Using this policy setting with the **Enforce password history** policy setting prevents the easy reuse of old passwords. For example, if you configure the **Enforce password history** policy setting to ensure that users cannot reuse any of their last 12 passwords, but you do not configure the **Minimum password age** policy setting to a number that is greater than 0, users could change their password 13 times in a few minutes and reuse their original password. You must configure this policy setting to a number that is greater than 0 for the **Enforce password history** policy setting to be effective.

### Countermeasure
Configure the **Minimum password age** policy setting to a value of at least 2 days. Users should know about this limitation and contact the Help Desk if they need to change their password during that two-day period. If you configure the number of days to 0, immediate password changes would be allowed, which we do not recommend.

### Potential impact
If an administrator sets a password for a user but wants that user to change the password when the user first logs on, the administrator must select the **User must change password at next logon** check box, or the user cannot change the password until the next day.

## See Also
[Password Policy](Password-Policy.md)


