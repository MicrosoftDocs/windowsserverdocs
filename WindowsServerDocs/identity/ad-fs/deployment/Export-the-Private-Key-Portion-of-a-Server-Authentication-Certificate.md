---
ms.assetid: cd4d4902-dcdf-49dd-8059-82a56bf4b585
title: Export the Private Key Portion of a Server Authentication Certificate
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---


# Export the Private Key Portion of a Server Authentication Certificate

Every federation server in an Active Directory Federation Services \(AD FS\) farm must have access to the private key of the server authentication certificate. If you are implementing a server farm of federation servers or Web servers, you must have a single authentication certificate. This certificate must be issued by an enterprise certification authority \(CA\), and it must have an exportable private key. The private key of the server authentication certificate must be exportable so that it can be made available to all the servers in the farm.  
  
This same concept is true of federation server proxy farms in the sense that all federation server proxies in a farm must share the private key portion of the same server authentication certificate.  
  
> [!NOTE]  
> The AD FS Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.  
  
Depending on which role this computer will play, use this procedure on the federation server computer or federation server proxy computer where you installed the server authentication certificate with the private key. When you finish the procedure, you can then import this certificate on the Default Web Site of each server in the farm. For more information, see [Import a Server Authentication Certificate to the Default Web Site](Import-a-Server-Authentication-Certificate-to-the-Default-Web-Site.md).  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### To export the private key portion of a server authentication certificate  
  
1. On the **Start** screen, type**Internet Information Services \(IIS\) Manager**, and then press ENTER.  
  
2. In the console tree, click **ComputerName**.  
  
3. In the center pane, double\-click **Server Certificates**.  
  
4. In the center pane, right\-click the certificate that you want to export, and then click **Export**.  
  
5. In the **Export Certificate** dialog box, click the **…** button.  
  
6. In **File name**, type **C:\\**<em>NameofCertificate</em>, and then click **Open**.  
  
7. Type a password for the certificate, confirm it, and then click **OK**.  
  
8. Validate the success of your export by confirming that the file you specified is created at the specified location.  
  
   > [!IMPORTANT]  
   > So that this certificate can be imported to the local certificate store on the new server, you must transfer the file to physical media and protect its security during transport to the new server. It is extremely important to guard the security of the private key. If this key is compromised, the security of your entire AD FS deployment \(including resources within your organization and in resource partner organizations\) is compromised.  
  
9. Import the exported server authentication certificate into the certificate store on the new server before you install the Federation Service. For information about how to import the certificate, see Import a Server Certificate \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=108283](https://go.microsoft.com/fwlink/?LinkId=108283)\).  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Certificate Requirements for Federation Servers](https://technet.microsoft.com/library/dd807040.aspx)  
  
[Certificate Requirements for Federation Server Proxies](https://technet.microsoft.com/library/dd807054.aspx)  
  

