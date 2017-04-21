---
title: Configure Quality of Service (QoS) for a Tenant VM Network Adapter
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6d783ff6-7dd5-496c-9ed9-5c36612c6859
ms.author: jamesmci
author: jamesmci
---
# Configure Quality of Service (QoS) for a Tenant VM Network Adapter

>Applies To: Windows Server 2016

When you configure QoS for a tenant VM network adapter, you have a choice between Data Center Bridging \(DCB\)or Software Defined Networking \(SDN\) QoS.

1.	**DCB**. You can configure DCB by using the Windows PowerShell NetQoS cmdlets. For an example see the section “Enable Data Center Bridging”  in the topic [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](../../../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).

2.	**SDN QoS**. You can enable SDN QoS by using Network Controller, which can be set to limit bandwidth on a virtual interface to prevent a high-traffic VM from blocking other users.  You can also configure SDN QoS to reserve a specific amount of bandwidth for a VM to ensure that the VM is accessible regardless of the amount of network traffic.  

All SDN Qos Settings are applied through the Port Settings of the Network Interface properties according to the following table.

|Element name|Description|
|------------|-----------| 
|macSpoofing|Specifies whether VMs can change the source media access control \(MAC\) address in outgoing packets to a MAC address that is not assigned to the VM. Allowed values are "enabled" \(allowing the VM to use a different MAC address\) and "disabled" \(allowing the VM to use only the MAC address assigned to it\).|
|arpGuard|Specifies whether ARP guard is enabled.  ARP guard allows only addresses that are specified in ArpFilter to pass through the port.  Allowed values are "enabled" or "disabled".
|dhcpGuard|Specifies whether to drop DHCP messages from a VM that claims to be a DHCP server. Allowed values are "enabled", which drops DHCP messages because the virtualized DHCP server is considered untrusted, or "disabled", which allows the message to be received because the virtualized DHCP server is considered to be trustworthy.
|stormLimit|Specifies the number of broadcast, multicast, and unknown unicast packets per second that a VM is allowed to send through the specified virtual network adapter. Broadcast, multicast, and unknown unicast packets beyond the limit during that one second interval are dropped. A value of zero \(0\) means there is no limit.
|portFlowLimit|Specifies the maximum number of flows that can be executed for the port.  A value of blank or zero \(0\) means there is no limit.
|vmqWeight|Specifies whether virtual machine queue (VMQ) is enabled on the virtual network adapter. The relative weight describes the affinity of the virtual network adapter to use VMQ. The range of value is 0 through 100. Specify 0 to disable VMQ on the virtual network adapter.
|iovWeight|Specifies whether single-root I/O virtualization \(SR-IOV\) is enabled on this virtual network adapter. The relative weight sets the affinity of the virtual network adapter to the assigned SR-IOV virtual function. The range of the value is 0 through 100. Specify 0 to disable SR-IOV on the virtual network adapter. 
|iovInterruptModeration|Specifies the interrupt moderation value for a single-root I/O virtualization \(SR-IOV\) virtual function assigned to a virtual network adapter. Allowed values are "default", "adaptive", "off", "low", "medium", and "high".   If Default is chosen, the value is determined by the physical network adapter vendor's setting.  If Adaptive is chosen, the interrupt moderation rate is based on the runtime traffic pattern. 
|iovQueuePairsRequested|Specifies the number of hardware queue pairs to be allocated to an SR-IOV virtual function. If receive-side scaling \(RSS\) is required, and if the physical network adapter that binds to the virtual switch supports RSS on SR-IOV virtual functions, then more than one queue pair is required. Allowed values range from 1 to 4294967295. 
|QosSettings|You can configure the following Qos Settings,all of which are optional:  <br/><br />**outboundReservedValue:**<br/>If outboundReservedMode is "absolute" then the value indicates the bandwidth, in Mbps, guaranteed to the virtual port for transmission (egress). If outboundReservedMode is "weight" then the value indicates the weighted portion of the bandwidth guaranteed. <br/><br />**outboundMaximumMbps:**  <br/>Indicates the maximum permitted send-side bandwidth, in Mbps, for the virtual port (egress). <br/><br/>**InboundMaximumMbps:**  <br/>Indicates the maximum permitted receive-side bandwidth for the virtual port (ingress) in Mbps. |