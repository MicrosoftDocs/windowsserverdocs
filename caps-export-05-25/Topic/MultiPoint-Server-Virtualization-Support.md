---
title: MultiPoint Server Virtualization Support
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f0864b8-a087-4890-94ef-05efbd3c4241
author: cfreemanwa
---
# MultiPoint Server Virtualization Support
[!INCLUDE[win8_server_multipoint-prem_2](../Token/win8_server_multipoint-prem_2_md.md)] supports the Hyper\-V® role in two ways:  
  
-   [!INCLUDE[win8_server_multipoint-prem_2](../Token/win8_server_multipoint-prem_2_md.md)] can be deployed as a guest operating system on a server running Hyper\-V.  
  
-   [!INCLUDE[win8_server_multipoint-prem_2](../Token/win8_server_multipoint-prem_2_md.md)] can be used as a virtualization server.  
  
> [!NOTE]  
> [!INCLUDE[win8_server_multipoint-std_2](../Token/win8_server_multipoint-std_2_md.md)] does not support virtualization as guest operating system or as a virtualization server.  
  
Running [!INCLUDE[win8_server_multipoint-prem_2](../Token/win8_server_multipoint-prem_2_md.md)] on a virtual machine provides the use of the Hyper\-V tools to manage operating systems. These tools include checkpoint and rollback features, and they allow you to export and import virtual machines. For larger installations, you can consolidate servers by running multiple [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] virtual computers on a single physical server. Possible scenarios include:  
  
-   A single classroom or lab has more than 20 seats.  Rather than deploying multiple physical computers running [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)], you can deploy multiple virtual machines on a single physical computer.  
  
    > [!NOTE]  
    > You can manage multiple MultiPoint servers, whether physical or virtual, through a single [!INCLUDE[win8_server_multipoint_manager](../Token/win8_server_multipoint_manager_md.md)] console.  
  
-   [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] is running on a virtual machine with another server infrastructure on the same physical computer. For example, [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] is running with Windows Small Business Server \(Windows SBS\) Essentials. Windows SBS centralizes the domain, security, and data for the network.  [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] provides Remote Desktop Services and centralizes the desktops.  
  
> [!NOTE]  
> When running [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] on a virtual machine, USB\-over\-Ethernet and RDP client stations are supported. Direct video and USB zero client connected stations are not supported.  
  
For more information about the Hyper\-V role, see [Hyper\-V](http://go.microsoft.com/fwlink/?LinkId=211308) on Microsoft TechNet.  
  
