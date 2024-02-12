---
description: "Learn more about: Deploying Legacy AD FS Federation Server Proxies"
ms.assetid: 1b21b0a9-1fe6-4fd1-8a25-92e578d774ed
title: Deploying Federation Server Proxies in AD FS
author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# Deploying Legacy AD FS Federation Server Proxies

To deploy federation server proxies in Active Directory Federation Services \(AD FS\), complete each of the tasks in [Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md).

> [!NOTE]
> When you use this checklist, we recommend that you first read the references to federation server proxy planning guidance in the [AD FS Design Guide in Windows Server 2012](../design/ad-fs-design-guide-in-windows-server-2012.md) before you begin the procedures for configuring the servers. Following the checklist provides a better understanding of the design and deployment process for federation server proxies.

## About federation server proxies
Federation server proxies are computers that run Windows Server&reg; 2012 and AD FS software that have been configured manually to act in the proxy role. You can use federation server proxies in your organization to provide intermediary services between an Internet client and a federation server that is behind a firewall on your corporate network.

> [!NOTE]
> Although the federation server and the federation server proxy roles cannot be installed on the same computer, a federation server can perform federation server proxy functions. For more information, see [When to Create a Federation Server](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dd807101(v=ws.11)).

The act of installing the AD FS software on a Windows Server&reg; 2012 computer and configuring it to serve in the proxy role makes that computer a federation server proxy.

