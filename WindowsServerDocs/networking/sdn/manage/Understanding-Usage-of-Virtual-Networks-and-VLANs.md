---
title: Understanding Usage of Virtual Networks and VLANs
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 84ac2458-3fcf-4c4f-acfe-6105443dd83f
ms.author: pashort
author: shortpatti
---
# Understanding Usage of Virtual Networks and VLANs

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about Hyper-V Network Virtualization Virtual Networks and how they differ from virtual local area networks (VLANs).  
  
Software Defined Networking (SDN) in  Windows Server 2016 is based on programming policy for overlay virtual networks within a Hyper-V Virtual Switch. You can create overlay virtual networks, also called Virtual Networks, with Hyper-V Network Virtualization.   
  
When you deploy Hyper-V Network Virtualization, overlay networks are created by encapsulating the original tenant virtual machine's Layer-2 Ethernet frame with an overlay -  or tunnel - header (for example, VXLAN or NVGRE) and Layer-3 IP and Layer-2 Ethernet headers from the underlay (or physical) network. The overlay virtual networks are identified by a 24-bit Virtual Network Identifier (VNI) to maintain tenant traffic isolation and to allow overlapping IP addresses. The VNI is composed of a virtual subnet ID (VSID), logical switch ID, and tunnel ID.  
  
Additionally, each tenant is assigned a routing domain (similar to virtual routing and forwarding - VRF) so that multiple virtual subnet prefixes (each represented by a VNI) can be directly routed to each other. Cross-tenant (or cross routing domain) routing is not supported without going through a gateway.   
  
The physical network on which each tenant's encapsulated traffic is tunneled is represented by a logical network called the provider logical network. This provider logical network consists of one or more subnets, each represented by an IP Prefix and, optionally, a VLAN 802.1q tag.  
  
You can create additional logical networks and subnets for infrastructure purposes to carry management traffic, storage traffic, live migration traffic, etc.  
  
Microsoft SDN does not support the isolation of tenant networks by using VLANs. Tenant isolation is accomplished solely by using Hyper-V Network Virtualization overlay Virtual Networks and encapsulation. 


