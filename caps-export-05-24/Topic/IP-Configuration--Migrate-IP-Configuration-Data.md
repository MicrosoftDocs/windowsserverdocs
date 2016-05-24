---
title: IP Configuration: Migrate IP Configuration Data
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0a213d3c-882a-4226-b5aa-9edad3a8271d
author: coreyp
---
# IP Configuration: Migrate IP Configuration Data
After you have prepared for IP configuration migration by performing steps in [IP Configuration: Prepare to Migrate](assetId:///115a5af5-a0ae-4472-8a1a-e227cfb89ed0), migrate IP configuration settings and data by using procedures in this section.  
  
## Migrating Global and NIC IP configuration  
Perform steps in this section to migrate IP configuration data.  
  
### IP configuration migration tools  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets that are used for data and share migration include **Export\-SmigServerSetting** \(used on the source server\), and **Import\-SmigServerSetting** \(used on the destination server\).  
  
The **Export\-SmigServerSetting** cmdlet lets the user copy all supported IP configuration settings from the source server to migration store at a specified location.  
  
On the destination server, the **Import\-SmigServerSetting** cmdlet applies the IP configuration settings specified in the migration store to the destination computer. To import the IP configuration settings of network adapters, you must provide the mapping between the source and destination network adapters by listing the physical addresses \(also called MAC addresses\) of all network adapters.  
  
> [!NOTE]  
> To import and export IP configuration settings for a network adapter, it must be enabled and connected to a network.  
  
For more information, see Help for [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets. To view Help for a cmdlet, in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, type **Get\-Help** <*cmdlet\_name*>, and then press **Enter**.  
  
> [!NOTE]  
> [!INCLUDE[wsmt](../Token/wsmt_md.md)] must be installed on the computer on which you want to view Help for the migration cmdlets.  
  
### <a name="BKMK_migip"></a>Migrating IP configuration by using Windows Server Migration Tools  
Use the two procedures in this section to migrate global and network adapter\-specific configuration settings by using [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
#### Export IP configuration settings from the source server  
If you have already exported IP configuration settings from your source server as part of another migration guide, go to the procedure [Import IP configuration settings to the destination server](#BKMK_import).  
  
##### <a name="BKMK_exportsettings"></a>To export IP configuration settings from the source server  
  
1.  Do one of the following.  
  
    -   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session on computers that are running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] go to **Start** and then click **Windows Server Migration Tools**.  
  
    -   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session on computers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] click **Start**, point to **Administrative Tools**, open the **Windows Server Migration Tools** folder, right\-click **Windows Server Migration Tools**, and then click **Run as administrator**.  
  
    -   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session on computers that are running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] go to **Start** and then click **Windows Server Migration Tools**.  
  
    -   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session on computers that are running Windows Server 2003, click **Start**, point to **Administrative Tools**, open the **Windows Server Migration Tools** folder, and then click **Windows Server Migration Tools**.  
  
2.  In the same [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, run the **Export\-SmigServerSetting** cmdlet on the source server by typing the following command, in which *MigrationStorePath* represents the path of your migration store location, and then pressing **Enter**.  
  
    ```  
    Export-SmigServerSetting -IPConfig -Path <MigrationStorePath> -Verbose  
    ```  
  
    > [!NOTE]  
    > Because network connectivity might be interrupted during the import operation, be sure to verify that the migration store is created on the destination computer.  
    >   
    > You are prompted to provide a password to encrypt the migration store. Remember this password, because you must provide the same password to import settings from the migration store.  
  
3.  Because it contains information that you must have to perform the import operation, save the output of the **Ipconfig \-all** command. Type the following, and then press **Enter**, in which *FileName* represents the path of the location in which you want to save the output text file, and the file name.  
  
    ```  
    IPConfig -all > <FileName>  
    ```  
  
4.  If the source server has a static IP address, disconnect the source server, or change the static IP address.  
  
#### <a name="BKMK_import"></a>Import IP configuration settings to the destination server  
  
###### To import IP configuration settings to the destination server  
  
1.  For network adapter IP configuration migration, map physical \(MAC\) addresses for both source and destination network adapters. View the IPConfig output you generated by using the **IPConfig \-all > <FilePath>** command in [To export IP configuration settings from the source server](#BKMK_exportsettings) to determine network adapter physical address mapping.  
  
2.  If the migration store is not already on the destination server, copy the migration store to a local drive on the destination server by typing the following and then pressing **Enter**, in which *NetworkPath* is the path of the location of the migration store, and *LocalPath* is the path of a location on the destination server.  
  
    ```  
    Copy <NetworkPath> <LocalPath>  
    ```  
  
3.  Log on to the destination server as a member of the Administrators group, if you have not already done so.  
  
4.  On the destination server, migrate all IP configuration by using the **Import\-SmigServerSetting** cmdlet as shown in the following example, in which each *SourcePhysicalAddress* and *TargetPhysicalAddress* in quotation marks represents the physical address of a network adapter that you want to migrate, and *MigrationStorePath* represents the path of the location of your migration store. Specify each network adapter physical address in the format *AA\-AA\-AA\-AA\-AA\-AA*, and separate the physical addresses of multiple network adapters by using commas.  
  
    ```  
    Import-SmigServerSetting -IPConfig All -SourcePhysicalAddress "<SourcePhysicalAddress1>","<SourcePhysicalAddress2>" -TargetPhysicalAddress "<TargetPhysicalAddress1>","<TargetPhysicalAddress2>" -Path <MigrationStorePath> -Verbose  
    ```  
  
    You can use one of the following values with the **\-IPConfig** parameter. For **All** or **Global** IP configuration migration, the destination server must be restarted for modifications to the IPv6 **DisabledComponents** property to take effect. You cannot use any of the [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets until the server has restarted.  
  
    -   **Global:** only import global Windows IP configuration settings.  
  
    -   **NIC:** only import specific IP configuration settings for certain network adapters. You must specify the physical address mapping by using the **\-SourcePhysicalAddress** and **\-TargetPhysicalAddress** parameters.  
  
    -   **All:** import both global and network adapter IP configuration\-specific settings. You must also specify the physical address mapping by using the **\-SourcePhysicalAddress** and **\-TargetPhysicalAddress** parameters.  
  
    For the list of supported settings for network adapters, see [IP Configuration: Prepare to Migrate](assetId:///115a5af5-a0ae-4472-8a1a-e227cfb89ed0).  
  
5.  You are prompted to provide the same password that was provided during the export process to decrypt the migration store. Type the password, and then press **Enter**.  
  
## See Also  
[Migrate IP Configuration to Windows Server 2012](assetId:///60d15eb2-1b7c-4ad8-a03b-3f6e972b6235)  
[IP Configuration: Prepare to Migrate](assetId:///115a5af5-a0ae-4472-8a1a-e227cfb89ed0)  
[IP Configuration: Post-migration Tasks](../Topic/IP-Configuration--Post-migration-Tasks.md)  
[IP Configuration: Appendix](assetId:///54009c1a-236d-4e82-bb0c-b9f68e90be89)  
  
