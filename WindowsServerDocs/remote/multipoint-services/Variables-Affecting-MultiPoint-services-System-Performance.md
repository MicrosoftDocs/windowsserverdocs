---
title: Variables Affecting MultiPoint Services System Performance
description: Performance information for MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f3e8875-1b5e-4789-b16c-d06d6e31f38e
author: evaseydl
manager: scottman
ms.author: evas
---
# Variables Affecting MultiPoint Services System Performance
There are many variables that can affect the overall performance of your MultiPoint Services system. You may want to consider these when designing your system.  
  
## Usage  
  
-   **Applications** The type and number of applications running at the same time, especially graphic\-heavy or memory intensive applications will affect the overall performance of your system. For more information, see [Applications and Internet Content](hardware-and-performance-recommendations.md#applications-and-internet-content).  
  
-   **Internet use** Consider if your users will be viewing multimedia content or web pages that use full-motion videos. This type of content can overload the system if too many users are viewing concurrently.  
  
    > [!NOTE]  
    > The projection feature in MultiPoint Services, which allows teachers to project their screens onto their student monitors, is not designed to project full-motion video. The projection feature is designed for demonstration purposes, such as showing a procedure.  
  
-   **High-speed devices** If too many users are concurrently using a high-speed device, like a web camera or DVD player, this affects the overall performance of the system.  
  
## Configuration  
  
-   **CPU, GPU, and RAM** See [Optimize MultiPoint Services System Performance](hardware-and-performance-recommendations.md#optimize-multipoint-services-system-performance) in this guide for CPU, GPU, and RAM recommendations.  
-   **Network bandwidth** For RDP-over-LAN connected stations, the network bandwidth and the capability of the client (for example, a thin client, desktop PC, or laptop) is important, particularly if video is running in the user's session. If you are using USB-over-Ethernet zero clients, network bandwidth should also be a consideration. Video data for all of the devices is sent over the same Ethernet connection, so you may want to consider setting up a separate Gigabit Ethernet network when using these devices.  
-   **RemoteFX** For RDP-over-LAN connected stations, you may be able to use RemoteFX to greatly improve the delivery of high-definition multimedia content.  
-   **Display resolution** If you have heavy full-screen video usage, you may want to consider reducing the monitor resolution to maximize performance.  
-   **Number of USB zero clients** The total number of USB zero clients on a single root hub on the server will directly affect video performance. For more information, see [Layout for USB Zero Client Connected Stations](MultiPoint-services-Site-Planning.md#layout-for-usb-zero-client-connected-stations). The number of USB-over-Ethernet zero client stations that are supported might be slightly less than the number of USB zero clients.  
-   **USB bandwidth** Consider the USB bandwidth when you are designing your system.  This is especially important for USB zero clients, which send video data over the USB connection. To optimize bandwidth, minimize the number of devices that are connected to a single USB port on the server. This applies to daisy chained stations and intermediate hubs. For more information, see [Station hubs](MultiPoint-services-Site-Planning.md#station-hubs) and [Intermediate hubs](MultiPoint-services-Site-Planning.md#intermediate-hubs).  
  
-   **USB type** Using USB 3.0 instead of USB 2.0 increases the available bandwidth between the server and the intermediate hub if you are connecting more than three USB zero clients to the hub or if you are using high-bandwidth USB devices.  
  
-   **Stations** The total number of stations affects the performance. If you have heavy graphics, processing, or video needs, you may want to limit the overall number of stations. For more information, see [Optimize MultiPoint Services System performance](hardware-and-performance-recommendations.md#optimize-multipoint-services-system-performance).