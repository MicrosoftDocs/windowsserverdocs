---
title: Access Credential Manager as a trusted caller
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 214b3f36-bb73-49b2-8546-17fbc295b114
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Access Credential Manager as a trusted caller

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
The **Access Credential Manager as a trusted caller** policy setting is used by Credential Manager during backup and restore. No accounts should have this privilege because it is assigned only to the Winlogon service. Saved credentials of users may be compromised if this privilege is given to other entities.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeTrustedCredManAccessPrivilege

### Possible values

-   User-defined list of accounts

-   Not defined

### Best practices

-   Do not modify this policy setting from the default.

### Location
**\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment**

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default domain policy|Not defined|
|Default domain controller policy|Not defined|
|Stand-alone server default settings|Not defined|
|Domain controller effective default settings|Not defined|
|Member server effective default settings|Not defined|
|Client computer effective default settings|Not defined|

### Operating system version differences
This setting was introduced with Windows Vista and Windows Server 2008. There are no differences in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

### Group Policy
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If an account is given this user right, the user of the account may create an application that calls into Credential Manager and is returned the credentials for another user.

### Countermeasure
Do not define the **Access Credential Manager as a trusted caller** policy setting for any accounts besides Credential Manager.

### Potential impact
None. Not defined is the default configuration.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


