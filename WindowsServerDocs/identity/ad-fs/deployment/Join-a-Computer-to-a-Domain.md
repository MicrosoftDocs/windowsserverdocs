---
ms.assetid: 10d6723e-c857-43da-9d2d-acb5641d3da8
title: Join a Computer to a Domain
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Join a Computer to a Domain

For Active Directory Federation Services \(AD FS\) to function, each computer that functions as a federation server must be joined to a domain. federation server proxies may be joined to a domain, but this is not a requirement.  
  
You do not have to join a Web server to a domain if the Web server is hosting claims\-aware applications only.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### To join a computer to a domain  
  
1.  On the **Start** screen, type **Control Panel**, and then press ENTER.  
  
2.  Navigate to **System and Security**, and then click **System**.  
  
3.  Under **Computer name, domain, and workgroup settings**, click **Change settings**.  
  
4.  On the **Computer Name** tab, click **Change**.  
  
5.  Under **Member of**, click **Domain**, type the name of the domain that you wish this computer to join, and then click **OK**.  
  
6.  Click **OK**, and then restart the computer.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  

