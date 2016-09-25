---
title: Storage Spaces Direct in Windows Server 2016
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dongill
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
manager: eldenc
ms.date: 09/16/2016
ms.assetid: 8bd0d09a-0421-40a4-b752-40ecb5350ffd
---
# Storage Spaces Direct in Windows Server 2016
>Applies To: Windows Server 2016

Storage Spaces Direct uses industry-standard servers with local-attached drives to create highly available, highly scalable software-defined storage at a fraction of the cost of traditional SAN or NAS arrays. Its converged or hyper-converged architecture radically simplifies procurement and deployment, while features like caching, tiering, and erasure coding, together with the latest hardware innovation like RDMA networking and NVMe drives, deliver unrivaled efficiency and performance.

Storage Spaces Direct is included in Windows Server 2016 Datacenter.

[![Storage Spaces Direct overview video](media/Storage-Spaces-Direct-in-Windows-Server-2016/storage-spaces-direct-video-thumbnail.png)](https://www.youtube.com/embed/raeUiNtMk0E)

## Key Benefits

<table>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0;">
			<img src="media/simplicity-icon.png">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Simplicity.</b> Go from industry-standard servers running Windows Server 2016 to your first Storage Spaces Direct cluster in under 15 minutes. For System Center users, deployment is just one literal checkbox.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0;">
			<img src="media/performance-icon.png">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Unrivaled Performance.</b> Whether all-flash or hybrid, Storage Spaces Direct easily exceeds 150,000 mixed 4k random IOPS per server with consistent, low latency thanks to its hypervisor-embedded architecture, its built-in read/write cache, and support for cutting-edge NVMe drives mounted directly on the PCIe bus.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0;">
			<img src="media/fault-tolerance-icon.png">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Fault Tolerance.</b> Built-in resiliency handles drive, server, or component failures with continuous availability. Larger deployments can also be configured for chassis and rack fault tolerance. When hardware fails, just swap it out; the software heals itself, with no complicated management steps.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0;">
			<img src="media/efficiency-icon.png">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Resource Efficiency.</b> Erasure coding delivers up to 2.4x greater storage efficiency, with unique innovations like Local Reconstruction Codes and real-time tiering to extend these gains to hard disk drives and mixed hot/cold workloads, all while minimizing CPU consumption to give resources back to where they're needed most - the VMs.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0;">
			<img src="media/manageability-icon.png">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Manageability.</b> Use Storage QoS Controls to keep noisy neighbors in check with minimum and maximum per-VM IOPS limits. The Health Service provides continuous built-in monitoring and alerting, and new APIs make it easy to collect rich, cluster-wide performance and capacity metrics.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0;">
			<img src="media/scalability-icon.png">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Scalability.</b> Go up to 16 servers and over 400 drives, for multiple petabytes of storage per cluster! To scale out, simply add drives or add more servers; Storage Spaces Direct will automatically onboard new drives and begin using them. Storage efficiency and performance improve predictably at scale.
		</td>
	</tr>
</table>

## Deployment Options

Storage Spaces Direct was designed for two distinct deployment options:

The converged deployment option, also known as disaggregated, layers a Scale-out File Server (SoFS) atop Storage Spaces Direct to provide network-attached storage over SMB3 File Shares. This allows for scaling of compute/workload independently from the storage cluster, essential for larger-scale deployments such as Hyper-V IaaS (Infrastructure as a Service) for service providers and enterprises.

The hyper-converged deployment option runs Hyper-V virtual machines or SQL Server databases directly on the servers providing the storage, storing their files on the local volumes. This eliminates the need to configure file server access and permissions, and reduces hardware costs for small-to-medium business or remote office/branch office deployments. See Hyper-converged solution using Storage Spaces Direct.

## How It Works

Storage Spaces Direct is the evolution of Storage Spaces, first introduced in Windows Server 2012. It leverages many of the features you know today in Windows Server, such as Failover Clustering, the Cluster Shared Volume (CSV) File System, Server Message Block (SMB) 3, and of course Storage Spaces. It also introduces new technology, most notably the Software Storage Bus and its sprawling feature set.

Here’s an overview of the Storage Spaces Direct stack:

**Networking Hardware.** Storage Spaces Direct uses SMB3, including SMB Direct and SMB Multichannel, over Ethernet to communicate between servers. We strongly recommend 10+ GbE with remote-direct memory access (RDMA), either iWARP or RoCE.

**Storage Hardware.** From 2 to 16 servers with local-attached SATA, SAS, or NVMe drives. Each server must have at least 2 solid-state drives, and at least 4 additional drives. The SATA and SAS devices should be behind a host-bus adapter (HBA) and SAS expander. We strongly recommend these meticulously engineered and extensively validated platforms from our partners.

**Failover Clustering.** The built-in clustering feature of Windows Server is used to connect the servers.

**Software Storage Bus.** The Software Storage Bus is new in Storage Spaces Direct. It spans the cluster and establishes a software-defined storage fabric whereby all the servers can see all of each other’s local drives. You can think of it as replacing costly and restrictive Fibre Channel or Shared SAS cabling.

**Storage Bus Layer Cache.** The Software Storage Bus dynamically binds the fastest drives present (e.g. SSD) to slower drives (e.g. HDDs) to provide server-side read/write caching that accelerates IO and boosts throughput.

**Storage Pool.** The collection of drives that will form the basis of Storage Spaces is called the Storage Pool. It is automatically created, and all eligible drives are automatically discovered and added to it. We strongly recommend you use one pool per cluster, with the default settings.

**Storage Spaces.** Storage Spaces provides fault tolerance to virtual “disks” using mirroring, erasure coding, or both. You can think of it as distributed, software-defined RAID using the drives in the pool. In Storage Spaces Direct, these virtual disks typically have resiliency to two simultaneous drive or server failures (e.g. 3-way mirroring, with each data copy in a different server) though chassis and rack fault tolerance is also available.

**Resilient File System (ReFS).** ReFS is the premier filesystem purpose-built for virtualization. It includes dramatic accelerations for VHD(X) file operations such as creation, expansion, and checkpoint merging, and built-in checksums to detect and correct bit errors. It also introduces Real-Time Tiering, which rotates data between so-called “hot” and “cold” storage tiers in real-time based on usage.

**Cluster Shared Volumes.** The CSV File System unifies all the ReFS volumes into a single namespace accessible through any server, so that to each server, every volume looks and acts like it’s mounted locally.

**Scale-Out File Server.** This final layer is necessary in converged deployments only. It provides remote file access using the SMB3 access protocol to clients, such as another cluster running Hyper-V, over the network, effectively turning Storage Spaces Direct into network-attached storage (NAS).

## Get Started

Try Storage Spaces Direct today in Azure, or download the Windows Server 2016 Technical Preview.

![](media/storage-spaces-direct-in-windows-server-2016/StorageSpacesDirectStack.png)  
![](media/storage-spaces-direct-in-windows-server-2016/StorageSpacesDirectHyperconverged.png)

[Storage Spaces Direct - Under the hood with the Software Storage Bus](http://blogs.technet.com/b/clausjor/archive/2015/11/19/storage-spaces-direct-under-the-hood-with-the-software-storage-bus.aspx).  
[Hyper-converged solution using Storage Spaces Direct](hyper-converged-solution-using-storage-spaces-direct.md).   

## Related Topics  
-   [Hyper-converged solution using Storage Spaces Direct in Windows Server 2016](hyper-converged-solution-using-storage-spaces-direct.md)  

## See Also  
-   [What's New in Failover Clustering in Windows Server](../../failover-clustering/whats-new-in-failover-clustering.md)  
-   [Storage Replica in Windows Server 2016](../storage-replica/storage-replica-overview.md)  
-   [Storage Quality of Service](../storage-qos/storage-qos-overview.md)
