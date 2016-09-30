---
title: "Join computers to the new Windows Server Essentials server3"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2f651a16-7bc3-4bd1-907e-15deda425848
author: nnamuhcs
ms.author: coreyp
---



# Join computers to the new Windows Server Essentials server3
##  <a name="BKMK_JoinComputers"></a>   
 The next step in the migration process is to join client computers to the new  Windows Server Essentials server by reinstalling the Windows Server Connector software.  
  
 Before you can connect a client computer to the  Windows Server Essentials server, you must disconnect it from the Source Server by uninstalling the Windows Server Connector software.  
  
#### To uninstall the Windows Server Connector software on a client computer  
  
1.  Log on to the client computer.  
  
2.  Open Control Panel, and click **Programs and Features**.  
  
3.  In the list of programs on the **Programs and Features** page, right-click **Windows Server 2012 Connector**, and then click **Uninstall**.  
  
#### To reinstall the Windows Server Connector software on a client computer  
  
1.  Log on to the client computer.  
  
2.  Browse to **http://***destination-servername***/connect** and install the Windows Server Connector software as if this was a new computer. The installation process is the same for domain-joined or non-domain-joined client computers.
