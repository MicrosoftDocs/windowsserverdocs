---
title: Maximum tolerance for computer clock synchronization
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0bbd61ca-f953-416b-be57-b502cb670d0d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Maximum tolerance for computer clock synchronization

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This security setting determines the maximum time difference (in minutes) that Kerberos V5 tolerates between the time on the client clock and the time on the domain controller that provides Kerberos authentication.  
  
To prevent "replay attacks," the Kerberos v5 protocol uses time stamps as part of its protocol definition. For time stamps to work properly, the clocks of the client and the domain controller need to be in sync as much as possible. In other words, both computers must be set to the same time and date. Because the clocks of two computers are often out of sync, administrators can use this policy setting to establish the maximum acceptable difference to the Kerberos protocol between a client clock and domain controller clock. If the difference between a client computer clock and the domain controller clock is less than the maximum time difference that is specified in this policy, any time stamp that is used in a session between the two computers is considered to be authentic.  
  
> [!IMPORTANT]  
> Changes to this setting are not persistent on computers running Windows Server 2003 and Windows XP. If you configure this setting and then restart the computer, this setting reverts to the default value. Beginning with Windows Server 2008 and Windows Vista, you can persist changes if you select the option **Define this policy in the database**. Selecting this option does not change current computer time settings.  
>   
> This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
The possible values for this Group Policy setting are:  
  
-   A user-defined number of minutes from 1 through 99,999  
  
-   Not defined  
  
To prevent replay attacks, the Kerberos protocol uses time stamps as part of its definition. For time stamps to work properly, the clocks of the client computer and the domain controller need to be synchronized as closely as possible. Because the clocks of two computers are often out of sync, administrators can use this policy setting to establish the maximum acceptable difference to the Kerberos protocol between a client computer clock and domain controller clock. If the difference between a client computer clock and the domain controller clock is less than **Maximum tolerance for computer clock synchronization**, any time stamp that is used in a session between the two computers is considered authentic.  
  
#### Best practices  
  
1.  It is advisable to set **Maximum tolerance for computer clock synchronization** to a value of 5 minutes.  
  
#### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Account Policies\Kerberos Policy\  
  
#### Default values  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|5 minutes|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Not applicable|  
|Domain Controller Effective Default Settings|5 minutes|  
|Member Server Effective Default Settings|Not applicable|  
|Client Computer Effective Default Settings|Not applicable|  
  
#### Operating system version differences  
There are no differences in the way this policy setting works between supported versions of Windows.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
This policy setting is configured on the domain controller.  
  
### Group Policy  
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
To prevent "replay attacks" (which are attacks in which an authentication credential is resubmitted by a malicious user or program to gain access to a protected resource), the Kerberos protocol uses time stamps as part of its definition. For time stamps to work properly, the clocks of the client computer and the domain controller need to be closely synchronized. Because the clocks of two computers are often not synchronized, administrators can use this policy to establish the maximum acceptable difference to the Kerberos protocol between a client computer clock and a domain controller clock. If the difference between the client computer clock and the domain controller clock is less than the maximum time difference specified in this setting, any time stamp that is used in a session between the two computers is considered to be authentic.  
  
### Countermeasure  
Configure the **Maximum tolerance for computer clock synchronization** setting to 5 minutes.  
  
### Potential impact  
None. This is the default configuration.  
  
### Additional references  
The following links provide additional information about topics that relate to securing domain controllers:  
  
-   [Modify Default Security Policies on Windows Server 2008-Based Domain Controllers](http://go.microsoft.com/fwlink/?LinkID=130889)  
  
-   [Best Practice Guide for Securing Windows Server Active Directory Installations](http://go.microsoft.com/fwlink/?LinkId=130890)  
  
## See Also  
[Kerberos Policy](../kerberos/Kerberos-Policy.md)  
  

