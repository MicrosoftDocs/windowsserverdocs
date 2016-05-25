---
title: Account lockout threshold - Explain text
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8d0ee916-1079-499d-a757-5b8b5ca84f1d
---
# Account lockout threshold - Explain text
This policy setting determines the number of failed sign\-in attempts that are allowed to occur on a user account before the account is locked out. Once an account is locked out, it cannot be used until it is reset by an administrator or until “Account lockout duration” has expired.  
  
This policy setting can be configured between 0 and 999 failed sign\-in attempts.  
  
The default value for this policy setting is: 0  
  
When this policy setting is set to 0, the account cannot be locked out. This helps to prevent denial\-of\-service attacks that intentionally attempt to lock out accounts.  
  
When this policy setting is greater than 0, the account is locked after the specified number of failed sign in attempts is reached, so it needs to be set to a value that is high enough to sufficiently provide users with the ability to accidentally mistype their password several times before the account is locked out. This value also needs to ensure that the account can be locked out within a given number of invalid sign in attempts, such as when malicious users initiate a brute force password attack.  
  
This policy setting is dependent on the “Account lockout duration” and “Reset account lockout counter after” policy settings. If “Account lockout threshold” is set to a number of invalid attempts greater than 0, a locked\-out account is not usable until it is reset by an administrator, or until the time specified in “Account lockout duration” expires.  
  
Once the account is locked out, the “Account lockout duration” begins. “Account lockout duration” must be set to a number of minutes that is greater than, or equal to, “Reset account lockout counter after”. When the minutes specified in “Account lockout duration” expires, and the “Reset account lockout counter after” value is reached, the system resets the account lockout counter automatically. Then the user can sign in with their account without administrator assistance.  
  
Notes  
  
\- Failed password attempts against workstations or member servers that have been locked by pressing CTRL\+ALT\+DELETE, or by password\-protected screen savers, do not count as failed attempts, unless the “Interactive logon: Require Domain Controller authentication to unlock workstation” policy setting is enabled.  
  
\- Applications and services, including authentication services, might also attempt numerous sign\-in attempts. These count against the threshold setting.  
  
