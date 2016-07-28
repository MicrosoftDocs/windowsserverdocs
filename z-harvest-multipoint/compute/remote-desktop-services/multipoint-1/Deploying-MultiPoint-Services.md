---
title: Deploying MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 594bc09e-5d2d-4984-a9de-79d40b1308d6
author: lizap
manager: jwhit
---
# Deploying MultiPoint Services
This guide describes how to deploy a [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] computer and stations, install and configure your system, set up user accounts, and perform some basic administration tasks, such as turning on Disk Protection and setting up backups, before you start using your system.  
  
You can use this guide to deploy [!INCLUDE[win8_server_multipoint-std_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint-std_2_md.md)] or [!INCLUDE[win8_server_multipoint-prem_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint-prem_2_md.md)]. Unless otherwise noted, all references to [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] refer to both [!INCLUDE[win8_server_multipoint-std_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint-std_2_md.md)] and [!INCLUDE[win8_server_multipoint-prem_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint-prem_2_md.md)].  
  
> [!IMPORTANT]  
> This guide assumes that you have purchased [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)], planned your environment, and procured the hardware that you will use. If you have not completed planning, see [Planning a Windows MultiPoint Server 2012 Deployment](../../../compute/remote-desktop-services/multipoint-1/Planning-a-MultiPoint-Services-Deployment.md) before you begin your deployment. These topics provide information about purchase and licensing options, options for setting up your MultiPoint Server computer and stations, and basic concepts you will need to know when using [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)].  
>   
> Windows MultiPoint Server 2012 does not support upgrading earlier versions of [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)]; you must purchase the full product.  
  
For a downloadable version of this doc, see [Windows MultiPoint Server 2012 Deployment Guide](http://www.microsoft.com/download/details.aspx?id=41545).  
  
> [!NOTE]  
> For additional support, see the [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] Help, which can be opened by clicking the Help icon or F1 on any [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)] or [!INCLUDE[win8_server_multipoint_dashboard](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_dashboard_md.md)] screen.  
  
## About [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)]  
Built on [!INCLUDE[win8_server_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_2_md.md)] technology, [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] enables multiple local *stations* to be connected to one computer. Several users can then share that computer at the same time, which enables each user to perform independent work or participate in a group activity.  
  
Stations can be connected directly to the computer running MultiPoint Server or can be clients on a network with MultiPoint Server. Stations can be as simple as one station *hub*, monitor, keyboard, and mouse, with no network required, or they can be traditional network clients such as a desktop, laptop, or thin client using the Remote Desktop Protocol \(RDP\) to connect to the server. For more information about your options for setting up stations, see [MultiPoint Server Stations](../../../compute/remote-desktop-services/multipoint-1/MultiPoint-Server-Stations.md).  
  
[!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] is available in the following two versions:  
  
-   **Standard**: Allows up to 10 simultaneously connected stations. Joining a domain is not supported, and it does not support virtualization as a host or guest operating system.  
  
-   **Premium**: Allows up to 20 simultaneously connected stations. Joining a domain is supported. Virtualization is supported as a host or guest operating system with a 1\+1 licensing model.  
  
> [!NOTE]  
> For information about deploying [!INCLUDE[win8_server_multipoint-prem_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint-prem_2_md.md)] in a virtualized environment, see [MultiPoint Server Virtualization Support](../../../compute/remote-desktop-services/multipoint-1/MultiPoint-Server-Virtualization-Support.md).  
  
## OEM vs. Site Licensing setup experience  
This guide provides instructions for completing the installation of an Original Equipment Manufacturer \(OEM\) product or performing a full installation of a product purchased under a Site Licensing agreement. There are three main differences between deployment of the OEM version and deployment of the Volume Licensing version of [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)]:  
  
-   The OEM version is pre\-installed on the server with which it is sold.  
  
-   On OEM products, the drivers for the hardware might already be installed.  
  
-   The initial customer setup experiences differ somewhat. Generally, a customer who purchases an OEM solution will connect the required peripheral devices, turn on the server, and follow instructions on\-screen or in the accompanying documentation to complete the setup. This requires fewer deployment tasks to be completed than when [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] is purchased through Volume Licensing. By contrast, Volume Licensing customers generally must consider capacity planning, choose their own hardware, and install the server software \(either manually or using Windows deployment tools\).  
  
## In this guide  
The *Deployment Guide* is organized in the following way. At a minimum, you need to complete the tasks for deploying your system and preparing your environment for users. Other tasks might or might not apply to your environment. For a summary of all deployment tasks, see [Task Lists: Deploying Windows MultiPoint Server 2012](../Topic/Task%20Lists:%20Deploying%20Windows%20MultiPoint%20Server%202012.md) in the appendixes.  
  
-   [Deploy a new Windows MultiPoint Server 2012 system](../../../compute/remote-desktop-services/multipoint-1/Deploy-a-new-Windows-MultiPoint-Server-2012-system.md)  
  
    Set up your [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)] computer and stations. Install and configure [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)]; set up your stations; install drivers, updates, and software; optionally join a domain; activate [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)]; and add client licenses \(CALs\) for each station.  
  
-   [Optional configuration tasks for a Windows MultiPoint Server 2012 deployment](../../../compute/remote-desktop-services/multipoint-1/Optional-configuration-tasks-for-a-Windows-MultiPoint-Server-2012-deployment.md)  
  
    Perform optional configuration tasks. Set up a split\-screen station; add printers; enable access over a wireless LAN; create virtual desktops for stations with the [!INCLUDE[firstref_client_7](../../../compute/remote-desktop-services/multipoint-1/includes/firstref_client_7_md.md)] or [!INCLUDE[win8_client_ent_1](../../../compute/remote-desktop-services/multipoint-1/includes/win8_client_ent_1_md.md)] operating system; change the display language for the system or for individual users.  
  
-   [Prepare your Windows MultiPoint Server 2012 system for users](../../../compute/remote-desktop-services/multipoint-1/Prepare-your-Windows-MultiPoint-Server-2012-system-for-users.md)  
  
    Plan and create user accounts; restrict users’ access to the server; for open access, configure stations for automatic logon; allow multiple sessions for shared user accounts; implement file sharing for users.  
  
-   [System administration in Windows MultiPoint Server 2012](../../../compute/remote-desktop-services/multipoint-1/System-administration-in-Windows-MultiPoint-Server-2012.md)  
  
    Perform some basic server administration tasks before you start using the server. Turn on Disk Protection; install Server Backup; to save power, configure sleep settings; configure group policies and the Registry for a domain deployment.  
  
-   [Appendixes: Deploying Windows MultiPoint Server 2012](../Topic/Appendixes:%20Deploying%20Windows%20MultiPoint%20Server%202012.md)  
  
    View or print task lists for all deployment tasks. Find out the meaning of terms used with [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)]. If basic language display setups do not meet your needs, find out how to handle complex scenarios.  
  
## See also  
  
- [MultiPoint Services](../../../compute/remote-desktop-services/multipoint-1/MultiPoint-Services.md)
  
-   [Windows MultiPoint Server Forum](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=windowsmultipointserver&filter=alltypes&sort=lastpostdesc)  
  
