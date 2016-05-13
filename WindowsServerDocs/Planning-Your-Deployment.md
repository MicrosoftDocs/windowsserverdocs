---
title: Planning Your Deployment
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9dcfbf94-1517-4c6d-bca1-cca72f2d1865
---
# Planning Your Deployment
When you plan for cross\-organizational \(federation\-based\) collaboration using [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)], first determine if your organization will host a Web resource to be accessed by other organizations across the Internet or if you will provide access to the Web resource for employees in your organization. This determination affects how you deploy [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)], and it is fundamental in the planning of your [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] infrastructure.

> [!NOTE]
> Make sure that the role that organization plays in the federation agreement is clearly understood by all parties.

For the [Federated Web SSO Design](Federated-Web-SSO-Design.md), [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] uses terms such as *account partner* \(also referred to as *identity provider* in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management snap\-in\) and *resource partner* \(also referred to as *relying party* in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management snap\-in\) to help differentiate the organization that hosts the accounts \(the account partner\) from the organization that hosts the Web\-based resources \(the resource partner\).

In the [Web SSO Design](Web-SSO-Design.md), the organization acts in both the account partner and resource partner roles because it is providing its users with access to its applications.

The following topics explain some of the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] partner organization concepts. They also contain links to topics in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Deployment Guide that contain information about setting up and configuring account partner organizations and resource partner organizations based on your [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] deployment goals.

## In this section

-   [Best Practices for Secure Planning and Deployment of AD FS](Best-Practices-for-Secure-Planning-and-Deployment-of-AD-FS.md)

-   [Planning for Interoperability with AD FS 1.x](Planning-for-Interoperability-with-AD-FS-1.x.md)

-   [When to Use Identity Delegation](When-to-Use-Identity-Delegation.md)

-   [Deploying AD FS in the Account Partner Organization](Deploying-AD-FS-in-the-Account-Partner-Organization.md)

-   [Deploying AD FS in the Resource Partner Organization](Deploying-AD-FS-in-the-Resource-Partner-Organization.md)


