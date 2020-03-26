---
title: Configure Quality of Service (QoS) for a tenant VM network adapter
description: When you configure QoS for a tenant VM network adapter, you have a choice between Data Center Bridging \(DCB\)or Software Defined Networking \(SDN\) QoS.
manager: dougkim
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6d783ff6-7dd5-496c-9ed9-5c36612c6859
ms.author: lizross
author: eross-msft
ms.date: 08/23/2018
---
# Configure Quality of Service (QoS) for a tenant VM network adapter

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

When you configure QoS for a tenant VM network adapter, you have a choice between Data Center Bridging \(DCB\)or Software Defined Networking \(SDN\) QoS.

1.	**DCB**. You can configure DCB by using the Windows PowerShell NetQoS cmdlets. For an example, see the section “Enable Data Center Bridging”  in the topic [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](../../../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).

2.	**SDN QoS**. You can enable SDN QoS by using Network Controller, which can be set to limit bandwidth on a virtual interface to prevent a high-traffic VM from blocking other users.  You can also configure SDN QoS to reserve a specific amount of bandwidth for a VM to ensure that the VM is accessible regardless of the amount of network traffic.  

Apply all SDN QoS settings through the Port settings of the Network Interface properties. Refer to the table below for more details.

|Element name|Description|
|------------|-----------| 
|macSpoofing| Allows VMs to change the source media access control \(MAC\) address in outgoing packets to a MAC address not assigned to the VM.<p>Allowed values:<ul><li>Enabled – Use a different MAC address.</li><li>Disabled – Use only the MAC address assigned to it.</li></ul>|
|arpGuard| Allows ARP guard only addresses specified in ArpFilter to pass through the port.<p>Allowed values:<ul><li>Enabled - Allowed</li><li>Disabled – Not allowed</li></ul>|
|dhcpGuard| Allows or drops any DHCP messages from a VM that claims to be a DHCP server. <p>Allowed values:<ul><li>Enabled – Drops DHCP messages because the virtualized DHCP server is considered untrusted.</li><li>Disabled – Allows the message to be received because the virtualized DHCP server is considered trustworthy.</li></ul>|
|stormLimit| The number of packets (broadcast, multicast, and unknown unicast) per second a VM is allowed to send through the virtual network adapter. Packets beyond the limit during that one-second interval get dropped. A value of zero \(0\) means there is no limit..|
|portFlowLimit| The maximum number of flows allowed to execute for the port. A value of blank or zero \(0\) means there is no limit. |
|vmqWeight| The relative weight describes the affinity of the virtual network adapter to use virtual machine queue (VMQ). The range of value is 0 through 100.<p>Allowed values:<ul><li>0 – Disables the VMQ on the virtual network adapter.</li><li>1-100 – Enables the VMQ on the virtual network adapter.</li></ul>|
|iovWeight| The relative weight sets the affinity of the virtual network adapter to the assigned single-root I/O virtualization \(SR-IOV\) virtual function. <p>Allowed values:<ul><li>0 – Disables SR-IOV on the virtual network adapter.</li><li>1-100 – Enables SR-IOV on the virtual network adapter.</li></ul>|
|iovInterruptModeration|<p>Allowed values:<ul><li>default – The physical network adapter vendor's setting determines the value.</li><li>adaptive - </li><li>off </li><li>low</li><li>medium</li><li>high</li></ul><p>If you choose **default**, the physical network adapter vendor's setting determines the value.  If you choose, **adaptive**, the runtime traffic pattern determins the interrupt moderation rate.|
|iovQueuePairsRequested| The number of hardware queue pairs allocated to an SR-IOV virtual function. If receive-side scaling \(RSS\) is required, and if the physical network adapter that binds to the virtual switch supports RSS on SR-IOV virtual functions, then more than one queue pair is required. <p>Allowed values: 1 to 4294967295.|
|QosSettings| Configure the following Qos settings,all of which are optional: <ul><li>**outboundReservedValue** - If outboundReservedMode is "absolute" then the value indicates the bandwidth, in Mbps, guaranteed to the virtual port for transmission (egress). If outboundReservedMode is "weight" then the value indicates the weighted portion of the bandwidth guaranteed.</li><li>**outboundMaximumMbps** - Indicates the maximum permitted send-side bandwidth, in Mbps, for the virtual port (egress).</li><li>**InboundMaximumMbps** - Indicates the maximum permitted receive-side bandwidth for the virtual port (ingress) in Mbps.</li></ul> |

---