---
title: Create a Storage Spaces Direct Campus Cluster
description: Learn how to deploy a Storage Spaces Direct campus cluster for high availability and fault tolerance on Windows Server 2025 or later.
#customer intent: As an IT administrator, I want to create a Storage Spaces Direct campus cluster so that I can ensure rack-level resiliency for my workloads across two physical locations.
author: robinharwood
ms.author: roharwoo
ms.reviewer: robhind
ms.date: 05/29/2026
ms.topic: how-to
ai-usage: ai-assisted
---

# Create a Storage Spaces Direct campus cluster

A campus cluster is a failover cluster that distributes nodes and data across two physical racks in separate rooms or buildings within the same campus. This topology keeps your workloads available when an entire rack goes offline, such as during a power, network, or cooling outage.

This article shows you how to create a four-node (2+2) Storage Spaces Direct campus cluster on Windows Server 2025 or later, with two nodes in each rack-level fault domain. The cluster uses Storage Spaces Direct for storage and Resilient File System (ReFS) for the file system.

For more information about campus cluster architecture, supported configurations, and how it compares to other topologies, see [Failover Clustering topologies](topologies.md).

## Prerequisites

- Windows Server 2025 or later with the 2025-12 security update ([KB5072033](https://support.microsoft.com/help/5072033)) installed on every node in the failover cluster.
- All-flash capacity drives of the same type on every node (SSD or NVMe). Don't use HDDs and don't configure a caching tier.
- An equal number of nodes in each of the two rack-level fault domains. For supported node configurations, see [Failover Clustering topologies](topologies.md). This article shows the 2+2 configuration.
- Exactly two rack-level fault domains, with cluster nodes spanning both racks.
- Direct-attached storage that follows your hardware original equipment manufacturer (OEM) guidelines, including driver versions.
- A quorum witness (file share witness, disk witness, cloud witness, or USB witness) in a third physical location, separate from the two campus cluster racks.

For optimal performance and resiliency, use the following configurations:

- A separate network path from each rack to the cluster quorum resource.
- Redundant top-of-rack (TOR) switches, core switches, and dedicated networks for Storage Spaces Direct storage traffic to minimize single points of failure and maximize workload uptime and durability.
- Network latency of 1 ms or less between racks. Use the [PsPing](/sysinternals/downloads/psping) utility to measure network latency.
- Remote direct memory access (RDMA) network interface cards (NICs) and switches to achieve up to 30% CPU savings on your cluster.

## Create the campus failover cluster

To create a Storage Spaces Direct campus cluster on Windows Server 2025 or later, complete these high-level steps in order:

1. Create a failover cluster without storage.
1. Define two rack fault domains.
1. Enable Storage Spaces Direct.
1. Create volumes on the storage pool.

This section covers the first step: creating the failover cluster without storage.

#### [PowerShell](#tab/powershell)

To create the failover cluster, use the [New-Cluster](/powershell/module/failoverclusters/new-cluster) cmdlet.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command to create the cluster without storage:

   ```powershell
   New-Cluster -Name <ClusterName> -Node <Node1,Node2,Node3,Node4> -NoStorage
   ```

   Replace `<ClusterName>` with your cluster name and `<Node1,Node2,Node3,Node4>` with your node names.

#### [Failover Cluster Manager](#tab/fcm)

To create the failover cluster, use Failover Cluster Manager.

1. From the Windows desktop, open the **Start** menu, and then select the **Server Manager** tile.

1. On the **Tools** menu, select **Failover Cluster Manager**.

1. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**. The Create Cluster Wizard opens.

1. On the **Before You Begin** page, select **Next**.

1. On the **Select Servers** page, in the **Enter name** box, enter the name of a server to add as a failover cluster node, and then select **Add**. Repeat this step for each of the four nodes. When you're finished, select **Next**.

1. On the **Validation Warning** page, select **Yes** to run cluster validation, and then select **Next**. Complete the Validate a Configuration Wizard.

1. On the **Access Point for Administering the Cluster** page, enter a name for the cluster. If the servers don't use Dynamic Host Configuration Protocol (DHCP), configure one or more static IP addresses for the failover cluster. Select **Next**.

1. On the **Confirmation** page, clear the **Add all eligible storage to the cluster** checkbox because you configure storage later when enabling Storage Spaces Direct. Select **Next**.

1. On the **Summary** page, confirm that the wizard created the failover cluster successfully, and then select **Finish**.

---

## Define rack fault domains for the campus cluster

After you create the campus failover cluster, define two rack fault domains before you enable Storage Spaces Direct. Rack fault domains tell Storage Spaces Direct how to place data copies across the two physical racks so the cluster can tolerate the loss of an entire rack.

> [!IMPORTANT]
> Define fault domains before you enable Storage Spaces Direct. After you create the pool and volumes, data doesn't retroactively move in response to changes to the fault domain topology.

#### [PowerShell](#tab/powershell)

Here's how to define fault domains by using PowerShell.

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

For alternative methods to define fault domains, including by using individual PowerShell cmdlets, see [Fault domain awareness](fault-domains.md).

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

## Enable Storage Spaces Direct on the campus cluster

After you define the two rack fault domains, enable Storage Spaces Direct on the campus cluster. When you enable Storage Spaces Direct, it creates the storage pool and configures it for rack-level fault tolerance.

#### [PowerShell](#tab/powershell)

Here's how to enable Storage Spaces Direct by using the [Enable-ClusterStorageSpacesDirect](/powershell/module/failoverclusters/enable-clusterstoragespacesdirect) cmdlet.

1. Run PowerShell on your computer in an elevated session.

1. Enable Storage Spaces Direct on the cluster:

   ```powershell
   Enable-ClusterStorageSpacesDirect
   ```

1. Update the storage pool to use the latest features:

   ```powershell
   Get-StoragePool S2D* | Update-StoragePool
   ```

1. Verify that the storage pool version is 29 or later. A campus cluster requires storage pool version 29 for rack-level fault domain awareness:

   ```powershell
   (Get-CimInstance -Namespace root/microsoft/windows/storage `
       -ClassName MSFT_StoragePool `
       -Filter 'IsPrimordial = false').CimInstanceProperties['Version'].Value
   ```

1. Verify that the storage pool's `FaultDomainAwareness` property has the value `StorageRack`. This value confirms that Storage Spaces Direct places data copies across the two rack fault domains:

   ```powershell
   Get-StoragePool -FriendlyName S2D* | Format-List FaultDomainAwareness
   ```

#### [Failover Cluster Manager](#tab/fcm)

Here's how to enable Storage Spaces Direct by using Failover Cluster Manager.

1. In **Failover Cluster Manager**, expand the cluster name, and then select **Storage** > **Pools**.

1. Right-click **Pools**, and then select **Enable Storage Spaces Direct**.

1. Complete the wizard to enable Storage Spaces Direct on the cluster.

1. After enabling Storage Spaces Direct, use PowerShell to update the storage pool and verify the configuration:

   ```powershell
   Get-StoragePool S2D* | Update-StoragePool
   ```

1. Verify that the storage pool version is 29 or later. A campus cluster requires storage pool version 29 for rack-level fault domain awareness:

   ```powershell
   (Get-CimInstance -Namespace root/microsoft/windows/storage `
       -ClassName MSFT_StoragePool `
       -Filter 'IsPrimordial = false').CimInstanceProperties['Version'].Value
   ```

1. Verify that the storage pool's `FaultDomainAwareness` property has the value `StorageRack`. This value confirms that Storage Spaces Direct places data copies across the two rack fault domains:

   ```powershell
   Get-StoragePool -FriendlyName S2D* | Format-List FaultDomainAwareness
   ```

---

## Create volumes on the campus cluster

Create volumes on the Storage Spaces Direct pool based on your resiliency requirements. For a 2+2 campus cluster (two nodes in each of two racks), use four-copy mirrored volumes. A four-copy volume places one copy of data on each node, so the cluster can survive the loss of an entire rack and one additional node at the same time.

The following table compares the two volume resiliency options for a 2+2 campus cluster:

| Volume type | Storage efficiency | Fault tolerance |
|---|---|---|
| Four-copy mirror | 25% | Survives loss of an entire rack plus one additional node. |
| Two-copy mirror | 50% | Survives loss of one node. Doesn't survive loss of an entire rack. |

For more information about volume resiliency options, see [Fault tolerance and storage efficiency](../storage/storage-spaces/fault-tolerance.md).

#### [PowerShell](#tab/powershell)

To create a four-copy mirrored volume by using PowerShell, follow these steps:

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

1. Right-click the **S2D** storage pool, and then select **New Virtual Disk**.

1. In the New Virtual Disk Wizard, enter a name for the volume.

1. On the **Storage Layout** page, select **Mirror**.

1. On the **Resiliency Settings** page, select **Two-way mirror** for a two-copy volume.

1. On the **Provisioning Type** page, select either **Fixed** or **Thin**.

1. Specify the size for the volume and complete the wizard.

1. After you create the virtual disk, right-click it and select **New Volume** to format it by using ReFS.

---

## Scale the campus cluster by adding nodes

You can grow a campus cluster from 1+1 to 2+2, 3+3, 4+4, or 5+5 by adding one node at a time to a rack and then to the cluster. For each new node, first add it to the rack fault domain by using [New-ClusterFaultDomain](/powershell/module/failoverclusters/new-clusterfaultdomain), and then add it to the cluster by using [Add-ClusterNode](/powershell/module/failoverclusters/add-clusternode).

The following example adds `Node5` to `Room1` and `Node6` to `Room2`:

```powershell
$nodeName = 'Node5'
$rackFaultDomainName = 'Room1'
New-ClusterFaultDomain -Type Node -Name $nodeName -FaultDomain $rackFaultDomainName
Add-ClusterNode -Name $nodeName

$nodeName = 'Node6'
$rackFaultDomainName = 'Room2'
New-ClusterFaultDomain -Type Node -Name $nodeName -FaultDomain $rackFaultDomainName
Add-ClusterNode -Name $nodeName
```

Repeat the pattern, alternating racks, until you reach your target configuration. Always keep an equal number of nodes in each rack.

## Related content

- [Deploy a quorum witness](deploy-quorum-witness.md)
- [Fault domain awareness](fault-domains.md)
- [Announcing support for S2D Campus Cluster on Windows Server 2025](https://techcommunity.microsoft.com/blog/failoverclustering/announcing-support-for-s2d-campus-cluster-on-windows-server-2025/4477075)
