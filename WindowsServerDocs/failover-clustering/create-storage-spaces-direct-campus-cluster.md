---
title: Create a Storage Spaces Direct Campus Cluster on Windows Server
description: Discover step-by-step instructions to deploy a Storage Spaces Direct campus cluster for high availability and fault tolerance on Windows Server 2025.
#customer intent: As an IT administrator, I want to create a Storage Spaces Direct campus cluster so that I can ensure rack-level resiliency for my workloads across two physical locations.
author: robinharwood
ms.author: roharwoo
ms.reviewer: robhind
ms.date: 01/20/2026
ms.topic: how-to
---

# Create a Storage Spaces Direct campus cluster

Learn how to create a Storage Spaces Direct campus cluster on Windows Server 2025 and later. A campus cluster distributes data across two physical racks in separate rooms or buildings within the same campus, providing rack-level resiliency for your workloads.

> [!NOTE]
> A campus cluster is different from a stretch cluster. Campus clusters use LAN connectivity within the same location with S2D replication, while stretch clusters span geographically distant sites connected by WAN and use Storage Replica for replication.

For more information about campus cluster architecture, supported configurations, and how it compares to other topologies, see [Failover Clustering topologies](topologies.md).

## Prerequisites

Before you create a campus cluster, ensure you meet the following requirements:

- **Windows Server 2025** with the 2025-12 Security Update (KB5072033) installed on every node in the failover cluster.
- **Flat S2D storage** - All capacity drives must be flash-based (SSD or NVMe). Don't use HDDs.
- **Exactly two RACK fault domains** - You must define exactly two rack-level fault domains and place the cluster nodes in these two racks.
- **Hardware OEM guidelines** - Follow your hardware OEM's guidelines for the deployment.
- **Cluster quorum resource** - Place the quorum resource (File Share Witness, Disk Witness, Cloud Witness, or USB Witness) in a third room, separate from the data rooms containing the racks.

For optimal performance and resiliency, use the following configurations:

- Each rack has a separate network path to the cluster quorum resource.
- Use redundant top-of-rack (TOR) switches, core switches, and dedicated networks for S2D storage traffic to minimize single points of failure and maximize workload uptime and durability.
- Network latency of 1 ms or less between racks. Use the [PsPing](/sysinternals/downloads/psping) utility to measure network latency.
- RDMA NICs and switches, which can achieve up to 30% CPU savings.

## Create the failover cluster

To create a campus cluster, first create a failover cluster without storage, then define fault domains before enabling Storage Spaces Direct.

#### [PowerShell](#tab/powershell)

Here's how to create the failover cluster using the [New-Cluster](/powershell/module/failoverclusters/new-cluster) cmdlet.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command to create the cluster without storage:

   ```powershell
   New-Cluster -Name <ClusterName> -Node <Node1,Node2,Node3,Node4> -NoStorage
   ```

   Replace `<ClusterName>` with your cluster name and `<Node1,Node2,Node3,Node4>` with your node names.

#### [Failover Cluster Manager](#tab/fcm)

Here's how to create the failover cluster using Failover Cluster Manager.

1. From the Windows desktop, open the **Start** menu, and then select the **Server Manager** tile.

1. On the **Tools** menu, select **Failover Cluster Manager**.

1. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**. The Create Cluster Wizard opens.

1. On the **Before You Begin** page, select **Next**.

1. On the **Select Servers** page, in the **Enter name** box, enter the name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each of the four nodes. When you're finished, select **Next**.

1. On the **Validation Warning** page, select **Yes** to run cluster validation, and then select **Next**. Complete the Validate a Configuration Wizard.

1. On the **Access Point for Administering the Cluster** page, enter a name for the cluster. If the servers don't use DHCP, configure one or more static IP addresses for the failover cluster. Select **Next**.

1. On the **Confirmation** page, clear the **Add all eligible storage to the cluster** checkbox because you configure storage later when enabling Storage Spaces Direct. Select **Next**.

1. On the **Summary** page, confirm that the failover cluster was created successfully, and then select **Finish**.

---

## Define fault domains

After you create the cluster, define fault domains before you enable Storage Spaces Direct.

> [!IMPORTANT]
> You must define fault domains before enabling Storage Spaces Direct. Once you create the pool and volumes, data doesn't retroactively move in response to changes to the fault domain topology.

#### [PowerShell](#tab/powershell)

Here's how to define fault domains using PowerShell.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command to define two rack fault domains, with two nodes in each rack:

   ```powershell
   Set-ClusterFaultDomain -XML @"
   <Topology>
     <Site Name="Campus">
       <Rack Name="Room1">
         <Node Name="Node1"/>
         <Node Name="Node2"/>
       </Rack>
       <Rack Name="Room2">
         <Node Name="Node3"/>
         <Node Name="Node4"/>
       </Rack>
     </Site>
   </Topology>
   "@
   ```

   Replace the node names with your actual node names, and update the site and rack names as appropriate for your environment.

1. Verify the fault domain configuration by running:

   ```powershell
   Get-ClusterFaultDomain
   ```

For alternative methods to define fault domains, including using individual PowerShell cmdlets, see [Fault domain awareness](fault-domains.md).

#### [Failover Cluster Manager](#tab/fcm)

Failover Cluster Manager doesn't support configuring rack-level fault domains through the GUI. Use PowerShell to define fault domains.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command to define two rack fault domains, with two nodes in each rack:

   ```powershell
   Set-ClusterFaultDomain -XML @"
   <Topology>
     <Site Name="Campus">
       <Rack Name="Room1">
         <Node Name="Node1"/>
         <Node Name="Node2"/>
       </Rack>
       <Rack Name="Room2">
         <Node Name="Node3"/>
         <Node Name="Node4"/>
       </Rack>
     </Site>
   </Topology>
   "@
   ```

   Replace the node names with your actual node names.

1. Verify the fault domain configuration by running:

   ```powershell
   Get-ClusterFaultDomain
   ```

---

## Enable Storage Spaces Direct

After defining fault domains, enable Storage Spaces Direct on the cluster.

#### [PowerShell](#tab/powershell)

Here's how to enable Storage Spaces Direct using the [Enable-ClusterStorageSpacesDirect](/powershell/module/failoverclusters/enable-clusterstoragespacesdirect) cmdlet.

1. Run PowerShell on your computer in an elevated session.

1. Enable Storage Spaces Direct on the cluster:

   ```powershell
   Enable-ClusterStorageSpacesDirect
   ```

1. Update the storage pool to ensure it's using the latest features:

   ```powershell
   Get-StoragePool S2D* | Update-StoragePool
   ```

1. Verify that the storage pool version is 29 or later:

   ```powershell
   (Get-CimInstance -Namespace root/microsoft/windows/storage -ClassName MSFT_StoragePool -Filter 'IsPrimordial = false').CimInstanceProperties['Version'].Value
   ```

1. Verify that the storage pool's `FaultDomainAwareness` property is set to `StorageRack`:

   ```powershell
   Get-StoragePool -FriendlyName S2D* | Format-List FaultDomainAwarenessDefault
   ```

#### [Failover Cluster Manager](#tab/fcm)

Here's how to enable Storage Spaces Direct using Failover Cluster Manager.

1. In **Failover Cluster Manager**, expand the cluster name, and then select **Storage** > **Pools**.

1. Right-click **Pools**, and then select **Enable Storage Spaces Direct**. Follow the wizard to complete the operation.

1. After enabling Storage Spaces Direct, use PowerShell to update the storage pool and verify the configuration:

   ```powershell
   Get-StoragePool S2D* | Update-StoragePool
   ```

1. Verify that the storage pool version is 29 or later:

   ```powershell
   (Get-CimInstance -Namespace root/microsoft/windows/storage -ClassName MSFT_StoragePool -Filter 'IsPrimordial = false').CimInstanceProperties['Version'].Value
   ```

1. Verify that the storage pool's `FaultDomainAwareness` property is set to `StorageRack`:

   ```powershell
   Get-StoragePool -FriendlyName S2D* | Format-List FaultDomainAwarenessDefault
   ```

---

## Create volumes

Create volumes on the storage pool based on your resiliency requirements. For a 2+2 campus cluster, use four-copy volumes as they provide the best balance between cost, performance, and resiliency. A four-copy volume places a copy of data on each node, so the cluster can survive losing an entire rack and a node at the same time.

A four-copy volume provides 25% storage capacity, while a two-copy volume provides 50% capacity with less resiliency. For more information about volume resiliency options, see [Fault tolerance and storage efficiency](../storage/storage-spaces/fault-tolerance.md).

#### [PowerShell](#tab/powershell)

Here's how to create a four-copy mirrored volume using PowerShell.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command to create a four-copy volume:

   ```powershell
   New-Volume -FriendlyName "FourCopyVolume" `
       -StoragePoolFriendlyName S2D* `
       -FileSystem CSVFS_ReFS `
       -Size 500GB `
       -ResiliencySettingName Mirror `
       -PhysicalDiskRedundancy 3 `
       -ProvisioningType Fixed `
       -NumberOfDataCopies 4 `
       -NumberOfColumns 3
   ```

   To create a two-copy volume instead, set `-PhysicalDiskRedundancy 1` and remove the `-NumberOfDataCopies` and `-NumberOfColumns` parameters. To use thin provisioning, change `-ProvisioningType` to `Thin`.

For more information about resiliency types and storage efficiency, see [Fault tolerance and storage efficiency](../storage/storage-spaces/fault-tolerance.md).

#### [Failover Cluster Manager](#tab/fcm)

Here's how to create volumes using Failover Cluster Manager. To create four-copy volumes, use PowerShell.

1. In **Failover Cluster Manager**, expand the cluster name, and then select **Storage** > **Pools**.

1. Select the **S2D** storage pool, and then right-click and select **New Virtual Disk**.

1. In the New Virtual Disk Wizard, enter a name for the volume.

1. On the **Storage Layout** page, select **Mirror**.

1. On the **Resiliency Settings** page, select **Two-way mirror** for a two-copy volume.

1. On the **Provisioning Type** page, select either **Fixed** or **Thin**.

1. Specify the size for the volume and complete the wizard.

1. After creating the virtual disk, right-click it and select **New Volume** to format it by using ReFS.

---

## Related content

- [Deploy a quorum witness](deploy-quorum-witness.md)
- [Fault domain awareness](fault-domains.md)
- [Announcing support for S2D Campus Cluster on Windows Server 2025](https://techcommunity.microsoft.com/blog/failoverclustering/announcing-support-for-s2d-campus-cluster-on-windows-server-2025/4477075)
