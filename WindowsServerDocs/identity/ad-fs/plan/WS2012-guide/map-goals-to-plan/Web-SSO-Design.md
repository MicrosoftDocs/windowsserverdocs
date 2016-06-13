---
title: Web SSO Design
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 076da5cd-c988-4e5c-bd09-6b60f421ae3f
author: billmath
---
# Web SSO Design
In the Web Single\-Sign\-On \(SSO\) design in Active Directory Federation Services \(AD FS\), users must authenticate only once to access multiple AD FS\-secured applications or services. In this design all users are external, and no federation trust exists because there are no partner organizations. Typically, you deploy this design when you want to provide individual consumer or customer access to one or more AD FS–secured services or applications over the Internet, as shown in the following illustration.  
  
![](../../../../media/Web-SSO-Design/adfs2_WebSSODesign.gif)  
  
With the Web SSO design, an organization that typically hosts an AD FS\-secured application or service in a perimeter network can maintain a separate store of customer accounts in the perimeter network, which makes it easier to isolate customer accounts from employee accounts.  
  
You can manage the local accounts for customers in the perimeter network by using either Active Directory Domain Services \(AD DS\), SQL Server, or a custom attribute store.  
  
This design coincides with the deployment goal in [Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](../../../../ad-fs/plan/WS2012-guide/goals/Provide-Your-Active-Directory-Users-Access-to-Your-Claims-Aware-Applications-and-Services.md).  
  
For a list of detailed tasks that you can use to plan and deploy your Web SSO design, see [Checklist: Implementing a Web SSO Design](Checklist--Implementing-a-Web-SSO-Design.md).  
  

