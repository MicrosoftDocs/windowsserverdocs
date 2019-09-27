---
title: MultiPoint Services Virtualization Support
description: Describes how to use MultiPoint Services with Hyper-V
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f0864b8-a087-4890-94ef-05efbd3c4241
author: evaseydl
manager: scottman
ms.author: evas
---
# MultiPoint Services Virtualization Support
MultiPoint Services supports the Hyper-V role in two ways:  
  
-   MultiPoint Services can be deployed as a guest operating system on a server running Hyper-V.  
  
-   MultiPoint Services can be used as a virtualization server.   
  
Running MultiPoint Services on a virtual machine provides the use of the Hyper-V tools to manage operating systems. These tools include checkpoint and rollback features, and they allow you to export and import virtual machines. For larger installations, you can consolidate servers by running multiple MultiPoint Services virtual computers on a single physical server. Possible scenarios include:  
  
-   A single classroom or lab has more than 20 seats. Rather than deploying multiple physical computers running MultiPoint Services, you can deploy multiple virtual machines on a single physical computer.  
  
    > [!NOTE]  
    > You can manage multiple MultiPoint servers, whether physical or virtual, through a single MultiPoint Manager console.  
  
-   The MultiPoint server is running on a virtual machine with another server infrastructure on the same physical computer. In that case this server infrastructure centralizes the domain, security, and data for the network. The MultiPoint server provides Remote Desktop Services and centralizes the desktops.  
  
> [!NOTE]  
> When running MultiPoint Services on a virtual machine, USB-over-Ethernet and RDP client stations are supported. Direct video and USB zero client connected stations are not supported.  
  
For more information about the Hyper-V role, see [Hyper-V](../../virtualization/hyper-v/hyper-v-on-windows-server.md).  