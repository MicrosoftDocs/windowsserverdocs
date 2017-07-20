---
title: Health states for Storage Spaces
description: How to understand the different health and operational states of Storage Spaces, and what to do about them.
keywords: Storage Spaces, detached, virtual disk, physical disk, storage pool, degraded
author: jasongerend
ms.author: jgerend
ms.date: 07/20/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-spaces
manager: brianlic
---
# Health and operational states for Storage Spaces

> Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10, Windows 8.1

This topic discusses the health and operational states of various objects in Storage Spaces and [Storage Spaces Direct](storage-spaces-direct-overview.md), including volumes, virtual disks, storage pools, and physical disks. It also discusses why a physical disk can't be added to a pool (the CannotPoolReason).

## Storage pool states

A storage pool can be in one or more operational states. These states map to a health state - either **OK**, **Warning**, or **Unhealthy**.

The following sections list the operational states that map to each health state.

### Pool health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK|The storage pool is OK.|

### Pool health state: Warning

When the storage pool is in the **Warning** health state, it means that the pool is accessible, but one or more physical disks failed or are missing. As a result, your virtual disks might have reduced resilience.

|Operational state    |Description|
|---------            |---------          |
|Degraded|There are failed or missing physical disks in the storage pool. <br><br>**Action**: Check the state of your physical disks and replace any failed disks.|

### Pool health state: Error

When a storage pool is in the **Error** health state, it means that the storage pool is read-only and can't be modified until the pool is returned to the **Warning** or **OK** health states.

|Operational state    |Read-only reason |Description|
|---------            |---------       |--------   |
|Read-only|Incomplete|This can occur if the storage pool pool loses its quorum, which means that the majority of disks in the pool have failed or are offline for some reason. When a pool loses its quorum, Storage Spaces automatically sets the pool configuration to read-only until enough disks become available again.<br><br>**Action:** Reconnect any missing disks and then set the pool back to read-write by opening a PowerShell session with administrative permissions and then typing `Get-StoragePool <PoolName> | Set-StoragePool -IsReadOnly $false`|
||Policy|An administrator set the storage pool to read-only.<br><br>**Action:** To set a storage pool to read-write access by using Windows PowerShell, open a PowerShell session with administrative permissions and then type `Get-StoragePool <PoolName> | Set-StoragePool -IsReadOnly $false`|
||Starting|Storage Spaces is starting. This should be a temporary state. Once completely started, the pool should transition to a different operational state.|

## Virtual disk states

A virtual disk can be in one or more operational states. These states map to a health state - either **OK**, **Warning**, **Unhealthy**, or **Information**/**Unknown**.

The following sections list the operational states that map to each health state.

### Virtual disk health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK    |The virtual disk is OK.|
|Suboptimal    |Data isn't written evenly across physical disks. <br><br>**Action**: Optimize drive usage in the storage pool by running the [Optimize-StoragePool](https://technet.microsoft.com/itpro/powershell/windows/storage/optimize-storagepool) cmdlet.|

### Virtual disk health state: Warning

When the virtual disk is in a **Warning** health state, it means that one or more copies of your data are unavailable, but Storage Spaces can still read at least one copy of your data.

|Operational state    |Description|
|---------            |---------          |
|In service            |Windows is repairing the virtual disk, such as after adding or removing a physical disk. When the repair is complete, the virtual disk should return to the OK health state.|
|Incomplete           |The resilience of the virtual disk is reduced because one or more physical disks failed or are missing. However, the missing physical disks contain up-to-date copies of your data.<br><br> **Action**: Reconnect any missing disks, replace any failed disks, and then repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet after reconnecting disks. If you're using Windows Server 2016 you don't need to use Repair-VirtualDisk - reconnecting or replacing the disk automatically starts a repair.|
|Degraded             |The resilience of the virtual disk is reduced because one or more physical disks failed or are missing, and there are outdated copies of your data on these physical disks. <br><br>**Action**: Reconnect any missing disks, replace any failed disks, and then repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet after reconnecting disks. If you're using Windows Server 2016 you don't need to use Repair-VirtualDisk - reconnecting or replacing the disk automatically starts a repair.|

### Virtual disk health state: Unhealthy

When a virtual disk is in an **Unhealthy** health state, some or all of the data on the virtual disk is currently inaccessible.

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached            |Majority Disks Unhealthy |Too many physical disks used by this virtual disk failed, are missing, or have stale data.   <br><br>**Action**: Reconnect any missing physical disks and replace any failed disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks (Windows Server 2016 and newer do this automatically). <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
|                     |Incomplete |Not enough physical disks are present to read the virtual disk.    <br><br>**Action**: Reconnect any missing physical disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks (Windows Server 2016 and newer do this automatically). <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
| |Timeout|Contacting the virtual disk timed out. <br><br> **Action:** **TO DO: Need more info here**   |
|                     |None |**BLOCKED: Need more info here**       <br>**Action**: |
|No redundancy||The virtual disk has lost data because too many physical disks failed.<br><br>**Action**: Replace failed physical disks and then restore your data from backup.|

### Virtual disk health state: Information/Unknown

The virtual disk can also be in the **Information** health state (as shown in the Storage Spaces Control Panel item) or **Unknown** health state (as shown in PowerShell) if an administrator took the virtual disk offline or the virtual disk has become detached.

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached             |By Policy            |An administrator took the virtual disk offline, or set the virtual disk to require manual attachment, in which case you'll have to manually attach the virtual disk every time Windows restarts.**Action**: Bring the virtual disk back online. To do so when the virtual disk is in a clustered storage pool, in Failover Cluster Manager select **Storage** > **Pools** > **Virtual Disks**, select the virtual disk that shows the **Offline** status and then select **Bring Online**. <br><br>To bring a virtual disk back online when not in a cluster, you can try opening a PowerShell session as an Administrator and then using the following command:<br> `Get-VirtualDisk | Where-Object -Filter { $_.OperationalStatus -eq "Detached" } | Connect-VirtualDisk`<br><br>To automatically attach all current virtual disks after Windows restarts, which is only relevant to non-clustered virtual disks, open a PowerShell session as an Administrator and then use the following command:<br> `Get-VirtualDisk | Set-VirtualDisk -ismanualattach $true`|

## Physical disk states

The following sections describe the health states a physical disk can be in, as well as the reasons a physical disk can't be added to a storage pool

### Disk health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK|The disk is OK.|

### Disk health state: Warning

|Operational state    |Description|
|---------            |---------          |
|Error|**BLOCKED: I'm guessing - is this accurate?** There was a temporary error with the disk.<br><br>**Action**: Consider replacing the disk.|
|In service|**BLOCKED:What is this?**|
|Predictive failure|The disk reported that it's close to failing.<br><br>**Action**: Replace the disk.|
|IO error|There was a temporary error accessing the disk.<br><br>**Action**: If this keeps happening, replace the disk.|
|Degraded|**BLOCKED:What is this?**|
|Stressed|**BLOCKED:What is this?**|
|Dormant|**BLOCKED:Is this retired?**|
|PowerMode|**BLOCKED:What is this?**|

### Disk health state: Unhealthy

|Operational state    |Description|
|---------            |---------          |
|Starting|The disk is getting ready for operation. This should be a temporary state - once complete, the disk should transition to a different operational state.|
|Lost communication|The disk is missing.<br><br>**Action**: Reconnect the disk, or replace it.|
|Stale metadata|Storage Spaces found old metadata on the disk, which can be a sign of a failing disk.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the disk.|
|Split|The disk has become separated from the pool.<br><br>**Action**: Reset the physical disk, erasing all data from the disk and adding it back to the pool as an empty disk. To do so, open a PowerShell session as an administrator, then run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet. Then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Failed media|The disk failed.<br><br>**Action**: Replace the disk.|
|Unrecognized metadata|Storage Spaces found unrecognized metadata on the disk, which can be a sign of a failing disk.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the disk.|
|Maintenance mode|An administrator placed the disk in maintenance mode, halting reads and writes from the disk. This is usually done before replacing a disk, or when testing failures.<br><br>**Action**: Remove and replace the disk, or take the disk out of maintenance mode, if you were just testing the pool.|

## Reasons a physical disk can't be pooled (CannotPoolReason)

|Reason|Description|
|---|---|
|In a pool|The physical disk already belongs to a storage pool. <br><br>Physical disks can belong to only a single storage pool at a time. To use this disk in another storage pool, first remove the physical disk from its existing pool, which tells Storage Spaces to move the data on the disk to other disks on the pool. Or reset the disk if the disk has been disconnected from its pool without notifying Storage Spaces. <br><br>To safely remove a physical disk from a storage pool, use [Remove-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/remove-physicaldisk), or go to Server Manager > **File and Storage Services** > **Storage Pools**, > **Physical Disks**, right-click the disk and then select **Remove Disk**.<br><br>To reset a physical disk, use [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk).|
|


<!---Future TO DO: Include a graphic showing the interaction of the different states.--->
