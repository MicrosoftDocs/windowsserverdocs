---
title: Where to Place a Federation Server Proxy
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4df7aa68-95da-455b-89e6-ecae00811362
author: billmath
---
# Where to Place a Federation Server Proxy
You can place [!INCLUDE[firstref_adfs2]()][!INCLUDE[adfs2_fs]()] proxies in a perimeter network to provide a protection layer against malicious users that may be coming from the Internet. Federation server proxies are ideal for the perimeter network environment because they do not have access to the private keys that are used to create tokens. However, [!INCLUDE[adfs2_fs]()] proxies can efficiently route incoming requests to [!INCLUDE[adfs2_fs]()]s that are authorized to produce those tokens.  
  
It is not necessary to place a [!INCLUDE[adfs2_fsp]()] inside the corporate network for either the account partner or the resource partner because client computers that are connected to the corporate network can communicate directly with the [!INCLUDE[adfs2_fs]()]. In this scenario, the [!INCLUDE[adfs2_fs]()] also provides [!INCLUDE[adfs2_fsp]()] functionality for client computers that are coming from the corporate network.  
  
As is typical with perimeter networks, an intranet\-facing firewall is established between the perimeter network and the corporate network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this scenario, the [!INCLUDE[adfs2_fsp]()] sits between both of these firewalls on the perimeter network.  
  
## Configuring your firewall servers for a federation server proxy  
For the [!INCLUDE[adfs2_fsp]()] redirection process to be successful, all firewall servers must be configured to allow Secure Hypertext Transfer Protocol \(HTTPS\) traffic. The use of HTTPS is required because the firewall servers must publish the [!INCLUDE[adfs2_fsp]()], using port 443, so that the [!INCLUDE[adfs2_fsp]()] in the perimeter network can access the [!INCLUDE[adfs2_fs]()] in the corporate network.  
  
> [!NOTE]  
> All communications to and from client computers also occur over HTTPS.  
  
In addition, the Internet\-facing firewall server, such as a computer running Microsoft Internet Security and Acceleration \(ISA\) Server, uses a process known as server publishing to distribute Internet client requests to the appropriate perimeter and corporate network servers, such as [!INCLUDE[adfs2_fs]()] proxies or [!INCLUDE[adfs2_fs]()]s.  
  
Server publishing rules determine how server publishing works—essentially, filtering all incoming and outgoing requests through the ISA Server computer. Server publishing rules map incoming client requests to the appropriate servers behind the ISA Server computer. For information about how to configure ISA Server to publish a server, see Create a Secure Web Publishing Rule \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=75182](http://go.microsoft.com/fwlink/?LinkId=75182)\).  
  
In the federated world of [!INCLUDE[nextref_adfs2]()], these client requests are typically made to a specific URL, for example, a [!INCLUDE[adfs2_fs]()] identifier URL such as http:\/\/fs.fabrikam.com. Because these client requests come in from the Internet, the Internet\-facing firewall server must be configured to publish the [!INCLUDE[adfs2_fs]()] identifier URL for each [!INCLUDE[adfs2_fsp]()] that is deployed in the perimeter network.  
  
### Configuring ISA Server to allow SSL  
To facilitate secure [!INCLUDE[nextref_adfs2]()] communications, you must configure ISA Server to allow Secure Sockets Layer \(SSL\) communications between the following:  
  
-   **Federation servers and [!INCLUDE[adfs2_fs]()] proxies.** An SSL channel is required for all communications between [!INCLUDE[adfs2_fs]()]s and [!INCLUDE[adfs2_fs]()] proxies. Therefore, you must configure ISA Server to allow an SSL connection between the corporate network and the perimeter network.  
  
-   **Client computers, [!INCLUDE[adfs2_fs]()]s, and [!INCLUDE[adfs2_fs]()] proxies.** So that communications can occur between client computers and [!INCLUDE[adfs2_fs]()]s or between client computers and [!INCLUDE[adfs2_fs]()] proxies, you can place a computer running ISA Server in front of the [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()].  
  
    If your organization performs SSL client authentication on the [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()], when you place a computer running ISA Server in front of the [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()], the server must be configured for pass\-through of the SSL connection because the SSL connection must terminate at the [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()].  
  
    If your organization does not perform SSL client authentication on the [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()], an additional option is to terminate the SSL connection at the computer running ISA Server and then re\-establish an SSL connection to the [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()].  
  
> [!NOTE]  
> The [!INCLUDE[adfs2_fs]()] or [!INCLUDE[adfs2_fsp]()] requires that the connection be secured by SSL to protect the contents of the security token.  
  

