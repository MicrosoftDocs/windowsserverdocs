---
ms.assetid: 1b21b0a9-1fe6-4fd1-8a25-92e578d774ed
title: Deploying Federation Server Proxies
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Deploying Federation Server Proxies

To deploy federation server proxies in Active Directory Federation Services \(AD FS\), complete each of the tasks in [Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md).  
  
> [!NOTE]  
> When you use this checklist, we recommend that you first read the references to federation server proxy planning guidance in the [AD FS Design Guide in Windows Server 2012](https://technet.microsoft.com/library/dd807036.aspx) before you begin the procedures for configuring the servers. Following the checklist provides a better understanding of the design and deployment process for federation server proxies.  
  
## About federation server proxies  
Federation server proxies are computers that run Windows Server® 2012 and AD FS software that have been configured manually to act in the proxy role. You can use federation server proxies in your organization to provide intermediary services between an Internet client and a federation server that is behind a firewall on your corporate network.  
  
> [!NOTE]  
> Although the federation server and the federation server proxy roles cannot be installed on the same computer, a federation server can perform federation server proxy functions. For more information, see [When to Create a Federation Server](https://technet.microsoft.com/library/dd807101.aspx).  
  
The act of installing the AD FS software on a Windows Server® 2012 computer and configuring it to serve in the proxy role makes that computer a federation server proxy.  
  

