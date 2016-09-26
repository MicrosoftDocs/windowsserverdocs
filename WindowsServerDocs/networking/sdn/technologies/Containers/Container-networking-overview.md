---
title: Container Networking Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 
ms.author: jmesser
author: jmesser81
---
# Container Networking Overview

>Applies To: Windows Server&reg; 2016

This topic is an overview of the networking stack for Windows Containers and includes links to additional guidance about creating, configuring, and managing container networks.

Windows containers function similarly to virtual machines in regards to networking. Each container has a virtual network adapter which is connected to a virtual switch, over which inbound and outbound traffic is forwarded. To enforce isolation between containers on the same host, a network compartment is created for each Windows Server and Hyper-V Container into which the network adapter for the container is installed. Windows Server containers use a Host vNIC to attach to the virtual switch. Hyper-V Containers use a Synthetic VM NIC (not exposed to the Utility VM) to attach to the virtual switch. 

Container endpoints can be attached to a local host network (e.g. NAT), the physical network, or an overlay virtual network created through the Microsoft Software Defined Networking (SDN) stack. 

For more information about creating and managing container networks for non-overlay/SDN deployments, refer to the [Windows Container Networking](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/management/container_networking) guide on MSDN.

For more information about creating and managing container networks for overlay virtual networks with SDN, refer to [Connect container endpoints to a tenant virtual network](../../manage/Connect-container-endpoints-to-a-Tenant-Virtual-Network.md). 