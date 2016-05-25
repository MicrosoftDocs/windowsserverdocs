---
title: File and Storage Services: Migrate an iSCSI Software Target
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a906976e-ce00-426c-9f71-91f78d4f4de6
author: JasonGerend
---
# File and Storage Services: Migrate an iSCSI Software Target
This section describes how to migrate Microsoft iSCSI Software Target 3.2 or 3.3 settings and data from an existing Windows Storage Server 2008 R2 or Windows Storage Server 2008 computer to a destination server that is running the iSCSI Target Server role service that is included with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and Windows Storage Server 2012.  
  
The naming for iSCSI Software Target has changed. To reduce the potential for confusion, in the context of this document, any naming that refers to “iSCSI Software Target”, refers to prior product versions installed on Windows Storage Server 2008 R2 and Windows Storage Server 2008, which are source servers. By contrast, any naming that refers to “iSCSI Target Server” refers to the new role service included with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and Windows Storage Server 2012, which are destination servers.  
  
> [!NOTE]  
> This section contains only iSCSI\-specific migration information. For generic information, such as the use of [Windows Server Migration Tools](http://technet.microsoft.com/library/jj134202), refer to [File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md).  
  
## Supported migration scenarios  
This section details both supported and unsupported migration scenarios.  
  
### Supported operating systems  
The versions of operating systems that are listed are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported.  
  
Migrations between physical operating systems and virtual operating systems are supported.  
  
Migration from a source server to a destination server that is running an operating system in a different system UI language \(that is, the installed language\) than the source server is not supported. For example, you cannot use Windows Server Migration Tools to migrate roles, operating system settings, data, or shared resources from a computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in the French system UI language to a computer that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the German system UI language.  
  
|||||  
|-|-|-|-|  
|**Source server processor**|**Source server operating system**|**Destination server operating system**|**Destination server processor**|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and Windows Storage Server 2012|x64\-based|  
|x64\-based|Windows Storage Server 2008 R2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and Windows Storage Server 2012|x64\-based|  
|x64\-based|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and Windows Storage Server 2012|x64\-based|  
|x64\-based|Windows Storage Server 2012|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and Windows Storage Server 2012|x64\-based|  
  
x64\-based migrations are supported for Windows Storage Server 2012 R2 and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. All editions of Windows Storage Server 2008 R2 and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are x64\-based.  
  
x86\-based migrations are not supported because Windows Storage Server 2012 R2 is not offered in the x86 platform.  
  
> [!NOTE]  
> The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
### Supported role configurations  
This migration guide is applicable to stand\-alone and clustered configurations, with certain limitations.  
  
The following general restrictions are applicable to all the supported configurations:  
  
-   Authentication settings for iSCSI initiators that use CHAP and Reverse CHAP settings are not automatically migrated.  
  
-   Snapshot storage settings for each virtual disk in the configuration are not automatically migrated.  
  
-   Configuration settings for virtual disks that are derived from snapshots are not automatically migrated.  
  
-   For clustered configurations, the migration process includes iSCSI target settings that are scoped to the virtual computer object, to a cluster node, or to the cluster node that owns the code cluster group.  
  
-   For clustered configurations, the migration of resource groups, network name resources, IP addresses, and cluster disks that are associated with resource groups is outside of the scope of this guide, and the migration needs to be performed independently as a preliminary step.  
  
-   iSCSI Naming Services \(iSNS\) settings for iSCSI Software Target are not automatically migrated.  
  
-   iSCSI target portal settings \(such as IP addresses that are used by the iSCSI target service to listen for incoming network connections\) are not automatically migrated  
  
-   The schedule for snapshots of virtual disks is not migrated.  
  
The following configurations are supported:  
  
-   Migration from a stand\-alone configuration to stand\-alone configuration  
  
-   Migration from a clustered configuration to a stand\-alone configuration \(with the restrictions listed previously regarding the scope of the settings\).  
  
-   Migration from a clustered configuration to a clustered configuration \(with the restrictions listed previously regarding the scope of the settings\).  
  
### Supported role services and features  
iSCSI Target Server \(as included with Windows Storage Server 2012 and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\) does not have role dependencies or feature dependencies.  
  
It is possible to install iSCSI Target Server with failover clustering, and this configuration is supported with the migration limitations listed previously.  
  
### Migrating multiple roles  
If you are migrating one clustered configuration to a different clustered configuration, the Failover Clustering feature needs to be migrated or set up prior to migrating iSCSI target settings.  
  
### Migration scenarios that are not supported  
The following migration scenarios are not supported:  
  
-   Migration from Windows Unified Storage Server 2003 R2.  
  
-   Migration from a stand\-alone configuration to a clustered configuration. This migration is not supported because there is no default mechanism to associate target and virtual disk settings to resource groups without knowing how the file paths are mapped to the cluster disk and how IP addresses are mapped to resource groups.  
  
-   Snapshots of virtual disks are not automatically migrated. Snapshots are based on a snapshot of the volume that contains the virtual hard disk \(VHD\) file at the time the snapshot was taken. Their existence and implementation depends on the volume of the computer from which the migration process happens, and it cannot be replicated or exported.  
  
-   Snapshot storage settings for virtual disks are not automatically migrated. The snapshot storage settings \(such as volume and maximum size per volume\) are dependent on the hardware and software configuration of the computer to which the settings are being migrate, and they cannot automatically be migrated. For detailed information about how to manually migrate the snapshot storage settings, see [Import the iSCSI Software Target settings in a stand\-alone configuration](../Topic/Migrate-iSCSI-Software-Target.md#BKMK_importtargetsettings).  
  
-   The configuration settings of the iSCSI target portal are not automatically migrated. This configuration is based on the IP addresses of the destination server, and those settings cannot be migrated outside the knowledge of the network configuration of the computer to which the settings are being migrate. For detailed information about how to manually configure the portal settings, see [Configure the iSCSI Target Server portal](../Topic/Migrate-iSCSI-Software-Target.md#BKMK_config_portal).  
  
-   iSNS settings are not automatically migrated. The iSNS settings are based on the network infrastructure and configuration of the destination server, and those settings cannot be migrated outside the knowledge of the network configuration of the computer to which the settings are being migrated. For detailed information about how to manually configure iSNS settings, see [Configure iSNS settings](../Topic/Migrate-iSCSI-Software-Target.md#BKMK_iSNS).  
  
-   Settings for virtual disks that are attached as local disks on the source server are not automatically migrated. The ability to attach a disk locally is expected to be a temporary operation that can be replicated if. For detailed information about how to configure settings for virtual disks that are to be attached as local disks, see [Configure storage](../Topic/Migrate-iSCSI-Software-Target.md#BKMK_configstorage).  
  
-   The schedule for snapshots of virtual disks is not migrated. Those settings must be manually discovered and replicated from the source to the destination server.  
  
## Migration overview  
This section describes the high\-level migration process, which involves harvesting configuration settings from the source, moving the virtual disks from the source server to the destination server, and restoring the configuration settings.  
  
### Migration process  
This section describes the high\-level migration process.  
  
**Migration planning**  
  
The migration planning phase involves gathering information based on the following questions:  
  
-   Are the source server and destination server configured in a cluster?  
  
-   If the servers are configured in a cluster, what are the virtual computer objects or client access points that contain the iSCSI target resources?  
  
-   Is the storage system of the destination server capable and configured appropriately to host the virtual disks of the source server, and does it have appropriate space to store the volume snapshots?  
  
-   Are there any iSCSI initiators that have a critical dependency on iSCSI targets for the duration of the migration process \(such as a computer that uses iSCSI boot nodes, or clusters that use shared storage\)?  
  
-   Are there any IP address or portal settings that are unique to the source server that need to be accounted for \(such as IP addresses that are known to the firmware of devices\)?  
  
-   Are there any iSNS settings that need to be manually recorded and migrated?  
  
-   Are there any virtual disks attached as local disks that might need to be exposed?  
  
**Preparing to migrate**  
  
The preparation to migrate data from the source server to the destination server involves the following steps:  
  
1.  If the destination server will have a clustered configuration, install the Failover Clustering feature and form a cluster before performing the migration.  
  
2.  If the destination server will have a clustered configuration, create a number of cluster resource groups with client access points and cluster disks as appropriate to replicate the existing configuration. If possible, use the same resource group names for the source clusters and the destination clusters.  
  
3.  Install the iSCSI Target Server role service on the destination server.  
  
4.  Disconnect all the iSCSI initiators. This step is required to maintain consistent data on the virtual disks while they are being moved.  
  
5.  Run the Windows PowerShell cmdlets, [Import\-IscsiTargetServerConfiguration](http://technet.microsoft.com/library/dn448372.aspx) and [Export\-IscsiTargetServerConfiguration](http://technet.microsoft.com/library/dn448370.aspx), to capture the existing settings on the source server in an XML file. For a cluster, run the Windows PowerShell cmdlets on each node in the cluster or on each virtual computer object, as appropriate for the scope of the planned migration.  
  
    The Windows PowerShell output displays the virtual disks that are eligible for migration and those that are not \(for the snapshot\-based reasons discussed previously\).  
  
**Migration**  
  
The actual migration process includes the following steps:  
  
1.  Move the files for all the virtual disks that are eligible for migration from the source server to the destination server. If there are any file path changes, note the source to destination mapping.  
  
2.  In a cluster configuration, ensure that the destination path of the file copy is on a cluster disk and that the cluster disk has been assigned to a resource group. Note the resource group that owns the path.  
  
3.  If the file paths have changed between the source and the destination servers, open the settings .xml file in a text editor, and identify the **<MigrationDevicePath>** tags that need to be changed to reflect the new path.  
  
4.  In a cluster configuration, if the file path or the resource group name have changed between the source server and the destination server, open the settings .xml file in a text editor, and identify the **<MigrationResourceGroup>** tags that need to be changed to reflect the new resource group.  
  
5.  Run the Windows PowerShell cmdlet, [Import\-IscsiTargetServerConfiguration](http://technet.microsoft.com/library/dn448372.aspx), to import the settings to the destination server. In a cluster configuration, the destination server can be specified as a cluster node or as a virtual computer object. The cluster node or virtual computer object must be the owner of the resource group that is indicated in the settings .xml file.  
  
6.  If there are snapshot storage settings relevant to the new configuration, apply those settings manually.  
  
7.  If there are virtual disks that need to be attached as local disks, perform those actions.  
  
8.  If there are any iSNS settings that are relevant to the new configuration, apply those settings manually.  
  
9. If there are any iSCSI target portal settings that are relevant to the new configuration, apply those settings manually.  
  
10. If there are any iSCSI initiators that are configured to authenticate by using CHAP and Reverse CHAP, manually restore those settings.  
  
**Verification**  
  
The verification process for the migration involves the following steps:  
  
1.  Validate the iSCSI target portal settings by opening a Command Prompt window and typing **`netstat.exe –nao | findstr 3260`**. \(This assumes that the default TCP port for the iSCSI protocol 3260 is used.\) Alternatively, type **`Get-WmiObject –Namespace root\wmi –Class WT_Portal`** to cross\-check the results.  
  
2.  Inspect the iSCSI Target Server configuration by using the Windows PowerShell cmdlet, **`Get-IScsiServerTarget`**  
  
3.  Inspect the iSCSI virtual disk configuration by using the Windows PowerShell cmdlet, **`Get-IScsiVirtualDisk`**  
  
4.  Validate the configuration for each iSCSI initiator that you expect to use with iSCSI Target Server by using the iscsicpl.exe UI tool or the iscsicli.exe command\-line tool.  
  
### Impact of migration  
The migration process does not impact or affect the source server. There are no resources or configuration settings that are altered or deleted as part of the migration process.  
  
No servers in the enterprise, other than the destination servers, will be affected by the migration.  
  
Client computers that are running as iSCSI initiators are expected to be explicitly disconnected during the migration to ensure data integrity. During the migration, the source server will be unavailable. When the migration process is complete, it is expected that the iSCSI initiators will log on to the destination server without any issues.  
  
The downtime for the iSCSI initiators is expected to be proportionate to the time it takes to move the virtual disk files from the source server to the destination server, plus the time needed to restore the configuration settings and to establish the network identity of the destination server.  
  
### Permissions required for migration  
Local Administrator permissions are required on the source and the destination server.  
  
If the iSNS server has additional access control policies, permission to alter the iSNS settings are required as appropriate for the iSNS server.  
  
To perform the migration process for the iSCSI initiators, permissions to log on and log off iSCSI sessions are required. For the iSCSI initiator, Local Administrator permissions are required.  
  
For iSCSI initiators that are firmware based, such as a network interface with the option to boot from iSCSI, being at the actual console may be required to configure logon credentials or the network identity of the destination server if the authentication settings \(CHAP and Reverse CHAP\) have changed.  
  
### Estimated time duration  
This section detail the various factors that impact how long a migration may take to complete.  
  
**Planning**  
  
The planning phase is expected to be influenced by the following factors:  
  
-   Stand\-alone versus a cluster configuration. A cluster setup may require one to two hours to configure if all the validations are performed.  
  
-   Storage configuration. Understanding and configuring a storage array to host potentially huge files requires that you plan the spindle and volume configurations so that they use the tools that are provided by the storage subsystem vendor.  
  
-   Network identity. This planning involves understanding if the source server has specially or purposely configured IP addresses, if configuring Level\-2 components \(such as switches\) is required, and if specific DNS or NetBIOS names need to be known to and cached by the iSCSI initiators.  
  
**Preparation**  
  
The preparation process involves understanding which settings \(that are specific to the source server\) cannot be automatically migrated, and gathering those settings. For each step in the preparation phase, the mechanism that is used to retrieve the settings depends on which step is applicable and which tool is used to recover those settings.  
  
-   Cluster resource group names and configuration. These settings can be gathered from the cluster administration tools and the user interfaces.  
  
-   iSCSI target portal configuration. These settings can be gathered by typing the following code at a command prompt: `PS > Get-WmiObject –Namespace root\wmi –Class WT_Portal`  
  
-   iSNS Server settings. These settings can be gathered by typing the following code at a command prompt: `PS > Get-WmiObject –Namespace root\wmi –Class WT_ISnsServer`  
  
-   CHAP and Reverse CHAP authentication settings. These settings cannot be automatically retrieved because the iSCSI target server does not offer a mechanism to retrieve passwords. These settings have been stored elsewhere in the enterprise, and they need to be retrieved independently.  
  
-   Locally mounted virtual disk settings.  
  
**Migration**  
  
The estimated time for the actual migration process is largely dominated by the time that it takes to move the virtual disk files from the source server to the destination server.  
  
A network\-based file copy, using a 1 GB link used at 50% for 1 TB of data, is estimated to take over five hours. Techniques that use a file transfer process involving external media, such as an External Serial Advanced Technology Attachment \(eSATA\) device, may take less time.  
  
The execution of the Windows PowerShell cmdlet, [Import\-IscsiTargetServerConfiguration](http://technet.microsoft.com/library/dn448372.aspx), is estimated to take few minutes for approximately 100 resources \(with a combination of iSCSI target settings and virtual disk settings\).  
  
**Verification**  
  
The estimated time for the verification is proportionate to the time it takes to reconnect or log on to the iSCSI initiators.  
  
For each iSCSI initiator, the target portal needs to be reconfigured, credentials related to authentication settings must be entered \(if required\), and the sessions have to be logged on.  
  
The estimated time is 5 to 15 minutes to verify each iSCSI initiator, depending on the process that is being used. iSCSI initiators can be verified through the iscsicpl.exe UI, through the iscsicli.exe command\-line tool, or through ad hoc Windows Management Instrumentation \(WMI\)\-based scripts\).  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[Prepare to Migrate iSCSI Software Target](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md)  
[Migrate iSCSI Software Target](../Topic/Migrate-iSCSI-Software-Target.md)  
[Verify the iSCSI Software Target Migration](../Topic/Verify-the-iSCSI-Software-Target-Migration.md)  
[Troubleshoot the iSCSI Software Target Migration](../Topic/Troubleshoot-the-iSCSI-Software-Target-Migration.md)  
[Roll Back a Failed iSCSI Software Target Migration](../Topic/Roll-Back-a-Failed-iSCSI-Software-Target-Migration.md)  
  
