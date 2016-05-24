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
> For information about how to deploy AD FS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [Windows Server 2012 R2 AD FS Deployment Guide](../Topic/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md).  
  
You can use Active Directory® Federation Services \(AD FS\) with the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] operating system in a federation services provider role to seamlessly authenticate your users to any Web\-based services or applications that reside in a resource partner organization, without the need for administrators to create or maintain external trusts or forest trusts between the networks of both organizations and without the need for the users to log on a second time. The process of authenticating to one network while accessing resources in another network—without the burden of repeated logon actions by users—is known as single sign\-on \(SSO\).  
  
## About this guide  
This guide provides recommendations to help you plan a new deployment of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], based on the requirements of your organization \(also referred to in this guide as deployment goals\) and the particular design that you want to create. This guide is intended for use by an infrastructure specialist or system architect. It highlights your main decision points as you plan your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment. Before you read this guide, you should have a good understanding of how [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] works on a functional level. You should also have a good understanding of the organizational requirements that will be reflected in your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design.  
  
This guide describes a set of deployment goals that are based on three primary [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] designs, and it helps you decide the most appropriate design for your environment. You can use these deployment goals to form one of the following comprehensive [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] designs or a custom design that meets the needs of your environment:  
  
-   Federated Web SSO to support business\-to\-business \(B2B\) scenarios and to support collaboration between business units with independent forests  
  
-   Web SSO to support customer access to applications in business\-to\-consumer \(B2C\) scenarios  
  
For each design, you will find guidelines for gathering the required data about your environment. You can then use these guidelines to plan and design your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment. After you read this guide and finish gathering, documenting, and mapping your organization's requirements, you will have the information necessary to begin deploying [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] using the guidance in the [Windows Server 2012 AD FS Deployment Guide](../Topic/Windows-Server-2012-AD-FS-Deployment-Guide.md).  
  
## In this guide  
  
-   [Identifying Your AD FS Deployment Goals](../Topic/Identifying-Your-AD-FS-Deployment-Goals.md)  
  
-   [Mapping Your Deployment Goals to an AD FS Design](../Topic/Mapping-Your-Deployment-Goals-to-an-AD-FS-Design.md)  
  
-   [Determine Your AD FS Deployment Topology](../Topic/Determine-Your-AD-FS-Deployment-Topology.md)  
  
-   [Planning Your Deployment](../Topic/Planning-Your-Deployment.md)  
  
-   [Planning Federation Server Placement](../Topic/Planning-Federation-Server-Placement.md)  
  
-   [Planning Federation Server Proxy Placement](../Topic/Planning-Federation-Server-Proxy-Placement.md)  
  
-   [Planning for AD FS Server Capacity](../Topic/Planning-for-AD-FS-Server-Capacity.md)  
  
-   [Appendix A: Reviewing AD FS Requirements](../Topic/Appendix-A--Reviewing-AD-FS-Requirements.md)  
  
## Acknowledgments  
Author: Nick Pierson  
  
Technical Reviewers: Matt Steele, Lu Zhao \(Migration\/Topologies\/Requirements\), Jen Field \(Capacity Planning\/Topologies\/AD DS Claims\), Jan Alexander \(Claims Engine\/Pipeline\/Language\), Krish Shenoy \(Planning Federation Servers and Federation Server Proxies\/Requirements\)  
  
Editor: Jim Becker  
  
