---
title: Maximum lifetime for user ticket renewal
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3ceeed17-69d0-4c5a-b16f-c142802b8b5e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Maximum lifetime for user ticket renewal

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
The **Maximum lifetime for user ticket renewal** policy setting determines the period of time (in days) during which a user???s ticket-granting ticket can be renewed.  
  
The possible values for this Group Policy setting are:  
  
-   A user-defined number of days from 0 through 99,999  
  
-   Not defined  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
#### Best practices  
  
1.  If the value for this policy setting is too high, users may be able to renew very old user ticket-granting tickets. If the value is 0, ticket-granting tickets never expire.  
  
    It is advisable to set **Maximum lifetime for user ticket renewal** to **7** days.  
  
#### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Account Policies\Kerberos Policy\  
  
#### Default values  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|7 days|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Not applicable|  
|Domain Controller Effective Default Settings|7 days|  
|Member Server Effective Default Settings|Not applicable|  
|Client Computer Effective Default Settings|Not applicable|  
  
#### Operating system version differences  
There are no differences in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
### Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
This policy setting is configured on the domain controller.  
  
#### Group Policy  
Client computers will get the new setting during the next scheduled and successful Group Policy refresh. But for domain controllers to assign these new settings immediately, a Gpupdate /force is required. On the local computer, the Security Configuration Engine will refresh this setting in about five minutes.  
  
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
If the value for the **Maximum lifetime for user ticket renewal** setting is too high, users might be able to renew very old user tickets.  
  
### Countermeasure  
Configure the **Maximum lifetime for user ticket renewal** setting to 7 days.  
  
### Potential impact  
None. This is the default configuration.  
  
## See Also  
[Kerberos Policy](../kerberos/kerberos-policy.md)  
  

