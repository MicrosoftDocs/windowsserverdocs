---
title: Comparison of Windows Server editions
description: "Learn about the differences between Windows Server Standard, Datacenter, Datacenter: Azure Edition and Annual Channel for Containers editions."
ms.topic: product-comparison
author: robinharwood
ms.author: roharwoo
ms.date: 05/01/2025
zone_pivot_groups: windows-os-version
---

# Comparison of Windows Server editions

Use this article to compare the Standard, Datacenter, and Datacenter: Azure Edition of Windows Server to see which is most appropriate for you.

> [!TIP]
> If you're looking for information about the locks and limits in Windows Server, see [Comparison of locks and limits in Windows Server](locks-limits.md).

## Available roles and features

:::zone pivot="windows-server-2025"

| Feature                                          | Subfeature                                                    | Standard edition | Datacenter edition | Datacenter: Azure Edition |
|--------------------------------------------------|:--------------------------------------------------------------:|:----------------:|:------------------:|:-------------------------:|
| .NET Framework 3.5 Features                      |                                                                | ✅               | ✅                  | ✅                        |
| .NET Framework 4.8 Features                      |                                                                | ✅               | ✅                  | ✅                        |
| Activation                                       |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Automatic Virtual Machine Activation                           | ⚠️&sup1;         | ✅                  | ✅&sup2;                  |
|                                                  | Key Management Service (KMS)                                   | ✅               | ✅                  | ❌&sup3;                  |
| Active Directory Certificate Services            |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Certificate Enrollment Policy Web Service                      | ✅               | ✅                  | ✅                        |
|                                                  | Certificate Enrollment Web Service                             | ✅               | ✅                  | ✅                        |
|                                                  | Certification Authority                                        | ✅               | ✅                  | ✅                        |
|                                                  | Certification Authority Web Enrollment                         | ✅               | ✅                  | ✅                        |
|                                                  | Network Device Enrollment Service                              | ✅               | ✅                  | ✅                        |
|                                                  | Online Responder                                               | ✅               | ✅                  | ✅                        |
| Active Directory Domain Services                 |                                                                | ✅               | ✅                  | ✅                        |
| Active Directory Federation Services             |                                                                | ✅               | ✅                  | ✅                        |
| Active Directory Lightweight Directory Services  |                                                                | ✅               | ✅                  | ✅                        |
| Active Directory Rights Management Services      |                                                                | ✅               | ✅                  | ✅                        |
| Azure Extended Networking                        |                                                                | ❌               | ❌                  | ✅                        |
| Background Intelligent Transfer Service (BITS)   |                                                                | ✅               | ✅                  | ✅                        |
| BitLocker Drive Encryption                       |                                                                | ✅               | ✅                  | ✅                        |
| BitLocker Network Unlock                         |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| BranchCache                                      |                                                                | ✅               | ✅                  | ✅                        |
| Client for NFS                                   |                                                                | ✅               | ✅                  | ✅                        |
| Data Center Bridging                             |                                                                | ✅               | ✅                  | ✅                        |
| Device Health Attestation                        |                                                                | ✅               | ✅                  | ✅                        |
| DHCP Server                                      |                                                                | ✅               | ✅                  | ✅                        |
| Direct Play                                      |                                                                | ✅&#8308;         | ✅&#8308;           | ✅&#8308;                 |
| DLNA codecs and web media streaming              |                                                                | ✅&#8308;         | ✅&#8308;           | ✅&#8308;                 |
| DNS Server                                       |                                                                | ✅               | ✅                  | ✅                        |
| Enhanced Storage                                 |                                                                | ✅               | ✅                  | ✅                        |
| Failover Clustering                              |                                                                | ✅               | ✅                  | ✅                        |
| Fax Server                                       |                                                                | ✅               | ✅                  | ✅                        |
| File and Storage Services                        |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | BranchCache for Network Files                                  | ✅               | ✅                  | ✅                        |
|                                                  | Data Deduplication                                             | ✅               | ✅                  | ✅                        |
|                                                  | DFS Namespaces                                                 | ✅               | ✅                  | ✅                        |
|                                                  | DFS Replication                                                | ✅               | ✅                  | ✅                        |
|                                                  | File Server                                                    | ✅               | ✅                  | ✅                        |
|                                                  | File Server Resource Manager                                   | ✅               | ✅                  | ✅                        |
|                                                  | File Server VSS Agent Service                                  | ✅               | ✅                  | ✅                        |
|                                                  | iSCSI Target Server                                            | ✅               | ✅                  | ✅                        |
|                                                  | iSCSI Target Storage Provider (VDS and VSS hardware providers) | ✅               | ✅                  | ✅                        |
|                                                  | Server for NFS                                                 | ✅               | ✅                  | ✅                        |
|                                                  | SMB 1.0/CIFS File Sharing Support                              | ✅               | ✅                  | ✅                        |
|                                                  | SMB Bandwidth Limit                                            | ✅               | ✅                  | ✅                        |
|                                                  | SMB over QUIC                                                  | ✅               | ✅                  | ✅                        |
|                                                  | Work Folders                                                   | ✅               | ✅                  | ✅                        |
|                                                  | Storage Migration Service                                      | ✅               | ✅                  | ✅                        |
|                                                  | Storage Migration Service Proxy                                | ✅               | ✅                  | ✅                        |
|                                                  | Storage Spaces                                                 | ✅               | ✅                  | ✅                        |
|                                                  | Storage Spaces Direct                                          | ❌               | ✅                  | ✅                        |
|                                                  | Storage Replica                                                | ✅               | ✅                  | ✅                        |
| Group Policy Management                          |                                                                | ✅               | ✅                  | ✅                        |
| Host Guardian Hyper-V Support                    |                                                                | ❌               | ✅                  | ✅                        |
| Host Guardian Service                            |                                                                | ✅               | ✅                  | ✅                        |
| Hotpatching                                      |                                                                | ✅&#8309;        | ✅&#8309;           | ✅                        |
| I/O Quality of Service                           |                                                                | ✅               | ✅                  | ✅                        |
| IIS Hostable Web Core                            |                                                                | ✅               | ✅                  | ✅                        |
| IP Address Management (IPAM) Server              |                                                                | ✅               | ✅                  | ✅                        |
| Management OData IIS Extension                   |                                                                | ✅               | ✅                  | ✅                        |
| Media Foundation                                 |                                                                | ✅               | ✅                  | ✅                        |
| Message Queuing                                  |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Message Queuing DCOM Proxy                                     | ✅               | ✅                  | ✅                        |
|                                                  | Message Queuing Services                                       | ✅               | ✅                  | ✅                        |
| Microsoft Defender Antivirus                     |                                                                | ✅               | ✅                  | ✅                        |
| Multipath I/O                                    |                                                                | ✅               | ✅                  | ✅                        |
| MultiPoint Connector                             |                                                                | ✅               | ✅                  | ✅                        |
| Network ATC                                      |                                                                | ✅               | ✅                  | ✅                        |
| Network Controller                               |                                                                | ❌               | ✅                  | ✅                        |
| Network Load Balancing                           |                                                                | ✅               | ✅                  | ✅                        |
| Network Policy and Access Services               |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Network Virtualization                           |                                                                | ✅               | ✅                  | ✅                        |
| Print and Document Services                      |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Internet Printing                                              | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Line Printer Daemon (LPD) Service                              | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Print Server                                                   | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Quality Windows Audio Video Experience           |                                                                | ✅               | ✅                  | ✅                        |
| RAS Connection Manager Administration Kit (CMAK) |                                                                | ✅               | ✅                  | ✅                        |
| Remote Access                                    |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | DirectAccess and VPN (RAS)                                     | ✅               | ✅                  | ✅                        |
|                                                  | Routing                                                        | ✅               | ✅                  | ✅                        |
|                                                  | Web Application Proxy                                          | ✅               | ✅                  | ✅                        |
| Remote Assistance                                |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Remote Desktop Services                          |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Remote Differential Compression                  |                                                                | ✅               | ✅                  | ✅                        |
| Remote Server Administration Tools               |                                                                | ✅               | ✅                  | ✅                        |
| RPC over HTTP Proxy                              |                                                                | ✅               | ✅                  | ✅                        |
| Setup and Boot Event Collection                  |                                                                | ✅               | ✅                  | ✅                        |
| Simple TCP/IP Services                           |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| SNMP Service                                     |                                                                | ✅               | ✅                  | ✅                        |
| Software Load Balancer                           |                                                                | ✅               | ✅                  | ✅                        |
| System Data Archiver                             |                                                                | ✅               | ✅                  | ✅                        |
| System Insights                                  |                                                                | ✅               | ✅                  | ✅                        |
| Telnet Client                                    |                                                                | ✅               | ✅                  | ✅                        |
| TFTP Client                                      |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Virtualization                                   |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Containers                                                     | ✅               | ✅                  | ❌                        |
|                                                  | Hyper-V                                                        | ✅               | ✅                  | ✅                        |
|                                                  | GPU partitioning                                               | ✅&#8310;        | ✅                  | ✅&#8310;                 |
|                                                  | VM Shielding Tools for Fabric Management                       | ✅               | ✅                  | ✅                        |
| Volume Activation Services                       |                                                                | ✅               | ✅                  | ✅                        |
| Web Server (IIS)                                 |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | FTP Server                                                     | ✅               | ✅                  | ✅                        |
|                                                  | Web Server                                                     | ✅               | ✅                  | ✅                        |
| WebDAV Redirector                                |                                                                | ✅               | ✅                  | ✅                        |
| Windows Biometric Framework                      |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Windows Deployment Services                      |                                                                | ✅               | ✅                  | ✅                        |
| Windows Identity Foundation 3.5                  |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Windows Internal Database                        |                                                                | ✅               | ✅                  | ✅                        |
| Windows PowerShell                               |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell 2.0 Engine                                  | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell 5.1                                         | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell Desired State Configuration Service         | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell Web Access                                  | ✅               | ✅                  | ✅                        |
| Windows Process Activation Service               |                                                                | ✅               | ✅                  | ✅                        |
| Windows Server Management enabled by Azure Arc   |                                                                | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Azure Update Manager                                           | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Change Tracking and Inventory                                  | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Azure Machine Configuration                                    | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Windows Admin Center in Azure for Arc                          | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Remote Support                                                 | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Network HUD                                                    | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Best Practices Assessment                                      | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
|                                                  | Azure Site Recovery Configuration                              | ✅&#8311;        | ✅&#8311;           | ✅&#8311;                 |
| Windows Search Service                           |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Windows Server Backup                            |                                                                | ✅               | ✅                  | ✅                        |
| Windows Server Migration Tools                   |                                                                | ✅               | ✅                  | ✅                        |
| Windows Server Update Services                   |                                                                | ✅               | ✅                  | ✅                        |
| Windows Standards-Based Storage Management       |                                                                | ✅               | ✅                  | ✅                        |
| Windows Subsystem for Linux                      |                                                                | ✅               | ✅                  | ✅                        |
| Windows TIFF IFilter                             |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| WinRM IIS Extension                              |                                                                | ✅               | ✅                  | ✅                        |
| WINS Server                                      |                                                                | ✅               | ✅                  | ✅                        |
| Wireless LAN Service                             |                                                                | ✅               | ✅                  | ✅                        |
| WoW64 Support                                    |                                                                | ✅               | ✅                  | ✅                        |
| XPS Viewer                                       |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |

1. As a guest if hosted on a virtualization host activated with Datacenter edition

2. Datacenter: Azure Edition can be used as a nested host or guest

3. Activated by Azure and can't be configured as a KMS host

4. When installed as Server with Desktop Experience

5. Available as an Azure Arc-enabled service. To learn more about Azure Arc pricing, see the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)

6. Available with Windows Server 2025 Standard, and is designed for standalone servers. Live migrate VMs between standalone nodes for planned downtime. If clustering is required for unplanned downtime, Windows Server 2025 Datacenter must be used instead.

7. Available for machines enrolled in Windows Server Management enabled by Azure Arc with Windows Server licenses that have active Software Assurances or Windows Server licenses that with active subscription licenses. To learn more about the available Azure benefits, billing, and requirements, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview).

::: zone-end

:::zone pivot="windows-server-2022"

| Feature                                          | Subfeature                                                    | Standard edition | Datacenter edition | Datacenter: Azure Edition |
|--------------------------------------------------|:--------------------------------------------------------------:|:----------------:|:------------------:|:-------------------------:|
| .NET Framework 3.5 Features                      |                                                                | ✅               | ✅                  | ✅                        |
| .NET Framework 4.8 Features                      |                                                                | ✅               | ✅                  | ✅                        |
| Activation                                       |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Automatic Virtual Machine Activation                           | ⚠️&sup1;        | ✅                  | ✅                        |
|                                                  | Key Management Service  (KMS)                                  | ✅               | ✅                  | ❌&sup2;                  |
| Active Directory Certificate Services            |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Certificate Enrollment Policy Web Service                      | ✅               | ✅                  | ✅                        |
|                                                  | Certificate Enrollment Web Service                             | ✅               | ✅                  | ✅                        |
|                                                  | Certification Authority                                        | ✅               | ✅                  | ✅                        |
|                                                  | Certification Authority Web Enrollment                         | ✅               | ✅                  | ✅                        |
|                                                  | Network Device Enrollment Service                              | ✅               | ✅                  | ✅                        |
|                                                  | Online Responder                                               | ✅               | ✅                  | ✅                        |
| Active Directory Domain Services                 |                                                                | ✅               | ✅                  | ✅                        |
| Active Directory Federation Services             |                                                                | ✅               | ✅                  | ✅                        |
| Active Directory Lightweight Directory Services  |                                                                | ✅               | ✅                  | ✅                        |
| Active Directory Rights Management Services      |                                                                | ✅               | ✅                  | ✅                        |
| Background Intelligent Transfer Service (BITS)   |                                                                | ✅               | ✅                  | ✅                        |
| BitLocker Drive Encryption                       |                                                                | ✅               | ✅                  | ✅                        |
| BitLocker Network Unlock                         |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| BranchCache                                      |                                                                | ✅               | ✅                  | ✅                        |
| Client for NFS                                   |                                                                | ✅               | ✅                  | ✅                        |
| Data Center Bridging                             |                                                                | ✅               | ✅                  | ✅                        |
| Device Health Attestation                        |                                                                | ✅               | ✅                  | ✅                        |
| DHCP Server                                      |                                                                | ✅               | ✅                  | ✅                        |
| Direct Play                                      |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| DLNA codecs and web media streaming              |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| DNS Server                                       |                                                                | ✅               | ✅                  | ✅                        |
| Enhanced Storage                                 |                                                                | ✅               | ✅                  | ✅                        |
| Failover Clustering                              |                                                                | ✅               | ✅                  | ✅                        |
| Fax Server                                       |                                                                | ✅               | ✅                  | ✅                        |
| File and Storage Services                        |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | BranchCache for Network Files                                  | ✅               | ✅                  | ✅                        |
|                                                  | Data Deduplication                                             | ✅               | ✅                  | ✅                        |
|                                                  | DFS Namespaces                                                 | ✅               | ✅                  | ✅                        |
|                                                  | DFS Replication                                                | ✅               | ✅                  | ✅                        |
|                                                  | File Server                                                    | ✅               | ✅                  | ✅                        |
|                                                  | File Server Resource Manager                                   | ✅               | ✅                  | ✅                        |
|                                                  | File Server VSS Agent Service                                  | ✅               | ✅                  | ✅                        |
|                                                  | iSCSI Target Server                                            | ✅               | ✅                  | ✅                        |
|                                                  | iSCSI Target Storage Provider (VDS and VSS hardware providers) | ✅               | ✅                  | ✅                        |
|                                                  | Server for NFS                                                 | ✅               | ✅                  | ✅                        |
|                                                  | SMB 1.0/CIFS File Sharing Support                              | ✅               | ✅                  | ✅                        |
|                                                  | SMB Bandwidth Limit                                            | ✅               | ✅                  | ✅                        |
|                                                  | SMB over QUIC                                                  | ❌               | ❌                  | ✅                        |
|                                                  | Work Folders                                                   | ✅               | ✅                  | ✅                        |
|                                                  | Storage Migration Service                                      | ✅               | ✅                  | ✅                        |
|                                                  | Storage Migration Service Proxy                                | ✅               | ✅                  | ✅                        |
|                                                  | Storage Spaces                                                 | ✅               | ✅                  | ✅                        |
|                                                  | Storage Spaces Direct                                          | ❌               | ✅                  | ✅                        |
|                                                  | Storage Replica                                                | ✅               | ✅                  | ✅                        |
| Group Policy Management                          |                                                                | ✅               | ✅                  | ✅                        |
| Host Guardian Hyper-V Support                    |                                                                | ❌               | ✅                  | ✅                        |
| Host Guardian Service                            |                                                                | ✅               | ✅                  | ✅                        |
| Hotpatching                                      |                                                                | ❌               | ❌                  | ✅                        |
| I/O Quality of Service                           |                                                                | ✅               | ✅                  | ✅                        |
| IIS Hostable Web Core                            |                                                                | ✅               | ✅                  | ✅                        |
| IP Address Management (IPAM) Server              |                                                                | ✅               | ✅                  | ✅                        |
| Management OData IIS Extension                   |                                                                | ✅               | ✅                  | ✅                        |
| Media Foundation                                 |                                                                | ✅               | ✅                  | ✅                        |
| Message Queuing                                  |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Message Queuing DCOM Proxy                                     | ✅               | ✅                  | ✅                        |
|                                                  | Message Queuing Services                                       | ✅               | ✅                  | ✅                        |
| Microsoft Defender Antivirus                     |                                                                | ✅               | ✅                  | ✅                        |
| Multipath I/O                                    |                                                                | ✅               | ✅                  | ✅                        |
| MultiPoint Connector                             |                                                                | ✅               | ✅                  | ✅                        |
| Network ATC                                      |                                                                | ✅               | ✅                  | ✅                        |
| Network Controller                               |                                                                | ❌               | ✅                  | ✅                        |
| Network Load Balancing                           |                                                                | ✅               | ✅                  | ✅                        |
| Network Policy and Access Services               |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Network Virtualization                           |                                                                | ✅               | ✅                  | ✅                        |
| Print and Document Services                      |                                                                | ✅               | ✅                  |
|                                                  | Internet Printing                                              | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
|                                                  | Line Printer Daemon (LPD) Service                              | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
|                                                  | Print Server                                                   | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Quality Windows Audio Video Experience           |                                                                | ✅               | ✅                  | ✅                        |
| RAS Connection Manager Administration Kit (CMAK) |                                                                | ✅               | ✅                  | ✅                        |
| Remote Access                                    |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | DirectAccess and VPN (RAS)                                     | ✅               | ✅                  | ✅                        |
|                                                  | Routing                                                        | ✅               | ✅                  | ✅                        |
|                                                  | Web Application Proxy                                          | ✅               | ✅                  | ✅                        |
| Remote Assistance                                |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Remote Desktop Services                          |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Remote Differential Compression                  |                                                                | ✅               | ✅                  | ✅                        |
| Remote Server Administration Tools               |                                                                | ✅               | ✅                  | ✅                        |
| RPC over HTTP Proxy                              |                                                                | ✅               | ✅                  | ✅                        |
| Setup and Boot Event Collection                  |                                                                | ✅               | ✅                  | ✅                        |
| Simple TCP/IP Services                           |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| SNMP Service                                     |                                                                | ✅               | ✅                  | ✅                        |
| Software Load Balancer                           |                                                                | ✅               | ✅                  | ✅                        |
| System Data Archiver                             |                                                                | ✅               | ✅                  | ✅                        |
| System Insights                                  |                                                                | ✅               | ✅                  | ✅                        |
| Telnet Client                                    |                                                                | ✅               | ✅                  | ✅                        |
| TFTP Client                                      |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Virtualization                                   |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Containers                                                     | ✅               | ✅                  | ❌                        |
|                                                  | Hyper-V                                                        | ✅               | ✅                  | ✅                        |
|                                                  | VM Shielding Tools for Fabric Management                       | ✅               | ✅                  | ✅                        |
| Volume Activation Services                       |                                                                | ✅               | ✅                  | ✅                        |
| Web Server (IIS)                                 |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | FTP Server                                                     | ✅               | ✅                  | ✅                        |
|                                                  | Web Server                                                     | ✅               | ✅                  | ✅                        |
| WebDAV Redirector                                |                                                                | ✅               | ✅                  | ✅                        |
| Windows Biometric Framework                      |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Windows Deployment Services                      |                                                                | ✅               | ✅                  | ✅                        |
| Windows Identity Foundation 3.5                  |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Windows Internal Database                        |                                                                | ✅               | ✅                  | ✅                        |
| Windows PowerShell                               |                                                                | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell 2.0 Engine                                  | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell 5.1                                         | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell Desired State Configuration Service         | ✅               | ✅                  | ✅                        |
|                                                  | Windows PowerShell Web Access                                  | ✅               | ✅                  | ✅                        |
| Windows Process Activation Service               |                                                                | ✅               | ✅                  | ✅                        |
| Windows Search Service                           |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| Windows Server Management enabled by Azure Arc   |                                                                | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Azure Update Manager                                           | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Change Tracking and Inventory                                  | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Azure Machine Configuration                                    | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Windows Admin Center in Azure for Arc                          | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Remote Support                                                 | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Best Practices Assessment                                      | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
|                                                  | Azure Site Recovery Configuration                              | ✅&#8308;        | ✅&#8308;           | ✅&#8308;                 |
| Windows Server Backup                            |                                                                | ✅               | ✅                  | ✅                        |
| Windows Server Migration Tools                   |                                                                | ✅               | ✅                  | ✅                        |
| Windows Server Update Services                   |                                                                | ✅               | ✅                  | ✅                        |
| Windows Standards-Based Storage Management       |                                                                | ✅               | ✅                  | ✅                        |
| Windows Subsystem for Linux                      |                                                                | ✅               | ✅                  | ✅                        |
| Windows TIFF IFilter                             |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |
| WinRM IIS Extension                              |                                                                | ✅               | ✅                  | ✅                        |
| WINS Server                                      |                                                                | ✅               | ✅                  | ✅                        |
| Wireless LAN Service                             |                                                                | ✅               | ✅                  | ✅                        |
| WoW64 Support                                    |                                                                | ✅               | ✅                  | ✅                        |
| XPS Viewer                                       |                                                                | ✅&sup3;         | ✅&sup3;            | ✅&sup3;                  |

1. As a guest if hosted on a virtualization host activated with Datacenter edition

2. Activated by Azure and can't be configured as a KMS host

3. When installed as Server with Desktop Experience

4. Available for machines enrolled in Windows Server Management enabled by Azure Arc with Windows Server licenses that have active Software Assurances or Windows Server licenses that with active subscription licenses. To learn more about the available Azure benefits, billing, and requirements, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview).

::: zone-end

:::zone pivot="windows-server-2019"

| Feature                                          | Subfeature                                                    | Standard edition | Datacenter edition |
|--------------------------------------------------|:--------------------------------------------------------------:|:----------------:|:------------------:|
| .NET Framework 3.5 Features                      |                                                                | ✅               | ✅                  |
| .NET Framework 4.7 Features                      |                                                                | ✅               | ✅                  |
| Activation                                       |                                                                | ✅               | ✅                  |
|                                                  | Automatic Virtual Machine Activation                           | ⚠️&sup1;        | ✅                  |
|                                                  | Key Management Service  (KMS)                                  | ✅               | ✅                  |
| Active Directory Certificate Services            |                                                                | ✅               | ✅                  |
|                                                  | Certificate Enrollment Policy Web Service                      | ✅               | ✅                  |
|                                                  | Certificate Enrollment Web Service                             | ✅               | ✅                  |
|                                                  | Certification Authority                                        | ✅               | ✅                  |
|                                                  | Certification Authority Web Enrollment                         | ✅               | ✅                  |
|                                                  | Network Device Enrollment Service                              | ✅               | ✅                  |
|                                                  | Online Responder                                               | ✅               | ✅                  |
| Active Directory Domain Services                 |                                                                | ✅               | ✅                  |
| Active Directory Federation Services             |                                                                | ✅               | ✅                  |
| Active Directory Lightweight Directory Services  |                                                                | ✅               | ✅                  |
| Active Directory Rights Management Services      |                                                                | ✅               | ✅                  |
| Background Intelligent Transfer Service (BITS)   |                                                                | ✅               | ✅                  |
| BitLocker Drive Encryption                       |                                                                | ✅               | ✅                  |
| BitLocker Network Unlock                         |                                                                | ✅&sup2;         | ✅&sup2;            |
| BranchCache                                      |                                                                | ✅               | ✅                  |
| Client for NFS                                   |                                                                | ✅               | ✅                  |
| Data Center Bridging                             |                                                                | ✅               | ✅                  |
| Device Health Attestation                        |                                                                | ✅               | ✅                  |
| DHCP Server                                      |                                                                | ✅               | ✅                  |
| Direct Play                                      |                                                                | ✅&sup2;         | ✅&sup2;            |
| DLNA codecs and web media streaming              |                                                                | ✅&sup2;         | ✅&sup2;            |
| DNS Server                                       |                                                                | ✅               | ✅                  |
| Enhanced Storage                                 |                                                                | ✅               | ✅                  |
| Failover Clustering                              |                                                                | ✅               | ✅                  |
| Fax Server                                       |                                                                | ✅               | ✅                  |
| File and Storage Services                        |                                                                | ✅               | ✅                  |
|                                                  | BranchCache for Network Files                                  | ✅               | ✅                  |
|                                                  | Data Deduplication                                             | ✅               | ✅                  |
|                                                  | DFS Namespaces                                                 | ✅               | ✅                  |
|                                                  | DFS Replication                                                | ✅               | ✅                  |
|                                                  | File Server                                                    | ✅               | ✅                  |
|                                                  | File Server Resource Manager                                   | ✅               | ✅                  |
|                                                  | File Server VSS Agent Service                                  | ✅               | ✅                  |
|                                                  | iSCSI Target Server                                            | ✅               | ✅                  |
|                                                  | iSCSI Target Storage Provider (VDS and VSS hardware providers) | ✅               | ✅                  |
|                                                  | Server for NFS                                                 | ✅               | ✅                  |
|                                                  | SMB 1.0/CIFS File Sharing Support                              | ✅               | ✅                  |
|                                                  | SMB Bandwidth Limit                                            | ✅               | ✅                  |
|                                                  | Work Folders                                                   | ✅               | ✅                  |
|                                                  | Storage Migration Service                                      | ✅               | ✅                  |
|                                                  | Storage Migration Service Proxy                                | ✅               | ✅                  |
|                                                  | Storage Spaces                                                 | ✅               | ✅                  |
|                                                  | Storage Spaces Direct                                          | ❌               | ✅                  |
|                                                  | Storage Replica                                                | ✅               | ✅                  |
| Group Policy Management                          |                                                                | ✅               | ✅                  |
| Host Guardian Hyper-V Support                    |                                                                | ❌               | ✅                  |
| Host Guardian Service                            |                                                                | ✅               | ✅                  |
| I/O Quality of Service                           |                                                                | ✅               | ✅                  |
| IIS Hostable Web Core                            |                                                                | ✅               | ✅                  |
| IP Address Management (IPAM) Server              |                                                                | ✅               | ✅                  |
| Internet Storage Name Server (iSNS)              |                                                                | ✅               | ✅                  |
| Management OData IIS Extension                   |                                                                | ✅               | ✅                  |
| Media Foundation                                 |                                                                | ✅               | ✅                  |
| Message Queuing                                  |                                                                | ✅               | ✅                  |
|                                                  | Message Queuing DCOM Proxy                                     | ✅               | ✅                  |
|                                                  | Message Queuing Services                                       | ✅               | ✅                  |
| Microsoft Defender Antivirus                     |                                                                | ✅               | ✅                  |
| Multipath I/O                                    |                                                                | ✅               | ✅                  |
| MultiPoint Connector                             |                                                                | ✅               | ✅                  |
| Network ATC                                      |                                                                | ✅               | ✅                  |
| Network Controller                               |                                                                | ❌               | ✅                  |
| Network Load Balancing                           |                                                                | ✅               | ✅                  |
| Network Policy and Access Services               |                                                                | ✅&sup2;         | ✅&sup2;            |
| Network Virtualization                           |                                                                | ✅               | ✅                  |
| Print and Document Services                      |                                                                | ✅               | ✅                  |
|                                                  | Internet Printing                                              | ✅&sup2;         | ✅&sup2;            |
|                                                  | Line Printer Daemon (LPD) Service                              | ✅&sup2;         | ✅&sup2;            |
|                                                  | Print Server                                                   | ✅&sup2;         | ✅&sup2;            |
| Quality Windows Audio Video Experience           |                                                                | ✅               | ✅                  |
| RAS Connection Manager Administration Kit (CMAK) |                                                                | ✅               | ✅                  |
| Remote Access                                    |                                                                | ✅               | ✅                  |
|                                                  | DirectAccess and VPN (RAS)                                     | ✅               | ✅                  |
|                                                  | Routing                                                        | ✅               | ✅                  |
|                                                  | Web Application Proxy                                          | ✅               | ✅                  |
| Remote Assistance                                |                                                                | ✅&sup2;         | ✅&sup2;            |
| Remote Desktop Services                          |                                                                | ✅&sup2;         | ✅&sup2;            |
| Remote Differential Compression                  |                                                                | ✅               | ✅                  |
| Remote Server Administration Tools               |                                                                | ✅               | ✅                  |
| RPC over HTTP Proxy                              |                                                                | ✅               | ✅                  |
| Setup and Boot Event Collection                  |                                                                | ✅               | ✅                  |
| Simple TCP/IP Services                           |                                                                | ✅&sup2;         | ✅&sup2;            |
| SNMP Service                                     |                                                                | ✅               | ✅                  |
| Software Load Balancer                           |                                                                | ✅               | ✅                  |
| System Data Archiver                             |                                                                | ✅               | ✅                  |
| System Insights                                  |                                                                | ✅               | ✅                  |
| Telnet Client                                    |                                                                | ✅               | ✅                  |
| TFTP Client                                      |                                                                | ✅&sup2;         | ✅&sup2;            |
| Virtualization                                   |                                                                | ✅               | ✅                  |
|                                                  | Containers                                                     | ✅               | ✅                  |
|                                                  | Hyper-V                                                        | ✅               | ✅                  |
|                                                  | VM Shielding Tools for Fabric Management                       | ✅               | ✅                  |
| Volume Activation Services                       |                                                                | ✅               | ✅                  |
| Web Server (IIS)                                 |                                                                | ✅               | ✅                  |
|                                                  | FTP Server                                                     | ✅               | ✅                  |
|                                                  | Web Server                                                     | ✅               | ✅                  |
| WebDAV Redirector                                |                                                                | ✅               | ✅                  |
| Windows Biometric Framework                      |                                                                | ✅&sup2;         | ✅&sup2;            |
| Windows Deployment Services                      |                                                                | ✅               | ✅                  |
| Windows Identity Foundation 3.5                  |                                                                | ✅&sup2;         | ✅&sup2;            |
| Windows Internal Database                        |                                                                | ✅               | ✅                  |
| Windows PowerShell                               |                                                                | ✅               | ✅                  |
|                                                  | Windows PowerShell 2.0 Engine                                  | ✅               | ✅                  |
|                                                  | Windows PowerShell 5.1                                         | ✅               | ✅                  |
|                                                  | Windows PowerShell Desired State Configuration Service         | ✅               | ✅                  |
|                                                  | Windows PowerShell Web Access                                  | ✅               | ✅                  |
| Windows Process Activation Service               |                                                                | ✅               | ✅                  |
| Windows Search Service                           |                                                                | ✅&sup2;         | ✅&sup2;            |
| Windows Server Backup                            |                                                                | ✅               | ✅                  |
| Windows Server Management enabled by Azure Arc&sup3;   |                                                          | ✅               | ✅                  |
|                                                  | Azure Update Manager&sup3;                                     | ✅               | ✅                  |
|                                                  | Change Tracking and Inventory&sup3;                            | ✅               | ✅                  |
|                                                  | Azure Machine Configuration&sup3;                              | ✅               | ✅                  |
|                                                  | Windows Admin Center in Azure for Arc&sup3;                    | ✅               | ✅                  |
|                                                  | Remote Support&sup3;                                           | ✅               | ✅                  |
|                                                  | Best Practices Assessment&sup3;                                | ✅               | ✅                  |
|                                                  | Azure Site Recovery Configuration&sup3;                        | ✅               | ✅                  |
| Windows Server Migration Tools                   |                                                                | ✅               | ✅                  |
| Windows Server Update Services                   |                                                                | ✅               | ✅                  |
| Windows Standards-Based Storage Management       |                                                                | ✅               | ✅                  |
| Windows Subsystem for Linux                      |                                                                | ✅               | ✅                  |
| Windows TIFF IFilter                             |                                                                | ✅&sup2;         | ✅&sup2;            |
| WinRM IIS Extension                              |                                                                | ✅               | ✅                  |
| WINS Server                                      |                                                                | ✅               | ✅                  |
| Wireless LAN Service                             |                                                                | ✅               | ✅                  |
| WoW64 Support                                    |                                                                | ✅               | ✅                  |
| XPS Viewer                                       |                                                                | ✅&sup2;         | ✅&sup2;            |

1. As a guest if hosted on a virtualization host activated with Datacenter edition

1. When installed as Server with Desktop Experience

1. Available for machines enrolled in Windows Server Management enabled by Azure Arc with Windows Server licenses that have active Software Assurances or Windows Server licenses that with active subscription licenses. To learn more about the available Azure benefits, billing, and requirements, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview).

::: zone-end

:::zone pivot="windows-server-2016"

| Feature                                          | Subfeature                                                    | Standard edition | Datacenter edition |
|--------------------------------------------------|:--------------------------------------------------------------:|:----------------:|:------------------:|
| .NET Framework 3.5 Features                      |                                                                | ✅               | ✅                  |
| .NET Framework 4.6 Features                      |                                                                | ✅               | ✅                  |
| Activation                                       |                                                                | ✅               | ✅                  |
|                                                  | Automatic Virtual Machine Activation                           | ⚠️&sup1;        | ✅                  |
|                                                  | Key Management Service  (KMS)                                  | ✅               | ✅                  |
| Active Directory Certificate Services            |                                                                | ✅               | ✅                  |
|                                                  | Certificate Enrollment Policy Web Service                      | ✅               | ✅                  |
|                                                  | Certificate Enrollment Web Service                             | ✅               | ✅                  |
|                                                  | Certification Authority                                        | ✅               | ✅                  |
|                                                  | Certification Authority Web Enrollment                         | ✅               | ✅                  |
|                                                  | Network Device Enrollment Service                              | ✅               | ✅                  |
|                                                  | Online Responder                                               | ✅               | ✅                  |
| Active Directory Domain Services                 |                                                                | ✅               | ✅                  |
| Active Directory Federation Services             |                                                                | ✅               | ✅                  |
| Active Directory Lightweight Directory Services  |                                                                | ✅               | ✅                  |
| Active Directory Rights Management Services      |                                                                | ✅               | ✅                  |
| Background Intelligent Transfer Service (BITS)   |                                                                | ✅               | ✅                  |
| BitLocker Drive Encryption                       |                                                                | ✅               | ✅                  |
| BitLocker Network Unlock                         |                                                                | ✅&sup2;         | ✅&sup2;            |
| BranchCache                                      |                                                                | ✅               | ✅                  |
| Client for NFS                                   |                                                                | ✅               | ✅                  |
| Data Center Bridging                             |                                                                | ✅               | ✅                  |
| Device Health Attestation                        |                                                                | ✅               | ✅                  |
| DHCP Server                                      |                                                                | ✅               | ✅                  |
| Direct Play                                      |                                                                | ✅&sup2;         | ✅&sup2;            |
| DLNA codecs and web media streaming              |                                                                | ✅&sup2;         | ✅&sup2;            |
| DNS Server                                       |                                                                | ✅               | ✅                  |
| Enhanced Storage                                 |                                                                | ✅               | ✅                  |
| Failover Clustering                              |                                                                | ✅               | ✅                  |
| Fax Server                                       |                                                                | ✅               | ✅                  |
| File and Storage Services                        |                                                                | ✅               | ✅                  |
|                                                  | BranchCache for Network Files                                  | ✅               | ✅                  |
|                                                  | Data Deduplication                                             | ✅               | ✅                  |
|                                                  | DFS Namespaces                                                 | ✅               | ✅                  |
|                                                  | DFS Replication                                                | ✅               | ✅                  |
|                                                  | File Server                                                    | ✅               | ✅                  |
|                                                  | File Server Resource Manager                                   | ✅               | ✅                  |
|                                                  | File Server VSS Agent Service                                  | ✅               | ✅                  |
|                                                  | iSCSI Target Server                                            | ✅               | ✅                  |
|                                                  | iSCSI Target Storage Provider (VDS and VSS hardware providers) | ✅               | ✅                  |
|                                                  | Server for NFS                                                 | ✅               | ✅                  |
|                                                  | SMB 1.0/CIFS File Sharing Support                              | ✅               | ✅                  |
|                                                  | SMB Bandwidth Limit                                            | ✅               | ✅                  |
|                                                  | Work Folders                                                   | ✅               | ✅                  |
|                                                  | Storage Spaces                                                 | ✅               | ✅                  |
|                                                  | Storage Spaces Direct                                          | ❌               | ✅                  |
|                                                  | Storage Replica                                                | ❌               | ✅                  |
| Group Policy Management                          |                                                                | ✅               | ✅                  |
| Host Guardian Hyper-V Support                    |                                                                | ❌               | ✅                  |
| Host Guardian Service                            |                                                                | ✅               | ✅                  |
| I/O Quality of Service                           |                                                                | ✅               | ✅                  |
| IIS Hostable Web Core                            |                                                                | ✅               | ✅                  |
| IP Address Management (IPAM) Server              |                                                                | ✅               | ✅                  |
| Internet Storage Name Server (iSNS)              |                                                                | ✅               | ✅                  |
| Management OData IIS Extension                   |                                                                | ✅               | ✅                  |
| Media Foundation                                 |                                                                | ✅               | ✅                  |
| Message Queuing                                  |                                                                | ✅               | ✅                  |
|                                                  | Message Queuing DCOM Proxy                                     | ✅               | ✅                  |
|                                                  | Message Queuing Services                                       | ✅               | ✅                  |
| Microsoft Defender Antivirus                     |                                                                | ✅               | ✅                  |
| Multipath I/O                                    |                                                                | ✅               | ✅                  |
| MultiPoint Connector                             |                                                                | ✅               | ✅                  |
| MultiPoint Services                              |                                                                | ✅               | ✅                  |
| Network ATC                                      |                                                                | ✅               | ✅                  |
| Network Controller                               |                                                                | ❌               | ✅                  |
| Network Load Balancing                           |                                                                | ✅               | ✅                  |
| Network Policy and Access Services               |                                                                | ✅&sup2;         | ✅&sup2;            |
| Print and Document Services                      |                                                                | ✅               | ✅                  |
|                                                  | Internet Printing                                              | ✅&sup2;         | ✅&sup2;            |
|                                                  | Line Printer Daemon (LPD) Service                              | ✅&sup2;         | ✅&sup2;            |
|                                                  | Print Server                                                   | ✅&sup2;         | ✅&sup2;            |
|                                                  | Distributed Scan Server                                        | ✅&sup2;         | ✅&sup2;            |
| Quality Windows Audio Video Experience           |                                                                | ✅               | ✅                  |
| RAS Connection Manager Administration Kit (CMAK) |                                                                | ✅               | ✅                  |
| Remote Access                                    |                                                                | ✅               | ✅                  |
|                                                  | DirectAccess and VPN (RAS)                                     | ✅               | ✅                  |
|                                                  | Routing                                                        | ✅               | ✅                  |
|                                                  | Web Application Proxy                                          | ✅               | ✅                  |
| Remote Assistance                                |                                                                | ✅&sup2;         | ✅&sup2;            |
| Remote Desktop Services                          |                                                                | ✅&sup2;         | ✅&sup2;            |
| Remote Differential Compression                  |                                                                | ✅               | ✅                  |
| Remote Server Administration Tools               |                                                                | ✅               | ✅                  |
| RPC over HTTP Proxy                              |                                                                | ✅               | ✅                  |
| Setup and Boot Event Collection                  |                                                                | ✅               | ✅                  |
| Simple TCP/IP Services                           |                                                                | ✅&sup2;         | ✅&sup2;            |
| SNMP Service                                     |                                                                | ✅               | ✅                  |
| Software Load Balancer                           |                                                                | ✅               | ✅                  |
| Telnet Client                                    |                                                                | ✅               | ✅                  |
| TFTP Client                                      |                                                                | ✅&sup2;         | ✅&sup2;            |
| Virtualization                                   |                                                                | ✅               | ✅                  |
|                                                  | Containers                                                     | ✅               | ✅                  |
|                                                  | Hyper-V                                                        | ✅               | ✅                  |
|                                                  | VM Shielding Tools for Fabric Management                       | ✅               | ✅                  |
| Volume Activation Services                       |                                                                | ✅               | ✅                  |
| Web Server (IIS)                                 |                                                                | ✅               | ✅                  |
|                                                  | FTP Server                                                     | ✅               | ✅                  |
|                                                  | Web Server                                                     | ✅               | ✅                  |
| WebDAV Redirector                                |                                                                | ✅               | ✅                  |
| Windows Biometric Framework                      |                                                                | ✅&sup2;         | ✅&sup2;            |
| Windows Deployment Services                      |                                                                | ✅               | ✅                  |
| Windows Identity Foundation 3.5                  |                                                                | ✅&sup2;         | ✅&sup2;            |
| Windows Internal Database                        |                                                                | ✅               | ✅                  |
| Windows PowerShell                               |                                                                | ✅               | ✅                  |
|                                                  | Windows PowerShell 2.0 Engine                                  | ✅               | ✅                  |
|                                                  | Windows PowerShell 5.1                                         | ✅               | ✅                  |
|                                                  | Windows PowerShell Desired State Configuration Service         | ✅               | ✅                  |
|                                                  | Windows PowerShell Web Access                                  | ✅               | ✅                  |
| Windows Process Activation Service               |                                                                | ✅               | ✅                  |
| Windows Server Essentials Experience             |                                                                | ✅               | ✅                  |
| Windows Search Service                           |                                                                | ✅&sup2;         | ✅&sup2;            |
| Windows Server Backup                            |                                                                | ✅               | ✅                  |
| Windows Server Management enabled by Azure Arc&sup3;    |                                                         | ✅               | ✅                  |
|                                                  | Azure Update Manager&sup3;                                     | ✅               | ✅                  |
|                                                  | Change Tracking and Inventory&sup3;                            | ✅               | ✅                  |
|                                                  | Azure Machine Configuration&sup3;                              | ✅               | ✅                  |
|                                                  | Windows Admin Center in Azure for Arc&sup3;                    | ✅               | ✅                  |
|                                                  | Remote Support&sup3;                                           | ✅               | ✅                  |
|                                                  | Best Practices Assessment&sup3;                                | ✅               | ✅                  |
|                                                  | Azure Site Recovery Configuration&sup3;                        | ✅               | ✅                  |
| Windows Server Migration Tools                   |                                                                | ✅               | ✅                  |
| Windows Server Update Services                   |                                                                | ✅               | ✅                  |
| Windows Standards-Based Storage Management       |                                                                | ✅               | ✅                  |
| Windows TIFF IFilter                             |                                                                | ✅&sup2;         | ✅&sup2;            |
| WinRM IIS Extension                              |                                                                | ✅               | ✅                  |
| WINS Server                                      |                                                                | ✅               | ✅                  |
| Wireless LAN Service                             |                                                                | ✅               | ✅                  |
| WoW64 Support                                    |                                                                | ✅               | ✅                  |
| XPS Viewer                                       |                                                                | ✅&sup2;         | ✅&sup2;            |

1. As a guest if hosted on a virtualization host activated with Datacenter edition

2. When installed as Server with Desktop Experience

3. Available for machines enrolled in Windows Server Management enabled by Azure Arc with Windows Server licenses that have active Software Assurances or Windows Server licenses that with active subscription licenses. To learn more about the available Azure benefits, billing, and requirements, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview).

::: zone-end
