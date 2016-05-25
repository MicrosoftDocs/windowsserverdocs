---
title: DFS Replication: Copying Files to Preseed or Stage Initial Synchronization
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fef2ead7-ad48-4d71-9b6e-4b8a2b266387
author: JasonGerend
---
# DFS Replication: Copying Files to Preseed or Stage Initial Synchronization
The topics in this guide describe how to preseed files for Distributed File System \(DFS\) Replication \(also known as DFSR or DFS\-R\) to speed up initial synchronization when you set up DFS Replication, add a new replication partner, or replace a server. Preseeding is required when you set up the database cloning feature, which was introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Distributed File System Replication synchronizes files between two or more servers. When you set up replication, the initial synchronization time drops significantly if DFS Replication can use files that are already in place on the destination volume.  
  
DFS Replication was introduced in Windows Server 2003 R2. Methods described in this guide can be used to preseed files for DFS Replication from servers running Windows Server 2003 R2 and later operating systems to any server that supports DFS Replication, including servers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Not all methods support all of these operating systems; for guidance, see [Comparison of Tools](#BKMK_ComparisonofTools), later in this topic. The methods can be used to preseed files from folders that are already replicated through DFS Replication or folders that will be replicated for the first time.  
  
> [!NOTE]  
> This guide assumes that you have a basic knowledge of DFS Replication. For more information, see [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md).  
  
## Overview of preseeding files for DFS Replication  
DFS Replication is a state\-based, multi\-master file replication service that uses a database and the NTFS USN journal to track file changes. In its simplest configuration, two servers communicate with each other bidirectionally \(writable\) or unidirectionally \(Read\-only\). For an individual file update operation, each server can operate in an upstream or downstream fashion.  
  
When configuring replication on the second – and subsequent – servers, DFS Replication completes a two\-phase process:  
  
-   **Phase 1: Initial build** – DFS Replication scans all existing files and folders in the replicated folder and adds a record for each one to the database.  
  
-   **Phase 2: Initial sync** – DFS Replication exchanges replicated file metadata \- such as each file hash, unique identifier, and global version sequence number – with its partner server. Inbound, the downstream \(destination\) server replicates any missing files or files that have a different hash from the file on the upstream \(source\) server. If DFS Replication finds any files that have a matching hash on the same relative path on both servers, the file is not replicated downstream.  
  
When you preseed file data on the downstream server, DFS Replication does not have to replicate those files inbound during initial synchronization. For larger data sets, this can save significant setup time and allow DFS Replication faster entry into the normal replication state, in which only new, changed, or modified files are replicated between servers.  
  
> [!NOTE]  
> To speed up initial synchronization when you add a new replication partner or replace a server in an existing DFS Replication setup, you can preseed the replicated folder on the destination server and then export a clone of the DFS Replication database. If you both preseed the replicated folder and export a database clone, members of a replication group do not have to exchange files or metadata during replication setup. For more information about this feature, introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [Export a Clone of the DFS Replication Database](../Topic/Export-a-Clone-of-the-DFS-Replication-Database.md).  
  
For preseeding to work, however, you must copy files from the upstream servers to the downstream servers without changing their file hashes. A file hash created by DFS Replication incorporates the data stream, the alternate data stream, and the access control list \(ACL\) applied directly to that file. This ensures that any aspect of file changes replicates to all other nodes. Incorrectly preseeding files on a downstream server leads to slower replication than not preseeding, because DFS Replication takes the additional step of verifying every existing file, but then must discard and replicate each file.  
  
## <a name="BKMK_ComparisonofTools"></a>Comparison of tools  
The tool that is best suited for your environment depends on the environment, the operating systems on the source and destination servers, and the nature and size of the data sets that you want to preseed for DFS Replication. The following table compares three tools that can be used for preseeding: Robocopy, Windows Server Backup, and NTBackup. This guide provides step\-by\-step procedures for preseeding files with each of these tools.  
  
|Preseeding tool|Advantages|Limitations|  
|-------------------|--------------|---------------|  
|Robocopy|-   Copies files directly from the source directory to the destination directory.<br />-   Can be used to preseed files from Windows Server 2003 R2 and later, through [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].|-   Cannot copy files with exclusive locks. To effectively preseed, you must stabilize files on the source computer before copying begins.<br />-   Requires manual installation of the correct Robocopy version for the source or destination operating system.|  
|Windows Server Backup|-   Easily installed feature of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].<br />-   Copies files with exclusive locks.|-   Requires backing up to an interim storage location.<br />-   Cannot be used to preseed files from Windows Server 2003 R2. \(Must be installed on both the source and destination server.\)<br />-   On a source server running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server Backup can only back up volumes, not individual folders. However, individual folders can be restored.|  
|Windows NTBackup|-   If you are accustomed to using NTBackup, provides a familiar tool for preseeding files from Windows Server 2003 R2 for DFS Replication in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].<br />-   Copies files with exclusive locks.|-   Requires backing up to an interim storage location.<br />-   Cannot be used to preseed files for DFS Replication in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].|  
  
Additional preseeding methods might be available for your storage devices and accompanying storage software:  
  
-   **Hardware options** \- Some SAN and NAS devices allow synchronous or snapshot\-based data duplication mirroring onto another volume. For example, you might be able to copy a volume currently in use on the source server to a new volume attached to the destination server. Because the new volume is a block\-level image of the previous volume, the data and files should be perfectly preseeded.  
  
    > [!NOTE]  
    > Be aware that Storage Spaces in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] does not allow creation of new volumes using mirror disks that were evicted from a previous storage pool.  
  
-   **Third\-party software options** \- Your backup or storage software vendors might offer additional options for preseeding files. Review documentation from your vendor for more information.  
  
> [!IMPORTANT]  
> If you plan to preseed data by using any non\-Microsoft solution, you should test the solution and then validate the preseeded data on the destination server to ensure that the file hashes are identical on the source and destination servers. For more information, see [Step 2: Validate Preseeded Files for DFS Replication](../Topic/Step-2--Validate-Preseeded-Files-for-DFS-Replication.md).  
  
## In this guide  
This guide provides detailed instructions for preseeding files for DFS Replication, validating the preseeded files, and troubleshooting any issues that occur during preseeding:  
  
-   [Step 1: Preseed Files for DFS Replication](../Topic/Step-1--Preseed-Files-for-DFS-Replication.md)  
  
    -   [Use Robocopy to Preseed Data for DFS Replication](assetId:///3222139a-4f85-4111-9e74-52befb6fedbc)  
  
    -   [Use Windows Server Backup to Preseed Files for DFS Replication](../Topic/Use-Windows-Server-Backup-to-Preseed-Files-for-DFS-Replication.md)  
  
    -   [Use Windows NTBackup to Preseed Files for DFS Replication](../Topic/Use-Windows-NTBackup-to-Preseed-Files-for-DFS-Replication.md)  
  
-   [Step 2: Validate Preseeded Files for DFS Replication](../Topic/Step-2--Validate-Preseeded-Files-for-DFS-Replication.md)  
  
-   [Troubleshoot Preseeding for Initial Synchronization in DFS Replication](../Topic/Troubleshoot-Preseeding-for-Initial-Synchronization-in-DFS-Replication.md)  
  
## Additional resources  
  
|Content type|References|  
|----------------|--------------|  
|Product evaluation|[What's New in DFS Replication in Windows Server 2012 R2](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601) &#124; [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md)|  
|Operations|[DFS Replication help and basic operational guidance](http://technet.microsoft.com/library/cc770278.aspx) &#124; [DFS Replication: Frequently Asked Questions \(FAQ\)](http://technet.microsoft.com/library/cc773238.aspx) &#124; [Robocopy \[LH\]](../Topic/Robocopy.md) \(command\-line reference\) &#124; [Windows Server Backup Step\-by\-Step Guide for Windows Server 2008 R2](http://technet.microsoft.com/library/ee849849(v=ws.10).aspx) &#124; [Windows Server Backup Step\-by\-Step Guide for Windows Server 2008](http://technet.microsoft.com/library/cc770266(v=ws.10).aspx) &#124; [Export a Clone of the DFS Replication Database](../Topic/Export-a-Clone-of-the-DFS-Replication-Database.md)|  
|Community resources|[The File Services and Storage TechNet Forum](http://social.technet.microsoft.com/Forums/windowsserver/en-US/home?forum=winserverfiles) &#124; [Storage Team at Microsoft \- File Cabinet Blog](http://blogs.technet.com/b/filecab/) &#124; [Ask the Directory Services Team blog](http://blogs.technet.com/b/askds/) &#124; [DFS Replication: Survival Guide \(TechNet Wiki\)](http://social.technet.microsoft.com/wiki/contents/articles/438.dfs-replication-survival-guide.aspx) &#124; [Windows Server Information Experience on Twitter](https://twitter.com/windowsserver)|  
  
