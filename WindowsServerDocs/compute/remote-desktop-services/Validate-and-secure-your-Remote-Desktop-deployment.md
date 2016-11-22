---
title: Validate and secure your Remote Desktop deployment
description: Learn how to verify that your RDS deployment is functioning.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 11/08/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: adc85c02-5391-4f8a-abd7-827a70746c4d
author: lizap
manager: dongill
---
# Validate and secure your Remote Desktop deployment

>Applies To: Windows Server 2016

Once you have deployed your Remote Desktop servers, you can validate the deployment by connecting to Remote Desktop from a client computer over the Internet.   
  
Once you validate the deployment, you'll want to secure your deployment.  
  
Use the following information to do both of these tasks.  
  
## Connect to a Remote Desktop deployment over the Internet  
Use the following steps to connect from a client computer:  
  
>[!NOTE] 
> This certificate installation step is not required if the certificate has been obtained from a trusted root certificate authority.


1.  Install the self-signed client certificates on the client computer:  
    1.  Sign into the client computer with an administrative account, and then navigate to the folder where you copied the certificates. Right-click one of the certificate files, and then click **Install certificate**.  
    2.  In the Certificate Import Wizard, click **Local Machine > Place all certificates in the following store**.  
    3.  Browse to the Trusted Root Certification Authorities, and then click **OK**.  
    4. Click **Next**, then **Finish**, and **OK**.  
    3.  Repeat steps a. and d. for the other certificate.  
2.  Connect to the deployment through RD Web Access and RD Gateway.  
    1.  In Internet Explorer (or a different, supported browser), enter the DNS name for the deployment, for example, https://contoso.westus.cloudapp.azure.com/RdWeb/.  
    3.  Sign in with a domain user account (like Contoso\u1).  
    4.  Under **RemoteApp and Desktops** select one of the collections created for this deployment (like ContosoDesktop), and then click **Connect**.  
      
  
Note: There are multiple ways to connect from a client computer to the desktop hosting deployment. These are described in [Distribution of Remote Apps and Desktops in Windows Server 2012](http://social.technet.microsoft.com/wiki/contents/articles/14488.distribution-of-remote-apps-and-desktops-in-windows-server-2012.aspx). The steps in this section connect using the RD Web Access site.  
  
## Secure the deployment  
To secure your deployment, you need to delete all public IP addresses except those assigned to external load balancers:  
  
1. In the Azure portal, click **Browse > Resource Groups**.  
2. Click the virtual machine that has a public IP address assigned to it (for example, Contoso-Cb1), then click the public IP address in the **Essentials** pane.  
3. Click **Delete**.
4. Repeat these steps for other virtual machines as necessary.  
  


