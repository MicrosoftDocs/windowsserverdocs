---
title: User Account Control: Detect application installations and prompt for elevation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b280407b-4e8b-4d0a-84a3-b99258b8ed38
---
# User Account Control: Detect application installations and prompt for elevation
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines the behavior of application installation detection for the entire system.  
  
Some software might attempt to install itself after being given permission to run. The user may give permission for the program to run because the program is trusted. Then the user is prompted to install an unknown component. This security policy provides another way to identify and stop these attempted software installations before they can do damage.  
  
### Possible values  
  
-   **Enabled**  
  
    Application installation packages that require an elevation of privilege to install are detected and the user is prompted for administrative credentials.  
  
-   **Disabled**  
  
    Application installation packages that require an elevation of privilege to install are not detected and the user is not prompted for administrative credentials.  
  
### Best practices  
  
1.  Installer detection is unnecessary when enterprises run standard user desktops that capitalize on delegated installation technologies like Group Policy Software Install \(GPSI\) or SMS. Therefore you can set this security policy to **Disabled**.  
  
2.  Enable the **User Account Control: Detect application installations and prompt for elevation** setting so standard users must provide administrative credentials before software is installed.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|Enabled|  
|DC Effective Default Settings|Enabled|  
|Member Server Effective Default Settings|Enabled|  
|Client Computer Effective Default Settings|Enabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Vista and Windows Server 2008.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Some malicious software might attempt to install itself after being given permission to run, for example, malicious software with a trusted application shell. The user may give permission for the program to run because the program is trusted. Then the user is prompted to install an unknown component. This policy provides another way to trap the software before it can do damage.  
  
### Countermeasure  
Enable the **User Account Control: Detect application installations and prompt for elevation** setting.  
  
### Potential impact  
Users must provide administrative passwords to install programs.  
  

