---
title: Implementing Your AD FS Design Plan
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cf5b857e-e54c-4d2d-88a1-43cbaaf1d133
author: billmath
---
# Implementing Your AD FS Design Plan
The following environmental conditions and requirements are important factors in the implementation of your [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] design plan:  
  
-   **Supported partners:** You usually use AD FS to work with partner organizations. To establish identity federation, determine the organizations with which you want to form a partnership. After a baseline [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment is in place, operating with partners involves adding partners, deleting partners, and updating partner information. Changes to partnerships may occur for a variety of reasons. For example, your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment might require partnership updates if your partner changes its business significantly, your organization becomes part of a larger organization or a federation of organizations, or your organization is acquired by a different company. In any scenario in which you federate identities from multiple domains, you will need to know the domains \(partners\) that you are currently supporting and all the additional domains that represent potential partners.  
  
-   **Supported application and service types:** Some applications and services require access to operating system resources, while others are "claims aware." It is important to understand the types of applications and services that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] supports so that you can formulate administration requirements.  
  
-   **Logical and physical architectural diagrams or deployment topology:** You will need to know:  
  
    -   Whether [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s will function in a set of farmed servers or on a single server.  
  
    -   Where your network deploys firewalls and proxies.  
  
    -   The location of resources and whether users are accessing resources from within your organization, outside the organization, or both.  
  
## How to implement your AD FS design using this guide  
The next step in implementing your design is to determine in what order each deployment task must be performed. This guide uses checklists to help you walk through the various server and application deployment tasks that are required to implement your design plan. Parent and child checklists are used as necessary to represent the order in which tasks for a specific [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design must be processed.  
  
Use the following parent checklists in this section of the guide to become familiar with the deployment tasks for implementing your organization's preferred [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design:  
  
-   [Checklist: Implementing a Web SSO Design](../Topic/Checklist--Implementing-a-Web-SSO-Design.md)  
  
-   [Checklist: Implementing a Federated Web SSO Design](../Topic/Checklist--Implementing-a-Federated-Web-SSO-Design.md)  
  
