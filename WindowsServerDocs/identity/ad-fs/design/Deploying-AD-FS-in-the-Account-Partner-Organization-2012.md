---
ms.assetid: 9aaca9c5-ce44-495c-aad6-61aede87a83f
title: Deploying AD FS in the Account Partner Organization
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Deploying AD FS in the Account Partner Organization

An account partner in Active Directory Federation Services \(AD FS\) represents the organization in the federation trust relationship that physically stores user accounts in a supported attribute store. For more information about which attribute stores are supported, see [The Role of Attribute Stores](../../ad-fs/technical-reference/The-Role-of-Attribute-Stores.md).  
  
The federation server in the account partner organization authenticates local users and creates security tokens that are used by the resource partner in making authorization decisions. Relying parties such as Web sites and Web services are then able to easily register themselves with the federation server and consume issued tokens for authentication and access control.  
  
In scenarios in which you need to provide your users with access to multiple federated applications or services—when each application or service is hosted by a different organization—you can configure the account partner federation server so that you can deploy multiple relying parties.  
  
For more information about how to set up and configure an account partner organization, see [Checklist: Configuring the Account Partner Organization](../../ad-fs/deployment/Checklist--Configuring-the-Account-Partner-Organization.md).  
  
## In this section  
  
-   [Review the Role of the Federation Server in the Account Partner](Review-the-Role-of-the-Federation-Server-in-the-Account-Partner.md)  
  
-   [Review the Role of the Federation Server Proxy in the Account Partner](Review-the-Role-of-the-Federation-Server-Proxy-in-the-Account-Partner.md)  
  
-   [Prepare Client Computers in the Account Partner](Prepare-Client-Computers-in-the-Account-Partner.md)  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
