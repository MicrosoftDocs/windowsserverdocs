---
title: Planning for Backup
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a6088e0-080f-4ed6-85a5-0e2182eb9766
author: cwatsonmsft
---
# Planning for Backup
When you plan a backup and recovery strategy for a virtualized server environment, there are several factors to consider. You must consider the different types of backups you can make, the state of the virtual machine, and the type of storage being used by the virtual machines. This topic discusses the advantages, disadvantages, and considerations for these factors.  
  
> [!NOTE]  
> This topic discusses considerations for backup strategies that are implemented using backup applications that support the Hyper\-V Volume Shadow Copy Service \(VSS\) writer. VSS snapshots are not the same as virtual machine snapshots. This topic does not cover the use of virtual machine snapshots because we do not recommend them as a permanent data or system recovery solution. Virtual machine snapshots are intended mainly for use in development and test environments because they provide a convenient way to store different points of system state, data, and configuration. However, there are some inherent risks of unintended data loss if they are not managed appropriately. For more information about virtual machine snapshots, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133342](http://go.microsoft.com/fwlink/?LinkId=133342).  
  
## Understanding backup options and considerations  
The backup integration service \(identifiable as Hyper\-V Volume Shadow Copy Requestor service in the guest operating system\) and the Hyper\-V Volume Shadow Copy Service \(VSS\) writer provide the mechanism for backing up virtual machines as well as system\-wide settings that apply to Hyper\-V. To implement the backup and recovery scenarios discussed in this section, you must use a backup application that is compatible with the Hyper\-V VSS writer. If you want to use Windows Server Backup, you must add a registry key to register the Hyper\-V VSS writer. For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133354](http://go.microsoft.com/fwlink/?LinkID=133354).  
  
There are two basic methods you can use to perform a backup. You can:  
  
-   **Perform a backup from the server running Hyper\-V.** We recommend that you use this method to perform a full server backup because it captures more data than the other method. If the backup application is compatible with Hyper\-V and the Hyper\-V VSS writer, you can perform a full server backup that helps protect all of the data required to fully restore the server, except the virtual networks. The data included in such a backup includes the configuration of virtual machines, snapshots associated with the virtual machines, and virtual hard disks used by the virtual machines. As a result, using this method can make it easier to recover the server if you need to, because you do not have to recreate virtual machines or reinstall Hyper\-V. However, virtual networks are not included in a full server backup. You will need to reconfigure the virtual networking by recreating the virtual networks and then reattaching the virtual network adapters in each virtual machine to the appropriate virtual network. As part of your backup planning, make sure you document the configuration and all relevant settings of your virtual network if you want to be able to recreate it.  
  
-   **Perform a backup from within the guest operating system of a virtual machine.** Use this method when you need to back up data from storage that is not supported by the Hyper\-V VSS writer. When you use this method, you run a backup application from the guest operating system of the virtual machine. If you need to use this method, you should use it in addition to a full server backup and not as an alternative to a full server backup. Perform a backup from within the guest operating system before you perform a full backup of the server running Hyper\-V. For more information about storage considerations, see the following section.  
  
> [!NOTE]  
> If you frequently back up virtual machines on a server running Hyper\-V in Windows Server 2008 R2, the startup time of the server might start increasing or the startup might hang at the Welcome screen. A hotfix is available to fix this problem. For more information about this hotfix, see article [982210](http://go.microsoft.com/fwlink/?LinkId=206474) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=206474\).  
  
### Storage considerations  
As you plan your backup strategy, consider the compatibility between the storage and backup solutions:  
  
-   **Virtual hard disks.** These offer the best compatibility and can be stored on many types of physical media. For more information about the types of storage you can use with Hyper\-V, see [Hardware Considerations](https://technet.microsoft.com/library/cc816844(v=ws.10).aspx).  
  
-   **Physical disks that are directly attached to a virtual machine.** These disks cannot be backed up by the Hyper\-V VSS writer. As a result, this type of disk will not be included in any backup performed by a backup program that uses the Hyper\-V VSS writer. In this situation, you would need to use some other process to back up the physical disk, such as running a backup application within the guest operating system.  
  
-   **iSCSI\-based storage.** This storage is supported for backup by the Hyper\-V VSS writer when the storage is connected through the management operating system and the storage is used for virtual hard disks.  
  
-   **Storage accessed from a virtual machine by using an Internet SCSI \(iSCSI\) initiator within the guest operating system.** This storage will not be included in a backup of the physical computer. In this scenario, you must use another process to back up the data from the iSCSI\-based storage before you perform a full server backup. For example, you could run a backup of the data on the iSCSI storage from a backup application running in the guest operating system.  
  
    > [!NOTE]  
    > In this scenario, when you back up a virtual machine, the VSS provider for the iSCSI\-based storage may create a temporary VSS snapshot for each LUN. The temporary snapshot is not used by the Hyper\-V VSS writer and is deleted automatically; however, this process can result in more time required to perform a full server backup. If you are running Hyper\-V in Windows Server 2008 R2, you can avoid this issue by installing a hotfix. For more information about this hotfix, see article [975354](http://go.microsoft.com/fwlink/?LinkID=179092) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=179092\).  
  
For more information about deploying storage for Hyper\-V, see [Implementing Disks and Storage](https://technet.microsoft.com/library/dd183729(v=ws.10).aspx).  
  
## Understanding online and offline backups  
Whether a backup is performed online or offline depends on whether the backup can be performed without downtime.  
  
You can perform an online backup with no downtime on a running virtual machine when all of the following conditions are met:  
  
-   Integration services are installed and the backup integration service has not been disabled.  
  
-   All disks being used by the virtual machine are configured within the guest operating system as NTFS\-formatted basic disks. Virtual machines that use storage on which the physical partitions have been formatted as dynamic disks or the FAT32 file system prevent an online backup from being performed. This is not the same as dynamically expanding virtual hard disks, which are fully supported by backup and restore operations.  
  
-   Volume Shadow Copy Service must be enabled on all volumes used by the virtual machine with a specific configuration. Each volume must also serve as the storage location for shadow copies of the volume. For example, the shadow copy storage for volume C: must be located on C:.  
  
If an online backup cannot be performed, then an offline backup is taken. This type of backup results in some degree of downtime. A variety of factors can affect the time required to take an offline backup. If the virtual machine is running or paused, it is put into a saved state as part of the offline backup process. After the backup is completed, the virtual machine is returned to its existing state.  
  
## Understanding the restore process  
The restore process is straightforward as long as the recommendations outlined in the previous sections were followed when the backups were created. This includes taking the recommended steps to ensure that data which is not included in a full server backup can be recovered or recreated.  
  
To restore when all components of your backup set are supported by the Hyper\-V VSS writer, have all the media and equipment available and then perform a restore of the entire system or the virtual machine, depending on your circumstances. The Hyper\-V VSS writer treats Hyper\-V as an application that can be backed up. This means that you can recover individual virtual machines. However, you cannot use this method to recover only a portion of a virtual machine.  
  
To restore when your backup set includes media that is not supported by the Hyper\-V VSS writer, you must perform an additional step. First, perform a restore of the entire system or the virtual machine, depending on your circumstances. Then, restore the unsupported media from within the guest operating system.  
  
> [!NOTE]  
> If you attempt to restore a virtual machine while it is running, it is turned off and deleted before the backed\-up version of the virtual machine is restored.  
  
> [!NOTE]  
> If you restore a virtual machine from an online backup, when you start the virtual machine you may receive a message that the operating system was not shut down properly. You can ignore this message.  
  
## Considerations about clustered virtual machines  
If you plan to cluster virtual machines, there are additional factors that you need to consider when planning to backup and restore those virtual machines. Before you attempt to back up or restore clustered virtual machines, consider the following:  
  
-   Apply a hotfix to prevent possible failure of a full server backup on a node when a virtual machine uses a volume mounted with a GUID. When the hotfix applied, a directory path that cannot be resolved will prevent only the virtual machine that uses the directory path from being backed up. However, when the hotfix is not applied, a volume mounted with a GUID may cause the entire backup operation to fail. For more information, see article [958184](http://go.microsoft.com/fwlink/?LinkId=133348) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133348\).  
  
-   You may need to take the virtual machine offline before you run a backup or restore a virtual machine. For instructions on taking a clustered virtual machine offline, see [Hyper\-V: Using Hyper\-V and Failover Clustering](http://go.microsoft.com/fwlink/?LinkID=129063) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=129063\).  
  
-   For information about backing up a cluster that uses Cluster Shared Volumes, see [Backing Up Cluster Shared Volumes in a Failover Cluster in Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=182154) \( HYPERLINK "http:\/\/go.microsoft.com\/fwlink\/?LinkId\=182154" http:\/\/go.microsoft.com\/fwlink\/?LinkId\=182154\).  
  
-   Several factors can affect backup and recovery operations when a virtual machine is clustered. The following tables identify the factors you need to consider and the action you need to take to perform the backup or recovery operation. The information in both tables assumes that you will run the backup or recovery operation on node 1.  
  
**Considerations for backing up clustered virtual machines**  
  
|||||||  
|-|-|-|-|-|-|  
|Location of cluster group|Cluster resource state|Configuration resource state|Storage resource state|Backup type|Action required to prepare for a backup|  
|Node 1|Online|Online|Online|Online|None|  
|Node 1|Online|Online|Online|Offline \(due to storage configuration of the virtual machine\)|Use the Cluster service to take the virtual machine cluster resource offline|  
|Node 1|Offline|Offline|Online|Offline|None|  
|Node 1|Offline|Online|Online|Offline|None|  
|Node 2|Any state|Any state|Any state|Virtual machine not reported for backup on node 1|Move the virtual machine to node 1|  
  
**Considerations for restoring clustered virtual machines**  
  
||||||  
|-|-|-|-|-|  
|Location|Cluster resource state|Configuration resource state|Storage resource state|Action required to prepare for a restore|  
|Node 1|Online|Online|Online|Take the cluster resource and configuration resource offline.|  
|Node 1|Offline|Online|Online|Take the configuration resource offline.|  
|Node 1|Offline|Offline|Offline|None|  
|Node 2|Any state|Any state|Any state|Take the cluster resource and the configuration resource offline on Node 2 to avoid a conflict.|  
  
