---
title: STEP 7: Test Connectivity When Returning to the Corpnet_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 399d51c2-0af3-43fb-8556-4cb169634842
author: vhorne
---
# STEP 7: Test Connectivity When Returning to the Corpnet_1
Many of your users will move between remote locations and the corpnet, so it’s important that when they return to the corpnet that they are able to access resources without having to make any configuration changes. Remote Access makes this possible because when the DirectAccess client returns to the corpnet, it is able to make a connection to the network location server. Once the HTTPS connection is successfully established to the network location server, the DirectAccess client disables the DirectAccess client configuration and uses a direct connection to corpnet.  
  
### Test connectivity on CLIENT1  
  
1.  Shut down CLIENT1 and then unplug CLIENT1 from the Homenet subnet or virtual switch and connect it to the Corpnet subnet or virtual switch. Turn on CLIENT1, and log on as CORP\\User1.  
  
2.  Open an elevated [!INCLUDE[wps_2](../Token/wps_2_md.md)] window, type **ipconfig \/all**, and press ENTER. The output will indicate that CLIENT1 has a local IP address, and that there is no active 6to4, Teredo, or IP\-HTTPS tunnel.  
  
3.  Test connectivity to the network share on APP2. [!INCLUDE[clickstart](../Token/clickstart_md.md)]**\\\\APP2\\Files**, and then press ENTER. You will be able to open the file in that folder.  
  
