---
title: Network access: Allow anonymous SID Name translation
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 418f3563-d8c6-41dd-8b0e-df23ffaef349
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network access: Allow anonymous SID Name translation

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting enables or disables the ability of an anonymous user to request security identifier (SID) attributes for another user.  
  
If this policy setting is enabled, a user might use the well-known Administrators SID to get the real name of the built-in Administrator account, even if the account has been renamed. That person might then use the account name to initiate a brute-force password-guessing attack.  
  
Misuse of this policy setting is a common error that can cause data loss or problems with data access or security.  
  
### Possible values  
  
-   Enabled  
  
    An anonymous user can request the SID attribute for another user. An anonymous user with knowledge of an administrator's SID could contact a computer that has this policy enabled and use the SID to get the administrator's name. This setting affects the SID-to-name translation as well as the name-to-SID translation  
  
-   Disabled  
  
    Prevents an anonymous user from requesting the SID attribute for another user.  
  
-   Not defined  
  
### Best practices  
  
-   Set this policy to Disabled. This is the default value on member computers; therefore, it will have no impact on them. The default value for domain controllers is Enabled. Disabling this policy setting on domain controllers means that legacy systems might be unable to communicate with Windows Server 2003-based domains.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Note defined|  
|Stand-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Enabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
The default value of this setting has changed between operating systems as follows:  
  
-   The default on domain controllers running Windows Server 2003 R2 or earlier was set to Enabled.  
  
-   The default on domain controllers running Windows Server 2008 or Windows Server 2008 R2 is set to Disabled.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
Modifying this setting may affect compatibility with client computers, services, and applications.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
If this policy setting is enabled, a user with local access could use the well-known Administrator's SID to learn the real name of the built-in Administrator account, even if it has been renamed. That person could then use the account name to initiate a password-guessing attack.  
  
### Countermeasure  
Disable the **Network access: Allow anonymous SID/Name translation** setting.  
  
### Potential impact  
Disabled is the default configuration for this policy setting on member computers; therefore, it has no impact on them. The default configuration for domain controllers is Enabled. If you disable this policy setting on domain controllers, computers running versions of Windows earlier than Windows Server 2003 may not communicate with Windows Server 2003–based domains. For example, computers with the following configurations may not work:  
  
-   Windows NT 4.0–based Remote Access Service servers  
  
-   Servers that host Microsoft SQL Server® and run on Windows NT 3.x–based or Windows NT 4.0–based computers  
  
-   Servers that host Remote Access Service or Microsoft SQL Server that run on Windows 2000–based computers and are located in Windows NT domains  
  

