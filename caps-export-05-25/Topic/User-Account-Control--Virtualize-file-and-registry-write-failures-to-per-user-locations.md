---
title: User Account Control: Virtualize file and registry write failures to per-user locations
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 34a21aa6-3da5-4eb7-83f0-f61371158bc7
---
# User Account Control: Virtualize file and registry write failures to per-user locations
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting enables or disables the redirection of the write failures of earlier applications to defined locations in the registry and the file system. This feature mitigates applications that historically ran as administrator and wrote runtime application data to %ProgramFiles%, %Windir%, %Windir%\\system32, or HKEY\_LOCAL\_MACHINE\\Software\\.  
  
Virtualization facilitates running  applications based on operating systems earlier than [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] that historically failed to run with standard user privileges. This feature can be disabled for applications on computers running at least the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] operating system because it is unnecessary.  
  
### Possible values  
  
-   **Enabled**  
  
    Setting this value facilitates the runtime redirection of application write failures to defined user locations for the file system and the registry.  
  
-   **Disabled**  
  
    Applications that write data to protected locations fail, as they did in versions of the Windows operating system earlier than Windows Vista.  
  
### Best practices  
  
1.  If you run applications that are not Windows Vista\-compliant, enable this security policy to prevent the possibility that these older applications could write data to unsecure locations.  
  
2.  If you only run at least Windows Vista–compliant applications, this feature is unnecessary so you can disable this policy.  
  
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
There are no differences in this security policy between operating systems beginning with Windows Vista.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
This policy has no impact in Windows operating systems earlier than Windows Vista.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Earlier applications might not write data to secure locations.  
  
### Countermeasure  
Enable the **User Account Control: Virtualize file and registry write failures to per\-user locations** setting.  
  
### Potential impact  
None. This is the default configuration.  
  
