---
title: Glossary
description: Defines words, terms, and concepts in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 807bce1d-b993-49c6-9783-b01a3c55846c
author: evaseydl
manager: scottman
ms.author: evas
---
# Glossary
**associate a station**  
To specify which monitor is used with which station and peripheral devices, such as a keyboard and mouse. For direct video connected stations, this is done by pressing a specified key on the station's keyboard when prompted to do so. For USB zero client connected stations, this typically happens automatically.  
  
**bus-powered hub**  
A hub that draws all of its power from the computer's USB interface. Bus-powered hubs do not need separate power connections. However, many devices do not work with this type of hub because they require more power than this type of hub provides.  
  
**console mode**  
One of the two modes MultiPoint services can start. When the system is in console mode, no stations are available for use. Instead, all of the monitors are treated as a single extended desktop for the console session of the computer system. Console mode is typically used to install, update, or configure software, which cannot be done when the computer is in station mode. See also: *station mode*.  
  
**direct-video-connected station**  
A MultiPoint station that consists of a monitor that is directly connected to a video output on the server, and at a minimum, it includes a keyboard and mouse that are connected to the server through a USB hub.  
  
**domain user account**  
A user account that is hosted on a domain computer. Domain user accounts can be accessed from any computer that is connected to the domain, and they are not tied to any particular computer.  
  
**downstream hub**  
A hub that is connected to a station hub to add more available ports for station devices. A downstream hub must not have a keyboard attached to it.  
  
**externally powered hub**  
Also known as a self-powered hub, this hub takes its power from an external power supply unit; therefore, it can provide full power (up to 500 mA) to every port. Many hubs can operate as bus-powered or externally-powered hubs.  
  
**HID consumer control device**  
A Human Interface Device (HID) is a computer device that interacts directly with humans. It may take input from or deliver output to humans. Examples are keyboard, mouse, trackball, touchpad, pointing stick, graphics table, joystick, fingerprint scanner, gamepad, webcam, headset, and driving simulator devices. A HID consumer control device is a particular class of HID devices that includes audio volume controls and multimedia and browser control keys.  
  
**intermediate hub**  
A hub that is between a *root hub* on the server and a station hub. Intermediate hubs are typically used to increase the number of available ports for stations hubs or to extend the distance of the stations from the computer.  
  
**local user account**  
A user account on a specific computer. A local user account is available only on the computer where the account is defined.  
  
**multifunction hub**  
See *USB zero client*.  
  
**MultiPoint Services system**  
A collection of hardware and software that consists of one computer that has Windows Server 2016 installed with the MultiPoint Services role enabled and at least one MultiPoint station. For more information about system layout options, see [MultiPoint Services Site Planning](MultiPoint-services-Site-Planning.md)  
  
**partition**  
A section of space on a physical disk that functions as if it is a separate disk.  
  
**primary station**  
The station that is the first to start up when MultiPoint Services is started. The primary station can be used by an administrator to access startup menus and settings. When it is not being used by the administrator, it can be used as a normal station (it does not have to be reserved exclusively for administration). The primary station's monitor must always be connected directly to a video output on the computer that is running MultiPoint Services. See also: station.  
  
**RDP-over-LAN-connected station**  
A station that is a thin client, traditional desktop, or laptop computer that connects to MultiPoint services by using Remote Desktop Protocol (RDP) through the local area network (LAN).  
  
**root hub**  
A USB hub that is built-in to the host controller on a computer's motherboard.  
  
**split screen**  
A station where a single monitor can be used to display two independent user desktops. Two sets of hubs, keyboards, and mice are associated with a single monitor. One set is associated with the left side of the monitor, and the other set is associated with the right side of the monitor.  
  
**standard station**  
In contrast to the *primary station*, which can be used by an administrator to access startup menus, standard stations will not display startup menus, and they can only be used after MultiPoint Services has completed the startup process. See also: station.  
  
*station*  
User endpoint for connecting to the computer running MultiPoint Services. Three station types are supported: direct-video-connected, USB-zero-client-connected, and RDP-over-LAN-connected stations. For more information about stations, see [MultiPoint Stations](MultiPoint-services-Stations.md).  
  
**station hub**  
A USB hub that has been associated with a monitor to create a MultiPoint station. It connects peripheral USB devices to MultiPoint Services. See also: *USB zero client* and *USB hub*.  
  
**station mode**  
One of the two modes MultiPoint services can start. Typically, the MultiPoint Services system is in station mode. When in station mode, the MultiPoint Services stations behave as if each station is a separate computer that is running the Windows operating system, and multiple users can use the system at the same time. See also: *console mode*.  
  
**USB hub**  
A generic multiport USB expansion hub that complies with the universal serial bus (USB) 2.0 or later specifications. Such hubs typically have several USB ports, which allows multiple USB devices to be connected to a single USB port on the computer. USB hubs are typically separate devices that can be *externally powered* or *bus-powered*. Some other devices, such as some keyboards and video monitors, may incorporate a USB hub into their design. See also: *USB zero client*.  
  
**USB over Ethernet zero client**  
A USB zero client that connects to the computer through a LAN connection rather than a USB port. This client appears to the server as a USB device even through the data is sent through the Ethernet connection.  
  
**USB zero client**  
An expansion hub that connects to the computer through a USB port and enables the connection of a variety of non-USB devices to the hub. USB zero clients are produced by specific hardware manufacturers, and they require the installation of a device-specific driver. USB zero clients support connecting a video monitor (through VGA, DVI, and so on), and peripherals (through USB, sometimes PS/2, and analog audio). The USB zero client can be *externally powered* or *bus-powered*. See also, *USB hubs*.  
  
**USB zero client connected station**  
A MultiPoint Services station that consists of (as a minimum) a monitor, keyboard, and mouse, which are connected to the server through a USB zero client.  
  
