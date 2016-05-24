---
title: IPAM Terminology
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 97b74261-ba98-4d4a-825b-1c80b5c5db97
---
# IPAM Terminology
Several new concepts and terms are used to describe IPAM. The following table displays a list of IPAM\-related terms used in this guide.  
  
|Term|Definition|  
|--------|--------------|  
|ASM|Address space management \(ASM\) in IPAM provides the ability to efficiently view, monitor, and manage IP address space on the network. The ASM feature supports IPv4 public and private address space, and IPv6 address space. You can manage dynamic IP addresses and static IP addresses on the network using IPAM ASM.|  
|IP Address Block|An IP address block is the largest unit used for address space management. IPAM automatically labels IPv4 address blocks that you create as belonging to public or private address space as defined by the IANA. IP address blocks are comprised of smaller units called IP address ranges.|  
|IP Address Inventory|IP Address Inventory is a node in the IPAM console that displays a built\-in IP address range group \(logical group\) that is organized by the device type field of IP addresses.|  
|IP Address Range|An IP address range is typically a DHCP scope or static IP address pool used to assign IP addresses to hosts. IP address ranges in IPAM are assigned to parent IP address blocks. IP address ranges do not contain other IP address ranges, but are comprised of individual IP addresses.|  
|IP Address Range Groups|IP address range groups are one or more IP address ranges that are grouped together based on built\-in or user\-defined custom fields.|  
|IPAM Administrators|IPAM Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have privileges to view all IPAM data and perform all IPAM tasks.|  
|IPAM ASM Administrators|IPAM ASM Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have all the privileges of the IPAM Users security group, and can perform IP address space tasks in addition to IPAM common management tasks.|  
|IPAM IP Audit Administrators|IPAM IP Audit Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have all the privileges of the IPAM Users security group. They can view IP address tracking data and perform IPAM common management tasks.|  
|IPAM MSM Administrators|IPAM MSM Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have all the privileges of the IPAM Users security group, and can perform server monitoring and management tasks in addition to IPAM common management tasks.|  
|IPAM Users|IPAM Users is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have read\-only access and cannot launch IPAM scheduled tasks. They can view all information in server inventory, IP address space, and the monitor and manage IPAM console nodes. IPAM Users can view IPAM and DHCP operational events under in the Event Catalog node, but cannot view IP address tracking data.|  
|Managed By Service|Managed By Service is a built\-in mandatory field for IP addresses and ranges that identifies the service that provides IP addresses in this range. An example value is **MS DHCP**, indicating that the IP address or range is supplied by a Microsoft Windows DHCP server.|  
|Managed Server|Managed servers are listed in the server inventory node of the IPAM console with a status of Managed. Domain controllers, DNS servers, DHCP servers, and network policy servers can be managed servers. The IPAM server must have access rights enabled on a managed server to perform management and monitoring actions. These access rights are enabled during the IPAM provisioning process.|  
|MSM|Multi\-server management \(MSM\) in IPAM provides periodic service monitoring and configuration of managed DHCP and DNS servers using the IPAM console.|  
|Provisioning method|Provisioning method refers to the processes used to enable IPAM server access to managed servers. Available provisioning methods are: manual and automatic. The manual method requires that group memberships, file shares, service access settings, and firewall ports be configured manually on each managed server. The automatic provisioning method uses Group Policy Objects to configure these access settings automatically when a server is marked as managed in the server inventory view. IPAM provides a wizard that enables you to choose the provisioning method during the initial setup of the IPAM server. The provisioning method cannot be changed after you complete the wizard.|  
|Service Instance|Service instance is a built\-in mandatory field for IP addresses and ranges that identifies the device that provides IP addresses in this range. The service instance for a Microsoft Windows DHCP server is the fully qualified domain name of the server \(ex: dhcp.contoso.com\).|  
|Server Groups|Server groups are logical groups used to organize managed DHCP and DNS servers. Servers are members of a server group based on values of custom fields that are assigned to the server.|  
|Unmanaged server|Unmanaged servers are listed in the server inventory node of the IPAM console with a status of Unmanaged. The IPAM server typically does not have access rights enabled to perform management and monitoring of unmanaged servers.|  
|Unmapped Address Space|Unmapped address space is an IP address range or individual IP address that does not map to a parent IP address block. To automatically map a child IP address range to a parent IP address block, add the parent block to the IPAM console.|  
  
## See also  
[What is IPAM?](../Topic/What-is-IPAM-.md)  
  
[Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md)  
  
[IPAM Architecture](../Topic/IPAM-Architecture.md)  
  
[IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md)  
  
