---
title: Backup and Restore Considerations for Deduplicated Volumes
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 817aee89-b74c-4945-b865-c3f767a87f0e
---
# Backup and Restore Considerations for Deduplicated Volumes
One of the benefits of deduplication is that by reducing the used space on a data volume, it makes backing up that volume faster, which enables longer retention times, greater efficiency to the backup storage target, and quicker restoration operations.

Block\-based backup applications should work without modification, and they maintain the optimization on the backup media. File\-based backup operations that do not use deduplication usually copy the files in their original form. If an administrator is using XCOPY, for instance, the restoration happens in memory during the backup copy operation. The backup target must be large enough to hold the logical size of the entire dataset because none of the deduplication is retained.

> [!CAUTION]
> Do not attempt to manually back up  the reparse points and the deduplication chunk\-store files that are located in the hidden Sysvol folder by using Robocopy. Data Deduplication may be modifying data, and this could cause data loss.

## <a name="BKMK_OVER"></a>Windows Server Backup
Windows Server Backup has the ability to back up an optimized volume “as\-is” \(that is, without removing deduplicated data\). The following examples show how to back up a volume and how to restore a volume or selected files from a volume.

1.  Install Windows Server Backup by running the following Windows PowerShell command:

    ```
    PS C:\> Add-WindowsFeature -name Windows-Server-Backup
    ```

2.  To back up the E: volume to another volume, run the following from a command prompt, substituting the correct volume names for your situation:

    ```
    C:\> wbadmin start backup –include:E: -backuptarget:F: -quiet
    ```

3.  Get the version ID of the backup you just created:

    ```
    C:\> wbadmin get versions
    ```

    This output version ID will be a date and time string, for example: 02\/16\/2012\-06:22.

4.  Restore the entire volume:

    ```
    C:\> Wbadmin start recovery –version:02/16/2012-06:22 -itemtype:Volume  -items:E: -recoveryTarget:E:
    ```

5.  Restore a particular folder \(in this case, the E:\\Docs folder\):

    ```
    C:\> Wbadmin start recovery –version:02/16/2012-06:22 -itemtype:File  -items:E:\Docs  -recursive
    ```

## Optimized backup considerations
Performing an optimized backup results in a smaller, faster backup. The backup is smaller because the total size of the optimized files, non\-optimized files \(files that are not included in policies\), and data deduplication chunk store files are significantly smaller than the full logical size of the volume \(that is, the size of all the files before deduplication\). Optimized backups are faster because there is less I\/O and because the optimized files are not restoredrehydrated during the file copy operations. Selective backup \(in which most of the volume is being backed up\) may also benefit from using the optimized backup approach if the logical size of the selected files is significantly greater than the physical size of the optimized files plus the chunk store container files.

## Incremental optimized backup considerations
A backup application can perform an incremental optimized backup as follows:

-   Back up only the changed user files, including reparse points that were created, modified, or deleted since the previous backup.

-   Back up the changed chunk store container files. \(Because new chunks are appended to the current chunk store container, when its size reaches about 1 GB, that container file is sealed and a new container file is created.\)

-   Perform an incremental backup at the sub\-file level. \(You can back up file ranges instead of entire files for large files that rarely change\).

## Full volume restore from optimized backup
File\-level full volume restore should be performed in an optimized manner by essentially reversing the procedure described earlier. The complete set of data deduplication metadata and container files are restored, then the complete set of data deduplication reparse points are restored, followed by restoration of all non\-deduplicated files.

Restoring volumes in this manner provides faster recovery time \(compared to full\-volume restore from a non\-optimized backup store\) because the amount of copied data is much smaller. Also the size of the restored data in an optimized full\-volume restore fits on the original size volume. Restoring to the original or an equivalently sized volume from a non\-optimized backup will likely fill the disk because the files will be replaced at their full logical \(non\-deduplicated\) size.

Block\-level restore from an optimized backup is automatically an optimized restore because the restore process occurs under Data Deduplication, which works at the file level.

> [!NOTE]
> We recommend that you always perform a full volume restore to the original reformatted volume or to a freshly formatted volume of equivalent or greater size.

## Selective restore from an optimized backup
Selective restore from an optimized backup can be done by using one of the following approaches:

-   Partial volume restore to a newly formatted volume

-   Restore from a \-backup store that allows data deduplication by using a backup application that supports the selective restore API provided by Data Deduplication

### Selective partial volume restore to a newly formatted volume
This approach is similar to the file\-level, full\-volume restore described earlier \(only a subset of the data deduplication reparse points are restored to a freshly formatted volume\).

> [!NOTE]
> With this approach, the entire set of data deduplication metadata and container files are copied to the new volume.

This approach is appropriate if most of the volume is being restored, and only when there are portions of the volume that are not required on the restored volume. The application can make a calculated decision about whether this is an appropriate technique by comparing the size of the data deduplication store files plus the physical size of all of the restored files to the total logical size of the target restore file set.

### Selective restore from a backup store that allows data deduplication
If the backup store is located on a volume that is enabled for data deduplication, the backup store and the original volume are optimized. In this case, the backup application can copy the files as normal files back to the target volume. The files are restored in memory from the backup store, so the application is subjected to increased I\/O latency while it is reading the backup store.

If the file on the target volume is missing, or if it has been fully recalled from the data deduplication store, there will be no increased latency on the target volume. However, to be sure, it is a good practice to first delete the file \(if it exists\) from the target volume before you restore the file with this approach.

## Non\-optimized backup and restore
In non\-optimized backup and restore, the backup application does not use the Data Deduplication backup and restore API. Instead, the backup application opens the files and copies them without specifying the reparse point flag.

The optimized files are coped to the backup volume as normal files, not as optimized files. The conversion from optimized files to normal files is performed transparently in memory by Data Deduplication when the backup application copies the files. Restoring from such a backup store is a normal file\-copy operation.

The size of the data in a non\-optimized backup is normally much larger than the original optimized volume because of the space savings that is provided by deduplication. A full volume restore from a non\-optimized backup will usually not fit on the original or an equivalently sized volume.

Non\-optimized backup is normally used only for the following situations:

-   To selectively back up a small percentage of the files on the volume, where the logical size of the selected files is significantly smaller than the physical size of the optimized files plus the chunk store container files.

-   To support restoring a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] backup to an earlier version of the Windows Server operating system.

-   To support restoring a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] backup to a computer that is not running Windows Server.

## Incremental non\-optimized backup
A backup application can perform an incremental optimized backup as follows:

-   To back up changed user files

-   To skip reparse point changes


