---
title: Migrating the Print and Document Services Role
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5955e079-a722-4562-8063-0d00a5222064
author: vhorne
---
# Migrating the Print and Document Services Role
  
## <a name="BKMK_Step4BackUpSourceServer"></a>Back up the source server  
The fourth step in the migration process is to back up your source server data to a printer settings file using either the Printer Migration Wizard or the **Printbrm.exe** command\-line tool in preparation for exporting printer queues, print drivers, and printer settings.  
  
> [!IMPORTANT]  
> As a best practice, run the Printer Migration Wizard or Printbrm.exe from a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] to ensure that you are using the newest version of the migration tools that have the latest updates and features. You can run these tools either locally on the server or remotely from any other computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
>   
> Remember that if you are running printbrm over the network to remote servers, the **Print$** share must exist on both the source and target servers and the Remote Registry Service must be running.  
  
##### To back up the source server using the Printer Migration Wizard  
  
1.  Open the Print Management snap\-in.  
  
2.  Do one of the following:  
  
    -   In the **Print Management** window, right\-click **Print Management**, and then click **Migrate Printers** to open the Printer Migration Wizard. Make sure that **Export printer queues and printer drivers to a file** is selected, and then click **Next**. In the **Select a print server** window, select the print server to be migrated, and then click **Next**.  
  
    -   In the **Print Management** tree, under **Print Servers**, right\-click the print server that contains the printer queues to migrate, and then click **Export printers to a file** to open the Printer Migration Wizard.  
  
3.  Review the list of items to be exported, and then click **Next**.  
  
4.  In the **Export printer data to** box, enter the path to the printer settings file to use, or browse to the location where you want to store the file. Click **Next** to export the printer\-specific information for the server to this file.  
  
5.  Verify that the printer settings file is stored on a resource that will be available to the destination server. Optimally, store it on a network share. Click **Finish**.  
  
The backup file that you create by using either the Printer Migration Wizard or the Printbrm.exe tool inherits the permissions allowed by your user credentials. Only you can access the file if you saved the file directly to a share during the backup file creation process. You must either change the file permissions on the **Security** tab of the file’s **Properties** dialog box, or you must perform any restorations or migrations by using that file yourself. If you create the backup file on the computer from which you are running the migration and later copy the file to a share, then file access permissions are inherited from the destination folder.  
  
##### To back up the source server using the Printbrm.exe command\-line tool  
  
1.  Open an administrator  Command Prompt window.  
  
2.  Perform a remote print backup. To do this, type the following command in the **%WINDIR%\\System32\\Spool\\Tools** folder at the command prompt, in which *Source Computer1* is the Universal Naming Convention \(UNC\) name of the source computer, and *Printer1 Settings* is the name of the printer settings file to back up.  
  
    ```  
    Printbrm -s \\<Source Computer1> -b -f <Printer1 Settings>.printerExport  
    ```  
  
    > [!NOTE]  
    > The Printer Migration Wizard and the Printbrm.exe command\-line tool only support a printer settings file that is created by the migration tool you are using. For example, .cab file backups that were created by using the Printer Migration Wizard are not supported. To view the complete syntax for the **Printbrm.exe** command, type **Printbrm.exe \/?** in a Command Prompt session.  
    >   
    > Only TCP\/IP, WSD, and LPR ports will be migrated. The Printer Migration Wizard will not migrate printers attached through USB, LPT, or other local ports. For more information about these scenarios and migrating Plug and Play printers, see [Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md).  
  
#### Cross\-architecture migrations  
For cross\-architecture migrations, verify that each print queue has a driver installed on the source server that is compatible with the operating system on the destination server before creating the printer settings file on the source server. For example, if you are migrating an x86\-based source print server to an x64\-based destination print server, verify that each print queue has an x64\-based driver installed before you create the printer settings file. Any print queue that does not have a cross\-architecture driver installed will not be migrated to the destination server.  
  
## <a name="BKMK_Step5Restoration"></a>Restoration  
The fifth step in the migration process is to restore the printers to the destination server, using the printer settings file you created.  
  
Before beginning the migration process, verify that you installed the Print and Document Services role on the destination server as part of your preparation.  
  
##### To restore printers to the destination server using the Printer Migration Wizard  
  
1.  On the source server, stop the Print Spooler service for all printers so you can preserve all print jobs prior to the migration.  
  
    1.  Open Computer Management. Click **Start**, click **Control Panel**, double\-click **Administrative Tools**, and then click **Computer Management**.  
  
    2.  In the console tree, expand **Services and Applications**.  
  
    3.  In the console tree, under **Services and Applications**, click **Services**.  
  
    4.  In the details pane, do one of the following to stop the service:  
  
        1.  Right\-click **Print Spooler** and select **Stop**.  
  
        2.  Double\-click **Print Spooler**. On the **General** tab, under **Service Status**, click **Stop**.  
  
2.  From the computer that is running the Printer Migration Wizard, on the **Administrative Tools** menu, click **Print Management**.  
  
3.  Do one of the following:  
  
    -   Right\-click **Print Management**, and then click **Migrate Printers** to open the Printer Migration Wizard. Select **Import printer queues and printer drivers from a file,** and then click **Next**.  
  
    -   In the **Print Management** tree, under **Print Servers**, right\-click the destination print server, and then click **Import printers from a file** to open the Printer Migration Wizard.  
  
4.  Specify the printer settings file created in the [Back up the source server](assetId:///fb314030-e792-49de-aa82-d5de5343ca1a#BKMK_Step4BackUpSourceServer) section, and then click **Next**.  
  
5.  Review the list of items to be imported, and then click **Next**.  
  
6.  In the **Import Mode** list, indicate whether you want to keep or overwrite existing printers.  
  
    If the printer settings file contains a printer already on the destination server, the printer is not restored, and the existing printer on the destination server is not changed.  
  
7.  In the **List in the directory** list, indicate which printers to list on the destination server.  
  
8.  Optionally, indicate whether you want to convert LPR ports to standard port monitors when you migrate.  
  
9. Click **Next** to import the printers.  
  
10. Click **Finish**.  
  
    > [!NOTE]  
    > It is recommended that you review the Application events that have a PrintBRM source to determine whether any additional actions are needed. The restored printers are shared in the same manner in which they were shared previously.  
  
11. To view details of the migration, click **Open Event Viewer**. For more information, see “Verify the Migration” in [Verifying the Migration](../Topic/Verifying-the-Migration.md). If you identify Error 30 in the Event Viewer, see “Troubleshooting” and “Migrating cross\-platform driver language monitors” in [Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md) for instructions on resolving the error.  
  
##### To restore printers to the destination server using the Printbrm.exe command\-line tool  
  
1.  Open an administrator Command Prompt window.  
  
2.  Type the following command in the **%WINDIR%\\System32\\Spool\\Tools** folder at the command prompt, in which *Source Computer1* is the UNC name of the source computer, and *Printer1 Settings* is the name of the printer settings file to restore.  
  
    ```  
    Printbrm -s \\<Source Computer1> -r -f <Printer1 Settings>.printerExport  
    ```  
  
## See Also  
[Migrate Print and Document Services to Windows Server 2012](../Topic/Migrate-Print-and-Document-Services-to-Windows-Server-2012.md)  
[Preparing to Migrate](../Topic/Preparing-to-Migrate.md)  
[Verifying the Migration](../Topic/Verifying-the-Migration.md)  
[Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md)  
[Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md)  
[Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
