---
title: Deploying AD FS in the Resource Partner Organization
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04a57d0c-ec14-4de9-ba92-3f45c45971a0
author: billmath
---
# Deploying AD FS in the Resource Partner Organization
The resource partner organization in [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] represents the organization whose Web servers may be protected by a resource\-side [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]. The [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] at the resource partner uses the security tokens that are produced by the account partner to provide claims to the Web servers that are located in the resource partner.  
  
In scenarios in which you need to provide access to federated services or applications to many different users—when some users reside in different organizations—you can configure the resource [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] so that you can deploy multiple account partners.  
  
For more information about how to set up and configure a resource partner organization, see [Checklist: Configuring the Resource Partner Organization](Checklist--Configuring-the-Resource-Partner-Organization.md).  
  
## In this section  
  
-   [Review the Role of the Federation Server in the Resource Partner](Review-the-Role-of-the-Federation-Server-in-the-Resource-Partner.md)  
  
-   [Review the Role of the Federation Server Proxy in the Resource Partner](Review-the-Role-of-the-Federation-Server-Proxy-in-the-Resource-Partner.md)  
  
-   [Determine Your Federated Application Strategy in the Resource Partner](Determine-Your-Federated-Application-Strategy-in-the-Resource-Partner.md)  
  

