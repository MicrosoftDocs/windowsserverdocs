---
title: Accounts: Rename administrator account
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb9d46bd-3e02-4f8e-b10d-1092609b786f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Accounts: Rename administrator account

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
The **Accounts: Rename administrator account** policy setting determines whether a different account name is associated with the security identifier (SID) for the Administrator account.

Because the Administrator account exists on all Windows server versions, renaming the account makes it slightly more difficult for attackers to guess this user name and password combination. By default, the built-in Administrator account cannot be locked out no matter how many times a malicious user might use a bad password. This makes the Administrator account a popular target for brute-force password-guessing attacks. The value of this countermeasure is lessened because this account has a well-known SID and there are non-Microsoft tools that allow you to initiate a brute-force attack over the network by specifying the SID rather than the account name. This means that even if you have renamed the Administrator account, a malicious user could start a brute-force attack by using the SID.

Rename the Administrator account by specifying a value for the **Accounts: Rename administrator account** policy setting.

### Possible values

-   User-defined text

-   Not defined

### Best practices

1.  Be sure to inform users who are authorized to use this account of the new account name.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Administrator|
|DC Effective Default Settings|Administrator|
|Member Server Effective Default Settings|Administrator|
|Client Computer Effective Default Settings|Administrator|

### Operating system version differences
In Windows Server 2003, this policy setting is not configured in the security templates, nor is a new user name for the account suggested there. This is so that numerous organizations reading this guide will not implement the same new user name in their environments. In later versions of the Windows operating system, the preconfigured security templates were removed.

Beginning with Windows Vista, the person who installs the operating system specifies an account that is the first member of the Administrator group and has full rights to configure the computer.

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
The Administrator account exists on all computers that run the  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003, Windows 2000 Server, or Windows XP Professional operating systems. If you rename this account, it is slightly more difficult for unauthorized persons to guess this privileged user name and password combination. Beginning with Windows Vista, the person who installs the operating system specifies an account that is the first member of the Administrator group and has full rights to configure the computer. The account cannot have the name Administrator, so this countermeasure is applied by default on new Windows Vista and  Windows 7  installations. If a computer is upgraded from a previous version of Windows to Windows Vista or  Windows 7 , the account with the name Administrator is retained with all the rights and privileges that were defined for the account in the previous installation.

The built-in Administrator account cannot be locked out, regardless of how many times an attacker might use a bad password. This capability makes the Administrator account a popular target for brute-force attacks that attempt to guess passwords. The value of this countermeasure is lessened because this account has a well-known SID, and there are non-Microsoft tools that allow authentication by using the SID rather than the account name. Therefore, even if you rename the Administrator account, an attacker could launch a brute-force attack by using the SID to log on.

### Countermeasure
Specify a new name in the **Accounts: Rename administrator account** setting to rename the Administrator account.

### Potential impact
You must provide users who are authorized to use this account with the new account name. (The guidance for this setting assumes that the Administrator account was not disabled.)


