---
title: Use Windows NTBackup to Preseed Files for DFS Replication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: abbda8b0-5822-4340-89d7-643560084893
---
# Use Windows NTBackup to Preseed Files for DFS Replication
This topic provides step\-by\-step procedures for using the NTBackup command\-line utility to preseed files for Distributed File System \(DFS\) Replication \(also known as DFSR or DFS\-R\) from a computer running Windows Server 2003 R2 to a computer running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. By preseeding data before you set up DFS Replication, add a new replication partner, or replace a server, you can speed up initial synchronization.  
  
The Windows NTBackup graphical utility \(ntbackup.exe\) is a tool for restoring backups made in Windows Server 2003 R2 to a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] computer. NTBackup provides the capability to back up and restore data from one server to another by using a transitional storage location. NTBackup can back up exclusively locked files. The tool is included with the Windows Server 2003 R2 operating system, but not with more recent operating systems. Downloadable versions of NTBackup are available for restoring files to a computer running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
If you are accustomed to using Windows NTBackup, this tool provides a familiar method for preseeding files for DFS Replication on a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] computer. However, the use of NTBackup is limited:  
  
-   In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], NTBackup can be used to restore backups but not to create backups.  
  
-   Microsoft does not provide NTBackup tools for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. To preseed files from Windows Server 2003 R2 or Windows Server 2003 to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or later, you must use the Robocopy tool or non\-Microsoft methods.  
  
> [!NOTE]  
> NTBackup is one of several tools that can be used to preseeding data for DFS Replication. For a comparison of tools and an overview of the preseeding process, see [DFS Replication: Copying Files to Preseed or Stage Initial Synchronization](../Topic/DFS-Replication--Copying-Files-to-Preseed-or-Stage-Initial-Synchronization.md).  
  
Preseeding files for DFS Replication by using NTBackup involves the following steps:  
  
-   [Step 1: Install NTBackup on the destination server](#BKMK_Step1InstallNTBackup)  
  
-   [Step 2: Back up the files from the source server](#BKMK_Step2BackUpReplicatedFiles)  
  
-   [Step 3: Restore the files to the destination server](#BKMK_Step3RestoreToDestinationServer)  
  
## Prerequisites  
Because preseeding does not directly involve DFS Replication, you need only meet the requirements for backing up and restoring files by using Windows NTBackup:  
  
-   You will need to use an account that is a member of the local Administrators group on both the source server and the destination server.  
  
-   The destination computer must have the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system installed.  
  
-   You must install NTBackup on the destination computer. \(NTBackup will be installed already on your source computer, which is running Windows Server 2003 R2.\) For more information, see [Step 1: Install the Windows Server Backup feature](#BKMK_Step1InstallNTBackup).  
  
-   To back up the files from the source computer, ample storage must be available on a different volume. The backup volume can exist on the source server, the destination server, or on network storage that can be accessed by both servers. The backup volume can be stored on fixed or removable storage.  
  
    > [!NOTE]  
    > When you decide how much space to allocate for the preseeded files, consider expected data growth over time and storage requirements for DFS Replication. For planning help, see [Edit the Quota Size of the Staging Folder and Conflict and Deleted Folder](http://technet.microsoft.com/library/cc754229.aspx) in [Managing DFS Replication](http://technet.microsoft.com/library/cc754771.aspx).  
  
## <a name="BKMK_Step1InstallNTBackup"></a>Step 1: Install NTBackup on the destination server  
On a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] destination server, you must add the NTBackup feature. On the source computer, running Windows Server 2003 R2, NTBackup is installed automatically during operating system installation.  
  
#### To install NTBackup on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]  
  
1.  Log on to the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] computer as an administrator.  
  
2.  Download and install NTBackup. For download instructions, see [article 974674](http://www.microsoft.com/download/details.aspx?id=24057) in the Microsoft Knowledge Base.  
  
#### To install NTBackup on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
1.  Log on to the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] computer as an administrator.  
  
2.  Open **Server Manager**, navigate to the **Features** section, and click **Add features**.  
  
3.  Select **Removable Storage Manager**, click **Next**, and then click **Install**.  
  
4.  Download and install the appropriate NTBackup MSI file from [Windows NT Backup \- Restore Utility](http://www.microsoft.com/download/details.aspx?id=4220).  
  
## <a name="BKMK_Step2BackUpReplicatedFiles"></a>Step 2: Back up the files from the source server  
Your next step is to back up the files to interim storage on the source server, the destination server, or on network storage that can be accessed by both servers. You must have ample storage for the backed up data on a different volume. The backup can be stored on fixed or removable storage.  
  
#### To back up files by using NTBackup  
  
1.  On the source server, start **Ntbackup.exe**.  
  
2.  If the **Backup or Restore Wizard** dialog box appears, clear the **Always start in wizard mode** check box, click **Cancel**, and then restart NTBackup.exe.  
  
3.  Click the **Backup** tab.  
  
4.  Select replicated folders to back up:  
  
    1.  Select each replicated folder that you want to back up.  
  
    2.  Clear the selection of the DfsrPrivate folder under each replicated folder so that those folders are not backed up. The DfsrPrivate folder increases the size of the backup but does not contain data useful to the destination server.  
  
5.  Under **Backup media or file name**, browse or type a path to a backup BKF file. This path can be a local path on the server or a remote share; the path can specify the same volume or a different volume. The target can be the destination server for the restore.  
  
6.  Click **Start Backup**. Select any desired options, entering a custom description and label if desired, and then click **Start Backup**.  
  
7.  After the backup operations complete, verify that no errors occurred during the backup.  
  
## <a name="BKMK_Step3RestoreToDestinationServer"></a>Step 3: Restore the backup to the destination server  
You are now ready to preseed the files from the source server to the destination server by restoring the backup.  
  
#### To restore the files by using NtbackupRestore or NtBackup  
  
1.  On the destination server, start the Windows NTBackup restore utility, **NtBackupRestoreUtility.exe**.  
  
2.  Click **Restore Wizard \(Advanced\)**.  
  
3.  On the **Welcome to the Restore Wizard** page, click **Next**.  
  
4.  On the **What to restore** page, select the backup that you want to preseed on the destination server. To do this, use the **Browse** button to select the BKF file that was created during the backup.  
  
5.  Select each replicated folder that you want to restore, and then click **Next**.  
  
6.  On the **Completing the Restore Wizard** page, click **Advanced**.  
  
7.  On the **Where to Restore** page, specify **Alternate location**, select the correct location, and then click **Next**.  
  
8.  On the **How to Restore** page, select the **Replace existing files if they are older than the backup files** option, then click **Next**.  
  
9. On the **Advanced Restore Options** page, select the **Restore security settings** option, clear all other options, and then click **Next**.  
  
10. On the **Completing the Restore Wizard** page, click **Finish**.  
  
11. After the restore operations complete, verify that that no errors occurred.  
  
## <a name="BKMK_NextStep"></a>Next step  
After you restore your files to the destination server and you resolve any issues with the backup and restore, use the **Get\-DfsrFileHash** cmdlet in Windows PowerShell or the **Dfsrdiag** command to validate the preseeded files by comparing file hashes on the source and destination servers. For instructions, see [Step 2: Validate Preseeded Files for DFS Replication](../Topic/Step-2--Validate-Preseeded-Files-for-DFS-Replication.md).  
  
