---
title: Roles, Role Services, and Features not in Windows Server - Server Core
description: Learn about the roles and features not included in the Server Core installation option for Windows Server.
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 02/23/2018
---
# Roles, Role Services, and Features not in Windows Server - Server Core

> Applies to: Windows Server 2019, Windows Server 2016, and Windows Server (Semi-Annual Channel)

The following roles, role services, and features have been removed from the Server Core installation option of Windows Server. Use this information to help figure out if the Server Core option works for your environment.

> [!NOTE]
> You can also see a list of the roles, role services, and features that [ARE included in Server Core](server-core-roles-and-services.md). It's a very large list, so for best results, search that list for the specific role or feature you're interested in.

## Roles not in Server Core

- Fax
- MultiPointServerRole
- NPAS
- WDS

## Role Services not in Server Core
Note that some Remote Desktop role services are included in Server Core (Connection Broker, Licensing, Virtualization Host), but others are NOT (Gateway, RD Session Host, Web Access).

- Print-Scan-Server
- Print-Internet
- RDS-Gateway
- RDS-RD-Server
- RDS-Web-Access
- Web-Mgmt-Console
- Web-Lgcy-Mgmt-Console
- WDS-Deployment
- WDS-Transport *(before Windows Server version 1803)*

## Features not in Server Core

- BITS-IIS-Ext
- BitLocker-NetworkUnlock
- Direct-Play
- Internet-Print-Client
- LPR-Port-Monitor
- MSMQ-Multicasting
- CMAK
- Remote-Assistance
- RSAT-SMTP
- RSAT-Feature-Tools-BitLocker-RemoteAdminTool
- RSAT-Bits-Server
- RSAT-NLB
- RSAT-SNMP
- RSAT-WINS
- Hyper-V-Tools
- RSAT-RDS-Tools
- RSAT-RDS-Gateway
- RSAT-RDS-Licensing-Diagnosis-UI
- RDS-Licensing-UI
- UpdateServices-UI
- RSAT-ADCS
- RSAT-ADCS-Mgmt
- RSAT-Online-Responder
- RSAT-ADRMS
- RSAT-Fax
- RSAT-File-Services
- RSAT-DFS-Mgmt-Con
- RSAT-FSRM-Mgmt
- RSAT-NFS-Admin
- RSAT-NPAS
- RSAT-Print-Services
- RSAT-VA-Tools
- WDS-AdminPack
- SMTP-Server
- TFTP-Client
- WebDAV-Redirector
- Biometric-Framework
- Windows-Defender-Gui
- Windows-Identity-Foundation
- PowerShell-ISE
- Search-Service
- Windows-TIFF-IFilter
- Wireless-Networking
- XPS-Viewer

