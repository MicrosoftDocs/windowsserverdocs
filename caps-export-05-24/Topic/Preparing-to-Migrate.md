---
title: Preparing to Migrate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6baa2fe1-b680-4173-9f3c-f449c6da4f1b
author: vhorne
---
# Preparing to Migrate
  
## <a name="BKMK_Step1AccessingMigrationTools"></a>Access the migration tools  
The Printer Migration Wizard and the Printbrm.exe command\-line tool support all migrations to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> Although the Printer Migration Wizard supports migrations from servers running Windows Server 2003 or a Server Core installation, it cannot run on these servers directly.  
  
### <a name="BKMK_ToAccessPrinterMigrationWizard"></a>To access the Printer Migration Wizard  
  
##### Open the Print Management snap\-in on computers running operating systems previous to [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]  
  
1.  If necessary, enable the **Administrative Tools** menu, which is hidden by default on Windows\-based client operating systems.  
  
    1.  Right\-click **Start**, and then click **Properties**. The **Start Menu and Taskbar Properties** dialog box opens.  
  
    2.  On the **Start Menu** tab, click **Customize**. The **Customize Start Menu** dialog box opens.  
  
    3.  Under **System Administrative Tools**, select **Display on the All Programs menu** or **Display on the All Programs menu and the Start menu**.  
  
2.  In the **Administrative Tools** menu, click **Print Management**.  
  
> [!TIP]  
> Alternatively, you can click **Start**, and type **printmanagement.msc** in the search text box.  
  
##### Open the Print Management snap\-in on computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   Open Server Manager, click **Tools**, and then click **Print Management**.  
  
##### Open the Print Management snap\-in on computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]  
  
-   From the Start screen, type **printmanagement.msc** and click **printmanagement** when it appears in the search results.  
  
> [!TIP]  
> If you run the Print Management Console remotely \(for example, from a client computer\), simply add the print server to your console \(right\-click **Print Servers**, click **Add\/Remove Servers**\) and continue the migration from there.  
  
##### Start the Printer Migration wizard  
  
-   In Print Management, right\-click **Print Management** and click **Migrate Printers**.  
  
> [!IMPORTANT]  
> The Print Management snap\-in filter settings will not be migrated and need to be saved independently of the printer migration.  
  
### To access the Printbrm.exe command\-line tool  
  
1.  To open a Command Prompt window, click **Start**, click **All Programs**, click **Accessories**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
    To open a command Prompt window on a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], right\-click the start charm and click Command Prompt \(Admin\)  
  
2.  Type:  
  
    ```  
    %WINDIR%\System32\Spool\Tools\Printbrm.exe  
    ```  
  
To view the complete syntax for this command, at a command prompt, type:  
  
```  
Printbrm.exe /?  
```  
  
For a listing of the available syntax for the **Printbrm.exe** command, see [Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md).  
  
## <a name="BKMK_Step2PrepareDestinationServer"></a>Prepare the destination server  
The second step in the migration process is to prepare the destination server.  
  
### Hardware requirements for the destination server  
There are no specific hardware requirements for being a print server beyond those for the version of the server operating system you are using.  
  
The amount of disk space needed for a migration is dependent on the number of print drivers to be migrated and the size of the drivers. Because print drivers can vary widely in size, the amount of disk space can range from one megabyte to several gigabytes.  
  
### Software requirements for the destination server  
Verify that hard drive space is sufficient on the destination server for the backup.  
  
No additional software is needed other than the necessary drivers required for the printers to be hosted. Migrate these drivers from the source server.  
  
For cross\-architecture migrations, verify that the destination server contains drivers for each supported architecture.  
  
### Installing the Print and Document Services role on the destination server  
You must install the Print and Document Services role on the destination server before you begin the migration process. For more information on installing this and other server roles, see the [Print and Document Services overview](http://technet.microsoft.com/library/hh831468.aspx).  
  
### Preparing for cross\-architecture migrations  
If you are migrating from the x86\-based architecture of Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] to the x64\-based architecture of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you should install x64\-based drivers on the source server before creating the backup file. The migration process copies all installed drivers from the source server to the destination server. It recreates the printer queues on the destination server if the printer settings file contains the x64\-based drivers.  
  
Verify that each print queue on the source server has a driver installed for the operating system on the destination server before creating the printer settings file. For example, if you are migrating an x86\-based source print server to an x64\-based destination print server, verify that each print queue has an x64\-based driver installed before you create the printer settings file. Any print queue that does not have a cross\-architecture driver installed will not be migrated to the destination server.  
  
To install cross\-architecture drivers for a printer, you can use:  
  
-   The **Add Printer Driver Wizard**, which is available in the Print Management snap\-in.  
  
-   The **Printer Properties** dialog box, which is available through the Printers folder in the Control Panel.  
  
As a best practice, you need to install a driver with the same name as the native architecture. To add the x86\-based driver to the x64\-based destination server, use the x86\-based client to remotely open the x64\-based server using Windows Explorer and navigate to the remote printer folder and add the driver. To install an x64\-based driver on the x86\-based source server, use the x64\-based client to remotely open the x86\-based server using Windows Explorer and navigate to the remote printer folder and add the driver.  
  
> [!TIP]  
> In many cases, it can take you a long time to update all the print drivers for all your print queues. To save time, you may want to update just the most used print queues first, and gradually update the others when you have time. To save time, you can set the existing print queues to the **Generic\/Text Only** driver for migration and later switch them to the OEM driver at your convenience. Most printers allow basic printing using the Generic Text driver. For more information, see [Cross\-Architecture print server migrations: Speeding up the migration process](http://blogs.technet.com/b/askperf/archive/2011/03/11/cross-architecture-print-server-migrations-speeding-up-the-migration-process.aspx) at the Microsoft TechNet Blogs web site.  
  
### Preparing for additional scenarios  
In the following instances, installing a feature on your destination server may require additional preparation before you migrate to it:  
  
-   The server hosts Line Printer Remote \(LPR\) printers.  
  
-   The server offers Internet Printing Protocol \(IPP\) printer connections.  
  
-   The server hosts Web Services on Devices \(WSD\) printers.  
  
-   The server is in a server cluster.  
  
-   The server hosts plug and play printers.  
  
For more information on these scenarios, see [Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md).  
  
## <a name="BKMK_Step3PrepareSourceServer"></a>Prepare the source server  
Simple system\-to\-system migrations require no preparation for the source server. However, additional preparation is required for cross\-architecture migrations. If performing the migration as quickly as possible is a priority, remove unused drivers, ports, and queues before starting the migration to improve its speed after verifying with users that the items to remove are no longer in use. In general, however, minimize changes to the source server environment to ensure you can roll back to this environment if necessary.  
  
> [!CAUTION]  
> If your source server is running multiple roles, renaming the source server or changing its IP address can cause other roles that are running on the source server to fail.  
  
> [!NOTE]  
> You should delete native print drivers that are not currently associated with a print queue because these drivers increase the size of the printer settings file unnecessarily. The print spooler will not allow a native print driver that is currently associated with a print queue to be deleted.  
>   
> The Print Spooler service will use non\-native drivers. It routes these drivers to the Print Server service when a non\-native client connects to a print queue and has to download a driver. You should remove any unused drivers and print queues.  
>   
> Do not delete a non\-native driver with a corresponding native print driver that is associated with a print queue. In this instance, the Print Spooler service will not prevent the non\-native driver from being deleted. If the non\-native driver's architecture matches the destination server's architecture, then you must block the driver's deletion. Cross\-architecture drivers will never appear to be loaded by the Print Spooler service. Administrators should only delete them after confirming the drivers are no longer needed.  
  
#### To install cross\-architecture drivers using the Print Management snap\-in on computers running Windows Vista and Windows Server 2008  
  
1.  Open the Print Management snap\-in. Click **Start**, click **Administrative Tools**, and then click **Print Management**.  
  
2.  In the Print Management tree, under **Print Servers**, click the print server you want.  
  
3.  Under the print server, right\-click **Drivers** and then select **Add Driver** to open the **Add Printer Driver Wizard**.  
  
4.  Follow the steps as indicated by the wizard.  
  
#### To install cross\-architecture drivers by using only the Printer Properties dialog box on computers running Windows XP and Windows Server 2003  
  
1.  Click **Start**, click **Control Panel**, and double\-click **Printers**.  
  
2.  Select **Printer**. Right\-click **Sharing**.  
  
3.  Click **Additional Drivers** and select **Processor** from the list.  
  
4.  Follow the instructions in the dialog boxes to install the correct driver. Only install the driver associated with the printer you are administering.  
  
> [!NOTE]  
> You can only add a cross\-architecture driver if you have already installed a native architecture version of the same driver.  
  
## See Also  
[Migrate Print and Document Services to Windows Server 2012](../Topic/Migrate-Print-and-Document-Services-to-Windows-Server-2012.md)  
[Migrating the Print and Document Services Role](../Topic/Migrating-the-Print-and-Document-Services-Role.md)  
[Verifying the Migration](../Topic/Verifying-the-Migration.md)  
[Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md)  
[Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md)  
[Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
