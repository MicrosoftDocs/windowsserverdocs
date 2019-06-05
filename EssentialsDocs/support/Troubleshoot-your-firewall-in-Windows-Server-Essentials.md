---
title: "Troubleshoot your firewall in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51d94b67-8b9b-4159-80dd-f652d73a43cb
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot your firewall in Windows Server Essentials
 
>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
  
 If you experience problems with remote access, run the Repair Anywhere Access Wizard.  
  
### To run the Repair Anywhere Access Wizard  
  
1. Open the Dashboard.  
  
2. Click **Settings**, click the **Anywhere Access** tab, and then click **Repair**.  
  
3. Follow the instructions in the Repair Anywhere Access Wizard.  
  
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
  

-   [Support Windows Server Essentials](Support-Windows-Server-Essentials.md)

-   [Support Windows Server Essentials](../support/Support-Windows-Server-Essentials.md)

