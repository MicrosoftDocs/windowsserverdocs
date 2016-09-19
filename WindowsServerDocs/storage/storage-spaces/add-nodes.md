---
title: Adding nodes or drives to Storage Spaces Direct
ms.prod: windows-server-threshold
ms.author: cosdar
ms.manager: dongill
ms.technology:
  - techgroup-storage
ms.topic: article
author: cosmosdarwin
ms.date: 09/19/2016
---
# Adding nodes or drives to Storage Spaces Direct

This topic describes how to add nodes (scaling "out") or drives (scaling "up") to Storage Spaces Direct.

## Adding nodes

**Scaling "Out" refers to adding new nodes to your Storage Spaces Direct cluster.** Scaling out can expand storage capacity, unlock greater storage efficiency, improve storage performance, and if you’re running hyper-converged, provide more compute resources for your workload.

Typical deployments are very easy to scale out. First, ensure the new node is running Windows Server 2016 Datacenter Edition, has joined the same Active Directory Domain Services domain, has all the requisite roles and features installed, and has networking properly configured. You can verify that it is suitable to join the cluster by running cluster validation again, including the new node. This should only take a few minutes.

```
Test-Cluster -Node Node, Node, Node, NewNode -Include "Storage Spaces Direct", Inventory, Network, "System Configuration"
```

   >[!TIP]
   > You can further verify that the new drives are ready for use by running **Get-PhysicalDisk** in PowerShell on the new node. Check that they are listed and marked **CanPool = True**. If they aren’t, you can check their **CannotPoolReason**, and if they contain old data or metadata, consider using **Clear-Disk**.

Now, the only step is to run the following PowerShell cmdlet on the cluster (as Administrator):

```
Add-ClusterNode -Name NewNode 
```

The node will join the cluster, its drives will automatically be added to the storage pool, and volumes will automatically be redistributed evenly across all the drives.

   >[!TIP]
   > Automatic pooling depends on you having only one pool. If you’ve circumvented the standard configuration to create multiple pools, you will need to add new drives to your preferred pool yourself using **Add-PhysicalDisk**.

You’re done! You are now ready to create more volumes! 

### Special case: from 2 to 3 nodes

With two nodes, you can only create two-way mirrored volumes (compare to distributed RAID-1). Any of the following cmdlets in PowerShell will do so.

```
New-Volume -FriendlyName "A" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 100GB
New-Volume -FriendlyName "B" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 100GB -ResiliencySettingName Mirror
New-Volume -FriendlyName "C" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -StorageTierFriendlyNames Capacity -StorageTierSizes 100GB
```

   >[!TIP]
   > Two-way mirroring only has **PhysicalDiskRedundancy = 1**, meaning that you are not protected against multiple simultaneous drive or node failures.

With three nodes, you can create three-way mirrored volumes, which are tolerant to multiple simultaneous failures. We recommend using three-way mirroring whenever possible. To begin creating three-way mirroed volumes, you have several options:

#### OPTION 1: Specify **PhysicalDiskRedundancy = 2** on each new volume upon creation.

```
New-Volume -FriendlyName "D" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 100GB -PhysicalDiskRedundancy 2
New-Volume -FriendlyName "E" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 100GB -ResiliencySettingName Mirror -PhysicalDiskRedundancy 2 
New-Volume -FriendlyName "F" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -StorageTierFriendlyNames Capacity -StorageTierSizes 100GB -PhysicalDiskRedundancy 2
```

#### OPTION 2: Set **PhysicalDiskRedundancy = 2** on the pool’s **ResiliencySetting** object, if you won’t reference the tier when thereafter creating volumes.

```
Get-StoragePool S* | Get-ResiliencySetting -Name Mirror | Set-ResiliencySetting -PhysicalDiskRedundancyDefault 2 
```

#### OPTION #: Set **PhysicalDiskRedundancy = 2** on the **StorageTier** called *Capacity*, and then create volumes by referencing the tier.

```
Set-StorageTier -FriendlyName Capacity -PhysicalDiskRedundancy 2 
```

It is worth noting that with three nodes, you are also able to use single parity (compare to distributed RAID-5). This has the advantage of greater storage efficiency: 66.7%, compared to 50.0% with two-way mirroring or 33.3% with three-way mirroring.

```
New-Volume -FriendlyName "P" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 100GB -ResiliencySettingName Parity 
```

   >[!TIP]
   > Tip: Single parity only has **PhysicalDiskRedundancy = 1**, meaning that you are not protected against multiple simultaneous drive or node failures.

### Special case: from 3 to 4 nodes

With four nodes, you can use "dual" parity, also commonly called "erasure coding" (compare to distributed RAID-6). This provides the same dual fault tolerance as three-way mirroring, but with a surprising 50.0% efficiency. Here again, if you’re coming from a smaller configuration, you have several options:

#### OPTION 1: Specify **PhysicalDiskRedundancy = 2** on each new volume upon creation.

```
New-Volume -FriendlyName "Q" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 100GB -ResiliencySettingName Parity -PhysicalDiskRedundancy 2
```

#### OPTION 2: Set **PhysicalDiskRedundancy = 2** on the pool’s **ResiliencySetting** object, if you won’t reference the tier when thereafter creating volumes.

```
Get-StoragePool S* | Get-ResiliencySetting -Name Parity | Set-ResiliencySetting -PhysicalDiskRedundancyDefault 2 
```

With four nodes, you can also begin using mixed resiliency, or "multi-resiliency", where an individual volume is part mirror, part parity.

For this, you will need to update your **StorageTier** configuration to have both *Performance* and *Capacity* tiers, as they would be created if you had first run **Enable-ClusterS2D** at four nodes. Specifically, both tiers should have the **MediaType** of your capacity devices (e.g. HDD) and **PhysicalDiskRedundancy = 2**. The *Performance* tier should be **ResiliencySettingName = Mirror**, and the *Capacity* tier should be **ResiliencySettingName = Parity**.

You may find it easiest to simply remove the existing tier, and create the two new ones.

#### OPTION 3: Modify the **StorageTier** definitions and then create volumes by referencing the tier.

```
Remove-StorageTier -FriendlyName Capacity

New-StorageTier -StoragePoolFriendlyName S2D* -MediaType HDD -PhysicalDiskRedundancy 2 -ResiliencySettingName Mirror -FriendlyName Performance
New-StorageTier -StoragePoolFriendlyName S2D* -MediaType HDD -PhysicalDiskRedundancy 2 -ResiliencySettingName Parity -FriendlyName Capacity
```

That’s it! You are now ready to create mixed resiliency volumes!

Example:

```
New-Volume -FriendlyName "M" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -StorageTierFriendlyNames Performance, Capacity -StorageTierSizes 50GB, 50GB 
```

### Greater parity efficiency beyond 4 nodes

As you scale beyond four nodes, new volumes can benefit from ever-greater parity encoding efficiency. For example, between six and seven nodes, efficiency improves from 50.0% to 66.7% as it becomes possible to use Reed-Solomon 4+2 (rather than 2+2). There are no steps you need to take to begin enjoying this new efficiency; the best possible encoding is determined automatically each time you create a volume.

However, any pre-existing volumes will *not* be "converted" to the new, wider encoding. One good reason is that to do so would require a massive calculation affecting literally *every single bit* in the entire deployment. If you would like pre-existing data to become encoded at the higher efficiency, you can migrate it to new volume(s).

### Adding nodes when using chassis or rack fault tolerance

**If your deployment uses chassis or rack fault tolerance, you must always specify the chassis or rack of new nodes before adding them to the cluster.** This lets Storage Spaces Direct know how best to distribute data to maximize fault tolerance. There are just two quick steps:

First, create a “placeholder” fault domain for the node with the following PowerShell cmdlet.

```
New-ClusterFaultDomain -Type Node -Name NewNode 
```

   >[!TIP]
   > Tip: Make sure you use exactly the name of the new node.

Then, move this placeholder into the chassis or rack where the new node is located in the real world.

```
Set-ClusterFaultDomain -Name NewNode -Parent ParentName 
```

For more information, check out [Fault domain awareness in Windows Server 2016](../../failover-clustering/fault-domains.md).

When the new node joins the cluster, it will automatically be associated (using its name) with the placeholder fault domain. 

That’s it! You are now ready to add the new node!

## Adding drives

**Scaling "Up" refers to adding new drives to existing nodes in your Storage Spaces Direct cluster.** If you have available slots, you can add drives to expand your storage capacity without adding nodes. You can add cache drives, or capacity drives, independently. That said, for best results, we strongly recommend always having the same number of drives in each node.

To scale up, simply connect the drives and verify that Windows discovers them. They should appear in the output of this PowerShell cmdlet (run as Administrator), on any cluster node, marked as **CanPool = True**.

```
Get-PhysicalDisk 
```

   >[!TIP]
   > If they don’t appear, you may need to manually scan for hardware changes. This can be done using **Device Manager**, under the **Action** menu. If they contain old data or metadata, consider reformatting them. This can be done using **Disk Management**.

Within a short time, eligible drives will automatically be claimed by Storage Spaces Direct, added to the storage pool, and volumes will automatically be redistributed evenly across all the drives. That’s it!

   >[!TIP]
   > Automatic pooling depends on you having only one pool. If you’ve circumvented the standard configuration to create multiple pools, you will need to add new drives to your preferred pool yourself using **Add-PhysicalDisk**.

You’re done! You are now ready to create more volumes!
