---
title: Selecting Hardware for Your MultiPoint Services System
description: Hardware considerations for MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e74961a2-bd38-48ae-b1c0-4b3eff761b4a
author: evaseydl
manager: scottman
ms.author: evas
---
# Selecting Hardware for Your MultiPoint Services System
When you build a MultiPoint Services system, you should select a computer that meets the Windows Server 2016 system requirements. If you are deciding which components to select, consider the following:  
  
-   The target price range of your complete solution.  
  
-   The types of usage scenarios that you might expect for the MultiPoint Services system, such as whether the users are running multimedia programs, using word processing or productivity programs, or browsing the Internet.  
  
-   Whether your scenario has large processing or memory demands.  
  
-   The number of users who could be using the system at the same time. If you plan to have many users on your system at the same time, or users who use system-intensive programs, you should plan for more computing power for your system.  
  
-   The type of stations. How many USB ports or video ports do you need?  
  
-   Future expansion plans. Do you plan to add stations to the MultiPoint Services system at a later date? Will you have enough video card slots, USB ports, or network taps? How many additional users will your hardware need to support?  
  
-   Physical layout. For more information, see [MultiPoint Services Site Planning](MultiPoint-services-Site-Planning.md).  
  
A MultiPoint Services system typically includes the following components:  
  
-   One computer that is running MultiPoint Services, which includes a CPU, RAM, hard disk drives, and video cards.  
  
-   A monitor, station hub, keyboard, and mouse for each station.  
  
-   Optional peripheral devices for the MultiPoint Services stations, including speakers, headphones, microphones, or storage devices that are available only to the user of the station.  
  
-   Optional peripheral devices that are available to all users of the MultiPoint Services system, connected directly to the host computer, such as printers, external hard disk drives, and USB storage devices.  
  
Use the following information to make hardware decisions:  
  
-   [Selecting a CPU](#selecting-a-cpu)  
-   [Selecting hardware components](#selecting-hardware-components)  
  
## Selecting a CPU  
A MultiPoint Services system is a multiple\-user environment, with all users connected to a single host computer. This increases the CPU usage because all users share the same computer. Some tasks, such as multimedia programs \(for example, media players or video\-editing software\), have larger processing demands. Therefore, make sure to select a CPU that can handle the processing requirements for the number of users and types of user scenarios that it will need to support.  
  
MultiPoint Services requires an x64\-based CPU, and must meet the system requirements for the computer as described in [Hardware Requirements and Performance Recommendations](Hardware-Requirements-and-Performance-Recommendations.md).  
  
The following types of processors have been tested to be used on a MultiPoint Services system with high\-demand processing programs, such as multimedia programs:  
  
-   **Dual\-core processor:** Can support up to 8 stations.  
-   **Quad\-core processor:** Can support up to 16 stations.
-   **Quad\-core processor with multithreading:** Can support up to 20 stations.      
-   **Six\-core processor with multithreading:** Can support up to 24 stations.  
  
With this information, select a CPU that meets the processing requirements for your MultiPoint Services system. 
> [!NOTE] 
> If you are running video intensive applications the recommendation is at least one core per station. 
  
## Selecting hardware components  
When you are building a MultiPoint Services system, consider the following hardware components that you may need:  
  
-   Video hardware  
  
-   MultiPoint Services station hardware  
  
    -   *USB hubs*  
  
    -   USB zero clients  
  
    -   Keyboards and mouse devices  
  
    -   Monitors  
  
-   Peripheral devices  
  
    -   Audio devices, such as speakers and headphones  
  
    -   Microphones  
  
    -   USB mass storage devices  
  
When you have selected the hardware components for your MultiPoint Services system, make sure that you obtain current, 64\-bit drivers for the components.  
  
The following topics provide detailed information to help you select components for your MultiPoint Services system:  
  
[Selecting video hardware](#selecting-video-hardware)  
[Selecting direct\-video\-connected or USB zero client station devices](#BKMK_Selectingdirect-video-connectedorUSBzeroclientstationdevices)   
[Selecting other station peripheral devices](#selecting-other-station-peripheral-devices)  
[Selecting RDP\-over\-LAN\-connected station hardware](#BKMK_SelectingRDP-over-LAN-connectedstationhardware)  
[Selecting audio devices](#selecting-audio-devices)  
  
## Selecting video hardware
The video hardware that you select should support the number of monitors that you will require for the number of users you intend to have working at MultiPoint Services stations. In addition, different types of video hardware can provide a higher\-performance solution for graphics\-intensive programs, such as multimedia content.  
  
Select the video hardware that can support the maximum number of monitors for the type of performance that your MultiPoint Services system requires. Make sure that you validate the performance of the video hardware that you choose to ensure that it meets your performance requirements.  
  
> [!NOTE]  
> You must install a video driver that supports extending your desktop across multiple monitors.  
  
Video hardware options include:  
  
-   Internal video cards that use a PCI or a PCIe bus interface  
  
-   External video controllers connected by USB  
  
The following sections describe the capabilities of each of these video hardware types. You can combine internal video cards and external video controllers to create the system that you want.  
  
### Internal video cards  
An internal video card is plugged\-in to the motherboard on the computer. The internal video card is a solution that can help the performance of graphics\-intensive multimedia programs. However, an internal video card requires an available PCI or PCIe slot to plug\-in to the motherboard. Many high\-performance video cards require a PCIe slot, but there are a limited number of PCIe slots on a motherboard. You should know what kind of video card slots are available on your computer so that you can purchase the correct type of video cards.  
  
The number of monitors that can connect to each video card depends on the GPU that is used on the card and the number of ports it supports, which typically ranges from 2 to 6.  
  
When you are selecting internal video cards, select video cards that support the number of monitors required to create the desired number of direct video connected stations. The maximum number of monitors that can be supported is equal to the number of internal video cards that are plugged\-in to the motherboard multiplied by the number of monitor ports on each of those video cards. For example, if you had two internal video cards and each card had two monitor ports, you could support up to four monitors.    
  
### External video controllers  
USB zero clients contain an external video controller to connect a monitor to the client. The USB zero client might also include connections for headphones, speakers, a microphone, or other peripheral devices.  
  
Select a USB zero client if you want to enable support for additional monitors without opening the computer, or if you want to support more stations than available video outputs. For example, if you previously had four monitors plugged\-in to internal video cards, and you want to add two more monitors, you can plug\-in two external video controllers to the computer and have room for two more monitors. In this manner, you can combine a USB zero client with the video controller and not use additional PCI or PCIe slots on the motherboard.  
  
## <a name="BKMK_Selectingdirect-video-connectedorUSBzeroclientstationdevices"></a>Selecting direct\-video\-connected or USB zero client station devices  
A MultiPoint Services station consists of a station hub or USB zero client with a keyboard and mouse plugged\-in, and a monitor that is plugged\-in to the host computer or in to a USB zero client. Other peripheral devices can be plugged\-in to the station hub or USB zero client, but they are not required to create MultiPoint station. These other peripheral devices are described in [Selecting other station peripheral devices](#selecting-other-station-peripheral-devices).  
  
The devices that you select to create a MultiPoint Services station should meet minimum requirements to work with MultiPoint Services. Details about the requirements for the following MultiPoint Services station devices are provided in this topic:  
  
-   [Selecting USB hubs](#selecting-usb-hubs)  
-   [Selecting USB zero clients](#selecting-usb-zero-clients)  
-   [Selecting keyboards and mouse devices](#selecting-keyboards-and-mouse-devices)  
-   [Selecting monitors](#selecting-monitors)  
  
### Selecting USB hubs  
The USB hubs that are used in a MultiPoint Services system can be a generic USB hub. Such hubs typically have four or more USB ports, and they allow multiple USB devices to be connected to a single USB port on the computer. Some other devices, such as keyboards and video monitors, may also incorporate a USB hub into their design.  
  
An additional consideration is the use of an *externally powered* hub, instead of a *bus\-powered* hub. With a bus\-powered hub, the amount of current that is provided by the host computer must be sufficient to provide power to all the peripheral devices that are plugged\-in to the hub, without degrading system performance. An externally powered hub allows you to connect more peripheral devices and provide sufficient power to all of them. The use of externally powered hubs can help prevent performance issues, port failures, and other intermittent issues.  
  
When selecting a USB hub for your MultiPoint Services system, consider its use. The hub can be used as a *station hub*, an *intermediate hub*, or a *downstream hub*. Refer to the following table for descriptions about each hub type. We recommend all USB devices to be USB 2.0 or later.
  
||Powered|  
|-|-----------|  
|Station Hub|Can be bus\-powered unless high\-powered devices will be plugged\-in to it or a downstream hub will be connected to it|  
|Intermediate Hub |Should be externally powered|  
|Downstream Hub|Can be externally powered or bus powered depending on the devices that are plugged\-in to the hub|  
|Active USB Extender Cable|Active USB cables that include a USB hub are typically bus powered; therefore, they are not recommended for connecting station hubs to the computer.|  
  
### Selecting USB zero clients  
A USB zero client is a USB hub that contains a video output. Therefore, it allows a monitor to be connected to the computer through a USB connection. For more information about using USB zero clients for video, see [Selecting video hardware](#selecting-video-hardware) in this document. A USB zero client can also enable the connection of a variety of USB and non\-USB devices to the hub. USB zero clients are produced by specific hardware manufacturers, and they require installing a device\-specific driver.  
  
### Selecting keyboards and mouse devices  
The keyboard and mouse devices that you plug\-in to the station will typically be USB devices. Some USB zero clients provide PS\/2 ports, in which case, the keyboard and mouse should use PS\/2 to connect to the station hub. You can also use a PS\/2 keyboard and mouse if you are setting up a PS\/2 direct\-video\-connected station.  
  
A keyboard with an internal hub can be used as a station hub. However, all other station devices must connect to the internal hub by using ports on the keyboard. If such a keyboard is connected to the computer through another hub, that hub will be treated as an intermediate hub.  
  
If you are using split\-screen stations, you may want to consider using a mini keyboard that does not have a number pad so that the two keyboards can fit in front of the monitor.  
  
### Selecting monitors  
There should be one monitor provided for each MultiPoint Services station, unless a split\-screen is planned. Monitors are plugged into the video card on the computer, the USB zero client or the LAN\-based client. Any type of monitor that is supported by the video card, USB zero client, or LAN\-based client can be used, including CRT monitors.  
  
Some special monitors include an internal LAN\-based client or USB zero client. Such monitors will typically include audio input\/output jacks and internal USB hubs for connecting keyboards and mice. They connect to the server through a USB or a LAN connection.  
  
#### Display resolution  
The minimum supported resolution for a station's display area is 512 x 768 pixels. If the MultiPoint Services system starts and finds that a station's display area is less than the minimum resolution, a blank screen will be displayed on that station and the station will not be usable.  
  
If a display monitor is going to be shared by two stations as split\-screen stations, the minimum requirement for the display is 1024 x 768, so that the resulting individual station screen areas are at least 512 x 768. For the best split\-screen user experience, a wide screen with a minimum of resolution of 1600 x 900 is recommended.  
  
## Selecting other station peripheral devices  
MultiPoint Services supports peripheral devices that are connected to a station hub, a USB zero client, or directly to the computer. Devices plugged into a station hub will be associated with that specific station. Other devices are available to every station when plugged directly into the computer. LAN clients can also support peripheral devices.  
  
> [!IMPORTANT]  
> A keyboard cannot be connected to a downstream hub \(for example, a hub that is plugged into a station hub\). If you plug in a keyboard to a downstream hub, any peripherals that are plugged\-in to the downstream hub will no longer be available to that station. This behavior allows the support of daisy\-chained station hubs.  
  
**Available to all stations** A USB device that is plugged into the computer \(for example, not through a station hub\) is available to all stations. Depending on the device, it can be used by multiple users at one time, or only one user can access it at a time. The following table explains how USB devices can be accessed.  
  
> [!NOTE]  
> The “Connected to Host Computer” column in the table refers to the behavior when the computer running MultiPoint Services is running in station mode with stations. If you are running in console mode, the peripherals that are plugged anywhere behave in the same way as a standard server in a console session.  
  
||Connected to Host Computer|Connected to Station Hub or Downstream Hub|  
|-|------------------------------|----------------------------------------------|  
|Keyboard|Not functional, unless it is part of a PS/2 station. |Available to individual station<br /><br />Cannot be connected to a downstream hub|  
|Mouse|Not functional, unless it is part of a PS/2 station. |Available to individual station|  
|Speaker/headphones|Not functional, unless it is part of a PS/2 station.|Available to individual station|  
|USB storage device|Available to all stations|Available to individual station|  
|HID Consumer Control|Not functional|Available to individual station|  
|Other USB devices, such as cameras, document readers, and DVD drives|Available to all stations if supported by Windows Server 2012|Available to all stations if supported by Windows Server 2008 R2 Remote Desktop Services|  
  
## <a name="BKMK_SelectingRDP-over-LAN-connectedstationhardware"></a>Selecting RDP\-over\-LAN\-connected station hardware  
Any LAN client that can connect to Remote Desktop Services, by using Remote Desktop Protocol, can become a MultiPoint Services station.  
  
If you want the LAN client to only be used as a MultiPoint station, you may want to “lock down” your LAN client. For example, configure your thin client so that it can only connect to a MultiPoint Services session, or configure your desktop computers so that access to desktop icons and Start Menu items such as a web browser is removed to prevent direct Internet access. You can make these configurations using your LAN client configuration tools or group or local policies.  
  
## Selecting audio devices  
It is important to make sure that when you select audio devices, they can be plugged into the station hub, USB zero client or LAN client. Some USB hubs, USB zero clients, and LAN clients have an analog audio jack that can be used with traditional analog audio devices \(such as headphones or earbuds\). Station hubs that do not have analog jacks can use USB audio devices.  
  
If you have configured a PS\/2 direct\-video\-connected station by using PS\/2 ports on the computer's motherboard for the keyboard and mouse, you must use the analog audio on the computer's motherboard in order for the audio device to be available to this station when the MultiPoint Services system is running in station mode.  
  
If you do not have a PS\/2 direct\-video\-connected station, the host audio device on the system's motherboard will be available only when the MultiPoint Services system is running in console mode.  