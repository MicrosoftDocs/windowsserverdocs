---
title: Mapping Your Deployment Goals to an AD FS Design
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39447336-ecd4-4f5e-bbc5-4bde64c1a8ef
author: billmath
---
# Mapping Your Deployment Goals to an AD FS Design
After you finish reviewing the existing [!INCLUDE[firstref_adfs2]()] deployment goals and you determine which goals are related to your deployment, you can map those goals to a specific [!INCLUDE[nextref_adfs2]()] design. For more information about [!INCLUDE[nextref_adfs2]()] predefined deployment goals, see [Identifying Your AD FS Deployment Goals](../../../active-directory-federation-services/plan/WS2012-guide/Identifying-Your-AD-FS-Deployment-Goals.md).  
  
Use the following table to determine which [!INCLUDE[nextref_adfs2]()] design maps to the appropriate combination of [!INCLUDE[nextref_adfs2]()] deployment goals for your organization. This table refers only to the two primary [!INCLUDE[nextref_adfs2]()] designs, as described in this guide. However, you can create a hybrid or custom [!INCLUDE[nextref_adfs2]()] design by using any combination of the [!INCLUDE[nextref_adfs2]()] deployment goals to meet the needs of your organization.  
  
|[!INCLUDE[nextref_adfs2]()] deployment goal|[Web SSO Design]()|[Federated Web SSO Design]()|  
|---------------------------------------------------------------------------|----------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|  
|[Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services]()|No|Yes, in the account partner|  
|[Provide Your Active Directory Users Access to the Applications and Services of Other Organizations]()|No|Yes, optional in the account partner|  
|[Provide Users in Another Organization Access to Your Claims-Aware Applications and Services]()|Yes|Yes|  
  

