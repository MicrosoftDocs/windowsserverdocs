---
title: Health states for virtual disks and other Storage Spaces objects 
description: 115-145 characters including spaces. Edit the intro para describing article intent to fit here. This abstract displays in the search result.
keywords: Don’t add or edit keywords without consulting your SEO champ.
author: jasongerend
ms.author: jgerend
ms.date: 06/09/2017
ms.topic: article-type-from-white-list
ms.prod: windows-server-threshold
ms.technology: storage-spaces
ms.assetid: 72db1242-a416-48d0-a270-60b63004fe92
manager: brianlic
---
# Health and operational states for virtual disks and other Storage Spaces objects

> Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic discusses the health and operational states of various objects in Storage Spaces and [Storage Spaces Direct](storage-spaces-direct-overview.md), including volumes, virtual disks, storage pools, and physical disks.

Include a graphic showing the interaction of the different states.

## Virtual disk health and operational states

|Health state|Operational state|Description|
|---------|---------|---|
|OK    |OK    |The virtual disk is OK.|
|    |Suboptimal    |Data isn't written evenly across physical disks. <br>**Action**: Optimize drive usage in the storage pool by running the Optimize-StoragePool cmdlet.|
|    |Max?    |?    |
|Warning    |Degraded    |One or more physical disks have failed, reducing the resilience of the virtual disk. <br>**Action**: Check the state of your physical disks and replace any failed disks.|
|    |Incomplete    |One or more physical disks are missing. <br> **Action**: Reconnect any missing disks.|
|    |InService    |Windows is repairing the virtual disk - no action is required.|
|Unhealthy |Detached|The virtual disk is in a detached state and can't be read by Windows. <br>**Action**: Reconnect any missing physical disks, and then attach the virtual disk using [Connect-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/connect-virtualdisk).|
|    |Unknown||
|Unknown|    ||

### OK health state

|Operational state    |Description|
|---------            |---------          |
|OK    |The virtual disk is OK.|
|Suboptimal    |Data isn't written evenly across physical disks. <br>**Action**: Optimize drive usage in the storage pool by running the Optimize-StoragePool cmdlet.|
|Max?    |?    |

### Warning health state

|Operational state    |Detached reason    |Description |
|---------            |---------          |-----       |
|Degraded             | | <br>**Action**: 
|Incomplete           |                    |One or more physical disks are missing, and the virtual disk has reduced resiliency. <br> **Action**: Reconnect any missing disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks.|
|InService            |                    |Windows is repairing the virtual disk - no action is required.|



### Unhealthy health state

|Operational state    |Description|
|---------            |---------          |
|Unhealthy |Detached|The virtual disk is in a detached state and can't be read by Windows. <br>**Action**: Reconnect any missing physical disks, and then attach the virtual disk using [Connect-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/connect-virtualdisk).|
|Detached             |Majority Disks Unhealthy |Too many physical disks used by this virtual disk failed, are missing, or have stale data.   <br>**Action**: Reconnect any missing physical disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
|             |By Policy    | One or more physical disks have failed, reducing the resilience of the virtual disk. <br>**Action**: Check the state of your physical disks and replace any failed disks.|
|                     |Majority Disks Unhealthy |Too many physical disks used by this virtual disk failed, are missing, or have stale data.   <br>**Action**: Reconnect any missing physical disks. If you're using Windows Server 2012 R2 or Windows Server 2012, repair the virtual disk using the [Repair-VirtualDisk](https://technet.microsoft.com/itpro/powershell/windows/storage/repair-virtualdisk) after reconnecting disks. <br>If more disks failed than you have copies of your data and the virtual disk wasn't repaired in-between failures, all data on the virtual disk is permanently lost - delete the virtual disk, create a new virtual disk, and then restore from a backup.|
|                     |Incomplete |Not enough physical disks are present to read the virtual disk.    <br>**Action**:|
|                     |None |    <br>**Action**:|
|                     |Unknown |    <br>**Action**:|
|    |Unknown||

### Unknown health state

|Operational state    |Description|
|---------            |---------          |
|Unknown|    ||
## Physical disk health and operational states

## Storage pool health and operational states

## Volume health and operational states