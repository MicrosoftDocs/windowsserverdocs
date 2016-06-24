---
title: Review the Role of the Federation Server in the Resource Partner
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a050121-74e5-4fcd-8ff3-6d1e381495f3
author: billmath
---
# Review the Role of the Federation Server in the Resource Partner
The [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the resource partner organization intercepts incoming security tokens that are sent by an account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)], validates and signs them, and then issues its own security tokens that are destined for the Web-based application.  
  
> [!NOTE]  
> When federated users use their Web browsers to access Web-based applications, the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the resource partner organization builds a new authentication cookie and writes it to the browser. This cookie enables single-sign-on (SSO) capabilities so that users do not have to log on again at the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the account partner when the users attempt to access different Web-based applications in the resource partner.  
  
In the Web SSO design, at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] must be installed in the perimeter network. In the Federated Web SSO design, there must be at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] installed in the corporate network of the account partner organization and at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] installed in the corporate network of the resource partner organization.  
  
> [!NOTE]  
> Before you can set up a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] computer in the resource partner organization, you must first join the computer to any Active Directory domain in the resource partner organization. For more information, see [Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md).  
  

