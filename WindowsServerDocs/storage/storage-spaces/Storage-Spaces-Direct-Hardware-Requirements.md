---
title: Storage Spaces Direct Hardware Requirements
ms.prod: windows-server
description: Minimum hardware requirements for testing Storage Spaces Direct.
ms.author: eldenc
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: eldenchristensen
ms.date: 08/05/2019
ms.localizationpriority: medium
---
# Storage Spaces Direct hardware requirements

> Applies to: Windows Server 2019, Windows Server 2016

This topic describes minimum hardware requirements for Storage Spaces Direct.

For production, Microsoft recommends purchasing a validated hardware/software solution from our partners, which include deployment tools and procedures. These solutions are designed, assembled, and validated against our reference architecture to ensure compatibility and reliability, so you get up and running quickly. For Windows Server 2019 solutions, visit the [Azure Stack HCI solutions website](https://azure.microsoft.com/overview/azure-stack/hci). For Windows Server 2016 solutions, learn more at [Windows Server Software-Defined](https://microsoft.com/wssd).

   > [!TIP]
   > Want to evaluate Storage Spaces Direct but don't have hardware? Use Hyper-V or Azure virtual machines as described in [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

## Base requirements

Systems, components, devices, and drivers must be **Windows Server 2016 Certified** per the [Windows Server Catalog](https://www.windowsservercatalog.com). In addition, we recommend that servers, drives, host bus adapters, and network adapters have the **Software-Defined Data Center (SDDC) Standard** and/or **Software-Defined Data Center (SDDC) Premium** additional qualifications (AQs), as pictured below. There are over 1,000 components with the SDDC AQs.

![screenshot of the Windows Server catalog showing the SDDC AQs](media/hardware-requirements/sddc-aqs.png)

The fully configured cluster (servers, networking, and storage) must pass all [cluster validation tests](https://technet.microsoft.com/library/cc732035(v=ws.10).aspx) per the wizard in Failover Cluster Manager or with the `Test-Cluster` [cmdlet](https://docs.microsoft.com/powershell/module/failoverclusters/test-cluster?view=win10-ps) in PowerShell.

In addition, the following requirements apply:

## Servers

- Minimum of 2 servers, maximum of 16 servers
- Recommended that all servers be the same manufacturer and model

## CPU

- Intel Nehalem or later compatible processor; or
- AMD EPYC or later compatible processor

## Memory

- Memory for Windows Server, VMs, and other apps or workloads; plus
- 4 GB of RAM per terabyte (TB) of cache drive capacity on each server, for Storage Spaces Direct metadata

## Boot

- Any boot device supported by Windows Server, which [now includes SATADOM](https://cloudblogs.microsoft.com/windowsserver/2017/08/30/announcing-support-for-satadom-boot-drives-in-windows-server-2016/)
- RAID 1 mirror is **not** required, but is supported for boot
- Recommended: 200 GB minimum size

## Networking

Storage Spaces Direct requires a reliable high bandwidth, low latency network connection between each node.  

Minimum interconnect for small scale 2-3 node
- 10 Gbps network interface card (NIC), or faster
- Two or more network connections from each node recommended for redundancy and performance

Recommended interconnect for high performance, at scale, or deployments of 4+ 
- NICs that are remote-direct memory access (RDMA) capable, iWARP (recommended) or RoCE
- Two or more network connections from each node recommended for redundancy and performance
- 25 Gbps NIC or faster

Switched or switchless node interconnects
- Switched: Network switches must be properly configured to handle the bandwidth and networking type.  If using RDMA that implements the RoCE protocol, network device and switch configuration is even more important. 
- Switchless: Nodes can be interconnected using direct connections, avoiding using a switch.  It is required that every node have a direct connection with every other node of the cluster.


## Drives

Storage Spaces Direct works with direct-attached SATA, SAS, or NVMe drives that are physically attached to just one server each. For more help choosing drives, see the [Choosing drives](choosing-drives.md) topic.

- SATA, SAS, and NVMe (M.2, U.2, and Add-In-Card) drives are all supported
- 512n, 512e, and 4K native drives are all supported
- Solid-state drives must provide [power-loss protection](https://blogs.technet.microsoft.com/filecab/2016/11/18/dont-do-it-consumer-ssd/)
- Same number and types of drives in every server – see [Drive symmetry considerations](drive-symmetry-considerations.md)
- Cache devices must be 32 GB or larger
- When using persistent memory devices as cache devices, you must use NVMe or SSD capacity devices (you can't use HDDs)
- NVMe driver is the Microsoft-provided one included in Windows. (stornvme.sys)
- Recommended: Number of capacity drives is a whole multiple of the number of cache drives
- Recommended: Cache drives should have high write endurance: at least 3 drive-writes-per-day (DWPD) or at least 4 terabytes written (TBW) per day – see [Understanding drive writes per day (DWPD), terabytes written (TBW), and the minimum recommended for Storage Spaces Direct](https://blogs.technet.microsoft.com/filecab/2017/08/11/understanding-dwpd-tbw/)

Here's how drives can be connected for Storage Spaces Direct:

- Direct-attached SATA drives
- Direct-attached NVMe drives
- SAS host-bus adapter (HBA) with SAS drives
- SAS host-bus adapter (HBA) with SATA drives
- **NOT SUPPORTED:** RAID controller cards or SAN (Fibre Channel, iSCSI, FCoE) storage. Host-bus adapter (HBA) cards must implement simple pass-through mode.

![diagram of supported drive interconnects](media/hardware-requirements/drive-interconnect-support-1.png)

Drives can be internal to the server, or in an external enclosure that is connected to just one server. SCSI Enclosure Services (SES) is required for slot mapping and identification. Each external enclosure must present a unique identifier (Unique ID).

- Drives internal to the server
- Drives in an external enclosure ("JBOD") connected to one server
- **NOT SUPPORTED:** Shared SAS enclosures connected to multiple servers or any form of multi-path IO (MPIO) where drives are accessible by multiple paths.

![diagram of supported drive interconnects](media/hardware-requirements/drive-interconnect-support-2.png)

### Minimum number of drives (excludes boot drive)

- If there are drives used as cache, there must be at least 2 per server
- There must be at least 4 capacity (non-cache) drives per server

| Drive types present   | Minimum number required |
|-----------------------|-------------------------|
| All persistent memory (same model) | 4 persistent memory |
| All NVMe (same model) | 4 NVMe                  |
| All SSD (same model)  | 4 SSD                   |
| Persistent memory + NVMe or SSD | 2 persistent memory + 4 NVMe or SSD |
| NVMe + SSD            | 2 NVMe + 4 SSD          |
| NVMe + HDD            | 2 NVMe + 4 HDD          |
| SSD + HDD             | 2 SSD + 4 HDD           |
| NVMe + SSD + HDD      | 2 NVMe + 4 Others       |

   >[!NOTE]
   > This table provides the minimum for hardware deployments. If you're deploying with virtual machines and virtualized storage, such as in Microsoft Azure, see [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

### Maximum capacity

| Maximums                | Windows Server 2019  | Windows Server 2016  |
| ---                     | ---------            | ---------            |
| Raw capacity per server | 400 TB               | 100 TB               |
| Pool capacity           | 4 PB (4,000 TB)      | 1 PB                 |
