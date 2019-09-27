---
ms.assetid: 09f335bb-896a-45dd-adc2-f215b8fba828
title: Federated Web SSO Design
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Federated Web SSO Design

The Federated Web Single\-Sign\-On \(SSO\) design in Active Directory Federation Services \(AD FS\) involves secure communication that spans multiple firewalls, perimeter networks, and name\-resolution servers—in addition to the entire Internet routing infrastructure.  
  
Typically, this design is used when two organizations agree to create a federation trust relationship to allow users in one organization \(the account partner organization\) to access Web\-based applications or services, which are secured by AD FS, in the other organization \(the resource partner organization\).  
  
In other words, a federation trust relationship is the embodiment of a business\-level agreement or partnership between two organizations. As shown in the following illustration, you can establish a federation trust relationship between two businesses, which results in an end\-to\-end federation scenario.  
  
![federated web sso](media/adfs2_FederatedWebSSODesign.gif)  
  
The one\-way arrow in the illustration signifies the direction of the federation trust, which—like the direction of Windows trusts—always points to the account side of the forest. This means that authentication flows from the account partner organization to the resource partner organization.  
  
In this Federated Web SSO design, two federation servers \(one in Fabrikam and the other in Contoso\) route authentication requests from user accounts in Fabrikam to Web\-based applications or services in Contoso.  
  
> [!NOTE]  
> For additional security, you can use federation server proxies to relay requests to federation servers that are not directly accessible from the Internet.  
  
In this example, Fabrikam is the identity, or account, provider. The Fabrikam portion of the Federated Web SSO design uses the following AD FS deployment goal:  
  
-   [Provide Your Active Directory Users Access to the Applications and Services of Other Organizations](Provide-Your-Active-Directory-Users-Access-to-the-Applications-and-Services-of-Other-Organizations.md)  
  
Contoso is the resource provider. The Contoso portion of the Federated Web SSO design achieves the following AD FS deployment goals:  
  
-   [Provide Users in Another Organization Access to Your Claims-Aware Applications and Services](Provide-Users-in-Another-Organization-Access-to-Your-Claims-Aware-Applications-and-Services.md)  
  
-   [Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](Provide-Your-Active-Directory-Users-Access-to-Your-Claims-Aware-Applications-and-Services.md)  
  
For a list of detailed tasks that you can use to plan and deploy the Federated Web SSO design, see [Checklist: Implementing a Federated Web SSO Design](../../ad-fs/deployment/Checklist--Implementing-a-Federated-Web-SSO-Design.md).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
