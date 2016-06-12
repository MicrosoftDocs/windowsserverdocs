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
You can place [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)][!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies in a perimeter network to provide a protection layer against malicious users that may be coming from the Internet. Federation server proxies are ideal for the perimeter network environment because they do not have access to the private keys that are used to create tokens. However, [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies can efficiently route incoming requests to [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s that are authorized to produce those tokens.  
  
It is not necessary to place a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] inside the corporate network for either the account partner or the resource partner because client computers that are connected to the corporate network can communicate directly with the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]. In this scenario, the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] also provides [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] functionality for client computers that are coming from the corporate network.  
  
As is typical with perimeter networks, an intranet\-facing firewall is established between the perimeter network and the corporate network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this scenario, the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] sits between both of these firewalls on the perimeter network.  
  
## Configuring your firewall servers for a federation server proxy  
For the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] redirection process to be successful, all firewall servers must be configured to allow Secure Hypertext Transfer Protocol \(HTTPS\) traffic. The use of HTTPS is required because the firewall servers must publish the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], using port 443, so that the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the perimeter network can access the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the corporate network.  
  
> [!NOTE]  
> All communications to and from client computers also occur over HTTPS.  
  
In addition, the Internet\-facing firewall server, such as a computer running Microsoft Internet Security and Acceleration \(ISA\) Server, uses a process known as server publishing to distribute Internet client requests to the appropriate perimeter and corporate network servers, such as [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies or [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s.  
  
Server publishing rules determine how server publishing works—essentially, filtering all incoming and outgoing requests through the ISA Server computer. Server publishing rules map incoming client requests to the appropriate servers behind the ISA Server computer. For information about how to configure ISA Server to publish a server, see Create a Secure Web Publishing Rule \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=75182](http://go.microsoft.com/fwlink/?LinkId=75182)\).  
  
In the federated world of [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)], these client requests are typically made to a specific URL, for example, a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] identifier URL such as http:\/\/fs.fabrikam.com. Because these client requests come in from the Internet, the Internet\-facing firewall server must be configured to publish the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] identifier URL for each [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] that is deployed in the perimeter network.  
  
### Configuring ISA Server to allow SSL  
To facilitate secure [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] communications, you must configure ISA Server to allow Secure Sockets Layer \(SSL\) communications between the following:  
  
-   **Federation servers and [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies.** An SSL channel is required for all communications between [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s and [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies. Therefore, you must configure ISA Server to allow an SSL connection between the corporate network and the perimeter network.  
  
-   **Client computers, [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s, and [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies.** So that communications can occur between client computers and [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s or between client computers and [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies, you can place a computer running ISA Server in front of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)].  
  
    If your organization performs SSL client authentication on the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], when you place a computer running ISA Server in front of the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], the server must be configured for pass\-through of the SSL connection because the SSL connection must terminate at the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)].  
  
    If your organization does not perform SSL client authentication on the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], an additional option is to terminate the SSL connection at the computer running ISA Server and then re\-establish an SSL connection to the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)].  
  
> [!NOTE]  
> The [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] requires that the connection be secured by SSL to protect the contents of the security token.  
  

