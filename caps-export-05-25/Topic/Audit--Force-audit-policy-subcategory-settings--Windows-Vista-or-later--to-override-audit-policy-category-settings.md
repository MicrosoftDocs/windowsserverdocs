---
title: Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a6c0011f-1ba6-4c94-b012-7577fd2b3379
---
# Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
The applicable Windows operating systems allow audit policy to be managed in a more precise way by using audit policy subcategories.  
  
There are over 40 auditing subcategories that provide precise details about activities on a computer. For information about these subcategories, see the [Advanced Security Audit Policy Settings \[Auditing\_Events\]](assetId:///825f16f4-80bf-4f23-98ef-f967cca25546).  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
### Best practices  
  
1.  Leave the setting enabled. This provides the ability to audit events at the category level without revising a policy.  
  
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
There are no differences in this policy for operating systems beginning with Windows Vista and Windows Server 2008.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], all auditing capabilities are integrated in Group Policy. This allows administrators to configure, deploy, and manage these settings in the Group Policy Management Console \(GPMC\) or Local Security Policy snap\-in for a domain, site, or organizational unit \(OU\).  
  
### Auditing  
To manage an audit policy by using subcategories without requiring a change to Group Policy, the SCENoApplyLegacyAuditPolicy registry value ,  prevents the application of category\-level audit policy from Group Policy and from the Local Security Policy administrative tool. This registry value is available in [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)].  
  
If the category level audit policy that is set here is not consistent with the events that are currently being generated, the cause might be that this registry key is set.  
  
### Command\-line tools  
For information about displaying and manipulating audit policies from the command line, see [Auditpol \[Vista\]](../Topic/Auditpol.md).  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Prior to the introduction of auditing subcategories in [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], it was difficult to track events at a per\-system or per\-user level. The larger event categories created too many events, and the key information that needed to be audited was difficult to find.  
  
### Countermeasure  
Enable audit policy subcategories as needed to track specific events.  
  
### Potential impacts  
The individual audit policy subcategories available in [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] are not exposed in the interface of Group Policy tools. Administrators can deploy a custom audit policy that applies detailed security audit settings to [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]–based or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] computers in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003, or Windows 2000 domain. But the advanced security audit policies are available in the interface of Group Policy in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
If you attempt to modify an audit setting by using Group Policy after enabling this setting through the command\-line tools, the Group Policy audit setting is ignored in favor of the custom policy setting. To modify audit settings by using Group Policy, you must first disable the **SCENoApplyLegacyAuditPolicy** key.  
  
> [!IMPORTANT]  
> Be very cautious about audit settings that can generate a large volume of traffic. For example, if you enable success or failure auditing for all of the Privilege Use subcategories, the high volume of audit events that are generated can make it difficult to find other types of entries in the Security log. Such a configuration could also have a significant impact on system performance.  
  
