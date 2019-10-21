---
title: "Comparison of Standard and Datacenter editions of Windows Server 2019" 
ms.prod: windows-server
ms.technology: server-general
ms.topic: article
ms.assetid: c5ca3bfe-7ced-49f6-2932-80cab33fe914
author: jasongerend
ms.author: jgerend
manager: jasgroce
ms.localizationpriority: medium
---
# Comparison of Standard and Datacenter editions of Windows Server 2019

> Applies To: Windows Server 2019
  
## Locks and Limits

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
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license|Yes; <strong>unlimited virtual machines</strong>, plus one Hyper-V host per license |
| Server can join a domain        | yes                           | yes |
| Edge network protection/firewall| no                            | no    |
| DirectAccess                    | yes                           | yes |
| DLNA codecs and web media streaming | Yes, if installed as Server with Desktop Experience | Yes, if installed as Server with Desktop Experience |

## Server roles

|Windows Server roles available|Role services|Windows Server 2019 Standard|Windows Server 2019 Datacenter|  
|-------------------|----------|----------|---------------------------|  
|Active Directory Certificate Services| |Yes|Yes|
|Active Directory Domain Services| |Yes|Yes|
|Active Directory Federation Services| |Yes|Yes|
|AD Lightweight Directory Services| |Yes|Yes|
|AD Rights Management Services| |Yes|Yes|
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
|Network Controller| |No| <strong>Yes</strong> |
|Network Policy and Access Services| |Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Print and Document Services| |Yes|Yes|
|Remote Access| |Yes|Yes|
|Remote Desktop Services| |Yes|Yes|
|Volume Activation Services| |Yes|Yes|
|Web Services (IIS)| |Yes|Yes|
|Windows Deployment Services| |Yes*|Yes*|
|Windows Server Essentials Experience| |No | No |
|Windows Server Update Services| |Yes|Yes|

*WDS Transport Server is new to Server Core installations in Windows Server 2019 (also in the semi-annual channel starting with Windows Server, version 1803)


## Features

|Windows Server Features installable with Server Manager (or PowerShell)|Windows Server 2019 Standard|Windows Server 2019 Datacenter|  
|-------------------|----------|---------------------------|  
|.NET Framework 3.5 |Yes|Yes|
|.NET Framework 4.7 |Yes|Yes|
|Background Intelligent Transfer Service (BITS)|Yes|Yes|
|BitLocker Drive Encryption|Yes|Yes|
|BitLocker Network Unlock|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|BranchCache|Yes|Yes|
|Client for NFS|Yes|Yes|
|Containers|Yes (unlimited Windows containers; up to two Hyper-V containers)|Yes (<strong>unlimited Windows and Hyper-V containers</strong>) |
|Data Center Bridging|Yes|Yes|
|Direct Play|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Enhanced Storage|Yes|Yes|
|Failover Clustering|Yes|Yes|
|Group Policy Management|Yes|Yes|
|Host Guardian Hyper-V Support|No| <strong>Yes</strong> |
|I/O Quality of Service|Yes|Yes|
|IIS Hostable Web Core|Yes|Yes|
|Internet Printing Client|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|IPAM Server|Yes|Yes|
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
|RAS Connection Manager Administration Kit|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Remote Assistance|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Remote Differential Compression|Yes|Yes|
|RSAT|Yes|Yes|
|RPC over HTTP Proxy|Yes|Yes|
|Setup and Boot Event Collection|Yes|Yes|
|Simple TCP/IP Services|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|SMB 1.0/CIFS File Sharing Support|Installed|Installed|
|SMB Bandwidth Limit|Yes|Yes|
|SMTP Server|Yes|Yes|
|SNMP Service|Yes|Yes|
|Software Load Balancer|Yes|Yes|
|Storage Replica|Yes|Yes|
|Telnet Client|Yes|Yes|
|TFTP Client|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|VM Shielding Tools for Fabric Management|Yes|Yes|
|WebDAV Redirector|Yes|Yes|
|Windows Biometric Framework|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Windows Defender features|Installed|Installed|
|Windows Identity Foundation 3.5|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Windows Internal Database|Yes|Yes|
|Windows PowerShell|Installed|Installed|
|Windows Process Activation Service|Yes|Yes|
|Windows Search Service|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|Windows Server Backup|Yes|Yes|
|Windows Server Migration Tools|Yes|Yes|
|Windows Standards-Based Storage Management|Yes|Yes|
|Windows TIFF IFilter|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|
|WinRM IIS Extension|Yes|Yes|
|WINS Server|Yes|Yes|
|Wireless LAN Service|Yes|Yes|
|WoW64 support|Installed|Installed|
|XPS Viewer|Yes, when installed as Server with Desktop Experience|Yes, when installed as Server with Desktop Experience|

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
|Software-defined Networking|No| <strong>Yes</strong> |
|Storage Migration  Service|Yes|Yes|
| Storage Replica         | Yes, (1 partnership and 1 resource group with a single 2TB volume)    | Yes, <strong>unlimited</strong> |
|Storage Spaces|Yes|Yes|
|Storage Spaces Direct|No| <strong>Yes</strong> |
|Volume Activation Services|Yes|Yes|
|VSS (Volume Shadow Copy Service) integration|Yes|Yes|
|Windows Server Update Services|Yes|Yes|
|Windows System Resource Manager|Yes|Yes|
|Server license logging|Yes|Yes|
|Inherited activation|As guest if hosted on Datacenter| <strong>Can be a host or a guest</strong> |
|Work Folders|Yes|Yes|
