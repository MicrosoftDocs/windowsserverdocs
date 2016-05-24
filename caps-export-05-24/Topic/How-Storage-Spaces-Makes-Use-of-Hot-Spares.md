---
title: How Storage Spaces Makes Use of Hot Spares
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6930af89-2238-4392-a5cc-9976223c1f48
---
# How Storage Spaces Makes Use of Hot Spares
This topic describes how to designate disks as hot spares for use in automatically replacing failed disks in a storage pool, and how Storage Spaces monitors disk health and automatically recovers from failed disks.  
  
## How to designate hot spares  
You can designate a disk as a hot spare when creating a storage pool or when adding disks to a pool by using the File and Storage Services role in Server Manager, or by using Windows PowerShell.  
  
### When creating a storage pool  
To designate one or more disks as hot spares when creating a storage pool, use the following procedure:  
  
##### Create a storage pool with hot spares  
  
1.  In **Server Manager**, click **File and Storage Services**, and then **Storage Pools**.  
  
2.  In the **STORAGE POOLS** tile, click **Tasks**, and then **New Storage Pool**.  
  
3.  On the **Select physical disks for the storage pool** page, select the disks you want to designate as hot spares, and then choose **Hot Spare** in the **Allocation** column.  
  
### When adding a physical disk  
To designate one or more disks as hot spares when adding physical disks to a storage pool, use the following procedure:  
  
##### Add a hot spare to a storage pool  
  
1.  In **Server Manager**, click **File and Storage Services**, and then **Storage Pools**.  
  
2.  Select the appropriate storage pool, and then in the **PHYSICAL DISKS** tile, click **Tasks**, and then **Add Physical Disk**.  
  
3.  Select the disks you want to designate as hot spares, and then choose **Hot Spare** in the **Allocation** column.  
  
[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example adds the physical disk named *PhysicalDisk4* to the *Company Data* storage pool and designates the disk as a hot spare.  
  
```  
Add-PhysicalDisk -StoragePoolFriendlyName "Company Data" -PhysicalDisks (Get-PhysicalDisk -FriendlyName PhysicalDisk4) -Usage HotSpare  
```  
  
## How Storage Spaces monitors disk health  
  
### Write errors  
If a disk reports a media error during a write operation, Storage Spaces performs the following actions:  
  
-   Marks the disk as Failed  
  
-   Activates the failure LED for the disk, if the disk is in a JBOD that supports SCSI Enclosure Services  
  
-   Replaces the failed disk with a hot spare and retries the write operation, if there is a hot spare available in the storage pool  
  
> [!NOTE]  
> Modern hard disks are designed to silently handle a limited number failures without reporting an error to the operating system. If the disk exceeds the number of allowed failures during a write operation, it reports a media error, which is typically an indicator that the disk is approaching a catastrophic failure.  
  
### Read errors  
If an error occurs while reading data from a disk, Storage Spaces performs the following actions:  
  
1.  Attempts to retrieve a copy of the data from another disk in the mirror or parity space. If this attempt succeeds, the read error is cleared.  
  
2.  Attempts to write a fresh copy of the data that was retrieved to the location that produced the read error. If this attempt fails, Storage Spaces produces a write error and takes action as described in the Write Errors section.  
  
### Disconnected disks  
If a disk is unexpectedly disconnected or silently fails read or write operations and a hot spare is available in the storage pool Storage Spaces performs the following actions by default:  
  
-   Marks the disk as Failed  
  
-   Replaces the failed disk with a hot spare and retries the write operation  
  
-   If there is not a hot spare available, Storage Spaces waits for the disk to reconnect or for administrator to take action.  
  
This behavior is configurable by using the `Set-StoragePool –RetireMissingPhysicalDisks <value>` cmdlet from a Windows PowerShell session. There are three settings:  
  
|Setting|Behavior|  
|-----------|------------|  
|Auto|If a hot spare is available in the storage pool follow the **Enabled** logic. Otherwise, follow the **Disabled** logic.|  
|Enabled|Mark the disk as Failed, replace it with a hot spare, and then retry the operation|  
|Disabled|Wait for the disk to reconnect or for an administrator to take action \(do not use any available hot spares\)|  
  
> [!NOTE]  
> If an entire enclosure is disconnected, no action is taken even when set to **Auto** or **Enabled** because the system has likely lost more disks than can be replaced by hot spares.  
  
