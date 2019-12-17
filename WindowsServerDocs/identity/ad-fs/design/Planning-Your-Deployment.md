---
ms.assetid: bb9b9e18-bf2f-4115-be77-9a165944db41
title: Planning Your Deployment
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Planning Your Deployment

When you plan for cross\-organizational \(federation\-based\) collaboration using Active Directory Federation Services \(AD FS\), first determine if your organization will host a Web resource to be accessed by other organizations across the Internet or if you will provide access to the Web resource for employees in your organization. This determination affects how you deploy AD FS, and it is fundamental in the planning of your AD FS infrastructure.  
  
> [!NOTE]  
> Make sure that the role that organization plays in the federation agreement is clearly understood by all parties.  
  
For the [Federated Web SSO Design](Federated-Web-SSO-Design.md), AD FS uses terms such as *account partner* \(also referred to as *identity provider* in the AD FS Management snap\-in\) and *resource partner* \(also referred to as *relying party* in the AD FS Management snap\-in\) to help differentiate the organization that hosts the accounts \(the account partner\) from the organization that hosts the Web\-based resources \(the resource partner\).  
  
In the [Web SSO Design](Web-SSO-Design.md), the organization acts in both the account partner and resource partner roles because it is providing its users with access to its applications.  
  
The following topics explain some of the AD FS partner organization concepts. They also contain links to topics in the AD FS Deployment Guide that contain information about setting up and configuring account partner organizations and resource partner organizations based on your AD FS deployment goals.  
  
## In this section  
  
-   [Best Practices for Secure Planning and Deployment of AD FS](Best-Practices-for-Secure-Planning-and-Deployment-of-AD-FS.md)  
  
-   [Planning for Interoperability with AD FS 1.x](Planning-for-Interoperability-with-AD-FS-1.x.md)  
  
-   [When to Use Identity Delegation](When-to-Use-Identity-Delegation.md)  
  
-   [Deploying AD FS in the Account Partner Organization](Deploying-AD-FS-in-the-Account-Partner-Organization-2012.md)  
  
-   [Deploying AD FS in the Resource Partner Organization](Deploying-AD-FS-in-the-Resource-Partner-Organization-2012.md)  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)


