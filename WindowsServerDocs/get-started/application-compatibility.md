---
title: Microsoft server applications compatibility for Windows Server
description: Learn about the compatibility of Microsoft server applications on Windows Server.
ms.topic: feature-availability
ms.author: roharwoo
author: robinharwood
ms.date: 01/13/2025
zone_pivot_groups: windows-os-version
---

# Microsoft server applications compatibility for Windows Server

We understand that application compatibility is one of the top reasons that customers choose Windows Server. Throughout the Windows Server development cycle, Microsoft regularly tests a large suite of Microsoft and non-Microsoft applications to ensure our products are compatible with as many applications as possible. These tests cover a wide range of non-Microsoft enterprise applications, including development tools, graphics tools, security tools, business office suites, storage management, antivirus, backup or recovery, and utilities.

The following table lists Microsoft server applications that support installation and functionality on Window Server. This information is for quick reference and isn't intended to replace the individual product specifications, requirements, announcements, or general communications of each individual server application. Refer to official documentation for each product to fully understand compatibility and options.

> [!TIP]
> If you're a software vendor partner looking for more information on Windows Server compatibility with non-Microsoft applications, visit the [Commercial App Certification portal](https://commercialappcertification.microsoft.com/).

:::zone pivot="windows-server-2025"

> [!div class="mx-tableFixed"]
> | Product                                | Supported on Server Core | Supported on Server with Desktop Experience | Product Web Link                                                                                                                                                                                       |
> |----------------------------------------|--------------------------|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
> | Configuration Manager (version 2409)   | ✅&sup2;                  | ✅                                          | [Support for Windows Server 2025](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2409#operating-system-support-added-for-windows-11-24h2-and-windows-server-2025)                         |
> | Exchange Server                        | ✅                        | ✅                                          | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix)                                                                                                                |
> | Microsoft 365 Apps                     | ❌                        | ✅                                          | [Windows and Office configuration support matrix](https://aka.ms/windows-office-support-matrix)                                                                                                         |
> | Project Server Subscription Edition    | ✅                        | ✅                                          | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition)                                                                     |
> | SharePoint Server Subscription Edition | ✅                        | ✅                                          | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition)                                                           |
> | SQL Server 2019                        | ✅&sup1;                  | ✅                                          | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2019?view=sql-server-ver15&preserve-view=true) |
> | SQL Server 2022                        | ✅&sup1;                  | ✅                                          | [Hardware and Software Requirements for Installing SQL Server 2022](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver16&preserve-view=true) |
> | System Center Data Protection Manager  | ✅&sup1;                  | ✅                                          | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm)                                                                                  |
> | System Center Operations Manager       | ✅&sup1;                  | ✅                                          | [System requirements for System Center Operations Manager](/system-center/scom/system-requirements)                                                                                                     |
> | System Center Virtual Machine Manager  | ✅&sup1;                  | ✅                                          | [System requirements for System Center Virtual Machine Manager](/system-center/vmm/system-requirements)                                                                                                 |

1. Might have limitations or require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
For more information, see specific product or Feature on Demand documentation.

2. Yes, as a managed client and distribution point but not as a site server.

::: zone-end

:::zone pivot="windows-server-2022"

> [!div class="mx-tableFixed"]
> | Product                                    | Supported on Server Core | Supported on Server with Desktop Experience | Product Web Link                                                                                                                                                                                         |
> |--------------------------------------------|--------------------------|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
> | Azure DevOps Server 2020.1                 | ✅&sup1;                  | ✅                                           | [Azure DevOps Server 2020.1 release notes](/azure/devops/server/release-notes/azuredevops2020u1?view=azure-devops&preserve-view=true)                                                                    |
> | Configuration Manager (version 2107)       | ✅&sup2;                  | ✅                                           | [Support for Windows Server 2022](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107#support-for-windows-server-2022-and-the-adk-for-windows-11)                                          |
> | Exchange Server 2019 CU12 and later        | ✅                        | ✅                                           | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix)                                                                                                                 |
> | Host Integration Server 2020               | ✅                        | ✅                                           | [HIS 2020 - What's New, Release Notes, System Requirements, and Installation](/host-integration-server/install-and-config-guides/his-2020-what-s-new-release-notes-system-requirements-and-installation) |
> | Microsoft 365 Apps                         | ❌                        | ✅                                           | [Windows and Office configuration support matrix](https://aka.ms/windows-office-support-matrix)                                                                                                          |
> | Office Online Server                       | ❌                        | ✅                                           | [Plan Office Online Server](/officeonlineserver/plan-office-online-server)                                                                                                                               |
> | Project Server 2019                        | ❌                        | ✅                                           | [Software requirements for Project Server 2019 - Project Server](/project/software-requirements-for-project-server-2019)                                                                                 |
> | Project Server Subscription Edition        | ✅                        | ✅                                           | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition)                                                                      |
> | SharePoint Server 2019                     | ❌                        | ✅                                           | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019)                                                                             |
> | SharePoint Server Subscription Edition     | ✅                        | ✅                                           | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition)                                                            |
> | SQL Server 2017                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true)        |
> | SQL Server 2019                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2019?view=sql-server-ver15&preserve-view=true)  |
> | SQL Server 2022                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2022](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver16&preserve-view=true)  |
> | System Center Data Protection Manager 2019 | ✅&sup3;                  | ✅&sup3;                                     | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm?view=sc-dpm-2019&preserve-view=true)                                               |
> | System Center Data Protection Manager 2022 | ✅&sup1;                  | ✅                                           | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm?view=sc-dpm-2022&preserve-view=true)                                               |
> | System Center Operations Manager 2019      | ✅&#8308;                 | ✅&#8308;                                    | [System requirements for System Center Operations Manager](/system-center/scom/system-requirements?view=sc-om-2019&preserve-view=true)                                                                   |
> | System Center Operations Manager 2022      | ✅&sup1;                  | ✅                                           | [System requirements for System Center Operations Manager](/system-center/scom/system-requirements?view=sc-om-2022&preserve-view=true)                                                                   |
> | System Center Virtual Machine Manager 2022 | ✅&sup1;                  | ✅                                           | [System requirements for System Center Virtual Machine Manager](/system-center/vmm/system-requirements?view=sc-vmm-2022&preserve-view=true)                                                              |

1. Might have limitations or require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
For more information, see specific product or Feature on Demand documentation.

2. Yes, as a managed client and distribution point but not as a site server.

3. Yes as a backup workload but not as a Data Protection Manager server.

4. Yes as an agent but not as a Management Server.

::: zone-end

:::zone pivot="windows-server-2019"

> [!div class="mx-tableFixed"]
> | Product                                    | Supported on Server Core | Supported on Server with Desktop Experience | Product Web Link                                                                                                                                                                                                         |
> |--------------------------------------------|--------------------------|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
> | Azure DevOps Server 2019                   | ✅&sup1;                  | ✅                                           | [Azure DevOps Server 2019](/azure/devops/server/requirements?view=azure-devops-2019&preserve-view=true)                                                                                                                  |
> | Azure DevOps Server 2020                   | ✅&sup1;                  | ✅                                           | [Azure DevOps Server 2020](/azure/devops/server/requirements?view=azure-devops-2020&preserve-view=true)                                                                                                                  |
> | Configuration Manager (version 1806)       | ✅&sup2;                  | ✅&sup2;                                     | [What's new in version 1806 of Configuration Manager current branch](/configmgr/core/plan-design/changes/whats-new-in-version-1806)                                                                                      |
> | Exchange Server 2019                       | ✅                        | ✅                                           | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix)                                                                                                                                 |
> | Host Integration Server 2016, CU3          | ✅                        | ✅                                           | [Host Integration Server system requirements](/host-integration-server/install-and-config-guides/system-requirements)                                                                                                    |
> | Office Online Server                       | ❌                        | ✅                                           | [Plan Office Online Server](/officeonlineserver/plan-office-online-server)                                                                                                                                               |
> | Project Server 2016                        | ❌                        | ✅                                           | [Software requirements for Project Server 2016](/project/software-requirements-for-project-server-2016)                                                                                                                  |
> | Project Server 2019                        | ❌                        | ✅                                           | [Software requirements for Project Server 2019](/project/software-requirements-for-project-server-2019)                                                                                                                  |
> | Project Server Subscription Edition        | ✅                        | ✅                                           | [Software requirements for Project Server Subscription Edition](/project/software-requirements-project-server-subscription-edition)                                                                                      |
> | SharePoint Server 2016                     | ❌                        | ✅                                           | [Hardware and software requirements for SharePoint Server 2016](/sharepoint/install/hardware-and-software-requirements)                                                                                                  |
> | SharePoint Server 2019                     | ❌                        | ✅                                           | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019)                                                                                             |
> | SharePoint Server Subscription Edition     | ✅                        | ✅                                           | [System requirements for SharePoint Server Subscription edition](/sharepoint/install/system-requirements-for-sharepoint-subscription-edition)                                                                            |
> | Skype for Business 2019                    | ❌                        | ✅                                           | [Install prerequisites for Skype for Business Server](/skypeforbusiness/deploy/install/install-prerequisites)                                                                                                            |
> | SQL Server 2014                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2014](/previous-versions/sql/2014/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
> | SQL Server 2016                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2016](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2016&preserve-view=true)                        |
> | SQL Server 2017                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true)                        |
> | SQL Server 2019                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2019?view=sql-server-ver15&preserve-view=true)                  |
> | SQL Server 2022                            | ✅&sup1;                  | ✅                                           | [Hardware and Software Requirements for Installing SQL Server 2022](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver16&preserve-view=true)                  |
> | System Center Data Protection Manager 2019 | ❌                        | ✅                                           | [Preparing your environment for System Center Data Protection Manager](/system-center/dpm/prepare-environment-for-dpm)                                                                                                   |
> | System Center Operations Manager 2019      | ✅&sup1;                  | ✅                                           | [System requirements for System Center Operations Manager](/system-center/scom/plan-system-requirements)                                                                                                                 |
> | System Center Virtual Machine Manager 2019 | ✅&sup1;                  | ✅                                           | [System requirements for System Center Virtual Machine Manager](/system-center/vmm/system-requirements)                                                                                                                  |

1. Might have limitations or require the [Server Core App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md).
For more information, see specific product or Feature on Demand documentation.

2. Yes, as a managed client and distribution point but not as a site server.

::: zone-end

:::zone pivot="windows-server-2016"

| Product                                    | Product Web Link                                                                                                                                                                                                         |
|--------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| BizTalk Server 2016                        | [Microsoft BizTalk Server](https://www.microsoft.com/cloud-platform/biztalk)                                                                                                                                             |
| Configuration Manager (version 1606)       | [What's new in version 1606 of Configuration Manager](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1606)                                                                                                 |
| Exchange Server 2016                       | [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix)                                                                                                                                 |
| Host Integration Server 2016               | [What's New in HIS 2016](/host-integration-server/install-and-config-guides/what-s-new-in-his-2016)                                                                                                                      |
| Office Online Server                       | [Plan Office Online Server](/officeonlineserver/plan-office-online-server)                                                                                                                                               |
| Project Server 2016                        | [Software requirements for Project Server 2016](/project/software-requirements-for-project-server-2016)                                                                                                                  |
| Project Server 2019                        | [Software requirements for Project Server 2019](/project/software-requirements-for-project-server-2019)                                                                                                                  |
| SharePoint Server 2016                     | [Hardware and software requirements for SharePoint Server 2016](/SharePoint/install/hardware-and-software-requirements)                                                                                                  |
| SharePoint Server 2019                     | [Hardware and software requirements for SharePoint Server 2019](/sharepoint/install/hardware-and-software-requirements-2019)                                                                                             |
| Skype for Business Server 2015             | [How to install Skype for Business Server 2015 on Windows Server 2016](https://support.microsoft.com/help/4015888/how-to-install-skype-for-business-server-2015-on-windows-server-2016)                                  |
| SQL Server 2012                            | [Hardware and Software Requirements for Installing SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110))                                                                                          |
| SQL Server 2014                            | [Hardware and Software Requirements for Installing SQL Server 2014](/previous-versions/sql/2014/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true) |
| SQL Server 2016                            | [Hardware and Software Requirements for Installing SQL Server 2016](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2016&preserve-view=true)                        |
| SQL Server 2017                            | [Hardware and Software Requirements for Installing SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017&preserve-view=true)                        |
| SQL Server 2019                            | [Hardware and Software Requirements for Installing SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2019?view=sql-server-ver15&preserve-view=true)                  |
| SQL Server 2022                            | [Hardware and Software Requirements for Installing SQL Server 2022](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver16&preserve-view=true)                  |
| System Center Virtual Machine Manager 2016 | [What's New in System Center](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true)                                                              |
| System Center Operations Manager 2016      | [What's New in System Center](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true)                                                              |
| System Center Data Protection Manager 2016 | [What's New in System Center](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2014&preserve-view=true)                                                              |
| Visual Studio Team Foundation Server 2017  | [Team Foundation Server 2017](https://www.visualstudio.com/news/releasenotes/tfs2017-relnotes)                                                                                                                           |

::: zone-end
