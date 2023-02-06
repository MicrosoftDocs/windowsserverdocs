---
title: Comparison of Standard and Datacenter editions Windows Server 2019
description: Comparison of Standard and Datacenter editions of Windows Server 2019.
ms.topic: conceptual
author: jasongerend
ms.author: alalve
ms.date: 09/16/2022
ms.prod: windows-server
---

# Comparison of Standard and Datacenter editions of Windows Server 2019

Use this article to compare Standard and Datacenter editions of Windows Server 2019 to see which will be most appropriate.

## Features generally available

# [Full Comparison](#tab/full-comparison)

|Features available generally|Windows Server 2019 Standard|Windows Server 2019 Datacenter|
|-------------------|----------|---------------------------|
|Best Practices Analyzer|Yes|Yes|
|Direct Access|Yes|Yes|
|Dynamic Memory (in virtualization)|Yes|Yes|
|Hot Add/Replace RAM|Yes|Yes|
|Microsoft Management Console|Yes|Yes|
|Minimal Server Interface|Yes|Yes|
|Network Load Balancing|Yes|Yes|
|Windows PowerShell|Yes|Yes|
|Server Core installation option|Yes|Yes|
|Server Manager|Yes|Yes|
|SMB Direct and SMB over RDMA|Yes|Yes|
|Software-defined Networking|No| **Yes** |
|Storage Migration  Service|Yes|Yes|
| Storage Replica | Yes, (1 partnership and 1 resource group with a single 2TB volume) | Yes, **unlimited** |
|Storage Spaces|Yes|Yes|
|Storage Spaces Direct|No| **Yes** |
|Volume Activation Services|Yes|Yes|
|VSS (Volume Shadow Copy Service) integration|Yes|Yes|
|Windows Server Update Services|Yes|Yes|
|Server license logging|Yes|Yes|
|Inherited activation|As guest if hosted on Datacenter| **Can be a host or a guest** |
|Work Folders|Yes|Yes|

# [Version Differences](#tab/version-differences)

|Features available generally|Windows Server 2019 Standard|Windows Server 2019 Datacenter|
|-------------------|----------|---------------------------|
|Software-defined Networking|No| **Yes** |
| Storage Replica | Yes, (1 partnership and 1 resource group with a single 2TB volume) | Yes, **unlimited** |
|Storage Spaces Direct|No| **Yes** |
|Inherited activation|As guest if hosted on Datacenter| **Can be a host or a guest** |

---

## Locks and Limits

# [Full Comparison](#tab/full-comparison)

| Locks and Limits                 | Windows Server 2019 Standard | Windows Server 2019 Datacenter |
| -------------------              | ---------------------------  | --------------------------- |
| Maximum number of users          | Based on CALs                | Based on CALs |
| Maximum SMB connections          | 16,777,216                   | 16,777,216 |
| Maximum RRAS connections         | unlimited                    | unlimited |
| Maximum IAS connections          | 2,147,483,647                | 2,147,483,647 |
| Maximum RDS connections          | 65,535                       | 65,535 |
| Maximum number of 64-bit sockets | 64                           | 64 |
| Maximum number of cores          | unlimited                    | unlimited |
| Maximum RAM                      | 24 TB                        | 24 TB |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license|Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Server can join a domain        | yes                           | yes |
| Edge network protection/firewall| no                            | no    |
| DirectAccess                    | yes                           | yes |
| DLNA codecs and web media streaming | Yes, if installed as Server with Desktop Experience | Yes, if installed as Server with Desktop Experience |

# [Version Differences](#tab/version-differences)

| Locks and Limits                 | Windows Server 2019 Standard | Windows Server 2019 Datacenter |
| -------------------              | ---------------------------  | --------------------------- |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license|Yes; **unlimited virtual machines**, plus one Hyper-V host per license |

---

## Server roles

# [Full Comparison](#tab/full-comparison)

|Windows Server roles available|Role services|Windows Server 2019 Standard|Windows Server 2019 Datacenter|
|-------------------|----------|----------|---------------------------|
|Active Directory Certificate Services| |Yes|Yes|
|Active Directory Domain Services| |Yes|Yes|
|Active Directory Federation Services| |Yes|Yes|
|Active Directory Lightweight Directory Services| |Yes|Yes|
|Active Directory Rights Management Services| |Yes|Yes|
|Device Health Attestation| |Yes|Yes|
|DHCP Server| |Yes|Yes|
|DNS Server| |Yes|Yes|
|Fax Server| |Yes|Yes|
|File and Storage Services|File Server|Yes|Yes|
|File and Storage Services|BranchCache for Network Files|Yes|Yes|
|File and Storage Services|Data Deduplication|Yes|Yes|
|File and Storage Services|DFS Namespaces|Yes|Yes|
|File and Storage Services|DFS Replication|Yes|Yes|
|File and Storage Services|File Server Resource Manager|Yes|Yes|
|File and Storage Services|File Server VSS Agent Service|Yes|Yes|
|File and Storage Services|iSCSI Target Server|Yes|Yes|
|File and Storage Services|iSCSI Target Storage Provider|Yes|Yes|
|File and Storage Services|Server for NFS|Yes|Yes|
|File and Storage Services|Work Folders|Yes|Yes|
|File and Storage Services|Storage Services|Yes|Yes|
|Host Guardian Service| |Yes|Yes|
|Hyper-V| |Yes|Yes; including Shielded Virtual Machines|
|Network Controller| |No| **Yes** |
|Network Policy and Access Services| |Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Print and Document Services| |Yes|Yes|
|Remote Access| |Yes|Yes|
|Remote Desktop Services| |Yes|Yes|
|Volume Activation Services| |Yes|Yes|
|Web Services (IIS)| |Yes|Yes|
|Windows Deployment Services| |Yes*|Yes*|
|Windows Server Update Services| |Yes|Yes|

> [!NOTE]
> WDS Transport Server is new to Server Core installations in Windows Server 2019 and also included in the Semi-Annual Channel starting with Windows Server version 1803.

# [Version Differences](#tab/version-differences)

|Windows Server roles available|Role services|Windows Server 2019 Standard|Windows Server 2019 Datacenter|
|-------------------|----------|----------|---------------------------|
|Network Controller| |No| **Yes** |

---

## Features

# [Full Comparison](#tab/full-comparison)

|Windows Server Features available|Windows Server 2019 Standard|Windows Server 2019 Datacenter|
|-------------------|----------|---------------------------|
|.NET Framework 3.5 |Yes|Yes|
|.NET Framework 4.7 |Yes|Yes|
|Background Intelligent Transfer Service (BITS)|Yes|Yes|
|BitLocker Drive Encryption|Yes|Yes|
|BitLocker Network Unlock|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|BranchCache|Yes|Yes|
|Client for NFS|Yes|Yes|
|Containers|Yes (unlimited Windows containers; up to two Hyper-V containers)|Yes (**unlimited Windows and Hyper-V containers**) |
|Data Center Bridging|Yes|Yes|
|Direct Play|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Enhanced Storage|Yes|Yes|
|Failover Clustering|Yes|Yes|
|Group Policy Management|Yes|Yes|
|Host Guardian Hyper-V Support|No| **Yes** |
|I/O Quality of Service|Yes|Yes|
|IIS Hostable Web Core|Yes|Yes|
|Internet Printing Client|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|IP Address Management (IPAM) Server|Yes|Yes|
|iSNS Server service|Yes|Yes|
|LPR Port Monitor|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Management OData IIS Extension|Yes|Yes|
|Media Foundation|Yes|Yes|
|Message Queueing|Yes|Yes|
|Multipath I/O|Yes|Yes|
|MultiPoint Connector|Yes|Yes|
|Network Load Balancing|Yes|Yes|
|Peer Name Resolution Protocol|Yes|Yes|
|Quality Windows Audio Video Experience|Yes|Yes|
|RAS Connection Manager Administration Kit (CMAK)|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Remote Assistance|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Remote Differential Compression|Yes|Yes|
|Remote Server Administration Tools (RSAT)|Yes|Yes|
|RPC over HTTP Proxy|Yes|Yes|
|Setup and Boot Event Collection|Yes|Yes|
|Simple TCP/IP Services|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|SMB 1.0/CIFS File Sharing Support|Yes|Yes|
|SMB Bandwidth Limit|Yes|Yes|
|SMTP Server|Yes|Yes|
|SNMP Service|Yes|Yes|
|Software Load Balancer|Yes|Yes|
|Storage Migration Service|Yes|Yes|
|Storage Migration Service Proxy|Yes|Yes|
|Storage Replica|Yes|Yes|
|System Data Archiver|Yes|Yes|
|System Insights|Yes|Yes|
|Telnet Client|Yes|Yes|
|TFTP Client|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|VM Shielding Tools for Fabric Management|Yes|Yes|
|WebDAV Redirector|Yes|Yes|
|Windows Biometric Framework|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Windows Defender Antivirus|Yes|Yes|
|Windows Identity Foundation 3.5|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Windows Internal Database|Yes|Yes|
|Windows PowerShell|Yes|Yes|
|Windows Process Activation Service|Yes|Yes|
|Windows Search Service|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Windows Server Backup|Yes|Yes|
|Windows Server Migration Tools|Yes|Yes|
|Windows Standards-Based Storage Management|Yes|Yes|
|Windows Subsystem for Linux|Yes|Yes|
|Windows TIFF IFilter|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|WinRM IIS Extension|Yes|Yes|
|WINS Server|Yes|Yes|
|Wireless LAN Service|Yes|Yes|
|WoW64 Support|Yes|Yes|
|XPS Viewer|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|

# [Version Differences](#tab/version-differences)

|Windows Server Features available|Windows Server 2019 Standard|Windows Server 2019 Datacenter|
|-------------------|----------|---------------------------|
|Containers|Yes (unlimited Windows containers; up to two Hyper-V containers)|Yes (**unlimited Windows and Hyper-V containers**) |
|Host Guardian Hyper-V Support|No| **Yes** |

---
