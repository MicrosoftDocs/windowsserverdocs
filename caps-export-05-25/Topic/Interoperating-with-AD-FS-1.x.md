---
title: Interoperating with AD FS 1.x
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2d1c192-5870-42eb-8c65-8c3678ead606
author: billmath
---
# Interoperating with AD FS 1.x
For interoperability between [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and AD FS 1.*x*, complete one or more of the following tasks, depending on the needs of your organization:  
  
-   Plan for interoperability between AD FS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and previous versions of AD FS, and learn more about the Name ID claim type. For more information, see [Planning for Interoperability with AD FS 1.x](../Topic/Planning-for-Interoperability-with-AD-FS-1.x.md).  
  
-   If you will be sending claims from an AD FS Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that can be consumed by an AD FS 1.*x* Federation Service, see [Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Federation Service](../Topic/Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Federation-Service.md).  
  
-   If you will be sending claims from an AD FS Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that can be consumed by an application that is hosted by a Web server running the AD FS 1.*x* claims\-aware Web agent, see [Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Claims-Aware Web Agent](../Topic/Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Claims-Aware-Web-Agent.md).  
  
-   If you will be sending claims from an AD FS 1.*x* Federation Service to be consumed by an AD FS Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [Checklist: Configuring AD FS  to Consume Claims from AD FS 1.x](../Topic/Checklist--Configuring-AD-FS--to-Consume-Claims-from-AD-FS-1.x.md).  
  
## Differences between Federation Service settings  
Although most of the AD FS 1.*x* Federation Service settings work in a similar manner as the AD FS Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] settings, some setting names have changed. The following table lists the names of settings for an AD FS 1.*x* Federation Service and their equivalent names for an AD FS Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
|AD FS 1.x Federation Service setting|Equivalent AD FS Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] setting|  
|----------------------------------------|----------------------------------------------------------------------------------------------------------|  
|Account Partner|Claims provider trust|  
|Resource Partner|Relying party trust|  
|Application|Relying party trust|  
|Application Properties|Relying party trust properties|  
|Application URL|Relying party identifier and WS\-Federation Passive Endpoint URL|  
|Federation Service URI|Federation Service identifier|  
|Federation Service endpoint URL|WS\-Federation Passive Endpoint URL|  
  
## See Also  
[AD FS and AD FS 1.x Interoperability](http://go.microsoft.com/fwlink/?LinkId=200776)  
  
