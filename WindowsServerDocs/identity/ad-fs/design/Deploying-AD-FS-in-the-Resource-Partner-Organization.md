---
ms.assetid: 41d6b897-1e72-4522-aad6-eece1154a154
title: Deploying AD FS in the Resource Partner Organization
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Deploying AD FS in the Resource Partner Organization

The resource partner organization in Active Directory Federation Services \(AD FS\) represents the organization whose Web servers may be protected by a resource\-side federation server. The federation server at the resource partner uses the security tokens that are produced by the account partner to provide claims to the Web servers that are located in the resource partner.  
  
In scenarios in which you need to provide access to federated services or applications to many different users—when some users reside in different organizations—you can configure the resource federation server so that you can deploy multiple account partners.  
  
For more information about how to set up and configure a resource partner organization, see [Checklist: Configuring the Resource Partner Organization](../../ad-fs/deployment/Checklist--Configuring-the-Resource-Partner-Organization.md).  
  
## In this section  
  
-   [Review the Role of the Federation Server in the Resource Partner](Review-the-Role-of-the-Federation-Server-in-the-Resource-Partner.md)  
  
-   [Review the Role of the Federation Server Proxy in the Resource Partner](Review-the-Role-of-the-Federation-Server-Proxy-in-the-Resource-Partner.md)  
  
-   [Determine Your Federated Application Strategy in the Resource Partner](Determine-Your-Federated-Application-Strategy-in-the-Resource-Partner.md)  
  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
