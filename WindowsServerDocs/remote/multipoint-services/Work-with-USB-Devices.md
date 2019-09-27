---
title: Work with USB Devices
description: Learn how USB devices work with MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a33f2b83-bbc2-4fc1-8a94-aaa985dfe1f9
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Work with USB Devices
You can connect devices to either the computer in your MultiPoint Services system or to a MultiPoint station hub. The location where a device is connected, and the type of device, affects whether a device is available to all users on the system, only to individual users, or not available to any users. The following are examples of the different connection types:  
  
-   If you connect a device directly to the computer, such as a printer or USB mass storage device, the device can be accessed by all session users on the MultiPoint Services system. Virtual desktop station users will not be able to access the devices connected directly to the computer.  
  
-   If you connect a device to a station hub, such as a keyboard, mouse, *audio device*, or mass storage device, the device is available only to the user logged on to that MultiPoint Services station.  
  
-   If you connect certain types of devices to the computer, such as a keyboard or mouse, the devices are not available to any users on the system.  
  
The following table shows a list of devices and how they behave, depending on where they are connected to the system. Information about how to connect station hubs is described in [Working with station hubs](#working-with-station-hubs). More information about how to connect video monitors to a station is described in [Work with Video Devices](Work-with-Video-Devices.md).  
  
|||||  
|-|-|-|-|  
|**Device**|**Behavior when it is connected directly to the computer**|**Behavior when it is connected to a station**|**Notes**|  
|Keyboard|We do not recommend connecting a keyboard directly to the computer.|Accessible only to the station user.|If the keyboard contains a USB port, then the USB hub inside the keyboard may be the station hub. Other USB devices attached to that port are available only to user who is using that keyboard.<br /><br />Some station hubs are equipped with a PS\/2 mouse port that is converted into a USB connection inside the hub.|  
|Mouse|We do not recommend connecting a mouse directly to the computer.|Accessible only to the station user.|Some station hubs are equipped with a PS\/2 mouse port that is converted into a USB connection inside the hub.|  
|USB hub|See [Working with station hubs](#working-with-station-hubs).|See [Working with station hubs](#working-with-station-hubs).||  
|Video monitor|See [MultiPoint Services Video Devices](work-with-video-devices.md).|See [MultiPoint Services Video Devices](work-with-video-devices.md).||  
|Audio output devices such as headphones|We do not recommend connecting an audio output device directly to the computer.|Accessible only to the station user.|Some station hubs are equipped with an analog audio port that is converted into a USB audio connection inside the hub.|  
|Audio input devices such as microphones|We do not recommend connecting an audio input device directly to the computer.|Accessible only to the station user.|Some station hubs are equipped with an analog audio port that is converted into a USB audio connection inside the hub.|  
|Printers|Accessible to all users on the system.*|Accessible only to the station user.||  
|USB mass storage device|Accessible to all users on the system.\*|Accessible only to the station user.|These devices include USB flash drives, external hard disk drives, and digital cameras.|  
|Web cameras|Accessible to all users on the system.*|Accessible only to the station user.|Only one user can connect to the camera at a time.|  
  
*Devices that are connected to the host computer are not visible to the users who are logged on to virtual desktop stations.  
  
For more information about how to set up a station, see [Set Up a Station](Set-Up-a-Station.md).  
  
### Working with station hubs  
There are four scenarios for how a USB hub can be used when it is connected to a MultiPoint Services system. Each of the following scenarios provides different access to the devices that are connected to it, depending on the type of hub and where it is connected to the system.  
  
-   A station hub connected to the computer in your MultiPoint Services system with a keyboard attached can be used to create a MultiPoint Services station. A keyboard and mouse are connected to the station hub using the ports that are available on the hub. A video monitor is connected to a video port on the computer or to a video adapter on the station hub, if available. The keyboard, mouse, and monitor are then *associated* with a MultiPoint Services station.  
  
-   A USB hub connected to the computer in your MultiPoint Services system with no keyboard attached can be used to connect additional devices to the computer when there are not enough ports on the computer for the required devices. All devices connected to this USB hub are available to all users of the MultiPoint Services system. This is not considered a MultiPoint Services station hub.  
  
-   A powered USB hub connected to the computer in your MultiPoint Services system, also known as an intermediate hub, can be used to connect additional USB hubs that are used to create MultiPoint stations.  
  
-   A USB hub connected to a station hub can be used to connect additional devices to the station hub. Keyboards must be connected directly to the station hub.  
  
For more information about how to set up a MultiPoint Services station, see [Set Up a Station](Set-Up-a-Station.md).  
  
## See Also  
[Work with Video Devices](Work-with-Video-Devices.md)  
[Manage Station Hardware](Manage-Station-Hardware.md)  
[Set Up a Station](Set-Up-a-Station.md)