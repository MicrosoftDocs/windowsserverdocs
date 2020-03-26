---
title: Container Networking Overview
description: This topic is an overview of the networking stack for Windows Containers and includes links to additional guidance about creating, configuring, and managing container networks.
manager: ravirao
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 318659e5-e4a5-4e46-99d6-211dfc46f6b8
ms.author: lizross
author: jmesser81
ms.date: 09/04/2018
---
# Container Networking Overview

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, we give you an overview of the networking stack for Windows containers and we include links to additional guidance about creating, configuring, and managing container networks.

Windows Server Containers are a lightweight operating system virtualization method separating applications or services from other services that run on the same container host. Windows containers function similarly to virtual machines. When enabled, each container has a separate view of the operating system, processes, file system, registry, and IP addresses, which you can connect to virtual networks. 

A Windows container shares a kernel with the container host and all containers running on the host. Because of the shared kernel space, these containers require the same kernel version and configuration. Containers provide application isolation through process and namespace isolation technology.

>[!IMPORTANT]
>Windows containers do not provide a hostile security boundary and should not be used to isolate untrusted code. 

With Windows containers, you can deploy a Hyper-V host, where you create one or more virtual machines on the VM hosts. Inside the VM hosts, containers get created, and the networking access is through a virtual switch running inside the virtual machine. You can use reusable images stored in a repository to deploy the operating system and services into containers. Each container has a virtual network adapter which connects to a virtual switch, forwarding inbound and outbound traffic. You can attach container endpoints to a local host network (such as NAT), the physical network or overlay virtual network created through the SDN stack.

For enforcing isolation between containers on the same host, you create a network compartment for each Windows Server and Hyper-V container. Windows Server containers use a Host vNIC to attach to the virtual switch. Hyper-V Containers use a Synthetic VM NIC (not exposed to the Utility VM) to attach to the virtual switch. 

## Related topics 

- [Windows Container Networking](https://docs.microsoft.com/virtualization/windowscontainers/container-networking/architecture): Learn how to create and manage container networks for non-overlay/SDN deployments.

- [Connect container endpoints to a tenant virtual network](../../manage/Connect-container-endpoints-to-a-Tenant-Virtual-Network.md): Learn how to create and manage container networks for overlay virtual networks with SDN. 