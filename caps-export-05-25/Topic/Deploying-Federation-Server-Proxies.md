---
title: Deploying Federation Server Proxies
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f457b189-5965-41d2-a9e9-99d09815af5c
author: billmath
---
# Deploying Federation Server Proxies
In [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the role of a federation server proxy is handled by a new Remote Access role service called Web Application Proxy. To enable your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for accessibility from outside the corporate network, which was the purpose of deploying a federation server proxy in legacy versions of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], such as [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 2.0 and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can deploy one or more web application proxies for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
In the context of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], Web Application Proxy functions as an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] federation server proxy. In addition to this, Web Application Proxy provides reverse proxy functionality for web applications inside your corporate network to enable users on any device to access them from outside the corporate network. For more information, about the Web Application Proxy role service, see Web Application Proxy Overview.  
  
To plan the deployment of Web Application proxy, you can review the information in the following topics:  
  
-   [Plan the Web Application Proxy Infrastructure \[WAP\]](assetId:///8dfd483f-faf5-4a99-a590-0081623cad08)  
  
-   [Plan the Web Application Proxy Server](assetId:///9020ad26-2952-4ef2-a746-d564376d2b93)  
  
To deploy Web Application proxy, you can follow the procedures in the following topics:  
  
-   [Configure the Web Application Proxy Infrastructure](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md)  
  
-   [Install and Configure the Web Application Proxy Server](../Topic/Install-and-Configure-the-Web-Application-Proxy-Server.md)  
  
## See Also  
[Windows Server 2012 R2 AD FS Deployment Guide](../Topic/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
  
