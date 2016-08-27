---
title: Understanding Data Deduplication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
author: wmgries
manager: eldenc
ms.author: wgries
--- 

# Understanding Data Deduplication
> Applies to Windows Server 2016

This document describes how [Data Deduplication](overview.md) works. 

## <a name="how-does-dedup-work"></a>How does Data Deduplication work?
Data Deduplication in Windows Server was created with the following two principles:

1. **Optimization should not get in the way of writes to the disk**  
	This means that Data Deduplication optimizes data using a post-processing model; all data is written unoptimized to the disk, and then optimized later by Data Deduplication.

2. **Optimization should not change access semantics**  
	This means that users and applications that access data on an optimized volume are completely unaware that the files they are accessing have been deduplicated. 

Once enabled for a volume, Data Deduplication runs in the background to identify repeated patterns across files on that volume and to seamlessly move those portions, or chunks, with special pointers called [reparse points](#dedup-term-reparse-point) that point to a unique copy of that chunk. This occurs in the following four steps:

1. Scan file system for files eligible per policy for optimization.  
![Scan file system](media/understanding-dedup-how-dedup-works-1.gif)  
2. Break files into variable-size chunks.  
![Break files into chunks](media/understanding-dedup-how-dedup-works-2.gif)
3. Identify unique chunks.  
![Identify unique chunks](media/understanding-dedup-how-dedup-works-3.gif)
4. Place chunks in the chunk store and optionally compress.  
![Move to Chunk Store](media/understanding-dedup-how-dedup-works-4.gif)
5. Replace the original file stream of now optimized files with a reparse point to the chunk Store.  
![Replace file stream with reparse point](media/understanding-dedup-how-dedup-works-5.gif)

When optimized files are read, the file system hands off the files with a reparse point to the Data Deduplication file system filter (Dedup.sys), which redirects the read operation to the appropriate chunks in the chunk store that constitute the stream for that file. If/when a modifications are made to ranges of a deduplicated file, those modifications get written unoptimized to the disk and are optimized by the by the [Optimization job](understand.md#usage-type-optimization) the next time it runs.

## <a id="usage-type"></a>Usage Types
The following Usage Types provide reasonable Data Deduplication configuration for common workloads:  

| Usage Type | Ideal Workloads | What's Different |
|------------|-----------------|------------------|
| <a id="usage-type-default"></a>Default | General purpose file server:<ul><li>Team shares</li><li>Work Folders</li><li>Folder redirection</li><li>Software development shares</li></ul> | <ul><li>Background Optimization</li><li>Default optimization policy:<ul><li>Minimum File Age = 3 days</li><li>Optimize in-use files = No</li><li>Optimize partial files = No</li></ul></li></ul> |
| <a id="usage-type-hyperv"></a>Hyper-V | Virtualized Desktop Infrastructure (VDI) servers | <ul><li>Background Optimization</li><li>Default optimization policy:<ul><li>Minimum File Age = 3 days</li><li>Optimize in-use files = Yes</li><li>Optimize partial files = Yes</li></ul></li><li>"Under-the-hood" tweaks for Hyper-V interop</li></ul> |
| <a id="usage-type-backup"></a>Backup | Virtualized Backup Applications, such as [Microsoft Data Protection Manager (DPM)](https://technet.microsoft.com/library/hh758173.aspx) | <ul><li>Priority Optimization</li><li>Default optimization policy:<ul><li>Minimum File Age = 0 days</li><li>Optimize in-use files = Yes</li><li>Optimize partial files = No</li></ul></li><li>"Under-the-hood" tweaks for interop with DPM/DPM-like solutions</li></ul> |

## <a id="job-info"></a>Jobs
Data Deduplication, uses a post-processing strategy to optimize and maintain a volume's space efficiency. 

| Job Name | Job Descriptions | Default Schedule |
|----------|------------------|------------------|
| <a id="job-info-optimization"></a>Optimization | The **Optimization** job deduplicates by chunking data on a volume per the volume policy settings, (optionally) compressing those chunks, and storing chunks uniquely in the Chunk Store. The optimization process that Data Deduplication uses is described in detail [above](understand.md#how-does-dedup-work). | Once every hour |
| <a id="job-info-gc"></a>Garbage Collection | The **Garbage Collection** job is responsible for reclaiming disk space by removing unnecessary chunks that are no longer being referenced by files that have been recently modified or deleted. | Every Saturday at 2:35 am. |
| <a id="job-info-scrubbing"></a>Integrity Scrubbing | The **Integrity Scrubbing** job is responsible for identifiying corruption in the chunk store due to disk failures or bad sectors. When possible, Data Deduplication can automatically use volume features (such as mirror or parity on a Storage Spaces volume) to reconstruct the corrupted data. Additionally, Data Deduplication keeps backup copies of popular chunks when they are referenced over 100 times in an area called the hotspot. | Every Saturday at 3:35 am. |
| <a id="job-info-unoptimization"></a>Unoptimization | The **Unoptimization** job is a special job that can only be run manually that undoes the optimization done by deduplication and disables Data Deduplication for that volume. | [On-demand only](run.md#disabling-dedup) |

## <a id="dedup-term"></a>Data Deduplication Terminology
| Term | Definition |
|------|------------|
| <a id="dedup-term-chunk"></a>Chunk | A chunk is a section of a file that has been selected by the Data Deduplication chunking algorithm as likely to occur in other, similiar files. |
| <a id="dedup-term-chunk-store"></a>Chunk store | The chunk store is an organized series of container files in the System Volume Information folder that Data Deduplication uses to uniquely store chunks. |
| <a id="dedup-term-dedup"></a>Dedup | An abbrevation for Data Deduplication commonly used in PowerShell, Windows Server APIs and components, and in common usage in the Windows Server community. |
| <a id="dedup-term-file-metadata"></a>File metadata | Every file contains metadata that describe interesting properties about the file that are not related to the main content of the file. For instance, Date Created, Last Read Date, Author, etc. |
| <a id="dedup-term-file-stream"></a>File stream | The file stream is the main content of the file. This is the part of the file that Data Deduplication optimizes. |
| <a id="dedup-term-file-system"></a>File system | The file system is the software and on-disk data structure that allow the operating system to store files on storage media. Data Deduplication is supported on NTFS formatted volumes. | 
| <a id="dedup-term-file-system-filter"></a>File system filter | A file system filter is a plugin that modifies the default behavior of the file system. In order to preserve access semantics, Data Deduplication uses a file system filter (Dedup.sys) to redirect reads to optimized content completely transparently to the user/application making the read request. |
| <a id="dedup-term-optimization"></a>Optimization | A file is considered optimized (or deduplicated) by Data Deduplication if it has been chunked and its unique chunks have been stored in the chunk store. |
| <a id="dedup-term-in-policy"></a>Optimization policy | The optimization policy specifies which files should be considered for Data Deduplication. For example, files may be considered out-of-policy if they are brand new, open, in a certain path on the volume, or are of a certain file type. |
| <a id="dedup-term-reparse-point"></a>Reparse point | A [reparse point](https://msdn.microsoft.com/library/windows/desktop/aa365503.aspx) is a special tag that notifies the file system to pass off IO to a specified file system filter. When a file's file stream has been optimized, Data Deduplication replaces the file stream with a reparse point, which allows Data Deduplication to preserve the access semantics for that file. |
| <a id="dedup-term-volume"></a>Volume | A volume is a Windows construct for a logical storage drive that may span multiple physical storage devices across a one or more servers. Deduplication is enabled on a volume by volume basis. |
| <a id="dedup-term-workload"></a>Workload | A workload is an application that runs on Windows Server. Example workloads include general purpose file server, Hyper-V, and SQL Server. |

> [!Warning]  
> Unless instructed by authorized Microsoft Support Personnel, do not attempt to manually modify the chunk store. Doing so may result in data corruption and/or loss.

## Frequently Asked Questions
**How does Data Deduplication differ from other optimization products?**  
There are several important differences between Data Deduplication, and other common storage optimization products:

* *How does Data Deduplication differ from Single Instance Store?*  
	Single Instance Store, or SIS, was a predecessor technology to Data Deduplication first introduced in Windows Storage Server 2008 R2. Single Instance Store optimized a volume by identifying files that were completely identical and replacing them with logical links to a single copy of a file stored in the SIS common store. Unlike Single Instance Store, Data Deduplication can get space savings from files that are not identical but share many common patterns and from files which themselves contain many repeated patterns. Single Instance Store was deprecated in Windows Server 2012 R2 and removed in Windows Server 2016 in favor of Data Deduplication.

* *How does Data Deduplication differ from NTFS compression?*  
	NTFS compression is a feature of NTFS that can be optionally enabled at the volume level. With NTFS compression, each individual file is optimized individually via compression at write-time. Unlike NTFS compression, Data Deduplication can get spacing savings across all the files on a volume. This is advantageous over NTFS compression because files may have <u>both</u> internal duplication (which is addressed by NTFS compression) and have similarities with other files on the volume (which is not addressed by NTFS compression). Additionally, Data Deduplication has a post-processing model, which means that new files (or modifications to existing files), will be written to disk unoptimized and will be optimized later on by Data Deduplication.

* *How does Data Deduplication differ from archive file formats like zip, rar, 7z, cab, etc?*  
	Archive file formats like zip, rar, 7z, cab, etc perform compression over a specified set of files. Like Data Deduplication, this means that both duplicated patterns within files and duplicated patterns across files are optimized, however this requires manual intervention, in the form of choosing which files should be included in the archive, and changes the access semantics, because now accessing a specific file within the archive means opening the archive, selecting the specific file desired, and decompressing that file for use. Data Deduplication operates transparently to users and administrators, and requires no manual kick-off. Additionally, Data Deduplication preserves access semantics - optimized files appear unchanged after optimization.

**Can I change the Data Deduplication settings for my selected Usage Type?**  
Yes, although Data Deduplication provides reasonable defaults for **Recommended workloads**, you may still find it desirable to tweak Data Deduplication settings to get the most out of your storage. Additionally, other workloads will [require some tweaking to ensure that Data Deduplication does not interfere with the workload](install-enable.md#enable-dedup-sometimes-considerations).

**Can I manually run a Data Deduplication job?**  
Yes, [all Data Deduplication jobs may be run manually](run.md#running-dedup-jobs-manually). This may be desirable if scheduled jobs did not run due to insufficient system resources or because of an error. Additionally, the Unoptimization job can only be run manually.

**Can I monitor the historical outcomes of Data Deduplication jobs?**  
Yes, [all Data Deduplication jobs make entries in the Windows Event Log](run.md#monitoring-dedup).

**Can I change the default schedules for the Data Deduplication jobs on my system?**  
Yes, [all schedules are configurable](advanced-settings.md#modifying-job-schedules). Modifying the default Data Deduplication schedules is particularly desirable to ensure that the Data Deduplication jobs have time to finish and do not compete for resources with the workload.