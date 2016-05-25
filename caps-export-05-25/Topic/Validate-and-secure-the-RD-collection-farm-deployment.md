---
title: Validate and secure the RD collection farm deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fb869f7-067d-44ae-9acb-6febc22e30c2
author: lizap
---
# Validate and secure the RD collection farm deployment
Once you have added the Remote Desktop Session Host server to your collection farm, you can validate the deployment by connecting to it from a client computer over the Internet.   
  
Once you validate the deployment, you'll want to secure your deployment.  
  
Use the following information to do both of these tasks.  
  
## Connect to a Remote Desktop deployment over the Internet  
Use the following steps to connect from a client computer through RD Web Access and RD Gateway:  
1.	In Internet Explorer (or a different, supported browser), enter the FQDN of the cloud service, e.g. https://contoso.westus.cloudapp.azure.com/RdWeb/.  
2.	Sign in with a domain user account (like Contoso\u1).  
3.	Under **RemoteApp and Desktops** select one of the collections created for this deployment (like ContosoDesktop), and then click **Connect**.  
      
  
Note: There are multiple ways to connect from a client computer to the desktop hosting deployment. These are described in [Distribution of Remote Apps and Desktops in Windows Server 2012](http://social.technet.microsoft.com/wiki/contents/articles/14488.distribution-of-remote-apps-and-desktops-in-windows-server-2012.aspx). The steps in this section connect using the RD Web Access site.  
  
## Secure the deployment  
To secure your deployment, you need to delete the Public IP addresses assigned to the RD Connection Broker and RD Session Host virtual machines:  
  
1. In the Azure portal, click **Browse > Virtual machines**.  
2. Click the RD Session Host VM (for example, Contoso-SH2), then click the Public IP address in the **Essentials** pane.  
3. Click **Delete**.  
  
