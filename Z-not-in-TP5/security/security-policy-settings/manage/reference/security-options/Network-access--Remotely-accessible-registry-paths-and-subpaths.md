---
title: Network access: Remotely accessible registry paths and subpaths
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 944c91af-1239-4ddd-aab4-6ab025bb18d2
---
# Network access: Remotely accessible registry paths and subpaths
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which registry paths and subpaths are accessible when an application or process references the WinReg key to determine access permissions.  
  
The registry is a database for computer configuration information, much of which is sensitive. A malicious user can use it to facilitate unauthorized activities. The chance of this happening is reduced by the fact that the default ACLs that are assigned throughout the registry are fairly restrictive, and they help protect it from access by unauthorized users.  
  
To allow remote access, you must also enable the Remote Registry service.  
  
### Possible values  
  
-   User-defined list of paths  
  
-   Not Defined  
  
### Best practices  
  
1.  Set this policy to a null value; that is, enable the policy setting, but do not enter any paths in the text box. Remote management tools, such as the Microsoft Baseline Security Analyzer and Microsoft Systems Management Server (SMS), require remote access to the registry. Removing the default registry paths from the list of accessible paths might cause these and other management tools to fail.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|See the following registry key combination|  
|DC Effective Default Settings|See the following registry key combination|  
|Member Server Effective Default Settings|See the following registry key combination|  
|Client Computer Effective Default Settings|See the following registry key combination|  
  
The combination of all the following registry keys apply to the previous settings:  
  
1.  System\CurrentControlSet\Control\Print\Printers  
  
2.  System\CurrentControlSet\Services\Eventlog  
  
3.  Software\Microsoft\OLAP Server  
  
4.  Software\Microsoft\Windows NT\CurrentVersion\Print  
  
5.  Software\Microsoft\Windows NT\CurrentVersion\Windows  
  
6.  System\CurrentControlSet\Control\ContentIndex  
  
7.  System\CurrentControlSet\Control\Terminal Server  
  
8.  System\CurrentControlSet\Control\Terminal Server\UserConfig  
  
9. System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration  
  
10. Software\Microsoft\Windows NT\CurrentVersion\Perflib  
  
11. System\CurrentControlSet\Services\SysmonLog  
  
### Operating system version differences  
This security setting is not available on Windows operating systems prior to Windows Server 2008. The security setting that appears on computers running Windows XP is **Network access: Remotely accessible registry paths**, and the setting in Windows Server 2003 is  **Network access: Remotely accessible registry paths and subpaths**.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
The registry contains sensitive computer configuration information that could be used by an attacker to facilitate unauthorized activities. The fact that the default ACLs that are assigned throughout the registry are fairly restrictive and help to protect the registry from access by unauthorized users reduces the risk of such an attack.  
  
### Countermeasure  
Configure the **Network access: Remotely accessible registry paths and sub-paths** setting to a null value (enable the setting but do not enter any paths in the text box).  
  
### Potential impact  
Remote management tools such as MBSA and SMS require remote access to the registry to properly monitor and manage those computers. If you remove the default registry paths from the list of accessible ones, such remote management tools could fail.  
  
> [!NOTE]  
> If you want to allow remote access, you must also enable the Remote Registry service.  
  

