---
title: Migrating the NPS Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9bdccbcb-b995-46d9-a49c-0bce88581467
---
# Migrating the NPS Server
This topic contains steps and procedures for migrating the Network Policy Server \(NPS\) role service from a legacy source server to a new x64\-based destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
![](../Image/PowerShellLogoSmall.gif)[!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## Known issues  
If you previously created conditional attributes for your remote access policy using **Called Station ID** and **Calling Station ID**, the comparison of these attributes in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] uses a regular expression instead of matching the exact string. For a description of these attributes, see [Remote Access Policy Conditions](http://technet.microsoft.com/library/bb742382.aspx) in the **IAS Authorization** section.  
  
## <a name="BKMK_migrate-settings"></a>Exporting settings from the source server  
Use the following procedures to export the NPS settings from your x86\-based or x64\-based source server prior to migrating to an x64\-based server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Follow the steps in the appropriate section based on the version of Windows Server that is running on the source server:  
  
-   [Exporting settings from Windows Server 2003](../Topic/Migrating-the-NPS-Server.md#BKMK_export2003)  
  
-   [Exporting settings from Windows Server 2008](../Topic/Migrating-the-NPS-Server.md#BKMK_export2008)  
  
-   [Exporting settings from Windows Server 2008 R2](../Topic/Migrating-the-NPS-Server.md#BKMK_export2008R2)  
  
-   [Exporting settings from Windows Server 2012 or Windows Server 2012 R2](../Topic/Migrating-the-NPS-Server.md#BKMK_export8)  
  
> [!WARNING]  
> When you use the following procedures to export configuration settings, apply appropriate precautions when moving these files from the source server to destination servers. NPS server configurations are not encrypted in the exported XML file, and contain shared secrets for RADIUS clients and members of remote RADIUS server groups. Therefore, sending these files over a network connection might pose a security risk. You can add the file to an encrypted, password protected archive file before moving the file to provide greater security. In addition, store the file in a secure location to prevent access by unauthorized users.  
  
### <a name="BKMK_export2003"></a>Exporting settings from Windows Server 2003  
Configuration settings for Internet Authentication Service \(IAS\) in Windows Server 2003 are stored in **.MDB** files. Configuration settings for Network Policy Server \(NPS\) in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are stored in **.XML** files. **Iasmigreader.exe** is a command\-line tool that exports the configuration settings of IAS on a computer running Windows Server 2003 to a text file. You can obtain the **iasmigreader.exe** command line migration tool for migrating Windows Server 2003 IAS settings to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] from the following locations:  
  
1.  [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] installation media provides a copy of the migration tool in the **\\sources\\dlmanifests\\microsoft\-windows\-iasserver\-migplugin\\** directory.  
  
2.  The migration tool is available in the **%windir%\\syswow64\\** directory on a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
##### To export settings from a source server running Windows Server 2003  
  
1.  Copy **iasmigreader.exe** to the source server into a directory configured in the **%path%** environment variable.  
  
    > [!TIP]  
    > To review the source server’s **%path%** configuration, type **echo %path%** at a command prompt and press Enter.  
  
2.  At an elevated command prompt, type **iasmigreader.exe**, and then press Enter. The migration tool will automatically export settings to a text file.  
  
    > [!IMPORTANT]  
    > Configuration changes made to IAS will take at least one minute to be available for export.  
  
3.  IAS settings are stored in the file **ias.txt** located in the **%windir%\\system32\\ias** directory on the source server. If you are running a 64\-bit version of Windows Server 2003, the **ias.txt** file is located in the **%windir%\\syswow64\\ias** directory.  
  
4.  You must manually copy SQL log configuration settings on the source server to a file \(example: sql.txt\).  
  
    To record these settings:  
  
    1.  At an elevated command prompt, type **ias.msc**, and then press Enter.  
  
    2.  In the IAS console tree, click **Remote Access Logging**, right\-click **SQL Server**, and then click **Properties**.  
  
    3.  Record the configuration settings on the **Settings** tab, and then click **Configure**.  
  
    4.  Manually record all configuration settings from the Connection and Advanced tabs by copying them into the **sql.txt** file. Alternatively, you can click the **All** tab and enter **Name** and **Value** settings displayed on each line into the **sql.txt** file. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
5.  Copy the ias.txt and sql.txt files to the migration store file location.  
  
> [!WARNING]  
> Store the ias.txt and sql.txt files in a secure location. These files contain shared secret information and SQL connection strings.  
  
> [!IMPORTANT]  
> When you migrate the configuration settings of the IAS role service that is running on a 32\-bit or a 64\-bit Windows Server 2003–based source server to the NPS role service that is running on a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]–based destination server, the import procedure seems to complete successfully. However, the Extensible Authentication Protocol \(EAP\) method is misconfigured. This occurs because the migration tool generates a faulty parameter that is stored in the configuration text file \(ias.txt\). For more information about this issue and for a workaround, see The EAP method is configured incorrectly during the migration process from Windows Server 2003 32\-bit or a 64\-bit to Windows Server 2008 R2 \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=181982](http://go.microsoft.com/fwlink/?LinkID=181982)\).  
  
### <a name="BKMK_export2008"></a>Exporting settings from Windows Server 2008  
Configuration settings for NPS in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] are stored in **.XML** files that can be directly imported to the destination server. The Network Shell \(NetSh\) command line utility can be used to export and import these settings. You can also use the Windows interface to import and export these settings.  
  
> [!WARNING]  
> You cannot use the Windows interface or a command line to export or import detailed SQL configuration settings. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
##### To export settings from a source server running Windows Server 2008 using a command line  
  
1.  On the source NPS server, open an elevated command prompt, type the following command and then press Enter:  
  
    ```  
    netsh nps export filename="path\file.xml" exportPSK=YES  
    ```  
  
    Replace *path* with the directory location where you want to save the source server configuration file, and replace *file* with the name of the .XML file that you want to save.  
  
2.  Confirm that a message appears indicating that the export to file was successful.  
  
3.  On the source server, type the following command and then press Enter:  
  
    ```  
    netsh nps show sqllog > path\sql.txt  
    ```  
  
    Replace *path* with the directory location where you want to save the source server SQL configuration file, and replace *sql* with the name of the .TXT file that you want to save. This file contains the basic configuration for SQL logging that is found on the **Settings** tab in SQL logging properties. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
4.  Copy the **file.xml** and **sql.txt** files to the migration store file location. This information will be required for configuration of the destination server.  
  
##### To export settings from a source server running Windows Server 2008 using the Windows interface  
  
1.  On the source server, open Server Manager.  
  
2.  In the Server Manager console tree, open **Roles\\Network Policy and Access Services\\NPS**.  
  
3.  Right click **NPS**, and then click **Export Configuration**.  
  
4.  In the dialog box that appears, select the check box next to **I am aware that I am exporting all shared secrets**, and then click **OK**.  
  
5.  Next to **File name**, type **file.xml**, navigate to the migration store file location, and then click **Save**.  
  
6.  If you have configured SQL logging, you must manually record detailed SQL configuration settings.  
  
    To record these settings:  
  
    1.  In the NPS console tree, click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    2.  Record the configuration settings on the **Settings** tab, and then click **Configure**.  
  
    3.  Manually record all configuration settings from the Connection and Advanced tabs by copying them into the **sql.txt** file. Alternatively, you can click the **All** tab and enter **Name** and **Value** settings displayed on each line into the **sql.txt** file. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
7.  Copy the ias.txt and sql.txt files to the migration store file location.  
  
### <a name="BKMK_export2008R2"></a>Exporting settings from Windows Server 2008 R2  
Configuration settings for NPS in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are stored in **.XML** files that can be directly imported to the destination server. The Network Shell \(NetSh\) command line utility can be used to export and import these settings. You can also use the Windows interface to import and export settings.  
  
> [!WARNING]  
> You cannot use the Windows interface or a command line to export or import detailed SQL configuration settings. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
> [!IMPORTANT]  
> The netsh utility does not support migration of template configuration settings. To migrate these settings, you must use the Windows interface.  
  
##### To export settings from a source server running Windows Server 2008 R2 using a command line  
  
1.  On the source NPS server, open an elevated command prompt, type the following command and then press Enter:  
  
    ```  
    netsh nps export filename="path\file.xml" exportPSK=YES  
    ```  
  
    Replace *path* with the directory location where you want to save the source server configuration file, and replace *file* with the name of the .XML file that you want to save.  
  
2.  Confirm that a message appears indicating that the export to file was successful.  
  
3.  On the source server, type the following command and then press Enter:  
  
    ```  
    netsh nps show sqllog > path\sql.txt  
    ```  
  
    Replace *path* with the directory location where you want to save the source server SQL configuration file, and replace *sql* with the name of the .TXT file that you want to save. This file contains the basic configuration for SQL logging that is found on the **Settings** tab in SQL logging properties. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
4.  Copy the **file.xml** and **sql.txt** files to the migration store file location. This information will be required for configuration of the destination server.  
  
#### <a name="BKMK_export_UI"></a>To export settings from a source server running Windows Server 2008 R2 using the Windows interface  
  
1.  On the source server, open Server Manager.  
  
2.  In the Server Manager console tree, open **Roles\\Network Policy and Access Services\\NPS**.  
  
3.  Right click **NPS**, and then click **Export Configuration**.  
  
4.  In the dialog box that appears, select the check box next to **I am aware that I am exporting all shared secrets**, and then click **OK**.  
  
5.  Next to **File name**, type **file.xml**, navigate to the migration store file location, and then click **Save**.  
  
6.  In the console tree, right\-click **Templates Management** and then click **Export Templates to a file**.  
  
7.  Next to **File name**, type **iastemplates.xml**, navigate to the migration store file location, and then click **Save**.  
  
8.  If you have configured SQL logging, you must manually record detailed SQL configuration settings.  
  
    To record these settings:  
  
    1.  In the NPS console tree, click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    2.  Record the configuration settings on the **Settings** tab, and then click **Configure**.  
  
    3.  Manually record all configuration settings from the Connection and Advanced tabs by copying them into the **sql.txt** file. Alternatively, you can click the **All** tab and enter **Name** and **Value** settings displayed on each line into the **sql.txt** file. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
9. Copy the **file.xml**, **iastemplates.xml**, and **sql.txt** files to the migration store file location. This information will be required for configuration of the destination server.  
  
## <a name="BKMK_export8"></a>Exporting settings from Windows Server 2012 or Windows Server 2012 R2  
Configuration settings for NPS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] are stored in **.XML** files that can be directly imported to the destination server. You can use the following methods to export and import these settings:  
  
1.  The Network Shell \(NetSh\) command line utility  
  
2.  The Windows interface  
  
3.  [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets  
  
> [!WARNING]  
> You cannot use [!INCLUDE[wps_2](../Token/wps_2_md.md)], the Windows interface or a command line to export or import detailed SQL configuration settings. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
> [!IMPORTANT]  
> The netsh utility and [!INCLUDE[wps_2](../Token/wps_2_md.md)] do not support migration of template configuration settings. To migrate these settings, you must use the Windows interface.  
  
### <a name="BKMK_export_UI_8a"></a>To export settings from a source server using Windows PowerShell  
  
1.  On the source server, create a new folder for your settings \(for example: C:\\ConfigSettings\).  
  
2.  Export your configuration settings to an .xml file in that folder, by following these steps.  
  
    1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**PowerShell**, and then click Enter.  
  
    2.  To switch to the NPS context enter the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] command and then press Enter:  
  
        **Import\-Module NPS**  
  
    3.  To export the configuration file to an .xml file, enter the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] command, using the \-path parameter to identify the name of the .xml file to be created and the folder into which it should be placed:  
  
        **Export\-NpsConfiguration \[\-Path\] <String>**  
  
        > [!TIP]  
        > For example:  
        >   
        > Export\-NpsConfiguration –Path C:\\ConfigSettings \-Path nps01.xml  
  
        > [!CAUTION]  
        > The exported file contains unencrypted shared secrets for RADIUS clients and members of remote RADIUS server groups. Because of this, you should ensure that the file is stored in a secure location to prevent malicious users from accessing the file.  
  
3.  Confirm that no errors were reported by [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
4.  If you have configured SQL logging, you must manually record detailed SQL configuration settings.  
  
    To record these settings:  
  
    1.  In the NPS console tree, click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    2.  Record the configuration settings on the **Settings** tab, and then click **Configure**.  
  
    3.  Manually record all configuration settings from the Connection and Advanced tabs by copying them into the **sql.txt** file. Alternatively, you can click the **All** tab and enter **Name** and **Value** settings displayed on each line into the **sql.txt** file. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
5.  Copy the **file.xml**, **iastemplates.xml**, and **sql.txt** files to the migration store file location. This information will be required for configuration of the destination server.  
  
#### To export settings from a source server using the Netsh utility  
  
1.  On the source NPS server, open an elevated command prompt, type the following command and then press Enter:  
  
    ```  
    netsh nps export filename="path\file.xml" exportPSK=YES  
    ```  
  
    Replace *path* with the directory location where you want to save the source server configuration file, and replace *file* with the name of the .XML file that you want to save.  
  
2.  Confirm that a message appears indicating that the export to file was successful.  
  
3.  On the source server, type the following command and then press Enter:  
  
    ```  
    netsh nps show sqllog > path\sql.txt  
    ```  
  
    Replace *path* with the directory location where you want to save the source server SQL configuration file, and replace *sql* with the name of the .TXT file that you want to save. This file contains the basic configuration for SQL logging that is found on the **Settings** tab in SQL logging properties. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
4.  Copy the **file.xml** and **sql.txt** files to the migration store file location. This information will be required for configuration of the destination server.  
  
### <a name="BKMK_export_UI_8"></a>To export settings from a source server using the Windows interface  
  
1.  On the source server, open Server Manager.  
  
2.  In the Server Manager console tree, click **ALL SERVERS**, then from the list of servers in the right pane, right\-click the relevant server and select **Network Policy Server**.  
  
3.  Right click the root node **NPS**, and then click **Export Configuration**.  
  
4.  In the dialog box that appears, select the check box next to **I am aware that I am exporting all shared secrets**, and then click **OK**.  
  
5.  Next to **File name**, type **file.xml**, navigate to the migration store file location, and then click **Save**.  
  
6.  In the console tree, right\-click **Templates Management** and then click **Export Templates to a file**.  
  
7.  Next to **File name**, type **iastemplates.xml**, navigate to the migration store file location, and then click **Save**.  
  
8.  If you have configured SQL logging, you must manually record detailed SQL configuration settings.  
  
    To record these settings:  
  
    1.  In the NPS console tree, click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    2.  Record the configuration settings on the **Settings** tab, and then click **Configure**.  
  
    3.  Manually record all configuration settings from the Connection and Advanced tabs by copying them into the **sql.txt** file. Alternatively, you can click the **All** tab and enter **Name** and **Value** settings displayed on each line into the **sql.txt** file. For a list of text logging and SQL configuration settings that you need to record manually, see [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac).  
  
9. Copy the **file.xml**, **iastemplates.xml**, and **sql.txt** files to the migration store file location. This information will be required for configuration of the destination server.  
  
## <a name="BKMK_import-settings"></a>Importing settings to the destination server  
Use the following procedures to import the NPS settings from your x86\-based or x64\-based source server to an x64\-based destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   [Importing settings from Windows Server 2003](../Topic/Migrating-the-NPS-Server.md#BKMK_import2003)  
  
-   [Importing settings from Windows Server 2008 or Windows Server 2008 R2](../Topic/Migrating-the-NPS-Server.md#BKMK_import2008R2)  
  
-   [Importing settings from Windows Server 2012 or Windows Server 2012 R2](../Topic/Migrating-the-NPS-Server.md#BKMK_import8b)  
  
### <a name="BKMK_import2003"></a>Importing settings from Windows Server 2003  
The configuration file **ias.txt** that was exported from the source server is in a format that can be imported to a destination server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If SQL accounting settings were saved, these settings are recorded manually in the **sql.txt** file.  
  
> [!IMPORTANT]  
> When you migrate the configuration settings of the IAS role service that is running on a 32\-bit or a 64\-bit Windows Server 2003–based source server to the NPS role service that is running on a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]–based destination server, the import procedure seems to complete successfully. However, the Extensible Authentication Protocol \(EAP\) method is misconfigured. This occurs because the migration tool generates a faulty parameter that is stored in the configuration text file \(ias.txt\). For more information about this issue and for a workaround, see The EAP method is configured incorrectly during the migration process from Windows Server 2003 32\-bit or a 64\-bit to Windows Server 2008 R2 \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=181982](http://go.microsoft.com/fwlink/?LinkID=181982)\).  
  
##### To import settings from a source server running Windows Server 2003  
  
1.  Copy the configuration file **ias.txt** that was exported to the migration store file location to the destination NPS server. Alternatively you can import configuration settings directly from the migration store file location by supplying the appropriate path to the file in the import command.  
  
2.  On the destination server, use either netsh or [!INCLUDE[wps_2](../Token/wps_2_md.md)] to import the configuration.  
  
    -   To use netsh, do the following:  
  
        1.  Open an elevated command prompt, type the following command and then press Enter:  
  
            ```  
            netsh nps import filename="path\ias.txt"  
            ```  
  
            Replace *path* with the directory where the **ias.txt** file is located. Verify that a message appears indicating that the import process was successful.  
  
            > [!TIP]  
            > If the configuration file is located on a network share, provide full path to the file. For example: **netsh nps import filename \= “\\\\fileserver1\\Data\\ias.txt”**.  
  
    -   To use [!INCLUDE[wps_2](../Token/wps_2_md.md)], do the following:  
  
        1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**PowerShell**, and then click Enter.  
  
        2.  Switch to the NPS context, enter the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] command:  
  
            **Import\-Module NPS**  
  
        3.  To import the configuration, enter the following:  
  
            **Import\-NpsConfiguration \[\-Path\] <String>**  
  
            Replace *String* with the directory where the **ias.txt** file is located. Verify that a message appears indicating that the import process was successful.  
  
            > [!TIP]  
            > For example:  
            >   
            > Import\-NpsConfiguration –Path c:\\temp\\ias.txt  
  
3.  If required, configure SQL accounting. To configure SQL accounting:  
  
    1.  In the Server Manager console tree, click **ALL SERVERS**, then from the list of servers in the right pane, right\-click the relevant server and select **Network Policy Server**.  
  
    2.  Click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    3.  Manually enter SQL settings from the **sql.txt** file that you created.  
  
### <a name="BKMK_import2008R2"></a>Importing settings from Windows Server 2008 or Windows Server 2008 R2  
The configuration file **file.xml** that was exported from the source server is in a format that can be imported to a destination server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. SQL accounting settings are saved in the **sql.txt** file.  
  
> [!NOTE]  
> For source servers running Windows Server 2008 R2: If you saved a templates configuration file, **iastemplates.xml**, you must use the Windows interface to import these settings.  
  
##### To import settings from a source server running Windows Server 2008 or Windows Server 2008 R2  
  
1.  Copy the configuration files **file.xml** and **sql.txt** that were exported to the migration store file location to the destination NPS server. Alternatively you can import configuration settings directly from the migration store file location by supplying the appropriate path to the file in the import command.  
  
2.  On the destination server, use either netsh or [!INCLUDE[wps_2](../Token/wps_2_md.md)] to import the configuration.  
  
    -   To use netsh, do the following:  
  
        1.  Open an elevated command prompt, type the following command and then press Enter:  
  
            ```  
            netsh nps import filename="path\file.xml"  
            ```  
  
            Replace *path* with the directory where the **file.xml** file is located. Verify that a message appears indicating that the import process was successful.  
  
            > [!TIP]  
            > If the configuration file is located on a network share, provide full path to the file. For example: **netsh nps import filename \= “\\\\fileserver1\\Data\\file.xml”**.  
  
    -   To use [!INCLUDE[wps_2](../Token/wps_2_md.md)], do the following:  
  
        1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**PowerShell**, and then click Enter.  
  
        2.  Switch to the NPS context, enter the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] command:  
  
            **Import\-Module NPS**  
  
        3.  To import the configuration, enter the following:  
  
            **Import\-NpsConfiguration \[\-Path\] <String>**  
  
            Replace *<String>* with the directory where the **file.xml** file is located.  
  
            > [!TIP]  
            > For example:  
            >   
            > **Import\-NpsConfiguration –Path c:\\temp\\file.xml**  
  
        4.  Confirm that no errors were reported by [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
3.  If required, configure SQL accounting. To configure SQL accounting:  
  
    1.  In the Server Manager console tree, click **ALL SERVERS**, then from the list of servers in the right pane, right\-click the relevant server and select **Network Policy Server**.  
  
    2.  Click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    3.  Manually enter SQL settings from the **sql.txt** file.  
  
### <a name="BKMK_import8b"></a>Importing settings from Windows Server 2012 or Windows Server 2012 R2  
The configuration file **file.xml** that was exported from the source server is in a format that can be imported to a destination server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. SQL accounting settings are saved in the **sql.txt** file. If you saved a templates configuration file, **iastemplates.xml**, you must use the Windows interface to import these settings.  
  
##### To import settings from a source server  
  
1.  Copy the configuration files **file.xml** and **sql.txt** that were exported to the migration store file location to the destination NPS server. Alternatively you can import configuration settings directly from the migration store file location by supplying the appropriate path to the file in the import command.  
  
2.  On the destination server, open an elevated command prompt, type the following command and then press Enter:  
  
    ```  
    netsh nps import filename="path\file.xml"  
    ```  
  
    Replace *path* with the directory where the **file.xml** file is located. Verify that a message appears indicating that the import process was successful.  
  
    > [!TIP]  
    > If the configuration file is located on a network share, provide full path to the file. For example: **netsh nps import filename \= “\\\\fileserver1\\Data\\file.xml”**.  
  
    ![](../Image/PowerShellLogoSmall.gif)The following [!INCLUDE[wps_2](../Token/wps_2_md.md)] command performs the same function:  
  
    ```  
    Import-NpsConfiguration –Path c:\temp\file.xml  
    ```  
  
3.  If required, configure SQL accounting. To configure SQL accounting:  
  
    1.  In the Server Manager console tree, click **ALL SERVERS**, then from the list of servers in the right pane, right\-click the relevant server and select **Network Policy Server**.  
  
    2.  Click **Accounting** and then click **Change SQL Server Logging Properties**.  
  
    3.  Manually enter SQL settings from the **sql.txt** file.  
  
## <a name="BKMK_UI"></a>Using the NPS console to migrate NPS settings  
You can also use the Windows interface on the destination server to import configuration settings.  
  
#### To import settings from a source server using the Windows interface  
  
1.  Copy the configuration files **file.xml**, **iastemplates.xml**, and **sql.txt** that were exported to the migration store file location to the destination NPS server. Alternatively you can import configuration settings directly from the migration store file location by supplying the appropriate path to the file in the import command. If you have custom settings that were recorded using the [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac), these must be configured manually on the destination server.  
  
2.  On the destination server, open Server Manager.  
  
3.  In the Server Manager console tree, click **ALL SERVERS**, and then from the list of servers in the right pane, right\-click the relevant server and select **Network Policy Server**.  
  
4.  To import template configuration settings, follow steps 5 to 13. If you do not have template settings, skip to step 7.  
  
5.  In the console tree, right\-click **Templates Management** and then click **Import Templates from a file**.  
  
6.  Select the template configuration file **iastemplates.xml** that you copied from the source server and then click **Open**.  
  
7.  In the console tree, right\-click **NPS** and then click **Import Configuration**.  
  
8.  Select the configuration file **file.xml** or **ias.txt** that you copied from the source server and then click **Open**.  
  
9. Verify that a message appears indicating the import was successful.  
  
10. Configure SQL accounting if required using the **sql.txt** file and the data collection worksheet. To configure SQL accounting, follow steps 11 to 13.  
  
11. In the NPS console tree, click **Accounting** and then click **Change SQL Server Logging Properties** in the details pane.  
  
12. Modify the properties on the **Settings** tab if required, and then click **Configure** to enter detailed settings.  
  
13. Using information recorded in the **sql.txt** file, enter the required settings on the **Connection** and **Advanced** tabs, and then click **OK**.  
  
