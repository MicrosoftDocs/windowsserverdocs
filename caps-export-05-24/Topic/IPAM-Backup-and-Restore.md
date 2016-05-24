---
title: IPAM Backup and Restore
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8d12b013-5ffe-47eb-a08c-b8a3bb1c5593
---
# IPAM Backup and Restore
This topic provides instructions for a performing backup and restore of an IPAM server, using Windows Server Backup tools in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. You can use the steps in this topic to:  
  
1.  Configure a regularly scheduled backup of IPAM data.  
  
2.  Recover the IPAM database on an IPAM server.  
  
## Requirements for using Windows Server Backup  
Windows Server Backup is available on all editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. However, the Windows Server Backup snap\-in is not available when you use the Server Core installation option. To run backups for computers with a Server Core installation, you must use the command line or manage backups remotely from another computer that is running a full installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information, see [Windows Server Backup Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/ee706683.aspx) \(http:\/\/technet.microsoft.com\/library\/ee706683.aspx\).  
  
If Windows Server Backup feature is not installed on your system, you can install the feature as described in [Install Windows Server Backup Tools](http://technet.microsoft.com/library/cc732081.aspx) \(http:\/\/technet.microsoft.com\/library\/cc732081.aspx\).  
  
Membership in the **Administrators** group or **Backup Operators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## <a name="backup_and_restore"></a>Backup and restore IPAM  
  
> [!IMPORTANT]  
> If the version of IPAM changes or patches are installed between backup and restore procedures, you may need to convert the database schema to higher version so that it is compatible.  
  
The following procedures assume that a network share is available on another server \(for example: \\\\MyBackupSrv\\ipambackup\) to store IPAM backup data.  
  
## <a name="backup"></a>  
#### To create a scheduled backup  
  
1.  On the IPAM server, open **Administrative Tools** and then click **Windows Server Backup**.  
  
2.  In the navigation pane, right\-click **Local Backup** and then click **Backup Schedule**.  
  
    > [!TIP]  
    > Choosing **Backup Schedule** does not create a backup immediately. After using **Backup Schedule** to create a regularly scheduled backup, you can also choose to create a backup immediately with the **Backup Once** option.  
  
3.  In the Backup Schedule Wizard, click **Next**.  
  
4.  On the **Select Backup Configuration** page, choose **Custom** and then click **Next**.  
  
5.  On the **Select Items for Backup** page, click **Add Items**.  
  
6.  In **Select Items**, browse to **Windows\\System32\\ipam\\Database** and select **ipam.mdf** and **ipam\_log.ldf**.  
  
    ![](../Image/IPAM_backup1.gif)  
  
7.  Click **OK** and then click **Next**.  
  
8.  On the **Specify Backup Time** page, choose when and how often to perform a backup of the IPAM database, and then click **Next**.  
  
9. On the **Specify Destination Type** page, choose a location to store backup files and then click **Next**. In this example, a shared network folder is used. If you choose another option, you must have a hard disk available to store files that does not contain operating system or application files.  
  
10. If you chose to backup files to a network share, click **OK** in the notification dialog box.  
  
11. Type a location for the network share under Location \(for example: **\\\\MyBackupSrv\\ipambackup**\) and then click **Next**.  
  
12. In the Windows Security dialog box, provide credentials that have permission to write to the network share and then click **OK**.  
  
13. On the **Confirmation** page, click **Finish**.  
  
14. Verify that **You have successfully created the backup schedule** is displayed, and then click **Close**.  
  
## <a name="restore"></a>  
#### To restore from a backup  
  
1.  Temporarily stop the Windows Internal Database service on the IPAM server by typing **services.msc** in an elevated command prompt, pressing ENTER, right\-clicking **Windows Internal Database**, and then clicking **Stop**.  
  
    Leave the Services console open so that you can start the Windows Internal Database service again after the IPAM database has been restored from backup.  
  
2.  On the IPAM server, open **Administrative Tools** and then click **Windows Server Backup**.  
  
3.  Right\-click **Local Backup** and then click **Recover**.  
  
4.  On the **Getting Started** page, choose the location where a backup is stored. In this example, a backup is stored on a network share so **A backup stored on another location** is chosen. Click **Next** to continue.  
  
5.  On the **Specify Location Type** page, choose **Remote shared folder**. Choose **Local drives** only if your backup was not stored remotely as shown in this example. Click **Next** to continue.  
  
6.  On the Specify Remote Folder page, type the location of your network share \(for example: **\\\\MyBackupSrv\\ipambackup**\) and then click **Next**.  
  
7.  On the **Select Backup Date** page, choose a date to use for the restore point of the IPAM database and then click **Next**.  
  
8.  On the **Select Recovery Type** page, choose **Files and folders** and then click **Next**.  
  
9. Browse to **Windows\\System32\\ipam\\Database**, click the **Database** folder, and then select both of the available files: **ipam.mdf** and **ipam\_log.ldf**. Click **Next** to continue.  
  
    ![](../Image/IPAM_backup2.gif)  
  
10. On the **Specify Recovery Options** page, click **Browse**, browse to the **Windows\\System32\\ipam\\Database** folder, and click **OK**  
  
11. Under **When the wizard find items…** choose **Overwrite the existing versions with the recovered versions**, ensure that the **Restore access control…** checkbox is selected, and then click **Next**.  
  
    ![](../Image/IPAM_backup3.gif)  
  
12. On the **Confirmation** page, click **Recover**.  
  
13. Verify that **Completed** is displayed next to **Status**, and then click **Close**.  
  
14. In the Services console, right\-click **Windows Internal Database**, and then click **Start**.  
  
> [!TIP]  
> If the Windows Internal Database service fails to start, or IPAM is not able to connect to the database after a restore operation, you can review the error log file at **%SystemRoot%\\WID\\Log**.  
  
## See also  
[Capacity planning](../Topic/IPAM-Deployment-Planning.md#capacity)  
  
