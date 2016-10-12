---
title: Interactive logon: Require smart card
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1cebcf96-3d4a-4c09-8b1a-883daed74212
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Interactive logon: Require smart card

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
The **Interactive logon: Require smart card** policy setting requires users to log on to a computer by using a smart card.

Requiring users to use long, complex passwords for authentication enhances network security, especially if the users must change their passwords regularly. This reduces the chance that a malicious user will be able to guess a user's password through a brute-force attack. Using smart cards rather than passwords for authentication dramatically increases security because, with today's technology, it is nearly impossible for a malicious user to impersonate another user. Smart cards that require personal identification numbers (PINs) provide two-factor authentication: the user who attempts to log on must possess the smart card and know its PIN. A malicious user who captures the authentication traffic between the user's computer and the domain controller will find it extremely difficult to decrypt the traffic: even if they do, the next time the user logs on to the network, a new session key will be generated for encrypting traffic between the user and the domain controller.

### Possible values

-   Enabled

-   Disabled

-   Not defined

### Best practices

1.  Set **Interactive logon: Require smart card** to Enabled. All users will have to use smart cards to log on to the network. This means that the organization must have a reliable public key infrastructure (PKI) in place, and provide smart cards and smart card readers for all users.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

In Windows Server 2003, Microsoft implemented the PKI called Certificate Services. In later operating system versions, Certificate Services was renamed Active Directory® Certificate Services (AD CS), and it became a separate server role that is installed by using Server Manager.

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
It can be difficult to make users choose strong passwords, and even strong passwords are vulnerable to brute-force attacks if an attacker has sufficient time and computing resources.

### Countermeasure
For users with access to computers that contain sensitive data, issue smart cards to users and configure the **Interactive logon: Require smart card** setting to Enabled.

### Potential impact
All users of a computer with this setting enabled must use smart cards to log on to the local computer. This means that the organization must have a reliable public key infrastructure (PKI) as well as smart cards and smart card readers for these users. These requirements are significant challenges because expertise and resources are required to plan for and deploy these technologies.  Windows Server 2008 R2  and  Windows Server 2008  include Active Directory Certificate Services (AD CS) to implement and manage certificates. When AD CS is used with  Windows 7  or Windows Vista, features such as automatic user and computer enrollment and renewal become available.


