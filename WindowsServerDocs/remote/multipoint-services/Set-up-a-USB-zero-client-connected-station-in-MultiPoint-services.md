---
title: Set up a USB zero client-connected station in MultiPoint Services
description: Learn how to create a USB zero client station in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d2908865-6be3-474d-88f1-995f40bb61d0
author: lizap
manager: dongill
ms.author: elizapo
---
# Set up a USB zero client-connected station in MultiPoint Services
When you use USB zero clients to create MultiPoint Services stations, the monitor for each station is connected to the video port on the USB zero client, as shown in the following illustration. For more information about this and other station types, see [MultiPoint Stations](MultiPoint-services-Stations.md).
  
**MultiPoint Services system with one direct-video-connected station and two USB zero client-connected stations**  
  
![USB zerio-client connected stations](./media/WMS11_diagram7.gif)  
  
> [!IMPORTANT]  
> Before you set up USB zero client-connected stations, be sure to install the latest drivers for your video cards and the USB zero client. Outdated drivers can prevent the MultiPoint Services configuration from completing successfully. For instructions, see [Update and install device drivers if needed](Update-and-install-device-drivers-if-needed.md).  
  
> [!IMPORTANT]  
> If you are using a USB-over-Ethernet zero client, follow the instructions from your vendor, instead of this procedure, to use the Ethernet connection to set up the device on the network.  
  
### To set up a USB zero client-connected station  
  
1.  Connect the video monitor cable to the DVI or VGA video display port on the USB zero client, as shown in the following illustration.  
  
    ![Image of Video connection to USB hub-based system](./media/WMSVideoConnection.gif)  
  
2.  Connect the USB zero client to an open USB port on the computer.  
  
    ![Image of MultiPoint Services USB hub connection](./media/WMSUSBHubConnection.gif)  
  
3.  Connect a keyboard and mouse to the USB zero client.  
  
    ![Image of USB hub input device connections](./media/WMSUSBDeviceConnection.gif)  
  
4.  If you are using an externally powered USB zero client, connect the power cord of the USB zero client to a power outlet.  
  
5.  Connect the power cord of the video monitor to a power outlet.  
  
6.  If you are prompted to associate devices with the station, follow the instructions on the monitor to complete the setup. (Generally, USB zero client-connected stations are associated with stations automatically as you add them to the server.)