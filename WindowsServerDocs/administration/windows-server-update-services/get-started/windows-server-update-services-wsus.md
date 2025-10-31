---
title: Windows Server Update Services (WSUS) Overview
description: See an overview of the Windows Server Update Service (WSUS) Server role, including its features, applications, and support for Unified Update Platform (UUP).
ms.topic: overview
ms.author: roharwoo
author: robinharwood
ms.date: 05/02/2025
# customer intent: As an administrator, I want to become familiar with Windows Server Update Service (WSUS) Server role features for distributing updates to computers on my network so that I can maintain operational efficiency, overcome security vulnerabilities, and maintain the stability of my production environment.
---

# Windows Server Update Services (WSUS) overview

Windows Server Update Services (WSUS) provides a way for IT administrators to deploy the latest Microsoft product updates. You can use WSUS to fully manage the distribution of updates that are released through Microsoft Update to computers on your network. This article provides an overview of this server role and more information about how to deploy and maintain WSUS.

> [!NOTE]
> WSUS is deprecated and is no longer adding new features. However, it continues to be supported for production deployments, and receives security and quality updates as per the product lifecycle. For more info, see [Features removed or no longer developed in Windows Server](../../../get-started/removed-deprecated-features-windows-server.md).

## WSUS Server role description

A WSUS server provides features that you can use to manage and distribute updates through a management console. A WSUS server can also be the update source for other WSUS servers within the organization. The WSUS server that acts as an update source is called an upstream server. In a WSUS implementation, at least one WSUS server on your network must be able to connect to Microsoft Update to get available update information. As an administrator, you can determine, based on network security and configuration, how many other WSUS servers connect directly to Microsoft Update.

WSUS includes the following features:

- Windows PowerShell cmdlets to manage the most important administrative tasks in WSUS.
- Secure hash algorithm 256-bit (SHA-256) capability for extra security.
- Client and server separation: versions of the Windows Update Agent (WUA) can be deployed independently of WSUS.

## Practical applications

Update management is the process of controlling the deployment and maintenance of interim software releases into production environments. It helps you maintain operational efficiency, overcome security vulnerabilities, and maintain the stability of your production environment. Maintaining a known level of trust within your organization's operating systems and application software helps you avoid security vulnerabilities that, if exploited, can lead to a loss of revenue and intellectual property. Minimizing this threat requires you to properly configure systems, use the latest software, and install the recommended software updates.

The core scenarios where WSUS adds value to your business are:

- Centralized update management
- Update management automation

### Use Windows PowerShell to manage WSUS

For system administrators to automate their operations, they need coverage through command-line automation. The main goal is to facilitate WSUS administration by providing a way for system administrators to automate their day-to-day operations. Bringing core WSUS operations to Windows PowerShell helps administrators increase productivity, reduce the learning curve for new tools, and increase consistency across similar operations. The Windows PowerShell cmdlets for WSUS operations add flexibility and agility for the system administrator.

## Unified Update Platform

Beginning March 28, 2023, WSUS supports Unified Update Platform (UUP) updates for Windows 11 version 21H2 clients. For more information, see [Plan your WSUS deployment](../plan/plan-your-wsus-deployment.md).

> [!IMPORTANT]
> This change requires either an update installation or the manual addition of Multipurpose Internet Mail Extensions (MIME) types to Internet Information Services (IIS) on WSUS servers. Clients using Windows 11 version 22H2 might fail to install updates from WSUS if the server isn't updated. For more information, see [UUP considerations](../plan/plan-your-wsus-deployment.md#uup-considerations).

## Related content

For information about planning, deploying, and managing WSUS, see the following guides:

- [Deploy Windows Server Update Services](../deploy/deploy-windows-server-update-services.md)
- [Update Management with Windows Server Update Services](../manage/update-management-with-windows-server-update-services.md)


