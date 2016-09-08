---
title: "Join computers to the new Windows Server 2012 Essentials server3"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Join computers to the new Windows Server 2012 Essentials server
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 2f651a16-7bc3-4bd1-907e-15deda425848
caps.latest.revision: 2
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Join computers to the new Windows Server 2012 Essentials server3
##  <a name="BKMK_JoinComputers"></a>   
 The next step in the migration process is to join client computers to the new --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials server by reinstalling the Windows Server Connector software.  
  
 Before you can connect a client computer to the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials server, you must disconnect it from the Source Server by uninstalling the Windows Server Connector software.  
  
#### To uninstall the Windows Server Connector software on a client computer  
  
1.  Log on to the client computer.  
  
2.  Open Control Panel, and click **Programs and Features**.  
  
3.  In the list of programs on the **Programs and Features** page, right-click **Windows Server 2012 Connector**, and then click **Uninstall**.  
  
#### To reinstall the Windows Server Connector software on a client computer  
  
1.  Log on to the client computer.  
  
2.  Browse to **http://***destination-servername***/connect** and install the Windows Server Connector software as if this was a new computer. The installation process is the same for domain-joined or non-domain-joined client computers.
