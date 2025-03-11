---
title: Windows Server Update Services (WSUS) Overview
description: Windows Server Update Service (WSUS) - An overview of the Server role and its practical applications
ms.topic: overview
ms.author: roharwoo
author: robinharwood
ms.date: 02/14/2025
---

# Windows Server Update Services (WSUS) overview

Windows Server Update Services (WSUS) enables information technology administrators to deploy the latest Microsoft product updates. You can use WSUS to fully manage the distribution of updates that are released through Microsoft Update to computers on your network. This article provides an overview of this server role and more information about how to deploy and maintain WSUS.

## WSUS Server role description

A WSUS server provides features that you can use  to manage and distribute updates through a management console. A WSUS server can also be the update source for other WSUS servers within the organization. The WSUS server that acts as an update source is called an upstream server. In a WSUS implementation, at least one WSUS server on your network must be able to connect to Microsoft Update to get available update information. As an administrator, you can determine, based on network security and configuration, how many other WSUS servers connect directly to Microsoft Update.

Windows Server Update Services includes the following features:

- Includes Windows PowerShell cmdlets to manage the most important administrative tasks in WSUS
- Adds SHA256 hash capability for extra security
- Provides client and server separation: versions of the Windows Update Agent (WUA) can ship independently of WSUS

## Practical applications

Update management is the process of controlling the deployment and maintenance of interim software releases into production environments. It helps you maintain operational efficiency, overcome security vulnerabilities, and maintain the stability of your production environment. If your organization can't maintain a known level of trust within its operating systems and application software, it might have many security vulnerabilities that, if exploited, could lead to a loss of revenue and intellectual property. Minimizing this threat requires you to properly configure systems, use the latest software, and install the recommended software updates.

The core scenarios where WSUS adds value to your business are:

- Centralized update management
- Update management automation

### Using Windows PowerShell to manage WSUS

For system administrators to automate their operations, they need coverage through command-line automation. The main goal is to facilitate WSUS administration by allowing system administrators to automate their day-to-day operations. Bringing core WSUS operations to Windows PowerShell allows administrators to increase productivity, reduce the learning curve for new tools, and increase consistency across similar operations. The Windows PowerShell cmdlets for WSUS operations add flexibility and agility for the system administrator.

## Unified Update Platform

Beginning March 28, 2023, WSUS supports Unified Update Platform (UUP) updates for Windows 11 version 21H2 clients. For more information, see [Plan your WSUS deployment](../plan/plan-your-wsus-deployment.md).

> [!IMPORTANT]
> The change requires either an update installation, or manually adding MIME types to Internet Information Services (IIS) on WSUS servers. Clients using Windows 11 version 22H2 might fail to install updates from WSUS if the server isn't updated. For more information, see [Unified Update Platform (UUP) considerations for WSUS](../plan/plan-your-wsus-deployment.md#uup-considerations).

## Related content

The following guides for planning, deploying, and managing WSUS are as follows:

- [Deploy Windows Server Update Services](../deploy/deploy-windows-server-update-services.md)

- [Manage Updates using Windows Server Update Services](../manage/update-management-with-windows-server-update-services.md)
