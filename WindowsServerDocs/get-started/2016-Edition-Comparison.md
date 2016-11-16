---
title: Windows Server 2016 Products and Editions
description: "Explains differences in the Standard and Datacenter editions" 
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 11/10/2016
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
|Maximum RAM|4 TB|4 TB|
|Can be used as virtualization guest|Yes; 2 virtual machines, plus one Hyper-V host per license|Yes; unlimited virtual machines, plus one Hyper-V host per license|
|Server can join a domain|yes|yes|
|Edge network protection/firewall|no|no|
|DirectAccess|yes|yes|
|DLNA codecs and web media streaming|Yes, if installed as Server with Desktop Experience|Yes, if installed as Server with Desktop Experience|

## Server roles
|Server roles available|Windows Server 2016 Standard|Windows Server 2016 Datacenter|  
|-------------------|----------|---------------------------|  
|Active Directory Certificate Services|Yes|Yes|
|Active Directory Domain Services|Yes|Yes|
|Active Directory Federation Services|Yes|Yes|
|AD Lightweight Directory Services|Yes|Yes|
|AD Rights Management Services|Yes|Yes|
|Application Server|Yes|Yes|
|DHCP Server|Yes|Yes|
|DNS Server|Yes|Yes|
|Fax Server|Yes|Yes|
|File Services|Yes|Yes|
|Hyper-V|Yes|Yes|
|Network Policy and Access Services|Yes|Yes|
|Print and Document Services|Yes|Yes|
|Remote Desktop Services|Yes|Yes|
|Web Services IIS|Yes|Yes|
|Windows Deployment Services|Yes|Yes|
|Windows Media Services support (Streaming Media Services)|Yes|Yes|
|WINS Server|Yes|Yes|
|Remote Access Role RRAS|Yes|Yes|

## Features

|Features available|Windows Server 2016 Standard|Windows Server 2016 Datacenter|  
|-------------------|----------|---------------------------|  
|Best Practices Analyzer|Yes|Yes|
|Branch Cache Hosted Server|Yes|Yes|
|Branch Cache P2P Cache|Yes|Yes|
|Control Panel|Yes|Yes|
|Cross File Replication (DFS-R)|Yes|Yes|
|Data De-duplication|Yes|Yes|
|ISCSI target support|Yes|Yes|
|Direct Access|Yes|Yes|
|Dynamic Memory (in virtualization)|Yes|Yes|
|Failover Clustering "Continuous Availability"|Yes|Yes|
|Hot Add/Replace RAM|Yes|Yes|
|IPAM (IP Address Management)|Yes|Yes|
|Microsoft Management Console|Yes|Yes|
|Minimal Server Interface|Yes|Yes|
|Network Load Balancing|Yes|Yes|
|Windows PowerShell|Yes|Yes|
|Server Core Installation Option|Yes|Yes|
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
