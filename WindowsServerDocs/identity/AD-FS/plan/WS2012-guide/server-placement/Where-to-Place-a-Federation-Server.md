---
title: Where to Place a Federation Server
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e6994151-f45d-4d33-aaa0-fddab4880e32
author: billmath
---
# Where to Place a Federation Server
As a security best practice, place [!INCLUDE[firstref_adfs2]()][!INCLUDE[adfs2_fs]()]s in front of a firewall and connect them to your corporate network to prevent exposure from the Internet. This is important because [!INCLUDE[adfs2_fs]()]s have full authorization to grant security tokens. Therefore, they should have the same protection as a domain controller. If a [!INCLUDE[adfs2_fs]()] is compromised, a malicious user has the ability to issue full access tokens to all Web applications and to [!INCLUDE[adfs2_fs]()]s that are protected by [!INCLUDE[firstref_adfs2]()] in all resource partner organizations.  
  
> [!NOTE]  
> As a security best practice, avoid having your [!INCLUDE[adfs2_fs]()]s directly accessible on the Internet. Consider giving your [!INCLUDE[adfs2_fs]()]s direct Internet access only when you are setting up a test lab environment or when your organization does not have a perimeter network.  
  
For typical corporate networks, an intranet\-facing firewall is established between the corporate network and the perimeter network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this situation, the [!INCLUDE[adfs2_fs]()] sits inside the corporate network, and it is not directly accessible by Internet clients.  
  
> [!NOTE]  
> Client computers that are connected to the corporate network can communicate directly with the [!INCLUDE[adfs2_fs]()] through Windows Integrated Authentication.  
  
A [!INCLUDE[adfs2_fsp]()] should be placed in the perimeter network before you configure your firewall servers for use with [!INCLUDE[nextref_adfs2]()]. For more information, see [Where to Place a Federation Server Proxy]().  
  
## Configuring your firewall servers for a federation server  
So that the [!INCLUDE[adfs2_fs]()]s can communicate directly with [!INCLUDE[adfs2_fs]()] proxies, the intranet firewall server must be configured to allow Secure Hypertext Transfer Protocol \(HTTPS\) traffic from the [!INCLUDE[adfs2_fsp]()] to the [!INCLUDE[adfs2_fs]()]. This is a requirement because the intranet firewall server must publish the [!INCLUDE[adfs2_fs]()] using port 443 so that the [!INCLUDE[adfs2_fsp]()] in the perimeter network can access the [!INCLUDE[adfs2_fs]()].  
  
In addition, the intranet\-facing firewall server, such as a server running Internet Security and Acceleration \(ISA\) Server, uses a process known as server publishing to distribute Internet client requests to the appropriate corporate [!INCLUDE[adfs2_fs]()]s. This means that you must manually create a server publishing rule on the intranet server running ISA Server that publishes the clustered [!INCLUDE[adfs2_fs]()] URL, for example, http:\/\/fs.fabrikam.com.  
  
For more information about how to configure server publishing in a perimeter network, see [Where to Place a Federation Server Proxy](). For information about how to configure ISA Server to publish a server, see Create a secure Web publishing rule \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=75182](http://go.microsoft.com/fwlink/?LinkId=75182)\).  
  

