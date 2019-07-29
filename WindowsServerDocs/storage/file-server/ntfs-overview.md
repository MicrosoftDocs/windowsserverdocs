---
title: NTFS overview
description: An explanation of what NTFS is.
ms.prod: windows-server-threshold 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 06/17/2019
ms.localizationpriority: medium
---
# NTFS overview

>Applies to: Windows 10, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

NTFS—the primary file system for recent versions of Windows and Windows Server—provides a full set of features including security descriptors, encryption, disk quotas, and rich metadata, and can be used with Cluster Shared Volumes (CSV) to provide continuously available volumes that can be accessed simultaneously from multiple nodes of a failover cluster.

To learn more about new and changed functionality in NTFS in Windows Server 2012 R2, see [What's New in NTFS](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn466520(v%3dws.11)). For additional feature information, see the [Additional information](#additional-information) section of this topic. To learn more about the newer Resilient File System (ReFS), see [Resilient File System (ReFS) overview](../refs/refs-overview.md).

## Practical applications

### Increased reliability

NTFS uses its log file and checkpoint information to restore the consistency of the file system when the computer is restarted after a system failure. After a bad-sector error, NTFS dynamically remaps the cluster that contains the bad sector, allocates a new cluster for the data, marks the original cluster as bad, and no longer uses the old cluster. For example, after a server crash, NTFS can recover data by replaying its log files.

NTFS continuously monitors and corrects transient corruption issues in the background without taking the volume offline (this feature is known as [self-healing NTFS](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771388(v=ws.10)), introduced in Windows Server 2008). For larger corruption issues, the Chkdsk utility, in Windows Server 2012 and later, scans and analyzes the drive while the volume is online, limiting time offline to the time required to restore data consistency on the volume. When NTFS is used with Cluster Shared Volumes, no downtime is required. For more information, see [NTFS Health and Chkdsk](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831536(v%3dws.11)).

### Increased security

- **Access Control List (ACL)-based security for files and folders**—NTFS allows you to set permissions on a file or folder, specify the groups and users whose access you want to restrict or allow, and select access type.

- **Support for BitLocker Drive Encryption**—BitLocker Drive Encryption provides additional security for critical system information and other data stored on NTFS volumes. Beginning in Windows Server 2012 R2 and Windows 8.1, BitLocker provides support for device encryption on x86 and x64-based computers with a Trusted Platform Module (TPM) that supports connected stand-by (previously available only on Windows RT devices). Device encryption helps protect data on Windows-based computers, and it helps block malicious users from accessing the system files they rely on to discover the user's password, or from accessing a drive by physically removing it from the PC and installing it on a different one. For more information, see [What's new in BitLocker](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn306081(v%3dws.11)).

- **Support for large volumes**—NTFS can support volumes as large as 256 terabytes. Supported volume sizes are affected by the cluster size and the number of clusters. With (2<sup>32</sup> – 1) clusters (the maximum number of clusters that NTFS supports), the following volume and file sizes are supported.

  |Cluster size|Largest volume|Largest file|
  |---|---|---|
  |4 KB (default size)|16 TB|16 TB|
  |8 KB|32 TB|32 TB|
  |16 KB|64 TB|64 TB|
  |32 KB|128 TB|128 TB|
  |64 KB (maximum size)|256 TB|256 TB|

>[!IMPORTANT]
>Services and apps might impose additional limits on file and volume sizes. For example, the volume size limit is 64 TB if you’re using the Previous Versions feature or a backup app that makes use of Volume Shadow Copy Service (VSS) snapshots (and you’re not using a SAN or RAID enclosure). However, you might need to use smaller volume sizes depending on your workload and the performance of your storage.

### Formatting requirements for large files

To allow proper extension of large .vhdx files, there are new recommendations for formatting volumes. When formatting volumes that will be used with Data Deduplication or will host very large files, such as .vhdx files larger than 1 TB, use the **Format-Volume** cmdlet in Windows PowerShell with the following parameters.

|Parameter|Description|
|---|---|
|-AllocationUnitSize 64KB|Sets a 64 KB NTFS allocation unit size.|
|-UseLargeFRS|Enables support for large file record segments (FRS). This is needed to increase the number of extents allowed per file on the volume. For large FRS records, the limit increases from about 1.5 million extents to about 6 million extents.|

For example, the following cmdlet formats drive D as an NTFS volume, with FRS enabled and an allocation unit size of 64 KB.

```PowerShell
Format-Volume -DriveLetter D -FileSystem NTFS -AllocationUnitSize 64KB -UseLargeFRS
```

You also can use the **format** command. At a system command prompt, enter the following command, where **/L** formats a large FRS volume and **/A:64k** sets a 64 KB allocation unit size:

```PowerShell
format /L /A:64k
```

### Maximum file name and path

NTFS supports long file names and extended-length paths, with the following maximum values:

- **Support for long file names, with backward compatibility**—NTFS allows long file names, storing an 8.3 alias on disk (in Unicode) to provide compatibility with file systems that impose an 8.3 limit on file names and extensions. If needed (for performance reasons), you can selectively disable 8.3 aliasing on individual NTFS volumes in Windows Server 2008 R2, Windows 8, and more recent versions of the Windows operating system.
  In Windows Server 2008 R2 and later systems, short names are disabled by default when a volume is formatted using the operating system. For application compatibility, short names still are enabled on the system volume.

- **Support for extended-length paths**—Many Windows API functions have Unicode versions that allow an extended-length path of approximately 32,767 characters—beyond the 260-character path limit defined by the MAX\_PATH setting. For detailed file name and path format requirements, and guidance for implementing extended-length paths, see [Naming Files, Paths, and Namespaces](https://msdn.microsoft.com/library/windows/desktop/aa365247).

- **Clustered storage**—When used in failover clusters, NTFS supports continuously available volumes that can be accessed by multiple cluster nodes simultaneously when used in conjunction with the Cluster Shared Volumes (CSV) file system. For more information, see [Use Cluster Shared Volumes in a Failover Cluster](../../failover-clustering/failover-cluster-csvs.md).

### Flexible allocation of capacity

If the space on a volume is limited, NTFS provides the following ways to work with the storage capacity of a server:

- Use disk quotas to track and control disk space usage on NTFS volumes for individual users.
- Use file system compression to maximize the amount of data that can be stored.
- Increase the size of an NTFS volume by adding unallocated space from the same disk or from a different disk.
- Mount a volume at any empty folder on a local NTFS volume if you run out of drive letters or need to create additional space that is accessible from an existing folder.

## Additional information

- [Cluster size recommendations for ReFS and NTFS](https://techcommunity.microsoft.com/t5/Storage-at-Microsoft/Cluster-size-recommendations-for-ReFS-and-NTFS/ba-p/425960)
- [Resilient File System (ReFS) overview](../refs/refs-overview.md)
- [What's New in NTFS](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn466520(v%3dws.11)) (Windows Server 2012 R2)
- [What's New in NTFS](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff383236(v=ws.10)) (Windows Server 2008 R2, Windows 7)
- [NTFS Health and Chkdsk](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831536(v%3dws.11))
- [Self-Healing NTFS](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771388(v=ws.10)) (introduced in Windows Server 2008)
- [Transactional NTFS](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc730726(v%3dws.10)) (introduced in Windows Server 2008)
- [Storage in Windows Server](../storage.md)