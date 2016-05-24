---
title: Devices: Allowed to format and eject removable media
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 09f48b14-b89a-4983-9fe3-0dad797a46bc
---
# Devices: Allowed to format and eject removable media
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines who is allowed to format and eject removable media.  
  
Users can move removable disks to a different computer where they have administrative user rights and then take ownership of any file, assign themselves full control, and view or modify any file. The advantage of configuring this policy setting is diminished by the fact that most removable storage devices will eject media with the press of a button.  
  
### Possible values  
  
-   Administrators  
  
-   Administrators and Power Users  
  
-   Administrators and Interactive Users \(not applicable to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]\)  
  
-   Not defined  
  
### Best practices  
  
1.  It is advisable to set **Allowed to format and eject removable media** to **Administrators**. Only administrators will be able to eject NTFS\-formatted removable media.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|Administrators|  
|DC Effective Default Settings|Administrators|  
|Member Server Effective Default Settings|Administrators|  
|Client Computer Effective Default Settings|Not defined|  
  
### Operating system version differences  
The option Administrators and Interactive Users is not applicable to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], but it can be used for backward compatibility.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Users could move data on removable disks to a different computer where they have administrative privileges. The user could then take ownership of any file, grant themselves full control, and view or modify any file. The fact that most removable storage devices eject media when a mechanical button is pressed diminishes the advantage of this policy setting.  
  
### Countermeasure  
Configure the **Devices: Allowed to format and eject removable media** setting to **Administrators**.  
  
### Potential impact  
Only administrators can format and eject removable media. If users are in the habit of using removable media for file transfers and storage, they must be informed of the change in policy.  
  
