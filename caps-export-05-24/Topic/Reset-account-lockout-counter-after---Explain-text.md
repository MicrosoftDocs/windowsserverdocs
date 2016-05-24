---
title: Reset account lockout counter after - Explain text
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7d0577af-f92b-4a7b-944c-c843407e13a0
---
# Reset account lockout counter after - Explain text
This policy setting determines the number of minutes that need to elapse before the counter that tracks failed sign\-in attempts and triggers account lockouts is reset to 0. This reset time must be less than or equal to the “Account lockout duration” policy setting. The account is automatically reset when this policy setting is configured between 1 and 99,999 minutes.  
  
The default value for this policy setting is: Undefined. The effect is that the policy setting is not evaluated.  
  
This policy setting is dependent on the “Account lockout threshold” and “Account lockout duration” policy settings.  
  
When the “Account lockout threshold” is greater than 0, the account is locked after the specified number of failed sign\-in attempts is reached. Once the account is locked out, the “Account lockout duration” begins. “Account lockout duration” must be set to a number of minutes that is greater than, or equal to, “Reset account lockout counter after”. When the minutes specified in “Account lockout duration” expires, and the “Reset account lockout counter after” value is reached, the system resets the account lockout counter automatically. Then user can sign in with their account without administrator assistance.  
  
When “Account lockout duration” is 0, a locked account can only be reset manually by an administrator.  
  
