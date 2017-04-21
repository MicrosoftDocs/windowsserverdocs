---
title: Storage Spaces Direct Hardware Requirements
ms.prod: windows-server-threshold
description: Minimum hardware requirements for testing Storage Spaces Direct.
ms.author: eldenc
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: eldenchristensen
ms.date: 02/15/2017
---
# Storage Spaces Direct hardware requirements
>Applies To: Windows Server 2016

This topic describes minimum hardware requirements for testing Storage Spaces Direct. For production environments we recommend acquiring a *Windows Server Software-Defined* hardware/software offering, which includes production deployment tools and procedures. These offerings are designed, assembled, and validated to meet Microsoft's requirements for private cloud environments, helping ensure reliable operation. Windows Server Software-Defined offerings will be available later this year - check back for updates! To learn more, check out [Partner Offers at Microsoft Ignite 2016](https://channel9.msdn.com/events/Ignite/2016/BRK2167).

If you would like to evaluate Storage Spaces Direct in Windows Server 2016 without investing in hardware, you can use Hyper-V virtual machines, as described in [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx).

## Basic requirements

All systems, components, devices, and drivers must be "Certified for Windows Server 2016" per the [Windows Server Catalog](https://www.windowsservercatalog.com).

The fully configured cluster (servers, networking, and storage) must pass all [cluster validation tests](https://technet.microsoft.com/library/cc732035(v=ws.10).aspx) per the wizard in the Failover Cluster snap-in or with the **Test-Cluster** cmdlet in PowerShell.

In addition, the following requirements apply.

## Additional requirements for Storage Spaces Direct

### Servers

- Minimum of 2 servers, maximum of 16 servers
- All servers should be the same make and model

### CPU

- Minimum of Intel Nehalem or later compatible processor

### Memory

- 4 GB of RAM per terabyte (TB) of cache drive capacity on each server, to store Storage Spaces Direct metadata.   
Note that RAM sizes use base-2 numbering (where 1 GB = 1,024 MB), while drives are advertised using base-10 numbering (where 1 TB = 1,000 GB). For example, if each server has 2 x 1.6 TB (advertised capacity) cache drives, you should keep 2 x 1.6 x 4096 MB = 13,107 MB (12.8 GB) of memory available for Storage Spaces Direct internal use.
- Any memory used by Windows Server, VMs, and other apps or workloads.

### Networking

- Minimum of 10 Gbps network interface for intra-cluster communication
- Recommended: Two NICs for redundancy and performance
- Recommended: NICS that are remote-direct memory access (RDMA) capable, iWARP or RoCE

### Drives

For more help choosing drives, see the [Choosing drives](choosing-drives.md) topic.

- Use local-attached SATA, SAS, or NVMe drives.
- Every drive must be physically connected to only one server.
- All servers must have the same drive types (if one server has NVMe, they all require NVMe.  If one has HDD, they all require HDD)
- Recommended: All servers have the same drive configuration (type, size, firmware)
- SSDs must have [power-loss protection](https://blogs.technet.microsoft.com/filecab/2016/11/18/dont-do-it-consumer-ssd/), i.e. they are "enterprise-grade"
- Recommended:  SSDs used for cache have high endurance, providing minimum of 5 drive-writes-per-day (DWPD)
- Add capacity drives in multiples of the number of NVMe or SSD cache devices.
- Drives can be 512n, 512e, or 4K native - they all work equally well.
- Use a separate, dedicated drive or RAID 1 mirror for Windows Server (200 GB is a recommended minimum size).
- **Not supported:** Multi-path IO (MPIO) or physically connecting drives via multiple paths.

#### Minimum number of drives

- If there are drives used as cache, there must be at least 2 per server
- There must be at least 4 capacity (non-cache) drives per server

| Drive types present   | Minimum number required |
|-----------------------|-------------------------|
| All NVMe (same model) | 4 NVMe                  |
| All SSD (same model)  | 4 SSD                   |
| NVMe + SSD            | 2 NVMe + 4 SSD          |
| NVMe + HDD            | 2 NVMe + 4 HDD          |
| SSD + HDD             | 2 SSD + 4 HDD           |
| NVMe + SSD + HDD      | 2 NVMe + 4 Others       |

   >[!NOTE]
   >  This table provides the minimum number of drives required for bare-metal deployments. If you're deploying Storage Spaces Direct using virtual machines and virtualized storage, such as [in Azure](https://blogs.technet.microsoft.com/filecab/2016/05/05/s2dazuretp5/), this requirement is waived because your "drives" aren't expected to ever fail. In this case, the requirement is just two "drives" per server. In Azure, we recommend using [premium data disks](https://azure.microsoft.com//documentation/articles/storage-premium-storage/) for better performance. 

#### Maximum

- Maximum of 1 petabyte (1,000 TB) of raw capacity per storage pool

### Host-bus adapter (HBA)

- Simple pass-through SAS HBA for both SAS and SATA drives
- SCSI Enclosure Services (SES) for SAS and SATA drives
- Any direct-attached storage enclosures must present Unique ID
- **Not Supported:** RAID HBA controllers or SAN (Fibre Channel, iSCSI, FCoE) devices
