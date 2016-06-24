---
title: AD FS Design Guide in Windows Server 2012 R2
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad1d302d-1994-4fb3-ba74-3d9f2612e115
author: Femila
---
# AD FS Design Guide in Windows Server 2012 R2
Active Directory Federation Services (AD FS) provides simplified, secured identity federation and Web single sign-on (SSO) capabilities for end users who want to access applications within an AD FS-secured enterprise, in federation partner organizations, or in the cloud.  
  
In Windows Server® 2012 R2, AD FS includes a federation service role service that acts as an identity provider (authenticates users to provide security tokens to applications that trust AD FS) or as a federation provider (consumes tokens from other identity providers and then provides security tokens to applications that trust AD FS).  
  
The function of providing extranet access to applications and services that are secured by AD FS in Windows Server 2012 R2 is now performed by a new Remote Access role service called Web Application Proxy. This is a departure from the prior versions of Windows Server in which this function was handled by an AD FS federation server proxy. Web Application Proxy is a server role designed to provide access for the AD FS-related extranet scenario and other extranet scenarios. For more information on Web Application Proxy, see [Web Application Proxy Walkthrough Guide](Web-Application-Proxy-Walkthrough-Guide.md).  
  
## About this guide  
This guide provides recommendations to help you plan a new deployment of AD FS, based on the requirements of your organization. This guide is intended for use by an infrastructure specialist or system architect. It highlights your main decision points as you plan your AD FS deployment. Before you read this guide, you should have a good understanding of how AD FS works on a functional level. For more information, see [Understanding Key AD FS Concepts](../../ad-fs/plan/tech-ref/Understanding-Key-AD-FS-Concepts.md).  
  
## In this guide  
  
-   [Identify Your AD FS Deployment Goals](../../ad-fs/plan/WS2012R2-guide/Identify-Your-AD-FS-Deployment-Goals.md)  
  
-   [Plan Your AD FS Deployment Topology](../../ad-fs/plan/WS2012R2-guide/Plan-Your-AD-FS-Deployment-Topology.md)  
  
-   [AD FS Requirements](../../ad-fs/plan/WS2012R2-guide/AD-FS-Requirements.md)  
  
## Acknowledgments  
Author: Gayana Bagdasaryan  
  
Technical Reviewers: Jen Field, Samuel Devasahayam  
  
## See Also  
[AD FS Design](AD-FS-Design.md)  
  

