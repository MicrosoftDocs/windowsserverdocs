---
ms.assetid: f88238ea-d851-4129-8b4e-a3a62b813614
title: Review the Role of the Federation Server in the Resource Partner
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
    
# Review the Role of the Federation Server in the Resource Partner

The federation server in the resource partner organization intercepts incoming security tokens that are sent by an account federation server, validates and signs them, and then issues its own security tokens that are destined for the Web\-based application.  
  
> [!NOTE]  
> When federated users use their Web browsers to access Web\-based applications, the federation server in the resource partner organization builds a new authentication cookie and writes it to the browser. This cookie enables single\-sign\-on \(SSO\) capabilities so that users do not have to log on again at the federation server in the account partner when the users attempt to access different Web\-based applications in the resource partner.  
  
In the Web SSO design, at least one federation server must be installed in the perimeter network. In the Federated Web SSO design, there must be at least one federation server installed in the corporate network of the account partner organization and at least one federation server installed in the corporate network of the resource partner organization.  
  
> [!NOTE]  
> Before you can set up a federation server computer in the resource partner organization, you must first join the computer to any Active Directory domain in the resource partner organization. For more information, see [Checklist: Setting Up a Federation Server](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server.md).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

