---
title: NTFS overview
description: Learn how NTFS provides a full set of features including security descriptors, encryption, disk quotas, and rich metadata in Windows.
ms.topic: concept-article
author: dknappettmsft
ms.author: daknappe
ms.date: 06/17/2025
---

# NTFS overview

New Technology File System (NTFS) is the default file system for modern Windows-based operating system (OS). It provides advanced features, including security descriptors, encryption, disk quotas, and support for rich metadata, enhancing both security and data management. Additionally, NTFS seamlessly integrates with Cluster Shared Volumes (CSV), allowing highly available storage that multiple nodes in a failover cluster can access concurrently. This integration ensures continuous data availability and resilience.

## Increased reliability

NTFS enhances reliability by maintaining a transaction-based log file and checkpoint information. If a system failure occurs, NTFS uses this log to automatically restore file system consistency during the next startup, minimizing the risk of data loss. When a bad sector is detected, NTFS dynamically remaps the affected cluster to a healthy one, marks the original cluster as unusable, and ensures that data is preserved. For example, after a system crash, NTFS can recover changes by replaying its transaction log, helping to maintain data integrity and reduce downtime.

NTFS includes a feature called [self-healing NTFS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771388(v=ws.10)), which automatically detects and repairs minor file system corruption in the background, without requiring the volume to be taken offline. This proactive approach helps maintain data integrity and minimizes disruptions to users and applications.

For more significant file system corruption, the `chkdsk` utility can scan and repair NTFS volumes while keeping them online, minimizing downtime. The only period the volume might be unavailable is during the phase required to restore data consistency. When NTFS is used with CSV, repairs can be performed without any downtime, ensuring continuous availability. To learn more, see [NTFS Health and Chkdsk](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831536(v%3dws.11)).

## Increased security

- **Granular access control with ACLs**: NTFS enables you to assign detailed permissions to files and folders using Access Control Lists (ACLs). You can specify which users and groups have access, define the type of access such as read, write, or modify, and tailor security to meet organizational requirements.

- **Integrated BitLocker Drive Encryption support**: NTFS works seamlessly with BitLocker Drive Encryption to safeguard sensitive data on volumes. BitLocker applies hardware-based security features like the Trusted Platform Module (TPM) to provide device encryption, protecting data even if a drive is removed and installed in another system. This helps prevent unauthorized access to both user data and critical system files. To learn more, see [BitLocker overview](/windows/security/operating-system-security/data-protection/bitlocker).

## Support for large volumes

NTFS supports large volumes with maximum sizes determined by both the Windows version and the chosen cluster size. On Windows Server 2019 and later, and Windows 10 version 1709 and later, NTFS volumes can be as large as 8 petabytes (PB). Earlier versions of Windows support volumes up to 256 terabytes (TB). The actual maximum volume and file size depends on the cluster size and the total number of clusters supported by NTFS (up to 2<sup>32</sup> – 1 clusters). The following table summarizes the largest supported volume and file sizes for each cluster size:

| Cluster size | Largest volume and file |
|--|--|
| 4 KB (default size) | 16 TB |
| 8 KB | 32 TB |
| 16 KB | 64 TB |
| 32 KB | 128 TB |
| 64 KB (earlier max) | 256 TB |
| 128 KB | 512 TB |
| 256 KB | 1 PB |
| 512 KB | 2 PB |
| 1024 KB | 4 PB |
| 2048 KB (max size) | 8 PB |

If you try to mount a volume with a cluster size larger than the supported maximum of the Windows version you're using, you get the error **STATUS_UNRECOGNIZED_VOLUME**.

> [!IMPORTANT]
> Some services and applications might enforce their own limits on file and volume sizes. For instance, when using the **Previous Versions** feature or backup applications that rely on Volume Shadow Copy Service (VSS) snapshots (without a SAN or RAID enclosure), the maximum supported volume size is 64 TB. Depending on your workload and storage performance, you might need to use smaller volumes.

## Formatting requirements for large files

To allow proper extension of large `.vhdx` files, there are new recommendations for formatting volumes. When formatting volumes that you use with Data Deduplication or that host large files, such as `.vhdx` files larger than 1 TB, use the [Format-Volume](/powershell/module/storage/format-volume) cmdlet with the following parameters:

```powershell
Format-Volume -DriveLetter <DriveLetter> -FileSystem NTFS -AllocationUnitSize 65536 -UseLargeFRS
```

In this example, the **AllocationUnitSize** parameter sets the allocation unit size to 64 KB (65,536 bytes), and **UseLargeFRS** enables support for large file record segments.

You also can run the `format` command in an elevated command prompt where `/L` formats a large File Record Segment (FRS) volume and `/A:64k` sets a 64 KB allocation unit size:

```cmd
format <DriveLetter> /l /a:64k
```

## Maximum file name and path

NTFS supports long file names and extended-length paths, with the following maximum values:

- **Support for long file names, with backward compatibility**: NTFS supports long file names, storing an 8.3 alias on disk (in Unicode) to provide compatibility with file systems that impose an 8.3 limit on file names and extensions. If needed, for performance reasons, you can selectively disable 8.3 aliasing on individual NTFS volumes in Windows Server 2008 R2, Windows 8, and more recent versions of the Windows OS. In Windows Server 2008 R2 and later systems, short names are disabled by default when a volume is formatted using the OS. For application compatibility, short names still are enabled on the system volume.

- **Support for extended-length paths**: Many Windows API functions have Unicode versions that allow an extended-length path of approximately 32,767 characters. That total is beyond the 260-character path limit defined by the MAX\_PATH setting. For detailed file name and path format requirements, and guidance for implementing extended-length paths, see [Naming files, paths, and namespaces](/windows/win32/fileio/naming-a-file).

- **Clustered storage**: When used in failover clusters, NTFS supports continuously available volumes that can be accessed by multiple cluster nodes simultaneously when used with the CSV file system. To learn more, see [Use Cluster Shared Volumes in a failover cluster](../../failover-clustering/failover-cluster-csvs.md).

## Flexible allocation of capacity

If the space on a volume is limited, NTFS provides the following ways to work with the storage capacity of a server:

- Use disk quotas to track and control disk space usage on NTFS volumes for individual users.
- Use file system compression to maximize the amount of data that can be stored.
- Increase the size of an NTFS volume by adding unallocated space from the same disk or from a different disk.
- Mount a volume at any empty folder on a local NTFS volume if you run out of drive letters or need to create extra space that is accessible from an existing folder.

## See also

- [Windows Server Storage documentation](../storage.yml)
- [Cluster size recommendations for ReFS and NTFS](https://techcommunity.microsoft.com/t5/Storage-at-Microsoft/Cluster-size-recommendations-for-ReFS-and-NTFS/ba-p/425960)
- [Resilient File System (ReFS) overview](../refs/refs-overview.md)
- [What's New in NTFS for Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn466520(v%3dws.11)) (Windows Server 2012 R2)
- [What's New in NTFS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ff383236(v=ws.10)) (Windows Server 2008 R2, Windows 7)
- [About Transactional NTFS](/windows/win32/fileio/about-transactional-ntfs)

