---
title: File and Storage Services: Migrate the File and Storage Services Role
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1ba67d47-b1d1-4706-af11-c789a7404476
---
# File and Storage Services: Migrate the File and Storage Services Role
  
## Migrate File Services  
Perform the following tasks to migrate the File and Storage Services server role.  
  
-   [Freeze administration configuration](#BKMK_FreezeAdministrationConfiguration)  
  
-   [Export settings](#BKMK_ExportSettings)  
  
-   [Migrate local users and groups to the destination server](#BKMK_Migratelocalusersandgroupstothedestinationserver)  
  
-   [Migrate data](#BKMK_MigrateData)  
  
-   [Migrate server identity](#BKMK_MigrateServerIdentity)  
  
-   [Configure DFS replication on the destination server](#BKMK_ConfigureDFSReplicationontheDestinationServer)  
  
-   [Import settings to the destination server](#BKMK_ImportsettingstotheDestinationserver)  
  
### <a name="BKMK_FreezeAdministrationConfiguration"></a>Freeze administration configuration  
Administrators must stop all configuration changes to the File and Storage Services role services on the source server before starting migration. When the migration begins, you must not make any configuration changes to the source server other than those that are required for the migration. For example, no links can be added to a DFS namespace after migration starts until the migration is successfully verified.  
  
### Install the Windows Server Migration Tools  
Before you can use any of the following Windows PowerShell cmdlets for migration on the source server or destination server, ensure that the [!INCLUDE[wsmt](../Token/wsmt_md.md)] are added. You can do this by using Server Manager or by using Windows PowerShell.  
  
##### To install the Windows Server Migration Tools  
  
1.  Log on to the computer as a member of the local Administrators security group.  
  
2.  In Server Manager, click **Add roles and features**.  
  
3.  On the **Before you begin** page, click **Next**.  
  
4.  On the **Select installation type** page, select **the Role\-base or feature\-based installation** option, and then click **Next**.  
  
5.  On the **Select destination server** page, click **Next**.  
  
6.  On the **Select server roles** page, accept the default selections, and then click **Next**.  
  
7.  On the **Select features** page, click **Windows Server Migration Tools**, and then click **Next**.  
  
8.  On the **Confirm installation selections** page, click **Install**.  
  
9. After the installation is complete, click **Close**.  
  
The following Windows PowerShell cmdlet performs the same function as the preceding procedure.  
  
```  
Install-WindowsFeature Migration  
```  
  
The following is a list of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets:  
  
-   **Export\-SmigServerSetting**  
  
-   **Import\-SmigServerSetting**  
  
-   **Get\-SmigServerFeature**  
  
-   **Send\-SmigServerData**  
  
-   **Receive\-SmigServerData**  
  
For more information about how to work with the Windows Server Migration Tools see [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
### <a name="BKMK_ExportSettings"></a>Export settings  
Export the following settings from the source server to the destination server:  
  
-   Server Message Block \(SMB\)  
  
-   Offline Files \(also known as called client\-side caching or CSC\)  
  
-   DFS Namespaces  
  
-   File Server Resource Manager \(FSRM\)  
  
-   Shadow Copies of Shared Folders  
  
#### BranchCache for Network Files server key  
The following procedure applies only if the source server is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
> [!NOTE]  
> This procedure, which is used to migrate the seed value that is used by the BranchCache for Network Files component, enables data that was stored in branch office locations by using BranchCache to be used after the file server is migrated from the source server to the destination server.  
>   
> For information about how to migrate a BranchCache host server, see the [BranchCache Migration Guide](http://go.microsoft.com/fwlink/?LinkID=139091).  
  
##### <a name="BKMK_migrateBC"></a>To migrate BranchCache for Network Files settings from the source server  
  
1.  In your Windows PowerShell session, collect data from the source server by running the **Export\-SmigServerSetting** cmdlet as a member of the Administrators security group. This step runs the **Export\-SmigServerSetting** cmdlet with all parameters from a single command line. The **Export\-SmigServerSetting** cmdlet parameters can collect all source BranchCache feature data in a single file \(Svrmig.mig\), or you can run the **Export\-SmigServerSetting** cmdlet multiple times by using one or more parameters to collect and store data in multiple Svrmig.mig files.  
  
    For more information, see the section "Prepare for migration" in [File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md).  
  
    Review the following dependencies before you run the command.  
  
    -   When you run the **Export\-SmigServerSetting** cmdlet, you are prompted to provide a password to encrypt the migration store data. You must provide this same password to import data from the migration store.  
  
    -   The *path* parameter can be to a folder that is empty or one that contains data. The actual data file in the folder \(Svrmig.mig\) is created by the **Export\-SmigServerSetting** cmdlet. Therefore, the user does not have to specify a file name.  
  
    -   If the path is not a shared location that the destination server can read, you must manually copy the migration store to the destination server or a location that the destination server can access.  
  
    -   If a migration store location already exists and you want to rerun the **Export\-SmigServerSetting** cmdlet, you must move the Svrmig.mig file from the migration store location and then store it elsewhere, or rename or delete the Svrmig.mig file first.  
  
2.  On the source server, type the following, and then press Enter, where *<storepath>* is the path that will contain the Svrmig.mig file after this step is completed. An example of the path is *\\\\fileserver\\users\\username\\branchcachestore*.  
  
    ```  
    Export-SmigServerSetting -featureID BranchCache -Path <storepath\BranchCache> -Verbose  
    ```  
  
#### Group Policy setting or local policy setting specific to SMB and Offline Files  
Most SMB and Offline Files settings are migrated as part of shared folders migration. The remaining settings that affect the server are set through Group Policy settings or local policy settings. This section describes how to inventory SMB and Offline Files settings that are controlled by Group Policy.  
  
##### Server message block  
Determine the policy settings that affect the SMB server. The SMB settings are controlled by Group Policy settings or local policy settings. If a Group Policy Object \(GPO\) is applied, these policies override the local settings. First, determine if the policy settings are controlled by a GPO, and then determine local settings for anything that is not controlled by the GPO.  
  
###### To determine if a GPO is applied to the source server  
  
1.  Open the Resultant Set of Policy snap\-in. To open the Resultant Set of Policy snap\-in, open a command prompt, type **rsop.msc**, and then press Enter.  
  
2.  In the snap\-in tree pane, click **Computer Configuration**, click **Windows Settings**, click **Security Settings**, click **Local Policies**, and then click **Security Options**.  
  
3.  Note in the SMB data collection worksheet in [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md) any Group Policy setting that affects the following **Microsoft network server** settings:  
  
    -   Microsoft network server: Amount of idle time required before suspending session  
  
    -   Microsoft network server: Attempt S4USelf to obtain claim information  
  
    -   Microsoft network server: Digitally sign communications \(always\)  
  
    -   Microsoft network server: Digitally sign communications \(if client agrees\)  
  
    -   Microsoft network server: Disconnect clients when logon hours expire  
  
    On source servers that are running the Server Core installation option of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system, run the **gpresult** command to review Group Policy settings \(for more information about **gpresult**, type **gpresult \/?** at a command prompt.\)  
  
> [!NOTE]  
> For any setting that is controlled by Group Policy, you must apply the same GPO to the destination server, or you can set the local policy of the destination server for the same behavior.  
>   
> For any setting that is not controlled by Group Policy, use the following procedure to determine the local policy setting. Note the local policy setting in the SMB data collection worksheet in [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md).  
  
###### To determine local policy settings  
  
1.  Open the Local Group Policy Editor. To open the Local Group Policy Editor, open a command prompt, type **gpedit.msc**, and then press Enter.  
  
2.  In the snap\-in tree pane, click **Computer Configuration**, click **Windows Settings**, click **Security Settings**, click **Local Policies**, and then click **Security Options**.  
  
3.  Note the following settings for **Microsoft network server**:  
  
    -   Microsoft network server: Amount of idle time required before suspending session  
  
    -   Microsoft network server: Attempt S4USelf to obtain claim information  
  
    -   Microsoft network server: Digitally sign communications \(always\)  
  
    -   Microsoft network server: Digitally sign communications \(if client agrees\)  
  
    -   Microsoft network server: Disconnect clients when logon hours expire  
  
    On source servers that are running the Server Core installation, run the **secedit** command to export and review local policy settings \(for more information about **secedit**, type **secedit \/?** at a command prompt.\)  
  
##### Offline Files  
  
> [!NOTE]  
> This section applies only to source servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Previous operating system releases do not have Offline Files settings that affect the server.  
  
Determine the policy settings that affect shared folders on the server for which client computers use Offline Files. The Offline Files settings are controlled through Group Policy or local policy. If Group Policy is applied, these policies override local settings. First, determine if the settings are controlled through Group Policy, and then determine the local settings for anything that is not controlled by using Group Policy.  
  
###### To determine if Group Policy is applied to the source server  
  
1.  Open the Resultant Set of Policy snap\-in. To open the Resultant Set of Policy snap\-in, open a command prompt, type **rsop.msc**, and then press Enter.  
  
2.  In the snap\-in tree pane, click **Computer Configuration**, click **Administrative Templates**, click **Network**, and then click **Lanman Server**.  
  
    > [!NOTE]  
    > If no policies are set, the preceding path will not exist. If the path does not exist, skip to the procedure [To determine local policy settings](#BKMK_csclocal). If the path exists and policies are found, proceed to the next step.  
  
3.  Note in the BranchCache data collection worksheet in [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md) any Group Policy settings that control the **Hash Publication for BranchCache** and **Hash Version support for BranchCache** settings.  
  
    On source servers that are running the Server Core installation option, run the **gpresult** command to review Group Policy settings \(for more information about **gpresult**, type **gpresult \/?** at a command prompt\).  
  
For any setting controlled by Group Policy, have the same Group Policy setting apply to the destination server, or you can choose to set the local policy setting of the destination server to get the same behavior.  
  
For any setting not controlled by Group Policy, use the following instructions to determine the local policy setting.  
  
###### <a name="BKMK_csclocal"></a>To determine local policy settings  
  
1.  Open the Local Group Policy Editor. To open the Local Group Policy Editor, open a command prompt, type **gpedit.msc**, and then press Enter.  
  
2.  In the snap\-in tree pane, click **Computer Configuration**, click **Administrative Templates**, click **Network**, and then click **Lanman Server**.  
  
3.  Note in the BranchCache data collection worksheet in [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md) the value of the **Hash Publication for BranchCache** and **Hash Version support for BranchCache** settings.  
  
    On source servers that are running the Server Core installation option, run the **secedit** command to export and review local policy settings \(for more information about **secedit**, type **secedit \/?** at a command prompt\).  
  
#### <a name="BKMK_dfsnameconfig"></a>DFS Namespace configuration  
Procedures in this section describe how to migrate DFS Namespaces from the source server to the destination server.  
  
Before the migration of the namespace begins, you can inventory the namespaces that are hosted on the source server for tracking purposes. You can do this by using DFS Management or DFSUtil.exe.  
  
The following procedure \(To inventory DFS Namespaces by using DFS Management\) applies only to computers that are running at least the Windows Server 2003 R2 version of the Windows Server operating system. For computers that are running Windows Server 2003, you can perform a DFS Namespace inventory by using **DFSUtil.exe** as described in [To inventory DFS Namespaces by using DFSutil.exe](#BKMK_dfsutil).  
  
You can also perform a DFS Namespace inventory from a client computer that is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], or [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)],  by using DFS Management that is part of Remote Server Administration Tools.  
  
-   To download Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], see [Deploy Remote Server Administration Tools](http://technet.microsoft.com/library/hh831501.aspx).  
  
-   To download Remote Server Administration Tools for [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], see [Remote Server Administration Tools for Windows 7](http://go.microsoft.com/fwlink/?LinkID=131280).  
  
-   To download Remote Server Administration Tools for [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], see [Microsoft Remote Server Administration Tools for Windows Vista](http://go.microsoft.com/fwlink/?LinkID=113192).  
  
##### <a name="BKMK_dfsmmc"></a>To inventory DFS Namespaces by using DFS Management  
  
1.  Under DFS Management in the left pane, right\-click **Namespaces**.  
  
2.  Click **Add Namespaces to Display**.  
  
3.  In the dialog box that is displayed, select **Server** from the Scope options.  
  
4.  Type the name of source server and click **Show Namespaces**.  
  
5.  Select all namespaces listed in the list box and click **OK**.  
  
6.  Right\-click the first namespace listed in the left pane.  
  
7.  Click **Properties**.  
  
8.  On the **General** tab, review the **Type** field. The type of namespace that is hosted on the server is described here. Possible values are stand\-alone, domain\-based \(Windows Server 2000 mode\), and domain\-based \([!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] mode\).  
  
9. In the case of a domain\-based namespace, click the **Namespace Servers** tab to identify the number of servers that host the namespace.  
  
10. Repeat steps 7 through 10 for the remaining namespaces listed in the left pane.  
  
##### <a name="BKMK_dfsutil"></a>To inventory DFS Namespaces by using DFSutil.exe  
  
1.  You can inventory your DFS Namespaces using DFSUtil.exe by using the command prompt. From a command prompt, type **DFSUtil.exe server SourceServer** where *SourceServer* represents the name of the source server.  
  
2.  Identify the namespaces \(DFS roots\) listed for the source server.  
  
3.  Type the following command, which lists the namespace properties for the first namespace identified in step 2:  
  
    ```  
    DFSUtil.exe root <\\SourceServer\Namespace>  
    ```  
  
4.  Identify the namespace type; possible values are stand\-alone root, domain root \(domain\-based namespace in Windows 2000 Server mode\), domainV2 root \(domain\-based namespace in Windows 2008 mode\).  
  
5.  Identify the DFS folders present in the namespace in each of the **Link Name** items displayed.  
  
6.  In the case of domain\-based namespaces, identify all the namespace servers by typing the following command:  
  
    ```  
    DFSUtil.exe root <\\Domain\Namespace>  
    ```  
  
7.  Identify the namespace servers that host the namespace in each of the **Target** items displayed under **Root Name**.  
  
8.  Repeat steps 3 through 7 for the remaining namespaces on the source server.  
  
##### Considerations for namespaces  
Is the namespace stand\-alone or domain\-based? If the namespace is stand\-alone, see the following section in this document: [Stand\-alone namespaces](#BKMK_standalone).  
  
If the namespace is domain\-based, consider the number of namespace servers for each namespace. For more information, see the following sections in this document:  
  
-   [Domain\-based namespaces with more than one namespace server](#BKMK_domainmore)  
  
-   [Domain\-based namespaces with one namespace server](#BKMK_one)  
  
###### <a name="BKMK_standalone"></a>Stand\-alone namespaces  
Complete the following procedure to export a stand\-alone namespace configuration.  
  
###### <a name="BKMK_standaloneexport"></a>To export the namespace configuration to an export file  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Type **DFSUtil.exe root export \\\\SourceServer\\Namespace FileName** to export the stand\-alone namespace to a file \(where *FileName* represents the exported file\), and then press Enter.  
  
###### <a name="BKMK_domainmore"></a>Domain\-based namespaces with more than one namespace server  
For more than one namespace server, remove the namespace server from the namespace by using DFSUtil.exe.  
  
###### <a name="BKMK_remnamespace"></a>To remove the namespace server from the namespace  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Type **DFSUtil.exe target remove <\\\\SourceServer\\Namespace>**, and then press Enter.  
  
###### <a name="BKMK_one"></a>Domain\-based namespaces with one namespace server  
There are two options that you can use in this scenario: export the namespace settings, or add a temporary server to the namespace.  
  
###### <a name="BKMK_exnssettings"></a>To export namespace settings  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Type **DFSUtil.exe root export \\\\Domain\\Namespace FileName** where *FileName* represents the file containing settings for export, and then press Enter.  
  
    > [!NOTE]  
    > For each namespace, there must be a different file name to export settings.  
  
3.  Repeat step 2 for each namespace for which the source server is a namespace server.  
  
You can use either of the following two options if a temporary server can be added to the namespace. This provides the ability to maintain the namespace online while the migration progresses. If this is not possible, follow the steps in [To remove the namespace server from the namespace](#BKMK_remnamespace) instead.  
  
###### To add a temporary server to the namespace by using DFS Management  
  
1.  In the left pane, select the namespace to be migrated.  
  
2.  Click the **Namespace servers** tab.  
  
3.  Select **Add Namespace Server**.  
  
4.  In the **Namespace server** box, type the name of the temporary server, and then click **OK**.  
  
The temporary server will be added to the namespace.  
  
###### To add a temporary server to the namespace by using DFSUtil.exe  
  
1.  Create a shared folder for the namespace on the temporary server with the same permissions as on the source server.  
  
2.  On the destination server, open a Command Prompt window.  
  
3.  Type **DFSUtil.exe target add \\\\TemporaryServer\\Namespace** and then press Enter.  
  
    ```  
    DFSUtil.exe target add <\\TemporaryServer\Namespace>  
    ```  
  
The temporary server will be added to the namespace.  
  
After the namespace settings are exported or a temporary server is added to the namespace, the namespace source server can be removed from the namespace as described in [To remove the namespace server from the namespace](#BKMK_remnamespace).  
  
##### Inventory advanced registry keys  
This section describes the process for determining if there are any settings that have been applied to the DFS Namespace component on the source server. These settings are stored in the registry and set or viewed through the DFSUtil.exe tool. To inventory these settings, run the following commands from the destination server:  
  
```  
  
DFSUtil.exe server registry DfsDnsConfig <SourceServer>  
```  
  
```  
DFSUtil.exe server registry LdapTimeoutValue <SourceServer>  
```  
  
```  
DFSUtil.exe server registry SyncInterval <SourceServer>  
```  
  
Note the setting for any registry modification. Registry keys that have not been modified display a value similar to the following:  
  
`<KeyName> does not exist in the Registry.`  
  
#### DFS Replication configuration  
To migrate DFS Replication settings, use the following Microsoft Enterprise Support blog series: [Replacing DFSR Member Hardware or OS](http://blogs.technet.com/b/askds/archive/2010/09/10/series-wrap-up-and-downloads-replacing-dfsr-member-hardware-or-os.aspx).  
  
#### File Server Resource Manager configuration on the source server  
When you migrate File Server Resource Manager, remember to use the same drive letters for the destination server volumes as for the source server. This is required because the File Server Resource Manager migration requires that the drive letter remains the same.  
  
1.  Stop the File Server Resource Manager and File Server Storage Reports Manager services. You can stop these services in Windows PowerShell by using the following command: **Stop\-Service –Name “srmsvc”, “srmreports”**.  
  
2.  Export the File Server Resource Manager configuration. You can export the File Server Resource Manager configuration in Windows PowerShell by using the following command: **Export\-SmigServerSetting \-FeatureID FS\-Resource\-Manager \-Path <storepath\\FSRM> \-Verbose**.  
  
3.  For each volume, get the configuration files by running the following commands in the Windows PowerShell session.  
  
    1.  Stop the file screen driver. Type **fltmc detach datascrn <VolumeLetter>:** and then press Enter.  
  
    2.  Stop the quota driver. Type **fltmc detach quota <VolumeLetter>:** and then press Enter.  
  
    3.  Grant Read permissions to the Administrator account for the "*<VolumeLetter>*:\\System Volume information\\SRM" folder and the following child objects:  
  
        -   takeown \/F "<VolumeLetter>:\\System Volume Information" \/A \/R \/D Y  
  
        -   cacls "<VolumeLetter>:\\System Volume Information" \/T \/E \/G Administrators:F  
  
        -   attrib \-S \-H "<VolumeLetter>:\\System Volume Information\\\*" \/S \/D  
  
    4.  Copy the following files from the **SRM** folder to an external storage device:  
  
        -   Quota.xml  
  
        -   Quota.md  
  
        -   Datascrn.md  
  
        -   DataScreenDatabase.xml  
  
    5.  Start the file screen driver. Type **fltmc attach datascrn <VolumeLetter>:** and then press Enter.  
  
    6.  Start the quota driver. Type **fltmc attach quota <VolumeLetter>:** and then press Enter.  
  
4.  Restart the File Server Resource Manager and File Server Storage Reports Manager services. Type **Start\-Service \-name "srmsvc","srmreports"**, and then press Enter.  
  
5.  Configure scheduled reports.  
  
    File Server Resource Manager reports and classification rule configurations are dependent on the drive letters and mount points. Any drives or mount points on the source server that are used by report or classification rule configurations must be available on the destination server, or the configurations must be updated during import.  
  
    To configure scheduled reports, follow step \(a\). However, if you are migrating from Windows Server 2003, follow step \(b\).  
  
    1.  To configure scheduled reports on all servers except Windows Server 2003, run the following commands in a Windows PowerShell session on the source server that was opened with elevated user rights.  
  
        1.  To get a list of all the task names associated with storage reports: `storrept r l`  
  
        2.  For each task name listed, run the following command on the source server: `schtasks /query /tn:"TASKNAME" /xml > "TASKNAME.xml"`  
  
    2.  To configure scheduled reports when you migrate from Windows Server 2003:  
  
        -   On the source server, do the following:  
  
            -   Open File Server Resource Manager.  
  
            -   In **Storage Report Management**, for each report task, note the report task, target, and schedule.  
  
        -   On the destination server, after you import the file server resource manager configuration, do the following:  
  
            -   Open File Server Resource Manager.  
  
            -   In **Storage Report Management**, for each report task, edit the report task properties.  
  
            -   On the **Schedule** tab, manually add the appropriate schedule for the report.  
  
6.  Configure scheduled file management tasks. This step applies only to source servers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
    1.  To display a list of all task names associated with file management tasks, type the following command on the source server in a Windows PowerShell session opened with elevated user rights:  
  
        ```  
        (new-object -com Fsrm.FsrmFileManagementJobManager).EnumFileManagementJobs()  
        ```  
  
    2.  For each entry listed, locate the task element, and then type the following command:  
  
        ```  
        Schtasks /query /tn:"TASK" /xml > "TASK.xml"  
        ```  
  
7.  Export the classification schedule. This is only applicable to servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] that already have a classification schedule configured. From an elevated command prompt, type the following command:  
  
    ```  
    Schtasks /query /tn:”FsrmAutoClassification{c94c42c4-08d5-473d-8b2d-98ea77d55acd}” /xml > “classification.xml”  
    ```  
  
#### Shadow Copies of Shared Folders  
The following procedures describe how to migrate shadow copy settings.  
  
###### To migrate shadow copy settings  
  
1.  Open Windows Explorer on the source server to view shadow copy storage locations and the creation schedule.  
  
    > [!IMPORTANT]  
    > This procedure applies to shadow copies for a server running the full installation option of Windows Server. If your source server is running the Server Core installation option of Windows Server, skip this procedure and follow the instructions in the following section: [To migrate shadow copies in Server Core](#BKMK_shadowcore).  
  
2.  For each volume on the source server, right\-click the volume, and then click **Configure Shadow Copies**.  
  
    On source servers that are running Windows Server 2003, right\-click the volume, click **Properties**, and then click the **Shadow Copies** tab.  
  
3.  Click **Settings**, and note the location and size of the shadow copy storage.  
  
4.  Click **Schedule** and note the details for the snapshot creation task.  
  
##### <a name="BKMK_shadowcore"></a>To migrate shadow copies in a Server Core installation  
  
1.  Log on to the computer that is running a Server Core installation remotely as follows:  
  
    1.  In Server Manager, click **Tools**, and then click **Computer Management**.  
  
    2.  In the **Computer Management** snap\-in pane, right\-click the top node, and then click **Connect to another computer**.  
  
2.  Type the computer name, and then click **OK**.  
  
3.  Expand **System Tools**, right\-click **Shared Folders**, click the **All Tasks** tab, and then click **Configure Shadow Copies**.  
  
4.  For each volume on the source server, right\-click the volume, click **Configure Shadow Copies**, click **Settings**, and note the location and size of the shadow copy storage.  
  
5.  Click **Schedule**, and then note details for the snapshot creation task.  
  
## <a name="BKMK_Migratelocalusersandgroupstothedestinationserver"></a>Migrate local users and groups to the destination server  
Before migrating data and shared folders or completing your migration of the FSRM configuration, you must migrate local users and groups. Export local users and groups from the source server, and then import local users and groups to the destination server.  
  
> [!IMPORTANT]  
> If the source server is a domain member server, but the destination server is a domain controller, imported local users are elevated to domain users, and imported local groups become Domain Local groups on the destination server.  
>   
> If the source server is a domain controller, but the destination server is not, Domain Local groups are migrated as local groups, and domain users are migrated as local users.  
  
### <a name="BKMK_exportug"></a>Export local users and groups from the source server  
On the source server, export local users and groups to a migration store \(as shown in the following example\) in a Windows PowerShell session that has been opened with elevated user rights.  
  
```  
Export-SmigServerSetting -User All -Group -Path <storepath\UsersGroups> -Verbose  
```  
  
You can use one of the following values with the *\-user* parameter:  
  
-   Enabled: Specify to export only enabled local users.  
  
-   Disabled: Specify to export only disabled local users.  
  
-   All: Specify to export enabled and disabled local users.  
  
For more information about the attributes of local users and groups that can be migrated, see the [Local User and Group Migration Guide](http://technet.microsoft.com/library/dd379531.aspx).  
  
You are prompted to provide a password to encrypt the migration store. Remember this password, because you must provide the same password to import from the migration store.  
  
If the path is not a shared location that is accessible to the destination server, you must manually copy the contents of the migration store folder to the destination server or a location that is accessible to the destination server.  
  
### Import local users and groups to the destination server  
On the destination server, import local users and groups from the migration store to which you exported the users and groups in [Export local users and groups from the source server](#BKMK_exportug), as illustrated by the following example. Use a Windows PowerShell session that has been opened with elevated user rights.  
  
```  
Import-SmigServerSetting -User All -Group -Path <storepath\UsersGroups> -Verbose  
```  
  
You can use one of the following values with the *\-user* parameter:  
  
-   Enabled: Specify to import only enabled local users.  
  
-   Disabled: Specify to import only disabled local users.  
  
-   All: Specify to import enabled and disabled local users.  
  
For the list of user attributes that are supported for migration, see the [Local User and Group Migration Guide](http://technet.microsoft.com/library/dd379531.aspx).  
  
You are prompted to provide the same password that you provided during export to decrypt the migration store.  
  
## <a name="BKMK_MigrateData"></a>Migrate data  
To migrate data, you can copy file data or physically move it, for example, by attaching the storage drive from the source server to the destination server. If you copy the data, follow the copy data migration steps in the following section.  
  
If you physically move the data, follow the steps described in the [Using disk drives or LUNs to migrate data from the source server to the destination server](#BKMK_PhysicalMove) section later in this document.  
  
### Data copy migration  
If you are planning a two\-phase data copy migration as described in the previous section, note that if files have been deleted on the source server between the start of the first copy and the start of the final copy, copies of the deleted files might have already transferred to the destination server. So if a file is deleted between the two copy processes, the file might still be available on the destination server after the migration is complete. If this is unacceptable in your environment, perform data and shared folder migration in a single phase, and disconnect all users before starting migration.  
  
> [!IMPORTANT]  
> The file migration portion of the Windows Server Migration Tools is designed for smaller data sets \(less than 100 GB of data\). It copies files one at a time over HTTPS. For larger datasets, we recommend using the version of robocopy.exe included with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
##### To copy data and shared folders and migrate all data without disconnecting users  
  
1.  Verify that the destination path has sufficient disk space to migrate the data. If NTFS or folder quota management is enabled on the destination server disk drive, verify that the NTFS or File Server Resource Manager quota limit allows for sufficient free disk space to migrate data. For more information about quota management in File Server Resource Manager, see one of the following:  
  
    -   [Quota Management](http://go.microsoft.com/fwlink/?LinkId=154277) for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
    -   [Quota Management](http://go.microsoft.com/fwlink/?LinkId=154241) for Windows Server 2003 R2  
  
    For more information about NTFS quota management, see one of the following:  
  
    -   [Setting Disk Quotas](http://go.microsoft.com/fwlink/?LinkId=154243) for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
    -   [Enable disk quotas](http://go.microsoft.com/fwlink/?LinkId=154245) for Windows Server 2003 R2 and Windows Server 2003  
  
2.  Ensure that you have completed the migration of local users and groups.  
  
    The **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets must be run on the source and destination server within five minutes of each other. By default, **Send\-SmigServerData** and **Receive\-SmigServerData** time out if a connection cannot be established within 300 seconds \(five minutes\). This maximum connection time\-out for the **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets is stored in the following registry subkey, which is user\-defined.  
  
    Subkey: HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\ServerMigration  
  
    Value: MaxConnectionTime \(REG\_DWORD\)  
  
    Data: Between 1 and 3600 \(represents connection time\-out, in seconds\)  
  
    If a value larger than 3600 is specified, 3600 seconds \(1 hour\) is used as the maximum connection time\-out.  
  
    For information about how to create a Windows Registry key, see [Add a Registry Key](http://go.microsoft.com/fwlink/?LinkId=147298) on the Microsoft Web site.  
  
3.  Use the following command to run the **Receive\-SmigServerData** cmdlet on the destination server. Use a Windows PowerShell session that is running with elevated user rights.  
  
    ```  
    Receive-SmigServerData  
    ```  
  
    > [!NOTE]  
    > All output for the Send and Receive operations occurs on the source server only. The destination server will appear to be done before the operation has completed.  
  
4.  Use the following command to run the **Send\-SmigServerData** cmdlet on the source server to migrate data and shared folders. Use a Windows PowerShell session that is running with elevated user rights.  
  
    ```  
    Send-SmigServerData -ComputerName <DestinationServer> -SourcePath d:\users -DestinationPath d:\shares\users -Recurse -Include All -Force  
    ```  
  
The destination data location does not have to be the same as the source location, and you can change it, if desired.  
  
> [!NOTE]  
> The Server service startup type must be set to Automatic on the destination server for shared folder migration to complete.  
>   
> Data that is transferred is encrypted automatically. You are prompted to enter a password to encrypt the transferred data on the source server, and the same password to decrypt the received data on the destination server.  
  
After the first data copy is finished, you must freeze the source server and all data changes.  
  
##### To disconnect users and migrate new or updated files  
  
1.  Make sure that users are notified that they should stop using the source server at this time to prevent any possible data loss. You can run the following command to list all the currently open files to determine the potential impact of performing this step.  
  
    ```  
    net file  
    ```  
  
2.  Disconnect all users from the source server by stopping the LanMan Server service.  
  
    ```  
    Stop-Service LanmanServer -force  
    ```  
  
    Stopping the LanMan Server service invalidates all open remote files to the shared folders on the source server, which can lead to potential data loss. It is best to perform this step when the fewest users are expected to access files on this server.  
  
3.  Use the following command to run the **Receive\-SmigServerData** cmdlet on the destination server. Use a Windows PowerShell session that is running with elevated user rights.  
  
    ```  
    Receive-SmigServerData  
    ```  
  
4.  Use the following command to run the **Send\-SmigServerData** cmdlet on the source server to migrate data and shared folders. Use a Windows PowerShell session that is running with elevated user rights.  
  
    ```  
    Send-SmigServerData -ComputerName <DestinationServer> -SourcePath d:\users -DestinationPath d:\shares\users -Recurse -Include All -Force  
    ```  
  
5.  If your scenario requires migrating reparse points, hard links, and mount points, recreate them on the destination server by using the **mklink** command for reparse points and hard links, and using the **mountvol** command for mounted volumes. For more information about these commands, enter `mklink /?` or `mountvol /?` in a Command Prompt window.  
  
It is important to maintain the same destination path that you used during the first copy of data and shared folders. The cmdlets transfer files, folders, and shared folders only if they do not exist on the destination server, or if there is a new version on the source server.  
  
### <a name="BKMK_PhysicalMove"></a>Physical data migration  
The next sections describe data migration by physically moving external drives or logical unit numbers \(LUNs\).  
  
#### Using disk drives or LUNs to migrate data from the source server to the destination server  
You can migrate data from the source server by moving the disk drives. Or, if your data resides on a LUN storage device, you have the option of moving the file server data by masking the LUNs from the source server and unmasking them on the destination server.  
  
For the ideal migration, make sure that you maintain the same mapping of the drive letters \(for example, drive D\) and the volume IDs \(see the following explanation\) so that relevant data and application information remains as consistent as possible during the move.  
  
> [!CAUTION]  
> You should not move a disk drive or LUN if it contains both data and the operating system.  
  
Benefits of physical migration:  
  
-   For large amounts of data, this is a faster operation.  
  
-   You maintain all data on the disk drive, such as hard links and mount points.  
  
-   Shadow copies are preserved if the shadow copies are on the migrated disk drive.  
  
Potential issues to be aware of:  
  
-   Permissions for local users that are not default computer accounts \(such as local administrators\) will be lost even if the same user name is used when creating the user account on the destination server.  
  
-   Encrypted File Sytsel \(EFS\) cannot be migrated.  
  
-   Encrypted volumes with BitLocker  cannot be migrated without first decrypting the volumes.  
  
-   Remote Storage cannot be migrated.  
  
-   When you are physically migrating disk drives that have File Server Resource Manager quotas enabled on them, it is a best practice to dismount the drive gracefully to avoid marking the quotas as dirty. Otherwise, unnecessary scans may occur later.  
  
###### To migrate data by physically moving the disk drive or by masking and unmasking the LUNs  
  
1.  Collect information from the source server.  
  
    > [!TIP]  
    > You can use Server Manager or Windows PowerShell on a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] to collect information from source computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
    1.  Record the drive letter and volume label for each data volume on the source server that you would like to move to the destination server.  
  
    2.  On the source server, export the volume GUID paths by exporting the following registry subkey to a file: **\\HKEY\_LOCAL\_MACHINE\\SYSTEM\\MountedDevices**. To do this, open the Registry Editor \(regedit.exe\), browse to the registry subkey, right\-click the registry subkey, and clicking **Export**.  
  
        Alternatively, to export the volume GUID paths from a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or Windows Server 2008 R2, open a Windows PowerShell session, and then type the following commands, where *<SourceServer>* is the name of the source server, *<Domain\\User>* is a user account with administrative permissions on the source server and *<LocalPath>\\<Filename>* is a local path and filename of the exported registry keys:  
  
        ```  
        Enter-PSSession <SourceServer> -Credential <Domain\User>  
        ```  
  
        ```  
        Regedit.exe /E <LocalPath>\<Filename>.reg "HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices"  
        ```  
  
        > [!NOTE]  
        > To use Server Manager or Windows PowerShell to remotely collect information from earlier versions of Windows Server, you must first setup the source server for remote management. For more information, see [Managing Downlevel Windows\-based Servers from Server Manager in Windows Server 2012](http://blogs.technet.com/b/servermanager/archive/2012/09/10/managing-downlevel-windows-based-servers-from-server-manager-in-windows-server-2012.aspx).  
  
    3.  Open Notepad, and copy the exported .reg file. Remove all entries that are in the following form: **\\DosDevices\\D:**. Save the.reg file \(all remaining entries should be in the following form: **\\??\\Volume{ef93fe94\-5dd7\-11dd\-961a\-001e4cdb4059}**\).  
  
2.  Prepare the destination server.  
  
    1.  In the Server Manager navigation pane, click **File and Storage Services**, and then click **Volumes** to display the Volumes page. Use the Volumes tile to make sure that the drive letters for the data volumes are available. If there is a drive letter that is currently assigned to an existing volume on the destination server, change the drive letter for that volume.  
  
        Alternatively, use the Windows PowerShell **Get\-Volume** and **Set\-Partition** cmdlets. For example, to get any volumes with the drive letters of F, G, or H, type `Get-Volume F,G,H`. To change the drive letter of a partition with the F drive letter, type `Set-Partition -DriveLetter F -NewDriveLetter Z`  
  
    2.  To import the volume GUID paths into the destination server, copy the.reg file that you created previously to the destination server, and then double\-click that file to update the destination server.  
  
3.  Move the disk drives or LUNs from the source server to the destination server.  
  
    1.  On the source server, remove the disk drives or unassign the LUNs by using Storage Manager for SANs. \(To open Storage Manager for SANs, click **Start**, click **Administrative Tools**, and then click **Storage Manager for SANs**.\) If the source server is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], use the File and Storage Services role in Server Manager instead to view the disks or virtual disks \(when using storage pools\) that you want to move. If the disk is part of a storage pool, on the **Storage Pools** page of the File and Storage Services role right\-click the virtual disk, and then click **Detach Virtual Disk**. For other types of disks, on the **Disks** page, right\-click the disk that you want to move and then click **Take Offline**.  
  
    2.  On the destination server, attach each disk drive or assign the LUNs, and then assign the appropriate drive letter by using the **Disks** and **Storage Pools** pages of the File and Storage Services role in Server Manager.  
  
4.  If any files or folders on the migrated drive use local users or local groups permissions \(except default users and groups\), re\-create these permission. Note that all domain users and groups permissions will remain intact, assuming that the source server and the destination server are members of the same domain.  
  
> [!NOTE]  
> You can use the `icacls` command to modify file and folder permissions \(type `icacls /?` in a Command Prompt window for details\). Type this command in a Windows PowerShell session or a command prompt that has been opened with elevated user rights.  
>   
> The list of the default users and groups is available in the topic [Default User Accounts and Groups](http://go.microsoft.com/fwlink/?LinkId=149889).  
  
#### Migrate shared folders  
If any of the folders on the migrated drive were shared on the source server and must be shared on the destination server, the following steps explain how to migrate shared folders.  
  
1.  If any of the migrated shared folders use local users and group permissions, ensure that you have completed the migration of local users and groups.  
  
    The **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets must be started on the source server and the destination server within five minutes of each other. By default, **Send\-SmigServerData** and **Receive\-SmigServerData** operations terminate if a connection cannot be established within 300 seconds \(five minutes\). The maximum connection time\-out for the **Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets is stored in the following registry subkey, which is user\-defined.  
  
    Subkey: **\\HKLM\\Software\\Microsoft\\ServerMigration**  
  
    Value: MaxConnectionTime \(REG\_DWORD\)  
  
    Data: Between 1 and 3600 \(represents connection time\-out, in seconds\). If a value larger than 3600 is specified, 3600 seconds \(one hour\) is used as the maximum connection time\-out.  
  
    For information about how to create a Windows Registry key, see [Add a Registry Key](http://go.microsoft.com/fwlink/?LinkId=147298).  
  
2.  Open port 7000 on the source server and destination server \(if this has not already been done\).  
  
    For information about how to open a port in Windows Firewall, see [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md).  
  
3.  On the destination server:  
  
    1.  Open a Windows PowerShell session with elevated user rights and enter the following command: **Receive\-SmigServerData**.  
  
4.  On the source server:  
  
    1.  Open a Windows PowerShell session in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003. On computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the Windows PowerShell session must be opened with elevated user rights. Enter the following command: **Send\-SmigServerData \-ComputerName <DestinationServerName> \-SourcePath <SourcePath> \-DestinationPath <DestinationPath> \-Recurse \-Include Share \-Force**  
  
> [!NOTE]  
> The *<SourcePath>* value specifies the local path on the source server that contained the shared folder before the drive was migrated. Shared folder information is not stored on the data drive, so do not be concerned that the drive no longer resides on the source server.  
>   
> The *<DestinationPath>* value specifies the local path on the destination server that contains folders that were previously shared on the source server. Unless the root drive letter or the folder structure has been changed on the migrated drive, the *<SourcePath>* and *<DestinationPath>* values should be the same.  
>   
> During shared folder migration, permissions for local users and groups and domain users and groups are migrated—no manual remapping is required.  
>   
> LanMan Server service automatically restarts on the destination server, and the shared folders migrate.  
  
#### DFS Replication migration  
If you physically migrated data, clean\-up the DFS Replication configuration state, which is stored on the migrated volume.  
  
1.  To clean up volumes \(for each physically migrated volume\)  
  
    1.  Navigate to the path <volume>\\System Volume Information.  
  
        > [!NOTE]  
        > This is a hidden system folder. To view this folder: in File Explorer, click **View**, and then select the **Hidden Items** check box. Also ensure that local administrators are granted **Full Control** of the folder.  
  
    2.  Delete the **DFSR** folder and all content in the folder.  
  
    3.  Revert any security permissions modifications that you made to perform the migration process.  
  
    4.  Repeat this process for all physically migrated volumes.  
  
2.  To clean up replicated folders \(for replicated folders on physically migrated volumes\)  
  
    1.  Navigate to the root of a replicated folder.  
  
    2.  Delete the **DfsrPrivate** folder and all subfolders.  
  
    3.  If the staging folder for the replicated folder is not located in the default location, remove the staging folder and all content in the staging folder.  
  
        > [!NOTE]  
        > The default location for the staging folder is in the DfsrPrivate folder, and this step is not required if the path is at the default location.  
  
    4.  If the **Conflict and Deleted** folder for the replicated folder is not located in the default location, remove the **Conflict and Deleted** folder and all content in the **Conflict and Deleted** folder.  
  
        > [!NOTE]  
        > The default location for the **Conflict and Deleted** folder is in the **DfsrPrivate** folder, and this step is not required if the path is at the default location.  
  
Use the inventoried information that you collected for the source server to detect all replication groups to which the source server belongs. Add the destination server as a member server to all these replication groups.  
  
## <a name="BKMK_MigrateServerIdentity"></a>Migrate the source server identity  
You need to rename the source server and migrate its previous identity to the destination server. You might also need to migrate the source server IP address to the destination server.  
  
### Rename the source server  
Rename the source server to a temporary name.  
  
### Migrate IP address  
When a static IP address is used on the source server, it is recommended that the IP address be migrated from the source server to the destination server. This is because client computers locally cache the IP address that is associated with a server name. Client computers will still attempt to access the source server even if it has been renamed.  
  
When the server IP address is not migrated, you must stop the LanMan Server service on the source server. This is done to prevent users from accessing shared folders on the source server after they have been migrated to the destination server. Open a Windows PowerShell session with elevated user rights, and then run the following cmdlet:  
  
```  
Stop-Service LanmanServer -Force  
```  
  
For more information about IP address migration, see [Migrate IP Configuration to Windows Server 2012](assetId:///60d15eb2-1b7c-4ad8-a03b-3f6e972b6235).  
  
### Rename destination server  
Rename the destination server to the name that was originally used for the source server.  
  
## <a name="BKMK_ConfigureDFSReplicationontheDestinationServer"></a>Export Remote VSS settings  
Follow the procedure in this section to migrate Remote VSS settings from [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
To migrate Remote VSS from [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you must first export the remote VSS settings using the configuration information that is included in the registry and in Group Policy. There are two configuration Group Policy settings for Remote VSS:  
  
-   Computer Policy\->Administrator Templates\->System\->File Share Shadow Copy Provider  
  
-   Computer Policy\->Administrator Templates\->System\->File Share Shadow Copy Agent  
  
You can configure these settings using either local or domain\-based Group Policy. It is recommended that you use a domain\-based policy setting because it does not require migration steps—you simply ensure that the policy setting applies to the new destination computer. If you are using a local policy setting, you must document the current settings for these two policy settings by running gpedit.msc. For the remaining policy settings, export the following registry key \(using reg.exe from a command prompt with Administrative privileges\), and then copy the rvss.reg file to the destination server:  
  
`Reg.exe export "HKLM\SYSTEM\CurrentControlSet\Services\fssagent\Settings" rvss.reg`  
  
### If you migrated the data by copying it  
Follow this procedure to add a replication connection between the source server and the destination server for each replication group on the source server:  
  
1.  In Server Manager, click **Tools**, and then click **DFS Management**.  
  
2.  In the console tree, under the **Replication** node, select **Add Replication Groups to Display**, enter the name of the source, and then click **Show Replication Groups**. Select all of the replication groups that are displayed, and then click **OK**.  
  
3.  For each replication group, do the following:  
  
    1.  Click the replication group, and then click **New Member**. The **New Member Wizard** appears. Follow the instructions in the wizard to add the destination server to the replication group by using the information from row \#2 in the DFS Replication data collection worksheet \([File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)\).  
  
    2.  In the console tree, under the **Replication** node, right\-click the replication group to which you just added the destination server, and then click **New Connection**.  
  
    3.  Specify the source server and destination server as sending and receiving members, and specify a schedule so that the connection is always enabled. At this point, the replication is one\-way.  
  
    4.  Select **Create a second connection in the opposite direction** to create a second connection for two\-way replication between the sending and receiving members.  
  
### If you migrated the data by physically moving it  
Follow this procedure to add a replication connection between the destination server and the closest server to the destination server other than the source server:  
  
1.  In Server Manager, click **Tools**, and then click **DFS Management**.  
  
2.  In the console tree, under the **Replication** node, select **Add Replication Groups to Display**, enter the name of the source, and then click **Show Replication Groups**. Select all of the replication groups that are displayed, and then click **OK**.  
  
3.  For each replication group:  
  
    1.  Click the replication group, and then click **New Member**. The **New Member Wizard** appears. Follow the instructions in the wizard to add the destination server to the replication group by using the information from row \#2 in the DFS Replication data collection worksheet \([File Services Migration: Appendix B: Migration Data Collection Worksheets](http://technet.microsoft.com/library/dd823296(v=ws.10).aspx)\).  
  
    2.  In the console tree, under the **Replication** node, right\-click the replication group to which you just added the destination server, and then click **New Connection**.  
  
    3.  Specify the destination server as the sending member, and then specify any other server except the source server as the receiving member. Specify the schedule to use for the connection. It is recommended that you select a server that has a good network connection to the destination server as the receiving member.  
  
    4.  Select **Create a second connection in the opposite direction** to create a connection for two\-way replication between the sending and receiving members.  
  
> [!NOTE]  
> The folder does not begin to replicate immediately. The new DFS Replication settings must be replicated to all domain controllers, and each member in the replication group must poll its closest domain controller to obtain these settings. The amount of time this takes depends on Active Directory Domain Services \(AD DS\) replication latency and the polling interval \(60 minutes\) on each member. The **dfsrdiag \/pollad** command can be used to force DFS Replication on the source server and destination server to poll AD DS and retrieve the latest configuration information instead of waiting for the next normal polling interval which could be up to 60 minutes.  
>   
> After DFS Replication on the destination server polls AD DS, it begins to replicate the folders that it configured, and it performs an initial synchronization. Event ID 4102 \(MSG\_EVENT\_DFSR\_CS\_INITIAL\_SYNC\_NEEDED\) is registered in the event log on the destination server for each replicated folder.  
>   
> During initial sync, DFS Replication downloads all files in the replicated folders from the source server and builds up a local copy of the database per volume. This process can be time consuming. It is possible to speed up the initial sync by seeding the data from the source server onto the destination server \(from the backup that was taken prior to commencing migration\).  
>   
> When the initial sync completes, event ID 4104 \(MSG\_EVENT\_DFSR\_CS\_INITIAL\_SYNC\_COMPLETED\) is registered for each replicated folder on the destination server. Monitor each replicated folder on the destination server and check to ensure that all of them have completed the initial sync.  
  
## <a name="BKMK_ImportsettingstotheDestinationserver"></a>Import settings to the destination server  
Follow the procedures in this section to import settings to the destination server.  
  
> [!NOTE]  
> If the source server is not running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the first procedure in this section does not apply. \(This procedure is used to migrate the seed value that is used by BranchCache for the Network Files component, and it enables data that is stored in BranchCache on the source server to be used after it is migrated to the destination server. For information about how to migrate a BranchCache host server, see the [BranchCache Migration Guide](http://go.microsoft.com/fwlink/?LinkID=139091).  
  
#### To set up BranchCache for Network Files migration on the destination server  
  
1.  On the destination server, open a Windows PowerShell session with elevated user rights.  
  
2.  Type the following command, where *storepath* is the available path that contains the Svrmig.mig file, and then press Enter.  
  
    ```  
    Import-SmigServerSetting -featureid BranchCache -Path <storepath\BranchCache> -Force -Verbose  
    ```  
  
### Group Policy or local policy specific to server message block and Offline Files  
Use a Group Policy Object or a local policy setting on the destination server to change the settings to the same values as the source server. These settings are recorded in the SMB and BranchCache data collection worksheets in [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md).  
  
##### To import SMB settings  
  
1.  Do one of the following:  
  
    -   If the policy settings are set by using Group Policy Objects, use the Group Policy editing tools to apply appropriate policy settings to the destination server.  
  
    -   If the policy settings are set by using a local policy setting, do the following:  
  
        1.  On the destination server, open the Local Group Policy Editor snap\-in.  
  
        2.  In the snap\-in tree pane, click **Computer Configuration**, click **Windows Settings**, click **Security Settings**, click **Local Policies**, and then click **Security Options**.  
  
2.  Use a Group Policy Object or a local policy setting to set the following settings to the same values as noted in [Export settings](#BKMK_ExportSettings). Set the destination server settings to the same values as were noted on the source server for the following **Microsoft network server** settings:  
  
    -   Microsoft network server: Amount of idle time required before suspending session  
  
    -   Microsoft network server: Attempt S4USelf to obtain claim information  
  
    -   Microsoft network server: Digitally sign communications \(always\)  
  
    -   Microsoft network server: Digitally sign communications \(if client agrees\)  
  
    -   Microsoft network server: Disconnect clients when logon hours expire  
  
    > [!NOTE]  
    > For any policy setting that is controlled by Group Policy, you must have the same Group Policy Object apply to the destination server, or you can set the local policy of the destination server to get the same behavior.  
  
    On destination servers that are running the Server Core installation, run the **secedit** command to change local policy settings \(for more information about **secedit**, type **secedit \/?** at a command prompt\).  
  
> [!NOTE]  
> The following procedure applies only if the source server is [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
##### To import Offline Files settings  
  
1.  Do one of the following:  
  
    -   If the policy settings are set by using Group Policy, use the Group Policy editing tools to apply appropriate policy settings to the destination server.  
  
    -   If the policy settings are set by using local policy, do the following:  
  
        1.  On the destination server, open the Local Group Policy Editor snap\-in.  
  
        2.  In the snap\-in tree pane, click **Computer Configuration**, click **Windows Settings**, click **Administrative Templates**, click **Network**, and then click **LanMan Server**.  
  
2.  Use a Group Policy Object or a local policy setting to set the destination server policy settings to the same values as the source server policy settings for **Hash Publication for BranchCache** and **Hash Version support for BranchCache** settings.  
  
    On destination servers that are running the Server Core installation, run the **secedit** command to change local policy settings \(for more information about **secedit**, type **secedit \/?** at a command prompt\).  
  
### DFS Namespace configuration  
Complete the configuration of namespaces on the destination server. The procedure you use depends on whether you want a stand\-alone or a domain\-based namespace.  
  
-   [Stand\-alone namespaces](#BKMK_impstand)  
  
-   [Domain\-based namespaces with more than one namespace server](#BKMK_dommore)  
  
-   [Domain\-based namespaces with one namespace server](#BKMK_domone)  
  
#### <a name="BKMK_impstand"></a>Stand\-alone namespaces  
If you want a stand\-alone namespace, you must first create the namespace on the destination server. You can do this by using DFS Management, or the **DFSUtil.exe** command\-line utility.  
  
###### To create the namespace on the destination server  
  
1.  Do one of the following:  
  
    -   On the destination server, open DFS Management, and create the namespace by using the same name as on the source server.  
  
    -   On the destination server, in a Command Prompt window opened with elevated user rights, type the following, and then press Enter.  
  
        ```  
        Dfsutil.exe root addstd <\\DestinationServer\Namespace>  
        ```  
  
###### To import a namespace configuration from the export file  
  
1.  On the destination server, in a Command Prompt window opened with elevated user rights, type the following \(in which *filename* represents the file name into which you exported namespace settings from the source server in [To export the namespace configuration to an export file](#BKMK_standaloneexport)\), and then press Enter.  
  
    ```  
    Dfsutil.exe root import set <filename> <\\DestinationServer\Namespace>  
    ```  
  
#### <a name="BKMK_dommore"></a>Domain\-based namespaces with more than one namespace server  
If you have more than one domain\-based namespace server, you can add namespace servers to your destination server by using DFS Management or the **DFSUtil.exe** command\-line utility.  
  
###### To use DFS Management  
  
1.  Select the namespace being migrated in the left pane.  
  
2.  Click the **Namespace servers** tab in the right pane.  
  
3.  Select **Add Namespace Server**.  
  
4.  In the dialog box that opens, type the name of the destination server, and then click **OK**.  
  
The destination server is added to the namespace.  
  
###### To use DFSUtil.exe  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Type the following command, and then press Enter.  
  
    ```  
    DFSUtil.exe target add <\\DestinationServer\Namespace>  
    ```  
  
#### <a name="BKMK_domone"></a>Domain\-based namespaces with one namespace server  
This section applies only if a temporary server was not added to the namespace. If you added a temporary server to the namespace as part of your export process, see [Domain\-based namespaces with more than one namespace server](#BKMK_dommore).  
  
###### To create the namespace on the destination server  
  
1.  Do one of the following:  
  
    -   In DFS Management on the destination server, create the namespace with the same name that was used on the source server.  
  
    -   Type the following command at a command prompt, and then press Enter.  
  
        ```  
        Dfsutil.exe root adddom <\\DestinationServer\Namespace>  
        ```  
  
###### To import a namespace configuration from the export file  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Type the following command \(in which *Filename* represents the export file names you created in [To export namespace settings](#BKMK_exnssettings)\). Run this command for each of the namespaces for which the source server was a namespace server.  
  
    ```  
    DFSUtil.exe root import set <Filename> \\DestinationServer\Namespace  
    ```  
  
    > [!NOTE]  
    > For each namespace, there must be a file name from which settings are imported.  
  
###### To manually reset delegation permissions on the namespace  
  
1.  On the destination server, open DFS Management.  
  
2.  Set the permissions that you inventoried in [DFS Namespace configuration](#BKMK_dfsnameconfig). When complete, close DFS Management.  
  
If any advanced registry keys were configured on *SourceServer*, use **DFSUtil.exe** to configure *DestinationServer* to have the same registry key settings. Run the following commands on the destination server to set the advanced registry keys.  
  
###### To set advanced registry keys  
  
1.  On the destination server, open a Command Prompt window.  
  
2.  Run the following commands to set the advanced registry keys by using **DFSUtil.exe**.  
  
    -   ```  
        DFSUtil.exe server registry DfsDnsConfig set <DestinationServer>  
        ```  
  
    -   ```  
        DFSUtil.exe server registry LdapTimeoutValue set <Value> <DestinationServer>  
        ```  
  
    -   ```  
        DFSUtil.exe server registry SyncInterval set <Value> <DestinationServer>  
        ```  
  
### File Server Resource Manager configuration on the destination server  
When you are migrating File Server Resource Manager, remember to use the same drive letters for the destination server volumes as for the source server. This is required because File Server Resource Manager migration requires that the drive letter remains the same.  
  
1.  Stop the File Server Resource Manager and File Server Storage Reports Manager services.  
  
    Open a Windows PowerShell session with elevated user rights, and then run the following command:  
  
    ```  
    Stop-Service -name "srmsvc","srmreports"  
    ```  
  
2.  Type the following in the Windows PowerShell session, and then press Enter.  
  
    ```  
    Import-SmigServerSetting -FeatureID FS-Resource-Manager -Path <storepath\FSRM> -Force  
    ```  
  
    > [!NOTE]  
    > If the Windows features that you are migrating have not been installed on the destination server, the **Import\-SmigServerSetting** cmdlet installs them as part of the import process, along with any Windows features that they depend on. Some Windows features might require that you restart the destination server to complete the installation. After restarting the computer, you must run the cmdlet again with the **\-Force** parameter to complete the import operation.  
    >   
    > Importing FSRM settings to the destination server replaces any global FSRM configuration information that is already on the destination server.  
  
3.  Set the configuration files for each volume.  
  
    Type the following commands in a Windows PowerShell session, and then press Enter.  
  
    > [!NOTE]  
    > Running the following commands on a clean computer returns an error message. It is safe to ignore this error message.  
  
    1.  Type the following command to stop the file screen driver:  
  
        ```  
        fltmc detach datascrn <VolumeLetter>:  
        ```  
  
    2.  Type the following command to stop the quota driver:  
  
        ```  
        fltmc detach quota <VolumeLetter>:  
        ```  
  
    3.  Add administrator Write permissions to the "<VolumeLetter>:\\System Volume information\\SRM" folder and the following subfolders:  
  
        -   takeown \/F "<VolumeLetter>:\\System Volume Information" \/A \/R \/D Y  
  
        -   cacls "<VolumeLetter>:\\System Volume Information" \/T \/E \/G Administrators:F  
  
        -   attrib \-S \-H "<VolumeLetter>:\\System Volume Information\\\*" \/S \/D  
  
    4.  Copy the following files from the external storage to the **SRM** folder:  
  
        -   Quota.xml  
  
        -   Quota.md  
  
        -   Datascrn.md  
  
        -   DataScreenDatabase.xml  
  
    5.  Type the following command to start the file screen driver:  
  
        ```  
        fltmc attach datascrn <VolumeLetter>:  
        ```  
  
    6.  Type the following command to start the quota driver:  
  
        ```  
        fltmc attach quota <VolumeLetter>:  
        ```  
  
4.  Restart the File Server Resource Manager and File Server Storage Reports Manager services.  
  
    Type the following command in a Windows PowerShell session, and then press Enter.  
  
    ```  
    Start-Service -name "srmsvc","srmreports"  
    ```  
  
5.  Configure scheduled reports and file management tasks.  
  
    For each scheduled report, you need to create a scheduled task on the destination server.  
  
    > [!NOTE]  
    > File Server Resource ManagerReports and classification rule configurations are dependent on the drive letters and mount points. Any drives or mount points on the source server that are used by report or classification rule configurations must be available on the destination server or the configurations must be updated during import.  
  
    After you have an XML file for each task, copy them to the destination server and run the following command in a Windows PowerShell session on the destination server for each task:  
  
    ```  
    schtasks /create /xml:"TASKNAME.xml" /tn:"TASKNAME"  
    ```  
  
6.  Import the classification schedule. The classification schedule requires a scheduled task on the destination server.  
  
    ```  
    schtasks /create /xml:"classification.xml" /tn:"FsrmAutoClassification{c94c42c4-08d5-473d-8b2d-98ea77d55acd}"  
    ```  
  
    Note that *classification.xml* is the name of the XML file that was exported from the target server.  
  
### Shadow Copies of Shared Folders  
Apply the same settings from the source server to the corresponding volumes on the destination server.  
  
##### To migrate shadow copy settings for Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003  
  
1.  To configure shadow copies, right\-click each volume on the destination server that had shadow copies configured on the source server, and then click **Configure Shadow Copies**.  
  
2.  Click **Settings** and verify that the location and size of shadow copy storage matches the settings from the source server.  
  
3.  Click **Schedule** and verify that the details for the snapshot creation task match the settings from the source server.  
  
##### To migrate shadow copy settings for a Server Core installation  
  
1.  Log on to the destination server that is remotely running the Server Core installation by doing the following:  
  
    1.  In Server Manager, click **Tools**, and then click **Computer Management**.  
  
    2.  In the **Computer Management** snap\-in tree pane, right\-click the top node, and then click **Connect to another computer**.  
  
2.  Enter the computer name, and then click **OK**.  
  
3.  Expand **System Tools**, right\-click **Shared Folders**, click the **All Tasks** tab, and then click **Configure Shadow Copies**.  
  
4.  For each volume on the destination server that had shadow copies configured on the source server, right\-click the volume, click **Configure Shadow Copies**, click **Settings**, and verify that the location and size of shadow copy storage match the settings from the source server.  
  
5.  Click **Schedule**, and verify that these details for the snapshot creation task match the settings from the source server.  
  
### Deduplication  
Use the following section to migrate Deduplication.  
  
#### Migrating Deduplication from Windows Server 2012 to Windows Server 2012  
All configuration information needed for migration is included on the deduplicated volume.  
  
If a disk is physically moved, or if a deduplicated volume is restored from a backup onto a different Windows Server 2012 computer, install the Deduplication role service using Server Manager on the new computer. If the Deduplication role service is not installed on the new server, only normal nondeduplicated files will be accessible. After a volume has been mounted, the deduplication filter will detect that the volume is deduplicated and will redirect input\/output requests appropriately.  
  
> [!NOTE]  
> Any previous custom deduplication job schedules that were created using Task Scheduler must be created again on the new computer using Task Scheduler.  
  
#### Migrating SIS from Windows Storage Server 2008 to Windows Server 2012  
Volumes that have been created and optimized using the down\-level Windows Storage Server version of deduplication, Single Instance Storage \(SIS\), should not be enabled for data deduplication. Microsoft recommends that SIS be removed from the volume by using SISAdmin.exe within Windows Storage Server to remove SIS or by copying the data to a different volume that is not running SIS prior to migrating the volume.  
  
Windows Server 2012 supports reading and writing to SIS\-controlled volumes, but you cannot continue to use SIS files using Windows Server 2012. You can install the SIS filter driver on Windows Server 2012 by installing the SIS\-Limited feature using the following command syntax:  
  
```  
dism /online /enable-feature:SIS-Limited  
```  
  
The SIS filter driver can be loaded so that you can read SIS\-controlled volumes and the data can be copied to a non\-SIS controlled volume so that data deduplication can be installed on the volume. Note that Windows Server 2012 does not support sisadmin.exe and cannot be used to remove SIS from a volume.  
  
1.  You should remove SIS from your volumes before installing the Windows Server 2012 data deduplication feature. \(This process is also known as disabling SIS.\)  
  
2.  Do not restore SIS links from a backup to a Windows Server 2012 deduplicated volume.  
  
3.  Restoring SIS volumes to Windows Server 2012 is supported if you load the SIS\-Limited filter.  
  
#### Migrating SIS volumes  
You have several options when it comes to migrating Windows Storage Server 2008 volumes to Windows Server 2012 to take advantage of the new Data Deduplication feature.  
  
You can migrate your existing SIS\-installed Windows Storage Server 2008 volumes to Windows Server 2012; however, migration is not automatic. SIS and data deduplication are mutually\-exclusive technologies.  
  
> [!CAUTION]  
> You will need to open the volumes in Windows Storage Server 2008 first, un\-SIS them, and then uninstall SIS before migrating to Windows Server 2012 as described in the procedures below.  
  
To disabling SIS a Windows Storage Server 2008 R2 or 2008 SIS volume, type **sisadmin.exe \[\/m <server>\] \[\/u <volumes>\]** where:  
  
1.  **\/m <server>** shifts the focus of the command line to a remote server. If the *\/m* option is not specified, the command line is applied to the local server. *<server>* can be expressed as a host name, fully qualified domain name \(FQDN\), or IP address.  
  
2.  **\/u <volumes>** is used to un\-SIS a volume \(that is, to restore all file copies and remove reparse points\).  
  
For each command option that uses *<volumes>* as a parameter, *<volumes>* represents a space\-delimited list of volume names \(for example, d:, e:, f:, and g:\).  
  
To unSIS or remove SIS entirely from the F: volume of a remote server using the IP address of the server, use the following command: **sisadmin.exe \/m 192.168.1.50 \/u F:**  
  
### Import Remote VSS settings  
Follow the procedure in this section to migrate Remote VSS settings from [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
To finish migrating Remote VSS from [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], import the remote VSS settings using the configuration information that is included in the registry and in Group Policy. There are two configuration Group Policy settings for Remote VSS:  
  
-   Computer Policy\->Administrator Templates\->System\->File Share Shadow Copy Provider  
  
-   Computer Policy\->Administrator Templates\->System\->File Share Shadow Copy Agent  
  
You can configure these policy settings using either local or domain\-based Group Policy. It is recommended that you use a domain\-based policy setting because it does not require migration steps—you simply ensure that the policy setting applies to the new destination computer. If you are using a local policy setting, open gpedit.msc and recreate the policy settings that you documented in [Export Remote VSS settings](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md#BKMK_ConfigureDFSReplicationontheDestinationServer).  
  
For the remaining policy settings, import the registry key that you previously exported by using reg.exe from a command prompt with Administrative privileges.  
  
For the remaining policy settings, import the registry key by using reg.exe from a command prompt with Administrative privileges:  
  
`Reg.exe import rvss.reg`  
  
## See also  
  
-   [Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
  
-   [File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
  
-   [File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
  
-   [File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
  
-   [File and Storage Services: Migrate Network File System](../Topic/File-and-Storage-Services--Migrate-Network-File-System.md)  
  
-   [File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
  
-   [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
  
-   [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
