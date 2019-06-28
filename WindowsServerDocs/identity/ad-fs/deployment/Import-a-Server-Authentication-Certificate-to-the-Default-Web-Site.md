---
ms.assetid: e1f2ce2d-b24f-4ccd-8add-9e69419fc6c1
title: Import a Server Authentication Certificate to the Default Web Site
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Import a Server Authentication Certificate to the Default Web Site

After you obtain a server authentication certificate from a certification authority \(CA\), you must manually install that certificate on the Default Web Site for each federation server or federation server proxy in a server farm.  
  
For Web servers, you must manually install the server authentication certificate on the appropriate Web site or virtual directory where your federated application resides.  
  
If you are setting up a farm, be sure to perform this procedure identically—using the exact same settings—on each of the servers in your farm.  
  
> [!NOTE]  
> The AD FS Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### To import a server authentication certificate to the Default Web Site  
  
1.  On the **Start** screen, type**Internet Information Services \(IIS\) Manager**, and then press ENTER.  
  
2.  In the console tree, click **ComputerName**.  
  
3.  In the center pane, double\-click **Server Certificates**.  
  
4.  In the **Actions** pane, click **Import**.  
  
5.  In the **Import Certificate** dialog box, click the **…** button.  
  
6.  Browse to the location of the pfx certificate file, highlight it, and then click **Open**.  
  
7.  Type a password for the certificate, and then click **OK**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Certificate Requirements for Federation Servers](https://technet.microsoft.com/library/dd807040.aspx)  
  
[Certificate Requirements for Federation Server Proxies](https://technet.microsoft.com/library/dd807054.aspx)  
   
  

