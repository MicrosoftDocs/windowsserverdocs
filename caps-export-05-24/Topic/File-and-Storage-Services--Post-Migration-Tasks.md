---
title: File and Storage Services: Post-Migration Tasks
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e0beed9-102d-4567-8a13-ece204b20d02
---
# File and Storage Services: Post-Migration Tasks
This topic explains how to complete the migration if it was successful, and how to roll back or troubleshoot the migration if it failed.  
  
## Completing the migration  
After you verify the migration, you can retire the source server.  
  
### Retire File and Storage Services on the source server  
After you complete and verify the migration, the source server can be shut down or disconnected from the network.  
  
#### Remove DFS Namespaces from the source server  
The procedure you use to remove DFS Namespaces from the source server depends on whether the namespaces are stand\-alone or domain\-based. If you want to remove the namespace from the source server, you must use **DFSUtil.exe**.  
  
> [!NOTE]  
> By default, clients cache the list of namespace servers for 300 seconds \(five minutes\), so we recommend that you do not run the **DFSUtil.exe remove** command within five minutes of completing verification of the DFS namespace migration. During migration, clients have only the temporary server in the cache of namespace servers. Waiting five minutes after you add the destination server to the namespace allows clients to list the destination server in their cache.  
  
###### To remove stand\-alone namespaces  
  
1.  Open a Command Prompt window on the destination server.  
  
2.  Type the following code, and then press Enter.  
  
    ```  
    Dfsutil.exe root remove <\\SourceServer\Namespace>  
    ```  
  
###### To remove domain\-based namespaces with one namespace server  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Type the following, and then press **Enter**.  
  
    ```  
    DFSUtil.exe target remove <\\TemporaryServer\Namespace>  
    ```  
  
> [!NOTE]  
> This procedure applies only if a temporary server was added to the namespace for migration purposes. For domain\-based namespaces with more than one namespace server, no additional actions are required.  
  
## Restoring File and Storage Services in the event of migration failure  
The following sections describe how to restore the File and Storage Services server role in the event of migration failure.  
  
### Roll back DFS Namespaces  
The steps that you perform to roll back DFS Namespaces depend on whether the namespaces are stand\-alone or domain\-based, and whether a temporary namespace was created during the migration process.  
  
##### To roll back DFS Namespaces \(do one of the following\)  
  
1.  For stand\-alone namespaces, no action is required other than migrating the identity back to the source server.  
  
2.  For domain\-based namespaces with more than one namespace server, or if a temporary server was added to a namespace that initially had only one namespace server, do the following:  
  
    1.  Remove the destination server from the namespace.  
  
    2.  Migrate identity and shared folder information to the source server.  
  
    3.  Add the source server to the namespace.  
  
3.  For domain\-based namespaces with only one namespace server, where no temporary namespace server was added during migration, do the following:  
  
    1.  Migrate identity and shared folder information to the source server.  
  
    2.  Verify that the export file for the namespace that was created during migration is still available.  
  
    3.  Delete the namespace.  
  
    4.  Create the namespace on the source server.  
  
    5.  Import the namespace configuration from the export file created during the migration.  
  
    6.  Manually reset delegation permissions to the namespace.  
  
> [!NOTE]  
> Another option to migrate domain\-based namespaces with one namespace server is to temporarily add a second namespace server before the migration, and then remove the temporary server after the migration.  
  
### Roll back data and shared folders  
If no changes have been made to migrated files, folders, and shared folders on the destination server and this data has not been deleted from the source server, no additional steps to roll back data and shared folders are required.  
  
If the migrated files, folders, or shared folders may have been modified on the destination server by the administrators or users, perform the following steps to synchronize the changes from the destination server back to the source server:  
  
1.  Type the following command in a Command Prompt window to copy the updated migrated data \(files and folders\) from the destination server back to the source server:  
  
    ```  
    robocopy <copy from path> <copy to path> /E  
    ```  
  
    This command can be executed on the source server or on the destination server, and it will recursively copy updated data. Type `robocopy /?` in a Command Prompt window for additional copy options, including options to copy file and folder permissions.  
  
    > [!CAUTION]  
    > Permissions that you set for nondefault local users and groups will not copy properly and need to be created manually.  
  
2.  Compare the lists of shared folders and their permissions on the source server and destination server and manually synchronize any changes.  
  
    To list all shared folders and their permissions, type the following command in a Windows PowerShell session that has been opened with elevated user rights:  
  
    ```  
    gwmi win32_share | %{net share $_.name}  
    ```  
  
### Roll back migration on the other computers in the enterprise  
If the migration failed, verify that the other computers in the enterprise can access the source server after you roll back the migration data.  
  
## Troubleshooting migration issues  
Troubleshooting tips include the following:  
  
-   For physical migration issues:  
  
    When some files are migrated physically and others are copied, there is a chance that the File Server Resource Manager configuration is not synchronized. To remedy this, delete and create new copies of the Quota.md and Datascrn.md files.  
  
-   For domain\-joined computers:  
  
    If a custom action \(quota notification or file management task\) fails to execute with an access\-denied failure and a corresponding event log, you should remove the custom action and create it on the destination server.  
  
### Troubleshoot data migration that does not complete  
If the **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets run indefinitely without completing, your destination server might not have sufficient disk space or a large enough File Server Resource Manager or NTFS quota limit to allow for data migration to finish. To determine whether insufficient disk space is preventing the data send\-receive process from completing, do the following on the destination server.  
  
##### To troubleshoot incomplete data migration  
  
1.  Open %*localappdata*%\/Svrmig\/Log\/SetupAct.log.  
  
2.  Review the most recent log entries. If the following exception occurs, your destination server has insufficient disk space or File Server Resource Manager or NTFS quota limits to complete data migration.  
  
    `Win32Exception: unable to write to FileStream: There is not enough space on the disk.`  
  
##### To resolve this issue, do the following  
  
1.  Press Ctrl\+C to cancel **Send\-SmigServerData** and **Receive\-SmigServerData** on both source and destination servers.  
  
2.  Check for sufficient disk space on the destination server’s hard disk drive. If the destination server’s hard disk drive has insufficient space, do one of the following:  
  
    -   Clear additional space.  
  
    -   Identify a different hard disk drive that has sufficient space.  
  
3.  If the destination server’s hard disk drive, the destination path, or any folders that contain the destination path have a File Server Resource Manager or NTFS quota enabled, and the quota limit does not allow for sufficient disk space to migrate data, do one of the following:  
  
    -   Increase the quota limit to set sufficient disk space to migrate the data. For more information about FSRM quota management, see one of the following.  
  
        -   [Quota Management](http://go.microsoft.com/fwlink/?LinkId=154277) for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
        -   [Quota Management](http://go.microsoft.com/fwlink/?LinkId=154241) for Windows Server 2003 R2  
  
        For more information about NTFS quota management, see one of the following.  
  
        -   [Setting Disk Quotas](http://go.microsoft.com/fwlink/?LinkId=154243) for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
        -   [Enable disk quotas](http://go.microsoft.com/fwlink/?LinkId=154245) for Windows Server 2003 R2 and Windows Server 2003  
  
    -   Identify a different hard disk drive that already has sufficient space and File Server Resource Manager or NTFS quota limits.  
  
4.  Run the **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets again, specifying a destination path that has sufficient disk space, and large enough File Server Resource Manager or NTFS quota limits, if applicable.  
  
### Troubleshoot data migration connectivity  
If the **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets cannot establish connectivity, verify the following conditions and then try again:  
  
1.  In the **Send\-SmigServerData** command on the source server, the *ComputerName* parameter correctly specifies the name of the destination server.  
  
2.  The **Receive\-SmigServerData** and **Send\-SmigServerData** commands are entered on the destination server and the source server respectively within five minutes of one another. This is the default maximum connection timeout for **Send\-SmigServerData** and **Receive\-SmigServerData**. You can change the maximum connection timeout for the **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets by modifying the following user\-defined registry subkey on the source server and destination server.  
  
    Subkey: **\\HKEY\_Local\_Machine\\Software\\Microsoft\\ServerMigration**  
  
    Value: MaxConnectionTime  \(REG\_DWORD\)  
  
    Data: Between 1 and 3600 \(represents the connection time\-out in seconds\). If a value larger than 3600 is specified, 3600 seconds is used as the maximum connection time\-out.  
  
    For information about how to create a Windows Registry key, see [Add a Registry Key](http://go.microsoft.com/fwlink/?LinkId=147298).  
  
3.  The same password is entered on the source server and destination server.  
  
4.  The source server and destination server are available on the same subnet:  
  
    1.  On the destination server, in a Command Prompt window, type `ipconfig` and note the subnet mask value.  
  
    2.  On the source server, in a Command Prompt window, type `ipconfig` and note the subnet mask value.  
  
    3.  Ensure that the subnet mask values are the same on the source server and destination server.  
  
5.  Port 7000 is open on the source and destination server and is not in use by another application.  
  
    1.  To check if port 7000 is open, in a Command Prompt window, enter the command:  
  
        ```  
        netsh firewall show portopening  
        ```  
  
        If port 7000 is not in the list, follow the instructions in [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md) to open port 7000.  
  
    2.  If port 7000 is open, type the following command to check if port 7000 is being used by another application:  
  
        ```  
        netstat  
        ```  
  
        -   In the Local Address column, you will see *<IP Address>*: *<port number>*.  
  
        -   If port 7000 is in the list, it is being used by another application.  
  
### Troubleshoot unexpected Windows PowerShell session closure  
If a migration cmdlet fails and the Windows PowerShell session closes unexpectedly with an access violation error message, look for a message similar to the following example in the %*localappdata*%\\SvrMig\\Logs\\setuperr.log file.  
  
`FatalError [0x090001] PANTHR Exception (code 0xC0000005: ACCESS_VIOLATION) occurred at 0x000007FEEDE9E050 in C:\Windows\system32\migwiz\unbcl.dll (+000000000008E050). Minidump attached (317793 bytes).`  
  
This failure occurs when the server cannot contact domain controllers that are associated with domain users or groups who are members of local groups, or who have rights to files or shares that are being migrated. When this happens, each domain user or group is displayed in the GUI as an unresolved security identifier \(SID\). An example of a SID is **S\-1\-5\-21\-1579938362\-1064596589\-3161144252\-1006**.  
  
To prevent this problem, verify that required domain controllers or global catalog servers are running, and that network connectivity allows communication between both source and destination servers and required domain controllers or global catalog servers. Then, run the cmdlets again.  
  
##### If connections between either the source or destination servers and the domain controllers or global catalog servers cannot be restored, do the following  
  
1.  Before you run **Export\-SmigServerSetting**, **Import\-SmigServerSetting**, or **Get\-SmigServerFeature** again, remove all unresolved domain users or groups who are members of local groups from the server on which you are running the cmdlet.  
  
2.  Before you run **Send\-SmigServerData** or **Receive\-SmigServerData** again, remove all unresolved domain users or groups who have user rights to files, folders, or shares on the migration source server.  
  
### <a name="bkmk_deploymentlogfile"></a>Locate the deployment log file  
The [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment log file is located at %windir%\\Logs\\SmigDeploy.log. Additional [!INCLUDE[wsmt](../Token/wsmt_md.md)] log files are created at the following locations:  
  
-   `%windir%\Logs\ServerMigration.log`  
  
-   On [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]: `%localappdata%\SvrMig\Log`  
  
-   On Windows Server 2003: `%userprofile%\Local Settings\Application Data\SvrMig\Log`  
  
If migration log files are not created in the preceding locations, ServerMigration.log and SmigDeploy.log are created in `%temp%`, and other logs are created in `%windir%\System32`.  
  
### <a name="bkmk_migrationtoolsresultobjects"></a>View the content of Windows Server Migration Tools result objects  
All [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets return results as objects. You can save result objects and query them for more information about the settings and data that were migrated. You can also use result objects as input for other Windows PowerShell commands and scripts.  
  
#### Result object descriptions  
The **Import\-SmigServerSetting** and **Export\-SmigServerSetting** cmdlets in [!INCLUDE[wsmt](../Token/wsmt_md.md)] return results in a list of **MigrationResult** objects. Each **MigrationResult** object contains information about the data or setting that the cmdlet processes, the result of the operation, and any related error or warning messages. The following table describes the properties of a **MigrationResult** object.  
  
|Property Name|Type|Definition|  
|-----------------|--------|--------------|  
|ItemType|Enum|The type of item being migrated. Values include **General**, **WindowsFeatureInstallation**, **WindowsFeature**, and **OSSetting**.|  
|ID|String|The ID of the migrated item. Examples of values include **Local User**, **Local Group**, and **DHCP**.|  
|Success|Boolean|The value **True** is displayed if the migration was successful; otherwise, **False** is displayed.|  
|DetailsList|List <MigrationResultDetails>|A list of **MigrationResultDetails** objects.|  
  
**Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets return results in a list of **MigrationDataResult** objects. Each **MigrationDataResult** object contains information about the data or shared folder that the cmdlet processes, the result of the operation, any error or warning messages, and other related information. The following table describes the properties of a **MigrationDataResult** object.  
  
|Property Name|Type|Definition|  
|-----------------|--------|--------------|  
|ItemType|Enum|The type of migrated item. Values include **File**, **Folder**, **Share**, and **Encrypted File**.|  
|SourceLocation|String|The source location of the item, shown as a path name.|  
|DestinationLocation|String|The destination location of the item shown as a path name.|  
|Success|Boolean|The value **True** is displayed if the migration was successful; otherwise, **False** is displayed.|  
|Size|Integer|The item size, in bytes.|  
|ErrorDetails|List <MigrationResultDetails>|A list of **MigrationResultDetails** objects.|  
|Error|Enum|Errors enumeration for errors that occurred.|  
|WarningMessageList|List <String>|A list of warning messages.|  
  
The following table describes the properties of objects within the **MigrationResultDetails** object that are common to **MigrationResult** and **MigrationDataResult** objects.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|FeatureId|String|The name of the migration setting that is related to the item. Examples of values include **IPConfig** and **DNS**. This property is empty for data migration.|  
|Messages|List <String>|A list of detailed event messages.|  
|DetailCode|Integer|The error or warning code associated with each event message.|  
|Severity|Enum|The severity of an event, if events occurred. Examples of values include **Information**, **Error**, and **Warning**.|  
|Title|String|Title of the result object. Examples of values include the physical address of the network adapter for IP configuration, or the user name for local user migration.|  
  
#### Examples  
The following examples show how to store the list of the result objects in a variable, and then use the variable in a query to return the content of result objects after the migration is complete.  
  
###### To store a list of result objects as a variable for queries  
  
1.  To run a cmdlet and save the result in a variable, type a command in the following format, and then press **Enter**.  
  
    **$***VariableName***\=** $\(*Cmdlet*\)  
  
    The following is an example.  
  
    **$ImportResult \= $\(Import\-SmigServerSetting \-FeatureId DHCP \-User all \-Group \-Path D:\\rmt\\DemoStore \-force \-Verbose\)**  
  
    This command runs the **Import\-SmigServerSetting** cmdlet with several parameters specified, and then saves result objects in the variable **ImportResult**.  
  
2.  After the **Import\-SmigServerSetting** cmdlet has completed its operations, return the information contained in the result object by typing a command in the following format, and then pressing **Enter**.  
  
    **$***VariableName*  
  
    In the following example, the variable is named **ImportResult**.  
  
    **$***ImportResult*  
  
    This command returns information contained in the result objects that were returned by **Import\-SmigServerSetting** in the example shown in step 1. The following is an example of the output that is displayed by calling the **ImportResult** variable:  
  
    ```  
          ItemType  ID                              Success  DetailsList  
          --------  --                              -------  -----------  
         OSSetting  Local User                         True  {Local User, Loc...  
         OSSetting  Local Group                        True  {Local Group, Lo...  
    WindowsFeature  DHCP                               True  {}  
  
    ```  
  
    Each line of the preceding example is a migration result for an item that was migrated by using the **Import\-SmigServerSetting** cmdlet. The column heading names are properties of **MigrationResult** objects. You can incorporate these properties into another command to return greater detail about result objects, as shown by the examples that follow in steps 3 and 4.  
  
3.  To display a specific property for all result objects in the list, type a command in the following format, and then press **Enter**.  
  
    **$<VariableName>| Select\-Object \-ExpandProperty <PropertyName>**  
  
    The following is an example.  
  
    **$importResult | Select\-Object \-ExpandProperty DetailsList**  
  
4.  You can run more advanced queries to analyze result objects by using Windows PowerShell cmdlets. The following are examples:  
  
    -   The following command returns only those details of result objects that have the ID **Local User**.  
  
        **$ImportResult | Where\-Object { $\_.ID \-eq "Local User" } | Select\-Object \-ExpandProperty DetailsList**  
  
    -   The following command returns only those details of result objects with an ID of **Local User** that have a message severity equal to **Warning**.  
  
        **$ImportResult | Where\-Object { $\_.ID \-eq "Local User" } | Select\-Object \-ExpandProperty DetailsList | ForEach\-Object { if \($\_.Severity \-eq "Warning"\) {$\_} }**  
  
    -   The following command returns only the details of result objects with an ID of **Local User** that also have the title **Remote Desktop Users**.  
  
        **$ImportResult | Where\-Object { $\_.ID \-eq "Local Group" } | Select\-Object \-ExpandProperty DetailsList | ForEach\-Object { if \($\_.Title \-eq "Remote DesktopUsers"\) {$\_} }**  
  
#### More information about querying results  
For more information about the cmdlets that are used in the preceding examples, see the following additional resources:  
  
-   [Using the Where\-Object Cmdlet](http://go.microsoft.com/fwlink/?LinkId=134853)  
  
-   [Using the Select\-Object Cmdlet](http://go.microsoft.com/fwlink/?LinkId=134858)  
  
-   [Using the ForEach\-Object Cmdlet](http://go.microsoft.com/fwlink/?LinkId=134860)  
  
For more information about Windows PowerShell scripting techniques, see [What Can I Do With Windows PowerShell?](http://go.microsoft.com/fwlink/?LinkId=134862)  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
[File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
[File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[File and Storage Services: Migrate Network File System](../Topic/File-and-Storage-Services--Migrate-Network-File-System.md)  
[File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
[File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
