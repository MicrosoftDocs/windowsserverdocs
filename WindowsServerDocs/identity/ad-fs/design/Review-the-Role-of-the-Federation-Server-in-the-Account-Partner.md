---
ms.assetid: d0ba3c0d-869f-4e24-89d7-499da7576f22
title: Review the Role of the Federation Server in the Account Partner
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Review the Role of the Federation Server in the Account Partner

A federation server in Active Directory Federation Services \(AD FS\) functions as a security token issuer. A federation server generates claims based on account values that reside in a local attribute store and packages them into security tokens so that users can seamlessly access Web\-browser\-based applications \(using single sign\-on \(SSO\)\) that are hosted in a resource partner organization.  
  
> [!NOTE]  
> When your users access federated applications by using a Web browser, a federation server automatically issues cookies to the users to maintain their logon status for that Web\-browser\-based application. These cookies include claims for the users. The cookies enable SSO capabilities so that the users do not have to enter credentials each time that they visit different Web\-browser\-based applications in the resource partner.  
  
In the Web SSO design, organizations with a perimeter network that want Internet users to have access to applications must install a federation server proxy in the perimeter network. In the Federated Web SSO design, there must be at least one federation server installed in the corporate network of the account partner organization and at least one federation server installed in the corporate network of the resource partner organization.  
  
> [!NOTE]  
> Before you can set up a federation server computer in the account partner organization, you must first join the computer to any domain in the Active Directory forest where the federation server will be used to authenticate users from that forest. For more information, see [Checklist: Setting Up a Federation Server](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server.md).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
