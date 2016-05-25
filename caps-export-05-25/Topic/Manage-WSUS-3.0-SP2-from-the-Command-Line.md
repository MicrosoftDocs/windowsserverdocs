---
title: Manage WSUS 3.0 SP2 from the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4d4b90e9-bbb2-429a-92c9-1e5388240416
author: britw
---
# Manage WSUS 3.0 SP2 from the Command Line
You can use the **wsusutil** command\-line utility that is provided with [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 to manage WSUS. The **wsusutil** tool is located in the *WSUSInstallDrive:\\WSUSInstallDirectory***\\Tools** folder on WSUS servers.  
  
> [!NOTE]  
> **wsusutil** is not installed on non\-WSUS servers on which the WSUS Administration Console is installed.  
  
In this topic:  
  
-   [Summary of wsusutil commands](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#sum)  
  
-   [Command: configuressl](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#configuressl)  
  
## <a name="wsutilproc"></a>To run the wsusutil tool  
  
1.  Log on to the WSUS server by using an account that is an administrator on the local computer.  
  
2.  [!INCLUDE[cmd_admin](../Token/cmd_admin_md.md)]  
  
3.  In the Command Prompt window, type the following command:  
  
    **Wsusutil***\/command \/parameter*  
  
## <a name="sum"></a>Summary of wsusutil commands  
The following table summarizes the **wsusutil** commands:  
  
###  
  
|Command|Description|  
|-----------|---------------|  
|**checkhealth**|This command checks the health of the WSUS server. The health check is configured by **wsusutil healthmonitoring**. The results are written to the event logs.<br /><br />-   Syntax: **wsusutil checkhealth**|  
|**configuressl**|Updates the WSUS server registry key after the [!INCLUDE[iis_nover](../Token/iis_nover_md.md)] configuration has changed.<br /><br />-   If this command is run with the optional *ServerCertificateName* parameter, the server certificate name is also updated.<br />-   If this command is run without the *ServerCertificateName* parameter, it updates the host headers settings.<br />-   Syntax: **wsusutil configuressl***<ServerCertificateName>* \( *<ServerCertificateName>* is an optional parameter\)<br />-   The output is the address of the WSUS website \(including the port number\); for example, **https:\/\/serverName:443**.<br /><br />For more information about how to configure Internet Information Services \(IIS\) and Secure Sockets Layer \(SSL\) for WSUS, see [Configure Internet Information Services \(IIS\)](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#iis).|  
|**deletefrontendserver**|Deletes the specified front\-end server from the WSUS database.<br /><br />-   Syntax: **wsusutil deletefrontendserver** *serverName* **Important:** This command removes the front\-end server from the database only. You will need to run **wsussetup \/u** on the front\-end server to uninstall WSUS.|  
|**export**|The first part of the export\/import process to synchronize a disconnected downstream WSUS server. Exports update metadata to an export package file. You cannot use this parameter to export update files, update approvals, or server settings.<br /><br />-   Syntax: **wsusutil export** *package* *logfile*<br />-   See the [export parameters](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#export) table.<br /><br />For more information about exporting and importing updates, see the [Configure a Disconnected Network to Receive Updates](../Topic/Configure-a-Disconnected-Network-to-Receive-Updates.md) section in the Windows Server Update Services3.0 SP2 Deployment Guide. **Note:** Exporting to or from a WSUS 2.0 server is not supported.|  
|**healthmonitoring**|Configures health monitoring values in the database. If new values are not specified, the current values are displayed.<br /><br /><ul><li>Syntax: **Wsusutil healthmonitoring***parameterName*</li><li>See the [healthmonitoring parameters](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#healthmonitoring) table.</li><li>The output from **wsusutil** *parameterName* is usually the current state of the given parameter, for example:<br /><br /><ul><li>**wsusutil healthmonitoring** *IntervalsInMinutes*<br /><br />        Output: **Detect interval: 10 min, Refresh interval: 360 min**</li><li>**wsusutil healthmonitoring** *DiskSpaceInMegabytes*<br /><br />        Output: **Error level: 200 MB, Warning level: 500 MB**</li></ul></li><li>When a health monitoring check parameter \(for example, **wsusutil healthmonitoring***CheckAcls*\) is set on or off, the output will simply be a warning that the WSUS Service must be stopped and restarted for the change to take effect.</li></ul> **Note:** You can set or get only one parameter at a time.|  
|**import**|The second part of the export\/import process. Imports update metadata to a server from an export package file that was created on another WSUS server. This command synchronizes a disconnected destination WSUS server.<br /><br />-   Syntax: **wsusutil import** *package* *logfile*<br />-   See the [import parameters](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#import) table.|  
|**listfrontendservers**|This command lists the front\-end servers in a network load balancing \(NLB\) configuration. It can be useful in troubleshooting an NLB configuration and after setting up a new front\-end server to make sure that it is configured properly.|  
|**listinactiveapprovals**|Returns a list of approved update titles that are in a permanently inactive state because of a change in server language settings.<br /><br />-   If you change language options on an upstream WSUS server, the number of approved updates on the upstream server may not match the number of approved updates on a replica server. For example, you configure your upstream server to synchronize all languages, then synchronize and approve 300 updates, of which 50 are non\-English language updates. Afterward, you change the language setting on the server to English only. Later, a replica server synchronizes from the upstream server and downloads the "active" approvals, which are now only the English language updates \(replica servers synchronize only active approvals\). At this point, you will see 300 updates approved on the upstream server, but only 250 approved on the replica server. You can use **listinactiveapprovals** to see a list of the updates on the parent upstream server that are permanently inactive—in this case, the 50 updates that are not English. You do not have to run this command before running the **removeinactiveapprovals** command.<br />-   Syntax: **wsusutil listinactiveapprovals**|  
|**movecontent**|Changes the file system location where the WSUS server stores update files, and optionally copies any update files from the original location to the new location<br /><br />See the [Movecontent](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#Movecontent) section for more information.|  
|**removeinactiveapprovals**|Removes approvals for updates that are in a permanently inactive state because of a change in WSUS server language settings.<br /><br />-   Syntax: **wsusutil removeinactiveapprovals**|  
|**reset**|You use this command if you store updates locally on your WSUS server, and you want to ensure that the metadata information stored in your WSUS database is accurate.<br /><br />-   With this command, you verify that every update metadata row in the WSUS database corresponds to update files that are stored in the local update file storage location on your WSUS server. If update files are missing or have been corrupted, WSUS downloads the update files again. This command might be useful to run after you restore your database, or as a first step when troubleshooting update approvals.<br />-   Syntax: **wsusutil reset**|  
|**usecustomwebsite**|-   If set to **true**, WSUS Setup will use port 8530 for its default website. If you set it to **false**, WSUS will use port 80.<br />-   Syntax: **wsusutil usecustomwebsite true** **Important:** <ul><li>You must use this command before you configure SSL.</li><li>If you are installing SharePoint on the same computer as WSUS, the value of **usecustomwebsite** should be set to **true** before the installation.</li><li>Using this command after running WSUS Setup will fail if the index of the default website is set to a value other than 1.</li></ul>|  
  
### <a name="healthmonitoring"></a>  
### Healthmonitoring parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|**IntervalsInMinutes***\[DetectInterval\] \[RefreshInterval\]*|Sets the values for detect and refresh intervals. If the detect interval is 0, the detect cycle will not run. If the refresh interval is 0, the refresh cycle will not run.<br /><br />For more information about the detect and refresh cycles, see [Health monitoring in WSUS 3.0 SP2](../Topic/Health-monitoring-in-WSUS-3.0-SP2.md).|  
|**DiskSpaceInMegabytes***\[ErrorLevel\] \[WarningLevel\]*|Sets the amount of available disk space \(in megabytes\) at which a low disk space warning or error event should be logged.|  
|**CatalogSyncIntervalInDays***\[Days\]*|Sets the number of days that should have passed after synchronization before a warning event is logged.|  
|**InstallUpdatesInPercent***\[WarningPercent\]\[ErrorPercent\]*|Sets the percentage of update installation failures at which a warning or error event is given.|  
|**InventoryInPercent***\[WarningPercent\]\[ErrorPercent\]*|Sets the percentage of inventory reporting failures at which a warning or error is given.|  
|**SilentClientsInPercent***\[WarningPercent\]\[ErrorPercent\]*|Sets the percentage of client computers not reporting to the server at which a warning or error should be given.|  
|**SilentClientsInDays***\[Days\]*|Sets the number of days that client computers can fail to report before an error should be given.|  
|**TargetComputersInPercent***\[WarningPercent\]\[ErrorPercent\]*|Sets the maximum percentage of target computers reporting to this server below which a warning or error event should be given. For example, if you set values of 80 and 60, a warning event will be logged if only 80 percent of computers have reported, and an error event will be logged if only 60 percent of computers have reported.|  
|**CheckAcls***on&#124;off*|On indicates to check ACLs on the relevant directories.|  
|**CheckForLowDiskSpace***on&#124;off*|On indicates to check for low disk space.|  
|**CheckForCatalogSyncFailures***on&#124;off*|On indicates to check for catalog synchronization failures.|  
|**CheckForContentSyncFailures***on&#124;off*|On indicates to check for content synchronization failures.|  
|**CheckForEmailNotificationFailures***on&#124;off*|On indicates to check for email notification failures.|  
|**CheckSelfUpdate***on&#124;off*|On: check for client self\-update failures.|  
|**CheckClientsExist***on&#124;off*|On indicates to check whether this server has any client computers.|  
|**CheckForUpdateInstallFailures***on&#124;off*|On: check for update installation failures.|  
|**CheckForInventoryFailures***on&#124;off*|On indicates to check for client computers that fail to report inventory.|  
|**CheckForSilentClients***on&#124;off*|On indicates to check for client computers that failed to report to the server.|  
|**CheckForTooManyClients***on&#124;off*|On indicates to check whether the number of client computers is approaching the maximum number allowed.|  
|**CheckReportingWebService***on&#124;off*|On indicates to check the Reporting web service.|  
|**CheckApiRemotingWebService** *on&#124;off*|On indicates to check the API Remoting web service.|  
|**CheckServerSyncWebService** *on&#124;off*|On indicates to check the Server Synchronization web service.|  
|**CheckClientWebService***on&#124;off*|On indicates to check the client web service.|  
|**CheckSimpleAuthWebService***on&#124;off*|On indicates to check the Simple Authentication web service.|  
|**CheckDssAuthWebService***on&#124;off*|On indicates to check the Downstream Server Authentication web service.|  
  
### <a name="export"></a>  
### Export parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|*package*|The path and file name of the.cab file to create.|  
|*logfile*|The path and file name of the log file to create.|  
  
### <a name="import"></a>  
### Import parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|*package*|The path and file name of the.cab file to import.|  
|*logfile*|The path and file name of the log file to import.|  
  
### <a name="Movecontent"></a>Movecontent  
When you run this command, **wsusutil** does the following:  
  
-   Copies the update files from the old location to the new location. The old location is not deleted.  
  
-   Updates the WSUS database to refer to the new location of the update files.  
  
-   Ensures that the content and metadata are synchronized. This check is always run, even if the **–skipcopy** parameter is used.  
  
The destination folder to which update files are moved must be on an NTFS partition. The utility will not try to copy update files if they already exist in the destination folder. The destination folder will have the same permissions that were set for the original folder.  
  
> [!NOTE]  
> You can use **xcopy**, the Backup utility, or other methods to copy update files from the old location to the new one. If you copy the files by using a method other than **wsusutil**, you still need to run **wsusutil** to perform the second part of the move, which is using the \-**skipcopy** parameter. See the [Syntax](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#BKMK_Syntax) section for more information.  
  
There are two scenarios in which you might move update files from one WSUS hard disk drive to another:  
  
-   If the hard disk drive is full  
  
-   If the hard disk drive fails  
  
#### If the hard disk drive is full  
If the hard disk drive where WSUS stores update files is full, you can do one of the following:  
  
-   Add more space to your current hard disk drive by using NTFS functionality. This operation can be done without using **wsusutil**, because it does not affect WSUS configuration or operation.  
  
-   Install a new hard disk drive, and then move the update files from the old hard disk drive to the new location by using **wsusutil**.  
  
#### If the hard disk drive fails  
If the hard disk drive fails, you must do the following:  
  
1.  Install a new hard disk drive on your computer, and then restore the update files from your backup files.  
  
    > [!NOTE]  
    > If you have not backed up your update files, WSUSutil.exe downloads the missing files at the end of the content move operation.  
  
2.  Run **wsusutil movecontent***newLocation*, and specify the location for the new hard disk drive. In addition, you specify the –**skipcopy** parameter, because you are putting the files in the new folder through the backup utility, or the source folder does not exist. The update files will be downloaded at the end of this process.  
  
3.  When the move operation is complete, all the missing files are downloaded.  
  
#### <a name="BKMK_Syntax"></a>Syntax  
**wsusutil movecontent** *contentpath logfile* **\-skipcopy**  
  
### Movecontent parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|*contentpath*|The new root for content files. The path must exist.|  
|*logfile*|The path and file name of the log file to create.|  
|*\-skipcopy*|Indicates that only the server configuration should be changed, and that the content files should not be copied.|  
  
