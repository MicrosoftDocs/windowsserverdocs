---
title: Configuring Partner Organizations
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 43e77be3-e691-48ca-966e-3bccf4b26802
author: billmath
---
# Configuring Partner Organizations
To deploy a new partner organization in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], complete the tasks in either [Checklist: Configuring the Resource Partner Organization](../Topic/Checklist--Configuring-the-Resource-Partner-Organization.md) or [Checklist: Configuring the Account Partner Organization](../Topic/Checklist--Configuring-the-Account-Partner-Organization.md), depending on your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design.  
  
> [!NOTE]  
> When you use either of these checklists, we strongly recommend that you first read the references to account partner or resource partner planning guidance \(in the [AD FS Design Guide in Windows Server 2012](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012.md)\) before continuing to the procedures for setting up the new partner organization. Following the checklist in this way will help provide a better understanding of the full [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design and deployment story for the account partner or resource partner organization.  
  
## About account partner organizations  
An account partner is the organization in the federation trust relationship that physically stores user accounts in an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]–supported attribute store. The account partner is responsible for collecting and authenticating a user's credentials, building up claims for that user, and packaging the claims into security tokens. These tokens can then be presented across a federation trust to enable access to Web\-based resources that are located in the resource partner organization.  
  
In other words, an account partner represents the organization for whose users the account\-side [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] issues security tokens. The [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the account partner organization authenticates local users and creates security tokens that the resource partner uses in making authorization decisions.  
  
With regard to attribute stores, the account partner in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is conceptually equivalent to a single Active Directory forest whose accounts need access to resources that are physically located in another forest. Accounts in this forest can access resources in the resource forest only when an external trust or forest trust relationship exists between the two forests and the resources to which the users are trying to gain access have been set with the proper authorization permissions.  
  
## About resource partner organizations  
The resource partner is the organization in an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment where Web servers are located. The resource partner trusts the account partner to authenticate users. Therefore, to make authorization decisions, the resource partner consumes the claims that are packaged in security tokens that come from users in the account partner.  
  
In other words, a resource partner represents the organization whose Web servers are protected by the resource\-side [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. The [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] at the resource partner uses the security tokens that are produced by the account partner to make authorization decisions for Web servers in the resource partner.  
  
To function as an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] resource, Web servers in the resource partner organization must either have [!INCLUDE[firstref_idfx](../Token/firstref_idfx_md.md)] installed or have the Active Directory Federation Services \(AD FS\) 1.x Claims\-Aware Web Agent role services installed. Web servers that function as an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] resource can host either Web\-browser\-based or Web\-service\-based applications.  
  
