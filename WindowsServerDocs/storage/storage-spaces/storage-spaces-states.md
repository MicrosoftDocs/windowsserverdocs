---
title: Health states for Storage Spaces
description: How to understand the different health and operational states of Storage Spaces, and what to do about them.
keywords: Storage Spaces,detached,virtual disk,physical disk,degraded
author: jasongerend
ms.author: jgerend
ms.date: 1/18/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-spaces
manager: brianlic
---
# Health and operational states for Storage Spaces and pools

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10, Windows 8.1

This topic describes the health and operational states of storage pools, virtual disks (which sit underneath volumes in Storage Spaces), and drives in Storage Spaces and [Storage Spaces Direct](storage-spaces-direct-overview.md). It also discusses why a drive can't be added to a pool (the CannotPoolReason).

## Storage pool states

Every storage pool has a health status - <span style="color:green">**Healthy**</span>, <span style="color:yellow">**Warning**</span>, or <span style="color:red">**Unhealthy**</span>, as well as one or more operational states.

To find out what state a pool is in, use the following PowerShell commands:

```PowerShell
Get-StoragePool -IsPrimordial $False | Select-Object HealthStatus, OperationalStatus, ReadOnlyReason
```

Here's a typical output:

```
HealthStatus OperationalStatus ReadOnlyReason
------------ ----------------- --------------
Healthy      OK                None
```

The following sections list the health and operational states.

### Pool health state: <span style="color:green">Healthy</span>

|Operational state    |Description|
|---------            |---------          |
|OK|The storage pool is healthy.|

### Pool health state: <span style="color:yellow">Warning</span>

When the storage pool is in the **Warning** health state, it means that the pool is accessible, but one or more drives failed or are missing. As a result, your storage pool might have reduced resilience.

|Operational state    |Description|
|---------            |---------          |
|Degraded|There are failed or missing drives in the storage pool. This condition only occurs with drives hosting pool metadata. <br><br>**Action**: Check the state of your drives and replace any failed drives before there are additional failures.|

### Pool health state: <span style="color:red">Unhealthy</span>

When a storage pool is in the **Unhealthy** health state, it means that the storage pool is read-only and can't be modified until the pool is returned to the **Warning** or **OK** health states.

|Operational state    |Read-only reason |Description|
|---------            |---------       |--------   |
|Read-only|Incomplete|This can occur if the storage pool pool loses its quorum, which means that the majority of drives in the pool have failed or are offline for some reason. When a pool loses its quorum, Storage Spaces automatically sets the pool configuration to read-only until enough drives become available again.<br><br>**Action:** Reconnect any missing drives, and if you're using Storage Spaces Direct, bring all servers online. Then set the pool back to read-write by opening a PowerShell session with administrative permissions and then typing:<br><br> `Get-StoragePool <PoolName> &#124; Set-StoragePool -IsReadOnly $false`|
||Policy|An administrator set the storage pool to read-only.<br><br>**Action:** To set a storage pool to read-write access by using Windows PowerShell, open a PowerShell session with administrative permissions and then type:<br><br>`Get-StoragePool <PoolName> \| Set-StoragePool -IsReadOnly $false`|
||Starting|Storage Spaces is starting. This should be a temporary state. Once completely started, the pool should transition to a different operational state.|

## Virtual disk states

In Storage Spaces, volumes are placed on virtual disks (storage spaces) that are carved out of free space in a pool. Every virtual disk has a health status - <span style="color:green">**Healthy**</span>, <span style="color:yellow">**Warning**</span>, or <span style="color:red">**Unhealthy**</span>, as well as one or more operational states.

To find out what state virtual disks are in, use the following PowerShell commands:

```PowerShell
Get-VirtualDisk | Select-Object HealthStatus, OperationalStatus, DetachedReason
```

Here's a typical output:

```
HealthStatus OperationalStatus      DetachedReason
------------ -----------------      --------------
Warning      {Degraded, Incomplete} None          
Warning      {Degraded, Incomplete} None          
```

The following sections list the health and operational states.

### Virtual disk health state: Healthy

|Operational state    |Description|
|---------            |---------          |
|OK    |The virtual disk is healthy.|
|Suboptimal    |Data isn't written evenly across drives. <br><br>**Action**: Optimize drive usage in the storage pool by running the [Optimize-StoragePool](https://technet.microsoft.com/itpro/powershell/windows/storage/optimize-storagepool) cmdlet.|

### Virtual disk health state: Warning

When the virtual disk is in a **Warning** health state, it means that one or more copies of your data are unavailable, but Storage Spaces can still read at least one copy of your data.

|Operational state    |Description|
|---------            |---------          |
|In service            |Windows is repairing the virtual disk, such as after adding or removing a drive. When the repair is complete, the virtual disk should return to the OK health state.|
|Incomplete           |The resilience of the virtual disk is reduced because one or more drives failed or are missing. However, the missing drives contain up-to-date copies of your data.<br><br> **Action**: Reconnect any missing drives, replace any failed drives, and if you're using Storage Spaces Direct, bring online any servers that are offline. If you're not using Storage Spaces Direct, next repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. Storage Spaces Direct automatically starts a repair if needed after reconnecting or replacing a drive.|
|Degraded             |The resilience of the virtual disk is reduced because one or more drives failed or are missing, and there are outdated copies of your data on these drives. <br><br>**Action**: Reconnect any missing drives, replace any failed drives, and if you're using Storage Spaces Direct, bring online any servers that are offline. If you're not using Storage Spaces Direct, next repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. Storage Spaces Direct automatically starts a repair if needed after reconnecting or replacing a drive.|

### Virtual disk health state: Unhealthy

When a virtual disk is in an **Unhealthy** health state, some or all of the data on the virtual disk is currently inaccessible.

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached            |Majority Disks Unhealthy |Too many drives used by this virtual disk failed, are missing, or have stale data.   <br><br>**Action**: Reconnect any missing drives, replace any failed drives, and if you're using Storage Spaces Direct, bring online any servers that are offline. If you're not using Storage Spaces Direct, next repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. Storage Spaces Direct automatically starts a repair if needed after reconnecting or replacing a drive. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
|                     |Incomplete |Not enough drives are present to read the virtual disk.    <br><br>**Action**: Reconnect any missing drives, and if you're using Storage Spaces Direct, bring online any servers that are offline. Then repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) cmdlet. If you're using Windows Server 2016 you don't need to use Repair-VirtualDisk - reconnecting the drive automatically starts a repair if needed. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
| |Timeout|Attaching the virtual disk took too long <br><br> **Action:** This shouldn't happen often, so you might try see if the condition passes in time. Or you can try disconnecting the virtual disk with the [Disconnect-VirtualDisk](https://docs.microsoft.com/powershell/module/storage/disconnect-virtualdisk?view=win10-ps) cmdlet, then using the [Connect-VirtualDisk](https://docs.microsoft.com/powershell/module/storage/connect-virtualdisk?view=win10-ps)  cmdlet to reconnect it. |
|No redundancy||The virtual disk has lost data because too many drives failed.<br><br>**Action**: Replace failed drives and then restore your data from backup.|

### Virtual disk health state: Information/Unknown

The virtual disk can also be in the **Information** health state (as shown in the Storage Spaces Control Panel item) or **Unknown** health state (as shown in PowerShell) if an administrator took the virtual disk offline or the virtual disk has become detached.

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached             |By Policy            |An administrator took the virtual disk offline, or set the virtual disk to require manual attachment, in which case you'll have to manually attach the virtual disk every time Windows restarts.,<br><br>**Action**: Bring the virtual disk back online. To do so when the virtual disk is in a clustered storage pool, in Failover Cluster Manager select **Storage** > **Pools** > **Virtual Disks**, select the virtual disk that shows the **Offline** status and then select **Bring Online**. <br><br>To bring a virtual disk back online when not in a cluster, open a PowerShell session as an Administrator and then try using the following command:<br><br> `Get-VirtualDisk \| Where-Object -Filter { $_.OperationalStatus -eq "Detached" } \| Connect-VirtualDisk`<br><br>To automatically attach all non-clustered virtual disks after Windows restarts, open a PowerShell session as an Administrator and then use the following command:<br><br> `Get-VirtualDisk \| Set-VirtualDisk -ismanualattach $false`|

## Drive (physical disk) states

The following sections describe the health states a drive can be in. Drives in a pool are represented in PowerShell as *physical disk* objects.

### Drive health state: Healthy

|Operational state    |Description|
|---------            |---------          |
|OK|The drive is healthy.|
|In service|The drive is performing some internal housekeeping operations. When the action is complete, the drive should return to the *OK* health state.|

### Drive health state: Warning

A drive in the Warning state can read and write data successfully but has an issue.

|Operational state    |Description|
|---------            |---------          |
|Removing from pool|Storage Spaces is in the process of removing the drive from its storage pool. <br><br> This is a temporary state. After the removal is complete, if the drive is still attached to the system, the drive transitions to another operational state (usually OK) in a primordial pool.|
|Starting maintenance mode|Storage Spaces is in the process of putting the drive in maintenance mode after an administrator put the drive in maintenance mode. This is a temporary state - the drive should soon be in the *In maintenance mode* state.|
|In maintenance mode|An administrator placed the drive in maintenance mode, halting reads and writes from the drive. This is usually done before updating drive firmware, or when testing failures.<br><br>**Action**: To take the drive out of maintenance mode, use the [Disable-StorageMaintenanceMode](https://technet.microsoft.com/itpro/powershell/windows/storage/disable-storagemaintenancemode) cmdlet.|
|Stopping maintenance mode|An administrator took the drive out of maintenance mode, and Storage Spaces is in the process of bringing the drive back online. This is a temporary state - the drive should soon be in another state - ideally *Healthy*.|
|Predictive failure|The drive reported that it's close to failing.<br><br>**Action**: Replace the drive.|
|IO error|There was a temporary error accessing the drive.<br><br>**Action**: If this keeps happening, replace the drive.|
|Transient error|There was a temporary error with the drive. This usually means the drive was unresponsive, but it could also mean that  the Storage Spaces protective partition was inappropriately removed from the drive. <br><br>**Action**: If the drive doesn't transition back to the **OK** state, you can try using the [Reset-PhysicalDisk](https://docs.microsoft.com/powershell/module/storage/reset-physicaldisk) cmdlet to wipe the drive. After you reset a drive, use [Repair-VirtualDisk](https://docs.microsoft.com/powershell/module/storage/repair-virtualdisk) to restore the resiliency of affected virtual disks. <br><br>If this keeps happening, replace the drive.|

### Drive health state: Unhealthy

A drive in the Unhealthy state can't currently be written to or accessed.

|Operational state    |Description|
|---------            |---------          |
|Not usable|This drive can't be used by Storage Spaces. For more info see [Storage Spaces Direct hardware requirements](storage-spaces-direct-hardware-requirements.md); if you're not using Storage Spaces Direct, see [Storage Spaces overview](https://technet.microsoft.com/library/hh831739(v=ws.11).aspx#Requirements).|
|Lost communication|The drive is missing. If you're using Storage Spaces Direct, this could be because a server is down.<br><br>**Action**: If you're using Storage Spaces Direct, bring all servers back online. If that doesn't fix it, reconnect the drive or replace it.|
|Split|The drive has become separated from the pool.<br><br>**Action**: Reset the drive, erasing all data from the drive and adding it back to the pool as an empty drive. To do so, open a PowerShell session as an administrator, run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet, and then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Stale metadata|Storage Spaces found old metadata on the drive, which can be a sign of a failing drive.<br><br>**Action**: You can reset the drive and see if this happens again, or you can proactively replace the drive. To reset the drive, open a PowerShell session as an administrator, run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet, and then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Unrecognized metadata|Storage Spaces found unrecognized metadata on the drive, which can be a sign of a failing drive.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the drive. To reset the drive, open a PowerShell session as an administrator, run the [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk) cmdlet, and then run [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk).|
|Failed media|The drive failed and won't be used by Storage Spaces anymore.<br><br>**Action**: Replace the drive.|
|Device hardware failure|There was a hardware failure on this drive. <br><br>**Action**: Replace the drive.|
|Updating firmware|Windows is updating the firmware on the drive. This is a temporary state that usually lasts less than a minute and during which time other drives in the pool handle all reads and writes. For more info, see [Update drive firmware](../update-firmware.md).|
|Starting|The drive is getting ready for operation. This should be a temporary state - once complete, the drive should transition to a different operational state.|

## Reasons a drive can't be pooled

Some drives just aren't ready to be in a storage pool. If you try to add one of these drives to a storage pool, Storage Spaces reports an error with the *CannotPoolReason*, which briefly describes why the drive can't be pooled. The following table gives a little more detail on each of the reasons.

|Reason|Description|
|---|---|
|In a pool|The drive already belongs to a storage pool. <br><br>Drives can belong to only a single storage pool at a time. To use this drive in another storage pool, first remove the drive from its existing pool, which tells Storage Spaces to move the data on the drive to other drives on the pool. Or reset the drive if the drive has been disconnected from its pool without notifying Storage Spaces. <br><br>To safely remove a drive from a storage pool, use [Remove-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/remove-physicaldisk), or go to Server Manager > **File and Storage Services** > **Storage Pools**, > **Physical Disks**, right-click the drive and then select **Remove Disk**.<br><br>To reset a drive, use [Reset-PhysicalDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/reset-physicaldisk).|
|Not healthy|The drive isn't in a healthy state and might need to be replaced.|
|Removable media|The drive is classified as a removable drive. <br><br>Storage Spaces doesn't support media that are recognized by Windows as removable, such as Blu-Ray drives. Although many fixed drives are in removable slots, in general, media that are *classified* by Windows as removable aren't suitable for use with Storage Spaces.|
|In use by cluster|The drive is currently used by a Failover Cluster.|
|Offline|The drive is offline. <br><br>To bring all offline drives online and set to read/write, open a PowerShell session as an administrator and use the following scripts:<br><br>`Get-Disk \| Where-Object -Property OperationalStatus -EQ "Offline" \| Set-Disk -IsOffline $false`<br><br>`Get-Disk \| Where-Object -Property IsReadOnly -EQ $true \| Set-Disk -IsReadOnly $false`|
|Insufficient capacity|This typically occurs when there are partitions taking up the free space on the drive. <br><br>**Action**: Delete any volumes on the drive, erasing all data on the drive. One way to do that is to use the [Clear-Disk](https://docs.microsoft.com/powershell/module/storage/clear-disk?view=win10-ps) PowerShell cmdlet.|
|Verification in progress|The [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document) is checking to see if the drive or firmware on the drive is approved for use by the server administrator.|
|Verification failed|The [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document) couldn't check to see if the drive or firmware on the drive is approved for use by the server administrator.|
|Firmware not compliant|The firmware on the physical drive isn't in the list of approved firmware revisions specified by the server administrator by using the [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document). |
|Hardware not compliant|The drive isn't in the list of approved storage models specified by the server administrator by using the [Health Service](https://docs.microsoft.com/windows-server/failover-clustering/health-service-overview#supported-components-document).|

## See also

- [Storage Spaces Direct](storage-spaces-direct-overview.md)
- [Storage Spaces Direct hardware requirements](storage-spaces-direct-hardware-requirements.md)
