---
ms.assetid: 68979914-8a1c-465a-bd37-08df30722d69
title: Mapping Your Deployment Goals to an AD FS Design
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Mapping Your Deployment Goals to an AD FS Design


After you finish reviewing the existing Active Directory Federation Services \(AD FS\) deployment goals and you determine which goals are related to your deployment, you can map those goals to a specific AD FS design. For more information about AD FS predefined deployment goals, see [Identifying Your AD FS Deployment Goals](Identifying-Your-AD-FS-Deployment-Goals.md).  
  
Use the following table to determine which AD FS design maps to the appropriate combination of AD FS deployment goals for your organization. This table refers only to the two primary AD FS designs, as described in this guide. However, you can create a hybrid or custom AD FS design by using any combination of the AD FS deployment goals to meet the needs of your organization.  
  
|AD FS deployment goal|[Web SSO Design](Web-SSO-Design.md)|[Federated Web SSO Design](Federated-Web-SSO-Design.md)|  
|---------------------------------------------------------------------------|----------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|  
|[Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](Provide-Your-Active-Directory-Users-Access-to-Your-Claims-Aware-Applications-and-Services.md)|No|Yes, in the account partner|  
|[Provide Your Active Directory Users Access to the Applications and Services of Other Organizations](Provide-Your-Active-Directory-Users-Access-to-the-Applications-and-Services-of-Other-Organizations.md)|No|Yes, optional in the account partner|  
|[Provide Users in Another Organization Access to Your Claims-Aware Applications and Services](Provide-Users-in-Another-Organization-Access-to-Your-Claims-Aware-Applications-and-Services.md)|Yes|Yes|  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
  

