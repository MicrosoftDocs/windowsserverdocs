---
title: Set up an RDP-over-LAN connected station in Windows MultiPoint Server 2012
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60e1a025-c2fb-4708-a3ff-c44c223a3224
author: lizap
manager: jwhit
---
# Set up an RDP-over-LAN connected station in Windows MultiPoint Server 2012
An RDP\-over\-LAN connected station is a thin client, traditional desktop, or laptop computer that connects to MultiPoint Server on a local area network \(LAN\) by using the Remote Desktop Protocol \(RDP\). For more information about this and other station types, see [MultiPoint Server Stations](../../../compute/remote-desktop-services/multipoint-1/MultiPoint-Server-Stations.md) \(http:\/\/technet.microsoft.com\/library\/jj916411.aspx\).  
  
### To set up a MultiPoint Server station using a computer or thin client on a LAN  
  
1.  Turn on the computer that is running [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)].  
  
2.  Ensure that the MultiPoint Server computer is connected to the LAN by a switch, router, or other networking device and has a proper IP address. \(An IP address that starts with 169.254 \(an APIPA address\) might indicate there is an issue with the LAN connection or that the DHCP server can’t be reached or is not functioning correctly.\)  
  
3.  Connect the client computer or thin client to the LAN.  
  
4.  Turn on the client computer or thin client.  
  
5.  On the client computer or thin client, start Remote Desktop Connection or an equivalent application, and enter the name or IP address of the computer running MultiPoint Server.  
  
