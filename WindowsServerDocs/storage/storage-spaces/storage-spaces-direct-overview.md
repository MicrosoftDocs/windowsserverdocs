---
title: Storage Spaces Direct overview
ms.author: cosdar
manager: dongill
ms.topic: article
author: cosmosdarwin
ms.date: 07/24/2020
ms.assetid: 8bd0d09a-0421-40a4-b752-40ecb5350ffd
description: An overview of Storage Spaces Direct, a feature of Windows Server and Azure Stack HCI that enables you to cluster servers with internal storage into a software-defined storage solution.
---
# Storage Spaces Direct overview

>Applies to: Azure Stack HCI, versions 21H2 and 20H2, Windows Server 2022, Windows Server 2019, Windows Server 2016

This article provides an overview of Storage Spaces Direct. It describes the features and components of the Storage Spaces Direct stack, the available deployment modes, and the key benefits it offers. This article also includes videos from Storage Spaces Direct experts at Microsoft and links to real-world customer stories.

Storage Spaces Direct is a software-defined storage solution for your converged or hyperconverged infrastructure. It enables you to combine multiple internal storage devices on a cluster of physical servers (between 2 and 16) into a software-defined pool of storage. You can then access this pool of storage from any server in that cluster. This pool has cache, tiers, resiliency, erasure coding across columns—all configured and managed automatically. To your network users, this pool appears as a single storage device and they don't need to worry about the physical storage location of their data. If you want to scale out the storage capacity of your cluster, you can add additional nodes to your existing cluster and then combine its storage devices with the existing storage pool.  

Storage Spaces Direct enables you to create a highly available and scalable storage solution, which results in significant cost reductions as compared to using storage area network (SAN) or network-attached storage (NAS) technologies.

You can deploy Storage Spaces Direct by connecting the servers in the cluster over Ethernet—no special cabling is required. The servers in the cluster can have traditional drive types, such as PMem (persistent memory), NVMe (non-volatile memory express), SSD (solid state drive), and HDD (hard disk drive). For more information about minimum hardware requirements in Storage Spaces Direct, see [Storage Spaces Direct hardware requirements](/storage-spaces-direct-hardware-requirements.md).

Storage Spaces Direct is a core technology of Azure Stack HCI, versions 21H2 and 20H2. It is also included in Windows Server 2019 Datacenter, Windows Server 2016 Datacenter, and [Windows Server Insider Preview Builds](https://insider.windows.com/for-business-getting-started-server/).

You can deploy Storage Spaces Direct on a cluster of physical servers or on virtual machine (VM) guest clusters. If deploying on a cluster of physical servers, we recommend using Azure stack HCI servers. However, you can still Windows Server for physical server deployment if you want. 

Deploying Storage Spaces Direct on VM guest clusters delivers virtual shared storage across a set of VMs on top of a private or public cloud. This type of deployment is supported only in Windows Server. For more information about guest VM deployment, see [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

To get started, try Storage Spaces Direct [in Microsoft Azure](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB), or download a 180-day-licensed evaluation copy of Windows Server from [Windows Server Evaluations](https://go.microsoft.com/fwlink/?linkid=842602).

To find answers to frequently asked questions about Storage Spaces Direct, see [FAQs](storage-spaces-direct-faq.md).

## Storage Spaces Direct stack

Storage Spaces Direct is the evolution of Storage Spaces, first introduced in Windows Server 2012. It leverages many of the features you know today in Windows Server, such as Failover Clustering, the Cluster Shared Volume (CSV) file system, Server Message Block (SMB) 3, and Storage Spaces. It also introduces a new technology called Software Storage Bus.

Here's an overview of the features and components of a Storage Spaces Direct stack:

![Storage Spaces Direct Stack](media/storage-spaces-direct-in-windows-server-2016/converged-full-stack.png)

**Networking Hardware.** Storage Spaces Direct uses SMB3, including SMB Direct and SMB Multichannel, over Ethernet to communicate between servers. We strongly recommend 10+ GbE with remote-direct memory access (RDMA), either iWARP or RoCE.

**Storage Hardware.** From 2 to 16 servers with local-attached SATA, SAS, or NVMe drives. Each server must have at least 2 solid-state drives, and at least 4 additional drives. The SATA and SAS devices should be behind a host-bus adapter (HBA) and SAS expander. We strongly recommend the meticulously engineered and extensively validated platforms from our partners (coming soon).

**Failover Clustering.** The built-in clustering feature of Windows Server is used to connect the servers.

**Software Storage Bus.** The Software Storage Bus is new in Storage Spaces Direct. It spans the cluster and establishes a software-defined storage fabric whereby all the servers can see all of each other's local drives. You can think of it as replacing costly and restrictive Fibre Channel or Shared SAS cabling.

**Storage Bus Layer Cache.** The Software Storage Bus dynamically binds the fastest drives present (for example, SSD) to slower drives (for example, HDDs) to provide server-side read or write caching that accelerates IO and boosts throughput.

**Storage Pool.** The collection of drives that form the basis of Storage Spaces is called the storage pool. It is automatically created, and all eligible drives are automatically discovered and added to it. We strongly recommend you use one pool per cluster, with the default settings. To learn more about the Storage Pool, see the [Deep Dive into the Storage Pool](https://techcommunity.microsoft.com/t5/storage-at-microsoft/deep-dive-the-storage-pool-in-storage-spaces-direct/ba-p/425959) blog.

**Storage Spaces.** Storage Spaces provides fault tolerance to virtual "disks" using [mirroring, erasure coding, or both](storage-spaces-fault-tolerance.md). You can think of it as distributed, software-defined RAID using the drives in the pool. In Storage Spaces Direct, these virtual disks typically have resiliency to two simultaneous drive or server failures (e.g. 3-way mirroring, with each data copy in a different server) though chassis and rack fault tolerance is also available.

**Resilient File System (ReFS).** ReFS is the premier filesystem purpose-built for virtualization. It includes dramatic accelerations for .vhdx file operations such as creation, expansion, and checkpoint merging, and built-in checksums to detect and correct bit errors. It also introduces real-time tiers that rotate data between so-called "hot" and "cold" storage tiers in real-time based on usage.

**Cluster Shared Volumes.** The CSV file system unifies all the ReFS volumes into a single namespace accessible through any server, so that to each server, every volume looks and acts like it's mounted locally.

**Scale-Out File Server.** This final layer is necessary in converged deployments only. It provides remote file access using the SMB3 access protocol to clients, such as another cluster running Hyper-V, over the network, effectively turning Storage Spaces Direct into network-attached storage (NAS).

## Key benefits of Storage Spaces Direct

Storage Spaces Direct offers the following key benefits:

| Image | Description |
|--|--|
| ![Simplicity](media/storage-spaces-direct-in-windows-server-2016/simplicity-icon.png) | **Simplicity.** Go from industry-standard servers running Windows Server 2016 to your first Storage Spaces Direct cluster in under 15 minutes. For System Center users, deployment is just one checkbox. |
| ![Unrivaled Performance](media/storage-spaces-direct-in-windows-server-2016/performance-icon.png) | **Unrivaled Performance.** Whether all-flash or hybrid, Storage Spaces Direct easily exceeds [150,000 mixed 4k random IOPS per server](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) with consistent, low latency thanks to its hypervisor-embedded architecture, its built-in read/write cache, and support for cutting-edge NVMe drives mounted directly on the PCIe bus. |
| ![Fault Tolerance](media/storage-spaces-direct-in-windows-server-2016/fault-tolerance-icon.png) | **Fault Tolerance.** Built-in resiliency handles drive, server, or component failures with continuous availability. Larger deployments can also be configured for [chassis and rack fault tolerance](../../failover-clustering/fault-domains.md). When hardware fails, just swap it out; the software heals itself, with no complicated management steps. |
| ![Resource Efficiency](media/storage-spaces-direct-in-windows-server-2016/efficiency-icon.png) | **Resource Efficiency.** Erasure coding delivers up to 2.4x greater storage efficiency, with unique innovations like Local Reconstruction Codes and ReFS real-time tiers to extend these gains to hard disk drives and mixed hot/cold workloads, all while minimizing CPU consumption to give resources back to where they're needed most - the VMs. |
| ![Manageability](media/storage-spaces-direct-in-windows-server-2016/manageability-icon.png) | **Manageability**. Use [Storage QoS Controls](../storage-qos/storage-qos-overview.md) to keep overly busy VMs in check with minimum and maximum per-VM IOPS limits. The [Health Service](../../failover-clustering/health-service-overview.md) provides continuous built-in monitoring and alerting, and new APIs make it easy to collect rich, cluster-wide performance and capacity metrics. |
| ![Scalability](media/storage-spaces-direct-in-windows-server-2016/scalability-icon.png) | **Scalability**. Go up to 16 servers and over 400 drives, for up to 1 petabyte (1,000 terabytes) of storage per cluster. To scale out, simply add drives or add more servers; Storage Spaces Direct will automatically onboard new drives and begin using them. Storage efficiency and performance improve predictably at scale. |

## Storage Spaces Direct deployment

There are two ways in which you can deploy Storage Spaces Direct in your cluster infrastructure:

- Converged
- Hyperconverged

> [!NOTE]
> Azure Stack HCI, versions 21 H2 and 20H2 support only hyperconverged deployment.

### Converged deployment

In the converged deployment, you use separate clusters for storage and compute. The converged deployment option, also known as 'disaggregated', layers a Scale-out File Server (SoFS) atop Storage Spaces Direct to provide network-attached storage over SMB3 file shares. This allows for scaling compute and workload independently from the storage cluster, essential for larger-scale deployments such as Hyper-V IaaS (Infrastructure as a Service) for service providers and enterprises.

![Storage Spaces Direct serves storage using the Scale-Out File Server feature to Hyper-V VMs in another server or cluster](media/storage-spaces-direct-in-windows-server-2016/converged-minimal.png)

### Hyperconverged

In the hyperconverged deployment, you use single cluster for both compute and storage. The hyperconverged deployment option runs Hyper-V virtual machines or SQL Server databases directly on the servers providing the storage, storing their files on the local volumes. This eliminates the need to configure file server access and permissions, and reduces hardware costs for small-to-medium business or remote office/branch office deployments. See [Deploy Storage Spaces Direct](deploy-storage-spaces-direct.md).

![Storage Spaces Direct serves storage to Hyper-V VMs in the same cluster](media/storage-spaces-direct-in-windows-server-2016/hyper-converged-minimal.png)

## Manage and monitor Storage Spaces Direct

You can use the following tools to manage and monitor Storage Spaces Direct:

| Name | Graphical or command-line? | Paid or included? |
|-----------------|----------------------------|-------------------|
| [Windows Admin Center](../../manage/windows-admin-center/overview.md)     | Graphical    | Included |
| Server Manager & Failover Cluster Manager                                 | Graphical    | Included |
| Windows PowerShell                                                        | Command-line | Included |
| [System Center Virtual Machine Manager (SCVMM)](/system-center/vmm/s2d) <br>& [Operations Manager (SCOM)](https://www.microsoft.com/download/details.aspx?id=54700) | Graphical    | Paid     |

## Videos

**Overview (5 minutes)**

> [!Video https://www.youtube-nocookie.com/embed/raeUiNtMk0E]

**Storage Spaces Direct at Microsoft Ignite 2018 (1 hour)**

> [!Video https://www.youtube-nocookie.com/embed/5kaUiW3qo30]

**Storage Spaces Direct at Microsoft Ignite 2017 (1 hour)**

> [!Video https://www.youtube-nocookie.com/embed/YDr2sqNB-3c]

**Storage Spaces Direct launch event at Microsoft Ignite 2016 (1 hour)**

> [!Video https://www.youtube-nocookie.com/embed/LK2ViRGbWs]

## Customer stories

There are [over 10,000 clusters](https://techcommunity.microsoft.com/t5/storage-at-microsoft/storage-spaces-direct-10-000-clusters-and-counting/ba-p/428185) worldwide running Storage Spaces Direct. Organizations of all sizes, from small businesses deploying just two nodes, to large enterprises and governments deploying hundreds of nodes, depend on Storage Spaces Direct for their critical applications and infrastructure.

Visit [Microsoft.com/HCI](https://www.microsoft.com/hci) to read their stories:

[![Grid of customer logos](media/storage-spaces-direct-in-windows-server-2016/customer-stories.png)](https://www.microsoft.com/hci)


## Additional References

- [Fault tolerance and storage efficiency](storage-spaces-fault-tolerance.md)
- [Storage Replica](../storage-replica/storage-replica-overview.md)
- [Storage at Microsoft blog](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)
- [Storage Spaces Direct throughput with iWARP](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (TechNet blog)
- [What's New in Failover Clustering in Windows Server](../../failover-clustering/whats-new-in-failover-clustering.md)
- [Storage Quality of Service](../storage-qos/storage-qos-overview.md)
- [Windows IT Pro Support](https://www.microsoft.com/itpro/windows/support)
