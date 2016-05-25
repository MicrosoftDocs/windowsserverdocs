---
title: Configure a Disconnected Network to Receive Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9ee2ea63-ef22-47b4-93e7-84fb603e1afc
author: britw
---
# Configure a Disconnected Network to Receive Updates
You can use [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] to manage updates to computers that are located on a network segment that is not connected to the Internet by following these steps:  
  
1.  Install a WSUS server on the disconnected network segment. This server is known as the *WSUS import server*.  
  
2.  Synchronize updates and metadata to a WSUS server that is connected to the Internet. This server is known as the *WSUS export server*.  
  
3.  Transfer the required updates and metadata from the WSUS export server to removable media.  
  
4.  Transport the removable media to the WSUS import server.  
  
5.  Import the updates and metadata to the WSUS import server.  
  
6.  Manage and download updates to client computers on the disconnected network segment by using the WSUS import server.  
  
This topic assumes that you already have installed the WSUS servers.  
  
**In this topic:**  
  
-   [Match express file installation and language settings on export and import servers](../Topic/Configure-a-Disconnected-Network-to-Receive-Updates.md#MatchSettings)  
  
-   [Export updates and metadata](../Topic/Configure-a-Disconnected-Network-to-Receive-Updates.md#Export)  
  
-   [Import updates and metadata](../Topic/Configure-a-Disconnected-Network-to-Receive-Updates.md#Import)  
  
## <a name="MatchSettings"></a>Match express file installation and language settings on export and import servers  
Before you export and import updates, you should confirm that the settings for express installation files and update languages on the WSUS export server match the settings on the WSUS import server. If these settings do not match, updates will not be correctly applied. For example, if express installation files are not selected on the export WSUS server, but they are selected on the WSUS import server, you cannot distribute updates by using express installation files. This is because no express installation files were downloaded by the export server. A mismatch of language settings can have a similar effect.  
  
You do not have to match the following settings on the export and import servers:  
  
-   Proxy server settings  
  
-   Download schedule  
  
-   Products and product classifications  
  
-   Source  
  
The deferred download of updates setting does not affect the WSUS import server. If you use deferred downloads on the WSUS export server, you must approve the updates before you can migrate them to the WSUS import server.  
  
#### To determine express installation and language options settings  
  
1.  Verify that the user account that is used to perform this procedure is a member of the local Administrators group or the WSUS Administrators group on the WSUS import and export servers.  
  
2.  On the WSUS export server, click **Start**, click **All Programs**, click **Administrative Tools**, and then click **Windows Server Update Services**.  
  
3.  In the left pane, expand the WSUS export server name, and then click **Options**.  
  
4.  In the middle pane, click **Update Files and Languages**.  
  
5.  If the **Store updates locally on this server** option is selected on the **Update Files** tab, check the setting for **Download express installation files**.  
  
6.  Click the **Update Languages** tab and identify the settings for the update languages.  
  
7.  Repeat these steps for the WSUS import server and verify that the **Download express installation files** and **Languages** settings match those settings on the exporting server.  
  
## <a name="Export"></a>Export updates and metadata  
You must transfer update files and update metadata from the WSUS export server to removable media, which is then used to import the data to the WSUS import server. The update files are located in the file system, and the update metadata is located in the WSUS database, on the WSUS export server.  
  
You can use the Windows Backup Wizard or any other file transfer utility to transfer update files from the WSUS export server to removable media. Consider using an incremental backup method to limit the data that you must transfer every time that you refresh the WSUS import server.  
  
By default, WSUS stores local updates in the \\WSUS\\WSUSContent\\ folder. You must transfer all files in this folder to the removable media. For more information about how to use Windows Server Backup, see [Windows Server Backup](http://go.microsoft.com/fwlink/?LinkID=201294).  
  
You must export the update metadata from the WSUS database on the WSUS export server by using the WSUSUtil.exe utility program. Although you can use incremental backup and restore functions to import update files to the WSUS import server, you cannot incrementally transfer the update metadata. During the export operation, WSUSutil.exe exports all metadata from the WSUS database.  
  
> [!IMPORTANT]  
> During an import or export process, the WSUS update service is shut down.  
  
#### To export metadata  
  
1.  Verify that the user account that is used to perform this procedure is a member of the local Administrators group on the WSUS export server.  
  
2.  Open a Command Prompt window on the WSUS export server and open the folder that contains WSUSutil.exe. This is usually the \\Program Files\\Update Services\\Tools folder.  
  
3.  Type the following command:  
  
    **wsusutil.exe export***packagename.cab logfile.log*  
  
    where:  
  
    -   *Packagename.cab* is a unique file name to contain the metadata.  
  
    -   *logfile.log* is a unique file name to contain the export log.  
  
    WSUSutil.exe will create the .cab and .log files as it exports metadata from the WSUS database.  
  
4.  Use any file copy utility to transfer the export files to the removable media.  
  
## <a name="Import"></a>Import updates and metadata  
  
> [!WARNING]  
> You must always import the update files to the WSUS import server before you import the update metadata. If WSUS finds metadata for an update that does not have corresponding update files, WSUS considers the update to be a failed download. To resolve this issue, copy the update to a directory on the WSUS import server and redeploy the update.  
  
Use the appropriate file transfer utility to transfer the update files from the removable media to the WSUS import server. If you used the Windows Server Backup utility to back up the update files, you must also use Windows Server Backup utility to restore the update files. You must maintain the WSUS export server’s folder structure for all folders that reside under the \\WSUS\\WSUSContent\\ folder on the WSUS import server.  
  
After you transfer the update files to the WSUS import server, you can transfer the update metadata by using the following procedure.  
  
#### To import metadata  
  
1.  Verify that the user account that is used to perform this procedure is a member of the local Administrators group on the WSUS import server.  
  
2.  Open a Command Prompt window on the WSUS import server and open the folder that contains WSUSutil.exe. This is usually the \\Program Files\\Update Services\\Tools folder.  
  
3.  Type the following command:  
  
    **wsusutil.exe import***packagename.cab logfile.log*  
  
    where:  
  
    -   *Packagename.cab* is the name of the .cab file that was created during the export operation.  
  
    -   *logfile.log* is a unique file name to contain an import log.  
  
    WSUSutil.exe imports the metadata from the removable media and creates a log file of the operation.  
  
    > [!NOTE]  
    > It can take three to four hours for the WSUS database to validate newly imported content.  
  
## See Also  
[Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md)  
  
