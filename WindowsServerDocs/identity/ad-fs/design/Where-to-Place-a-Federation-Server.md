---
ms.assetid: 935ea7c2-4678-4033-b50f-2036a0359c5d
title: Where to Place a Federation Server
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Where to Place a Federation Server

As a security best practice, place Active Directory Federation Services \(AD FS\)federation servers in front of a firewall and connect them to your corporate network to prevent exposure from the Internet. This is important because federation servers have full authorization to grant security tokens. Therefore, they should have the same protection as a domain controller. If a federation server is compromised, a malicious user has the ability to issue full access tokens to all Web applications and to federation servers that are protected by Active Directory Federation Services \(AD FS\) in all resource partner organizations.  
  
> [!NOTE]  
> As a security best practice, avoid having your federation servers directly accessible on the Internet. Consider giving your federation servers direct Internet access only when you are setting up a test lab environment or when your organization does not have a perimeter network.  
  
For typical corporate networks, an intranet\-facing firewall is established between the corporate network and the perimeter network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this situation, the federation server sits inside the corporate network, and it is not directly accessible by Internet clients.  
  
> [!NOTE]  
> Client computers that are connected to the corporate network can communicate directly with the federation server through Windows Integrated Authentication.  
  
A federation server proxy should be placed in the perimeter network before you configure your firewall servers for use with AD FS. For more information, see [Where to Place a Federation Server Proxy](Where-to-Place-a-Federation-Server-Proxy.md).  
  
## Configuring your firewall servers for a federation server  
So that the federation servers can communicate directly with federation server proxies, the intranet firewall server must be configured to allow Secure Hypertext Transfer Protocol \(HTTPS\) traffic from the federation server proxy to the federation server. This is a requirement because the intranet firewall server must publish the federation server using port 443 so that the federation server proxy in the perimeter network can access the federation server.  
  
In addition, the intranet\-facing firewall server, such as a server running Internet Security and Acceleration \(ISA\) Server, uses a process known as server publishing to distribute Internet client requests to the appropriate corporate federation servers. This means that you must manually create a server publishing rule on the intranet server running ISA Server that publishes the clustered federation server URL, for example, http:\/\/fs.fabrikam.com.  
  
For more information about how to configure server publishing in a perimeter network, see [Where to Place a Federation Server Proxy](Where-to-Place-a-Federation-Server-Proxy.md). For information about how to configure ISA Server to publish a server, see [Create a secure Web publishing rule](https://go.microsoft.com/fwlink/?LinkId=75182).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
