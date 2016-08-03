---
title: Set up an RDP-over-LAN connected station in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60e1a025-c2fb-4708-a3ff-c44c223a3224
author: evas
manager: scottman
---
# Set up an RDP-over-LAN connected station in MultiPoint Services
An RDP-over-LAN connected station is a thin client, traditional desktop, or laptop computer that connects to MultiPoint Services on a local area network (LAN) by using the Remote Desktop Protocol (RDP). For more information about this and other station types, see [MultiPoint Stations](MultiPoint-services-Stations.md).  
  
## To set up a MultiPoint station using a computer or thin client on a LAN  
  
1.  Turn on the computer that is running MultiPoint Services.  
  
2.  Ensure that the MultiPoint Server computer is connected to the LAN by a switch, router, or other networking device and has a proper IP address. (An IP address that starts with 169.254 (an APIPA address) might indicate there is an issue with the LAN connection or that the DHCP server can’t be reached or is not functioning correctly.)  
  
3.  Connect the client computer or thin client to the LAN.  
  
4.  Turn on the client computer or thin client.  
  
5.  On the client computer or thin client, start Remote Desktop Connection or an equivalent application, and enter the name or IP address of the computer running MultiPoint Services.

## Setup a Windows 10 devices for remote management by making use of Connector Services
Any PC or laptop running Windows 10 can be managed remotely:
- the Connector Services have been enabled  
- the machine has been added to managed computers on the MultiPoint server.  

On the PC running Windows 10 follow these steps to enable MultiPoint Connector:

1. Type in the search "Turn Windows features on or off" and select the proper search result. 

2. In the list of features enable **MultiPoint Connector**. This will enable MultiPoint connector services which are needed to manage the device. 

On the MultiPoint server:
1. Open MultiPoint Manager and select either **Add or remove personal computers** or **Add or remove MultiPoint Services**.

2. Select the remote computers you want to manage and click **OK**.  You will be prompted for admin credentials on the remote machines.  Once this is done, you will see the remote machines on the MultiPoint Manager home tab.

When successfully set up Dashboard Manager can monitor users working on the managed device.

> [!IMPORTANT]  
> When monitoring managed Windows 10 devices administratrive users cannot be monitored except the server settings have been changed accordingly. See [Edit Server Settings](Edit-Server-Settings.md)