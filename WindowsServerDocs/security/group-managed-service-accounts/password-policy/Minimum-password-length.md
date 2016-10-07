---
title: Minimum password length
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1afdb5ea-be46-4fb8-908a-f6dd4f5bc719
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Minimum password length

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
The **Minimum password length** policy setting determines the least number of characters that can make up a password for a user account. You can set a value of between 1 and 14 characters, or you can establish that no password is required by setting the number of characters to 0.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

### Possible values

-   User-specified number of characters between 0 and 14

-   Not defined

### Best practices
Set **Minimum password length** value to 14. If the number of characters is set to 0, no password is required. In most environments, a fourteen-character password is recommended because it is long enough to provide adequate security and still short enough for users to easily remember. This value will help provide adequate defense against a brute force attack. Adding complexity requirements will help reduce the possibility of a dictionary attack. For more information, see [Password must meet complexity requirements](Password-must-meet-complexity-requirements.md).

Permitting short passwords reduces security because short passwords can be easily broken with tools that perform dictionary or brute force attacks against the passwords. Requiring very long passwords can result in mistyped passwords that might cause an account lockout and subsequently increase the volume of Help Desk calls.

In addition, requiring extremely long passwords can actually decrease the security of an organization because users might be more likely to write down their passwords to avoid forgetting them. However, if users are taught that they can use passphrases (sentences such as "I want to drink a $5 milkshake"), they should be much more likely to remember.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy**

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or Group Policy Object (GPO)|Default value|
|----------------------------------------------|-----------------|
|Default domain policy|7 characters|
|Default domain controller policy|Not defined|
|Stand-alone server default settings|0 characters|
|Domain controller effective default settings|7 characters|
|Member server effective default settings|7 characters|
|Effective GPO default settings on client computers|0 characters|

### Operating system version differences
There are no differences in the way this policy setting works between supported versions of Windows.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Types of password attacks include dictionary attacks (which attempt to use common words and phrases) and brute force attacks (which try every possible combination of characters). Also, attackers sometimes try to obtain the account database so they can use tools to discover the accounts and passwords.

### Countermeasure
Configure the **Minimum password length** policy setting to a value of 8 or more. If the number of characters is set to 0, no password will be required.

In most environments, we recommend an eight-character password because it is long enough to provide adequate security, but not too difficult for users to easily remember. This configuration provides adequate defense against a brute force attack. Using the **Passwords must meet complexity requirements** policy setting in addition to the **Minimum password length** setting helps reduce the possibility of a dictionary attack.

> [!NOTE]
> Some jurisdictions have established legal requirements for password length as part of establishing computer security regulations.

### Potential impact
Requirements for extremely long passwords can actually decrease the security of an organization because users might leave the information in an unsecured location or lose it. If very long passwords are required, mistyped passwords could cause account lockouts and increase the volume of Help Desk calls. If your organization has issues with forgotten passwords due to password length requirements, consider teaching your users about passphrases, which are often easier to remember and, due to the larger number of character combinations, much harder to discover.

> [!NOTE]
> Older versions of Windows (such as Windows 98 and Windows NT 4.0) do not support passwords that are longer than 14 characters. Computers that run these older operating systems are unable to authenticate with computers or domains that use accounts that require long passwords.

## See Also
[Password Policy](Password-Policy.md)


