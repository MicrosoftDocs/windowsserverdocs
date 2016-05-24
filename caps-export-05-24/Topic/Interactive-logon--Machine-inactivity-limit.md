---
title: Interactive logon: Machine inactivity limit
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 96e1ea38-4131-4b8b-874e-db2730978510
---
# Interactive logon: Machine inactivity limit
This security policy reference topic for the IT professional describes the best practices, location, values, management, and security considerations for this policy setting.  
  
## Reference  
Beginning with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows detects user\-input inactivity of a sign\-in \(logon\) session by using the security policy setting **Interactive logon: Machine inactivity limit**. If the amount of inactive time exceeds the inactivity limit set by this policy, then the user’s session locks by invoking the screen saver. This policy setting allows you to control the locking time by using Group Policy.  
  
In versions earlier than [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], the desktop\-locking mechanism was set on individual computers in Personalization in Control Panel.  
  
### Possible values  
The automatic lock of the computer is set in elapsed seconds of inactivity, which can range from zero \(0\) to 599,940 seconds \(166.65 hours\).  
  
If no value \(blank\) or zero \(0\) is present in the **Machine will be locked after** input field, then the policy setting is disabled and no action is taken on user\-input inactivity for the session.  
  
### Best practices  
Set the time for elapsed user\-input inactivity based on the computer’s usage and location requirements. For example, if the computer or device is in a public area, you might want to have the desktop automatically lock after a short period of inactivity to prevent unauthorized access. However, if the computer or device is used by an individual or group of trusted individuals, such as in a restricted manufacturing area, automatically locking the desktop might hinder productivity.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
This policy setting was introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
Restart is required for changes to this policy to become effective when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
Because this policy setting was introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], it can only be set locally on those computers that contain this policy setting, but it can be set and distributed through Group Policy to any computer running the Windows operating system that supports Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
This policy setting helps you prevent unauthorized access to computers or devices under your control when the currently signed\-in user leaves without deliberately locking the desktop. In versions earlier than [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], the desktop\-locking mechanism was set on individual computers in Personalization in Control Panel.  
  
### Countermeasure  
Set the time for elapsed user\-input inactivity time by using the security policy setting **Interactive logon: Machine inactivity limit** based on the computer’s usage and location requirements.  
  
### Potential impact  
This security policy setting can limit unauthorized access to unsecured computers; however, that requirement must be balanced with the productivity requirements of the intended computer user.  
  
## See Also  
[Security Options](../Topic/Security-Options.md)  
  
