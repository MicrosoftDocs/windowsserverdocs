---
title: Devices: Allow undock without having to log on
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68361ed4-bad2-4dac-8778-c1edb53fb935
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Devices: Allow undock without having to log on

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
This policy setting enables or disables the ability of a user to remove a portable computer from a docking station without logging on. If you enable this policy setting, users can press a docked portable computer's physical eject button to safely undock the computer. If you disable this policy setting, the user must log on to receive permission to undock the computer. Only users who have the **Remove Computer from Docking Station** privilege can obtain this permission.  
  
> [!NOTE]  
> Disabling this policy setting only reduces theft risk for portable computers that cannot be mechanically undocked. Computers that can be mechanically undocked can be physically removed by the user whether or not they use the Windows undocking functionality.  
  
Enabling this policy setting means that anyone with physical access to a computer that has been placed in its docking station can remove the computer and possibly tamper with it. For computers that do not have docking stations, this policy setting has no impact. However, for users with a mobile computer that is normally docked while they are in the office, this policy setting will help lower the risk of equipment theft or a malicious user gaining physical access to these computers.  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
It is advisable to disable the **Devices: Allow undock without having to log on** policy setting. Users who have docked their computers will have to log on to the local console before they can undock their systems.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Enabled|  
|DC Effective Default Settings|Enabled|  
|Member Server Effective Default Settings|Enabled|  
|Client Computer Effective Default Settings|Enabled|  
  
### Operating system version differences  
There are no differences in this policy setting between operating systems beginning with Windows Server 2003.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
If this policy setting is enabled, anyone with physical access to portable computers in docking stations could remove them and possibly tamper with them.  
  
### Countermeasure  
Disable the **Devices: Allow undock without having to log on** setting.  
  
### Potential impact  
Users who have docked their computers must log on to the local console before they can undock their computers. For computers that do not have docking stations, this policy setting has no impact.  
  

