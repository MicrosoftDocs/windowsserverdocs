---
title: Troubleshoot your firewall in Windows Server Essentials
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51d94b67-8b9b-4159-80dd-f652d73a43cb
author: cfreemanwa
---
# Troubleshoot your firewall in Windows Server Essentials
[!INCLUDE[wse_all](../Token/wse_all_md.md)]  
  
If you experience problems with remote access, run the Repair Anywhere Access Wizard.  
  
### To run the Repair Anywhere Access Wizard  
  
1.  Open the Dashboard.  
  
2.  Click **Settings**, click the **Anywhere Access** tab, and then click **Repair**.  
  
3.  Follow the instructions in the Repair Anywhere Access Wizard.  
  
If you are using an advanced network setup or using a non\-Microsoft firewall, you may need to open additional ports on the firewall. The ports in the following table are registered with Internet Assigned Numbers Authority \(IANA\).  
  
|Port Number|Description|  
|---------------|---------------|  
|65500|Certificate web service|  
|65510 and 65515|Client computer deployment website|  
|65520|Web service for Mac client computers|  
|65532|Provider framework for server loopback communications|  
|6602|Provider framework for communication between the server and client computers|  
  
## See also  
  
-   [Use Remote Web Access in Windows Server Essentials](../Topic/Use-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Remote Web Access in Windows Server Essentials](../Topic/Manage-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Anywhere Access in Windows Server Essentials](../Topic/Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](../Topic/Manage-Windows-Server-Essentials.md)  
  
-   [Support Windows Server Essentials](../Topic/Support-Windows-Server-Essentials.md)  
  
