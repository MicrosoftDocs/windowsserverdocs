---
title: Get started with Windows Server Update Services (WSUS)
description: "Windows Server Update Service (WSUS) topic - An overview of the Server role and its practical applications"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-wsus
ms.tgt_pltfrm: na
ms.topic: get-started article
ms.assetid: 90e3464c-49d8-4861-96db-ee6f8a09ec5b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 5/22/2017
---
# Windows Server Update Services (WSUS)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows Server Update Services (WSUS) enables information technology administrators to deploy the latest Microsoft product updates. You can use WSUS to fully manage the distribution of updates that are released through Microsoft Update to computers on your network. This topic provides an overview of this server role and more information about how to deploy and maintain WSUS.

## WSUS Server role description
A WSUS server provides features that you can use  to manage and distribute updates through a management console. A WSUS server can also be the update source for other WSUS servers within the organization. The WSUS server that acts as an update source is called an upstream server. In a WSUS implementation, at least one WSUS server on your network must be able to connect to Microsoft Update to get available update information. As an administrator, you can determine - based on network security and configuration - how many other WSUS servers connect directly to Microsoft Update.

### Practical applications
Update management is the process of controlling the deployment and maintenance of interim software releases into production environments. It helps you maintain operational efficiency, overcome security vulnerabilities, and maintain the stability of your production environment. If your organization cannot determine and maintain a known level of trust within its operating systems and application software, it might have a number of security vulnerabilities that, if exploited, could lead to a loss of revenue and intellectual property. Minimizing this threat requires you to have properly configured systems, use the latest software, and install the recommended software updates.

The core scenarios where WSUS adds value to your business are:

-   Centralized update management

-   Update management automation

### New and changed functionality

> [!NOTE]
> Upgrade from any version of Windows Server that supports WSUS 3.2 to Windows Server 2012 R2 requires that you first uninstall WSUS 3.2.
> 
> In Windows Server 2012, upgrading from any version of Windows Server with WSUS 3.2 installed is blocked during the installation process if WSUS 3.2 is detected. In that case, you will be prompted to first uninstall Windows Server Update Services prior to upgrading your server.
> 
> However, because of changes in this release of Windows Server and Windows Server 2012 R2, when upgrading from any version of Windows Server and WSUS 3.2, the installation is not blocked. Failure to uninstall WSUS 3.2 prior to performing a Windows Server 2012 R2 upgrade will cause the post installation tasks for WSUS in Windows Server 2012 R2 to fail. In this case, the only known corrective measure is to format the hard drive and reinstall Windows Server.

Windows Server Update Services is a built-in server role that includes the following enhancements:

-   Can be added and removed by using the Server Manager

-   Includes Windows PowerShell cmdlets to manage the most important administrative tasks in WSUS

-   Adds SHA256 hash capability for additional security

-   Provides client and server separation: versions of the Windows Update Agent (WUA) can ship independently of WSUS

### Using Windows PowerShell to manage WSUS
For system administrators to automate their operations, they need coverage through command-line automation. The main goal is to facilitate WSUS administration by allowing system administrators to automate their day-to-day operations.

**What value does this change add?**

By exposing core WSUS operations through Windows PowerShell, system administrators can increase productivity, reduce the learning curve for new tools, and reduce errors due to failed expectations resulting from a lack of consistency across similar operations.

**What works differently?**

In earlier versions of the Windows Server operating system, there were no Windows PowerShell cmdlets, and update management automation was challenging. The Windows PowerShell cmdlets for WSUS operations add flexibility and agility for the system administrator.

## In this collection
The following guides for planning, deploying, and managing WSUS are in this collection:

-   [Deploy Windows Server Update Services](../deploy/deploy-windows-server-update-services.md)

-   [Manage Updates using Windows Server Update Services](../manage/update-management-with-windows-server-update-services.md)


