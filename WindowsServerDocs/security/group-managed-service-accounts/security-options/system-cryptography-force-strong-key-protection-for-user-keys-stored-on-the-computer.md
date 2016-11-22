---
title: System cryptography: Force strong key protection for user keys stored on the computer
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 71b4d0f0-650c-4249-b46d-d8e9213568f2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# System cryptography: Force strong key protection for user keys stored on the computer

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines whether users can use private keys, such as their Secure/Multipurpose Internet Mail Extensions (S/MIME) key, without a password.

Configuring this policy setting so that users must provide a password every time they use a key (in addition to their domain password) makes it more difficult for a malicious user to access locally-stored user keys, even if the attacker takes control of the user's computer and determines their logon password.

### Possible values

-   **User input is not required when new keys are stored and used**

-   **User is prompted when the key is first used**

-   **User must enter a password each time they use a key**

-   Not defined

### Best practices

1.  Set this policy to **User must enter a password each time they use a key**. Users must enter their password every time they access a key that is stored on their computer. For example, if users use an S/MIME certificate to digitally sign their email, they will be forced to enter the password for that certificate every time they send a signed email message. For some organizations, the overhead that is caused by using this value might be too high, but they should set the value at a minimum to **User is prompted when the key is first used**.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy's property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not defined|
|DC Effective Default Settings|Not defined|
|Member Server Effective Default Settings|Not defined|
|Client Computer Effective Default Settings|Not defined|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If a user's account is compromised or the user's computer is inadvertently left unsecured, the malicious user can use the keys that are stored for the user to access protected resources.

### Countermeasure
Configure the **System cryptography: Force strong key protection for user keys stored on the computer** setting to **User must enter a password each time they use a key** so that users must provide a password that is distinct from their domain password every time they use a key. This configuration makes it more difficult for an attacker to access locally stored user keys, even if the attacker takes control of the user's computer and determines the logon password.

### Potential impact
Users must type their password every time they access a key that is stored on their computer. For example, if users use an S/MIME certificate to digitally sign their email, they are forced to type the password for that certificate every time they send a signed email message. For some organizations, the overhead that is involved by using this configuration may be too high. At a minimum, this setting should be set to **User is prompted when the key is first used**.


