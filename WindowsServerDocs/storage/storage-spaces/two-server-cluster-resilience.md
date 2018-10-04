---
title: Increasing resiliency to drive failures on Storage Spaces Direct two-server clusters
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dansimp
ms.technology: storagespaces
ms.topic: article
author: jasongerend
ms.date: 10/04/2018
---
# Increasing resiliency to drive failures on Storage Spaces Direct two-server clusters

>Applies to: Windows Server 2019

This topic describes how to increase the resiliency to drive failures in a two-server cluster that uses Storage Spaces Direct by using mirror-accelerated parity volumes on Windows Server 2019.

Normally, when creating volumes on a two-server Storage Spaces Direct cluster, you create two-way mirrors, saving one copy of your data on each of the two servers.

In Windows Server 2019 you have two additional options for volumes on two-server clusters, both of which enable the cluster to tolerate a server going down and then losing a drive in the remaining server:

- **Mirror-accelerated parity** volumes that contain two tiers:
    - A **nested two-way mirror tier** that stores data in a two-way mirror that is itself mirrored between the two servers. It's basically a two-way mirror of a two-way mirror (or you could think of it as a four-way mirror). This enables each of the two servers to store two copies of your data. New data is quickly written to this tier and accessed at the high speed typical of a mirror.<br><br>On the nested two-way mirror tier, 10 GB of data takes 40 GB of capacity (20 GB on each of the two servers).
    - A **nested single-parity tier** that stores data in a single-parity tier that is itself mirrored between the two servers. This enables each server to store two copies of your data (each server stores one copy plus parity info to reconstruct a second copy). As with other mirror-accelerated parity volumes, once the mirror tier fills up to a certain point, less-frequently accessed data is written in the background to the parity tier for more efficient storage.<br><br>On the nested single parity tier, 10 GB of data takes 24 GB of capacity (12 GB on each of the two servers). <br><br>If you create a volume with 10% mirror and 90% parity, 100 GB of data would consume 256 GB (40 GB on the mirror tier; 216 GB on the parity tier), even though essentially four copies of the data are stored.

        ![](media\two-server-cluster-resilience\two-server-mirror-accelerated-parity.png)

- **Nested two-way mirror** volumes that store data exclusively in a two-way mirror that is itself mirrored between the two servers. Omitting the parity tier gives you an even higher level of performance.<br><br>On a nested two-way mirror volume, 10 GB of data takes 40 GB of capacity (20 GB on each of the two servers).

To use mirror-accelerated parity and nested two-way mirror volumes on a two-server cluster, see the following sections.

## Step 1: Creating storage tier templates

1. Open a PowerShell session with administrative credentials on one of the two servers in the cluster (or connected to one of them)
1. Type the following to create a storage tier template for nested two-way mirror and nested single-parity tiers:

    ```PowerShell
    New-StorageTier -FriendlyName NestedTwoWayMirror -StoragePoolFriendlyName S2D* -MediaType HDD -ResiliencySettingName Mirror -NumberOfDataCopies 4
    ```

1. Type the following to create a storage tier template for nested single-parity tiers:

    ```PowerShell
    New-StorageTier -FriendlyName NestedSingleParity -StoragePoolFriendlyName S2D* -MediaType HDD -ResiliencySettingName Parity -PhysicalDiskRedundancy 1 -NumberOfDataCopies 2 -FaultDomainAwareness StorageScaleUnit -ColumnIsolation PhysicalDisk
    ```
4. Type the following to display a list of the tier types--check to make sure the new types are listed:

    ```PowerShell
    Get-StorageTier
    ```

## Step 2: Set cache devices to become read-only after a server goes down

Two-server clusters keep one copy of data in solid-state cache devices on each server. This means that if a server goes down, fresh data is momentarily present in only a single cache device.

While solid-state cache devices tend to be pretty reliable, you can help protect against cache device failures while a server is offline by setting the cache devices to become read-only 30 minutes (by default) after a server goes down. When a cache device becomes read-only, the data is written to the capacity devices on the server that's still online. In this scenario, that means two copies of your fresh data would exist on the online server.

To set cache devices to become read-only after a server goes down, 

1. Open a PowerShell session with administrative credentials on one of the two servers in the cluster (or connected to one of them).
1. Type the following:

    ```PowerShell
    Get-StorageSubsystem clus* | Set-StorageHealthSetting -name "System.Storage.NestedResiliency.DisableWriteCacheOnNodeDown.Enabled" -value "True"
    ```

## Step 3: Creating volumes with the new resiliency types

To create a volume that has a nested two-way mirror and a nested single-parity tier, 

1. Open a PowerShell session with administrative credentials on one of the two servers in the cluster (or connected to one of them).
1. Type the following to create a volume, replacing \<NestedVolume> and \<10GB,90GB> with your own volume name and tier sizes:

    ```PowerShell
    New-Volume -FriendlyName <NestedVolume> -StorageTierFriendlyNames NestedTwoWayMirror,NestedSingleParity -StorageTierSizes <10GB,90GB>
    ```

3. Type the following commands to verify that the volume was created properly, replacing \<NestedVolume> with your own volume name:

    ```PowerShell
    Get-VirtualDisk
    Get-VirtualDisk <NestedVolume> | Get-StorageTier
    ```

    Here's an example of the output:

    ```
    FriendlyName              ResiliencySettingName FaultDomainRedundancy OperationalStatus HealthStatus    Size FootprintOnPool StorageEfficiency
    ------------              --------------------- --------------------- ----------------- ------------    ---- --------------- -----------------
    ClusterPerformanceHistory Mirror                1                     OK                Healthy        12 GB           26 GB            46.15%
    FirstVolume                                                           OK                Healthy      2.49 TB         7.96 TB            31.26%
 
    FriendlyName                   TierClass   MediaType ResiliencySettingName FaultDomainRedundancy   Size FootprintOnPool StorageEfficiency
    ------------                   ---------   --------- --------------------- ---------------------   ---- --------------- -----------------
    FirstVolume-NestedSingleParity Capacity    HDD       Parity                1                       2 TB            6 TB            33.33%
    FirstVolume-NestedTwoWayMirror Performance HDD       Mirror                3                     500 GB         1.95 TB            25.00%

    ```