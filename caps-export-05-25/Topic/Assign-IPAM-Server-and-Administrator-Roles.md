---
title: Assign IPAM Server and Administrator Roles
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 406b18f0-9f8c-4913-aa48-13a25bf84a8e
---
# Assign IPAM Server and Administrator Roles
Two tasks are discussed in this topic:  
  
1.  [Configuring IPAM server roles](../Topic/Assign-IPAM-Server-and-Administrator-Roles.md#server) enables you to define specific domains and servers that will be managed by an IPAM server. A single IPAM server can perform multiple management functions for multiple domains. You can also restrict an IPAM server to specific roles or limit the scope of servers to be managed.  
  
2.  [Configuring IPAM security groups](../Topic/Assign-IPAM-Server-and-Administrator-Roles.md#admins) enables you to define the set of permissions that users have when they access your IPAM server. IPAM security groups can be used to assign unique responsibilities to administrators.  
  
## <a name="server"></a>Configuring IPAM server roles  
Some reasons you might want to configure unique IPAM server roles include:  
  
1.  IPAM servers are deployed in the organization using a distributed or hybrid deployment topology.  
  
2.  Multiple IPAM servers are deployed at a single site.  
  
3.  A site managed by an IPAM server has unique requirements.  
  
4.  You are expanding your IPAM deployment.  
  
5.  You are adding new sites or domains to your organization.  
  
6.  You are configuring the scope of management for an IPAM server as part of a staged deployment.  
  
IPAM server roles can be assigned by configuring the scope of server discovery and customizing server manageability. IPAM servers can also be assigned to specific functions such as address space management, multi\-server management, or network audit by using IPAM security groups. To perform these tasks, see [Configure IPAM Server Roles](../Topic/Configure-IPAM-Server-Roles.md).  
  
## <a name="admins"></a>Configuring IPAM security groups  
It is important to define what tasks can be performed by users that have access to the IPAM server. This topic discusses two ways to configure these permissions: using local security groups and using role\-based settings.  
  
When you install IPAM Server on a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the following local role\-based IPAM security groups are created:  
  
-   IPAM Users  
  
-   IPAM MSM Administrators  
  
-   IPAM ASM Administrators  
  
-   IPAM IP Audit Administrators  
  
-   IPAM Administrators  
  
On a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you must use these local security groups to assign administrator roles on the IPAM server. For more information about these IPAM security groups, see [IPAM Server](../Topic/IPAM-Architecture.md#server). To configure these security groups, see [Assign Administrator Roles](../Topic/Assign-Administrator-Roles.md).  
  
On a computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can also use these local security groups to assign administrator roles. However, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] also includes the ability to configure new, customized security groups. For more information about this feature, see [Access Control](../Topic/Access-Control.md). To configure role\-based access settings now, see [Configure Role Based Access Control](../Topic/Configure-Role-Based-Access-Control.md).  
  
## See Also  
[What is IPAM?](../Topic/What-is-IPAM-.md)  
  
