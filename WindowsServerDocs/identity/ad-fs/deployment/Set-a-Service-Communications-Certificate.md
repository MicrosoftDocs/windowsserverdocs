---
ms.assetid: 638c89bd-87e6-484b-9d2e-8ae2a74227e5
title: Set a Service Communications Certificate
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Set a Service Communications Certificate


Federation servers in Active Directory Federation Services \(AD FS\) use the service communications certificate to secure Web services traffic for Secure Sockets Layer \(SSL\) communication with Web clients or with federation server proxies.

> [!NOTE]  
> The Service Communications Certificate is not the same as an SSL Certificate. To change the AD FS SSL certificate, you will need to use Powershell. Follow the guidance in this [article](https://docs.microsoft.com/windows-server/identity/ad-fs/operations/manage-ssl-certificates-ad-fs-wap).


You can use the following procedure to change the service communications certificate with the AD FS Management snap\-in.  

> [!NOTE]  
> The AD FS Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.  

Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   

### To set a service communications certificate  

1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  

2.  In the console tree, double\-click **Service**, and then click **Certificates**.  

3.  In the **Actions** pane, click the **Set Service Communications Certificate** link.  

4.  In the **Select a service communications certificate** dialog box, navigate to the certificate file that you want to set as the service communications certificate, select the certificate file, and then click **Open**.  

## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  

[Certificate Requirements for Federation Servers](https://technet.microsoft.com/library/dd807040.aspx)  
