---
title: Comparison of Standard, Datacenter, and Datacenter Azure Edition editions of Windows Server 2022
description: Comparison of Standard, Datacenter, and Datacenter Azure Edition editions of Windows Server 2022.
ms.topic: conceptual
author: dknappettmsft
ms.author: alalve
manager: femila
ms.date: 09/16/2022
ms.prod: windows-server
---

# Comparison of Standard, Datacenter, and Datacenter: Azure Edition editions of Windows Server 2022

Use this article to compare Standard, Datacenter, and Datacenter: Azure Edition editions of Windows Server 2022 to see which will be most appropriate.

## Features generally available

# [Full Comparison](#tab/full-comparison)

|Features available generally|Windows Server 2022 Standard|Windows Server 2022 Datacenter|Windows Server 2022 Datacenter: Azure Edition|
|--|--|--|--|
|Azure Extended Network|No|No|**Yes**|
|Best Practices Analyzer|Yes|Yes|Yes|
|Containers|Yes|Yes|Yes|
|Direct Access|Yes|Yes|Yes|
|Dynamic Memory (in virtualization)|Yes|Yes|Yes|
|Hot Add/Replace RAM|Yes|Yes|Yes|
|Hotpatching|No|No|**Yes**|
|Microsoft Management Console|Yes|Yes|Yes|
|Minimal Server Interface|Yes|Yes|Yes|
|Network Load Balancing|Yes|Yes|Yes|
|Windows PowerShell|Yes|Yes|Yes|
|Server Core installation option|Yes|Yes|Yes|
|Server Manager|Yes|Yes|Yes|
|SMB Direct and SMB over RDMA|Yes|Yes|Yes (not supported in Azure)|
|SMB Compression|Yes|Yes|Yes|
|SMB over QUIC|No|No|**Yes**|
|Software-defined Networking|No|**Yes**|**Yes**|
|Storage Migration Service|Yes|Yes|Yes|
|Storage Replica| Yes, (1 partnership and 1 resource group with a single 2TB volume) | Yes, **unlimited** | Yes, **unlimited** |
|Storage Replica Compression|No|No|**Yes**|
|Storage Spaces|Yes|Yes|Yes|
|Storage Spaces Direct|No|**Yes**|**Yes**|
|Volume Activation Services|Yes|Yes|Yes, (Cannot Configure as a KMS host)|
|VSS (Volume Shadow Copy Service) integration|Yes|Yes|Yes|
|Windows Server Update Services|Yes|Yes|Yes|
|Server license logging|Yes|Yes|Yes|
|Inherited activation|As guest if hosted on Datacenter| **Can be a host or a guest** | **Can be a host or a guest** |
|Work Folders|Yes|Yes|Yes|

# [Version Differences](#tab/version-differences)

|Features available generally|Windows Server 2022 Standard|Windows Server 2022 Datacenter|Windows Server 2022 Datacenter: Azure Edition|
|-------------------|----------|---------------------------|
|Azure Extended Network|No|No|**Yes**|
|Hotpatching|No|No|**Yes**|
|SMB over QUIC|No|No|**Yes**|
|Software-defined Networking|No|**Yes**|**Yes**|
|Storage Replica| Yes, (1 partnership and 1 resource group with a single 2TB volume) | Yes, **unlimited** | Yes, **unlimited** |
|Storage Spaces Direct|No|**Yes**|**Yes**|
|Inherited activation|As guest if hosted on Datacenter| **Can be a host or a guest** | **Can be a host or a guest** |

---

## Locks and Limits

# [Full Comparison](#tab/full-comparison)

| Locks and Limits                 | Windows Server 2022 Standard | Windows Server 2022 Datacenter |
| -------------------              | ---------------------------  | --------------------------- |
| Maximum number of users          | Based on CALs                | Based on CALs |
| Maximum SMB connections          | 16,777,216                   | 16,777,216 |
| Maximum RRAS connections         | Unlimited                    | Unlimited |
| Maximum IAS connections          | 2,147,483,647                | 2,147,483,647 |
| Maximum RDS connections          | 65,535                       | 65,535 |
| Maximum number of 64-bit sockets | 64                           | 64 |
| Maximum number of cores          | Unlimited                    | Unlimited |
| Maximum RAM                      | 48 TB                        | 48 TB |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Windows Server Containers | Unlimited | Unlimited |
| Virtual OSE/Hyper-V isolated Containers | 2 | Unlimited |
| Server can join a domain        | Yes                           | Yes |
| Edge network protection/firewall| No                            | No  |
| DirectAccess                    | Yes                           | Yes |
| DLNA codecs and web media streaming | Yes, if installed as Server with Desktop Experience | Yes, if installed as Server with Desktop Experience |

# [Version Differences](#tab/version-differences)

| Locks and Limits                 | Windows Server 2022 Standard | Windows Server 2022 Datacenter |
| -------------------              | ---------------------------  | --------------------------- |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |

---

## Server roles

# [Full Comparison](#tab/full-comparison)

|Windows Server roles available|Role services|Windows Server 2022 Standard|Windows Server 2022 Datacenter|
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
|Windows Deployment Services| |Yes|Yes|
|Windows Server Update Services| |Yes|Yes|

# [Version Differences](#tab/version-differences)

|Windows Server roles available|Role services|Windows Server 2022 Standard|Windows Server 2022 Datacenter|
|-------------------|----------|----------|---------------------------|
|Network Controller| |No| **Yes** |

---

## Features

# [Full Comparison](#tab/full-comparison)

|Windows Server Features available|Windows Server 2022 Standard|Windows Server 2022 Datacenter|
|-------------------|----------|---------------------------|
|.NET Framework 3.5 |Yes|Yes|
|.NET Framework 4.8 |Yes|Yes|
|Background Intelligent Transfer Service (BITS)|Yes|Yes|
|BitLocker Drive Encryption|Yes|Yes|
|BitLocker Network Unlock|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|BranchCache|Yes|Yes|
|Client for NFS|Yes|Yes|
|Containers|Yes|Yes|
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
|LPR Port Monitor|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Management OData IIS Extension|Yes|Yes|
|Media Foundation|Yes|Yes|
|Message Queueing|Yes|Yes|
|Microsoft Defender Antivirus|Yes|Yes|
|Multipath I/O|Yes|Yes|
|MultiPoint Connector|Yes|Yes|
|Network Load Balancing|Yes|Yes|
|Network Virtualization|Yes|Yes|
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
|WoW64 support|Yes|Yes|
|XPS Viewer|Yes, installed with Server with Desktop Experience|Yes, installed with Server with Desktop Experience|

# [Version Differences](#tab/version-differences)

|Windows Server Features available|Windows Server 2022 Standard|Windows Server 2022 Datacenter|
|-------------------|----------|---------------------------|
|Host Guardian Hyper-V Support|No| **Yes** |

---
