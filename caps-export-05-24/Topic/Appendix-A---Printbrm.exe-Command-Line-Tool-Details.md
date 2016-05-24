---
title: Appendix A - Printbrm.exe Command-Line Tool Details
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b1ca3310-78fe-49c1-9844-416b01e94edd
author: vhorne
---
# Appendix A - Printbrm.exe Command-Line Tool Details
  
## <a name="BKMK_AppendixA"></a>Printbrm.exe command\-line tool syntax  
The following table lists the available printbrm parameters:  
  
|Syntax|Description|  
|----------|---------------|  
|\-s <server name>|Specifies the destination server.|  
|\-b|Backs up the server to the specified file.|  
|\-r|Restores the configuration in the file to the server.|  
|\-q|Queries the server or the backup file.|  
|\-f <file name>|Specifies the backup file.|  
|\-d <directory name>|Unpacks the backup file to the directory \(with \-r\), or repacks a backup file from the directory \(with \-b\).|  
|\-o force|Forces overwriting of existing objects.|  
|\-p all:org|Publishes all printers in the directory, or publishes printers that were published originally.|  
|\-nobin|Omits binary files from the backup.|  
|\-lpr2tcp|Converts LPR ports to standard TCP\/IP ports on restore.|  
|\-c <file name>|Uses the specified configuration file.|  
|\-noacl|Removes ACLs from print queues on restore.|  
|\-?|Displays Help.|  
  
## Printbrm enhancements  
Printbrm.exe in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] has several enhancements and improvements, including the following:  
  
-   **Supports both v3 and v4 print drivers**  
  
    [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports both driver types, so with Printbrm you have full flexibility to back up, restore and configure the drivers you need to support your environment.  
  
-   **Supports backup CAB files greater than 2 GB**  
  
    You should use the latest PrintBRM version when performing a migration or restoration. You will avoid CAB file size issues if you use the latest version of Printbrm to migrate and restore your [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] \(or previous\) servers.  
  
-   **General improvements for reporting and error handling conditions during the backup and restore processes**  
  
    These conditions are primarily logged in the Event Log under **Custom Views\\Printer Migration Events**.  
  
## Printbrm usage scenarios  
There are many ways Printprm can be used to make migrating your printers easier and more flexible.  
  
### Using the configuration file  
You can use a configuration file to customize your printbrm migration for the following purposes:  
  
-   Replace printer drivers during a restore operation.  
  
    For example, you might want to import your printers to a new print server, but use new v4 printer drivers.  
  
-   Backup \/ Restore dependent files from third\-party Language Monitors  
  
-   Backup \/ Restore dependent files from third\-party party Print Processors  
  
For example, to replace your printer drivers, you can backup your printers using the `–nobin` parameter, and then restore the printers using the `–c <file name>` parameter to specify a configuration file with a DriverMap section.  
  
##### To use a configuration file to specify updated print drivers  
  
1.  Backup you printers using the `–nobin` parameter. For example:  
  
    `Printbrm.exe –b –nobin –s \\myoldprintserver –f printers.printerExport`  
  
2.  On the new print server computer, manually install the updated printer drivers.  
  
3.  Create a BrmConfig.xml configuration file to map the old drivers to the new drivers. For example:  
  
    ```  
    <BrmConfig>  
    <PLUGINS>  
    </PLUGINS>  
  
    <LanguageMonitors>  
    </LanguageMonitors>  
  
    <DriverMap>  
    <DRV old=”OldDriverName1” new=”NewDriverName1”/>  
    <DRV old=”OldDrverName2” new=”NewDriverName2”/>  
    </DriverMap>  
  
    </BrmConfig>  
    ```  
  
4.  Restore the printers specifying your configuration file using your configuration file. For example: `PrintBrm.exe –r –c BrmConfig.xml –f printers.printerExport –o force`  
  
5.  Check your installed printers to verify they are installed with the updated printer drivers.  
  
> [!IMPORTANT]  
> Remember that if you are running printbrm over the network to remote servers, the **Print$** share must exist on both the source and target servers and the Remote Registry Service must be running.  
  
### Selectively restoring your printers  
After you export the printers from your source server, you can selectively restore the printers and their related objects using the `–d` parameter. You can follow a general procedure to accomplish this:  
  
##### To selectively restore your printers  
  
1.  Export the printer objects from the source server.  
  
2.  Restore to a temporary folder using the `–d` parameter.  
  
3.  Manually edit the files in the temporary folder.  
  
    > [!NOTE]  
    > More information about the files created by a printbrm backup is described later.  
  
4.  Backup the temporary folder using the `–d` parameter.  
  
5.  Import the modified backup file to the target server.  
  
A backup or export operation using PrintBRM produces a compressed file that is used for the restore or import operation. The following XML files are part of the export file in addition to the individual printer driver and configuration files:  
  
-   **BrmDrivers** – contains a list of every driver installed on the computer and the driver files for each driver  
  
-   **BrmForms** – contains a list of all the installed forms  
  
-   **BrmLMons** – will usually contain either Windows NT x86 or Windows x64 as the architecture and a list of port monitors and the port monitor files installed  
  
-   **BrmPorts** – contains a list of all the installed printer ports  
  
-   **BrmPrinters** – contains a list of all printers that have been installed  
  
-   **BrmSpoolerAttrib** – contains information about the spooler directory path and also indicates whether or not the source server was a cluster server  
  
### Moving printers to a different domain  
If you move printers to a different domain, you will want to prevent the restoration of the print queue’s ACLs. Use the `–NoACL` parameter to do this. If you use this parameter, the restored print queues will inherit the permissions of the target print server.  
  
## See Also  
[Migrate Print and Document Services to Windows Server 2012](../Topic/Migrate-Print-and-Document-Services-to-Windows-Server-2012.md)  
[Preparing to Migrate](../Topic/Preparing-to-Migrate.md)  
[Migrating the Print and Document Services Role](../Topic/Migrating-the-Print-and-Document-Services-Role.md)  
[Verifying the Migration](../Topic/Verifying-the-Migration.md)  
[Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md)  
[Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
