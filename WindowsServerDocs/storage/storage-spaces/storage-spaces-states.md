---
title: Health states for Storage Spaces
description: How to understand the different health and operational states of Storage Spaces, and what to do about them.
keywords: Storage Spaces,detached,virtual disk,physical disk,degraded
author: jasongerend
ms.author: jgerend
ms.date: 1/12/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-spaces
manager: brianlic
---
# Health and operational states for Storage Spaces

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10, Windows 8.1

This topic discusses the health and operational states of various objects in Storage Spaces and [Storage Spaces Direct](storage-spaces-direct-overview.md), including volumes, virtual disks, storage pools, and physical disks. It also discusses why a physical disk can't be added to a pool (the CannotPoolReason).

## Storage pool states

A storage pool can be in one or more operational states. These states map to a health state - either **OK**, **Warning**, or **Unhealthy**.

The following sections list the operational states that map to each health state.

### Pool health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK|The storage pool is healthy.|

### Pool health state: Warning

When the storage pool is in the **Warning** health state, it means that the pool is accessible, but one or more physical disks failed or are missing. As a result, your storage pool might have reduced resilience.

|Operational state    |Description|
|---------            |---------          |
|Degraded|There are failed or missing physical disks in the storage pool. This condition only occurs with disks hosting pool metadata. <br><br>**Action**: Check the state of your physical disks and replace any failed disks before there are additional failures.|

### Pool health state: Error

When a storage pool is in the **Error** health state, it means that the storage pool is read-only and can't be modified until the pool is returned to the **Warning** or **OK** health states.

|Operational state    |Read-only reason |Description|
|---------            |---------       |--------   |
|Read-only|Incomplete|This can occur if the storage pool pool loses its quorum, which means that the majority of disks in the pool have failed or are offline for some reason. When a pool loses its quorum, Storage Spaces automatically sets the pool configuration to read-only until enough disks become available again.<br><br>**Action:** Reconnect any missing disks and then set the pool back to read-write by opening a PowerShell session with administrative permissions and then typing:<br><br> **Get-StoragePool <PoolName> &#124; Set-StoragePool -IsReadOnly $false**|
||Policy|An administrator set the storage pool to read-only.<br><br>**Action:** To set a storage pool to read-write access by using Windows PowerShell, open a PowerShell session with administrative permissions and then type:<br><br>**Get-StoragePool <PoolName> \| Set-StoragePool -IsReadOnly $false**|
||Starting|Storage Spaces is starting. This should be a temporary state. Once completely started, the pool should transition to a different operational state.|

## Virtual disk states

A virtual disk can be in one or more operational states. These states map to a health state - either **OK**, **Warning**, **Unhealthy**, or **Information**/**Unknown**.

The following sections list the operational states that map to each health state.

### Virtual disk health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK    |The virtual disk is healthy.|
|Suboptimal    |Data isn't written evenly across physical disks. <br><br>**Action**: Optimize drive usage in the storage pool by running the [Optimize-StoragePool](https://technet.microsoft.com/itpro/powershell/windows/storage/optimize-storagepool) cmdlet.|

### Virtual disk health state: Warning

When the virtual disk is in a **Warning** health state, it means that one or more copies of your data are unavailable, but Storage Spaces can still read at least one copy of your data.

|Operational state    |Description|
|---------            |---------          |
|In service            |Windows is repairing the virtual disk, such as after adding or removing a physical disk. When the repair is complete, the virtual disk should return to the OK health state.|
|Incomplete           |The resilience of the virtual disk is reduced because one or more physical disks failed or are missing. However, the missing physical disks contain up-to-date copies of your data.<br><br> **Action**: Reconnect any missing disks, and replace any failed disks. If you're not using Storage Spaces Direct, next repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. Storage Spaces Direct automatically starts a repair if needed after reconnecting or replacing a disk.|
|Degraded             |The resilience of the virtual disk is reduced because one or more physical disks failed or are missing, and there are outdated copies of your data on these physical disks. <br><br>**Action**: Reconnect any missing disks, and replace any failed disks. If you're not using Storage Spaces Direct, next repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. Storage Spaces Direct automatically starts a repair if needed after reconnecting or replacing a disk.|

### Virtual disk health state: Unhealthy

When a virtual disk is in an **Unhealthy** health state, some or all of the data on the virtual disk is currently inaccessible.

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached            |Majority Disks Unhealthy |Too many physical disks used by this virtual disk failed, are missing, or have stale data.   <br><br>**Action**: Reconnect any missing disks, and replace any failed disks. If you're not using Storage Spaces Direct, next repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. Storage Spaces Direct automatically starts a repair if needed after reconnecting or replacing a disk. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
|                     |Incomplete |Not enough physical disks are present to read the virtual disk.    <br><br>**Action**: Reconnect any missing physical disks and then repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. If you're using Windows Server 2016 you don't need to use Repair-VirtualDisk - reconnecting the disk automatically starts a repair if needed. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
| |Timeout|Attaching the virtual disk took too long <br><br> **Action:** This shouldn't happen often, so you might try see if the condition passes in time. Or you can try disconnecting the virtual disk with the [Disconnect-VirtualDisk](https://docs.microsoft.com/powershell/module/storage/disconnect-virtualdisk?view=win10-ps) cmdlet, then using the [Connect-VirtualDisk](https://docs.microsoft.com/powershell/module/storage/connect-virtualdisk?view=win10-ps)  cmdlet to reconnect it. |
|No redundancy||The virtual disk has lost data because too many physical disks failed.<br><br>**Action**: Replace failed physical disks and then restore your data from backup.|

### Virtual disk health state: Information/Unknown

The virtual disk can also be in the **Information** health state (as shown in the Storage Spaces Control Panel item) or **Unknown** health state (as shown in PowerShell) if an administrator took the virtual disk offline or the virtual disk has become detached.

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached             |By Policy            |An administrator took the virtual disk offline, or set the virtual disk to require manual attachment, in which case you'll have to manually attach the virtual disk every time Windows restarts.,<br><br>**Action**: Bring the virtual disk back online. To do so when the virtual disk is in a clustered storage pool, in Failover Cluster Manager select **Storage** > **Pools** > **Virtual Disks**, select the virtual disk that shows the **Offline** status and then select **Bring Online**. <br><br>To bring a virtual disk back online when not in a cluster, open a PowerShell session as an Administrator and then try using the following command:<br><br> **Get-VirtualDisk \| Where-Object -Filter { $_.OperationalStatus -eq "Detached" } \| Connect-VirtualDisk**<br><br>To automatically attach all non-clustered virtual disks after Windows restarts, open a PowerShell session as an Administrator and then use the following command:<br><br> **Get-VirtualDisk \| Set-VirtualDisk -ismanualattach $false**|

## Physical disk states

The following sections describe the health states a physical disk can be in.

### Disk health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK|The disk is healthy.|
|In service|The disk is performing some internal housekeeping operations. When the action is complete, the physical disk should return to the *OK* health state.|

### Disk health state: Warning

A physical disk in the Warning state can read and write data successfully but has an issue.

|Operational state    |Description|
|---------            |---------          |
|Removing from pool|Storage Spaces is in the process of removing the physical disk from its storage pool. <br><br> This is a temporary state. After the removal is complete, if the disk is still attached to the system, the disk transitions to another operational state (usually OK) in a primordial pool.|
|Starting maintenance mode|Storage Spaces is in the process of putting the disk in maintenance mode after an administrator put the disk in maintenance mode. This is a temporary state - the disk should soon be in the *In maintenance mode* state.|
|In maintenance mode|An administrator placed the disk in maintenance mode or is removing the disk from the pool, halting reads and writes from the disk. This is usually done before replacing a disk, or when testing failures.<br><br>**Action**: Remove and replace the disk, or take the disk out of maintenance mode by using the [Disable-StorageMaintenanceMode](https://technet.microsoft.com/itpro/powershell/windows/storage/disable-storagemaintenancemode) cmdlet.|
|Stopping maintenance mode|An administrator took the disk out of maintenance mode, and Storage Spaces is in the process of bringing the disk back online. This is a temporary state - the disk should soon be in another state - ideally *OK*.|
|Predictive failure|The disk reported that it's close to failing.<br><br>**Action**: Replace the disk.|
|IO error|There was a temporary error accessing the disk.<br><br>**Action**: If this keeps happening, replace the disk.|
|Transient error|There was a temporary error with the disk. This usually means the disk was unresponsive, but it could also mean that  the Storage Spaces protective partition was inappropriately removed from the disk. <br><br>**Action**: If the disk doesn't transition back to the **OK** state, you can try using the [Reset-PhysicalDisk](https://docs.microsoft.com/powershell/module/storage/reset-physicaldisk) cmdlet to wipe the disk. After you reset a physical disk, use [Repair-VirtualDisk](https://docs.microsoft.com/powershell/module/storage/repair-virtualdisk) to restore the resiliency of affected virtual disks. <br><br>If this keeps happening, replace the disk.|

### Disk health state: Unhealthy

A physical disk in the Unhealthy state can't currently be written to or accessed.

|Operational state    |Description|
|---------            |---------          |
|Not usable|This physical disk can't be used by Storage Spaces. For more info see [Storage Spaces Direct hardware requirements](storage-spaces-direct-hardware-requirements.md); if you're not using Storage Spaces Direct, see [Storage Spaces overview](https://technet.microsoft.com/library/hh831739(v=ws.11).aspx#Requirements).|
|Lost communication|The disk is missing.<br><br>**Action**: Reconnect the disk, or replace it.|
|Split|The disk has become separated from the pool.<br><br>**Action**: Reset the physical disk, erasing all data from the disk and adding it back to the pool as an empty disk. To do so, open a PowerShell session as an administrator, run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet, and then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Stale metadata|Storage Spaces found old metadata on the disk, which can be a sign of a failing disk.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the disk. To reset the disk, open a PowerShell session as an administrator, run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet, and then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Unrecognized metadata|Storage Spaces found unrecognized metadata on the disk, which can be a sign of a failing disk.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the disk. To reset the disk, open a PowerShell session as an administrator, run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet, and then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Failed media|The disk failed and won't be used by Storage Spaces anymore.<br><br>**Action**: Replace the disk.|
|Device hardware failure|There was a hardware failure on this disk. <br><br>**Action**: Replace the disk.|
|Updating firmware|Windows is updating the firmware on the physical disk. This is a temporary state that usually lasts less than a minute and during which time other disks in the pool handle all reads and writes. For more info, see [Update drive firmware](../update-firmware.md).|
|Starting|The disk is getting ready for operation. This should be a temporary state - once complete, the disk should transition to a different operational state.|

## Reasons a physical disk can't be pooled

Some physical disks just aren't ready to be in a storage pool. If you try to add one of these disks to a storage pool, Storage Spaces reports an error with the *CannotPoolReason*, which briefly describes why the disk can't be pooled. The following table gives a little more detail on each of the reasons.

|Reason|Description|
|---|---|
|In a pool|The physical disk already belongs to a storage pool. <br><br>Physical disks can belong to only a single storage pool at a time. To use this disk in another storage pool, first remove the physical disk from its existing pool, which tells Storage Spaces to move the data on the disk to other disks on the pool. Or reset the disk if the disk has been disconnected from its pool without notifying Storage Spaces. <br><br>To safely remove a physical disk from a storage pool, use [Remove-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/remove-physicaldisk), or go to Server Manager > **File and Storage Services** > **Storage Pools**, > **Physical Disks**, right-click the disk and then select **Remove Disk**.<br><br>To reset a physical disk, use [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk).|
|Not healthy|The physical disk isn't in a healthy state and might need to be replaced.|
|Removable media|The physical disk is classified as a removable disk. <br><br>Storage Spaces doesn't support media that are recognized by Windows as removable, such as Blu-Ray drives. Although many fixed disks are in removable slots, in general, media that are *classified* by Windows as removable aren't suitable for use with Storage Spaces.|
|In use by cluster|The physical disk is currently used by a Failover Cluster.|
|Offline|The physical disk is offline. <br><br>To bring all offline disks online and set to read/write, open a PowerShell session as an administrator and use the following scripts:<br><br>**Get-Disk \| Where-Object -Property OperationalStatus -EQ "Offline" \| Set-Disk -IsOffline $false**<br><br>**Get-Disk \| Where-Object -Property IsReadOnly -EQ $true \| Set-Disk -IsReadOnly $false**|
|Insufficient capacity|This typically occurs when there are partitions taking up the free space on the disk. <br><br>**Action**: Delete any volumes on the disk, erasing all data on the disk. One way to do that is to use the [Clear-Disk](https://docs.microsoft.com/powershell/module/storage/clear-disk?view=win10-ps) PowerShell cmdlet.|
|Verification in progress|The [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document) is checking to see if the disk or firmware on the disk is approved for use by the server administrator.|
|Verification failed|The [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document) couldn't check to see if the disk or firmware on the disk is approved for use by the server administrator.|
|Firmware not compliant|The firmware on the physical disk isn't in the list of approved firmware revisions specified by the server administrator by using the [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document). |
|Hardware not compliant|The physical disk isn't in the list of approved storage models specified by the server administrator by using the [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document).|

## See also

- [Storage Spaces Direct](storage-spaces-direct-overview.md)
- [Storage Spaces Direct hardware requirements](storage-spaces-direct-hardware-requirements.md)
