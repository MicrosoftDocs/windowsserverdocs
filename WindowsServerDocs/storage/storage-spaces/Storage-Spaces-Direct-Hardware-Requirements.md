---
title: Storage Spaces Direct Hardware Requirements
ms.prod: windows-server-threshold
description: Minimum hardware requirements for testing Storage Spaces Direct.
ms.author: eldenc
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: eldenchristensen
ms.date: 01/18/2018
ms.localizationpriority: medium
---
# Storage Spaces Direct hardware requirements

>Applies to: Windows Server 2016

This topic describes minimum hardware requirements for Storage Spaces Direct.

For production environments we recommend acquiring a [Windows Server Software-Defined](https://microsoft.com/wssd) hardware/software offering, which includes production deployment tools and procedures. These offerings are designed, assembled, and validated to meet Microsoft's requirements for private cloud environments, helping ensure reliable operation. Windows Server Software-Defined offerings are available through our partners' websites. Learn more at [https://microsoft.com/wssd](https://microsoft.com/wssd).

If you would like to evaluate Storage Spaces Direct without investing in hardware, you can use Hyper-V virtual machines, as described in [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

## Basic requirements

All systems, components, devices, and drivers must be "Certified for Windows Server 2016" per the [Windows Server Catalog](https://www.windowsservercatalog.com).

The fully configured cluster (servers, networking, and storage) must pass all [cluster validation tests](https://technet.microsoft.com/library/cc732035(v=ws.10).aspx) per the wizard in the Failover Cluster snap-in or with the **Test-Cluster** cmdlet in PowerShell.

In addition, the following requirements apply.

## Additional requirements for Storage Spaces Direct

### Servers

- Minimum of 2 servers, maximum of 16 servers
- Recommended that all servers be the same make and model

### CPU

- Minimum of Intel Nehalem or later compatible processor, or AMD EPYC or later compatible processor

### Memory

- 4 GB of RAM per terabyte (TB) of cache drive capacity on each server, to store Storage Spaces Direct metadata.   
Note that RAM sizes use base-2 numbering (where 1 GB = 1,024 MB), while drives are advertised using base-10 numbering (where 1 TB = 1,000 GB). For example, if each server has 2 x 1.6 TB (advertised capacity) cache drives, you should keep 2 x 1.6 x 4096 MB = 13,107 MB (12.8 GB) of memory available for Storage Spaces Direct internal use.
- Any memory used by Windows Server, VMs, and other apps or workloads.

### Networking

- Minimum of 10 Gbps network interface for intra-cluster communication
- Recommended: Two NICs for redundancy and performance
- Recommended: NICS that are remote-direct memory access (RDMA) capable, iWARP or RoCE
- With 2 servers, direct-connect (switchless) is supported

### Drives

For more help choosing drives, see the [Choosing drives](choosing-drives.md) topic.

- Use local-attached SATA, SAS, or NVMe drives
- Every drive must be physically connected to only one server
- Every server in the cluster should have the same types of drives and the same number of each type. We recommend using drives of the same model, size, and firmware version whenever possible. To learn more, see [Drive symmetry considerations for Storage Spaces Direct](drive-symmetry-considerations.md).
- SSDs must be "enterprise-grade" meaning they provide [power-loss protection](https://blogs.technet.microsoft.com/filecab/2016/11/18/dont-do-it-consumer-ssd/)
- Recommended: Cache drives should have high write endurance: at least 3 drive-writes-per-day (DWPD) or at least 4 terabytes written (TBW) per day. To learn more, see [Understanding drive writes per day (DWPD), terabytes written (TBW), and the minimum recommended for Storage Spaces Direct](https://blogs.technet.microsoft.com/filecab/2017/08/11/understanding-dwpd-tbw/).
- Recommended: Add capacity drives in multiples of the number of NVMe or SSD cache devices
- Drives can be 512n, 512e, or 4K native
- Use a separate, dedicated drive or RAID 1 mirror for Windows Server boot (recommended 200 GB minimum size)
- **Not supported:** Multi-path IO (MPIO) or physically connecting drives via multiple paths

> [!NOTE]
> Microsoft has a critical product advisory for Storage Spaces Direct customers using the Intel P3x00 family of NVMe devices (all capacities of the P3500, P3600, P3700). See Knowledge Base article [4052341](https://support.microsoft.com/help/4052341) for more information.

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
   >  This table provides the minimum number of drives required for bare-metal deployments. If you're deploying Storage Spaces Direct using virtual machines and virtualized storage, such as in Microsoft Azure, see [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

#### Maximum

- Maximum of 1 petabyte (1,000 TB) of raw capacity per storage pool

### Host-bus adapter (HBA)

- Simple pass-through SAS HBA for both SAS and SATA drives
- SCSI Enclosure Services (SES) for SAS and SATA drives
- Any direct-attached storage enclosures must present Unique ID
- **Not Supported:** RAID HBA controllers or SAN (Fibre Channel, iSCSI, FCoE) devices
