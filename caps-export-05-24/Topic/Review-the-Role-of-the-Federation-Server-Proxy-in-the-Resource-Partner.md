---
title: Review the Role of the Federation Server Proxy in the Resource Partner
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ee0ae90-5ae6-4f02-a12a-e5c185c09a0f
author: billmath
---
# Review the Role of the Federation Server Proxy in the Resource Partner
A [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] can function in one or more of the following roles, depending on how you configure the server to meet the needs of the resource partner organization:  
  
-   **Account partner discovery**: An Internet client computer must identify which account partner will authenticate it. The client finds the account partner by using an account partner discovery Web form \(discoverclientrealm.aspx\), which is stored on the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in the resource partner. If more than one account partner is configured in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in, a drop\-down menu appears to the client with all the available account partners that are visible to Internet client computers that access the account partner discovery Web form. You can change how the account partner discovery Web form is presented to client computers by customizing the discoverclientrealm.aspx file.  
  
-   **Security token redirection**: The [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in the account partner sends the security tokens to the resource partner. The resource [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] accepts these tokens and passes them on to the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the resource partner. The resource [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] then issues a security token that is bound for a specific resource Web server. The resource [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] then redirects the token to the client.  
  
To summarize, a resource [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] facilitates the federated logon process by redirecting client computers to a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] that can authenticate the clients. A resource [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] also acts as a proxy for client security tokens to resource [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s.  
  
> [!NOTE]  
> When it is necessary to help reduce the amount of hardware and the number of required certificates, the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] can be located on the same computer as the Web server.  
  
