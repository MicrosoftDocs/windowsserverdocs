---
title: DHCP Failover Architecture
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a31e286-cbc8-4efa-9754-fe12a0772384
---
# DHCP Failover Architecture
See the following sections in this topic:  
  
1.  [DHCP failover design](../Topic/DHCP-Failover-Architecture.md#design)  
  
2.  [Deployment considerations](../Topic/DHCP-Failover-Architecture.md#considerations)  
  
## <a name="design"></a>DHCP failover design  
DHCP failover can be deployed using either hot standby mode or load sharing mode. You can also use both modes on the same DHCP server if you configure multiple failover relationships. For details about hot standby and load sharing modes, see [DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md).  
  
You can customize your deployment based on the physical architecture of your network. See the following sections for more information.  
  
### Hot standby design  
The hot standby mode of operation is best suited to deployments where a central office or data center server acts as a standby backup server to a server at a remote site, which is local to the DHCP clients \(ex: hub and spoke deployment\). In such deployments, it is undesirable to have a remote standby server service any clients unless the local DHCP server becomes unavailable. The following figure is an example of a hub and spoke deployment.  
  
![](../Image/DHCP-HA_hot-standby.gif)  
  
In this example, four remote sites each have a primary \(active\) DHCP server on\-site with the standby server located remotely at a central site. The standby server at the central site might also be an active DHCP server for a subnet at the central site, or its only function can be as a standby server for the sites 1\-4. Client leases for all four sites can be viewed on the central DHCP server, even if it is not actively providing these leases.  
  
### Load balance design  
The load balance mode of operation is best suited to deployments where both servers in a failover relationship are located at the same physical site. Both servers respond to DHCP client requests based on the load distribution ratio configured by the administrator.  
  
Load balancing can be used with a single subnet, or multiple subnets. See the following examples.  
  
#### Load balance in a single site with a single subnet  
In the following example, two DHCP servers simultaneously provide IP addressing to clients on a single subnet.  
  
![](../Image/DHCP-HA_load-sharing-single.gif)  
  
#### Load balance in a single site with multiple subnets  
In the following example, two DHCP servers simultaneously provide IP addressing to clients on multiple subnets.  
  
![](../Image/DHCP-HA_load-sharing-multiple.gif)  
  
As previously noted, a load balance design also provides redundancy. If one of the servers in the previous examples becomes unavailable, the other DHCP server will assume responsibility for client leases.  
  
For more information about redundancy in hot standby and load balancing modes, see [DHCP Failover Examples](../Topic/DHCP-Failover-Examples.md).  
  
## <a name="considerations"></a>Deployment considerations  
Before you deploy DHCP failover, consider the following:  
  
### Time synchronization  
For DHCP failover to function correctly, time must be kept synchronized between the two servers in a failover relationship. Time synchronization can be maintained by deployment of the Network Time Protocol \(NTP\) or any other alternative mechanism. When the failover configuration wizard is run, it will compare the current time on the servers being configured for failover. If the time difference between the servers is greater than one minute, the failover setup process will halt with a critical error and request that time on the servers be synchronized.  
  
Each failover protocol message includes a time field that is populated with the Coordinated Universal Time \(UTC\) when the source server transmitted the message. For each message, the receiving server will perform a check of the time difference between the time stamp field in the packet and the time at the receiving server. If this time difference is found to be greater than one minute, the receiving server will log a critical event indicating that the two servers are not time synchronized.  
  
A binding is a collection of configuration parameters managed by DHCP servers, including at least an IP address, associated with or "bound to" a DHCP client. A binding update transaction refers to the set of information \(contained in options\), necessary to perform an update for a single IP address. Any change in state of an IP address lease \(e.g. a new lease, renew, expiry, release\) leads to a binding update message from the server on which the state change happened to a partner server. Any binding update message received by the server while time is out of synchronization is rejected with an error code. Determination of a time out\-of\-synch condition will not cause any change in the failover state of the server. Both servers will continue to operate in the same state as before determination of a time out\-of\-synch condition.  
  
### BOOTP support  
DHCP failover is not supported for BOOTP in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Support for BOOTP clients is provided in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
### Policy based assignment  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes a new policy based IP address assignment feature, which allows a Windows DHCP administrator to group the DHCP clients by a specific attribute of the client, such as vendor class, user class, client identifier, or MAC address. By grouping the clients based on these attributes, an administrator is able to assign parameters such as IP address, default gateway, DNS server and other DHCP options to a specific grouping of clients. This allows the administrator to exercise greater control on the configuration parameters delivered to end hosts. This feature introduces the concept of multiple IP address ranges within a single scope. To accommodate this, DHCP failover address distribution in load sharing mode is done on a per IP address range basis.  
  
### Windows Firewall  
DHCP failover uses TCP port 647 to listen for failover messages between two failover partner servers. For this traffic to be allowed by the Windows firewall, the following inbound and outbound firewall rules are added then you install the DHCP Server role:  
  
-   Microsoft\-Windows\-DHCP\-Failover\-TCP\-In  
  
-   Microsoft\-Windows\-DHCP\-Failover\-TCP\-Out  
  
### Relay agents  
Initial DHCPDISCOVER messages are broadcast by DHCP clients on the subnet to which they belong. Since routers typically do not forward broadcast traffic, a mechanism is required to enable DHCP clients to communicate with DHCP servers if the DHCP server is not located on the same subnet. Relay agents \(typically provided on a router\) are designed to perform this function, relaying DHCP and BOOTP messages between clients and servers on different subnets. Relay agents are commonly configured with on a network device, or you can configure DHCP relay on a Windows Server with the Remote Access role installed. See [Configure the DHCP Relay Agent](http://technet.microsoft.com/library/cc781416.aspx) for more information.  
  
If your DHCP relay is configured on a network device, consult your vendor’s documentation for details. The **helper\-address** command is commonly used to configure DHCP relay on a network device, for example:  
  
```  
ip helper-address 10.0.1.1  
```  
  
When you deploy DHCP failover, a single DHCP relay address might not be sufficient, since DHCP clients must always be able to communicate with both the primary DHCP server and the failover partner server. If both DHCP servers are located on a different subnet than DHCP clients, this requires at least two DHCP relay agents. For example:  
  
```  
ip helper-address 10.0.1.1  
ip helper-address 10.0.1.2  
```  
  
In this example, both DHCP servers are on the same subnet \(10.0.1.0\/24\). The primary DHCP server’s IP address is 10.0.1.1 and 10.0.1.2 is the IP address for the failover partner server. If both DHCP servers are located on the same subnet, you can also configure the subnet broadcast address \(ex: 10.0.1.255\) as a single DHCP relay. The use of a subnet broadcast address as a single DHCP relay is not possible if DHCP servers are located on separate subnets.  
  
#### Duplicate relay agents  
Virtual Router Redundancy Protocol \(VRRP\) is another failover protocol used to enable redundancy on network devices. An example of VRRP includes Hot Standby Router Protocol \(HSRP\), which is a Cisco proprietary VRRP. If VRRP\/HSRP is configured on a network device that is also configured with one or more DHCP relays, this can cause duplicate DHCP relay messages to be sent to the same DHCP failover server.  
  
If a single DHCP server configured for DHCP failover receives duplicate lease requests, this can cause inconsistent client lease durations, and clients might lease IP addresses that belong to other clients. Consult your vendor documentation to determine if the router redundancy protocol requires a specific configuration to support DHCP relay. For example, Cisco provides DHCP relay support for the HSRP protocol using virtual router groups.  
  
An update is also available from Microsoft to resolve this issue. See [Microsoft Knowledge Base article 2831920](http://support.microsoft.com/kb/2831920) and [Microsoft update 2845533](http://support.microsoft.com/kb/2845533) for more information.  
  
### See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[DHCP Failover Requirements](../Topic/DHCP-Failover-Requirements.md)  
  
[Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md)  
  
