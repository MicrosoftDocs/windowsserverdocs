---
description: "Learn more about: AD FS Design Guide in Windows Server"
ms.assetid: a8558c9d-0606-4881-93b2-f2d2716b18e7
title: AD FS Design Guide in Windows Server 2012 R2
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---

# AD FS Design Guide in Windows Server

Active Directory Federation Services \(AD FS\) provides simplified, secured identity federation and Web single sign\-on \(SSO\) capabilities for end users who want to access applications within an AD FS\-secured enterprise, in federation partner organizations, or in the cloud.

In Windows Server&reg; 2012 R2, AD FS includes a federation service role service that acts as an identity provider \(authenticates users to provide security tokens to applications that trust AD FS\) or as a federation provider \(consumes tokens from other identity providers and then provides security tokens to applications that trust AD FS\).

The function of providing extranet access to applications and services that are secured by AD FS in Windows Server 2012 R2 is now performed by a new Remote Access role service called Web Application Proxy. This is a departure from the prior versions of Windows Server in which this function was handled by an AD FS federation server proxy. Web Application Proxy is a server role designed to provide access for the AD FS\-related extranet scenario and other extranet scenarios. For more information on Web Application Proxy, see [Web Application Proxy Walkthrough Guide](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn280944(v=ws.11)).

## About this guide
This guide provides recommendations to help you plan a new deployment of AD FS, based on the requirements of your organization. This guide is intended for use by an infrastructure specialist or system architect. It highlights your main decision points as you plan your AD FS deployment. Before you read this guide, you should have a good understanding of how AD FS works on a functional level. For more information, see [Understanding Key AD FS Concepts](../../ad-fs/technical-reference/Understanding-Key-AD-FS-Concepts.md).

## In this guide

-   [Identify Your AD FS Deployment Goals](Identify-Your-AD-FS-Deployment-Goals.md)

-   [Plan Your AD FS Deployment Topology](Plan-Your-AD-FS-Deployment-Topology.md)

-   [AD FS Requirements](AD-FS-Requirements.md)


## See Also
[AD FS Design](../../ad-fs/AD-FS-Design.md)

