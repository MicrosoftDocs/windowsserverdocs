---
title: Set Up a Station
description: Learn how to set up a a station in MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dce05b6c-795e-43b2-9920-026550b873c5
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Set Up a Station
A MultiPoint Services *station* typically consists of a *station hub*, mouse, keyboard, and video monitor. This topic describes how to connect the hardware devices to the station hub to create a MultiPoint Services station.  
  
The station hub is a hardware device that connects peripheral devices to a computer in a MultiPoint Services system. MultiPoint Services supports two types of station hubs:  
  
-   **USB Hub:** A generic multiport USB expansion hub that complies with the universal serial bus 2.0 or later specifications. Such hubs typically have two, four, or more USB ports that allow for multiple USB devices to be connected to a single USB port on the computer. USB hubs are commonly separate devices that may be externally powered or bus-powered. When used as a station hub with MultiPoint Services, we recommend that you use a hub with four or more ports.  
  
    > [!IMPORTANT]  
    > If you plan to connect USB devices other than a keyboard and mouse to the hub, we recommend that you use an externally powered hub for best performance.  
  
-   **Multifunction Hub:** An expansion hub that connects to the computer via a USB port, and enables the connection of a variety of non-USB devices to the hub, including a video monitor. Multifunction hubs are produced by specific hardware manufacturers and may require the installation of a device-specific driver.  
  
If you want to add a station to your MultiPoint Services system, first make sure that you have enough connection ports available for the station hardware that you want to use. In addition, you must secure the appropriate number of *client access licenses (CALs)* for your MultiPoint Services system.  
  
## Setting up station hardware  
The procedures in this section describe how to connect MultiPoint Services station hardware to the different types of station hubs.  
  
### To set up a station with a USB hub  
  
1.  Before you can connect a new station, *end* all user *sessions*, and then shut down the computer and other powered devices in your MultiPoint Services system.  
  
2.  Connect the new video monitor cable to the video display port on the computer, as shown in the following illustration:  
  
    ![Image of Video connection to USB hub-based system](./media/WMSVideoConnection.gif)  
  
3.  Connect the new USB hub to an open USB port on the computer:  
  
    ![Image of MultiPoint Server USB hub connection](./media/WMSUSBHubConnection.gif)  
  
4.  Connect a keyboard and mouse to the USB hub:  
  
    ![Image of USB hub input device connections](./media/WMSUSBDeviceConnection.gif)  
  
5.  Connect the power cord of the video monitor to a power outlet.  
  
6.  Turn on the computer.  
  
7.  MultiPoint Services starts. Follow the instructions that appear on the new station's video monitor to associate the devices to the new station.  
  
### To set up a station with a multifunction hub  
  
1.  Before you can connect a new station, end all user sessions, and then shut down the computer and other powered devices in your MultiPoint Services system.  
  
2.  Connect the new video monitor cable to the DVI or VGA video display port on the multifunction hub, as shown in the following illustration:  
  
    ![Image of multifunction hub and video connection](./media/WMSMultifunctionHubVideoConnection.gif)  
  
3.  Connect the new multifunction hub to an open USB port on the computer:  
  
    ![Image of a multifunction hub connection](./media/WMSMultifunctionHubConnection.gif)  
  
4.  Connect a keyboard and mouse to the PS2 or USB connectors on the multifunction hub:  
  
    ![Image of multifunction hub and PS2 connectors](./media/WMSMultifunctionHubPS2Connection.gif)  
  
5.  Connect the power cord of the video monitor to a power outlet.  
  
6.  Turn on the computer.  
  
7.  MultiPoint Services starts. If prompted, follow the instructions that appear on the new station's video monitor to *associate* the devices to the new station.  
  
## See Also  
[End a User Session](End-a-User-Session.md)  
[Restart or Shut Down](Restart-or-Shut-Down.md)  
[Manage Station Hardware](Manage-Station-Hardware.md)  
[Work with USB Devices](Work-with-USB-Devices.md)