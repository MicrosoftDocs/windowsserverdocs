---
title: STEP 7 Test Connectivity When Returning to the Corpnet
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5a7252d0-6db8-4a9d-98ee-75082ecd2929
ms.author: lizross
author: eross-msft
---
# STEP 7 Test Connectivity When Returning to the Corpnet

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Many of your users will move between remote locations and the corpnet, so it's important that when they return to the corpnet that they are able to access resources without having to make any configuration changes. Remote Access makes this possible because when the DirectAccess client returns to the corpnet, it is able to make a connection to the network location server. Once the HTTPS connection is successfully established to the network location server, the DirectAccess client disables the DirectAccess client configuration and uses a direct connection to corpnet.  
  
### Test connectivity on CLIENT1  
  
1. Shut down CLIENT1 and then unplug CLIENT1 from the Homenet subnet or virtual switch and connect it to the Corpnet subnet or virtual switch. Turn on CLIENT1, and log on as CORP\User1.  
  
2. Open an elevated Windows PowerShell window, type **ipconfig /all**, and press ENTER. The output will indicate that CLIENT1 has a local IP address, and that there is no active 6to4, Teredo, or IP-HTTPS tunnel.  
  
3. Test connectivity to the network share on APP2. On the **Start** screen, type<strong>\\\APP2\Files</strong>, and then press ENTER. You will be able to open the file in that folder.  
  


