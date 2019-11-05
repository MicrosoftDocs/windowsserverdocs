---
title: Roles, Role Services, and Features not in Windows Server - Server Core
description: Learn about the roles and features not included in the Server Core installation option for Windows Server.
ms.prod: windows-server
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

- Fax Server (**Fax**)
- MultiPoint Services (**MultiPointServerRole**)
- Network Policy and Access Services (**NPAS**)
- Windows Deployment Services (**WDS**) *(before Windows Server version 1803)*

## Role Services not in Server Core
Note that some Remote Desktop role services are included in Server Core (Connection Broker, Licensing, Virtualization Host), but others are NOT (Gateway, RD Session Host, Web Access).

- Print and Document Services \ Distributed Scan Server (**Print-Scan-Server**)
- Print and Document Services \ Internet Printing (**Print-Internet**)
- Remote Desktop Services \ Remote Desktop Gateway (**RDS-Gateway**)
- Remote Desktop Services \ Remote Desktop Session Host (**RDS-RD-Server**)
- Remote Desktop Services \ Remote Desktop Web Access (**RDS-Web-Access**)
- Role Service Web Server (IIS) \ Management Tools \ IIS Management Console (**Web-Mgmt-Console**)
- Role Service Web Server (IIS) \ Management Tools \ IIS 6 Management Compatibility \ IIS 6 Management Console (**Web-Lgcy-Mgmt-Console**)
- Windows Deployment Services \ Deployment Server (**WDS-Deployment**)
- Windows Deployment Services \ Transport Server (**WDS-Transport**) *(before Windows Server version 1803)*

## Features not in Server Core
- Background Intelligent Transfer Service (BITS) \ IIS Server Extension (**BITS-IIS-Ext**)
- BitLocker Network Unlock (**BitLocker-NetworkUnlock**)
- Direct Play (**Direct-Play**)
- Internet Printing Client (**Internet-Print-Client**)
- LPR Port Monitor (**LPR-Port-Monitor**)
- Message Queuing \ Message Queuing Services \ Multicasting Support (**MSMQ-Multicasting**)
- RAS Connection Manager Administration Kit (**CMAK**)
- Remote Assistance (**Remote-Assistance**)
- Remote Server Administration Tools \ Feature Administration Tools \ SMTP Server Tools (**RSAT-SMTP**)
- Remote Server Administration Tools \ Feature Administration Tools \ BitLocker Drive Encryption Administration Utilities \ BitLocker Drive Encryption Tools (**RSAT-Feature-Tools-BitLocker-RemoteAdminTool**)
- Remote Server Administration Tools \ Feature Administration Tools \ BITS Server Extensions Tools (**RSAT-Bits-Server**)
- Remote Server Administration Tools \ Feature Administration Tools \ Network Load Balancing Tools (**RSAT-NLB**)
- Remote Server Administration Tools \ Feature Administration Tools \ SNMP Tools (**RSAT-SNMP**)
- Remote Server Administration Tools \ Feature Administration Tools \ WINS Server Tools (**RSAT-WINS**)
- Remote Server Administration Tools \ Role Administration Tools \ Hyper-V Management Tools \ Hyper-V GUI Management Tools (**Hyper-V-Tools**)
- Remote Server Administration Tools \ Role Administration Tools \ Remote Desktop Services Tools \ Remote Desktop Gateway Tools (**RSAT-RDS-Tools**)
- Remote Server Administration Tools \ Role Administration Tools \ Remote Desktop Services Tools \ Remote Desktop Gateway Tools (**RSAT-RDS-Gateway**)
- Remote Server Administration Tools \ Role Administration Tools \ Remote Desktop Services Tools \ Remote Desktop Licensing Diagnoser Tools (**RSAT-RDS-Licensing-Diagnosis-UI**)
- Remote Server Administration Tools \ Role Administration Tools \ Remote Desktop Services Tools \ Remote Desktop Licensing Tools (**RDS-Licensing-UI**)
- Remote Server Administration Tools \ Role Administration Tools \ Windows Server Update Services Tools \ User Interface Management Console (**UpdateServices-UI**)
- Remote Server Administration Tools \ Role Administration Tools \ Active Directory Certificate Services Tools (**RSAT-ADCS**)
- Remote Server Administration Tools \ Role Administration Tools \ Active Directory Certificate Services Tools \ Certification Authority Management Tools (**RSAT-ADCS-Mgmt**)
- Remote Server Administration Tools \ Role Administration Tools \ Active Directory Certificate Services Tools \ Online Responder Tools (**RSAT-Online-Responder**)
- Remote Server Administration Tools \ Role Administration Tools \ Active Directory Rights Management Services Tools (**RSAT-ADRMS**)
- Remote Server Administration Tools \ Role Administration Tools \ Fax Server Tools (**RSAT-Fax**)
- Remote Server Administration Tools \ Role Administration Tools \ File Services Tools (**RSAT-File-Services**)
- Remote Server Administration Tools \ Role Administration Tools \ File Services Tools \ DFS Management Tools (**RSAT-DFS-Mgmt-Con**)
- Remote Server Administration Tools \ Role Administration Tools \ File Services Tools \ File Server Resource Manager Tools (**RSAT-FSRM-Mgmt**)
- Remote Server Administration Tools \ Role Administration Tools \ File Services Tools \ Services for Network File System Management Tools (**RSAT-NFS-Admin**)
- Remote Server Administration Tools \ Role Administration Tools \ Network Policy and Access Services Tools (**RSAT-NPAS**)
- Remote Server Administration Tools \ Role Administration Tools \ Print and Document Services Tools (**RSAT-Print-Services**)
- Remote Server Administration Tools \ Role Administration Tools \ Volume Activation Tools (**RSAT-VA-Tools**)
- Remote Server Administration Tools \ Role Administration Tools \ Windows Deployment Services Tools (**WDS-AdminPack**)
- Simple TCP/IP Services (**Simple-TCPIP**)
- SMTP Server (**SMTP-Server**)
- TFTP Client (**TFTP-Client**)
- WebDAV Redirector (**WebDAV-Redirector**)
- Windows Biometric Framework (**Biometric-Framework**)
- Windows Defender Features \ GUI for Windows Defender (**Windows-Defender-Gui**)
- Windows Identity Foundation 3.5 (**Windows-Identity-Foundation**)
- Windows PowerShell \ Windows PowerShell ISE (**PowerShell-ISE**)
- Windows Search Service (**Search-Service**)
- Windows TIFF IFilter (**Windows-TIFF-IFilter**)
- Wireless LAN Service (**Wireless-Networking**)
- XPS Viewer (**XPS-Viewer**)
