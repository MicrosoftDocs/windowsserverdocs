---
title: DHCP Server Migration: Post-Migration Tasks
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ddfe99d-53f6-46c3-82be-6747a341f0ba
---
# DHCP Server Migration: Post-Migration Tasks
The post\-migration tasks for the source server are optional, depending on your migration scenario.  
  
-   [Completing migration](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md#BKMK_completing)  
  
-   [Restoring DHCP in the event of migration failure](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md#BKMK_restoring)  
  
-   [Troubleshooting cmdlet\-based migration](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md#BKMK_trouble)  
  
## <a name="BKMK_completing"></a>Completing migration  
Migration is complete after you have verified that the destination server, not the source server, is now serving the network. If your verification efforts demonstrate that the migration failed, see “Restoring DHCP in the event of migration failure” later in this topic.  
  
### Retiring DHCP on your source server  
After you have verified the migration, you can disconnect, repurpose, or retire the source server. If the source server is running other server roles, it should be left on the network. If you do not have to use this computer, you can store it as a backup in case you ever have to revert to your previous DHCP configuration.  
  
-   If your migration scenario includes a standalone DHCP Server, then this source server was taken offline after the export file was created, as described in [DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md). In this scenario, the DHCP service was interrupted from the time that it was stopped until the migration was complete on the new server, as described in [DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md).  
  
-   If your migration scenario includes more than one DHCP Server in a domain, a backup or other DHCP server continues to serve IP addresses during the migration so that services to clients are never interrupted. The migration is complete on the new server when the IP address of the source server is migrated to the destination server.  
  
### Retiring your source server  
After you have confirmed that the destination server is performing the functions previously handled by the source server, you can retire or repurpose the source server, depending on your needs. Follow your organization’s policy regarding server decommissioning. For information about decommissioning a domain controller, see [Decommissioning a Domain Controller](http://go.microsoft.com/fwlink/?LinkID=128290) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128290\).  
  
> [!WARNING]  
> After the source server is repurposed as a member server, otherwise repurposed or retired from service, you cannot roll that server back to its previous working state.  
  
## <a name="BKMK_restoring"></a>Restoring DHCP in the event of migration failure  
If the migration of DHCP Server fails, you have these options:  
  
-   If the source server has not been repurposed, an administrator can reassign the IP configuration settings, reauthorize the server, and restart the DHCP service on the original server.  
  
-   Use the backup files that were created on the source server, as described in [DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md), to restore DHCP server on the original DHCP server.  
  
### Estimated time to complete a rollback  
You should be able to complete a rollback in one to two hours.  
  
## <a name="BKMK_trouble"></a>Troubleshooting cmdlet\-based migration  
The [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment log file is located at %*windir*%\\Logs\\SmigDeploy.log. Additional [!INCLUDE[wsmt](../Token/wsmt_md.md)] log files are created at the following locations.  
  
-   %*windir*%\\Logs\\ServerMigration.log  
  
-   On [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]: %*localappdata*%\\SvrMig\\Log  
  
-   On Windows Server 2003: %*userprofile*%\\Local Settings\\Application Data\\SvrMig\\Log  
  
If migration log files cannot be created in the previous locations, **ServerMigration.log** and **SmigDeploy.log** are created in %*temp*%, and other logs are created in %*windir*%\\System32.  
  
For DHCP\-specific troubleshooting tips, see [Troubleshooting DHCP servers](http://go.microsoft.com/fwlink/?LinkId=128533) on the Windows Server TechCenter \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128533\). Although these tips are written for Windows Server 2003, they also address common issues that apply to later versions of the operating system.  
  
If a migration cmdlet fails, and the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session closes unexpectedly with an access violation error message, look for a message similar to the following example in the %*localappdata*%\\SvrMig\\Logs\\setuperr.log file.FatalError \[0x090001\] PANTHR Exception \(code 0xC0000005: ACCESS\_VIOLATION\) occurred at 0x000007FEEDE9E050 in C:\\Windows\\system32\\migwiz\\unbcl.dll \(\+000000000008E050\).  Minidump attached \(317793 bytes\).  
  
This failure occurs when the server cannot contact domain controllers that are associated with domain users or groups who are members of local groups, or who have rights to files or shares that are being migrated. When this happens, each domain user or group is displayed in the GUI as an unresolved security identifier \(SID\). An example of a SID is **S\-1\-5\-21\-1579938362\-1064596589\-3161144252\-1006**.  
  
To prevent this problem, verify that required domain controllers or global catalog servers are running, and that network connectivity allows communication between both source and destination servers and required domain controllers or global catalog servers.  Then, run the cmdlets again.  
  
#### If connections between either the source or destination servers and the domain controllers or global catalog servers cannot be restored, do the following.  
  
1.  Before you run **Export\-SmigServerSetting**, **Import\-SmigServerSetting** or **Get\-SmigServerFeature** again, remove all unresolved domain users or groups who are members of local groups from the server on which you are running the cmdlet.  
  
2.  Before you run **Send\-SmigServerData** or **Receive\-SmigServerData** again, remove all unresolved domain users or groups who have user rights to files, folders, or shares on the migration source server.  
  
### Viewing the content of Windows Server Migration Tools result objects  
All [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets return results as objects. You can save result objects, and query them for more information about settings and data that were migrated. You can also use result objects as input for other [!INCLUDE[wps_2](../Token/wps_2_md.md)] commands and scripts.  
  
#### Result object descriptions  
The [!INCLUDE[wsmt](../Token/wsmt_md.md)]**Import\-SmigServerSetting** and **Export\-SmigServerSetting** cmdlets return results in a list of **MigrationResult** objects. Each **MigrationResult** object contains information about the data or setting that the cmdlet processes, the result of the operation, and any related error or warning messages. The following table describes the properties of a **MigrationResult** object.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|ItemType|Enum|The type of item being migrated. Values include **General**, **WindowsFeatureInstallation**, **WindowsFeature**, and **OSSetting**.|  
|ID|String|The ID of the migrated item. Examples of values include **Local User**, **Local Group**, and **DHCP**.|  
|Success|Boolean|The value **True** is displayed if migration was successful; otherwise, **False** is displayed.|  
|DetailsList|List <MigrationResultDetails>|A list of **MigrationResultDetails** objects.|  
  
**Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets return results in a list of **MigrationDataResult** objects. Each **MigrationDataResult** object contains information about the data or share that the cmdlet processes, the result of the operation, any error or warning messages, and other related information. The following table describes the properties of a **MigrationDataResult** object.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|ItemType|Enum|The type of migrated item. Values include **File**, **Folder**, **Share**, and **Encrypted File**.|  
|SourceLocation|String|The source location of the item, shown as a path.|  
|DestinationLocation|String|The destination location of the item, shown as a path.|  
|Success|Boolean|The value **True** is displayed if migration was successful; otherwise, **False** is displayed.|  
|Size|Integer|The item size, in bytes.|  
|ErrorDetails|List <MigrationResultDetails>|A list of **MigrationResultDetails** objects.|  
|Error|Enum|Errors enumeration for errors that occurred.|  
|WarningMessageList|List <String>|A list of warning messages.|  
  
The following table describes the properties of objects within the **MigrationResultDetails** object that are common to both **MigrationResult** and **MigrationDataResult** objects.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|FeatureId|String|The name of the migration setting that is related to the item. Examples of values include **IPConfig** and **DNS**. This property is empty for data migration.|  
|Messages|List <String>|A list of detailed event messages.|  
|DetailCode|Integer|The error or warning code associated with each event message.|  
|Severity|Enum|The severity of an event, if events occurred. Examples of values include **Information**, **Error**, and **Warning**.|  
|Title|String|Title of the result object. Examples of values include the network adapter physical address for IP configuration, or user name for local user migration.|  
  
#### Examples  
The following examples show how to store the list of the result objects in a variable, and then use the variable in a query to return the content of result objects after migration is complete.  
  
###### To store a list of result objects as a variable for queries  
  
1.  To run a cmdlet and save the result in variable, type a command in the following format, and then press **Enter**.  
  
    ```  
    $VariableName = $(Cmdlet)  
    ```  
  
    The following is an example.  
  
    ```  
    $ImportResult = $(Import-SmigServerSetting -FeatureId DHCP -User all -Group -Path D:\rmt\DemoStore -force -Verbose)  
    ```  
  
    This command runs the **Import\-SmigServerSetting** cmdlet with several parameters specified, and then saves result objects in the variable **ImportResult**.  
  
2.  After the **Import\-SmigServerSetting** cmdlet has completed its operations, return the information that is contained in the result object by typing a command in the following format, and then pressing **Enter**.  
  
    ```  
    $VariableName  
    ```  
  
    In the following example, the variable is named **ImportResult**.  
  
    ```  
    $ImportResult  
    ```  
  
    This command returns information that was contained in the result objects that were returned by **Import\-SmigServerSetting** in the example shown in step 1. The following is an example of the output that is displayed by calling the **ImportResult** variable.  
  
    ```  
          ItemType  ID                              Success  DetailsList  
          --------  --                              -------  -----------  
         OSSetting  Local User                         True  {Local User, Loc...  
         OSSetting  Local Group                        True  {Local Group, Lo...  
    WindowsFeature  DHCP                               True  {}  
  
    ```  
  
    Each line of the previous sample is a migration result for an item that was migrated by using the **Import\-SmigServerSetting** cmdlet. The column heading names are properties of **MigrationResult** objects. You can incorporate these properties into another command to return more detail about result objects, as shown by examples in step 3 and forward.  
  
3.  To display a specific property for all result objects in the list, type a command in the following format, and then press **Enter**.  
  
    ```  
    $<VariableName>| Select-Object -ExpandProperty <PropertyName>  
    ```  
  
    The following is an example.  
  
    ```  
    $importResult | Select-Object -ExpandProperty DetailsList  
    ```  
  
4.  You can run more advanced queries to analyze result objects by using [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets. The following are examples.  
  
    -   The following command returns only those details of result objects that use the ID **Local User**.  
  
        ```  
        $ImportResult | Where-Object { $_.ID -eq "Local User" } | Select-Object -ExpandProperty DetailsList  
        ```  
  
    -   The following command returns only those details of result objects that use an ID of **Local User** that have a message severity equal to **Warning**.  
  
        ```  
        $ImportResult | Where-Object { $_.ID -eq "Local User" } | Select-Object -ExpandProperty DetailsList | ForEach-Object { if ($_.Severity -eq "Warning") {$_} }  
        ```  
  
    -   The following command returns only the details of result objects that use an ID of **Local Group** that also have the title **Remote Desktop Users**.  
  
        ```  
        $ImportResult | Where-Object { $_.ID -eq "Local Group" } | Select-Object -ExpandProperty DetailsList | ForEach-Object { if ($_.Title -eq "Remote DesktopUsers") {$_} }  
        ```  
  
#### More information about querying results  
For more information about the cmdlets that are used in the previous examples, see the following additional resources.  
  
-   [Where\-Object](http://go.microsoft.com/fwlink/?LinkId=134853) on the Microsoft Script Center Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134853\).  
  
-   [Select\-Object](http://go.microsoft.com/fwlink/?LinkId=134858) on the Microsoft Script Center Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134858\).  
  
-   [ForEach\-Object](http://go.microsoft.com/fwlink/?LinkId=134860) on the Microsoft Script Center Web site \(http:\/\/www.microsoft.com\/technet\/scriptcenter\/topics\/msh\/cmdlets\/foreach\-object.mspx\)  
  
## See also  
[Migrate DHCP Server to Windows Server 2012 R2](../Topic/Migrate-DHCP-Server-to-Windows-Server-2012-R2.md)  
  
[DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md)  
  
[DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md)  
  
[DHCP Server Migration: Verifying the Migration](../Topic/DHCP-Server-Migration--Verifying-the-Migration.md)  
  
[DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md)  
  
