---
title: Deploy a basic desktop hosting environment using Azure IaaS
description: Use RDS with Azure IaaS to host apps and desktops in the cloud.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 764d0c22-8800-485e-98a2-9e206d2544d4
author: lizap
manager: dongill
---
# Deploy a basic desktop hosting environment using Azure IaaS

>Applies To: Windows Server 2016

You can use Remote Desktop Services with Azure services to implement a desktop hosting service for tenants. This is ideal for hosting providers that want to leverage Microsoft Azure Infrastructure Services to deliver desktop hosting services and Subscriber Access Licenses (SALs) to multiple tenants via the Microsoft Service Provider Licensing Agreement (SPLA) program. It's also good for end customers who want to create and manage desktop hosting solutions in Microsoft Azure Infrastructure Services for their own employees using RDS User CALs extended rights through Software Assurance (SA).   
  
This article will walk you through the steps to create a basic desktop hosting solution based on the [Microsoft Azure Hosting Reference Architecture Guide](Desktop-Hosting-Reference-Architecture.md). If you need to create a production environment, you'll want to check out the other scenarios, including  high availability, customized desktop experience, and RemoteApp collections  
  
To deliver a desktop hosting solutions, we leverage Windows Server and the Windows Desktop Experience feature to deliver Windows users an application experience that is familiar to business users and consumers. Although Windows 8.1, Windows 7, and earlier Windows client versions are not licensed for hosting environments with shared hardware, the Desktop Experience feature in Windows Server 2012 R2 provides a similar user experience and application support.  
  
What this article covers:   
* Deployment guidance for a basic desktop hosting service based on Remote Desktop Services (RDS).    
* Session-based desktops that use Windows Server Remote Desktop Session Host (RDSH).  
   
    Windows client-based virtual desktop infrastructures are not covered because there is no Service Provider License Agreement (SPLA) for Windows client operating systems. Windows Server-based virtual desktop infrastructures are allowed under the SPLA, and Windows client-based virtual desktop infrastructures are allowed on dedicated hardware with end-customer licenses in certain scenarios. However, client-based virtual desktop infrastructures are out-of-scope for this article.  
* Basic availability provided by Microsoft Azure Infrastructure Services.  
  
    You can provide additional levels of high availability by guest clustering, but a general high availability solution is out-of-scope for this article.  
* Desktop hosting services for tenants ranging in size from 5 to 5000 users.    
  
    If you have more users, this architecture may need to be modified to provide adequate performance, and you'll want to use Windows PowerShell for managing any RDS deployment between 500 and 5000 users.   
* A Standalone desktop hosting cloud service that does not have virtual private network (VPN) links to an on-premises network. You can add those links but we don't in this article.  
* Self-signed certificates.  
   
    For a production deployment, get your certificates from a trusted root certificate authority and alternative deployment procedures used to install these certificates on the servers and client devices.  
  
There are multiple ways to deploy a desktop hosting solution. Throughout the article, you'll see specific examples you can use as a starting point for a basic deployment. These examples are identified with the ( ) notation.  
  
Use the following information to create your basic deployment:  
1.  [Configure your environment](Configure-your-desktop-hosting-environment.md).  
4.  [Deploy Remote Desktop Services](Deploy-your-Remote-Desktop-environment.md).  
5. [Validate and secure your deployment](Validate-and-secure-your-Remote-Desktop-deployment.md).


