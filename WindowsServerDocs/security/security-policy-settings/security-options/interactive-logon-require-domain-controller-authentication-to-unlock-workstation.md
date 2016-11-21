---
title: Interactive logon: Require Domain Controller authentication to unlock workstation
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cfc92eb5-ee4a-46fb-ba03-610c11c9c085
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Interactive logon: Require Domain Controller authentication to unlock workstation

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
Unlocking a locked computer requires logon information. For domain accounts, the **Interactive logon: Require Domain Controller authentication to unlock workstation** policy setting determines whether it is necessary to contact a domain controller to unlock a computer. Enabling this policy setting requires a domain controller to authenticate the domain account that is being used to unlock the computer. Disabling this policy setting allows a user to unlock the computer without the computer verifying the logon information with a domain controller. However, if **Interactive logon: Number of previous logons to cache (in case domain controller is not available)** is set to a value greater than zero, the user's cached credentials will be used to unlock the system.  
  
The computer caches (locally in memory) the credentials of any users who have been authenticated. The computer uses these cached credentials to authenticate anyone who attempts to unlock the console.  
  
When cached credentials are used, any changes that have recently been made to the account (such as user rights assignments, account lockout, or the account being disabled) are not considered or applied after this authentication process. This means not only that user rights are not updated, but more importantly that disabled accounts are still able to unlock the console of the system.  
  
It is advisable to set **Interactive logon: Require Domain Controller authentication to unlock workstation** to Enabled and set **Interactive logon: Number of previous logons to cache (in case domain controller is not available)** to 0. When the console of a computer is locked by a user or automatically by a screen saver time-out, the console can only be unlocked if the user is able to reauthenticate to the domain controller. If no domain controller is available, users cannot unlock their workstations.  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
  
1.  Set **Interactive logon: Require Domain Controller authentication to unlock workstation** to Enabled and set **Interactive logon: Number of previous logons to cache (in case domain controller is not available)** to 0. When the console of a computer is locked by a user or automatically by a screen saver time-out, the console can only be unlocked if the user is able to reauthenticate to the domain controller. If no domain controller is available, users cannot unlock their workstations.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Server 2003.  
  
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
By default, the computer caches locally in memory the credentials of any users who are authenticated. The computer uses these cached credentials to authenticate anyone who attempts to unlock the console. When cached credentials are used, any changes that have recently been made to the account'uch as user rights assignments, account lockout, or the account being disabled???are not considered or applied after the account is authenticated. User privileges are not updated, and disabled accounts are still able to unlock the console of the computer.  
  
### Countermeasure  
Configure the **Interactive logon: Require Domain Controller authentication to unlock workstation** setting to Enabled and configure the **Interactive logon: Number of previous logons to cache (in case domain controller is not available)** setting to 0.  
  
### Potential impact  
When the console on a computer is locked by a user or automatically by a screen-saver timeout, the console can be unlocked only if the user can reauthenticate to the domain controller. If no domain controller is available, users cannot unlock their workstations. If you configure the **Interactive logon: Number of previous logons to cache (in case domain controller is not available)** setting to 0, users whose domain controllers are unavailable (such as mobile or remote users) cannot log on.  
  

