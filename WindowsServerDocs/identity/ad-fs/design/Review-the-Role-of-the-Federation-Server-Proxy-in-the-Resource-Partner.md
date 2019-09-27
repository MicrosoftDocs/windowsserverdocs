---
ms.assetid: 14aa112d-ae31-4181-97e4-92623b5c9270
title: Review the Role of the Federation Server Proxy in the Resource Partner
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Review the Role of the Federation Server Proxy in the Resource Partner

A federation server proxy in Active Directory Federation Services \(AD FS\) can function in one or more of the following roles, depending on how you configure the server to meet the needs of the resource partner organization:  
  
-   **Account partner discovery**: An Internet client computer must identify which account partner will authenticate it. The client finds the account partner by using an account partner discovery Web form \(discoverclientrealm.aspx\), which is stored on the federation server proxy in the resource partner. If more than one account partner is configured in the AD FS Management snap\-in, a drop\-down menu appears to the client with all the available account partners that are visible to Internet client computers that access the account partner discovery Web form. You can change how the account partner discovery Web form is presented to client computers by customizing the discoverclientrealm.aspx file.  
  
-   **Security token redirection**: The federation server proxy in the account partner sends the security tokens to the resource partner. The resource federation server proxy accepts these tokens and passes them on to the federation server in the resource partner. The resource federation server then issues a security token that is bound for a specific resource Web server. The resource federation server proxy then redirects the token to the client.  
  
To summarize, a resource federation server proxy facilitates the federated logon process by redirecting client computers to a federation server that can authenticate the clients. A resource federation server proxy also acts as a proxy for client security tokens to resource federation servers.  
  
> [!NOTE]  
> When it is necessary to help reduce the amount of hardware and the number of required certificates, the federation server proxy can be located on the same computer as the Web server.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

