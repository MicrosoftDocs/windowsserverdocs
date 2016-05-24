---
title: Export the Private Key Portion of a Server Authentication Certificate
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb86c173-3ed0-45e2-916d-524be00a2ef9
author: billmath
---
# Export the Private Key Portion of a Server Authentication Certificate
Every [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in an [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] farm must have access to the private key of the server authentication certificate. If you are implementing a server farm of [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s or Web servers, you must have a single authentication certificate. This certificate must be issued by an enterprise certification authority \(CA\), and it must have an exportable private key. The private key of the server authentication certificate must be exportable so that it can be made available to all the servers in the farm.  
  
This same concept is true of [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] farms in the sense that all [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies in a farm must share the private key portion of the same server authentication certificate.  
  
> [!NOTE]  
> The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.  
  
Depending on which role this computer will play, use this procedure on the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] computer or [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] computer where you installed the server authentication certificate with the private key. When you finish the procedure, you can then import this certificate on the Default Web Site of each server in the farm. For more information, see [Import a Server Authentication Certificate to the Default Web Site](../Topic/Import-a-Server-Authentication-Certificate-to-the-Default-Web-Site.md).  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To export the private key portion of a server authentication certificate  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Internet Information Services \(IIS\) Manager**, and then press ENTER.  
  
2.  In the console tree, click **ComputerName**.  
  
3.  In the center pane, double\-click **Server Certificates**.  
  
4.  In the center pane, right\-click the certificate that you want to export, and then click **Export**.  
  
5.  In the **Export Certificate** dialog box, click the **…** button.  
  
6.  In **File name**, type **C:\\***NameofCertificate*, and then click **Open**.  
  
7.  Type a password for the certificate, confirm it, and then click **OK**.  
  
8.  Validate the success of your export by confirming that the file you specified is created at the specified location.  
  
    > [!IMPORTANT]  
    > So that this certificate can be imported to the local certificate store on the new server, you must transfer the file to physical media and protect its security during transport to the new server. It is extremely important to guard the security of the private key. If this key is compromised, the security of your entire [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment \(including resources within your organization and in resource partner organizations\) is compromised.  
  
9. Import the exported server authentication certificate into the certificate store on the new server before you install the Federation Service. For information about how to import the certificate, see Import a Server Certificate \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=108283](http://go.microsoft.com/fwlink/?LinkId=108283)\).  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Certificate Requirements for Federation Servers](../Topic/Certificate-Requirements-for-Federation-Servers.md)  
  
[Certificate Requirements for Federation Server Proxies](../Topic/Certificate-Requirements-for-Federation-Server-Proxies.md)  
  
