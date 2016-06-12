---
title: Network access: Remotely accessible registry paths
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 24d84fa4-f8b6-4e34-afef-1e78eed04257
---
# Network access: Remotely accessible registry paths
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which registry paths are accessible when an application or process references the WinReg key to determine access permissions.  
  
The registry is a database for computer configuration information, much of which is sensitive. A malicious user can use the registry to facilitate unauthorized activities. To reduce the risk of this happening, suitable access control lists \(ACLs\) are assigned throughout the registry to help protect it from access by unauthorized users.  
  
To allow remote access, you must also enable the Remote Registry service.  
  
### Possible values  
  
-   User\-defined list of paths  
  
-   Not Defined  
  
### Best practices  
  
1.  Set this policy to a null value; that is, enable the policy setting but do not enter any paths in the text box. Remote management tools, such as the Microsoft Baseline Security Analyzer and Microsoft Systems Management Server \(SMS\), require remote access to the registry. Removing the default registry paths from the list of accessible paths might cause these and other management tools to fail.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|See the following registry key combination|  
|DC Effective Default Settings|See the following registry key combination|  
|Member Server Effective Default Settings|See the following registry key combination|  
|Client Computer Effective Default Settings|See the following registry key combination|  
  
The combination of all the following registry keys apply to the previous settings:  
  
1.  System\\CurrentControlSet\\Control\\ProductOptions  
  
2.  System\\CurrentControlSet\\Control\\Server Applications  
  
3.  Software\\Microsoft\\Windows NT\\CurrentVersion  
  
### Operating system version differences  
This security setting is not available on Windows operating systems prior to Windows Server 2008. The security setting that appears on computers running Windows XP is **Network access: Remotely accessible registry paths**, and the setting in Windows Server 2003 is  **Network access: Remotely accessible registry paths and subpaths**. For more information, see [Network access: Remotely accessible registry paths and subpaths](network-access-remotely-accessible-registry-paths-subpaths.md).  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
An attacker could use information in the registry to facilitate unauthorized activities. To reduce the risk of such an attack, suitable ACLs are assigned throughout the registry to help protect it from access by unauthorized users.  
  
### Countermeasure  
Configure the **Network access: Remotely accessible registry paths** setting to a null value \(enable the setting, but do not enter any paths in the text box\).  
  
### Potential impact  
Remote management tools such as the Microsoft Baseline Security Analyzer \(MBSA\) and Microsoft Systems Management Server \(SMS\) require remote access to the registry to properly monitor and manage those computers. If you remove the default registry paths from the list of accessible ones, such remote management tools could fail.  
  
> [!NOTE]  
> If you want to allow remote access, you must also enable the Remote Registry service.  
  

