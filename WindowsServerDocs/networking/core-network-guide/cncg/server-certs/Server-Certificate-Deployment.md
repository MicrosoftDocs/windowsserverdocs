---
title: Server Certificate Deployment
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: 1ae4384b-f4e4-41e8-bc5f-9ac41953bca4
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Server Certificate Deployment

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Follow these steps to install an enterprise root certification authority (CA) and to deploy server certificates for use with PEAP and EAP.  
  
> [!IMPORTANT]  
> Before you install Active Directory Certificate Services, you must name the computer, configure the computer with a static IP address, and join the computer to the domain. After you install AD CS, you cannot change the computer name or the domain membership of the computer, however you can change the IP address if needed. For more information on how to accomplish these tasks, see the Windows Server&reg; 2016 [Core Network Guide](../../Core-Network-Guide.md).  

  
-   [Install the Web Server WEB1](../../../core-network-guide/cncg/server-certs/Install-the-Web-Server-WEB1.md)  
  
-   [Create an alias (CNAME) record in DNS for WEB1](../../../core-network-guide/cncg/server-certs/Create-an-Alias-CNAME-Record-in-DNS-for-WEB1.md)  
  
-   [Configure WEB1 to distribute Certificate Revocation Lists (CRLs)](../../../core-network-guide/cncg/server-certs/Configure-WEB1-to-Distribute-Certificate-Revocation-Lists.md)  
  
-   [Prepare the CAPolicy inf file](../../../core-network-guide/cncg/server-certs/Prepare-the-CAPolicy-inf-File.md)  
  
-   [Install the Certification Authority](../../../core-network-guide/cncg/server-certs/Install-the-Certification-Authority.md)  
  
-   [Configure the CDP and AIA extensions on CA1](../../../core-network-guide/cncg/server-certs/Configure-the-CDP-and-AIA-Extensions-on-CA1.md)  
  
-   [Copy the CA certificate and CRL to the virtual directory](../../../core-network-guide/cncg/server-certs/Copy-the-CA-Certificate-and-CRL-to-the-Virtual-Directory.md)  
  
-   [Configure the server certificate template](../../../core-network-guide/cncg/server-certs/Configure-the-Server-Certificate-Template.md)  
  
-   [Configure server certificate autoenrollment](../../../core-network-guide/cncg/server-certs/Configure-Server-Certificate-Autoenrollment.md)  
  
-   [Refresh Group Policy](../../../core-network-guide/cncg/server-certs/Refresh-Group-Policy.md)  
  
-   [Verify Server Enrollment of a Server Certificate](../../../core-network-guide/cncg/server-certs/Verify-Server-Enrollment-of-a-Server-Certificate.md)  
  
> [!NOTE]  
> The procedures in this guide do not include instructions for cases in which the **User Account Control** dialog box opens to request your permission to continue. If this dialog box opens while you are performing the procedures in this guide, and if the dialog box was opened in response to your actions, click **Continue**.  
  


