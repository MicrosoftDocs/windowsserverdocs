---
title: Software Defined Networking (SDN)
description: Software Defined Networking (SDN) provides a method to centrally configure and manage physical and virtual network devices such as routers, switches, and gateways in your datacenter. Use this topic to learn about the Software Defined Networking (SDN) technologies that are provided in Windows Server, System Center, and Microsoft Azure.
manager: dougkim
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: 9a1ea73c-20cd-42c5-95ad-b003b9cc6d64
ms.author: lizross
author: eross-msft
ms.date: 08/09/2018
---
# SDN in Windows Server overview

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016


Software Defined Networking (SDN) provides a method to centrally configure and manage physical and virtual network devices such as routers, switches, and gateways in your datacenter. You can use your existing SDN-compatible devices to achieve deeper integration between the virtual network and the physical network. Virtual network elements such as Hyper-V Virtual Switch, Hyper-V Network Virtualization, and RAS Gateway are designed to be integral elements of your SDN infrastructure. 

>[!Note]
>Hyper-V hosts and virtual machines (VMs) running SDN infrastructure servers, such as Network Controller and Software Load Balancing nodes, must have Windows Server 2016 Datacenter edition installed. 
>
>Hyper-V hosts containing only tenant workload VMs connected to SDN-controlled networks can use Windows Server 2016 Standard edition.

SDN is possible because network planes are no longer bound to the network devices themselves. However, other entities, such as datacenter management software like System Center 2016 use network planes. SDN allows you to manage your datacenter network dynamically, providing an automated, centralized way to meet the requirements of your applications and workloads. 

You can use SDN to:

- Dynamically create, secure, and connect your network to meet the evolving needs of your apps
- Speed up the deployment of your workloads in a non-disruptive manner
- Contain security vulnerabilities from spreading across your network
- Define and control policies that govern both physical and virtual networks 
- Implement network policies consistently at scale

SDN allows you to accomplish all of this while also reducing your overall infrastructure costs.



## Contact the Datacenter and Cloud Networking product team

If you're interested in discussing SDN technologies with Microsoft or other SDN customers, there are a variety of methods for making contact.

For more information, see [Contact the Datacenter and Cloud Networking Team](contact-sdn-team.md).
