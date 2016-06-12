---
title: AD FS Design Guide in Windows Server 2012
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bed4afe-6bdd-44f8-9e11-903c3de838bf
author: billmath
---
# AD FS Design Guide in Windows Server 2012
  
> [!NOTE]  
> For information about how to deploy AD FS in  Windows Server 2012 R2 , see [Windows Server 2012 R2 AD FS Deployment Guide](Windows-Server-2012-R2-AD-FS-Deployment-Guide.md).  
  
You can use Active Directory® Federation Services \(AD FS\) with the Windows Server® 2012 operating system in a federation services provider role to seamlessly authenticate your users to any Web\-based services or applications that reside in a resource partner organization, without the need for administrators to create or maintain external trusts or forest trusts between the networks of both organizations and without the need for the users to log on a second time. The process of authenticating to one network while accessing resources in another network—without the burden of repeated logon actions by users—is known as single sign\-on \(SSO\).  
  
## About this guide  
This guide provides recommendations to help you plan a new deployment of AD FS, based on the requirements of your organization \(also referred to in this guide as deployment goals\) and the particular design that you want to create. This guide is intended for use by an infrastructure specialist or system architect. It highlights your main decision points as you plan your AD FS deployment. Before you read this guide, you should have a good understanding of how AD FS works on a functional level. You should also have a good understanding of the organizational requirements that will be reflected in your AD FS design.  
  
This guide describes a set of deployment goals that are based on three primary AD FS designs, and it helps you decide the most appropriate design for your environment. You can use these deployment goals to form one of the following comprehensive AD FS designs or a custom design that meets the needs of your environment:  
  
-   Federated Web SSO to support business\-to\-business \(B2B\) scenarios and to support collaboration between business units with independent forests  
  
-   Web SSO to support customer access to applications in business\-to\-consumer \(B2C\) scenarios  
  
For each design, you will find guidelines for gathering the required data about your environment. You can then use these guidelines to plan and design your AD FS deployment. After you read this guide and finish gathering, documenting, and mapping your organization's requirements, you will have the information necessary to begin deploying AD FS using the guidance in the [Windows Server 2012 AD FS Deployment Guide](Windows-Server-2012-AD-FS-Deployment-Guide.md).  
  
## In this guide  
  
-   [Identifying Your AD FS Deployment Goals](../../active-directory-federation-services/plan/WS2012-guide/identifying-your-ad-fs-deployment-goals.md)  
  
-   [Mapping Your Deployment Goals to an AD FS Design](../../active-directory-federation-services/plan/WS2012-guide/mapping-your-deployment-goals-ad-fs-design.md)  
  
-   [Determine Your AD FS Deployment Topology](../../active-directory-federation-services/plan/WS2012-guide/determine-your-ad-fs-deployment-topology.md)  
  
-   [Planning Your Deployment](../../active-directory-federation-services/plan/WS2012-guide/planning-your-deployment.md)  
  
-   [Planning Federation Server Placement](../../active-directory-federation-services/plan/WS2012-guide/planning-federation-server-placement.md)  
  
-   [Planning Federation Server Proxy Placement](../../active-directory-federation-services/plan/WS2012-guide/planning-federation-server-proxy-placement.md)  
  
-   [Planning for AD FS Server Capacity](../../active-directory-federation-services/plan/WS2012-guide/planning-ad-fs-server-capacity.md)  
  
-   [Appendix A: Reviewing AD FS Requirements](../../active-directory-federation-services/plan/WS2012-guide/appendix-reviewing-ad-fs-requirements.md)  
  
## Acknowledgments  
Author: Nick Pierson  
  
Technical Reviewers: Matt Steele, Lu Zhao \(Migration\/Topologies\/Requirements\), Jen Field \(Capacity Planning\/Topologies\/AD DS Claims\), Jan Alexander \(Claims Engine\/Pipeline\/Language\), Krish Shenoy \(Planning Federation Servers and Federation Server Proxies\/Requirements\)  
  
Editor: Jim Becker  
  

