---
title: Step 3: Migrate WSUS
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb419453-0255-4b1a-b425-981c22fcb7ea
author: britw
---
# Step 3: Migrate WSUS
During the third step in the migration of your Windows Server Update Services \(WSUS\) server role, you will migrate binaries and security groups, back up the database, change the server identity, and apply security settings The following checklist describes the steps involved.  
  
|Task|Description|  
|--------|---------------|  
|[3.1. Migrate WSUS update binaries](../Topic/Step-3--Migrate-WSUS.md#BKMK_3.1)|Move WSUS update binaries from the source server to the destination server.|  
|[3.2. Migrate WSUS security groups](../Topic/Step-3--Migrate-WSUS.md#BKMK_3.2)|Migrate local users and groups manually or by using Windows Server Migration Tools.|  
|[3.3. Back up the WSUS database](../Topic/Step-3--Migrate-WSUS.md#BKMK_3.3.)|Use SQL Server Management Studio to back up and restore the WSUS database, computer groups, update approvals, and WSUS settings.|  
|[3.4. Change the WSUS server identity](../Topic/Step-3--Migrate-WSUS.md#BKMK_3.4)|Change the WSUS server identity on the destination server. Performing this step ensures that there is no effect on clients that are managed by WSUS during the migration process.|  
|[3.5. Apply security settings](../Topic/Step-3--Migrate-WSUS.md#BKMK_3.5)|Configure security settings on the new server. This includes configuring security settings on the destination server that you were using on the source server.|  
|[3.6. Review additional considerations](../Topic/Step-3--Migrate-WSUS.md#BKMK_3.6)|Review some additional actions that you should take after the migration is complete.|  
  
## <a name="BKMK_3.1"></a>3.1. Migrate WSUS update binaries  
Use your preferred method to copy WSUS update binaries in the WSUS folder from the source server to the destination server \(for example, Windows Server Migration Tools, Windows Explorer, Xcopy, or Robocopy\). If you decide to use Windows Server Migration Tools to migrate WSUS update binaries to a destination server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [Migrate WSUS Update Binaries from the Source Server to the Destination Server Using Windows Server Migration Tools](http://technet.microsoft.com/library/ee822836(WS.10).aspx).  
  
> [!IMPORTANT]  
> Migrating WSUS update binaries is unnecessary if update files are stored on Microsoft Update.  
  
## <a name="BKMK_3.2"></a>3.2. Migrate WSUS security groups  
You have the option of manually migrate only the WSUS Administrators and WSUS Reporters local security groups. Or, you can use Windows Server Migration Tools to migrate all local users and groups \(including the WSUS Administrators and WSUS Reporters local security groups\) from the source server to the destination server.  
  
> [!WARNING]  
> The WSUS Server Migration Tools can be installed on the server using the Server Manager Add Features option.  
  
Before you perform this procedure, verify that the destination server can resolve the names of domain users who are members of the local group during the import operation. If the source and destination servers are in different domains, the destination server must be able to contact a global catalog server for the forest in which the source domain user accounts are located. Use the following guidelines:  
  
-   **If the source server is a member of the domain and the destination server is a domain controller**: Imported local users are elevated to domain users, and imported local groups become Domain Local groups on the destination server.  
  
-   **If the source server is a domain controller, and the destination server is not**: Domain Local groups are migrated as local groups, and domain users are migrated as local users.  
  
Use the following procedure to manually migrate users to the WSUS Administrators and WSUS Reporters local security groups.  
  
#### To manually migrate local users and groups  
  
1.  Right\-click in the Taskbar, click **Properties**, highlight **Toolbars**, and then click **Address**.  
  
2.  Type **lusrmgr.msc**, and then press ENTER.  
  
3.  In the console tree of the Local Users and Groups MMC snap\-in, double\-click **Users**.  
  
4.  Manually create a list of the local users.  
  
5.  In the console tree of the Local Users and Groups MMC snap\-in,  double\-click **Groups**.  
  
6.  Manually add the users from the source server to the WSUS Administrators and WSUS Reporters groups.  
  
Use the following procedure to use Windows Server Migration Tools to migrate users to the WSUS Administrators and WSUS Reporters local security groups.  
  
#### To use Windows Server Migration Tools to migrate users  
  
1.  Open a Windows PowerShell session on the source server and on the destination server.  
  
2.  Type the command below and press ENTER:  
  
    `Add-PSSnapin Microsoft.Windows.ServerManager.Migration`  
  
3.  In the Windows PowerShell session on the source server, type the following command to export local users and groups to a migration store:  
  
    `Export-SmigServerSetting -User <Enabled | Disabled | All> -Group -Path <MigrationStorePath> -Verbose`  
  
    *MigrationStorePath* represents the path of the location where you want to store migrated data. You can also use one of the following values with the **\-User** parameter:  
  
    -   **Enabled**: Export only enabled local users  
  
    -   **Disabled**: Export only disabled local users  
  
    -   **All**: Export enabled and disabled local users  
  
4.  Press ENTER.  
  
    > [!IMPORTANT]  
    > You are prompted to provide a password to encrypt the migration store. Remember this password, because you must provide the same password to import data from the migration store on the destination server. If the path is not a shared location to which the destination server has access, you must copy the migration store to the destination server manually, or to a location that this destination server can access as it runs the **Import\-SmigServerSetting** cmdlet.  
  
5.  In the Windows PowerShell session on the destination server, type the following command to import local users and groups from the migration store that you created in Step 2:  
  
    `Import-SmigServerSetting -User <Enabled | Disabled | All> -Group -Path <MigrationStorePath> -Verbose`  
  
    *MigrationStorePath* represents the path of the location from which you want to import migrated data. You can also use one of the following values with the **\-User** parameter:  
  
    -   **Enabled**: Export only enabled local users  
  
    -   **Disabled**: Export only disabled local users  
  
    -   **All**: Export enabled and disabled local users  
  
6.  Press ENTER.  
  
    > [!WARNING]  
    > After you enter the **Import\-SmigServerSetting** cmdlet, you are prompted to provide the same password to decrypt the migration store that you created during the export process.  
  
## <a name="BKMK_3.3."></a>3.3. Back up the WSUS database  
WSUS servers can be configured to use Windows Internal Database, the database software that is included with WSUS, or the full version of SQL Server. Regardless of which database option the source server is running, perform the following procedures to back up the WSUS database on the source server and restore the database to the destination server.  
  
For an overview of backup and command\-line syntax, see the following topics in SQL Server TechCenter:  
  
-   [Backup Overview](http://go.microsoft.com/fwlink/?LinkID=161960)  
  
-   [BACKUP \(Transact\-SQL\)](http://go.microsoft.com/fwlink/?LinkID=161961)  
  
For an overview of restore and command\-line syntax, see the following topics in SQL Server TechCenter:  
  
-   [Restore and Recovery Overview](http://go.microsoft.com/fwlink/?LinkID=161963)  
  
-   [RESTORE \(Transact\-SQL\)](http://go.microsoft.com/fwlink/?LinkID=161964)  
  
> [!IMPORTANT]  
> SQL Server Management Studio must be run with elevated administrator permissions throughout this procedure.  
  
#### To back up the WSUS database on the source server  
  
1.  After you connect to the appropriate instance of the database in Object Explorer, click the server name to expand the server tree.  
  
    > [!NOTE]  
    > If the source server is using Windows Internal Database, the query changes depending on which version of WSUS you are currently running. For WSUS 3.2, the query is:   **\\\\.\\pipe\\mssql$microsoft\#\#ssee\\sql\\query**, and for WSUS on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the query is:  **\\\\.\\pipe\\Microsoft\#\#WID\\tsql\\query**.  
  
2.  Expand **Databases**, and select the **SUSDB** database.  
  
3.  Right\-click the database, point to **Tasks**, and then click **Back Up**. The **Back Up Database** dialog box appears.  
  
4.  In the **Database** list, verify the database name.  
  
5.  In the **Backup type** list, select **Full**.  
  
6.  Select **Copy Only Backup**. A copy\-only backup is a SQL Server backup that is independent of the sequence of conventional SQL Server backups.  
  
7.  For **Backup component**, click **Database**.  
  
8.  Accept the default backup set name that is suggested in the **Name** text box, or enter a different name for the backup set.  
  
9. Optionally, in the **Description** text box, enter a description of the backup set.  
  
10. Specify when the backup set will expire and can be overwritten without explicitly skipping verification of the expiration data.  
  
11. Choose the backup destination by clicking Disk.  
  
    > [!IMPORTANT]  
    > To remove a backup destination, select it and then click **Remove**. To view the contents of a backup destination, select it and then click **Contents**.  
  
12. In the **Select a page** pane, click **Options** to view or select the advanced options.  
  
13. On the **Overwrite Media** option, click one of the following:  
  
    -   **Back up to the existing media set** For this option, click **Append to the existing backup set** or **Overwrite all existing backup sets**. Optionally:  
  
        -   Click **Check media set name and backup set expiration** to cause the backup operation to verify the date and time at which the media set and backup set expire.  
  
        -   Enter a name in the **Media set name** text box. If no name is specified, a media set with a blank name is created. If you specify a media set name, the media \(tape or disk\) is checked to see whether the name matches the name that you enter here.  
  
    -   **Back up to a new media set, and erase all existing backup sets** For this option, enter a name in the **New media set name** text box, and, optionally, describe the media set in the **New media set description** text box.  
  
14. In the **Reliability** section, optionally select:  
  
    -   **Verify backup when finished.**  
  
    -   **Perform checksum before writing to media.**  
  
    -   **Continue on checksum error.**  
  
15. SQL Server 2008 Enterprise support backup compression. By default, whether a backup is compressed depends on the value of the **Backup\-compression default** server configuration option. Regardless of the current server\-level default, you can compress the backup or prevent compression at this time. To compress the backup, select **Compress backup**, or to prevent compression, select **Do not compress backup**.  
  
#### To restore the WSUS database backup on the destination server by using SQL Server Management Studio  
  
1.  After you connect to the appropriate instance of the database in Object Explorer, click the server name to expand the server tree.  
  
    > [!IMPORTANT]  
    > If the source server is using Windows Internal Database, the database name is: **\\\\.\\pipe\\Microsoft\#\#WID\\tsql\\query**.  
  
2.  Click **New Query** and copy the following SQL command to drop the WSUS database  
  
    **USE master**GOALTER DATABASE SUSDB SET SINGLE\_USER WITH ROLLBACK IMMEDIATEGODROP DATABASE SUSDBGO  
  
3.  Click **Execute**, to run the query  
  
4.  Run the following query:  
  
    **RESTORE DATABASE \[SUSDB\] FROM  DISK \= N'C:\\SUSDB.bak' WITH  FILE \= 1,  MOVE N'SUSDB' TO N'c:\\Windows\\WID\\Data\\susdb.mdf',  MOVE N'SUSDB\_log' TO N'c:\\Windows\\WID\\Data\\SUSDB\_log.ldf',  NOUNLOAD,  STATS \= 10**  
  
    > [!IMPORTANT]  
    > Drive C: that is used in this example will vary according to the actual storage location for the files.  
  
5.  In the **Backup type** list, select **Full**.  
  
    > [!WARNING]  
    > Running the previous query will result in the following error message:  
    >   
    > **Msg 3605, Level 16, State 1, Line 5**Schema verification failed for database 'SUSDB'.Msg 3013, Level 16, State 1, Line 5RESTORE DATABASE is terminating abnormally  
    >   
    > Disregard the error message and continue.  
  
6.  Open an elevated command prompt in Windows Server 2012, and run the following command:  
  
    **%programfiles%\\update services\\tools\\wsusutil postinstall \[sql parameter\] \[content parameter\]**  
  
    > [!IMPORTANT]  
    > For WID, do not specify the SQL parameter.  
  
#### To restore the WSUS database backup on the destination server by using SQL Server Management Studio  
  
1.  After you connect to the appropriate instance of the database in **Object Explorer**, click the server name to expand the server tree.  
  
    > [!IMPORTANT]  
    > If the source server is using Windows Internal Database, the database name is *\\\\.\\pipe\\Microsoft\#\#WID\\tsql\\query*.  
  
2.  Click **New Query** and copy the following SQL command to drop the WSUS database \(SUSDB\):  
  
    `USE master`  
  
    `GO`  
  
    `ALTER DATABASE SUSDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE`  
  
    `GO`  
  
    `DROP DATABASE SUSDB`  
  
    `GO`  
  
3.  Click **Execute** to run the query.  
  
4.  Run the following query:  
  
    `RESTORE DATABASE [SUSDB] FROM  DISK = N'C:\SUSDB.bak' WITH  FILE = 1,  MOVE N'SUSDB' TO N'c:\Windows\WID\Data\susdb.mdf',  MOVE N'SUSDB_log' TO N'c:\Windows\WID\Data\SUSDB_log.ldf',  NOUNLOAD,  STATS = 10`  
  
    > [!IMPORTANT]  
    > Drive C: that is mentioned in this example will vary according to the actual storage location for the files.  
  
5.  This will result in the following error message:  
  
    `Msg 3605, Level 16, State 1, Line 5`  
  
    `Schema verification failed for database 'SUSDB'.`  
  
    `Msg 3013, Level 16, State 1, Line 5`  
  
    `RESTORE DATABASE is terminating abnormally`  
  
    Disregard the error message and continue.  
  
6.  Open an elevated command prompt in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and run the following command:  
  
    `%programfiles%\update services\tools\wsusutil postinstall [sql parameter] [content parameter]`  
  
    > [!IMPORTANT]  
    > For WID, do not specify the SQL parameter.  
  
When a database is restored to a different server, it contains a set of users and permissions, although there may be no corresponding user log on information, or the log on information may not be associated with the same users. This condition is known as having "orphaned users." See [article 168644](http://go.microsoft.com/fwlink/?LinkID=168644) in the Microsoft Knowledge Base for instructions about how to resolve orphaned users.  
  
After you restore a SQL Server 2005 database to SQL Server 2008, the database becomes available immediately, and it is then automatically upgraded.  
  
## <a name="BKMK_3.4"></a>3.4. Change the WSUS server identity  
The WSUS server identity on the destination server must be changed. Performing this step guarantees that WSUS\-managed clients are not affected during the migration process. If the source server and the destination server run with the same identity, and a change is made to one of the servers, the communication between the client and server will fail.  
  
#### To change the WSUS server identity  
  
1.  On the destination server, open a Windows PowerShell session with elevated user rights and run the following script:  
  
    `$updateServer = get-wsusserver`  
  
    `$config = $updateServer.GetConfiguration()`  
  
    `$config.ServerId = [System.Guid]::NewGuid()`  
  
    `$config.Save()`  
  
2.  As soon as the server identity is changed, run the following command  to generate a new encryption key:  
  
    `%ProgramFiles%\Update Services\Tools\wsusutil.exe postinstall`  
  
## <a name="BKMK_3.5"></a>3.5. Apply security settings  
Refer to the settings that you recorded in the [Migration Data Collection Worksheet](http://technet.microsoft.com/library/ee822828(WS.10).aspx), and then complete the following tasks to apply the security settings that you were using on the source server to the destination server.  
  
-   **SMTP server settings**: If you are using an authenticating proxy or the email notification feature to an SMTP server that requires a password \(or both\), you must manually configure the proxy and email notification to the SMTP server, and enter the SMTP password on the new destination server if you are using email notification.  
  
-   **Code signing certificate**: If you are using an advanced management tool that exposes local update publishing \(such as Microsoft System Center Essentials 2007 or Microsoft System Center Configuration Manager 2007\), copy the code\-signing certificate.  
  
To initialize a trust relationship between the update server and its clients, use the following procedures to point the downstream servers to the new WSUS server, and point the WSUS clients to the new WSUS server.  
  
### Point the downstream servers to the new WSUS server  
If you have downstream servers in your WSUS configuration, and if the server identity on the destination server was changed, perform the following procedure to point them to the new WSUS server.  
  
##### To connect a downstream server to an upstream server  
  
1.  In the navigation pane of the downstream WSUS Server Administration console, click **Options**.  
  
2.  Click **Update Source and Proxy Server**, and then click the **Update Source** tab.  
  
3.  Select the **Synchronize from another Windows Server Update Services server** check box, and then type the server name and port number in the corresponding text boxes.  
  
4.  Repeat step 1 through step 3 for additional downstream servers, if applicable. The synchronization can take several minutes to several hours to finish.  
  
5.  To confirm that the downstream servers are synchronizing with the upstream server, in the WSUS Administration Console on the upstream WSUS server, click **Downstream Servers**. In the **Status** pane, confirm that the server’s **Last Synchronization** date is after the date that the previous steps were completed.  
  
### Point the WSUS clients to the new WSUS server  
If the server identity on the destination server was changed, use the following procedure to point the WSUS clients to the new WSUS destination server.  
  
##### To point the WSUS clients to the new destination server  
  
1.  Open the Local Group Policy Editor, and in **Specify intranet Microsoft update service policy**, change the URL to reflect the new WSUS server.  
  
2.  Update the Group Policy settings that are used to point WSUS clients to the WSUS server by entering the FQDN of the new WSUS server. After you have updated the Group Policy settings, WSUS clients will synchronize with the new WSUS server.  
  
3.  To force the clients to detect the new destination server, open a command prompt, and run `wuauclt.exe /resetauthorization /detectnow`.  
  
    > [!NOTE]  
    > To make sure that WSUS clients point to the new WSUS server immediately, you must force detection, which causes WSUS to update computer group membership. If you do not force a detection, it can take up to four hours for clients to point to the new WSUS server.  
  
4.  Depending on the number of clients, the initial synchronization can take several minutes to several hours to finish. To confirm that the synchronization is complete, in the WSUS Administration Console, expand **Computers**, and then click **All Computers**. In the **Status** pane, click **Any**, and then click **Refresh**. Confirm that the computers that you expect to see synchronizing to this WSUS server are listed. The **Last Contact Date** has to be refreshed with a post\-migration time stamp.  
  
    > [!TIP]  
    > To force a report that the **Last Contact Date** was updated, run `wuauclt.exe /resetauthorization /detectnow`, and then run `wuauclt.exe /reportnow`.  
  
5.  After the clients have synchronized, confirm that clients are installing approved updates based on your WSUS configuration settings. In the WSUS Administration Console, click **Reports**, and then click **Computer Tabular Status**. Select the **Report Options** that are applicable to the clients, and then click **Run Report**.  
  
6.  To make sure that no WSUS clients are still pointing at the old WSUS server, wait a week and then open the WSUS Administration Console on the old WSUS server. Expand **Computers**, and then click **All Computers**. In the **Status** pane, click **Any**, and then click **Refresh**. Sort on **Last Status Report**. There should be no clients that have a **Last Status Report** date after the date that the synchronization completed.  
  
## <a name="BKMK_3.6"></a>3.6. Review additional considerations  
After the migration is complete, consider the following:  
  
-   It is important to have a backup plan for restoring the WSUS server role if there is a migration failure. You do not need to roll back the migration on the source server because the migration process makes no changes to it. You do not need to roll back the migration on the destination server because it is a new server.  
  
-   After you have confirmed that no WSUS clients are contacting the old WSUS server, you can uninstall WSUS from the source server. To perform this operation, see the section titled **Retire the WSUS role on the source server \(optional\)** in the Windows Server Update Services 3.0 SP2 Migration Guide topic: [Post\-migration Tasks for WSUS](http://technet.microsoft.com/library/ee822827(WS.10).aspx).  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 4: Verify the WSUS Migration](../Topic/Step-4--Verify-the-WSUS-Migration.md)  
  
-   [Step 2: Prepare to Migrate WSUS](../Topic/Step-2--Prepare-to-Migrate-WSUS.md)  
  
-   [WSUS server role description](assetId:///77f5db8a-4b8f-4bd5-8493-387310adf46e#BKMK_OVER)  
  
