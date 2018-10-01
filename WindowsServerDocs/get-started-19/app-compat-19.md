---
title: Microsoft Server Application Compatibility
description: "Compatibility table for Server 2019 and Microsoft server applications."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2afe7c32-1fda-4441-989b-4115dabdcd27
author: coreyp
ms.author: coreyp-at-msft
manager: jasgroce
ms.localizationpriority: medium
---
# Windows Server 2019 and Microsoft Server Application Compatibility

>Applies To: Windows Server 2019

This table lists Microsoft server applications that support installation and functionality on Window Server 2019. This information is for quick reference and is not intended to replace the individual product specifications, requirements, announcements, or general communications of each individual server application. Refer to official documentation for each product to fully understand compatibility and options.

For customers and software vendor partners looking for more information on Windows Server compatibility with non-Microsoft applications, visit the [Commercial App Certification portal](https://commercialappcertification.microsoft.com/).


| Product                                                      | Released? | Supported on Server with Desktop Experience | Supported on Server Core                 | Product Web Link                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|--------------------------------------------------------------|-----------|---------------------------------------------|------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Microsoft SQL Server 2016                                    | Yes       | Yes                                         | Yes\*                                    | [Hardware and Software Requirements for Installing SQL Server 2016](https://docs.microsoft.com/en-us/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2016) |
| Microsoft SQL Server 2017                                    | Yes       | Yes                                         | Yes\*                                    | [Hardware and Software Requirements for Installing SQL Server 2017](https://docs.microsoft.com/en-us/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017)   |
| Microsoft System Center Virtual Machine Manager 2019         | No        | Yes                                         | No                                       | [Overview of System Center release options](https://docs.microsoft.com/en-us/system-center/ltsc-and-sac-overview)                                                                                                        |
| Microsoft System Center Operations Manager 2019              | No        | Yes                                         | No                                       | [Overview of System Center release options](https://docs.microsoft.com/en-us/system-center/ltsc-and-sac-overview)                                                                                                        |
| Microsoft System Center Data Protection Manager 2019         | No        | Yes                                         | No                                       | [Overview of System Center release options](https://docs.microsoft.com/en-us/system-center/ltsc-and-sac-overview)                                                                                                    |
| Microsoft System Center Configuration Manager (version 1806) | Yes       | Yes as managed client, No as site server    | Yes as managed client, No as site server | [What's new in version 1806 of System Center Configuration Manager](https://docs.microsoft.com/en-us/sccm/core/plan-design/changes/whats-new-in-version-1806)                                                    |
| SharePoint Server 2016                                       | Yes       | Yes                                         | No                                       | [Hardware and software requirements for SharePoint Server 2016](https://docs.microsoft.com/en-us/SharePoint/install/hardware-and-software-requirements)                                                                                    |
| SharePoint Server 2019                                       | No        | Yes                                         | No                                       | [Hardware and software requirements for SharePoint Server 2019](https://docs.microsoft.com/en-us/sharepoint/install/hardware-and-software-requirements-2019)                                                     |
| Project Server 2016                                          | Yes       | Yes                                         | No                                       | [Software requirements for Project Server 2016](https://docs.microsoft.com/en-us/project/software-requirements-for-project-server-2016)                                                                                                    |
| Project Server 2019                                          | No        | Yes                                         | No                                       | [Install and configure Project Servers 2016 or 2019](https://docs.microsoft.com/en-us/project/install-and-configure-project-server-2016)                                                                           |
| Exchange Server 2019                                         | No        | Yes                                         | Yes                                      | [Exchange Server system requirements](https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/system-requirements?view=exchserver-2019)                                                                          |
| Host Integration Server 2016, CU3                            | No        | Yes                                         | Yes                                      | [Host Integration Server system requirements](https://docs.microsoft.com/en-us/host-integration-server/install-and-config-guides/system-requirements)                                                                |
| Visual Studio Team Foundation Server 2017                    | Yes       | Yes                                         | Yes\*                                    | [Team Foundation Server 2017](https://docs.microsoft.com/en-us/visualstudio/releasenotes/tfs2017-relnotes)                                                                                                                       |

\*May have limitations or may require the Server Core App Compatibility feature
on demand (FOD).  Please refer to specific product or FOD documentation.


