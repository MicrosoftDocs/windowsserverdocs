---
title: Microsoft server applications compatibility for Windows Server
description: Compatibility table for Windows Server 2022 and Microsoft server applications.
ms.topic: article
ms.author: roharwoo
author: robinharwood
manager: femila
ms.date: 02/07/2023
zone_pivot_groups: windows-os-version
---

# Microsoft server applications compatibility for Windows Server

This table lists Microsoft server applications that support installation and functionality on Window Server. This information is for quick reference and isn't intended to replace the individual product specifications, requirements, announcements, or general communications of each individual server application. Refer to official documentation for each product to fully understand compatibility and options.

> [!TIP]
> If you are a software vendor partner looking for more information on Windows Server compatibility with non-Microsoft applications, visit the [Commercial App Certification portal](https://commercialappcertification.microsoft.com/).

:::zone pivot="windows-server-2025"

| Product | Supported on Server Core | Supported on Server with Desktop Experience | Released | Product Web Link |
|--|--|--|--|--|
| Azure DevOps Server 2022.1 | Yes* | Yes | Yes | [Azure DevOps Server 2022 Update 1 Release Notes](/azure/devops/server/release-notes/azuredevops2022u1) |
| Configuration Manager (version 2107) | Yes as a managed client and distribution point.<br/>No as a site server. | Yes as a site server/site systems and a managed client. | Yes | [Support for Windows Server 2022](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107#support-for-windows-server-2022-and-the-adk-for-windows-11) |
| Exchange Server | Yes | Yes | Yes | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix) |
| Host Integration Server 2020 | Yes | Yes | Yes | [HIS 2020 - What's New, Release Notes, System Requirements, and Installation](/host-integration-server/install-and-config-guides/system-requirements-2020) |
| Microsoft 365 Apps | No | Yes | Yes | [Windows and Office configuration support matrix](https://aka.ms/windows-office-support-matrix) |
| Office Online Server| No | Yes | Yes | [Plan Office Online Server](/officeonlineserver/plan-office-online-server) |
| Project Server 2019 | No | Yes | Yes | [Software requirements for Project Server 2019 - Project Server](/project/software-requirements-for-project-server-2019)|
| Project Server Subscription Edition | Yes | Yes | Yes | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition) |
| SharePoint Server 2019 | No | Yes | Yes | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019) |
| SharePoint Server Subscription Edition | Yes | Yes | Yes | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition) |
| SQL Server 2017 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true) |
| SQL Server 2019 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15?view=sql-server-ver15&preserve-view=true) |
| SQL Server 2022 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver16) |
| System Center Data Protection Manager | Yes* | Yes | Yes | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm) |
| System Center Operations Manager | Yes* | Yes | Yes | [System requirements for System Center Operations Manager](/system-center/scom/system-requirements) |
| System Center Virtual Machine Manager | Yes* | Yes | Yes | [System requirements for System Center Virtual Machine Manager](/system-center/vmm/system-requirements) |

\* May have limitations or may require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
For more information, see specific product or Feature on Demand documentation.

** Refer to Product Web Link

::: zone-end

:::zone pivot="windows-server-2022"

| Product | Supported on Server Core | Supported on Server with Desktop Experience | Released | Product Web Link |
|--|--|--|--|--|
| Azure DevOps Server 2020.1 | Yes* | Yes | Yes | [Azure DevOps Server 2020.1 release notes](/azure/devops/server/release-notes/azuredevops2020u1?view=azure-devops&preserve-view=true) |
| Configuration Manager (version 2107) | Yes as a managed client and distribution point.<br/>No as a site server. | Yes as a site server/site systems and a managed client. | Yes | [Support for Windows Server 2022](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107#support-for-windows-server-2022-and-the-adk-for-windows-11) |
| Exchange Server 2019 CU12 and later | Yes | Yes | Yes | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix?view=exchserver-2019&preserve-view=true) |
| Host Integration Server 2020 | Yes | Yes | Yes | [HIS 2020 - What's New, Release Notes, System Requirements, and Installation](/host-integration-server/install-and-config-guides/his-2020-what-s-new-release-notes-system-requirements-and-installation) |
| Microsoft 365 Apps | No | Yes | Yes | [Windows and Office configuration support matrix](https://aka.ms/windows-office-support-matrix) |
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

::: zone-end

:::zone pivot="windows-server-2019"

| Product | Supported on Server Core | Supported on Server with Desktop Experience | Released | Product Web Link |
|--|--|--|--|--|
| Azure DevOps Server 2019 | Yes* | Yes | Yes | [Azure DevOps Server 2019](/azure/devops/server/requirements?view=azure-devops-2019&preserve-view=true) |
| Azure DevOps Server 2020 | Yes* | Yes | Yes | [Azure DevOps Server 2020](/azure/devops/server/requirements?view=azure-devops-2020&preserve-view=true) |
| Configuration Manager (version 1806) | Yes as managed client, No as site server | Yes as managed client, No as site server | Yes | [What's new in version 1806 of Configuration Manager current branch](/configmgr/core/plan-design/changes/whats-new-in-version-1806) |
| Exchange Server 2019 | Yes | Yes | Yes | [Exchange Server system requirements](/exchange/plan-and-deploy/system-requirements) |
| Host Integration Server 2016, CU3 | Yes | Yes | Yes | [Host Integration Server system requirements](/host-integration-server/install-and-config-guides/system-requirements) |
|Office Online Server|  No| Yes | Yes | [Plan Office Online Server](/officeonlineserver/plan-office-online-server)|
| Project Server 2016 | No | Yes | Yes | [Software requirements for Project Server 2016](/project/software-requirements-for-project-server-2016) |
| Project Server 2019 | No | Yes | Yes | [Software requirements for Project Server 2019](/project/software-requirements-for-project-server-2019) |
| Project Server Subscription Edition | Yes | Yes | Yes | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition) |
| SharePoint Server 2016 | No | Yes | Yes | [Hardware and software requirements for SharePoint Server 2016](/sharepoint/install/hardware-and-software-requirements) |
| SharePoint Server 2019 | No | Yes | Yes | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019) |
| SharePoint Server Subscription Edition | Yes | Yes | Yes | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition) |
| Skype for Business 2019 | No | Yes | Yes | [Install prerequisites for Skype for Business Server](/skypeforbusiness/deploy/install/install-prerequisites) |
| SQL Server 2014 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2014](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
| SQL Server 2016 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2016](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2016&preserve-view=true) |
| SQL Server 2017 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true) |
| SQL Server 2019 | Yes* | Yes | Yes | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15?view=sql-server-ver15&preserve-view=true) |
| System Center Data Protection Manager 2019 | No | Yes | Yes | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm) |
| System Center Operations Manager 2019 | Yes* | Yes | Yes | [System requirements for System Center Operations Manager](/system-center/scom/plan-system-requirements) |
| System Center Virtual Machine Manager 2019 | Yes* | Yes | Yes | [System requirements for System Center Virtual Machine Manager](/system-center/vmm/system-requirements) |

*May have limitations or may require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
Please refer to specific product or FOD documentation.

::: zone-end

:::zone pivot="windows-server-2016"

| Product | Released | Product Web Link |
|--|--|--|
| BizTalk Server 2016 | Yes | [Microsoft BizTalk Server](https://www.microsoft.com/cloud-platform/biztalk)|
| Configuration Manager (version 1606) | Yes | [What's new in version 1606 of Configuration Manager](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1606)|
| Exchange Server 2016 | Yes | [Updates for Exchange 2016](/Exchange/new-features/updates)|
| Host Integration Server 2016 | Yes | [What's New in HIS 2016](/host-integration-server/install-and-config-guides/what-s-new-in-his-2016)|
| Office Online Server | Yes | [Plan Office Online Server](/officeonlineserver/plan-office-online-server)|
| Project Server 2016 | Yes | [Software requirements for Project Server 2016](/project/software-requirements-for-project-server-2016)|
| Project Server 2019 | Yes | [Software requirements for Project Server 2019](/project/software-requirements-for-project-server-2019) |
| SharePoint Server 2016 | Yes | [Hardware and software requirements for SharePoint Server 2016](/SharePoint/install/hardware-and-software-requirements)|
| SharePoint Server 2019 | Yes | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019) |
| Skype for Business Server 2015 | Yes| [How to install Skype for Business Server 2015 on Windows Server 2016](https://support.microsoft.com/help/4015888/how-to-install-skype-for-business-server-2015-on-windows-server-2016)|
| SQL Server 2012 | Yes | [Hardware and Software Requirements for Installing SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110))|
| SQL Server 2014 | Yes | [Hardware and Software Requirements for Installing SQL Server 2014](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
| SQL Server 2016 | Yes | [SQL Server 2016](https://www.microsoft.com/cloud-platform/sql-server)|
| System Center Virtual Machine Manager 2016 | Yes | [What's New in System Center](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
| System Center Operations Manager 2016 | Yes | [What's New in System Center](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
| System Center Data Protection Manager 2016 | Yes | [What's New in System Center](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
| Visual Studio Team Foundation Server 2017 | Yes | [Team Foundation Server 2017](https://www.visualstudio.com/news/releasenotes/tfs2017-relnotes)|

::: zone-end