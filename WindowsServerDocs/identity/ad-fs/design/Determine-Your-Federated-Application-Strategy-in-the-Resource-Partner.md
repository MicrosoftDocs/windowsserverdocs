---
ms.assetid: 9eab8c43-a0f2-4d19-a5a4-e1399f0d5f25
title: Determine Your Federated Application Strategy in the Resource Partner
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Determine Your Federated Application Strategy in the Resource Partner

An important part of designing a new Active Directory Federation Services \(AD FS\) infrastructure in the resource partner organization is determining your full set of applications and services that will be used to participate in the federation and which account partners will be the recipients of those resources. Before you design a federated application and services strategy, consider the following questions:  
  
-   Will you be enabling and deploying an ASP.NET application or a Windows Communication Foundation \(WCF\) service for federation?  
  
-   Will users on your corporate network require access to the federated application or service through Windows Integrated Authentication?  
  
-   Will the federated application or service be used by users in your perimeter network? If so, will Windows Integrated Authentication be required?  
  
-   Are all of the Web servers that host federated applications running a Windows Server operating system and Internet Information Services \(IIS\)?  
  
-   Who will the federated application or service provide resources for?  
  
Answering these questions will help you plan a solid AD FS design. It will also assist you in creating a federated application and services strategy that is cost effective and resource efficient. For more information about designing the most appropriate federated application and services strategy for your organization, see the following topics in this guide:  
  
-   [Provide Your Active Directory Users Access to Your Claims-Aware Applications and Services](Provide-Your-Active-Directory-Users-Access-to-Your-Claims-Aware-Applications-and-Services.md)  
  
-   [Provide Your Active Directory Users Access to the Applications and Services of Other Organizations](Provide-Your-Active-Directory-Users-Access-to-the-Applications-and-Services-of-Other-Organizations.md)  
  
-   [Provide Users in Another Organization Access to Your Claims-Aware Applications and Services](Provide-Users-in-Another-Organization-Access-to-Your-Claims-Aware-Applications-and-Services.md)  
  
For more information about how to create a claims\-aware ASP.NET application or WCF service, see [Windows Identity Foundation SDK](https://go.microsoft.com/fwlink/?LinkId=122266).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

