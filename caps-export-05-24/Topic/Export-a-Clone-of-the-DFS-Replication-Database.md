---
title: Export a Clone of the DFS Replication Database
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 807032ab-b4f1-4255-b7cf-76a0d8d4b9d6
---
# Export a Clone of the DFS Replication Database
This topic describes how to export a clone of the Distributed File System Replication \(DFS Replication\) database, which is a new capability introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
You can remove the need for members of a replication group to exchange files or metadata during replication setup by preseeding a replicated folder and exporting a clone of the database. This can reduce the initial synchronization time by up to 99% under ideal circumstances, and it’s useful when you configure replication for the first time, add new replication partners, replace server hardware, or recover from loss or corruption of the DFS Replication database.  
  
This document assumes that you have a basic knowledge of DFS Replication. For more information, see [Overview of DFS Replication](http://go.microsoft.com/fwlink/p/?LinkId=121762).  
  
> [!TIP]  
> To maximize cloning success, test the procedures in your lab prior to attempting production changes.  
  
## Prerequisites  
The following requirements are necessary on the source server and the destination server:  
  
-   The DFS Replication role service must be installed and running.  
  
-   You can perform only one cloning operation at a time per server.  
  
-   You must be signed in as a member of the Domain Administrators security group or the Enterprise Administrators security group, or you must have delegated permissions to create replication groups. For more information, see [Delegate the Ability to Manage DFS Replication](http://technet.microsoft.com/library/cc771465.aspx).  
  
The following requirements are necessary on the source server from which you want to export a database clone:  
  
-   The DFS Replication database must be on a volume that contains at least one Read\-write replicated folder. This is because SYSVOL and Read\-only replicated folders are not included in the database export process.  
  
-   The volume you are exporting must contain replicated folders that are in the **Normal** state. The replicated folders in that database cannot be in initial sync, initial building, or recovery states.  
  
-   Use only approved preseeding techniques to copy files in replicated folders to the destination server.  
  
-   Confirm that the preseeding worked properly by using the **Get\-DfsrFileHash** cmdlet. For more information on preseeding replicated folders, see [DFS Replication: Copying Files to Preseed or Stage Initial Synchronization](../Topic/DFS-Replication--Copying-Files-to-Preseed-or-Stage-Initial-Synchronization.md).  
  
-   To maximize cloning performance and data fidelity, prevent all user changes to files on the source server during the cloning operation. The more changes that occur during cloning, the more DFS Replication must update the destination server.  
  
-   Export a database clone only when it is acceptable that replication will pause. Cloning takes the DFS Replication volume manager offline, which prevents any replication from running on that volume during cloning. When cloning completes, DFS Replication automatically resumes replication.  
  
The following requirements are necessary on the destination server on which you want to import a database clone:  
  
-   The destination replicated folder you create must be writeable \- it can't be a read\-only replicated folder.  
  
-   The destination volume cannot have a replicated folder on it.  
  
-   If the destination volume previously contained a replicated folder, delete the following hidden folder on the volume: <volume>:\\system volume information\\dfsr\\database\_<string>.  
  
-   To export database clones to a hub server with numerous replication partners, you might have to use NTFS volume mount points on the hub server to create a separate volume for each imported database. This is because each volume can only host one DFS Replication database, and cloning can't merge an existing database with an imported database.  
  
-   Prevent all Write access to existing file shares on the destination replication folders by changing the share permissions to Read\-only for all users. Don't create any new file shares for the folders until cloning and the post\-cloning initial sync processing finishes. As an alternative to changing file share permissions, you can note and remove the file shares. As with any initial sync, users shouldn't use a destination server until all the files are available because the appearance of missing or out\-of\-date files could lead them to contact the Help Desk, or they could attempt to fix the apparent issues themselves.  
  
> [!NOTE]  
> You can clone a clone. That is, you can create a clone, import the cloned database on another server, and then clone that database. You can also import a cloned database on many servers.  
  
> [!NOTE]  
> The supported limit for files per volume is 70 million, with 120 million files per server supported in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Step 1: Create an example replication environment  
This procedure shows you how to create an example replication environment to test DFS Replication database cloning. To clone an existing server that already performs replication, skip this section. Cloning supports multiple destination servers, but this example includes only a single destination server.  
  
This example uses SRV01 as the source \(upstream or authoritative\) server, SRV02 as the destination \(downstream or nonauthoritative\) server, and drive H on both servers. It also uses a replication group named RG01 and a replicated folder named RF01. All servers must run [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
#### To create an example replication environment for testing  
  
1.  On the source server *SRV01*, create a folder on drive H named *RF01*.  
  
2.  Create or copy in some test files to the H:\\RF01 folder, such as by copying the 1,000 largest files in the C:\\Windows\\sysWOW64 folder.  
  
3.  Create the *RG01* test replication group, the *RF01* test replicated folder, and add only *SRV01* as a member by running the following commands from an elevated Windows PowerShell session:  
  
    ```powershell  
    $DfsrComputerName = "SRV01"  
    $DfsrReplicatedFolderPath = "H:\RF01"  
    $DfsrReplicationGroupName = "RG01"  
    $DfsrReplicatedFolderName = "RF01"  
  
    New-DfsReplicationGroup -GroupName $DfsrReplicationGroupName  
    New-DfsReplicatedFolder -GroupName $DfsrReplicationGroupName -FolderName $DfsrReplicatedFolderName  
    Add-DfsrMember -GroupName $DfsrReplicationGroupName -ComputerName $DFSRComputername  
    Set-DfsrMembership -GroupName $DfsrReplicationGroupName -FolderName $DfsrReplicatedFolderName -ContentPath $DfsrReplicatedFolderPath -ComputerName $DFSRComputername -PrimaryMember $True  
    ```  
  
    > [!IMPORTANT]  
    > Do not add SRV02 as a member or create a connection between the servers in this new replication group yet. However, you can add multiple replicated folders on a volume and clone them.  
  
4.  Wait for DFS Replication event 4112 in the DFS Replication event log, which indicates that the replication folder initialized successfully as the primary member \(there is one event per replicated folder\). To view this event, in Event Viewer, navigate to **Applications and Services Logs**, then **DFS Replication**.  
  
    To reduce the wait time, you can force Active Directory Domain Services \(AD DS\) replication, and then use the DFS Replication cmdlet **Update\-DfsrConfigurationFromAD**. For more information, see [Force Replication Between Domain Controllers](http://technet.microsoft.com/library/cc816926.aspx) or [Synchronize Replication with All Partners](http://technet.microsoft.com/library/cc816915.aspx).  
  
## Step 2: Export a clone of a DFS Replication database  
When you have a DFS Replication database to export \(from an example replication environment or from a production environment\), use the following procedure to export a clone of the database, which is used for all replicated folders on the volume you specify.  
  
This example uses SRV01 as the source server, SRV02 as the destination server, and drive H on both servers. It also uses a replication group named RG01 and a replicated folder named RF01. All servers must run [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
If you're performing an upgrade installation \(instead of a clean install\) of Windows Server, you don't need to use cloning or the procedures in this topic.  
  
> [!TIP]  
> To maximize cloning performance and data fidelity, prevent all user changes to files on the source server during the cloning operation. The more changes that occur during cloning, the more DFS Replication must update the destination server.  
  
### <a name="BKMK_ExportClone"></a>To export a clone of a DFS Replication database  
  
1.  Validate that all the existing replicated folders on the volume that stores the replicated folder that you want to preseed are in the **Normal**, noninitial sync state. Replicated folders in other states are skipped during cloning.  
  
    To validate the state, examine the DFS Replication event log to ensure that all replicated folders have a 4112 or 4104 event. You can also use the following sample command to determine which replicated folders are in the **Normal**, noninitial sync state:  
  
    ```powershell  
    Get-WmiObject -Namespace "root\Microsoft\Windows\DFSR" -Class msft_dfsrreplicatedfolderinfo -ComputerName srv01  
    | ft replicatedfoldername,state -auto -wrap  
    ```  
  
    All replicated folders listed for that computer will show state 4 \(that is, **Normal**\) if they have completed the initial build or initial sync, and they are ready to clone.  
  
2.  Export the cloned database and volume configuration XML by running the following sample command from an elevated Windows PowerShell session:  
  
    ```powershell  
    $DfsrCloneVolume = "H:"  
    $DfsrCloneDir = "\DfsrClone"  
  
    New-Item -Path $DfsrCloneVolume\$DfsrCloneDir -Type Directory  
    Export-DfsrClone -Volume $DfsrCloneVolume -Path $DfsrCloneVolume\$DfsrCloneDir  
    ```  
  
    > [!NOTE]  
    > Although the **Export\-DfsrClone** cmdlet does not return any output until cloning completes, you can safely close the Windows PowerShell session after running the command. The DFS Replication service performs the processing while the command synchronously waits for the result. If you close the Windows PowerShell console or exit the command, you can continue to see progress by examining the DFS Replication event log, the DFS Replication debug logs, or by using the **Get\-DfsrCloneState** cmdlet.  
  
3.  After completion, make a note of the Robocopy sample commands that are displayed by the **Export\-DfsrClone** cmdlet. You can later use these commands to copy the data to the destination server. You can also use **Export\-DfsrClone** with the **\-WhatIf** parameter to see the Robocopy samples without performing cloning, for example:  
  
    ```ms-dos  
    Robocopy.exe "H:\DfsrClone" "<destination path>" /B   
    Robocopy.exe "H:\RF01" "<destination path>" /E /B /COPYALL /R:6 /W:5 /MT:64 /XD DfsrPrivate /TEE /LOG+:preseed.log   
    ```  
  
4.  Wait for a DFS Replication Event 2402 in the DFS Replication event log, which indicates that the export completed successfully. You can also use the **Get\-DfsrCloneState** cmdlet to see the export status. The cmdlet returns **Ready** when the export process completes.  
  
## Step 3: Import a clone of a DFS Replication database  
After you export a clone of a DFS Replication database, use the following procedure to import it on the destination server.  
  
#### Import the cloned database on the destination server  
  
1.  Use an approved method to preseed the destination server with the contents of the replicated folders from the source server. If the destination server is the same as the source server \(for example, if you are replacing hardware or installing a new operating system\), or you are recovering from a corrupted DFS Replication database, skip this step. In these instances, there is no need to remove the previously replicated data.  
  
    For example, you could use the following Robocopy sample command with the instructions in the following article: [Replacing DFSR Member Hardware or OS \(Part 2: Preseeding\)](http://blogs.technet.com/b/askds/archive/2010/09/07/replacing-dfsr-member-hardware-or-os-part-2-pre-seeding.aspx):  
  
    ```ms-dos  
    Robocopy.exe "H:\RF01" "\\Srv02\H$\Rf01" /E /B /COPYALL /R:6 /W:5 /MT:64 /XD DfsrPrivate /TEE /LOG+:preseed.log   
    ```  
  
2.  Copy to the destination server the exported dfsr.db.clone database and config.xml files that you created with the **Export\-DfsrClone** cmdlet in Step 2 of [Export a clone of a DFS Replication database](#BKMK_ExportClone). For example, you could use the following Robocopy sample command:  
  
    ```ms-dos  
    Robocopy.exe "H:\DfsrClone" "\\Srv02\H$\DfsrClone" /B  
    ```  
  
    > [!IMPORTANT]  
    > If you are using database cloning to recover from a corrupted database, remove the destination server from the affected replication group membership prior to copying. For more information, see [Use cloning to replace a corrupted DFS Replication database](../Topic/Export-a-Clone-of-the-DFS-Replication-Database.md#CorruptDatabase).  
  
3.  On the destination server *SRV02*, ensure that a DFS Replication database does not already exist on the volume into which you will import data. To do so, use the following procedure:  
  
    1.  Launch an elevated Windows PowerShell session and then type the following, where *H* is the drive letter of the appropriate replicated folder:  
  
        ```powershell  
        Get-ChildItem -path "H:\System Volume Information\dfsr" -hidden  
        ```  
  
    2.  If there aren't any DFS Replication databases on the volume, there won't be any output. If a directory is listed, use DFS Management or the following Windows PowerShell command to confirm that there aren't any replicated folders on drive *H:\\* \(you cannot clone into an existing DFS Replication database\).  
  
        ```powershell  
        Get-DfsrMembership | Where-Object -Property ContentPath -Like H:\* | Format-Table   
        ```  
  
    3.  If the destination volume doesn't currently contain any replicated folders, but it did previously \(such as reusing storage when replacing a server\), in the elevated Windows PowerShell session, type the following command:  
  
        ```powershell  
        Stop-Service DFSR  
        Remove-Item –path "H:\system volume information\dfsr" –recurse -force  
        Start-Service DFSR  
        ```  
  
4.  After all preseeding operations are complete, import the cloned database and volume configuration XML by using a validation level of basic \(1\). This provides a balance of speed and data fidelity for the initial sync. Run the following sample command from an elevated Windows PowerShell session on the destination server:  
  
    > [!IMPORTANT]  
    > Do not start the import until you complete all preseeding operations.  
  
    ```powershell  
    Import-DfsrClone -Volume h: -Path "h:\Dfsrclone"  
    ```  
  
    > [!NOTE]  
    > Although the **Import\-DfsrClone** cmdlet does not return any output until cloning completes, you can safely close the Windows PowerShell session after running the command. The DFS Replication service performs the processing while the command synchronously waits for the result. If you close the Windows PowerShell console or exit the command, you can continue to see progress by examining the DFS Replication event log, the DFS Replication debug logs, or by using the **Get\-DfsrCloneState** cmdlet.  
  
5.  Wait for a DFS Replication Event 2404 in the DFS Replication event log, which indicates that the import completed successfully. Event 2416 also contains cloning progress events. You can also use the **Get\-DfsrCloneState** cmdlet to see the export status. The cmdlet returns **Ready** when the export process completes.  
  
6.  Add *SRV02* to the replication group with a connection to the source server by running the following sample commands from an elevated Windows PowerShell session.  
  
    If the destination server is a production server that is already a member of the same replication group as the source server \(and you did not remove all of its memberships while replacing a corrupted database\), skip the **Add\-DfsrMember** and **Add\-DfsrConnection** cmdlets, and use only the **Set\-DfsrMembership** cmdlet in the following command.  
  
    ```powershell  
    $DfsrSourceComputerName = "Srv01"  
    $DfsrDestinationComputerName = "Srv02"  
    $DfsrReplicationGroupName = "RG01"  
    $DfsrReplicatedFolderName = "RF01"  
    $DfsrReplicatedFolderPath = "H:\RF01"  
  
    Add-DfsrMember -GroupName $DfsrReplicationGroupName -ComputerName $DfsrDestinationComputerName  
    Add-DfsrConnection -GroupName $DfsrReplicationGroupName -SourceComputerName $DfsrSourceComputerName –DestinationComputerName $DfsrDestinationComputerName  
    Set-DfsrMembership -GroupName $DfsrReplicationGroupName -FolderName $DfsrReplicatedFolderName -ContentPath $DfsrReplicatedFolderPath -ComputerName $DfsrDestinationComputerName   
    ```  
  
7.  Wait for DFS Replication event 4104 in the DFS Replication event log, which indicates that the replication folder initialized successfully as a nonauthoritative member \(there is one event per replicated folder\).  
  
8.  Open an elevated Windows PowerShell session, and use the **Get\-DfsrPreservedFiles** cmdlet to note any files that were conflicted or preexisting on the destination server. If there aren't any, you should see the result **Could not find the specified manifest file**. There should not be any preexisting files, and the only conflicts would be files that were modified after cloning started and before it completed, for example:  
  
    ```powershell  
    Get-DfsrPreservedFiles -path "h:\rf01\dfsrprivate\conflictanddeletedmanifest.xml"   
    Get-DfsrPreservedFiles -path "h:\rf01\dfsrprivate\preexistingmanifest.xml"   
    ```  
  
9. Use the **Start\-DfsrPropagationTest** and **Write\-DfsrPropagationReport** cmdlets to validate replication, for example:  
  
    ```powershell  
    Start-DfsrPropagationTest –GroupName "RG01" –FolderName * -ReferenceComputer SRV01  
    Write-DfsrPropagationReport –GroupName "RG01" –FolderName * -ReferenceComputer SRV01 –Path "c:\reports"  
    ```  
  
## <a name="CorruptDatabase"></a>Use cloning to replace a corrupted DFS Replication database  
In the event of DFS Replication database corruption that is caused by hardware issues \(such as abrupt power loss\), you can save time by cloning the database from another server rather than waiting for the automatic nonauthoritative recovery to complete.  
  
To perform a database recovery by using cloning, follow the procedures to export a database clone and import a database clone, but skip preseeding the replicated folder. Also, prior to performing "Step 3: Import a clone of a DFS Replication database," remove the server from the replicated folder memberships that are affected by the corruption. This prevents DFS Replication from attempting to rebuild the database.  
  
To do so, from an elevated Windows PowerShell session, type the following command to remove only the member. \(This removes all of that computer’s memberships in that replication group because Windows PowerShell does not support removing a single membership.\)  
  
```powershell  
Remove-DfsrMember –GroupName RG01 –ComputerName SRV02  
```  
  
> [!IMPORTANT]  
> If you remove a member from a replication group, all of its memberships are affected. Only perform this operation if all the server’s memberships exist only on the volume with the corrupt database.  
  
If there are volumes without corrupt databases, you should use the **DFSRADMIN** command instead. Open an elevated command prompt window, and type the following command to remove only the single affected membership:  
  
```ms-dos  
Dfsradmin membership delete /rgname:rg01 /rfname:rf01 /memname:srv02  
```  
  
## See also  
  
|||  
|-|-|  
|**Content Type**|**References**|  
|**Product evaluation**|-   [What's New in DFS Replication in Windows Server 2012 R2](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601)|  
|**Operations**|-   [DFS Management Help](http://technet.microsoft.com/library/cc732006.aspx)<br />-   [DFS Replication: Frequently Asked Questions](http://technet.microsoft.com/library/cc773238.aspx)<br />-   [DFS Replication: Copying Files to Preseed or Stage Initial Synchronization](../Topic/DFS-Replication--Copying-Files-to-Preseed-or-Stage-Initial-Synchronization.md)<br />-   [DFS Replication Cmdlets](http://technet.microsoft.com/library/dn296591(v=wps.630).aspx)|  
|**Community resources**|-   [The File Services and Storage TechNet Forum](http://social.technet.microsoft.com/forums/winserverfiles/threads/)<br />-   [Storage Team at Microsoft File Cabinet Blog](http://blogs.technet.com/filecab/)<br />-   [Ask the Directory Services Team Blog](http://blogs.technet.com/b/askds/)<br />-   [DFS Replication Survival Guide \(TechNet Wiki\)](http://social.technet.microsoft.com/wiki/contents/articles/dfs-replication-survival-guide.aspx)<br />-   [Windows Server Information Experience on Twitter](http://twitter.com/windowsserver)|  
  
