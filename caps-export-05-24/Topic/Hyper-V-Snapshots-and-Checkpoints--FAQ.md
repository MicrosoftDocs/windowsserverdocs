---
title: Hyper-V Snapshots and Checkpoints: FAQ
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6aeaf839-2fb9-475f-a94c-28a4d5b7f9ac
author: cwatsonmsft
---
# Hyper-V Snapshots and Checkpoints: FAQ
**What are virtual machine snapshots?**  
  
Virtual machine snapshots capture the state, data, and hardware configuration of a running virtual machine.  
  
**What are snapshots used for?**  
  
Snapshots provide a fast and easy way to revert the virtual machine to a previous state. For this reason, virtual machine snapshots are intended mainly for use in development and test environments. Having an easy way to revert a virtual machine can be very useful if you need to recreate a specific state or condition so that you can troubleshoot a problem.  
  
There are certain circumstances in which it may make sense to use snapshots in a production environment. For example, you can use snapshots to provide a way to revert a potentially risky operation in a production environment, such as applying an update to the software running in the virtual machine.  
  
**How are snapshots stored?**  
  
Snapshot data files are stored as .avhd files. Taking multiple snapshots can quickly consume storage space. In the first release version of Hyper\-V \(KB950050\) and in Hyper\-V in Windows Server 2008 Service Pack 2, snapshot, snapshot data files usually are located in the same folder as the virtual machine by default. In Hyper\-V in Windows Server 2008 R2, the files usually are located in the same folder as the virtual hard disk. The following exceptions affect the location of the snapshot data files: If the virtual machine was imported with snapshots, they are stored in their own folder. If the virtual machine has no snapshots and you configure the virtual machine snapshot setting, all snapshots you take afterwards will be stored in the folder you specify.  
  
> [!CAUTION]  
> Do not delete .avhd files directly from the storage location. Instead, use Hyper\-V Manager to select the virtual machine, and then delete the snapshots from the snapshot tree.  
>   
> Do not expand a virtual hard disk when it is used in a virtual machine that has snapshots. Doing so will make the snapshots unusable.  
  
**What other important considerations should I be aware of when using snapshots?**  
  
Keep the following considerations in mind, especially if you plan to use snapshots on a virtual machine in a production environment:  
  
-   The presence of a virtual machine snapshot reduces the disk performance of the virtual machine.  
  
-   When you delete a snapshot, the .avhd files that store the snapshot data remain in the storage location until the virtual machine is shut down, turned off, or put into a saved state. As a result, when you delete a snapshot, you will need to put the production virtual machine into one of those states at some point to be able to complete the safe removal of the snapshot.  
  
-   We do not recommend using snapshots on virtual machines that provide time\-sensitive services, or when performance or the availability of storage space is critical.  
  
    > [!IMPORTANT]  
    > Microsoft does not support the use of snapshots on virtual machines hosting the Active Directory Domain Services role \(also known as “domain controllers”\) or virtual machines hosting the Active Directory Lightweight Directory Services role in Windows Server 2008 or Windows Server 2008 R2. For more information, see [Operational Considerations for Virtualized Domain Controllers](http://go.microsoft.com/fwlink/?LinkId=159631) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159631\).  
    >   
    > For information about virtualizing domain controllers in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], see [Active Directory Domain Services \(AD DS\) Virtualization](http://technet.microsoft.com/library/hh831734.aspx).  
  
**I’ve taken multiple snapshots and now my virtual machine pauses automatically. Hyper\-V Manager shows the status as ‘paused\-critical’. How can I fix this?**  
  
This problem occurs when you have run out of space on the physical storage where the virtual machine snapshot files are stored. Note that this may be on a different drive than where the virtual hard disk is stored.  
  
To fix the problem, create additional space on the drive by deleting unused data. For example, if you do not need to keep some of the snapshots, you can delete the snapshots individually. \(Make sure to use Hyper\-V Manager to delete the snapshots. Do not delete the .ahvd files directly.\) Or, to delete all of the snapshots in one action, export the virtual machine and then import the virtual machine. If you delete snapshots, you must shut down, turn off, or save the state of the virtual machine to delete the snapshots from the physical storage.  
  
**I’ve deleted some snapshots to free up storage space, but the space hasn’t been recovered. What can I do?**  
  
Shut down the virtual machine—or, if that action is not available, turn off the virtual machine. Deleted virtual machine snapshot files are not removed from the physical storage until the virtual machine is shut down, turned off, or put into a saved state. Depending on the size and number of snapshots, it may take a while to delete the snapshot files. Hyper\-V Manager displays the progress when deleting the snapshots.  
  
**I’ve tried to delete snapshots, but they failed to merge because there is not enough space on the disk \(error 0x80070070\). What can I do?**  
  
If possible, free up storage space on the volume where the .vhd file is located. In some cases this might not be possible. For example, the space is occupied by .vhd and .avhd files only. If you cannot free up space on the current volume, export the virtual machine to a volume that has sufficient disk space to allow the merge to complete. The process of exporting the virtual machine to delete snapshots consists of the following steps:  
  
1.  Export the virtual machine from the current location.  
  
2.  Import the virtual machine to a location that has sufficient storage space. The location should be a different volume on the same host to avoid configuration problems.  
  
3.  If the version of Hyper\-V is earlier than Windows Server 2008 R2, turn on the virtual machine and then shut it down, to trigger the merge process at the new storage location.  
  
4.  If you want to move the virtual machine back to the original location, free up additional space. Then, import the virtual machine back to the original location.  
  
For more information about exporting and importing virtual machines using Hyper\-V in Windows Server 2008 R2, see the blog post [Hyper\-V R2 Import\/Export – Part 1 – The Case for New Import\/Export Functionality](http://go.microsoft.com/fwlink/?LinkId=207802) \( HYPERLINK "http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207802" http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207802\). For more information about exporting and importing virtual machines using the release version of Hyper\-V for Windows Server 2008, see [Hyper\-V \- Export & Import \(Part 1\)](http://go.microsoft.com/fwlink/?LinkId=207800) \( HYPERLINK "http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207800" http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207800\).  
  
**Should snapshots be used as a substitute for backups?**  
  
No, because virtual machine snapshots are not the same as backups created by a Volume Shadow Copy Service \(VSS\) writer. We do not recommend using virtual machine snapshots as a permanent data or system recovery solution. Even though virtual machine snapshots provide a convenient way to store different points of system state, data, and configuration, there are some inherent risks of unintended data loss if they are not managed appropriately. A backup solution helps provide protection that is not provided by snapshots.  
  
One reason that snapshots are not an acceptable substitute for a backup is that they do not protect against problems that may occur on the server running Hyper\-V, such as a hardware malfunction on the physical computer or a software\-related issue in the management operating system. Another reason is that applications that run in a virtual machine are not aware of the snapshot, and will not be able to adjust appropriately. For example, if you used a virtual machine snapshot to restore an Exchange server, the server would expect the same set of client connections that were present when the snapshot was taken.  
  
For more information about backing up Hyper\-V and its virtual machines, see [Planning for Backup](http://go.microsoft.com/fwlink/?LinkId=143125) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=143125\).  
  
