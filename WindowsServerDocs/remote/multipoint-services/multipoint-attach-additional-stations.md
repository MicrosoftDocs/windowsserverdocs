---
title: Attach additional stations to your MultiPoint server
description: Add more stations to your MultiPoint Services deployment
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d78ebf4e-0968-4014-9a42-9f75cc50cb52
author: evaseydl
manager: scottman
ms.author: evas
ms.date: 08/04/2016
---
# Attach additional stations to MultiPoint Services
In your MultiPoint Services environment, your users use stations to connect to MultiPoint Services and do their work. The stations are the user endpoints for connecting to the computer running Multipoint Services.  
  
MultiPoint services supports three types of station:  
  
-   Direct-video-connected stations  
  
-   USB zero client-connected stations (and USB over Ethernet zero client connected stations)  
  
-   RDP-over-LAN connected stations  
  
The classifications are based on a station's hardware and the type of connection that it uses. You can mix and match connection types for your stations. The only requirement is that the primary station (which you installed earlier) must be a direct-video-connected station. For more information about station setups, see [MultiPoint Stations](MultiPoint-services-Stations.md).  
  
For instructions that explain how to set up each type of station, see the following:  
  
-   [Set up a direct-video-connected station](Set-up-a-direct-video-connected-station-in-MultiPoint-services.md)  
  
-   [Set up a USB zero client-connected station](Set-up-a-USB-zero-client-connected-station-in-MultiPoint-services.md)  
  
-   [Set up an RDP-over-LAN connected station](Set-up-an-RDP-over-LAN-connected-station-in-MultiPoint-services.md)  
  
For a detailed comparison of station types, see [Station type comparison](multipoint-services-stations.md#BKMK_StationTypeComparison).  
  
> [!NOTE]  
> -   The procedures for attaching stations do not describe how to set up intermediate hubs or downstream hubs. For information about where to install these hubs, see [MultiPoint Stations](MultiPoint-services-Stations.md).  
> -   In some cases, you might need to create station virtual desktops, which run in virtual machines. For example, you use applications that cannot be installed on Windows Server or applications that will not run multiple instances on the same host computer. For more information, see [Create Windows 10 Enterprise virtual desktops for stations](Create-Windows-10-Enterprise-virtual-desktops-for-stations.md).  
  
> [!TIP]  
> It is useful to create your stations in the order of their physical locations so that they are identified sequentially in MultiPoint Server. If you later want to change the name of a station, you can do that in MultiPoint Manager. For more information, see Remap all stations in MultiPoint Server Help and Support.