---
title: Windows Server 2022 and Microsoft server application compatibility
description: Compatibility table for Windows Server 2022 and Microsoft server applications
ms.topic: article
ms.author: daknappe
author: dknappettmsft
manager: femila
ms.date: 9/20/2021
ms.localizationpriority: medium
---

# Windows Server 2022 and Microsoft Server application compatibility

This table lists Microsoft server applications that support installation and functionality on Window Server 2022. This information is for quick reference and is not intended to replace the individual product specifications, requirements, announcements, or general communications of each individual server application. Refer to official documentation for each product to fully understand compatibility and options.

> [!TIP]
> If you are a software vendor partner looking for more information on Windows Server compatibility with non-Microsoft applications, visit the [Commercial App Certification portal](https://commercialappcertification.microsoft.com/).

| Product | Supported on Server Core | Supported on Server with Desktop Experience | Released | Product Web Link |
|--|--|--|--|--|
| Azure DevOps Server 2020.1 | Yes* | Yes | Yes | [Azure DevOps Server 2020.1 release notes](/azure/devops/server/release-notes/azuredevops2020u1?view=azure-devops&preserve-view=true) |
| Configuration Manager (version 2107) | Yes as a managed client and distribution point.<br/>No as a site server. | Yes as a site server/site systems and a managed client. | Yes | [Support for Windows Server 2022](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107#support-for-windows-server-2022-and-the-adk-for-windows-11) |
| Project Server Subscription Edition | Yes | Yes | Public preview | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition) |
| SharePoint Server 2019 | No | Yes | Yes | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019) |
| SharePoint Server Subscription Edition | Yes | Yes | Public preview | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition) |
| SQL Server 2017 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true) |
| SQL Server 2019 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15?view=sql-server-ver15&preserve-view=true) |
| System Center Data Protection Manager 2019 | Yes | Yes | Yes | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/release-build-versions?view=sc-dpm-2019&preserve-view=true) |

*May have limitations or may require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
Please refer to specific product or Feature on Demand documentation.
