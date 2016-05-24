---
title: File and Storage Services: Prepare to Migrate
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c287295-6eff-408c-89f7-8f549c143212
---
# File and Storage Services: Prepare to Migrate
This guide provides you with instructions for migrating the File and Storage Services role to a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Install migration tools  
[!INCLUDE[wsmt](../Token/wsmt_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] allows an administrator to migrate some server roles, features, operating system settings, file shares, and other data from computers that are running certain editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003 to computers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
For complete installation, configuration, and removal instructions for [!INCLUDE[wsmt](../Token/wsmt_md.md)], see [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
Migration documentation and tools ease the process of migrating server role settings and data from an existing server that is running a Windows server operating system to another computer. For a complete list of supported operating systems, see [Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md).  
  
By using these tools to migrate roles, you can simplify migration, reduce migration time, increase accuracy of the migration process, and help eliminate conflicts that could otherwise occur during the migration process.  
  
### Prepare for migration  
The following list outlines the major steps for preparing to migrate the File and Storage Services role.  
  
-   [Prepare the destination server](#BKMK_Preparethedestinationserver)  
  
-   [Back up the source server](#BKMK_Backupthesourceserver)  
  
-   [Prepare the source server](#BKMK_PreparetheSourceServer)  
  
-   [Prepare other computers in the enterprise](#BKMK_PreparetheOtherComputersintheEnterprise)  
  
> [!IMPORTANT]  
> Before you run the **Import\-SmigServerSetting**, **Export\-SmigServerSetting**, or **Get\-SmigServerFeature** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with domain users or groups who are members of local groups on the source server.  
>   
> Before you run the **Send\-SmigServerData** or **Receive\-SmigServerData** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with those domain users who have rights to files or shares that are being migrated.  
  
### <a name="BKMK_Preparethedestinationserver"></a>Prepare the destination server  
Use the following information to prepare the destination server for migration.  
  
#### Hardware requirements for the destination server  
Verify that the data locations for the destination server have sufficient free space to migrate the data. Ensure that the destination server hard disk drives are the same size or larger than the source server hard disk drives.  
  
#### Software requirements for the destination server  
There are several software requirements that must be met to ensure a successful migration.  
  
-   Consult the migration matrix to determine if you can migrate the version of Windows Server that you are running on the source server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For a complete list of supported operating systems, see [Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md).  
  
-   Before migration, install all critical updates and service packs on the source server that were released before [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It is a recommended best practice that you install all current critical updates and service packs on the source server and the destination server.  
  
#### Prepare for local user and group migration on the destination server  
Verify that the destination server can resolve the names of domain users who are members of the local group during the import operation. If the source server and destination server are in different domains, the destination server must be able to contact a global catalog server for the forest in which the source domain user accounts are located.  
  
#### Prepare for File and Storage Services on destination server  
  
1.  Install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the destination server.  
  
2.  Ensure that the time and date are set correctly on the destination server, and that they are in sync with the source server.  
  
3.  Determine the File Services role services that have been installed on the source server and then install the same File and Storage Services role services on the destination server.  
  
4.  Install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the destination server.  
  
    For more information about how to install [!INCLUDE[wsmt](../Token/wsmt_md.md)], see [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
5.  Open UDP port 7000 and make sure that it is not in use by other applications. This port is used by **Send\-SmigServerData** and **Receive\-SmigServerData** to establish a data transfer connection.  
  
    > [!NOTE]  
    > If you have changed the default behavior of Windows Firewall to block outbound traffic on computers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must explicitly allow outbound traffic on UDP port 7000.  
  
6.  Open TCP port 7000 and make sure that it is not in use by other applications. This port is used by **Send\-SmigServerData** and **Receive\-SmigServerData** to perform the data transfer.  
  
    For more information about how to open UDP port 7000 and TCP port 7000, see [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md).  
  
    For more information about how to determine if a port is in use, see [How To Determine Which Program Uses or Blocks Specific Transmission Control Protocol Ports in Windows Server 2003](http://go.microsoft.com/fwlink/?LinkId=149887).  
  
7.  Verify that the destination path has sufficient disk space to migrate the data. If NTFS or folder quota management \(in File Server Resource Manager\) is enabled on the destination server disk drive, verify that the quota limit allows for sufficient free disk space to migrate data. For more information about quota management in File Server Resource Manager, see one of the following:  
  
    -   [Quota Management](http://go.microsoft.com/fwlink/?LinkId=154277) for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
    -   [Quota Management](http://go.microsoft.com/fwlink/?LinkId=154241) for Windows Server 2003 R2  
  
    For more information about NTFS quota management, see one of the following.  
  
    -   [Setting Disk Quotas](http://go.microsoft.com/fwlink/?LinkId=154243) for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
    -   [Enable disk quotas](http://go.microsoft.com/fwlink/?LinkId=154245) for Windows Server 2003 R2 and Windows Server 2003  
  
#### Prepare File Server Resource Manager on destination server  
If you are using File Classification Infrastructure plug\-ins from a non\-Microsoft vendor, you should register the non\-Microsoft plug\-ins on the destination server and refer to additional instructions for migration from the non\-Microsoft plug\-in vendor. You should register the plug\-in after File Server Resource Manager \(FSRM\) has been installed and started on the destination server.  
  
Use the same drive letters for the destination server volumes as for the source server. This is required, because FSRM migration requires the drive letter to remain the same.  
  
#### Data and file share preparation on destination server  
Do not allow users to access the destination server until migration is fully completed. This ensures data integrity and prevents failure when an open file on the destination server cannot be overwritten during migration.  
  
#### Data integrity and security considerations on destination server  
Server migration tools preserve file and folder permissions during data migration. When you are planning the migration, keep in mind that if the migrated files and folders inherit permissions from their parents, during migration it is the inheritance setting that is migrated, not the inherited permissions. Therefore, it is important to make sure that the parent folders on the source server and the destination server have the same permissions to maintain the permissions on migrated data that has inherited permissions.  
  
For example:  
  
1.  Migrate folder **c:\\A\\C** from the source server to folder **c:\\B\\D** on the destination server.  
  
2.  Verify that on the source server, only Mary has access to folder **c:\\A** and folder **c:\\A\\C** is specified to inherit permission from its parent.  
  
3.  Verify that on the destination server, only John has access to folder **c:\\B**. After **c:\\A\\C** is migrated to **c:\\B\\D**, John will have access to folder **D**, but Mary will not.  
  
If you use permissions inheritance for the migrated data, ensure that the parent folder for the migrated data on the destination server has the required permission set.  
  
#### Prepare DFS Namespaces on destination server  
The DFS Namespaces role service must be installed, and the DFS Namespace service must be running before migration. If the namespaces that you are migrating are domain\-based, both source and destination servers must be in the same Active Directory Domain Services \(AD DS\) domain. If the namespaces are stand\-alone namespaces, AD DS membership does not matter.  
  
### <a name="BKMK_Backupthesourceserver"></a>Back up the source server  
If DFS Namespaces are being migrated, back up the source server by using a full server backup or system state backup. If the DFS Namespaces are part of an AD DS domain, you need to back up the AD DS domain to save the Active Directory configuration information for DFS Namespaces.  
  
For each domain\-based DFS namespace, you should also back up the configuration information for the namespace. Repeat the following command for each namespace and save the output file name to a safe location:  
  
```  
DFSUtil.exe root export <\\<DomainName>\Namespace> <Filename>  
```  
  
> [!NOTE]  
> DFSUtil.exe is available on computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. It is available to download for use on Windows Server 2003 R2 and Windows Server 2003 as part of the [Windows Server 2003 Service Pack 1 32\-bit Support Tools](http://go.microsoft.com/fwlink/?LinkId=147453).  
  
### <a name="BKMK_PreparetheSourceServer"></a>Prepare the source server  
The following sections describe how to prepare the source server for the migration.  
  
#### Prepare all file services on source server  
  
-   Install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the source server.  
  
    For more information about how to install [!INCLUDE[wsmt](../Token/wsmt_md.md)], see [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
-   Verify that the time and date are set correctly on the destination server and that they are synchronized with the source server.  
  
-   Open UDP port 7000 and make sure that is not in use by other applications. This port is used by **Send\-SmigServerData** and **Receive\-SmigServerData** to establish a data transfer connection.  
  
    > [!NOTE]  
    > If you have changed the default behavior of Windows Firewall to block outbound traffic on computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must explicitly allow outbound traffic on UDP port 7000.  
  
-   Open TCP port 7000 and make sure that it is not in use by other applications. This port is used by **Send\-SmigServerData** and **Receive\-SmigServerData** to perform the data transfer.  
  
For more information about how to open UDP port 7000 and TCP port 7000, see [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md).  
  
For more information about how to determine if a port is in use, see [How To Determine Which Program Uses or Blocks Specific Transmission Control Protocol Ports in Windows Server 2003](http://go.microsoft.com/fwlink/?LinkId=149887).  
  
#### Data and file share preparation on the source server  
To minimize downtime and reduce impact to users, plan your data migration to occur during off\-peak hours. Use the `net share` command to list all file shares on the source server.  
  
You can use this list during the verification step to verify that all the required file shares have migrated. Reparse points and hard links will not migrate when data is copied \(versus a physical migration\), and the reparse points need to be migrated manually. When you migrate hard links, a separate file is created on the destination server for each link. If your migration involves copying the data to the destination server, follow the instructions for how to detect the reparse points and hard links in [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md). Afterward, you can remap and recreate them during migration, as instructed in the [Copy Data Migration](#BKMK_Copydatamigrationscenarios) section.  
  
#### Prepare DFS on the source server  
DFS Namespaces role services must be installed, and the DFS Namespace service must be running before migration.  
  
For information about DFS Namespaces preparation, see [Prepare DFS namespaces on source server](#BKMK_PrepareDFSnamespacesonsourceserver).  
  
#### <a name="BKMK_PrepareDFSnamespacesonsourceserver"></a>Prepare DFS Namespaces on source server  
For domain\-based namespaces with one namespace server, determine if you will add a temporary server to the namespace or if you will perform a manual inventory of the namespace permissions.  
  
-   Option 1 \(recommended\):  
  
    Add a temporary server as a namespace server to each domain\-based namespace on the source server when the source server is the only namespace server.  
  
-   Option 2:  
  
    Inventory the permissions for managing each of the namespaces that are hosted on the source server when the source server is the only namespace server. This process can be completed by using the DFS Management MMC Snap\-in.  
  
### <a name="BKMK_PreparetheOtherComputersintheEnterprise"></a>Prepare other computers in the enterprise  
Data and file share migration requires preparing other computers in the enterprise. Perform the following steps for copy data migration scenarios, and for physical data scenarios.  
  
#### <a name="BKMK_Copydatamigrationscenarios"></a>For copy data migration scenarios  
  
-   Notify the users that the server performance may be reduced during the first phase of data migration.  
  
-   Ask users to stop writing to the server before the second phase of data migration begins \(to prevent possible data loss\). We recommend that you prevent access to the file shares so that users do not ignore this advice. For example, you could temporarily set all file shares to be read\-only by setting the share permissions to Everyone \= Read Only.  
  
-   Notify users that they cannot access their files on the server when the second phase of the migration begins until the file server migration is fully completed.  
  
#### For physical data migration scenarios  
Notify the users that they cannot access the file server from the moment the storage is disconnected from the source server until the server migration is fully completed.  
  
## See also  
  
-   [Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
  
-   [File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
  
-   [File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
  
-   [File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
  
-   [File and Storage Services: Migrate Network File System](../Topic/File-and-Storage-Services--Migrate-Network-File-System.md)  
  
-   [File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
  
-   [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
  
-   [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
