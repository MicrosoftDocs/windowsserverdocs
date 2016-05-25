---
title: Migrate iSCSI Software Target
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9dbfd55e-c2dc-42e9-9438-e7f291610708
author: JasonGerend
---
# Migrate iSCSI Software Target
This topic discusses the actual migration steps for iSCSI Software Target 3.2 or iSCSI Software Target 3.3 for both the stand\-alone configuration and the clustered configuration:  
  
## Migrating iSCSI Software Target in a standalone configuration  
The migration of iSCSI Target Server 3.3 or iSCSI Target Server 6.2 has equivalent steps, whether you are migrating from Windows Storage Server 2008 R2 or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or Windows Storage Server 2012 to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
### Establish network identity of the iSCSI Target Server computer  
As part of the planning process, a strategy should have been devised regarding how iSCSI Target Server will be accessed from the network, based on key questions including but not limited to:  
  
-   Which computer name will be used?  
  
-   Which IP addresses on which subnet or set of network interfaces will be used?  
  
-   What relationship should be maintained between the IP addresses and computer name of the source server and the destination server? Will you keep the same addresses and names or create new ones?  
  
Based on the desired final configuration, configuration changes are potentially needed in the following areas:  
  
-   The DHCP Server that might assign IP addresses to the destination iSCSI Target servers  
  
-   The DHCP Server that might assign IP addresses to the iSCSI initiators  
  
-   The DNS Server or Active Directory domain controller that might perform naming resolution services for the computers in the enterprise  
  
### <a name="BKMK_config_portal"></a>Configure the iSCSI Target Server portal  
After you have configured IP addresses for the network interfaces of the iSCSI Target Server computer, it is possible to verify the existing configuration by using the following Windows PowerShell command:  
  
```  
PS > $Portals = Get-WmiObject -Namespace root\wmi -Class WT_Portal | Where-Object { $_.Listen }  
PS > $Portals  
```  
  
The configuration of the access surface for iSCSI Target Server from the network can be restricted by disabling certain portals. For example, you can disable the fourth portal in the array returned in the previous step by using the following Windows PowerShell commands:  
  
```  
PS > $Portals[3].Listen = 0  
PS > $Portals[3].Put()  
  
```  
  
The default port can also be changed from 3260 to any available TCP port on the destination server.  
  
### <a name="BKMK_iSNS"></a>Configure iSNS settings  
The iSNS servers that were configured for the source server can be configured for the destination server by using the following Windows PowerShell commands:  
  
```  
PS > $WT_ISnsServerClass =  Get-WmiObject -namespace root\wmi -class meta_class -filter "__CLASS = 'WT_ISnsServer'"  
PS > $WtiSNSInstanace = $WT_ISnsServerClass.CreateInstance()  
PS > $WtiSNSInstanace.ServerName = "<iSNS computer name or IP>"  
PS > $WtIsnsInstanace.Put()  
  
```  
  
> [!NOTE]  
> The set of iSNS servers that are configured for iSCSI Target Server was obtained during the preparation of the source server.  
  
### <a name="BKMK_configstorage"></a>Configure storage  
The destination server is expected to have sufficient storage space to host all of the virtual disks that are present on the source server.  
  
The space does not need to be contiguous or in a single volume, and it does not need to replicate the same file system structure or volume mount point structure of the source server. The storage that is prepared to host the virtual disks must not be a nested volume, and it must be formatted with the NTFS file system.  
  
### <a name="BKMK_config_VSS"></a>Configure the Volume Shadow Copy Service  
For the storage that was prepared in the previous step, it is appropriate to configure the Volume Shadow Copy Service, in case the default per\-volume settings are not adequate. To inspect that current configuration, use the following Windows PowerShell command:  
  
```  
PS > & vssadmin.exe list shadowstorage  
  
```  
  
To modify the current configuration, use the following Windows PowerShell commands:  
  
```  
PS > & vssadmin.exe add ShadowStorage  
PS > & vssadmin.exe delete ShadowStorage  
PS > & vssadmin.exe resize ShadowStorage  
  
```  
  
### Transfer the virtual disk  
For all the files in the list of files that was captured in the source server preparation step, copy the files from the source server to the destination server. For more information, see [Capture the existing settings: stand\-alone configuration](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_Captureexisting).  
  
You will need the destination paths in the following steps. So if the absolute file path is different between the source server and the destination server, create a table with the mapping; for example:  
  
|||  
|-|-|  
|**Source path**|**Destination path**|  
|G:\\WS08R2\_OpsMgr2007\_R2.vhd|H:\\VHDS\\WS08R2\_OpsMgr2007\_R2.vhd|  
|F:\\Dynamic\_Spanned\_GPT\_2.vhd|D:\\DYNVHDS\\Dynamic\_Spanned\_GPT\_2.vhd|  
  
### <a name="BKMK_importtargetsettings"></a>Import the iSCSI Software Target settings in a stand\-alone configuration  
To import the iSCSI Software Target settings in a stand\-alone configuration, you need the .xml file that you previously created. For more information, see [Capture the existing settings: stand\-alone configuration](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_Captureexisting).  
  
If there is no change in the absolute path of the virtual disk files, the import process can be performed by using the following Windows PowerShell commands:  
  
```  
PS > cd “$ENV:SystemRoot\System32\WindowsPowerSehll\V1.0\Modules\IscsiTarget”  
PS> .\ iSCSITargetSettings.PS1 –Import –FileName <settings XML file>  
  
```  
  
If the absolute path is different between the source server and the destination server, before you import the settings, the settings .xml file needs to be altered to reflect the new path.  
  
Locate the records for the virtual disk, and alter the path in the <MigrationDevicePath> tag to reflect the absolute file path in the destination server:  
  
```  
<iSCSIVirtualDisk>  
 <DevicePath>F:\Dynamic_Spanned_GPT_2.vhd</DevicePath>  
  <MigrationDevicePath>D:\DYNVHDS\Dynamic_Spanned_GPT_2.vhd</MigrationDevicePath>  
</iSCSIVirtualDisk>  
  
```  
  
After the XML has been altered to reflect the path in the destination server, you can import the settings by using the Windows PowerShell commands previously presented.  
  
### Configure shadow storage for the virtual disks  
If certain virtual disks have shadow storage requirements that are different than the ones configured in the section  HYPERLINK "file:\/\/\/C:\\\\Users\\\\a\-dasiss\\\\Desktop\\\\iSCSI\_Migration\-Win2012\-jy\-IXReview.docx" \\l "z8" Configure the Volume Shadow Copy Service, it is possible to alter the default or previously configured settings by using the following Windows PowerShell commands:  
  
```  
PS > $VirtDisk = Get-WmiObject -Namespace root\wmi -Class WT_Disk | Where-Object { $_.DevicePath -eq '<full path of virtual disk>' }  
PS > $VirtDisk.SnapshotStorageSizeInMB = <new size>  
PS > $VirtDisk.Put()  
  
```  
  
### Configure CHAP and Reverse CHAP  
The authentication settings for iSCSI Target Server that are configured with CHAP and Reverse CHAP need to be manually configured. The list of targets that require CHAP and Reverse CHAP configuration is listed at the end of the import script, as described in the section Import the iSCSI Software Target settings in a standalone configuration.  
  
To configure the CHAP and Reverse CHAP settings, use the following Windows PowerShell commands:  
  
```  
PS > $Target = Get-WmiObject -Namespace root\wmi -Class WT_Host | Where-Object { $_.HostName -eq '<name of the target>' }  
PS > $Target.EnableCHAP = 1  
PS > $Target.CHAPUserName = "<user name>"  
PS > $Target.CHAPSecret = "<CHAP Secret>"  
PS  $Target.Put()  
  
```  
  
## Migrating iSCSI Software Target in a failover cluster  
The migration process for the failover cluster configuration is largely identical to migrating a stand\-alone configuration, with the following differences:  
  
-   You will migrate resource groups instead of merely establishing the network identity of the server.  
  
-   You will use different Windows PowerShell commands to import the resource groups.  
  
### Migrate resource groups  
This step replaces the “Establishing the network identity of iSCSI Target Server” step when you migrate a stand\-alone configuration because the network identity of an iSCSI Target server in a cluster is given by the union of the client access point. \(A client access point in the cluster is the logical union of a network name resource and one or more IP addresses that are assigned to the network name resource.\)  
  
Assuming the initial cluster resource groups and network names were configured in the default state, those can be recreated by using the following Windows PowerShell command:  
  
```  
PS > Add-ClusterServerRole – Name <resource group name>  
  
```  
  
Use this command for each of the resource groups that were in the original configuration. If the default client access point configuration does not match the initial configuration \(for example, because the network name is bound to the incorrect cluster network, or the configuration required statically assigned IP addresses\), modifications can be made. For more information, see [Migrate Roles and Features to Windows Server](http://technet.microsoft.com/library/jj134039.aspx).  
  
After the resource groups have been created, clustered disks must be assigned to the network resources to match the configuration that you captured. For more information, see the Cluster resource group configuration section.  
  
### <a name="BKMK_Importiscsitarget"></a>Import the iSCSI Software Target settings in a failover cluster  
Follow these instructions to import settings in a failover cluster configuration. \(This information differs from the how you would import settings in a stand\-alone configuration.\)  
  
A prerequisite for the import phase is to have all of the resource groups that will host iSCSI Target Server resources owned by the same cluster node. Use the following Windows PowerShell command to validate the current ownership:  
  
```  
PS > Get-ClusterGroup  
  
```  
  
If there is no change in the absolute path of the virtual disk files, the import process can be performed by using the following commands:  
  
```  
PS > cd “$ENV:SystemRoot\System32\WindowsPowerSehll\V1.0\Modules\IscsiTarget”  
PS> .\iSCSITargetSettings.PS1 –Import –FileName <settings XML file>  
  
```  
  
If the absolute path is different between the source server and the destination server, before you import the settings, the settings .xml file needs to be altered to reflect the new path.Locate the records for the virtual disk, and alter the path in the **<MigrationDevicePath>** tag to reflect the absolute file path in the destination server:  
  
```  
<iSCSIVirtualDisk>  
      <DevicePath>F:\Dynamic_Spanned_GPT_2.vhd</DevicePath>  
      <MigrationDevicePath>D:\DYNVHDS\Dynamic_Spanned_GPT_2.vhd</MigrationDevicePath>  
    </iSCSIVirtualDisk>  
  
```  
  
After the XML has been altered to reflect the path in the destination server, you can import the settings by using the Windows PowerShell commands.  
  
## Migrate iSCSI Target Server Providers  
This section provides details about migrating iSCSI Target Server Virtual Disk Service \(VDS\), Volume Shadow Copy Service \(VSS\), and SMI\-S providers.  
  
**Migrate VDS and VSS hardware providers**  
  
-   If you are upgrading from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the previous storage provider is automatically upgraded to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and no additional action is required.  
  
-   If you are upgrading from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must first manually uninstall the currently installed iSCSI Target storage provider. Because iSCSI Target storage provider was installed separately from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the provider cannot be automatically upgraded. When the iSCSI Target storage provider is uninstalled, do the following:  
  
    1.  Upgrade the server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    2.  Install the **iSCSI Target Storage Provider \(VDS and VSS hardware providers\)** role service on the upgraded server. You can do this using **Server Manager dashboard**.  
  
    3.  The iSCSI VDS and VSS storage providers must be configured to run under the administrative credentials of the iSCSI Target Server. For more information, see [iSCSI Target Block Storage, How To](http://technet.microsoft.com/library/hh848268.aspx).  
  
**Migrate SMI\-S providers**  
  
You must first manually uninstall the currently installed SMI\-S provider for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Because the SMI\-S provider was installed separately from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the provider cannot be automatically upgraded. When the SMI\-S provider is uninstalled, do the following:  
  
1.  Upgrade the server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The SMI\-S provider is automatically installed along with the iSCSI Target Server role service.  
  
2.  From any System Center Virtual Machine Manager \(VMM\) or SMI\-S management client, unregister and reregister using the appropriate credentials. For information on configuring the SMI\-S provider using VMM, see [Configuring an SMI\-S Provider for iSCSI Target Server](http://technet.microsoft.com/library/jj860422.aspx). For information about configuring the SMI\-S provider using the SMI\-S management client, see [Register\-SmisProvider](http://technet.microsoft.com/library/jj884241.aspx).  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[Prepare to Migrate iSCSI Software Target](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md)  
[Verify the iSCSI Software Target Migration](../Topic/Verify-the-iSCSI-Software-Target-Migration.md)  
[Troubleshoot the iSCSI Software Target Migration](../Topic/Troubleshoot-the-iSCSI-Software-Target-Migration.md)  
[Roll Back a Failed iSCSI Software Target Migration](../Topic/Roll-Back-a-Failed-iSCSI-Software-Target-Migration.md)  
  
