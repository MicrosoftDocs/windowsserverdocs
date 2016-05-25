---
title: Set up the physical computer and primary station
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e83b126-ce9a-4cd7-a0bd-6627c9e0f81b
author: cfreemanwa
---
# Set up the physical computer and primary station
Before you install [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)], you need to set up the primary station for your MultiPoint Server system and, if you will use a local area network \(LAN\) with MultiPoint Server, connect the computer to the LAN.  
  
A *station* is an endpoint by which the MultiPoint Server computer is accessed. The *primary station* is the first station to start when MultiPoint Server is started. Administrators can use it to access startup menus and settings. The primary station provides access to system configuration and troubleshooting information that is only available during startup and before the MultiPoint Server operating system is running. After startup, you can use the primary station as you would any other station.  
  
The primary station must be a direct\-video\-connected station. The following procedure describes how to connect the needed hardware to your MultiPoint Server computer.  
  
For more information about stations, see [MultiPoint Server Stations](http://technet.microsoft.com/library/jj916411.aspx) \(http:\/\/technet.microsoft.com\/library\/jj916411.aspx\). For help with making hardware selections, see [Selecting Hardware for Your MultiPoint Server System](../Topic/Selecting-Hardware-for-Your-MultiPoint-Server-System.md) \(http:\/\/technet.microsoft.com\/library\/jj916407.aspx\). For information about connecting other stations types to the MultiPoint Server computer, see [Attach additional stations to your Windows MultiPoint Server 2012 computer](../Topic/Attach-additional-stations-to-your-Windows-MultiPoint-Server-2012-computer.md).  
  
> [!NOTE]  
> To create a video\-connected station, you must use a Latin keyboard \(such as an English\- or Spanish\-language keyboard\).  
  
### To set up your primary station  
  
1.  Ensure that the computer running [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] is turned off and unplugged.  
  
2.  Connect the power cord of the monitor to a power outlet, and connect the monitor cable to the video display port on the computer, as shown below.  
  
    ![](../Image/WMSVideoConnection.gif)  
  
3.  If the station will use a USB keyboard and mouse, complete the following steps:  
  
    1.  Connect an external USB hub to an open USB port on the computer, as shown below.  
  
        ![](../Image/WMSUSBHubConnection.gif)  
  
    2.  Connect the USB keyboard and mouse to the USB hub.  
  
        ![](../Image/WMSUSBDeviceConnection.gif)  
  
        > [!NOTE]  
        > If your MultiPoint Server computer has PS\/2 ports, you can, if needed, use a PS\/2 keyboard and mouse plugged directly into the computer. However, this setup has significant limitations. Users cannot use audio devices, web cams, and flash drives on PS\/2 stations.  
  
    3.  If you are using an externally powered hub, connect the power cable of the hub to a power outlet.  
  
        > [!IMPORTANT]  
        > We strongly recommend the use of a powered hub. Erratic system behavior can result from under\-current conditions.  
        >   
        > Users should not attach mice and keyboards directly to the USB ports of the computer. Doing so is likely to cause the incorrect association of multiple keyboards and mice to the same station, or to no station at all.  
  
        > [!NOTE]  
        > The host audio device on the system’s motherboard is only available while Windows MultiPoint Server is in console mode. To ensure uninterrupted audio for a station that uses an external USB hub, you must use a USB audio device plugged into the hub.  
  
### To connect the computer to the LAN  
  
-   If you have a LAN, connect your computer to your network with a network cable.  
  
