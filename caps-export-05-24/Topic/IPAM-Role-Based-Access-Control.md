---
title: IPAM Role Based Access Control
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64a64cb8-2f51-44b2-8ad2-589127463cbf
---
# IPAM Role Based Access Control
This topic provides a summary of role based access control for IP Address Management \(IPAM\), a new feature available in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)].  
  
For examples and information about how role based access control works, see [Walkthrough: Demonstrate IPAM in Windows Server 2012 R2](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md).  
  
## <a name="RBAC"></a>Role based access control  
Role based access control provides you with the ability to customize roles, access scopes, and access policies. Thus, you have the ability to define and establish fine\-grained control for users and groups, enabling them to perform a specific set of administrative operations on specific objects managed by IPAM.  
  
**Roles**: A role is a collection of IPAM operations. You can associate a role with a user or group in Windows using an access policy. Eight built\-in administrator roles are provided for convenience, but you can also create customized roles to meet your business requirements.  
  
**Access scopes**: An access scope determines the objects that a user has access to. You can use access scopes to define administrative domains in IPAM. For example, you might create access scopes based on geographical location. By default, IPAM includes an access scope of Global. All other access scopes are subsets of the Global access scope. Users or groups that are assigned to the Global access scope have access to all objects in IPAM that are permitted by their assigned role.  
  
**Access Policies**: An access policy combines a role with an access scope to assign permission to a user or group. For example, you might define an access policy for a user with a role of IP Block Admin and an access scope of Global\\Asia. Therefore, this user will have permission to edit and delete IP address blocks that are associated to the Asia access scope. This user will not have permission to edit or delete any other IP address blocks in IPAM.  
  
The following default access scope and roles are provided:  
  
|Type|Name|Description|  
|--------|--------|---------------|  
|Role|DNS record administrator|Manages DNS resource records|  
|Role|IP address record administrator|Manages IP addresses but not IP address spaces, ranges, blocks, or subnets.|  
|Role|IPAM administrator|Manages all settings and objects in IPAM|  
|Role|IPAM ASM administrator|Completely manages IP addresses|  
|Role|IPAM DHCP administrator|Completely manages DHCP servers|  
|Role|IPAM DHCP reservations administrator|Manages DHCP reservations|  
|Role|IPAM DHCP scope administrator|Manages DHCP scopes|  
|Role|IPAM MSM administrator|Completely manages DHCP and DNS servers|  
|Access scope|Global|By default, all objects in IPAM are included in the global access scope. All additional scopes that are configured are subsets of the global access scope.|  
  
## See also  
[IP Address Management \(IPAM\) Overview](../Topic/IP-Address-Management--IPAM--Overview.md)  
  
