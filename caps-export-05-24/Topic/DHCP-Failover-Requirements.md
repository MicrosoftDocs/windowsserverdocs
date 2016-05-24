---
title: DHCP Failover Requirements
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b31bd93f-d926-4e57-880c-90823ce7bc41
---
# DHCP Failover Requirements
Requirements to deploy DHCP failover are the following:  
  
|Item|Requirement|Details|  
|--------|---------------|-----------|  
|**Operating system**|[!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], or a later operating system is required.|Both DHCP servers in a DHCP failover relationship must be running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or a later operating system. Servers do not need to both be running the same operating system, but this is recommended to ensure consistent replication of settings.|  
|**Role services**|The DHCP Server role service is required.|Both computers participating in a DHCP failover relationship must have the DHCP Server role installed and running. The DHCP Server service can be paused, but must not be stopped.<br /><br />Additional roles, role services, and features are optional.|  
|**Network**|DHCP servers can be on the same network or on different networks. The network connection between DHCP failover partners must be uninterrupted.<br /><br />Both DHCP servers must be able to communicate with each other, and with all DHCP clients that will receive DHCP leases from failover\-enabled scopes.<br /><br />Both servers must also be time synchronized to within one minute of each other.|DHCP servers can communicate with each other directly, or through IP routing.<br /><br />DHCP servers can communicate with DHCP clients either directly or using DHCP relay.<br /><br />For more information about configuring DHCP relay agents for a DHCP failover deployment, see [DHCP Failover Architecture](../Topic/DHCP-Failover-Architecture.md).|  
|**IP addresses**|DHCP servers should be configured with static IP addresses.|To ensure a persistent TCP connection between DHCP failover partners is maintained, it is important to use a static IP address on all DHCP server network interfaces.<br /><br />If the static IP address of a DHCP server needs to be changed, for example during DHCP migration, you must first delete all DHCP failover relationships that exist on that server, and then recreate the relationships when the new IP address is active.<br /><br />For more information about communication between DHCP failover partners, see [DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md).|  
|**DHCP scopes**|At least one IPv4 DHCP scope must be configured on the primary DHCP server.<br /><br />The same DHCP scope ID, or an overlapping scope, must not be configured on the failover partner.|Other DHCP scopes that are not overlapping can be configured on the failover partner, but are not required. Scopes that are not configured for DHCP failover are not affected.<br /><br />The DHCP scope does not need to be active. An inactive DHCP scope that is replicated to a DHCP failover partner server will also be inactive on the failover partner.<br /><br />You cannot configure DHCP failover using two DHCP servers that are already configured for a split\-scope DHCP deployment because the same DHCP scope ID is present on both servers. Initial replication of a DHCP scope to the failover partner will fail if the scope ID already exists on the destination server.|  
|**Domain membership**|Not required.|DHCP servers can be workgroup computers or domain member computers. However, workgroup computers cannot be authorized in Active Directory. For more information, see [Authorizing DHCP servers](http://technet.microsoft.com/library/cc781697.aspx).|  
  
## Prerequisite checks  
The following prerequisite checks are made before enabling DHCP failover:  
  
|Check performed|Error message displayed|  
|-------------------|---------------------------|  
|DNS name resolution for the failover partner server|Unable to resolve the specified DNS name.|  
|Valid IP address specified for the failover partner server|The specified IP address <x.x.x.x> is invalid.|  
|The server has a network connection to the failover partner server|The specified DHCP server is not reachable. Please provide a DHCP server that is reachable.|  
|The operating system on the failover partner server|The version of specified DHCP server does not support failover.|  
|The user is a member of the DHCP Administrators group, or equivalent, on the failover partner server|You do not have permissions to perform this operation on the remote DHCP server.|  
|The maximum number of failover relationships for either DHCP server|The local\/partner server already has 31 \(maximum allowed\) failover relationships. A server cannot have more than 31 failover relationships.|  
|The DHCP Server service is running on the failover partner server|DHCP server is not running on the specified server. Please ensure that DHCP server is running on the specified server.|  
|Time is synchronized between both servers|The time difference between this server and the specified partner server is greater than the permissible value of x minutes. It is recommended to ensure that both servers are time synchronized before configuring failover. You could setup Network Time Protocol \(NTP\) service on both servers to ensure time synchronization. **Tip:** A maximum permissible time difference can be configured in the Windows Registry. The registry value will be read from both the servers and the minimum of the values is used to perform this check. If registry value has not been configured, the default value is used.|  
|Are scopes already present on the failover partner server|Following scopes already exist on the specified partner server. These scope\(s\) will need to be deleted on the partner server before configuring failover.|  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[DHCP Failover Architecture](../Topic/DHCP-Failover-Architecture.md)  
  
[Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md)  
  
