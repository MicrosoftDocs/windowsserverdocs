---
title: NIC Teaming settings
description:  In this topic, we give you an overview of the NIC Team properties such as teaming and load balancing modes. We also give you details about the Standby adapter setting and the Primary team interface property. If you have at least two network adapters in a NIC Team, you do not need to designate a Standby adapter for fault tolerance.
manager: dougkim
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-nict
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4caaa86-5799-4580-8775-03ee213784a3
ms.author: lizross
author: eross-msft
ms.date: 09/13/2018
---


# NIC Teaming settings
In this topic, we give you an overview of the NIC Team properties such as teaming and load balancing modes. We also give you details about the Standby adapter setting and the Primary team interface property. If you have at least two network adapters in a NIC Team, you do not need to designate a Standby adapter for fault tolerance.


  
![NIC Team properties](../../media/Create-a-New-NIC-Team-on-a-Host-Computer-or-VM/nict_06_properties.jpg)  

## Teaming modes 
The options for Teaming mode are **Switch Independent** and **Switch Dependent**. The Switch Dependent mode includes **Static Teaming** and **Link Aggregation Control Protocol (LACP)**. 

>[!TIP]
>For best NIC Team performance, we recommend that you use a Load Balancing mode of Dynamic distribution.  
  
### Switch Independent
  
[!INCLUDE [switch-independent-shortdesc-include](../../includes/switch-independent-shortdesc-include.md)] 
  
When you use Switch Independent mode with Dynamic distribution, the network traffic load is distributed based on the TCP Ports address hash as modified by the Dynamic load balancing algorithm. The Dynamic load balancing algorithm redistributes flows to optimize team member bandwidth utilization so that individual flow transmissions can move from one active team member to another. The algorithm takes into account the small possibility that redistributing traffic could cause out-of-order delivery of packets, so it takes steps to minimize that possibility.  
  
### Switch Dependent  

[!INCLUDE [switch-dependent-shortdesc-include](../../includes/switch-dependent-shortdesc-include.md)]  
  
> [!IMPORTANT]  
> Switch dependent teaming requires that all team members are connected to the same physical switch or a multi-chassis switch that shares a switch ID among the multiple chassis.


- **Static Teaming.** Static Teaming requires you to manually configure both the switch and the host to identify which links form the team. Because this is a statically configured solution, there is no additional protocol to assist the switch and the host to identify incorrectly plugged cables or other errors that could cause the team to fail to perform. This mode is typically supported by server-class switches.

- **Link Aggregation Control Protocol (LACP).** Unlike Static Teaming, LACP Teaming mode dynamically identifies links that are connected between the host and the switch. This dynamic connection enables the automatic creation of a team and, in theory but rarely in practice, the expansion and reduction of a team simply by the transmission or receipt of LACP packets from the peer entity. All server-class switches support LACP, and all require the network operator to administratively enable LACP on the switch port. When you configure a Teaming mode of LACP, NIC Teaming always operates in LACP's Active mode with a short timer.  No option is presently available to modify the timer or change the LACP mode.


When you use Switch Dependent modes with Dynamic distribution, the network traffic load is distributed based on the TransportPorts address hash as modified by the Dynamic load balancing algorithm.  The Dynamic load balancing algorithm redistributes flows to optimize team member bandwidth utilization. Individual flow transmissions can move from one active team member to another as part of the dynamic distribution. The algorithm takes into account the small possibility that redistributing traffic could cause out-of-order delivery of packets, so it takes steps to minimize that possibility.  
  
As with all switch dependent configurations, the switch determines how to distribute the inbound traffic among the team members.  The switch is expected to do a reasonable job of distributing the traffic across the team members but it has complete independence to determine how it does so.  


## Load Balancing modes  
The options for Load Balancing distribution mode are **Address Hash**, **Hyper-V Port**, and **Dynamic**.  
  
### Address Hash
  
[!INCLUDE [address-hash-shortdesc-include](../../includes/address-hash-shortdesc-include.md)]
  
Use Windows PowerShell to specify values for the following hashing function components.  
  
-   Source and destination TCP ports and source and destination IP addresses. This is the default when you select **Address Hash** as the Load Balancing mode.  
  
-   Source and destination IP addresses only.  
  
-   Source and destination MAC addresses only.  
  
The TCP ports hash creates the most granular distribution of traffic streams, resulting in smaller streams that can be independently moved between NIC team members. However, you cannot use the TCP ports hash for traffic that is not TCP or UDP-based, or where the TCP and UDP ports are hidden from the stack, such as with IPsec-protected traffic. In these cases, the hash automatically uses the IP address hash or, if the traffic is not IP traffic, the MAC address hash is used.  
  
### Hyper-V Port
  
[!INCLUDE [hyper-v-port-shortdesc-include](../../includes/hyper-v-port-shortdesc-include.md)]  
  
Because the adjacent switch always sees a particular MAC address on one port, the switch distributes the ingress load (the traffic from the switch to the host) on multiple links based on the destination MAC (VM MAC) address. This is particularly useful when Virtual Machine Queues (VMQs) are used, because a queue can be placed on the specific NIC where the traffic is expected to arrive.  
  
However, if the host has only a few VMs, this mode might not be granular enough to achieve a well-balanced distribution. This mode will also always limit a single VM (i.e., the traffic from a single switch port) to the bandwidth that is available on a single interface. NIC Teaming uses the Hyper-V Virtual Switch Port as the identifier instead of using the source MAC address because, in some instances, a VM might be configured with more than one MAC address on a switch port.  
  
### Dynamic
  
[!INCLUDE [dynamic-shortdesc-include](../../includes/dynamic-shortdesc-include.md)]
  
The outbound loads in this mode are dynamically balanced based on the concept of flowlets. Just as human speech has natural breaks at the ends of words and sentences, TCP flows (TCP communication streams) also have naturally occurring breaks. The portion of a TCP flow between two such breaks is referred to as a flowlet.  
  
When the dynamic mode algorithm detects that a flowlet boundary has been encountered - such as when a break of sufficient length has occurred in the TCP flow - the algorithm automatically rebalances the flow to another team member if appropriate.  In some circumstances the algorithm might also periodically rebalance flows that do not contain any flowlets. Because of this, the affinity between TCP flow and team member can change at any time as the dynamic balancing algorithm works to balance the workload of the team members.  
  
Whether the team is configured with Switch Independent or one of the Switch Dependent modes, it is recommended that you use Dynamic distribution mode for best performance.  
  
There is an exception to this rule when the NIC Team has just two team members, is configured in Switch Independent mode, and has Active/Standby mode enabled, with one NIC active and the other configured for Standby. With this NIC Team configuration, Address Hash distribution provides slightly better performance than Dynamic distribution.  


## Standby adapter setting  
The options for Standby Adapter are **None (all adapters Active)** or your selection of a specific network adapter in the NIC Team that acts as a Standby adapter. When you configure a NIC as a Standby adapter, all other unselected team members are Active, and no network traffic is sent to or processed by the adapter until an Active NIC fails. After an Active NIC fails, the Standby NIC becomes active and processes network traffic. When all team members get restored to service, the standby team member returns to standby status.  

If you have a two-NIC team and you choose to configure one NIC as a Standby adapter, you lose the bandwidth aggregation advantages that exist with two active NICs.  You do not need to designate a Standby Adapter to achieve fault tolerance; fault tolerance is always present whenever there are at least two network adapters in a NIC Team.
 
  
## Primary Team interface property  
To access the Primary Team Interface dialog box, you must click the link that is highlighted in the illustration below.  
  
![Primary Team Interface Property](../../media/Create-a-New-NIC-Team-on-a-Host-Computer-or-VM/nict_10_primaryteaminterface.jpg)  
  
After you click the highlighted link, the following **New Team Interface** dialog box opens.  
  
![New Team Interface dialog box](../../media/Create-a-New-NIC-Team-on-a-Host-Computer-or-VM/nict_newteaminterface.jpg)  
  
If you are using VLANs, you can use this dialog box to specify a VLAN number.  
  
Whether or  not you are using VLANs, you can specify a tNIC name for the NIC Team.  
  


---