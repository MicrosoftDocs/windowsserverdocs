---
title: Windows Server 2022 and Microsoft server applications compatibility
description: Compatibility table for Windows Server 2022 and Microsoft server applications.
ms.topic: article
ms.author: roharwoo
author: robinharwood
manager: femila
ms.date: 02/07/2023
---

# Windows Server 2022 and Microsoft server applications compatibility

This table lists Microsoft server applications that support installation and functionality on Window Server 2022. This information is for quick reference and isn't intended to replace the individual product specifications, requirements, announcements, or general communications of each individual server application. Refer to official documentation for each product to fully understand compatibility and options.

> [!TIP]
> If you are a software vendor partner looking for more information on Windows Server compatibility with non-Microsoft applications, visit the [Commercial App Certification portal](https://commercialappcertification.microsoft.com/).

| Product | Supported on Server Core | Supported on Server with Desktop Experience | Released | Product Web Link |
|--|--|--|--|--|
| Azure DevOps Server 2020.1 | Yes* | Yes | Yes | [Azure DevOps Server 2020.1 release notes](/azure/devops/server/release-notes/azuredevops2020u1?view=azure-devops&preserve-view=true) |
| Configuration Manager (version 2107) | Yes as a managed client and distribution point.<br/>No as a site server. | Yes as a site server/site systems and a managed client. | Yes | [Support for Windows Server 2022](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107#support-for-windows-server-2022-and-the-adk-for-windows-11) |
| Exchange Server 2019 CU12 and later | Yes | Yes | Yes | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix?view=exchserver-2019&preserve-view=true) |
| Host Integration Server 2020 | Yes | Yes | Yes | [HIS 2020 - What's New, Release Notes, System Requirements, and Installation](/host-integration-server/install-and-config-guides/his-2020-what-s-new-release-notes-system-requirements-and-installation) |
| Microsoft 365 Apps | No | Yes | Yes | [Windows and Office configuration support matrix](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE2OqRI) |
| Office Online Server| No | Yes | Yes | [Plan Office Online Server](/officeonlineserver/plan-office-online-server) |
| Project Server 2019 | No | Yes | Yes | [Software requirements for Project Server 2019 - Project Server](/project/software-requirements-for-project-server-2019)|
| Project Server Subscription Edition | Yes | Yes | Yes | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition) |
| SharePoint Server 2019 | No | Yes | Yes | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019) |
| SharePoint Server Subscription Edition | Yes | Yes | Yes | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition) |
| SQL Server 2017 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true) |
| SQL Server 2019 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15?view=sql-server-ver15&preserve-view=true) |
| System Center Data Protection Manager 2019 | Yes as a backup workload.<br/>No as a DPM server. | Yes as a backup workload.<br/>No as a DPM server. | Yes | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm?view=sc-dpm-2019&preserve-view=true) |
| System Center Data Protection Manager 2022 | Yes* | Yes | Yes | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm?view=sc-dpm-2022&preserve-view=true) |
| System Center Operations Manager 2019 | Yes as an agent.<br/>No as a Management Server** | Yes as an agent.<br/>No as a Management Server**. | Yes | [System requirements for System Center Operations Manager](/system-center/scom/system-requirements?view=sc-om-2019&preserve-view=true) |
| System Center Operations Manager 2022 | Yes* | Yes | Yes | [System requirements for System Center Operations Manager](/system-center/scom/system-requirements?view=sc-om-2022&preserve-view=true) |
| System Center Virtual Machine Manager 2022 | Yes* | Yes | Yes | [System requirements for System Center Virtual Machine Manager](/system-center/vmm/system-requirements?view=sc-vmm-2022&preserve-view=true) |

\* May have limitations or may require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
For more information, see specific product or Feature on Demand documentation.

** Refer to Product Web Link
