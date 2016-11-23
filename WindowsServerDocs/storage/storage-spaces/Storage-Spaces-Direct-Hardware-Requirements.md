---
title: Storage Spaces Direct Hardware Requirements
ms.prod: windows-server-threshold
ms.author: eldenc
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: eldenchristensen
ms.date: 11/23/2016
ms.assetid: 8bd0d09a-0421-40a4-b752-40ecb5350ffd
---
# Storage Spaces Direct Hardware Requirements
>Applies To: Windows Server 2016

## Foreword

Microsoft strongly recommends deploying Storage Spaces Direct with *Windows Server Software-Defined (WSSD)* offers from our hardware partners. They have been thoughtfully designed and extensively validated to provide the best experience. To learn more, check out [Partner Offers at Microsoft Ignite 2016](https://channel9.msdn.com/events/Ignite/2016/BRK2167).

## Basic requirements

All systems, components, devices, and drivers must be "Certified for Windows Server 2016" per the [Windows Server Catalog](https://www.windowsservercatalog.com).

The fully configured cluster (servers, networking, and storage) must pass all [cluster validation tests](https://technet.microsoft.com/en-us/library/cc732035(v=ws.10).aspx) per the wizard in the Failover Cluster snap-in or with the **Test-Cluster** cmdlet in PowerShell.

In addition, the following requirements apply.

## Additional requirements for Storage Spaces Direct

### Servers

- Minimum of 2 servers, maximum of 16 servers
- All servers must be identical in hardware components, drivers, firmware, and configuration
 
### CPU

- Minimum of Nehalem or later compatible processor

### Memory

- At least 5 GB of RAM per 1 TB of cache drive capacity on each server, plus whatever memory you intend for your workload

### Networking

- Minimum of 10 Gbps network interface for intra-cluster communication
- Recommended: Two NICs for redundancy and performance
- Recommended: Interfaces which are remote-direct memory access (RDMA) capable, iWARP or RoCE

### Drives

- Local-attached SATA, SAS, or NVMe drives
- Every drive must be physically connected to only one server
- **Not supported: ** multi-path IO (MPIO) or physically connecting drives via multiple paths
- For hybrid (SSD/NVMe + HDD) configurations, minimum of 2 SSD/NVMe + 4 HDD
- For all-flash (SSD only) configurations, minimum of 4 SSD/NVMe
- Maximum of 416 drives total across all servers
- Maximum of 1 PB of total raw capacity
- Ensure that all SSDs have power-loss protection, i.e. they are "enterprise-grade"
- Separate dedicated drive for boot

### Host-bus adapter (HBA)

- Simple pass-through SAS HBA for both SAS and SATA drives
- SCSI Enclosure Services (SES) for SAS and SATA drives
- Any direct-attached storage enclosures must present Unique ID
- **Not Supported:** RAID HBA controllers or SAN (Fibre Channel, iSCSI, FCoE) devices
