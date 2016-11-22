---
title: Shutdown: Allow system to be shut down without having to log on
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f4fbe773-9faa-4b90-91cc-16b82f9ce5b1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Shutdown: Allow system to be shut down without having to log on

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines whether a computer can be shut down without having to log on to the Windows operating system. If you enable this policy setting, the **Shut Down** option is available on the logon screen in the Windows operating system. If you disable this policy setting, the **Shut Down** option is removed from the logon screen. This configuration requires that users are able to log on to the computer successfully and that they have the **Shut down the system** user right before they can perform a computer shutdown.  
  
Users who can access the console locally can shut down the system. Attackers or misguided users can connect to the server by using Terminal Services or Remote Desktop Services, and then shut it down or restart it without having to identify themselves. A malicious user might also cause a temporary denial-of-service condition by walking up to the local console and restarting the server, or shutting down the server and thus rendering unavailable all its applications and services.  
  
### Possible values  
  
-   Enabled  
  
    The Shut Down command is available on the logon screen in the Windows operating system.  
  
-   Disabled  
  
    The Shut Down option is removed from the logon screen and users must have the **Shut down the system** user right before they can perform a computer shutdown.  
  
-   Not defined  
  
### Best practices  
  
1.  On servers, set this policy to **Disabled**. Administrators must log on to servers to shut them down or restart them.  
  
2.  On client computers, set this policy to **Enabled** and define the list of those with the right to shut them down or restart them with the User Rights Assignment policy **Shut down the system**.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy's property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Enabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Server 2008 and Windows Vista.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
For information about the User Rights Assignment policy, **Shut down the system**, see the [user-rights-assignment/Shut down the system](shut-down-the-system.md) reference topic.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Users who can access the console locally could shut down the computer.  
  
Attackers who have access to the local console could restart the server, which would cause a temporary DoS condition. Attackers could also shut down the server and leave all of its applications and services unavailable.  
  
### Countermeasure  
Disable the **Shutdown: Allow system to be shut down without having to log on** setting.  
  
### Potential impact  
Operators must log on to servers to shut them down or restart them.  
  

