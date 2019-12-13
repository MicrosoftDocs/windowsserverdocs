---
ms.assetid: ec26705c-4446-4226-b9b4-b775b642f0f4
title: Where to Place a Federation Server Proxy
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Where to Place a Federation Server Proxy

You can place Active Directory Federation Services \(AD FS\)federation server proxies in a perimeter network to provide a protection layer against malicious users that may be coming from the Internet. Federation server proxies are ideal for the perimeter network environment because they do not have access to the private keys that are used to create tokens. However, federation server proxies can efficiently route incoming requests to federation servers that are authorized to produce those tokens.  
  
It is not necessary to place a federation server proxy inside the corporate network for either the account partner or the resource partner because client computers that are connected to the corporate network can communicate directly with the federation server. In this scenario, the federation server also provides federation server proxy functionality for client computers that are coming from the corporate network.  
  
As is typical with perimeter networks, an intranet\-facing firewall is established between the perimeter network and the corporate network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this scenario, the federation server proxy sits between both of these firewalls on the perimeter network.  
  
## Configuring your firewall servers for a federation server proxy  
For the federation server proxy redirection process to be successful, all firewall servers must be configured to allow Secure Hypertext Transfer Protocol \(HTTPS\) traffic. The use of HTTPS is required because the firewall servers must publish the federation server proxy, using port 443, so that the federation server proxy in the perimeter network can access the federation server in the corporate network.  
  
> [!NOTE]  
> All communications to and from client computers also occur over HTTPS.  
  
In addition, the Internet\-facing firewall server, such as a computer running Microsoft Internet Security and Acceleration \(ISA\) Server, uses a process known as server publishing to distribute Internet client requests to the appropriate perimeter and corporate network servers, such as federation server proxies or federation servers.  
  
Server publishing rules determine how server publishing works—essentially, filtering all incoming and outgoing requests through the ISA Server computer. Server publishing rules map incoming client requests to the appropriate servers behind the ISA Server computer. For information about how to configure ISA Server to publish a server, see [Create a Secure Web Publishing Rule](https://go.microsoft.com/fwlink/?LinkId=75182).  
  
In the federated world of AD FS, these client requests are typically made to a specific URL, for example, a federation server identifier URL such as http:\//fs.fabrikam.com. Because these client requests come in from the Internet, the Internet\-facing firewall server must be configured to publish the federation server identifier URL for each federation server proxy that is deployed in the perimeter network.  
  
### Configuring ISA Server to allow SSL  
To facilitate secure AD FS communications, you must configure ISA Server to allow Secure Sockets Layer \(SSL\) communications between the following:  
  
-   **Federation servers and federation server proxies.** An SSL channel is required for all communications between federation servers and federation server proxies. Therefore, you must configure ISA Server to allow an SSL connection between the corporate network and the perimeter network.  
  
-   **Client computers, federation servers, and federation server proxies.** So that communications can occur between client computers and federation servers or between client computers and federation server proxies, you can place a computer running ISA Server in front of the federation server or federation server proxy.  
  
    If your organization performs SSL client authentication on the federation server or federation server proxy, when you place a computer running ISA Server in front of the federation server or federation server proxy, the server must be configured for pass\-through of the SSL connection because the SSL connection must terminate at the federation server or federation server proxy.  
  
    If your organization does not perform SSL client authentication on the federation server or federation server proxy, an additional option is to terminate the SSL connection at the computer running ISA Server and then re\-establish an SSL connection to the federation server or federation server proxy.  
  
> [!NOTE]  
> The federation server or federation server proxy requires that the connection be secured by SSL to protect the contents of the security token.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
