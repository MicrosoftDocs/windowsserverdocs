---
ms.assetid: 1b3a03c0-5558-4177-9b2f-e9d6ce3271cd
title: Review the Role of the Federation Server Proxy in the Account Partner
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Review the Role of the Federation Server Proxy in the Account Partner

The primary role of the federation server proxy in the perimeter network of the account partner organization in Active Directory Federation Services \(AD FS\) is to collect authentication credentials from a client computer that logs on over the Internet and to pass those credentials to the federation server, which is located inside the corporate network of the account partner organization. The account for the client computer is stored in the account partner’s attribute store.  
  
A federation server proxy can also function in one or more of the following roles, depending on how you configure it to meet the needs of the account partner organization:  
  
-   Relay Security Tokens—The federation server issues a security token to the federation server proxy, which then relays the token to the client computer. The security token is used to provide access for that client computer to a specific relying party.  
  
-   Collect Credentials—The federation server proxy uses a default client logon Web form \(clientlogon.aspx\) to collect password\-based credentials through forms\-based authentication. However, you can customize this form to accept other supported types of authentication, such as Secure Sockets Layer \(SSL\) client authentication. For more information about how to customize this page, see Customizing Client Logon and Home Realm Discovery Pages \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=104275](https://go.microsoft.com/fwlink/?LinkId=104275)\). A federation server proxy does not accept credentials through Windows Integrated Authentication.  
  
To summarize, a federation server proxy in the account partner acts as a proxy for client logons to a federation server that is located in the corporate network. The federation server proxy also facilitates the distribution of security tokens to Internet clients that are destined for relying parties.  
  
> [!CAUTION]  
> Exposing a federation server proxy on the account partner extranet will the client logon Web form accessible by anyone with Internet access. This can potentially leave your organization vulnerable to some password\-based attacks, such as dictionary attacks or brute force attacks that can trigger account lockouts for user accounts that are stored in the corporate Active Directory Domain Services \(AD DS\).  
  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
