---
title: Review the Role of the Federation Server in the Account Partner
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bdcc6ce5-4c42-4d1a-b4c3-869b6cffff23
author: billmath
---
# Review the Role of the Federation Server in the Account Partner
A [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] functions as a security token issuer. A [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] generates claims based on account values that reside in a local attribute store and packages them into security tokens so that users can seamlessly access Web-browser-based applications (using single sign-on (SSO)) that are hosted in a resource partner organization.  
  
> [!NOTE]  
> When your users access federated applications by using a Web browser, a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] automatically issues cookies to the users to maintain their logon status for that Web-browser-based application. These cookies include claims for the users. The cookies enable SSO capabilities so that the users do not have to enter credentials each time that they visit different Web-browser-based applications in the resource partner.  
  
In the Web SSO design, organizations with a perimeter network that want Internet users to have access to applications must install a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] in the perimeter network. In the Federated Web SSO design, there must be at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] installed in the corporate network of the account partner organization and at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] installed in the corporate network of the resource partner organization.  
  
> [!NOTE]  
> Before you can set up a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] computer in the account partner organization, you must first join the computer to any domain in the Active Directory forest where the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] will be used to authenticate users from that forest. For more information, see [Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md).  
  

