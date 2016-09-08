---
title: "Troubleshoot your firewall in Windows Server Essentials"
ms.custom: na
ms.date: 01/12/2014
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 51d94b67-8b9b-4159-80dd-f652d73a43cb
caps.latest.revision: 10
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-de
  - es-es
  - fr-fr
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Troubleshoot your firewall in Windows Server Essentials
--- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- This topic applies to a server running Windows Server 2012 Essentials or Windows Server 2012 R2 Essentials, or to a server running Windows Server 2012 R2 Standard or Windows Server 2012 R2 Datacenter with the Windows Server Essentials Experience role installed.  
  
 If you experience problems with remote access, run the Repair Anywhere Access Wizard.  
  
### To run the Repair Anywhere Access Wizard  
  
1.  Open the Dashboard.  
  
2.  Click **Settings**, click the **Anywhere Access** tab, and then click **Repair**.  
  
3.  Follow the instructions in the Repair Anywhere Access Wizard.  
  
 If you are using an advanced network setup or using a non-Microsoft firewall, you may need to open additional ports on the firewall. The ports in the following table are registered with Internet Assigned Numbers Authority (IANA).  
  
|Port Number|Description|  
|-----------------|-----------------|  
|65500|Certificate web service|  
|65510 and 65515|Client computer deployment website|  
|65520|Web service for Mac client computers|  
|65532|Provider framework for server loopback communications|  
|6602|Provider framework for communication between the server and client computers|  
  
## See also  
  
-   [Use Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Remote Web Access](../manage/Manage-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Anywhere Access](../manage/Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](../manage/Manage-Windows-Server-Essentials.md)  
  
-   [Support Windows Server Essentials](../support/Support-Windows-Server-Essentials.md)
