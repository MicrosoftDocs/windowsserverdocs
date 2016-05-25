---
title: Use Windows Server Backup to Preseed Files for DFS Replication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3823c722-a866-4424-91a6-d0e472c8280d
author: JasonGerend
---
# Use Windows Server Backup to Preseed Files for DFS Replication
This topic explains how to use the Windows Server Backup feature to preseed data when setting up replication for Distributed File System \(DFS\) Replication \(also known as DFSR or DFS\-R\). By preseeding data before you set up DFS Replication, add a new replication partner, or replace a server, you can speed up initial synchronization and enable cloning of the DFS Replication database in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
The Windows Server Backup graphical utility \(wbadmin.msc\) and command\-line utility \(wbadmin.exe\) are included with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can use Windows Server Backup to back up and restore data from one server to another using a transitional storage location. Windows Server Backup can back up exclusively locked files.  
  
> [!NOTE]  
> Windows Server Backup is one of several tools that can be used to preseed data for DFS Replication. For a comparison of tools and an overview of the preseeding process, see [Step 1: Preseed Files for DFS Replication](../Topic/Step-1--Preseed-Files-for-DFS-Replication.md).  
  
Preseeding data for DFSR by using Windows Server Backup involves the following steps:  
  
-   [Step 1: Install the Windows Server Backup feature](#BKMK_Step1InstallWindowsServerBackup)  
  
-   [Step 2: Back up the replicated files from the source server](#BKMK_Step2BackUpFiles)  
  
-   [Step 3: Restore the replicated files to the destination server](#BKMK_Step3RestoreReplicatedData)  
  
## Prerequisites  
Because preseeding does not directly involve DFS Replication, you need only meet the requirements for performing a file copy by using Windows Server Backup:  
  
-   You will need to use an account that is a member of the local Administrators group on both the source server and the destination server.  
  
-   The source and destination computers must have an operating system that includes the Windows Server Backup feature. Windows Server Backup is included with the following operating systems: [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
-   Install the Windows Server Backup feature on the source and destination servers. For more information, see [Step 1: Install the Windows Server Backup feature](#BKMK_Step1InstallWindowsServerBackup).  
  
-   A separate volume must be available with ample storage for backing up the source folders. The backup volume can be on the source computer, the destination computer, or on network storage that is accessible to both computers. The backup volume can be stored on fixed or removable storage.  
  
    > [!NOTE]  
    > When you decide how much space to allocate for the preseeded files, consider expected data growth over time and storage requirements for DFS Replication. For planning help, see [Edit the Quota Size of the Staging Folder and Conflict and Deleted Folder](http://technet.microsoft.com/library/cc754229.aspx) in [Managing DFS Replication](http://technet.microsoft.com/library/cc754771.aspx).  
  
-   On the destination server, the path that you plan to restore the data to should not contain any files. Any files restored as copies of existing files will be moved to the PreExisting folder when initial synchronization for DFS Replication starts.  
  
## <a name="BKMK_Step1InstallWindowsServerBackup"></a>Step 1: Install the Windows Server Backup feature  
The Windows Server Backup feature is not installed by default. You must add it to both the source server and the destination server. The following procedures explain how to install Windows Server Backup.  
  
#### To install Windows Server Backup on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using Server Manager  
  
1.  Start **Server Manager** \(servermanager.exe\).  
  
2.  On the Dashboard, click **Add roles and features**.  
  
3.  Proceed to the **Features** page, and select **Windows Server Backup**.  
  
4.  Follow the wizard instructions to install the feature.  
  
#### To install Windows Server Backup on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using Windows PowerShell  
  
1.  Open Windows PowerShell with elevated rights.  
  
2.  Run the following command:  
  
    ```powershell  
    Install-WindowsFeature -Name Windows-Server-Backup –IncludeManagementTools  
    ```  
  
#### To install Windows Server Backup on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
-   To find out how to install Windows Server Backup on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] by using Server Manager or from the command line, see [Windows Server Backup Step\-by\-Step Guide for Windows Server 2008 R2](http://technet.microsoft.com/library/ee849849(WS.10).aspx).  
  
-   To find out how to install Windows Server Backup on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] by using Server Manager or from the command line, see [Windows Server Backup Step\-by\-Step Guide for Windows Server 2008](http://technet.microsoft.com/library/cc770266(v=WS.10).aspx).  
  
## <a name="BKMK_Step2BackUpFiles"></a>Step 2: Back up the replicated files from the source server  
To back up files from the source server, you must have a different volume that has ample storage for the backed up data. That volume can be located on the source server, the destination server, or on network storage that both servers can access. The volume can be on fixed or removable storage.  
  
> [!NOTE]  
> The procedures in this topic describe how to back up to and restore selected folders from a shared folder. You can also back up to a local drive on the destination server. In that case, for Windows Server Backup to discover the backup on the destination server, you must back up to the drive’s root folder.  
  
#### To back up files using the wbadmin.msc graphical tool  
  
1.  Sign in on the source server with an account that is a member of the local Administrators group.  
  
2.  Start Windows Server Backup by using either of the following methods:  
  
    -   In **Server Manager**, on the **Tools** menu, click **Windows Server Backup**.  
  
    -   At an elevated command prompt, enter **wbadmin.msc**.  
  
3.  In the console tree, click **Local Backup**.  
  
4.  On the **Actions** pane, click **Backup Once**.  
  
    The Backup Once Wizard opens.  
  
5.  On the **Backup Options** page, click **Next** to begin specifying an unscheduled backup.  
  
6.  On the **Select Backup Configuration** page, select **Custom**, and then click **Next**.  
  
7.  On the **Select Items for Backup** page, click **Add Items**, and then select the folders that you want to preseed on the destination server. Then click **Next**.  
  
    > [!NOTE]  
    > The option to select specific folders to back up is not available in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. That version of Windows Server Backup only supports full volume backups. However, it does allow you to restore specific folders.  
  
8.  On the **Specify Destination Type** page, select **Remote shared folder**, and then click **Next**.  
  
9. On the **Specify Remote Folder** page, enter or select the shared folder where you want to store the backup, and then click **Next**. A **WindowsImageBackup** folder will be created in the shared folder to store the backup.  
  
10. On the **Confirmation** page, review the options that you specified, and then click **Backup**.  
  
11. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] only, on the **Specify advanced option** page, click **Next** to the default selection.  
  
12. After the backup operations complete, verify that no errors occurred. In the console tree, click **Local Backup**, and then click the backup that just completed. If the status is not **Successful**, click **View details** in the **Status** pane below to review any errors that occurred.  
  
#### To back up the replicated files by using the wbadmin.exe command\-line tool  
  
1.  Sign in on the source server with an account that is a member of the local Administrators group.  
  
2.  Open an elevated command prompt.  
  
3.  Run the following command, substituting your own path and folders:  
  
    ```ms-dos  
    wbadmin start backup -backuptarget:<storage location for the backup>: -include:<folder1, folder2, foldern>  
    ```  
  
    > [!NOTE]  
    > In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you cannot use the **–include** parameter to specify individual folders to back up. You can only back up full volumes.  
  
    Example 1: The following example backs up the replicated folders RF01 and RF02 on F: to a local fixed disk on the G: volume:  
  
    `wbadmin start backup -backuptarget:g: -include:f:\rf01,f:\rf02`  
  
    Example 2: The following example backs up the same replicated folders to a remote file share on the SRV01 server:  
  
    `wbadmin start backup -backuptarget:\\SRV01\BackDfsr$ -include:f:\rf01,f:\rf02`  
  
## <a name="BKMK_Step3RestoreReplicatedData"></a>Step 3: Restore the replicated files to the destination server  
You can now restore the backup that you just created to preseed the data from the source server to the destination server. The following procedures describe how to do this by using the graphical tool \(wbadmin.msc\) or the command\-line utility \(wbadmin.exe\).  
  
The following procedure describes how to use Windows Server Backup to preseed files from a backup stored on a shared folder.  
  
#### To restore the replicated files by using the wbadmin.msc graphical tool  
  
1.  Sign in on the destination server with an account that is a member of the local Administrators group on both the source and destination servers.  
  
2.  Start **Windows Server Backup** from **Server Manager**, or by running Start Wbadmin.msc.  
  
3.  In the console tree, click **Local Backup**.  
  
4.  On the **Actions** pane, click **Recover**.  
  
    The Recovery Wizard opens.  
  
5.  On the **Getting Started** page, select **A backup stored on another location** \(to indicate that you saved the backup from a different server\), and then click **Next**.  
  
6.  On the **Specify Location Type** page, click **Remote shared folder**. \(Select this option even if the share that stores the backup is on the destination server.\)  
  
7.  On the **Specify Remote Folder** page, type the UNC path to the shared folder where you stored your backup. For example, type **\\\\MyFileServer\\Backups**. After you type the server name and a backslash, you can select from shared folders that store backups on the server.  
  
8.  On the **Select Backup Date** page, select the date and time of the backup that you want to preseed on the destination server, and then click **Next**.  
  
9. On the **Select Recovery Type** page, select **File and Folders**, and then click **Next**.  
  
10. On the **Select Items to Recover** page, under **Available Items**, expand the backup, select the folder that stores the files you want to preseed, and then click **Next**.  
  
11. On the **Specify Recovery Options** page, enter the following options, and then click **Next**:  
  
    1.  Select **Another location**, and then specify or select the location on the destination server to which you want to preseed the files.  
  
        > [!IMPORTANT]  
        > The target on the destination server should not contain any files. Any files restored as copies of existing files will be moved to the PreExisting folder when initial synchronization for DFS Replication starts.  
  
    2.  Leave the **Create copies so that you have both versions** and **Leave Restore access control list \(ACL\) permissions to the file or folder being recovered** options selected.  
  
12. On the **Confirmation** page, review the options that you selected, and then click **Recover**.  
  
13. After the restore operations complete, verify that no errors occurred. If any files are missing, check the backup to make sure the files were backed up. Then check the restore log to ensure that no files were skipped during the restore.  
  
#### To restore the replicated files using wbadmin.exe command\-line tool  
  
1.  On the destination server, open an elevated command prompt.  
  
2.  To retrieve a list of backups, run the following command:  
  
    ```ms-dos  
    wwbadmin get versions –backuptarget:<path to saved backup>  
    ```  
  
    Example 1: Lists backups that were saved to the H: drive on the \(local\) destination server:  
  
    `wbadmin get versions -backupTarget:h:`  
  
    Example 2: Lists backups that were saved to a transitional file server share:  
  
    `wbadmin get versions -backupTarget:\\SRV01\BackDfsr`  
  
3.  To restore the backup to the destination server, run the following command:  
  
    ```ms-dos  
    wbadmin start recovery -version:<version> -itemtype:File -backuptarget:<path to saved backup> -items:<path to files to restore> -recursive -overwrite:createcopy -recoverytarget:<path to restore to>  
    ```  
  
    Example 1: Restores files from two folders \- RF01 and RF02, which were backed up to the Q: drive on the destination server. The files are restored to the F: drive on the destination \(local\) server:  
  
    `wbadmin start recovery -version:06/07/2013-16:23 -itemtype:File -backuptarget:q: -items:f:\rf01,f:\rf02 -recursive -overwrite:createcopy -recoverytarget:f:\`  
  
    Example 2: Restores files that were backed up to a transitional file server share named \\\\srv01\\q$:  
  
    `wbadmin start recover -version:06/07/2013-16:23 -itemtype:File -backuptarget:\\srv01\q$ -items:f:\rf01,f:\rf02 -recursive -overwrite:createcopy -recoverytarget:g:\`  
  
4.  Review the list of restored files to ensure that all files from the backup were restored successfully.  
  
## <a name="BKMK_NextStep"></a>Next step  
After you use Windows Server Backup to back up files to an interim storage location and then restore them to the desired location on the destination server, and you resolve any issues with the backup and restore, use the **Get\-DfsrFileHash** cmdlet in Windows PowerShell or the **Dfsrdiag** command to validate the preseeded files by comparing file hashes on the source and destination servers. For instructions, see [Step 2: Validate Preseeded Files for DFS Replication](../Topic/Step-2--Validate-Preseeded-Files-for-DFS-Replication.md).  
  
