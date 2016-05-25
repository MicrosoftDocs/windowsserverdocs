---
title: Account lockout duration - Explain text
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b87cac2e-32c3-4dfc-89b1-3785010eca32
---
# Account lockout duration - Explain text
This policy setting determines the number of minutes that a locked\-out account remains locked out before it is automatically unlocked.  
  
This policy setting can be set to between 0 and 99,999 minutes. When set to 0, a locked account can only be reset manually by an administrator.  
  
The default value for this policy setting is: Undefined. The effect is that the policy setting is not evaluated.  
  
This policy setting is dependent on the “Account lockout threshold” and “Reset account lockout counter after” policy settings.  
  
When the “Account lockout threshold” is greater than 0, the account is locked after the specified number of failed sign\-in attempts is reached. Once the account is locked out, the “Account lockout duration” begins. “Account lockout duration” must be set to a number of minutes that is greater than, or equal to, “Reset account lockout counter after”. When the minutes specified in “Account lockout duration” expires, and the “Reset account lockout counter after” value is reached, the system resets the account lockout counter automatically. Then the user can sign in with their account without administrator assistance.  
  
