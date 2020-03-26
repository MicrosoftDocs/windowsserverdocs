---
title: What's New in Hyper-V Network Virtualization in Windows Server 2016
description: This topic provides information about new features in Hyper-V Network Virtualization in Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0254275a-0a77-40a9-b68a-1029284c03fe
ms.author: lizross
author: eross-msft
ms.date: 03/19/2018
---
# What's New in Hyper-V Network Virtualization in Windows Server 2016

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the Hyper-V Network Virtualization (HNV) functionality that is new or changed in Windows Server 2016.  
  
## <a name="BKMK_IPAM2012R2"></a>Updates in HNV  
HNV offers enhanced support in the following areas:  
  
|Feature/Functionality|New or improved|Description|  
|--------------------------|-------------------|---------------|  
|[Programmable Hyper-V switch](../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md#SDN)|New|HNV policy is programmable through the Microsoft Network Controller.|  
|[VXLAN encapsulation support](../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md#VXLAN)|New|HNV now supports VXLAN encapsulation.|  
|[Software Load Balancer (SLB) interoperability](../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md#SLB)|New|HNV is fully integrated with the Microsoft Software Load Balancer.|  
|[Compliant IEEE Ethernet headers](../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/../../../sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md#L2)|Improved|Compliant with IEEE Ethernet standards|  
  
### <a name="SDN"></a>Programmable Hyper-V switch  
HNV is a fundamental building block of Microsoft's updated Software Defined Networking (SDN) solution, and is fully integrated into the SDN stack.  
  
Microsoft's new Network Controller pushes HNV policies down to a Host Agent running on each host using Open vSwitch Database Management Protocol (OVSDB) as the SouthBound Interface (SBI). The Host Agent stores this policy using a customization of the [VTEP schema](https://github.com/openvswitch/ovs/blob/master/vtep/vtep.ovsschema) and programs complex flow rules into a performant flow engine in the Hyper-V switch.  
  
The flow engine inside the Hyper-V switch is the same engine used in Microsoft Azure&trade;, which has been proven at hyper-scale in the Microsoft Azure public cloud. Additionally, the entire SDN stack up through the Network Controller, and Network Resource Provider (details coming soon) is consistent with Microsoft Azure, thus bringing the power of the Microsoft Azure public cloud to our enterprise and hosting service provider customers.  
  
> [!NOTE]  
> For more information about OVSDB, see [RFC 7047](https://www.rfc-editor.org/info/rfc7047).  
  
The Hyper-V switch supports both stateless and stateful flow rules based on simple 'match action' within Microsoft's flow engine.  
 
![Windows Server 2016 Hyper-V switch](../../../media/what-s-new-in-hyper-v-network-virtualization-in-windows-server/HNVOverview.png)  
  
### <a name="VXLAN"></a>VXLAN encapsulation support  
The Virtual eXtensible Local Area Network (VXLAN - [RFC 7348](https://www.rfc-editor.org/info/rfc7348)) protocol has been widely adopted in the market place, with support from vendors like Cisco, Brocade, Dell, HP and others. HNV also now supports this encapsulation scheme using MAC distribution mode through the Microsoft Network Controller to program mappings for tenant overlay network IP addresses (Customer Address, or CA) to the physical underlay network IP addresses (Provider Address, or PA). Both NVGRE and VXLAN Task Offloads are supported for improved performance through third-party drivers.  
  
### <a name="SLB"></a>Software Load Balancer (SLB) interoperability  
Windows Server 2016 includes a software load balancer (SLB) with full support for virtual network traffic and seamless interaction with HNV. The SLB is implemented through the performant flow engine in the data plane v-Switch and controlled by the Network Controller for Virtual IP (VIP) / Dynamic IP (DIP) mappings.  
  
### <a name="L2"></a>Compliant IEEE Ethernet headers  
HNV implements correct L2 Ethernet headers to ensure interoperability with third-party virtual and physical appliances that depend on industry-standard protocols. Microsoft ensures that all transmitted packets have compliant values in all fields to ensure this interoperability. In addition, support for Jumbo Frames (MTU > 1780) in the physical L2 network will be required to account for packet overhead introduced by encapsulation protocols (NVGRE, VXLAN) while ensuring guest Virtual Machines attached to an HNV Virtual Network maintain a 1514 MTU.  
  
## See also  
  
-   [Hyper-V Network Virtualization Overview](hyperv-network-virtualization-overview-windows-server.md)  
  
-   [Hyper-V Network Virtualization technical details](hyperv-network-virtualization-technical-details-windows-server.md)  
  
-   [Software Defined Networking](../../Software-Defined-Networking--SDN-.md)  
  