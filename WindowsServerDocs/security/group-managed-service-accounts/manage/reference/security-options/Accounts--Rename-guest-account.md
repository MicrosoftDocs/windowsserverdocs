---
title: Accounts: Rename guest account
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d758269f-9088-406b-93d2-1c0315c4c97c
---
# Accounts: Rename guest account
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
The **Accounts: Rename guest account** policy setting determines whether a different account name is associated with the security identifier \(SID\) for the Guest account.

The Guest account exists in the  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003,  Windows 7 , Windows Vista, and Windows XP Professional operating systems. Renaming the Guest account makes it slightly more difficult for unauthorized persons to guess this privileged user name and password combination.

Rename the Guest account by specifying a value for the **Accounts: Rename guest account** policy setting.

The Guest account is disabled by default in Windows Server 2003, Windows 2000 Server, and Windows XP, but it is set as **Guest** in  Windows Server 2008 R2 ,  Windows Server 2008 ,  Windows 7 , and Windows Vista.

### Possible values

-   *User\-defined text*

-   Guest

### Best practices

1.  For computers in unsecured locations, renaming the account makes it more difficult for unauthorized users to guess it.

2.  For computers in secured or trusted locations, keeping the name of the account as Guest provides consistency among computers.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Guest|
|Default Domain Controller Policy|Guest|
|Stand\-Alone Server Default Settings|Guest|
|DC Effective Default Settings|Guest|
|Member Server Effective Default Settings|Guest|
|Client Computer Effective Default Settings|*User\-defined text*|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2008.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Policy conflict considerations
None.

### Group Policy
This policy setting can be configured by using the Group Policy Management Console \(GPMC\) to be distributed through Group Policy Objects \(GPOs\). If this policy is not contained in a distributed GPO, this policy can be configured on the local computer by using the Local Security Policy snap\-in.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The Guest account exists in all Windows server and client operating system versions beginning with Windows Server 2003 and Windows XP Professional. Because the account name is well known, it provides a vector for a malicious user to get access to network resources and attempt to elevate privileges or install software that could be used for a later attack on your system.

### Countermeasure
Specify a new name in the **Accounts: Rename guest account** setting to rename the Guest account. If you rename this account, it is slightly more difficult for unauthorized persons to guess this privileged user name and password combination.

### Potential impact
There should be little impact because the Guest account is disabled by default in Windows 2000 Server, Windows Server 2003, and Windows XP. For later operating systems, the policy is enabled with **Guest** as the default.


