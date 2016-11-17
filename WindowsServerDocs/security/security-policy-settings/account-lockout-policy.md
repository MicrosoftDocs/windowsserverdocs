---
title: Account Lockout Policy
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2c112718-a472-4615-abc5-6edc409bdda8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Account Lockout Policy

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for the IT professional describes the Account Lockout Policy settings and links to information about each policy setting.  
  
## Overview of Account Lockout Policy settings  
Someone who attempts to use more than a few unsuccessful passwords while trying to log on to your system might be a malicious user who is attempting to determine an account password by trial and error. Beginning with Windows Server 2003, Windows domain controllers keep track of logon attempts, and domain controllers can be configured to respond to this type of potential attack by disabling the account for a preset period of time. Account Lockout Policy settings control the threshold for this response and the actions to be taken after the threshold is reached. The Account Lockout Policy settings can be configured in the following location in the Group Policy Management Console: **Computer Configuration\Windows Settings\Security Settings\Account Policies\Account Lockout Policy**.  
  
For information about setting security policies, see [How to Configure Security Policy Settings](how-to-configure-security-policy-settings.md).  
  
The following topics provide a discussion of each policy setting's implementation and best practices considerations, policy location, default values for the server type or Group Policy Object (GPO), relevant differences in operating system versions, and security considerations (including the possible vulnerabilities of each policy setting), countermeasures that you can implement, and the potential impact of implementing the countermeasures.  
  
-   [Account lockout duration](account-lockout-duration.md)  
  
-   [Account lockout threshold](account-lockout-threshold.md)  
  
-   [Reset account lockout counter after](reset-account-lockout-counter-after.md)  
  

