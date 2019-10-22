---
title: Use Robocopy to preseed files for DFS Replication
description: How to use Robocopy.exe to preseed files for DFS Replication.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 05/18/2018
ms.localizationpriority: medium
---
# Use Robocopy to preseed files for DFS Replication

>Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

This topic explains how to use the command-line tool, **Robocopy.exe**, to preseed files when setting up replication for Distributed File System (DFS) Replication (also known as DFSR or DFS-R) in Windows Server. By preseeding files before you set up DFS Replication, add a new replication partner, or replace a server, you can speed up initial synchronization and enable cloning of the DFS Replication database in Windows Server 2012 R2. The Robocopy method is one of several preseeding methods; for an overview, see [Step 1: preseed files for DFS Replication](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn495046(v%3dws.11)>).

The Robocopy (Robust File Copy) command-line utility is included with Windows Server. The utility provides extensive options that include copying security, backup API support, retry capabilities, and logging. Later versions include multi-threading and un-buffered I/O support.

>[!IMPORTANT]
>Robocopy does not copy exclusively locked files. If users tend to lock many files for long periods on your file servers, consider using a different preseeding method. Preseeding does not require a perfect match between file lists on the source and destination servers, but the more files that do not exist when initial synchronization is performed for DFS Replication, the less effective preseeding is. To minimize lock conflicts, use Robocopy during non-peak hours for your organization. Always examine the Robocopy logs after preseeding to ensure that you understand which files were skipped because of exclusive locks.

To use Robocopy to preseed files for DFS Replication, follow these steps:

1. [Download and install the latest version of Robocopy.](#step-1-download-and-install-the-latest-version-of-robocopy)
2. [Stabilize files that will be replicated.](#step-2-stabilize-files-that-will-be-replicated)
3. [Copy the replicated files to the destination server.](#step-3-copy-the-replicated-files-to-the-destination-server)

## Prerequisites

Because preseeding does not directly involve DFS Replication, you only need to meet the requirements for performing a file copy with Robocopy.

- You need an account that's a member of the local Administrators group on both the source and destination servers.

- Install the most recent version of Robocopy on the server that you will use to copy the files—either the source server or the destination server; you will need to install the most recent version for the operating system version. For instructions, see [Step 2: Stabilize files that will be replicated](#step-2-stabilize-files-that-will-be-replicated). Unless you are preseeding files from a server running Windows Server 2003 R2, you can run Robocopy on either the source or destination server. The destination server, which typically has the more recent operating system version, gives you access to the most recent version of Robocopy.

- Ensure that sufficient storage space is available on the destination drive. Do not create a folder on the path that you plan to copy to: Robocopy must create the root folder.
    
    >[!NOTE]
    >When you decide how much space to allocate for the preseeded files, consider expected data growth over time and storage requirements for DFS Replication. For planning help, see [Edit the Quota Size of the Staging Folder and Conflict and Deleted Folder](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754229(v=ws.11)) in [Managing DFS Replication](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754771(v=ws.11)>).

- On the source server, optionally install Process Monitor or Process Explorer, which you can use to check for applications that are locking files. For download information, see [Process Monitor](https://docs.microsoft.com/sysinternals/downloads/procmon) and [Process Explorer](https://docs.microsoft.com/sysinternals/downloads/process-explorer).

## Step 1: Download and install the latest version of Robocopy

Before you use Robocopy to preseed files, you should download and install the latest version of **Robocopy.exe**. This ensures that DFS Replication doesn't skip files because of issues within Robocopy's shipping versions.

The source for the latest compatible Robocopy version depends on the version of Windows Server that is running on the server. For information about downloading the hotfix with the most recent version of Robocopy for Windows Server 2008 R2 or Windows Server 2008, see [List of currently available hotfixes for Distributed File System (DFS) technologies in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/968429/list-of-currently-available-hotfixes-for-distributed-file-system-dfs-t).

Alternatively, you can locate and install the latest hotfix for an operating system by taking the following steps.

### Locate and install the latest version of Robocopy for a specific version of Windows Server

1. In a web browser, open [https://support.microsoft.com](https://support.microsoft.com/).

2. In **Search Support**, enter the following string, replacing `<operating system version>` with the appropriate operating system, then press the Enter key:
    
    ```robocopy.exe kbqfe "<operating system version>"```
    
    For example, enter **robocopy.exe kbqfe "Windows Server 2008 R2"**.

3. Locate and download the hotfix with the highest ID number (that is, the latest version).

4. Install the hotfix on the server.

## Step 2: Stabilize files that will be replicated

After you install the latest version of Robocopy on the server, you should prevent locked files from blocking copying by using the methods described in the following table. Most applications do not exclusively lock files. However, during normal operations, a small percentage of files might be locked on file servers.

|Source of the lock|Explanation|Mitigation|
|---|---|---|
|Users remotely open files on shares.|Employees connect to a standard file server and edit documents, multimedia content, or other files. Sometimes referred to as the traditional home folder or shared data workloads.|Only perform Robocopy operations during off-peak, non-business hours. This minimizes the number of files that Robocopy must skip during preseeding.<br><br>Consider temporarily setting Read-only access on the file shares that will be replicated by using the Windows PowerShell **Grant-SmbShareAccess** and **Close-SmbSession** cmdlets. If you set permissions for a common group such as Everyone or Authenticated Users to READ, standard users might be less likely to open files with exclusive locks (if their applications detect the Read-only access when files are opened).<br><br>You might also consider setting a temporary firewall rule for SMB port 445 inbound to that server to block access to files or use the **Block-SmbShareAccess** cmdlet. However, both of these methods are very disruptive to user operations.|
|Applications open files local.|Application workloads running on a file server sometimes lock files.|Temporarily disable or uninstall the applications that are locking files. You can use Process Monitor or Process Explorer to determine which applications are locking files. To download Process Monitor or Process Explorer, visit the [Process Monitor](https://docs.microsoft.com/sysinternals/downloads/procmon) and [Process Explorer](https://docs.microsoft.com/sysinternals/downloads/process-explorer) pages.|

## Step 3: Copy the replicated files to the destination server

After you minimize locks on the files that will be replicated, you can preseed the files from the source server to the destination server.

>[!NOTE]
>You can run Robocopy on either the source computer or the destination computer. The following procedure describes running Robocopy on the destination server, which typically is running a more recent operating system, to take advantage of any additional Robocopy capabilities that the more recent operating system might provide.

### Preseed the replicated files onto the destination server with Robocopy

1. Sign in to the destination server with an account that's a member of the local Administrators group on both the source and destination servers.

2. Open an elevated command prompt.

3. To preseed the files from the source to destination server, run the following command, substituting your own source, destination, and log file paths for the bracketed values:
    
    ```PowerShell
    robocopy "<source replicated folder path>" "<destination replicated folder path>" /e /b /copyall /r:6 /w:5 /MT:64 /xd DfsrPrivate /tee /log:<log file path> /v
    ```
    
    This command copies all contents of the source folder to the destination folder, with the following parameters:
    
    |Parameter|Description|
    |---|---|
    |"\<source replicated folder path\>"|Specifies the source folder to preseed on the destination server.|
    |"\<destination replicated folder path\>"|Specifies the path to the folder that will store the preseeded files.<br><br>The destination folder must not already exist on the destination server. To get matching file hashes, Robocopy must create the root folder when it preseeds the files.|
    |/e|Copies subdirectories and their files, as well as empty subdirectories.|
    |/b|Copies files in Backup mode.|
    |/copyall|Copies all file information, including data, attributes, time stamps, the NTFS access control list (ACL), owner information, and auditing information.|
    |/r:6|Retries the operation six times when an error occurs.|
    |/w:5|Waits 5 seconds between retries.|
    |MT:64|Copies 64 files simultaneously.|
    |/xd DfsrPrivate|Excludes the DfsrPrivate folder.|
    |/tee|Writes status output to the console window, as well as to the log file.|
    |/log \<log file path>|Specifies the log file to write. Overwrites the file's existing contents. (To append the entries to the existing log file, use `/log+ <log file path>`.)|
    |/v|Produces verbose output that includes skipped files.|
    
    For example, the following command replicates files from the source replicated folder, E:\\RF01, to data drive D on the destination server:
    
    ```PowerShell
    robocopy.exe "\\srv01\e$\rf01" "d:\rf01" /e /b /copyall /r:6 /w:5 /MT:64 /xd DfsrPrivate /tee /log:c:\temp\preseedsrv02.log
    ```
    
    >[!NOTE]
    >We recommend that you use the parameters described above when you use Robocopy to preseed files for DFS Replication. However, you can change some of their values or add additional parameters. For example, you might find out through testing that you have the capacity to set a higher value (thread count) for the */MT* parameter. Also, if you'll primarily replicate larger files, you might be able to increase copy performance by adding the **/j** option for unbuffered I/O. For more information about Robocopy parameters, see the [Robocopy](https://docs.microsoft.com/windows-server/administration/windows-commands/robocopy) command-line reference.

    >[!WARNING]
    >To avoid potential data loss when you use Robocopy to preseed files for DFS Replication, do not make the following changes to the recommended parameters:
    >- Do not use the */mir* parameter (that mirrors a directory tree) or the */mov* parameter (that moves the files, then deletes them from the source).
    >-  Do not remove the **/e**, **/b**, and **/copyall** options.

4. After copying completes, examine the log for any errors or skipped files. Use Robocopy to copy any skipped files individually instead of recopying the entire set of files. If files were skipped because of exclusive locks, either try copying individual files with Robocopy later, or accept that those files will require over-the-wire replication by DFS Replication during initial synchronization.

## Next step

After you complete the initial copy, and use Robocopy to resolve issues with as many skipped files as possible, you will use the **Get-DfsrFileHash** cmdlet in Windows PowerShell or the **Dfsrdiag** command to validate the preseeded files by comparing file hashes on the source and destination servers. For detailed instructions, see [Step 2: Validate Preseeded Files for DFS Replication](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn495042(v%3dws.11)>).
