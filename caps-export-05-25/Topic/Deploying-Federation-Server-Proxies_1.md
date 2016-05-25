---
title: Deploying Federation Server Proxies_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4f3a9e31-4a2a-447c-a890-0652117690a3
author: billmath
---
# Deploying Federation Server Proxies_1
To deploy [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], complete each of the tasks in [Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md).  
  
> [!NOTE]  
> When you use this checklist, we recommend that you first read the references to [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] planning guidance in the [AD FS Design Guide in Windows Server 2012](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012.md) before you begin the procedures for configuring the servers. Following the checklist provides a better understanding of the design and deployment process for [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies.  
  
## About federation server proxies  
Federation server proxies are computers that run [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] software that have been configured manually to act in the proxy role. You can use [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies in your organization to provide intermediary services between an Internet client and a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] that is behind a firewall on your corporate network.  
  
> [!NOTE]  
> Although the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] and the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] roles cannot be installed on the same computer, a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] can perform [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] functions. For more information, see [When to Create a Federation Server](../Topic/When-to-Create-a-Federation-Server.md).  
  
The act of installing the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] software on a [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] computer and configuring it to serve in the proxy role makes that computer a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)].  
  
