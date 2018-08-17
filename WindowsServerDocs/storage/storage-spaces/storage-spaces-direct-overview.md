---
title: Storage Spaces Direct overview
ms.prod: windows-server-threshold
ms.author: cosdar
ms.manager: dongill
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 7/27/2018
ms.assetid: 8bd0d09a-0421-40a4-b752-40ecb5350ffd
description: An overview of Storage Spaces Direct, a feature of Windows Server that enables you to cluster servers with internal storage into a software-defined storage solution.
ms.localizationpriority: medium
---
# Storage Spaces Direct overview

>Applies to: Windows Server 2016

Storage Spaces Direct uses industry-standard servers with local-attached drives to create highly available, highly scalable software-defined storage at a fraction of the cost of traditional SAN or NAS arrays. Its converged or hyper-converged architecture radically simplifies procurement and deployment, while features such as caching, storage tiers, and erasure coding, together with the latest hardware innovations such as RDMA networking and NVMe drives, deliver unrivaled efficiency and performance.

Storage Spaces Direct is included in Windows Server 2016 Datacenter and [Windows Server Insider Preview Builds](https://insider.windows.com/en-us/for-business-getting-started-server/). 

For other applications of Storage Spaces, such as Shared SAS clusters and stand-alone servers, see [Storage Spaces overview](overview.md). If you're looking for info about using Storage Spaces on a Windows 10 PC, see [Storage Spaces in Windows 10](https://support.microsoft.com/help/12438/windows-10-storage-spaces).

<table>
    <tr style="border: 0;">
        <td style="padding: 5px; border: 0;">
            <strong>Understand</a></strong>
            <ul>
			  <li>Overview (you are here)</li>
			  <li><a href="understand-the-cache.md">Understand the cache</a></li>
			  <li><a href="storage-spaces-fault-tolerance.md">Fault tolerance and storage efficiency</a></li>
              <li><a href="drive-symmetry-considerations.md">Drive symmetry considerations</a></li>
              <li><a href="understand-quorum.md">Understanding cluster and pool quorum</a></li>
		  	</ul>
        </td>
        <td style="padding: 5px; border: 0;">
            <strong>Plan</a></strong>
            <ul>
			  <li><a href="storage-spaces-direct-hardware-requirements.md">Hardware requirements</a></li>
              <li><a href="csv-cache.md">Using the CSV in-memory read cache</li>
			  <li><a href="choosing-drives.md">Choose drives</a></li>
			  <li><a href="plan-volumes.md">Plan volumes</a></li>
              <li><a href="storage-spaces-direct-in-vm.md">Using guest VM clusters</a></li>
              <li><a href="storage-spaces-direct-disaster-recovery.md">Disaster recovery</a></li>
		    </ul>
        </td>
    </tr>
    <tr style="border: 0;">
        <td style="padding: 5px; border: 0;">
            <strong>Deploy</a></strong>
            <ul>
			  <li><a href="deploy-storage-spaces-direct.md">Deploy Storage Spaces Direct</a></li>
			  <li><a href="create-volumes.md">Create volumes</a></li>
              <li><a href="../../failover-clustering/manage-cluster-quorum.md">Configure quorum</a><br><br><br></li>
		    </ul>
        </td>        
        <td style="padding: 5px; border: 0;">
            <strong>Manage</a></strong>
            <ul>
              <li><a href="../../manage/windows-admin-center/use/manage-hyper-converged.md">Manage with Windows Admin Center</a></li>
			  <li><a href="add-nodes.md">Add servers or drives</a></li>
			  <li><a href="maintain-servers.md">Taking a server offline for maintenance</li>
			  <li><a href="remove-servers.md">Remove servers</a></li>
			  <li><a href="resize-volumes.md">Extend volumes</a></li>
			  <li><a href="../update-firmware.md">Update drive firmware</a></li>
		    </ul>
        </td>
    </tr>
    <tr style="border: 0;">
         <td style="padding: 5px; border: 0;">
            <strong>Troubleshooting</a></strong>
            <ul>
              <li><a href="storage-spaces-states.md">Troubleshoot health and operational states</a></li>
              <li><a href="data-collection.md">Collect diagnostic data with Storage Spaces Direct</a></li>
            </ul>
         <td style="padding: 5px; border: 0;">
            <strong>Insider Preview content</a></strong>
            <ul>
                <li><a href="cluster-sets.md">Cluster sets</a></li>
                <li><a href="performance-history.md">Performance history</a></li>
                <li><a href="delimit-volume-allocation.md">Delimit the allocation of volumes</a></li>
            </ul>
    </tr>
</table>

## Videos

**Quick Video Overview (5 minutes)**

<iframe src="https://www.youtube-nocookie.com/embed/raeUiNtMk0E" width="560" height="315" allowfullscreen></iframe>

**Storage Spaces Direct at Microsoft Ignite 2017 (1 hour)**

[Watch on YouTube](https://www.youtube.com/watch?v=YDr2sqNB-3c)

**Launch Event at Microsoft Ignite 2016 (1 hour)**

[Watch on YouTube](https://www.youtube.com/watch?v=-LK2ViRGbWs)

## Key benefits

<table>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0; width:100px">
			<img src="media/storage-spaces-direct-in-windows-server-2016/simplicity-icon.png" width="100" alt="">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Simplicity.</b> Go from industry-standard servers running Windows Server 2016 to your first Storage Spaces Direct cluster in under 15 minutes. For System Center users, deployment is just one checkbox.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0; width:100px">
			<img src="media/storage-spaces-direct-in-windows-server-2016/performance-icon.png" width="100" alt="">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Unrivaled Performance.</b> Whether all-flash or hybrid, Storage Spaces Direct easily exceeds <a href="https://blogs.technet.microsoft.com/filecab/2016/07/26/storage-iops-update-with-storage-spaces-direct/">150,000 mixed 4k random IOPS per server</a> with consistent, low latency thanks to its hypervisor-embedded architecture, its built-in read/write cache, and support for cutting-edge NVMe drives mounted directly on the PCIe bus.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0; width:100px">
			<img src="media/storage-spaces-direct-in-windows-server-2016/fault-tolerance-icon.png" width="100" alt="">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Fault Tolerance. </b> Built-in resiliency handles drive, server, or component failures with continuous availability. Larger deployments can also be configured for <a href="../../failover-clustering/fault-domains.md">chassis and rack fault tolerance</a>. When hardware fails, just swap it out; the software heals itself, with no complicated management steps.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0; width:100px">
			<img src="media/storage-spaces-direct-in-windows-server-2016/efficiency-icon.png" width="100" alt="">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Resource Efficiency.</b> Erasure coding delivers up to 2.4x greater storage efficiency, with unique innovations like Local Reconstruction Codes and ReFS real-time tiers to extend these gains to hard disk drives and mixed hot/cold workloads, all while minimizing CPU consumption to give resources back to where they're needed most - the VMs.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0; width:100px">
			<img src="media/storage-spaces-direct-in-windows-server-2016/manageability-icon.png" width="100" alt="">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Manageability.</b> Use <a href="../storage-qos/storage-qos-overview.md">Storage QoS Controls</a> to keep overly busy VMs in check with minimum and maximum per-VM IOPS limits. The <a href="../../failover-clustering/health-service-overview.md">Health Service</a> provides continuous built-in monitoring and alerting, and new APIs make it easy to collect rich, cluster-wide performance and capacity metrics.
		</td>
	</tr>
	<tr style="border: 0;">
		<td style="padding: 10px; border: 0; width:100px">
			<img src="media/storage-spaces-direct-in-windows-server-2016/scalability-icon.png" width="100" alt="">
		</td>
		<td style="padding: 10px; border: 0;">
			<b>Scalability.</b> Go up to 16 servers and over 400 drives, for up to 1 petabyte (1,000 terabytes) of storage per cluster. To scale out, simply add drives or add more servers; Storage Spaces Direct will automatically onboard new drives and begin using them. Storage efficiency and performance improve predictably at scale.
		</td>
	</tr>
</table>

## Deployment options

Storage Spaces Direct was designed for two distinct deployment options:

### Converged

**Storage and compute in separate clusters.** The converged deployment option, also known as 'disaggregated', layers a Scale-out File Server (SoFS) atop Storage Spaces Direct to provide network-attached storage over SMB3 file shares. This allows for scaling compute/workload independently from the storage cluster, essential for larger-scale deployments such as Hyper-V IaaS (Infrastructure as a Service) for service providers and enterprises.

![Storage Spaces Direct serves storage using the Scale-Out File Server feature to Hyper-V VMs in another server or cluster](media/storage-spaces-direct-in-windows-server-2016/converged-minimal.png)

### Hyper-Converged

**One cluster for compute and storage.** The hyper-converged deployment option runs Hyper-V virtual machines or SQL Server databases directly on the servers providing the storage, storing their files on the local volumes. This eliminates the need to configure file server access and permissions, and reduces hardware costs for small-to-medium business or remote office/branch office deployments. See [Deploy Storage Spaces Direct](deploy-storage-spaces-direct.md).

![Storage Spaces Direct serves storage to Hyper-V VMs in the same cluster](media/storage-spaces-direct-in-windows-server-2016/hyper-converged-minimal.png)

## How it works

Storage Spaces Direct is the evolution of Storage Spaces, first introduced in Windows Server 2012. It leverages many of the features you know today in Windows Server, such as Failover Clustering, the Cluster Shared Volume (CSV) file system, Server Message Block (SMB) 3, and of course Storage Spaces. It also introduces new technology, most notably the Software Storage Bus.

Here's an overview of the Storage Spaces Direct stack:

![Storage Spaces Direct Stack](media/storage-spaces-direct-in-windows-server-2016/converged-full-stack.png)

**Networking Hardware.** Storage Spaces Direct uses SMB3, including SMB Direct and SMB Multichannel, over Ethernet to communicate between servers. We strongly recommend 10+ GbE with remote-direct memory access (RDMA), either iWARP or RoCE.

**Storage Hardware.** From 2 to 16 servers with local-attached SATA, SAS, or NVMe drives. Each server must have at least 2 solid-state drives, and at least 4 additional drives. The SATA and SAS devices should be behind a host-bus adapter (HBA) and SAS expander. We strongly recommend the meticulously engineered and extensively validated platforms from our partners (coming soon).

**Failover Clustering.** The built-in clustering feature of Windows Server is used to connect the servers.

**Software Storage Bus.** The Software Storage Bus is new in Storage Spaces Direct. It spans the cluster and establishes a software-defined storage fabric whereby all the servers can see all of each other's local drives. You can think of it as replacing costly and restrictive Fibre Channel or Shared SAS cabling.

**Storage Bus Layer Cache.** The [Software Storage Bus](software-storage-bus-overview.md) dynamically binds the fastest drives present (e.g. SSD) to slower drives (e.g. HDDs) to provide server-side read/write caching that accelerates IO and boosts throughput.

**Storage Pool.** The collection of drives that form the basis of Storage Spaces is called the storage pool. It is automatically created, and all eligible drives are automatically discovered and added to it. We strongly recommend you use one pool per cluster, with the default settings. Read our [Deep Dive into the Storage Pool](https://blogs.technet.microsoft.com/filecab/2016/11/21/deep-dive-pool-in-spaces-direct/) to learn more.

**Storage Spaces.** Storage Spaces provides fault tolerance to virtual "disks" using [mirroring, erasure coding, or both](storage-spaces-fault-tolerance.md). You can think of it as distributed, software-defined RAID using the drives in the pool. In Storage Spaces Direct, these virtual disks typically have resiliency to two simultaneous drive or server failures (e.g. 3-way mirroring, with each data copy in a different server) though chassis and rack fault tolerance is also available.

**Resilient File System (ReFS).** ReFS is the premier filesystem purpose-built for virtualization. It includes dramatic accelerations for .vhdx file operations such as creation, expansion, and checkpoint merging, and built-in checksums to detect and correct bit errors. It also introduces real-time tiers that rotate data between so-called "hot" and "cold" storage tiers in real-time based on usage.

**Cluster Shared Volumes.** The CSV file system unifies all the ReFS volumes into a single namespace accessible through any server, so that to each server, every volume looks and acts like it's mounted locally.

**Scale-Out File Server.** This final layer is necessary in converged deployments only. It provides remote file access using the SMB3 access protocol to clients, such as another cluster running Hyper-V, over the network, effectively turning Storage Spaces Direct into network-attached storage (NAS).

## Customer stories

There are [over 10,000 clusters](https://blogs.technet.microsoft.com/filecab/2018/03/27/storage-spaces-direct-momentum/) worldwide running Storage Spaces Direct. Organizations of all sizes, from small businesses deploying just two nodes, to large enterprises and governments deploying hundreds of nodes, depend on Storage Spaces Direct for their critical applications and infrastructure.

Click any logo to read the full customer story:

<div style="background-color: rgba(0,0,0,0.1); padding: 10px;">
    <a target="_blank" href="https://customers.microsoft.com/story/createadvertising"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Create Advertising (Microsoft Customer Story)" src="wall-of-logos/microsoft-create-advertising.png"></a>
    <a target="_blank" href="https://lenovosuccess.com/casestudy/majmaah-university"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Majmaah University (Lenovo Customer Success Story)" src="wall-of-logos/lenovo-majmaah-university.png"></a>
    <a target="_blank" href="https://lenovosuccess.com/casestudy/soerum-kommune"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Soerum Kommune (Lenovo Customer Success Story)" src="wall-of-logos/lenovo-soerum-kommune.png"></a>
    <a target="_blank" href="https://www.fujitsu.com/global/about/resources/case-studies/cs-2017mar-make-it.html"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Make IT (Fujitsu Case Study)" src="wall-of-logos/fujitsu-make-it.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/mead-hunt-replaces-aging-san-with-dataon-cib-9112-and-windows-server-2016-running-refs-and-hyper-v/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Mead & Hunt (DataON Case Study)" src="wall-of-logos/dataon-mead-hunt.png"></a>
    <a target="_blank" href="https://customers.microsoft.com/story/youth-villages"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Youth Villages (Microsoft Customer Story)" src="wall-of-logos/microsoft-youth-villages.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/evga-chooses-microsoft-and-dataon-for-their-next-generation-hyper-converged-cluster-platform/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="EVGA (DataON Case Study)" src="wall-of-logos/dataon-evga.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/king-county-wa-library-system-upgrades-to-a-storage-spaces-direct/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="King County Library System (DataON Case Study)" src="wall-of-logos/dataon-king-county-library-system.png"></a>
    <a target="_blank" href="https://www.fujitsu.com/global/about/resources/case-studies/cs-2017sep-itarex.html"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="iTAREX (Fujitsu Case Study)" src="wall-of-logos/fujitsu-itarex.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/bennington-updates-their-storage-with-a-windows-server-2016-solution/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Bennington (DataON Case Study)" src="wall-of-logos/dataon-bennington.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/cherokee-county-school-district-replaces-their-iscsi-san-storage-with-a-storage-spaces-direct/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Cherokee County School District (DataON Case Study)" src="wall-of-logos/dataon-cherokee-county-school-district.png"></a>
    <a target="_blank" href="https://www.fujitsu.com/global/about/resources/case-studies/cs-2018jun-harreringenieure.html"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Harrer Ingenieure GmbH (Fujitsu Case Study)" src="wall-of-logos/fujitsu-harrer-ingenieure.png"></a>
    <a target="_blank" href="https://lenovosuccess.com/casestudy/braathe-gruppen-as"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Braathe Gruppen Read (Lenovo Customer Success Story)" src="wall-of-logos/lenovo-braathe-gruppen.png"></a>
    <a target="_blank" href="https://lenovosuccess.com/casestudy/cloud-factory"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="SE Cloud Factory (Lenovo Customer Success Story)" src="wall-of-logos/lenovo-se-cloud-factory.png"></a>
    <a target="_blank" href="https://lenovosuccess.com/casestudy/oblakoteka"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Oblakoteka Read (Lenovo Customer Success Story)" src="wall-of-logos/lenovo-oblakoteka.png"></a>
    <a target="_blank" href="https://lenovosuccess.com/casestudy/acuutech"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Acuutech (Lenovo Customer Success Story)" src="wall-of-logos/lenovo-acuutech.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/infront-upgrades-their-hyper-v-and-storage-environment-to-a-dataon-and-storage-spaces-direct-solution/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Infront Finance (DataON Case Study)" src="wall-of-logos/dataon-infront.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/tmi-systems-consolidates-networking-and-storage-into-a-cost-effective-high-performance-storage-spaces-direct/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="TMI (DataON Case Study)" src="wall-of-logos/dataon-tmi.png"></a>
    <a target="_blank" href="https://www.dataonstorage.com/customer-stories/quest-chooses-dataon-microsoft-power-veeam-cloud-connect-backup-service/"><img onload="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px;'" onmouseover="this.style.cssText = 'box-shadow: 0px 2px 10px 2px rgba(0,0,0,0.2); margin: 0px 2px 4px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" onmouseout="this.style.cssText = 'box-shadow: none; margin: 2px 2px 2px 2px; width: 19.2%; max-width: 225px; transition: 0.2s;'" title="Quest Technology Management (DataON Case Study)" src="wall-of-logos/dataon-quest-technology-management.png"></a>
</div>

## Management tools

The following tools can be used to manage and/or monitor Storage Spaces Direct:

| Name | Graphical or command-line? | Paid or included? |
|-----------------|----------------------------|-------------------|
| [Windows Admin Center](../../manage/windows-admin-center/overview.md)     | Graphical    | Included |
| Server Manager & Failover Cluster Manager                                 | Graphical    | Included |
| Windows PowerShell                                                        | Command-line | Included |
| [System Center Virtual Machine Manager (SCVMM)](https://technet.microsoft.com/system-center-docs/vmm/manage/manage-storage-spaces-direct-vmm) & [Operations Manager (SCOM)](https://www.microsoft.com/download/details.aspx?id=54700) | Graphical    | Paid     |

## Get started

Try Storage Spaces Direct [in Microsoft Azure](https://blogs.technet.microsoft.com/filecab/2016/05/05/s2dazuretp5/), or download a 180-day-licensed evaluation copy of Windows Server from [Windows Server Evaluations](https://go.microsoft.com/fwlink/?linkid=842602).

## See also

-   [Fault tolerance and storage efficiency](storage-spaces-fault-tolerance.md)
-   [Storage Replica](../storage-replica/storage-replica-overview.md)
-   [Storage Spaces Direct throughput with iWARP](https://blogs.technet.microsoft.com/filecab/2017/03/13/storage-spaces-direct-throughput-with-iwarp) (TechNet blog)
-   [What's New in Failover Clustering in Windows Server](../../failover-clustering/whats-new-in-failover-clustering.md)  
-   [Storage Quality of Service](../storage-qos/storage-qos-overview.md)
-   [Windows IT Pro Support](https://www.microsoft.com/itpro/windows/support)
