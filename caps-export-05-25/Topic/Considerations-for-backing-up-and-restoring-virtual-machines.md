---
title: Considerations for backing up and restoring virtual machines
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3465c6ba-5194-4b0e-b72c-a9168cd3bbd3
author: cwatsonmsft
---
# Considerations for backing up and restoring virtual machines
There are two basic options for backing up virtual machines. You can back up the virtual machine from the host, which includes the virtual hard disks and the configuration files or perform a full backup from within the virtual machine. The process of restoring a virtual machine is dependent upon how it was originally backed up.  
  
-   **[Backing up and restoring virtual machines from the host](../Topic/Considerations-for-backing-up-and-restoring-virtual-machines.md#BKMK_HOST_B)**. We recommend that you use this method. This type of backup includes:  
  
    -   Virtual machine configuration information  
  
    -   Checkpoints\/snapshots  
  
    -   Virtual hard disks  
  
-   **[Backing up and restoring from within the virtual machine](../Topic/Considerations-for-backing-up-and-restoring-virtual-machines.md#BKMK_VM_B)**. This method is similar to backing up a physical machine. Use this method when you need to back up data from storage that is not supported by the Hyper\-V VSS writer, like:  
  
    -   Physical disks that are directly attached to the virtual machine. These are also known as pass\-through disks.  
  
    -   Fibre channel connected storage  
  
    -   Guest\-initiated iSCSI connected storage  
  
    -   Clustered virtual machines that use a shared .vhdx  
  
## <a name="BKMK_HOST_B"></a>From the host  
We recommend that you back up your virtual machines from the host. If the backup application is compatible with Hyper\-V and the Hyper\-V Volume Shadow Copy Service \(VSS\) writer, the virtual machines can be backed up and brought back online quickly. This type of backup includes:  
  
-   Configuration information  
  
-   Checkpoints\/snapshots  
  
-   Virtual hard disks  
  
### Avoiding downtime  
You can perform a live backup of a running virtual machine with no downtime when all of the following conditions are met:  
  
-   The guest operating system supports live backup, is running the latest version of the integration services and the backup integration service, **Backup \(volume checkpoint\)**, is enabled.  All supported Windows guest operating systems support live backup. For supported Linux distributions see: [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](../Topic/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).  
  
-   All disks being used by the virtual machine are NTFS\-formatted basic disks. Storage partitions that have been formatted as [dynamic disks](http://msdn.microsoft.com/library/windows/desktop/aa363785.aspx) or FAT32 prevent a live backup. This is not the same as dynamically expanding virtual hard disks, which are fully supported by backup and restore operations.  
  
-   VSS must be enabled on all volumes used by the virtual machine.  
  
-   Shadow copies must be stored on the same volume from which they were created. For example, the shadow copies of volume C must also be stored on volume C. To check where shadow copies are being stored, at an elevated command prompt type: **vssadmin list shadowstorage**.  
  
If a live backup cannot be performed, then an offline backup is taken. An offline backup results in some downtime. If the virtual machine is running or paused, it is put into a saved state as part of the offline backup process. After the backup is completed, the virtual machine is returned to its existing state. Offline backups can happen in these situations:  
  
-   Virtual machines that do not have integration services installed or enabled will be put in a saved state while the VSS snapshot is created.  
  
-   Virtual machines that are running operating systems that do not support VSS will be put in a saved state while the VSS snapshot is created.  
  
-   Virtual machines that contain [dynamic disks](http://msdn.microsoft.com/library/windows/desktop/aa363785.aspx) \(not dynamically expanding\) must be backed up offline.  
  
### <a name="BKMK_HOST_R"></a>Restoring virtual machines from a host backup  
The Hyper\-V VSS writer treats Hyper\-V as an application that can be backed up. This means that you can recover individual virtual machines. However, you cannot recover only a portion of a virtual machine.  
  
> [!NOTE]  
> -   If you attempt to restore a virtual machine while it is running, it is turned off and deleted before the virtual machine is restored.  
> -   If you restore a virtual machine from a live backup, when you start the virtual machine you may receive a message that the operating system was not shut down properly. You can ignore this message.  
  
## <a name="BKMK_VM_B"></a>From in the virtual machine  
There are some storage configurations in which the Hyper\-V host cannot access the storage for the virtual machine because it is configured from within the virtual machine and the host is not aware that it is connected. In these situations, you will need to back up the virtual machines and their storage from within the guest. These situations include:  
  
-   You have clustered virtual machines using shared .vhdx.  In this case, you must perform the backup from within the virtual machines in the same way that you would typically backup physical machines using a cluster aware backup process.  
  
-   Physical disks that are directly attached to a virtual machine. These are also known as pass\-through disks.  
  
-   Storage that is accessed from a virtual machine by using fibre channel or an Internet SCSI \(iSCSI\) initiator within the guest operating system.  
  
This type of backup is similar to backing up a physical machine. You will run a backup application from within the guest operating system.  
  
If you back up your virtual machines from the guest operating system, you should also do a full server backup in case you need to restore the Hyper\-V server as well.  
  
### <a name="BKMK_VM_R"></a>Restoring from a backup taken inside a virtual machine  
Restoring from a backup that was taken from within a virtual machine requires two steps:  
  
1.  On the host, recreate the virtual machine using the same settings as the original virtual machine.  
  
2.  Start the virtual machine and restore from backup as you would with a physical computer.  
  
## Troubleshooting  
When backing up virtual machines, several warning messages may appear in the event log for the virtual machine.  
  
1.  Event ID: 58 \- This is discussed in more detail in [Hyper\-V and "Event ID: 58 \- The disk signature of disk 2 is equal to the disk signature of disk 0"](http://blogs.msdn.com/b/virtual_pc_guy/archive/2015/03/11/hyper-v-and-quot-event-id-58-the-disk-signature-of-disk-2-is-equal-to-the-disk-signature-of-disk-0-quot.aspx) in Ben Armstrong’s blog.  
  
2.  Event ID: 157 – a disk has been surprise removed. This happens when the disk is temporarily disconnected during backup. Install the update from [KB 2958027](https://support.microsoft.com/kb/2958027) or [KB 3000850](https://support.microsoft.com/kb/3000850) to suppress Event ID 157’s for virtual disks.  
  
These events can be ignored when they are logged during a backup. For more information on the backup process and why these events occur, see the article [How Hyper\-V Backup Got Better in 2012 R2 \(but now requires a SCSI controller\)](http://blogs.msdn.com/b/virtual_pc_guy/archive/2015/03/09/how-hyper-v-backup-got-better-in-2012-r2-but-now-requires-a-scsi-controller.aspx) in Ben Armstrong’s blog.  
  
## See also  
  
-   [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](../Topic/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)  
  
-   [Integration Services](../Topic/Integration-Services.md)  
  
-   [Supported Guest Operating Systems for Hyper\-V in Windows Server 2012 and Windows 8](assetId:///91958199-798d-4ac5-a019-3ed95c0cd2b8)  
  
-   [Supported Guest Operating Systems for Hyper\-V in Windows Server 2012 R2 and Windows 8.1](assetId:///0a3a974c-1714-47c8-88ca-8c1124dda369)  
  
-   [Hyper\-V on the TechNet forums](http://social.technet.microsoft.com/Forums/home?forum=winserverhyperv)  
  
