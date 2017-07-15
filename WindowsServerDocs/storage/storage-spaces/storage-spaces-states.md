---
title: Health states for virtual disks and other Storage Spaces objects 
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
# Health and operational states for virtual disks and other Storage Spaces objects

> Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic discusses the health and operational states of various objects in Storage Spaces and [Storage Spaces Direct](storage-spaces-direct-overview.md), including volumes, virtual disks, storage pools, and physical disks.


## Virtual disk health and operational states

A virtual disk can be in one or more operational states. These states map to a health state - either **OK**, **Warning**, **Unhealthy**, or **Unknown**. 

The following sections list the operational states that map to each health state.

### Virtual disk health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK    |The virtual disk is OK.|
|Suboptimal    |Data isn't written evenly across physical disks. <br><br>**Action**: Optimize drive usage in the storage pool by running the Optimize-StoragePool cmdlet.|
|Max?    |**TO DO: Need more info here**     |

### Virtual disk health state: Warning

|Operational state    |Description|
|---------            |---------          |
|Degraded             |One or more physical disks failed, reducing the resilience of the virtual disk. <br><br>**Action**: Check the state of your physical disks and replace any failed disks.|
|Incomplete           |One or more physical disks are missing, reducing the resiliency of the virtual disk. <br><br> **Action**: Reconnect any missing disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks.|
|InService            |Windows is repairing the virtual disk - no action is required.|

### Virtual disk health state: Unhealthy

|Operational state    |Detached reason |Description|
|---------            |---------       |--------   |
|Detached             |By Policy            |An administrator has taken the virtual disk offline. <br><br>**Action**: If this virtual disk is in a clustered storage pool, in Failover Cluster Manager select **Storage** > **Pools** > **Virtual Disks**, select the virtual disk that shows the **Offline** status and then select **Bring Online**. <br><br>If not in a cluster, you can try opening a PowerShell session as an Administrator and then using the following command:<br> `Get-VirtualDisk | Where-Object -Filter { $_.OperationalStatus -eq "Detached" } | Connect-VirtualDisk`|
|            |Majority Disks Unhealthy |Too many physical disks used by this virtual disk failed, are missing, or have stale data.   <br><br>**Action**: Reconnect any missing physical disks and replace any failed disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
|                     |Incomplete |Not enough physical disks are present to read the virtual disk.    <br><br>**Action**: Reconnect any missing physical disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
| |Timeout|Contacting the virtual disk timed out. <br><br> **Action:** **TO DO: Need more info here**   |
||Max|**BLOCKED: Need more info here**   |
|                     |None |**BLOCKED: Need more info here**       <br>**Action**: |
|                     |Unknown | Storage Spaces couldn't determine why the virtual disk is detached.    <br><br>**Action**:**BLOCKED: Need more info here**   |

### Virtual disk health state: Unknown
|Operational state    |Description|
|---------            |--------   |
|Unknown|Storage Spaces couldn't determine the state.<br><br>**Action**: **BLOCKED: Need more info here**   |

## Physical disk health and operational states

### Disk health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK|The disk is OK.|

### Disk health state: Warning

|Operational state    |Description|
|---------            |---------          |
|Error|**BLOCKED: I'm guessing - is this accurate?** There was a temporary error with the disk.<br><br>**Action**: Replace the disk. |
|In service||
|Predictive failure|The disk reported that it's close to failing.<br><br>**Action**: Replace the disk.|
|IO error|There was a temporary error accessing the disk.<br><br>**Action**: If this keeps happening, replace the disk.|
|Degraded|**BLOCKED:What is this?**|
|Stressed|**BLOCKED:What is this?**|
|Dormant|**BLOCKED:Is this retired?**|
|PowerMode|**BLOCKED:What is this?**|

### Disk health state: Unhealthy

|Operational state    |Description|
|---------            |---------          |
|Non-recoverable error|There was an unrecoverable error with the disk.<br><br>**Action**: Replace the disk.|
|Starting|The disk is getting ready for operation. This should be a temporary state - once complete, the disk should transition to a different operational state.|
|Stopping|The disk is stopping. This should be a temporary state - once complete, the disk should transition to a different operational state.|
|No contact|**BLOCKED:What is this? How is this different from Lost Communication?**|
|Lost communication|The disk is missing.<br><br>**Action**: Reconnect the disk, or replace it.|
|Stale metadata|Storage Spaces found old metadata on the disk, which can be a sign of a failing disk.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the disk.|
|Split|The disk has become separated from the pool.<br><br>**Action**: Reset the physical disk, wiping the disk and adding it back to the pool as an empty disk.|
|Failed media|The disk failed.<br><br>**Action**: Replace the disk.|
|Unrecognized metadata|Storage Spaces found unrecognized metadata on the disk, which can be a sign of a failing disk.<br><br>**Action**: You can reset the disk and see if this happens again, or you can proactively replace the disk.|
|Maintenance mode|An administrator placed the disk in maintenance mode, halting reads and writes from the disk. This is usually done before replacing a disk, or when testing failures.<br><br>**Action**: Remove and replace the disk, or take the disk out of maintenance mode, if you were just testing the pool.|

### Disk health state: Information

|Operational state    |Description|
|---------            |---------          |
|Unknown|Storage Spaces couldn't determine the state.<br><br>**Action**: **BLOCKED: Need more info here - try disconnecting the disk and reconnecting it? If it doesn't resolve, replace the disk?**   |

## Storage pool health and operational states

### Pool health state: OK

|Operational state    |Description|
|---------            |---------          |
|OK|The storage pool is OK.|

### Pool health state: Warning

|Operational state    |Description|
|---------            |---------          |
|Degraded|There are failed or missing physical disks in the storage pool. <br><br>**Action**: Check the state of your physical disks and replace any failed disks.|

### Pool health state: Error

|Operational state    |Read-only reason |Description|
|---------            |---------       |--------   |
|Read-only|Incomplete|This can occur if the storage pool pool loses its quorum, which means that the majority of disks in the pool have failed or are offline for some reason. When a pool loses its quorum, Storage Spaces automatically sets the pool configuration to read-only until enough disks become available again.<br><br>**Action:** Reconnect any missing disks.|
||Policy|An administrator set the storage pool to read-only.<br><br>**Action:** To set a storage pool to read-write access by using Windows PowerShell, open a PowerShell session with administrative permissions and then type `Get-StoragePool <PoolName> | Set-StoragePool -IsReadOnly $false`|
||Starting|Storage Spaces is starting. This should be a temporary state - once Storage Spaces starts the pool should transition to a different operational state.|
|Max||The storage pool is out of free space. <br><br>**Action:** Add physical disks.|

### Pool health state: Information

|Operational state    |Description|
|---------            |---------          |
|Unknown|Storage Spaces couldn't determine the state.|

**Future TO DO: Include a graphic showing the interaction of the different states.**
