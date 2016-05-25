---
title: Review the Role of the Federation Server Proxy in the Account Partner
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a602ec98-4f79-415e-8f2c-ef775e0bcc6a
author: billmath
---
# Review the Role of the Federation Server Proxy in the Account Partner
The primary role of the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the perimeter network of the account partner organization in [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] is to collect authentication credentials from a client computer that logs on over the Internet and to pass those credentials to the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)], which is located inside the corporate network of the account partner organization. The account for the client computer is stored in the account partner’s attribute store.  
  
A [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] can also function in one or more of the following roles, depending on how you configure it to meet the needs of the account partner organization:  
  
-   Relay Security Tokens—The [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] issues a security token to the [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)], which then relays the token to the client computer. The security token is used to provide access for that client computer to a specific relying party.  
  
-   Collect Credentials—The [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] uses a default client logon Web form \(clientlogon.aspx\) to collect password\-based credentials through forms\-based authentication. However, you can customize this form to accept other supported types of authentication, such as Secure Sockets Layer \(SSL\) client authentication. For more information about how to customize this page, see Customizing Client Logon and Home Realm Discovery Pages \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=104275](http://go.microsoft.com/fwlink/?LinkId=104275)\). A [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] does not accept credentials through Windows Integrated Authentication.  
  
To summarize, a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the account partner acts as a proxy for client logons to a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] that is located in the corporate network. The [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] also facilitates the distribution of security tokens to Internet clients that are destined for relying parties.  
  
> [!CAUTION]  
> Exposing a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] on the account partner extranet will the client logon Web form accessible by anyone with Internet access. This can potentially leave your organization vulnerable to some password\-based attacks, such as dictionary attacks or brute force attacks that can trigger account lockouts for user accounts that are stored in the corporate Active Directory Domain Services \(AD DS\).  
  

