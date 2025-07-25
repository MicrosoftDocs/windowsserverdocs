---
title: Volume Shadow Copy Service (VSS)
description: Learn how to use Volume Shadow Copy Service to coordinate the actions that are required to create a consistent shadow copy for backup and restore operations in Windows Server.
ms.topic: concept-article
author: xelu86
ms.author: alalve
ms.date: 07/07/2025
---

# Volume Shadow Copy Service (VSS)

Backing up and restoring critical business data can be complex due to the following issues:

- The data usually needs to be backed up while the applications that produce the data are still running. This means that some of the data files might be open or they might be in an inconsistent state.

- If the data set is large, it can be difficult to back up all of it at one time.

Correctly performing backup and restore operations requires close coordination between the backup applications, the line-of-business applications that are being backed up, and the storage management hardware and software. The Volume Shadow Copy Service (VSS), which was introduced in Windows Server 2003, facilitates the communication between these components to allow them to work better together. When all the components support VSS, you can use them to back up your application data without taking the applications offline.

VSS coordinates the actions that are required to create a consistent shadow copy (also known as a snapshot or a point-in-time copy) of the data that is to be backed up. The shadow copy can be used as-is, or it can be used in the following scenarios:

- You want to back up application data and system state information, including archiving data to another hard disk drive, to tape, or to other removable media.

- You're data mining.

- You're performing disk-to-disk backups.

- You need a fast recovery from data loss by restoring data to the original Logical Unit Number (LUN) or to an entirely new LUN that replaces an original LUN that failed.

Windows features and applications that use VSS include:

- [Windows Server Backup](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754572(v=ws.10))

- [Shadow Copies of Shared Folders](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771305(v=ws.11))

- [System Center Data Protection Manager](/system-center/dpm/dpm-overview)

- [System Restore](https://support.microsoft.com/windows/use-system-restore-a5ae3ed9-07c4-fd56-45ee-096777ecd14e)

## How VSS works

A complete VSS solution requires all of the following basic parts:

- **VSS service**: Part of the Windows operating system that ensures the other components can communicate with each other properly and work together.

- **VSS requester**: The software that requests the actual creation of shadow copies (or other high-level operations like importing or deleting them). Typically, this is the backup application. The Windows Server Backup utility and the System Center Data Protection Manager application are VSS requesters. Non-Microsoft VSS requesters include nearly all backup software that runs on Windows.

- **VSS writer**: The component that guarantees you have a consistent data set to back up. This is typically provided as part of a line-of-business application, such as SQL Server or Exchange Server. VSS writers for various Windows components, such as the registry, are included with the Windows operating system. Non-Microsoft VSS writers are included with many applications for Windows that need to guarantee data consistency during backup.

- **VSS provider**: The component that creates and maintains the shadow copies. This can occur in the software or in the hardware. The Windows operating system includes a VSS provider that uses copy-on-write. If you use a storage area network (SAN), it's important that you install the VSS hardware provider for the SAN, if one is provided. A hardware provider offloads the task of creating and maintaining a shadow copy from the host operating system.

The following diagram illustrates how the VSS service coordinates with requesters, writers, and providers to create a shadow copy of a volume.

![Diagram showing how the VSS service coordinates with requesters, writers, and providers to create a shadow copy of a volume.](media/volume-shadow-copy-service/Ee923636.94dfb91e-8fc9-47c6-abc6-b96077196741(WS.10).jpg)

*Figure 1: Architectural diagram of Volume Shadow Copy Service*

### How a shadow copy is created

This section puts the various roles of the requester, writer, and provider into context by listing the steps that need to be taken to create a shadow copy. The following diagram shows how VSS controls the overall coordination of the requester, writer, and provider.

![Diagram showing how the Volume Shadow Copy Service controls the overall coordination of the requester, writer, and provider.](media/volume-shadow-copy-service/Ee923636.1c481a14-d6bc-4796-a3ff-8c6e2174749b(WS.10).jpg)

*Figure 2: Shadow copy creation process*

To create a shadow copy, the requester, writer, and provider perform the following actions:

1. The requester asks VSS to enumerate the writers, gather the writer metadata, and prepare for shadow copy creation.

1. Each writer creates an XML description of the components and data stores that need to be backed up and provides it to VSS. The writer also defines a restore method, which is used for all components. VSS provides the writer's description to the requester, which selects the components that are backed up.

1. VSS notifies all the writers to prepare their data for making a shadow copy.

1. Each writer prepares the data as appropriate, such as completing all open transactions, rolling transaction logs, and flushing caches. When the data is ready to be shadow-copied, the writer notifies VSS.

1. VSS informs the writers to temporarily freeze application write I/O requests (read I/O requests are still possible) for the few seconds that are required to create the shadow copy of the volume or volumes. The application freeze isn't allowed to take longer than 60 seconds. VSS flushes the file system buffers and then freezes the file system, which ensures that the file system metadata is recorded correctly and the data to be shadow-copied is written in a consistent order.

1. VSS informs the provider to create the shadow copy. The shadow copy creation period lasts no more than 10 seconds, during which all write I/O requests to the file system remain frozen.

1. VSS releases file system write I/O requests.

1. VSS informs the writers to thaw application write I/O requests. At this point, applications are free to resume writing data to the disk that's being shadow-copied.

   > [!NOTE]
   > The shadow copy creation can be aborted if the writers are kept in the freeze state for longer than 60 seconds or if the providers take longer than 10 seconds to commit the shadow copy.

1. The requester can retry the process (go back to step 1) or notify the administrator to retry at a later time.

1. If the shadow copy is successfully created, VSS returns the location information for the shadow copy to the requester. In some cases, the shadow copy can be temporarily made available as a read-write volume so that VSS and one or more applications can alter the contents of the shadow copy before the shadow copy is finished. After VSS and the applications make their alterations, the shadow copy is made read-only. This phase is called autorecovery, and it's used to undo any file-system or application transactions on the shadow copy volume that weren't completed before the shadow copy was created.

### How the provider creates a shadow copy

A hardware or software shadow copy provider uses one of the following methods for creating a shadow copy:

- **Complete copy**: This method makes a complete copy (called a *full copy* or *clone*) of the original volume at a given point in time. This copy is read-only.

- **Copy-on-write**: This method doesn't copy the original volume. Instead, it makes a differential copy by copying all changes (completed write I/O requests) that are made to the volume after a given point in time.

- **Redirect-on-write**: This method doesn't copy the original volume, and it doesn't make any changes to the original volume after a given point in time. Instead, it makes a differential copy by redirecting all changes to a different volume.

## Complete copy

A complete copy is created by making a *split mirror*, as follows:

1. The original volume and the shadow copy volume are a mirrored volume set.

1. The shadow copy volume is separated from the original volume. This breaks the mirror connection.

After the mirror connection is broken, the original volume and the shadow copy volume are independent. The original volume continues to accept all changes (write I/O requests), while the shadow copy volume remains an exact read-only copy of the original data at the time of the break.

### Copy-on-write method

In the copy-on-write method, when a change to the original volume occurs (but before the write I/O request is completed), each block to be modified is read and then written to the volume's shadow copy storage area (also called its *diff area*). The shadow copy storage area can be on the same volume or a different volume. This preserves a copy of the data block on the original volume before the change overwrites it.

| Time | Source data (status and data) | Shadow copy (status and data) |
|------|-------------------------------|-------------------------------|
| T0 | Original data: 1 2 3 4 5 | No copy: — |
| T1 | Data changed in cache: 3 to 3' | Shadow copy created (differences only): 3 |
| T2 | Original data overwritten: 1 2 3' 4 5 | Differences and index stored on shadow copy: 3 |

*Table 1: The copy-on-write method of creating shadow copies*

The copy-on-write method is a quick method for creating a shadow copy, because it copies only data that's changed. The copied blocks in the diff area can be combined with the changed data on the original volume to restore the volume to its state before any of the changes were made. If there are many changes, the copy-on-write method can become expensive.

### Redirect-on-write method

In the redirect-on-write method, whenever the original volume receives a change (write I/O request), the change isn't applied to the original volume. Instead, the change is written to another volume's shadow copy storage area.

| Time | Source data (status and data) | Shadow copy (status and data) |
|------|-------------------------------|-------------------------------|
| T0 | Original data: 1 2 3 4 5 | No copy: — |
| T1 | Data changed in cache: 3 to 3' | Shadow copy created (differences only): 3' |
| T2 | Original data overwritten: 1 2 3 4 5 | Differences and index stored on shadow copy: 3' |

*Table 2: The redirect-on-write method of creating shadow copies*

Like the copy-on-write method, the redirect-on-write method is a quick method for creating a shadow copy, because it copies only changes to the data. The copied blocks in the diff area can be combined with the unchanged data on the original volume to create a complete, up-to-date copy of the data. If there are many read I/O requests, the redirect-on-write method can become expensive.

## Shadow copy providers

There are two types of shadow copy providers: hardware-based providers and software-based providers. There's also a system provider, which is a software provider that's built in to the Windows operating system.

### Hardware-based providers

Hardware-based shadow copy providers act as an interface between VSS and the hardware level by working with a hardware storage adapter or controller. The work of creating and maintaining the shadow copy is performed by the storage array.

Hardware providers always take the shadow copy of an entire LUN, but VSS only exposes the shadow copy of the volume or volumes that were requested.

A hardware-based shadow copy provider makes use of VSS functionality that defines the point in time, allows data synchronization, manages the shadow copy, and provides a common interface with backup applications. However, VSS doesn't specify the underlying mechanism by which the hardware-based provider produces and maintains shadow copies.

### Software-based providers

Software-based shadow copy providers typically intercept and process read and write I/O requests in a software layer between the file system and the volume manager software.

These providers are implemented as a user-mode DLL component and at least one kernel-mode device driver, typically a storage filter driver. Unlike hardware-based providers, software-based providers create shadow copies at the software level, not the hardware level.

A software-based shadow copy provider must maintain a *point-in-time* view of a volume by having access to a data set that can be used to re-create volume status before the shadow copy creation time. An example is the copy-on-write technique of the system provider. However, VSS places no restrictions on what technique the software-based providers use to create and maintain shadow copies.

A software provider is applicable to a wider range of storage platforms than a hardware-based provider, and it should work with basic disks or logical volumes equally well. (A logical volume is a volume that's created by combining free space from two or more disks.) In contrast to hardware shadow copies, software providers consume operating system resources to maintain the shadow copy.

For more information about basic disks, see [Manage basic volumes](../disk-management/manage-basic-volumes.md).

### System provider

One shadow copy provider, the system provider, is supplied in the Windows operating system. Although a default provider is supplied in Windows, other vendors are free to supply implementations that are optimized for their storage hardware and software applications.

To maintain the *point-in-time* view of a volume that's contained in a shadow copy, the system provider uses a copy-on-write technique. Copies of the blocks on volume that have been modified since the beginning of the shadow copy creation are stored in a shadow copy storage area.

The system provider can expose the production volume, which can be written to and read from normally. When the shadow copy is needed, it logically applies the differences to data on the production volume to expose the complete shadow copy.

For the system provider, the shadow copy storage area must be on an NTFS volume. The volume to be shadow copied doesn't need to be an NTFS volume, but at least one volume mounted on the system must be an NTFS volume.

The component files that make up the system provider are `swprv.dll` and `volsnap.sys`.

### In-box VSS writers

The Windows operating system includes a set of VSS writers that are responsible for enumerating the data that's required by various Windows features.

For more information about these writers, see [In-Box VSS Writers](/windows/win32/vss/in-box-vss-writers).

## How shadow copies are used

In addition to backing up application data and system state information, shadow copies can be used for many purposes, including:

- Restoring LUNs (LUN resynchronization and LUN swapping).

- Restoring individual files (Shadow Copies of Shared Folders).

- Data mining by using transportable shadow copies.

### Restoring LUNs (LUN resynchronization and LUN swapping)

In Windows Server 2008 R2 and Windows 7, VSS requesters can use a hardware shadow copy provider feature called LUN resynchronization (or *LUN resync*). This is a fast-recovery scheme that allows an application administrator to restore data from a shadow copy to the original LUN or to a new LUN.

The shadow copy can be a full clone or a differential shadow copy. In either case, at the end of the resync operation, the destination LUN has the same contents as the shadow copy LUN. During the resync operation, the array performs a block-level copy from the shadow copy to the destination LUN.

> [!NOTE]
> The shadow copy must be a transportable hardware shadow copy.

Most arrays allow production I/O operations to resume shortly after the resync operation begins. While the resync operation is in progress, read requests are redirected to the shadow copy LUN, and write requests to the destination LUN. This allows arrays to recover large data sets and resume normal operations in several seconds.

LUN resynchronization is different from LUN swapping. A LUN swap is a fast recovery scenario that VSS has supported since Windows Server 2003 SP1. In a LUN swap, the shadow copy is imported and then converted into a read-write volume. The conversion is an irreversible operation, and the volume and underlying LUN can't be controlled with the VSS APIs after that. The following list describes how LUN resynchronization compares with LUN swapping:

- In LUN resynchronization, the shadow copy isn't altered, so it can be used several times. In LUN swapping, the shadow copy can be used only once for a recovery. For the most safety-conscious administrators, this is important. When LUN resynchronization is used, the requester can retry the entire restore operation if something goes wrong the first time.

- At the end of a LUN swap, the shadow copy LUN is used for production I/O requests. For this reason, the shadow copy LUN must use the same quality of storage as the original production LUN to ensure that performance isn't impacted after the recovery operation. If LUN resynchronization is used instead, the hardware provider can maintain the shadow copy on storage that is less expensive than production-quality storage.

- If the destination LUN is unusable and needs to be re-created, LUN swapping might be more economical because it doesn't require a destination LUN.

> [!WARNING]
> All of the operations listed are LUN-level operations. If you attempt to recover a specific volume by using LUN resynchronization, you're unwittingly going to revert all the other volumes that are sharing the LUN.

### Restoring individual files (Shadow Copies of Shared Folders)

Shadow Copies of Shared Folders uses VSS to provide point-in-time copies of files that are located on a shared network resource, such as a file server. With Shadow Copies of Shared Folders, users can quickly recover deleted or changed files that are stored on the network. Because they can do so without administrator assistance, Shadow Copies of Shared Folders can increase productivity and reduce administrative costs.

For more information, see [Shadow Copies of Shared Folders](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771305(v=ws.10)).

### Data mining by using transportable shadow copies

With a hardware provider that's designed for use with VSS, you can create transportable shadow copies that can be imported onto servers within the same subsystem (for example, a SAN). These shadow copies can be used to seed a production or test installation with read-only data for data mining.

With VSS and a storage array with a hardware provider that's designed for use with VSS, it's possible to create a shadow copy of the source data volume on one server, and then import the shadow copy onto another server (or back to the same server). This process is accomplished in a few minutes, regardless of the size of the data. The transport process is accomplished through a series of steps that use a shadow copy requester (a storage-management application) that supports transportable shadow copies.

## To transport a shadow copy

1. Create a transportable shadow copy of the source data on a server.

1. Import the shadow copy to a server that's connected to the SAN. (You can import to a different server or the same server.)

1. The data is now ready to be used.

![Diagram showing how to transport a shadow copy between two servers.](media/volume-shadow-copy-service/Ee923636.633752e0-92f6-49a7-9348-f451b1dc0ed7(WS.10).jpg)

*Figure 3: Shadow copy creation and transport between two servers*

> [!NOTE]
> A transportable shadow copy that's created on Windows Server 2003 can't be imported onto a server that's running Windows Server 2008 or Windows Server 2008 R2. A transportable shadow copy that was created on Windows Server 2008 or Windows Server 2008 R2 can't be imported onto a server that's running Windows Server 2003. However, a shadow copy that's created on Windows Server 2008 can be imported onto a server that's running Windows Server 2008 R2, and vice versa.

Shadow copies are read-only. If you want to convert a shadow copy to a read/write LUN, you can use a Virtual Disk Service-based storage-management application (including some requesters) in addition to VSS. By using this application, you can remove the shadow copy from Volume Shadow Copy Service management and convert it to a read/write LUN.

VSS transport is an advanced solution on computers running Windows Server 2003 Enterprise Edition, Windows Server 2003 Datacenter Edition, Windows Server 2008, or Windows Server 2008 R2. It works only if there's a hardware provider on the storage array. Shadow copy transport can be used for many purposes, including tape backups, data mining, and testing.

## Frequently asked questions

This FAQ answers questions about VSS for system administrators. For information about VSS application programming interfaces, see [Volume Shadow Copy Service](/windows/win32/vss/volume-shadow-copy-service-portal).

### When was VSS introduced? On which Windows operating system versions is it available?

VSS was introduced in Windows XP. It's available on Windows XP, Windows Server 2003, Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2.

### What's the difference between a shadow copy and a backup?

A shadow copy serves as the backup when performing a hard disk drive backup. Data can be extracted from the shadow copy for restoration purposes, or the shadow copy can be directly used for rapid recovery scenarios, such as LUN resynchronization or LUN swapping.

When data is copied from the shadow copy to tape or other removable media, the content that's stored on the media constitutes the backup. The shadow copy itself can be deleted after the data is copied from it.

### What's the largest size volume that VSS supports?

VSS supports a volume size of up to 64 TB.

### I made a backup on Windows Server 2008. Can I restore it on Windows Server 2008 R2?

It depends on the backup software that you used. Most backup programs support this scenario for data but not for system state backups.

Shadow copies that are created on either of these versions of Windows can be used on the other.

### I made a backup on Windows Server 2003. Can I restore it on Windows Server 2008?

It depends on the backup software you used. If you create a shadow copy on Windows Server 2003, you can't use it on Windows Server 2008. Also, if you create a shadow copy on Windows Server 2008, you can't restore it on Windows Server 2003.

### How can I disable VSS?

It's possible to disable VSS by using the Microsoft Management Console. However, you shouldn't do this. Disabling VSS adversely affects any software you use that depends on it, such as System Restore and Windows Server Backup.

For more information, see the following Microsoft TechNet Web sites:

- [System Restore](/previous-versions/technet-magazine/cc137798(v=msdn.10))

- [Windows Server Backup](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754572(v=ws.10))

### Can I exclude files from a shadow copy to save space?

VSS is designed to create shadow copies of entire volumes. Temporary files, such as paging files, are automatically omitted from shadow copies to save space.

To exclude specific files from shadow copies, use the following registry key: `FilesNotToSnapshot`.

> [!NOTE]
> The `FilesNotToSnapshot` registry key is intended to be used only by applications. Users who attempt to use it encounter limitations such as:
>
> - It can't delete files from a shadow copy that was created on a Windows Server by using the Previous Versions feature.
> - It can't delete files from shadow copies for shared folders.
> - It can delete files from a shadow copy that was created by using the [Diskshadow](../../administration/windows-commands/diskshadow.md) utility, but it can't delete files from a shadow copy that was created by using the [VssAdmin](../../administration/windows-commands/vssadmin.md) utility.
> - Files are deleted from a shadow copy on a best-effort basis. This means that they aren't guaranteed to be deleted.

For more information, see [Excluding Files from Shadow Copies](/windows/win32/vss/excluding-files-from-shadow-copies).

### My non-Microsoft backup program failed with a VSS error. What can I do?

Check the product support section of the web site of the company that created the backup program. There could be a product update that you can download and install to fix the problem. If not, contact the company's product support department.
System administrators can use the VSS troubleshooting information on the following Microsoft TechNet Library web site to gather diagnostic information about VSS-related issues. For more information, see [Volume Shadow Copy Service](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd364794(v=ws.10)).

### What is the *diff area*?

The shadow copy storage area (or diff area) is the location where the data for the shadow copy that's created by the system software provider is stored.

### Where is the diff area located?

The diff area can be located on any local volume. However, it must be located on an NTFS volume that has enough space to store it.

### How is the diff area location determined?

The following criteria are evaluated, in this order, to determine the diff area location:

- If a volume already has an existing shadow copy, that location is used.

- If there's a preconfigured manual association between the original volume and the shadow copy volume location, that location is used.

- If the previous two criteria don't provide a location, the shadow copy service chooses a location based on available free space. If more than one volume is being shadow copied, the shadow copy service creates a list of possible snapshot locations based on the size of free space, in descending order. The number of locations provided is equal to the number of volumes being shadow copied.

- If the volume being shadow copied is one of the possible locations, a local association is created. Otherwise, an association with the volume that has the most available space is created.

### Can VSS create shadow copies of non-NTFS volumes?

Yes. However, persistent shadow copies can be made only for NTFS volumes. In addition, at least one volume mounted on the system must be an NTFS volume.

### What's the maximum number of shadow copies I can create at one time?

The maximum number of shadow copied volumes in a single shadow copy set is 64. This isn't the same as the number of shadow copies.

### What's the maximum number of software shadow copies created by the system provider that I can maintain for a volume?

The maximum number is of software shadow copies for each volume is 512. However, by default, you can only maintain 64 shadow copies that are used by the Shadow Copies of Shared Folders feature. To change the limit for the Shadow Copies of Shared Folders feature, use the following registry key: `MaxShadowCopies`.

### How can I control the space that's used for shadow copy storage space?

Type the `vssadmin resize shadowstorage` command.

For more information, see [Vssadmin resize shadowstorage](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc788050(v=ws.11)).

### What happens when I run out of space?

Shadow copies for the volume are deleted, beginning with the oldest shadow copy.

## VSS tools

The Windows operating system provides the following tools for working with VSS:

- [DiskShadow](../../administration/windows-commands/diskshadow.md)

- [VssAdmin](../../administration/windows-commands/vssadmin.md)

### DiskShadow

DiskShadow is a VSS requester that you can use to manage all the hardware and software snapshots that you can have on a system. DiskShadow includes commands such as:

- `list`: Lists VSS writers, VSS providers, and shadow copies

- `create`: Creates a new shadow copy

- `import`: Imports a transportable shadow copy

- `expose`: Exposes a persistent shadow copy (as a drive letter, for example)

- `revert`: Reverts a volume back to a specified shadow copy

This tool is intended for use by IT professionals, but developers might also find it useful when testing a VSS writer or VSS provider.

DiskShadow is available only on Windows Server operating systems. It isn't available on Windows client operating systems.

### VssAdmin

VssAdmin is used to create, delete, and list information about shadow copies. It can also be used to resize the shadow copy storage area (*diff area*).

VssAdmin includes commands such as:

- `create shadow`: Creates a new shadow copy

- `delete shadows`: Deletes shadow copies

- `list providers`: Lists all registered VSS providers

- `list writers`: Lists all subscribed VSS writers

- `resize shadowstorage`: Changes the maximum size of the shadow copy storage area

VssAdmin can only be used to administer shadow copies that are created by the system software provider.

VssAdmin is available on Windows client and Windows Server operating system versions.

## Volume Shadow Copy Service registry keys

The following registry keys are available for use with VSS:

- `VssAccessControl`

- `MaxShadowCopies`

- `MinDiffAreaFileSize`

### VssAccessControl

This key is used to specify which users have access to shadow copies.

For more information, see:

- [Security Considerations for Writers](/windows/win32/vss/security-considerations-for-writers)

- [Security Considerations for Requesters](/windows/win32/vss/security-considerations-for-requestors)

### MaxShadowCopies

This key specifies the maximum number of client-accessible shadow copies that can be stored on each volume of the computer. Client-accessible shadow copies are used by Shadow Copies of Shared Folders.

For more information, see *MaxShadowCopies* under [Registry Keys for Backup and Restore](/windows/win32/backup/registry-keys-for-backup-and-restore).

### MinDiffAreaFileSize

This key specifies the minimum initial size, in MB, of the shadow copy storage area.

For more information, see *MinDiffAreaFileSize* under [Registry Keys for Backup and Restore](/windows/win32/backup/registry-keys-for-backup-and-restore).

### Supported operating system versions

The following table lists the minimum supported operating system versions for VSS features.

| VSS feature | Minimum supported client | Minimum supported server |
|-------------|--------------------------|--------------------------|
| LUN resynchronization | None supported | Windows Server 2008 R2 |
| `FilesNotToSnapshot` registry key | Windows Vista | Windows Server 2008 |
| Transportable shadow copies | None supported | Windows Server 2003 with SP1 |
| Hardware shadow copies | None supported | Windows Server 2003 |
| Previous versions of Windows Server | Windows Vista | Windows Server 2003 |
| Fast recovery using LUN swap | None supported | Windows Server 2003 with SP1 |
| Multiple imports of hardware shadow copies (This is the ability to import a shadow copy more than once. Only one import operation can be performed at a time.) | None supported | Windows Server 2008 |
| Shadow Copies of Shared Folders | None supported | Windows Server 2003 |
| Transportable auto-recovered shadow copies | None supported | Windows Server 2008 |
| Concurrent backup sessions (up to 64) | Windows XP | Windows Server 2003 |
| Single restore session concurrent with backups | Windows Vista | Windows Server 2003 with SP2 |
| Up to 8 restore sessions concurrent with backups | Windows 7 | Windows Server 2003 R2 |

## Related content

- [Volume Shadow Copy Service in Windows Developer Center](/windows/desktop/vss/volume-shadow-copy-service-overview)
