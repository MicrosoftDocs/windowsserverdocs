---
title: "Troubleshoot computer backup and restore errors in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 06/25/2013
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5cc73aff-d2c0-4cf9-a23d-ef928ae5ddc9
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot computer backup and restore errors in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Use these procedures to troubleshoot computer backups in Windows Server Essentials, including backup configuration issues, incomplete or unsuccessful backups, backup health alerts, and issues with file, folder, or full-system restores.  
  
> [!NOTE]
>  For the most recent troubleshooting information from the Windows Server Essentials community, visit the [Windows Server Essentials Forum](https://social.technet.microsoft.com/Forums//winserveressentials/threads).  
  
##  <a name="BKMK_TroubleshootBackupConfigurationIssues"></a> Troubleshoot backup configuration issues for a connected computer  
 Use these procedures to troubleshoot issues with the backup configurations for computers that are backed up on your Windows Server Essentials server.  
  
### Errors  
  
-   Backup configuration did not complete successfully  
  
-   Error collecting information for computer  
  
-   Error removing computer from backup  
  
### Resolutions  
  
##### To troubleshoot errors that occur while you configure backups for a connected computer  
  
1.  Make sure your computer is connected to the network through a network device.  
  
2.  Make sure the network device that the computer is connected to is also connected to the network, powered on, and functioning properly.  
  
3.  Make sure that Windows Server Client Backup Service and Windows Server Client Computer Backup Provider Service are running on the server.  
  
    ###### To start computer backup services on the server  
  
    1.  On the server, click **Start**, click **Administrative Tools**, and then click **Services**.  
  
    2.  Scroll down to and click **Windows Server Client Computer Backup Provider Service**. If the status of the service is not **Started**, right-click the service, and then click **Start**.  
  
    3.  Click **Windows Server Client Computer Backup Service**. If the status of the service is not **Started**, right-click the service, and then click **Start**.  
  
    4.  Close **Services**.  
  
4.  Make sure that Windows Server Client Computer Backup Provider Service is running on the client computer.  
  
    ###### To start the computer backup service on the client computer  
  
    1.  On the client computer, click **Start**, type **Services** in the **Search programs and files** text box, and then press Enter.  
  
    2.  Scroll down to and click **Windows Server Client Computer Backup Provider Service**. If the status of the service is not **Started**, right-click the service, and then click **Start**.  
  
    3.  Close **Services**.  
  
5.  Check alerts to determine if there are errors in the backup database. If there are errors, follow the instructions in the alert to repair the backup database.  
  
6.  Uninstall the Windows Server Essentials Connector software from the computer, and then reinstall it. For more information, see the topics [Uninstall the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_13) and [Install the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_11).  
  
##  <a name="BKMK_TroubleshootaBackupThatDidNotCompleteProperly"></a> Troubleshoot a backup that did not complete properly  
 When a backup has Unsuccessful status, no part of the backup succeeded and no data is available for you to restore. However, when a backup has Incomplete status, not all items specified in the backup configuration were backed up, but some data might be available for you to restore.  
  
### Errors  
  
-   Backup is incomplete  
  
-   Backup unsuccessful  
  
### Resolutions  
  
##### To identify volumes that were not backed up successfully  
  
1.  Open the Windows Server Essentials Dashboard, and then click **Computers and Backup**.  
  
2.  Click the name of the computer where backup did not complete successfully, and then click **View the computer properties** in the **Tasks** pane.  
  
3.  Click the backup that did not complete successfully, and then click **View details**.  
  
4.  In the **Backup Details** dialog box, a green check is displayed in the status of every volume that was backed up successfully.  
  
##### To troubleshoot an unsuccessful backup of a volume  
  
1.  Make sure that the hard disk is connected to the computer, turned on, and functioning properly.  
  
2.  Run **chkdsk /f /r** to fix any errors on the hard disk (**/f**) and recover readable information from any bad sectors (**/r**). For more information about running **chkdsk**, see [CHKDSK](https://go.microsoft.com/fwlink/?LinkId=206562).  
  
3.  Make sure that the computer was not shut down or disconnected from the network while backup was running.  
  
4.  Make sure there is enough free space on each volume for backup to run. Backup requires some additional disk space on the client computer to create a VSS snapshot. On any volume that is not system reserved, at least 10 percent of available disk space must be free. On a system reserved volume, if the volume size is less than 500 MB, VSS requires 32 MB of free space to create a snapshot; if the volume is 500 MB or greater, VSS requires 320 MB of free space.  
  
     If insufficient free space is available on a volume, try one of these resolutions:  
  
    -   Extend the volume. You can extend any basic or dynamic volume except the system reserved volume.  
  
        ###### To extend a volume  
  
        1.  In Control Panel, click **System and Security**.  
  
        2.  Under **Administrative Tools**, click **Create and format hard disk partitions**.  
  
        3.  Right-click the volume that you want to extend. If **Extend Volume** is enabled, select that option. If the option is not enabled, you cannot extend the volume.  
  
        4.  Follow the steps in the Extend Volume Wizard to extend the volume.  
  
    -   Delete content from the volume to make more space available.  
  
        > [!NOTE]
        >  If you need to free up space on the system reserved volume, you can move the System Recovery Image to a different volume. For instructions, see [Deploy a System Recovery Image](https://technet.microsoft.com/library/dd744280\(v=ws.10\).aspx).  
  
    -   Exclude the volume from the client backup. Do this only if it is not important to you to maintain a backup copy of the data on the volume.  
  
        > [!WARNING]
        >  If you exclude the system reserved volume from a client backup, the client system will not be backed up, and you will not be able to perform a full system restore on the computer.  
  
5.  Check for other alerts on the server that may indicate there is not enough disk space on the server for backup to complete successfully. Follow the instructions in the alert to fix the issue.  
  
6.  Run **vssadmin** in a command prompt to troubleshoot Volume Shadow Copy Service (VSS) issues. For information about **vssadmin**, see [VSSADMIN](https://go.microsoft.com/fwlink/?LinkID=94332).  
  
##  <a name="BKMK_TroubleshootBackupHealthAlertIssues"></a> Troubleshoot backup health alert issues  
  
### Errors  
  
-   The Windows Server Solutions Computer Backup Provider Service stopped working  
  
-   The Windows Server Solutions Client Computer Backup Provider Service stopped working  
  
### Resolutions  
  
##### To troubleshoot a backup health alert  
  
1.  If an alert tells you that the backup database has issues, follow the instructions in the alert to fix the issue.  
  
2.  If an alert tells you that a backup service is not running, try to start the service on the server or the client computer where you received the error message.  
  
    ###### To start backup services on the server  
  
    1.  On the server, click **Start**, and click **Administrative Tools**, and then click **Services**.  
  
        > [!NOTE]
        >  If you are administering the server remotely, you must use Remote Desktop Connection to access the server desktop. For information about using Remote Desktop Connection, see [Connect to another computer using Remote Desktop Connection](https://windows.microsoft.com/windows-vista/Connect-to-another-computer-using-Remote-Desktop-Connection).  
  
    2.  Scroll down to and click **Windows Server Client Computer Backup Provider Service**. If the status of the service is not **Started**, right-click the service, and then click **Start**.  
  
    3.  Click **Windows Server Client Computer Backup Service**. If the status of the service is not **Started**, right-click the service, and then click **Start**.  
  
    4.  Close **Services**.  
  
    ###### To start backup services on a client computer  
  
    1.  On the client computer, click **Start**, type **Services** in the **Search programs and files** text box, and then click ENTER.  
  
    2.  Right-click **Windows Server Client Computer Backup Provider Service**, and then click **Start**.  
  
    3.  Close the **Services**.  
  
3.  Check event logs on the client computer or server for issues relating to backup services or drivers.  
  
4.  Reboot the server or client computer where you received the error message.  
  
5.  Check health alerts for other issues that may have an effect on client backup.  
  
##  <a name="BKMK_FileAndFolder"></a> Troubleshoot a file or folder restore  
  
### Errors  
  
-   File or folder restore did not complete successfully.  
  
### Resolutions  
  
##### To troubleshoot an unsuccessful file or folder restore  
  
1.  Make sure your computer is connected to the network through a network device.  
  
2.  Make sure the network device that the computer is connected to is also connected to the network, powered on, and functioning properly.  
  
3.  Check alerts to determine if there are errors in the backup database. If there are errors, follow the instructions in the alert to repair the backup database.  
  
4.  Try to restore the files or folders from another backup.  
  
5.  Make sure that the **Windows Server Solution Computer Restore Driver** is installed and working properly.  
  
    ###### To check the status of the Windows Server Solution Computer Restore Driver  
  
    1.  Click **Start**, type **Device Manager** in the **Search programs and files** text box, and then click ENTER.  
  
    2.  In Device Manager, click **System devices**, scroll to **Windows Server Solutions Computer Restore Driver**.  
  
    3.  If the driver is not displayed:  
  
        1.  Open a command prompt with administrator privileges, and run the following command:  
  
             **%ProgramFiles%\Windows Server\Bin\BackupDriverInstaller.exe? -i**  
  
        2.  Refresh Device Manager. The driver should appear.  
  
    4.  If the icon that is displayed is a computer monitor, the driver is installed and running properly. Close Device Manager.  
  
    5.  If the icon displayed is not a computer monitor  
  
        1.  Right-click **Windows Server Solutions Computer Restore Driver**, and then click **Properties**.  
  
        2.  Click the **Driver** tab, and then click **Update Driver**.  
  
        3.  Click **Search automatically for updated driver software**, and then follow the instructions to update the driver.  
  
    6.  Close Device Manager.  
  
6.  Uninstall the Windows Server Essentials Connector software from the computer, and then reinstall it. For more information, see the topics [Uninstall the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_13) and [Install the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_11).  
  
##  <a name="BKMK_Troubleshootfullsystemrestoreissues"></a> Troubleshoot a full system restore  
  
### Errors  
  
-   Cannot log on the client computer after a full system restore.  
  
### Resolutions  
 If you change the name of a computer, and you later need to restore to a backup that was saved before the computer name changed, after the restore, when you attempt to log on under your domain account, you will receive this error: "The security database on the server does not have a computer account for this workstation trust relationship." To gain network access to the computer again, remove the Connector software, remove the computer from the Windows domain, and then connect to the server again.  
  
##### To regain network access to a restored computer after a computer name change  
  
1.  Log on to the computer as a local administrator.  
  
2.  Uninstall the Connector software. For more information, see [Uninstall the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_13).  
  
3.  Remove the computer from the domain. For more information, see [Remove a computer from a Windows domain](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_8).  
  
4.  Connect the computer to the server again. For more information, see [Connect computers to the server](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_9).  
  
## See also  
  
-   [Support Windows Server Essentials](Support-Windows-Server-Essentials.md)