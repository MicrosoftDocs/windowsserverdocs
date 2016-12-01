---
title: Windows Server 2016 Products and Editions
description: "Explains differences in the Standard and Datacenter editions" 
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 12/01/2016
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c5ca3bfe-7ced-49f6-a932-80cab33f419e
author: jaimeo
ms.author: jaimeo
manager: dongill
---
# Comparison of Standard and Datacenter editions of Windows Server 2016

> Applies To: Windows Server 2016
  
## Locks and Limits
|Locks and Limits|Windows Server 2016 Standard|Windows Server 2016 Datacenter|  
|-------------------|----------|---------------------------|  
|Maximum number of users|Based on CALs|Based on CALs|
|Maximum SMB connections|16777216|16777216|
|Maximum RRAS connections|unlimited|unlimited|
|Maximum IAS connections|2147483647|2147483647|
|Maximum RDS connections|65535|65535|
|Maximum number of 64-bit sockets|64|64|
|Maximum number of cores|unlimited|unlimited|
|Maximum RAM|24 TB|24 TB|
|Can be used as virtualization guest|Yes; 2 virtual machines, plus one Hyper-V host per license|Yes; unlimited virtual machines, plus one Hyper-V host per license|
|Server can join a domain|yes|yes|
|Edge network protection/firewall|no|no|
|DirectAccess|yes|yes|
|DLNA codecs and web media streaming|Yes, if installed as Server with Desktop Experience|Yes, if installed as Server with Desktop Experience|

## Server roles
|Windows Server roles available|Role services|Windows Server 2016 Standard|Windows Server 2016 Datacenter|  
|-------------------|----------|----------|---------------------------|  
|Active Directory Certificate Services| |Yes|Yes|
|Active Directory Domain Services| |Yes|Yes|
|Active Directory Federation Services| |Yes|Yes|
|AD Lightweight Directory Services| |Yes|Yes|
|AD Rights Management Services| |Yes|Yes|
|Device Health Attestation| |???|Yes|
|DHCP Server| |Yes|Yes|
|DNS Server| |Yes|Yes|
|Fax Server| |Yes|Yes|
|File and Storage Services|File Server|???|Yes|
|File and Storage Services|BranchCache for Network Files|???|Yes|
|File and Storage Services|Data Deduplication|???|Yes|
|File and Storage Services|DFS Namespaces|???|Yes|
|File and Storage Services|DFS Replication|???|Yes|
|File and Storage Services|File Serve Resource Mnager|???|Yes|
|File and Storage Services|File Server VSS Agent Service|???|Yes|
|File and Storage Services|iSCSI Target Server|???|Yes|
|File and Storage Services|iSCSI Target Storage Provider|???|Yes|
|File and Storage Services|Server for NFS|???|Yes|
|File and Storage Services|Work Folders|???|Yes|
|File and Storage Services|Storage Services|???|Yes|
|Host Guardian Service| |???|Yes|
|Hyper-V| |Yes|Yes|
|MultiPoint Services| |Yes|Yes|
|Network Controller| |???|Yes|
|Network Policy and Access Services| |Yes|Yes|
|Print and Document Services| |Yes|Yes|
|Remote Access| |???|Yes|
|Remote Desktop Services| |Yes|Yes|
|Volume Activation Services| |???|Yes|
|Web Servicer (IIS)| |Yes|Yes|
|Windows Deployment Services| |Yes|Yes|
|Windows Server Essentials Experience| |???|Yes|
|Windows Server Update Services| |???|Yes|

## Features

|Windows Server Features installable with Server Manager (or PowerShell)|Windows Server 2016 Standard|Windows Server 2016 Datacenter|  
|-------------------|----------|---------------------------|  
|.NET Framework 3.5|Yes|Yes|
|.NET Framework 4.6|Yes|Yes|
|Background Intelligent Transfer Service (BITS)|???|Yes|
|BitLocker Drive Encryption|???|Yes|
|BitLocker Network Unlock|???|Yes|
|BranchCache|???|Yes|
|Client for NFS|???|Yes|
|Containers|???|Yes|
|Data Center Bridging|???|Yes|
|Direct Play|???|Yes|
|Enhanced Storage|???|Yes|
|Failover Clustering|???|Yes|
|Group Policy Management|Yes|Yes|
|Host Guardian Hyper-V Support|???|Yes|
|I/O Quality of Service|???|Yes|
|IIS Hostable Web Core|???|Yes|
|Internet Printing Client|???|Yes|
|IPAM Server|???|Yes|
|iSNS Server service|???|Yes|
|LPR Port Monitor|???|Yes|
|Management OData IIS Extension|???|Yes|
|Media Foundation|???|Yes|
|Message Queueing|???|Yes|
|Multipath I/O|???|Yes|
|MultiPoint Connector|???|Yes|
|Network Load Balancing|???|Yes|
|Peer Name Resolution Protocol|???|Yes|
|Quality Windows Audio Video Experience|???|Yes|
|RAS Connection Manager Administration Kit|???|Yes|
|Remote Assistance|???|Yes|
|Remote Differential Compression|???|Yes|
|RSAT|Yes|Yes|
|RPC over HTTP Proxy|Yes|Yes|
|Setup and Boot Event Collection|Yes|Yes|
|Simple TCP/IP Services|Yes|Yes|
|SMB 1.0/CIFS File Sharing Support|???|Yes|
|SMB Bandwidth Limit|???|Yes|
|SMTP Server|Yes|Yes|
|SNMP Service|Yes|Yes|
|Software Load Balancer|???|Yes|
|Storage Replica|???|Yes|
|Telnet Client|Yes|Yes|
|TFTP Client|Yes|Yes|
|VM Shielding Tools for Fabric Management|???|Yes|
|WebDAV Redirector|???|Yes|
|Windows Biometric Framework|???|Yes|
|Windows Defender features|Yes|Yes|
|Windows Identity Foundation 3.5|???|Yes|
|Windows Internal Database|???|Yes|
|Windows PowerShell|Yes|Yes|
|Windows Process Activation Service|???|Yes|
|Windows Search Service|???|Yes|
|Windows Server Backup|Yes|Yes|
|Windows Server Migration Tools|Yes|Yes|
|Windows Standards-Based Storage Management|???|Yes|
|Windows TIFF IFilter|???|Yes|
|WinRM IIS Extension|???|Yes|
|WINS Server|Yes|Yes|
|Wireless LAN Service|Yes|Yes|
|WoW64 support|Yes|Yes|
|XPS Viewer|Yes|Yes|

|Features available generally|Windows Server 2016 Standard|Windows Server 2016 Datacenter|  
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
|Nano Server installation option|Yes|Yes|
|Server Manager|Yes|Yes|
|SMB Direct and SMB over RDMA|Yes|Yes|
|Storage Management Service|Yes|Yes|
|Storage Spaces|Yes|Yes|
|Volume Activation Services|Yes|Yes|
|VSS (Volume Shadow Copy Service) integration|Yes|Yes|
|Windows Server Update Services|Yes|Yes|
|Windows System Resource Manager|Yes|Yes|
|Server license logging|Yes|Yes|
|Inherited activation|As guest if hosted on Datacenter|Can be host or guest|
|Work folders|Yes|Yes|
