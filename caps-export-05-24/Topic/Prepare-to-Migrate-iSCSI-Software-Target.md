---
title: Prepare to Migrate iSCSI Software Target
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8bd497bb-38f9-4ee2-9864-3db2cddd4d83
---
# Prepare to Migrate iSCSI Software Target
This topic discusses the tasks that are necessary before you start the migration process. The first step is to install the Windows Server Migration Tools. For more information, see [File and Storage Services: Prepare to Migrate](http://technet.microsoft.com/library/jj863563.aspx).  
  
## Prepare the destination server  
The destination server is a computer that is configured and shipped by an OEM with Windows Storage Server 2012 pre\-installed, or that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
iSCSI Target Server hardware requirements for the destination server are the following:  
  
-   The amount of free disk space on the destination server must be sufficient to host the iSCSI virtual disk from the source server with adequate room for the snapshot storage.  
  
-   For clustered configurations, the resource groups that are created in the destination server must have associated cluster disks with adequate free space to host the iSCSI virtual disk from the source server.  
  
-   The destination server must have one or more network interfaces to be utilized for the iSCSI network traffic.  
  
Installing the Failover Cluster feature in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or Windows Storage Server 2012 or is required if the source server was configured with failover clusters. For more information, see the [Failover Clustering Overview](http://technet.microsoft.com/library/hh831579.aspx).  
  
## Back up the source server  
Before you start migration, as a best practice, it is recommended that you back up the source server. For more information, see [Windows Server Backup](http://technet.microsoft.com/library/cc770757.aspx).  
  
## Prepare the source server  
The following tasks are performed on the source server.  
  
### <a name="BKMK_clusterresource"></a>Cluster resource group configuration  
Use the following steps to obtain the cluster resource groups:  
  
1.  Gather the resource groups that have iSCSI Software Target resources by using the following Windows PowerShell commands:  
  
    ```  
    PS > Import-Module FailoverClusters  
    PS > $iSCSITargetResources = Get-ClusterResource | Where-Object { ( $_.ResourceType.Name -eq "Host" ) –or ($_.ResourceType.Name -eq "WTDisk") }  
    PS > $iSCSITargetResources  
  
    ```  
  
2.  From the cluster resources obtained in the previous step, gather the cluster disk dependencies by using the following Windows PowerShell commands:  
  
    ```  
    PS > $Dependencies = &{ $iSCSITargetResources | Get-ClusterResourceDependency  }   
    PS > $Dependencies  
  
    ```  
  
If the source server is running Windows Storage Server 2008, the following steps can be followed to gather the equivalent information:  
  
1.  Gather the iSCSI Software Target resources, and then gather the groups by using the following Windows PowerShell commands:  
  
    ```  
    PS > $iSCSITargetResources = Get-WmiObject -NameSpace root\mscluster -Authentication PacketPrivacy -Class MsCluster_Resource -Filter "Type = `"WTDisk`" or Type = `"Host`""  
    PS > $iSCSITargetResources  
    PS > $Groups = &{foreach($res in $iSCSITargetResources) { Get-WmiObject -NameSpace root\mscluster -Authentication PacketPrivacy -Query "associators of {$($res.__RELPATH)}  WHERE ResultClass = MSCluster_ResourceGroup" }}  
    PS > $Groups  
  
    ```  
  
2.  From the cluster resources obtained in the previous step, gather the cluster disk dependencies by using the following Windows PowerShell commands:  
  
    ```  
    PS > $Dependencies = &{foreach($res in $iSCSITargetResources) { Get-WmiObject -NameSpace root\mscluster -Authentication PacketPrivacy -Query "associators of {$($res.__RELPATH)}  WHERE ResultClass = MSCluster_Resource ResultRole = Dependent" }}  
    PS > $Dependencies  
    ```  
  
The resource groups obtained in step 1 have network name resources and IP addresses that need to be migrated to the destination server.  
  
For information about how to migrate these settings, see [Migrate Roles and Features to Windows Server](http://technet.microsoft.com/library/jj134039.aspx).  
  
The cluster disk that you obtained in step 2 is the physical disk where the volumes reside that are hosting the iSCSI Software Target virtual disks.  
  
To obtain the volumes from the cluster disk, use the following steps:  
  
1.  Obtain the disk signature of the cluster disk by using the following Windows PowerShell command:  
  
    ```  
    PS > & cluster.exe res "<cluster resource name>" /priv  
  
    ```  
  
2.  Obtain the **Win32\_DiskDrive** object from the disk signature by using the following Windows PowerShell command:  
  
    ```  
    PS > $DiskObj = Get-WmiObject -Namespace root\cimv2 -Class Win32_DiskDrive -Filter "Signature = <disk signature>"  
    PS > $DiskObj  
    ```  
  
3.  Obtain the **Win32\_DiskDriveToDiskPartition** association by using the following Windows PowerShell command:  
  
    ```  
    PS > $DiskToDiskPartition = Get-WmiObject -Namespace root\cimv2 –Class Win32_DiskDriveToDiskPartition | Where-Object { $_.Antecedent -eq $DiskObj.__PATH }  
    PS > $DiskToDiskPartition  
    ```  
  
4.  Obtain the **Win32\_LogicalDiskToDiskPartition** association that points to the volume association by using the following Windows PowerShell command:  
  
    ```  
    PS > Get-WmiObject -Namespace root\cimv2 -Class Win32_LogicalDiskToPartition | Where-Object { $_.Antecedent -eq $ DiskToDiskPartition.Dependent }  
    ```  
  
Steps 2–4 must be applied on the source server cluster node that currently owns the physical disk cluster resource.  
  
### iSCSI Target portal configuration  
Use the following steps to obtain the portal associations:  
  
1.  Gather the configured portals association for the iSCSI target portal by using the following Windows PowerShell command:  
  
    ```  
    PS> Get-WmiObject -Namespace root\wmi -Class WT_portal | Format-List -Property Address,Listen,Port  
    ```  
  
2.  The IP addresses that have the **Listen** state set to **True** are the IP addresses that an iSCSI initiator can use to reach the server. For more information about migrating the IP addresses, see [Migrate Roles and Features to Windows Server](http://technet.microsoft.com/library/jj134039.aspx).  
  
### iSNS configuration  
Gather the configured iSCSI Naming Services \(iSNS\) association for the server by using the following Windows PowerShell command:  
  
```  
PS> Get-WmiObject -Namespace root\wmi -Class WT_ISnsServer | Format-List -Property ServerName  
  
```  
  
The server names that are listed need to be added to the list of iSNS servers that can be used to retrieve information about the iSCSI initiators in the enterprise.  
  
### CHAP and Reverse CHAP configuration  
Gather the CHAPUserName and ReverseCHAPUserName association for the servers that are configured with CHAP and Reverse CHAP by using the following Windows PowerShell command:  
  
```  
PS > Get-WmiObject -Namespace root\wmi -Class WT_Host | Where-Object { ( $_.EnableCHAP ) -or ( $_.EnableReverseCHAP )  } | Format-List -Property Hostname,CHAPUserName,ReverseCHAPUserName  
  
```  
  
The passwords that are used in conjunction with the credentials listed previously cannot be retrieved, and they must be known through other mechanisms.  
  
### Snapshot storage configuration  
The snapshot storage configuration can be obtained by using the following Windows PowerShell command:  
  
```  
PS > & vssadmin.exe list shadowstorage  
  
```  
  
This command shows the volume snapshot shadow storage configuration for the entire source server. Not all the volumes listed may be relevant to the current iSCSI Software Target server configuration.  
  
For the volumes that are relevant \(that is, the volumes that host iSCSI virtual disks\), the associated shadow storage volume is listed, in addition to the amount of disk space used with the maximum amount of configured space.  
  
### Disconnect the iSCSI initiators  
Follow the instruction in the following section to disconnect the iSCSI initiators: Prepare other computers in the enterprise.  
  
### <a name="BKMK_Captureexisting"></a>Capture the existing settings: stand\-alone configuration  
All of the settings on the iSCSI Software Target source server that are not hardware configuration specific and are not dependent on an IP address and the network identity of the server can be captured with the following Windows PowerShell commands:  
  
**Windows Server 2008 R2 and Windows Server 2008 file path**  
  
```  
PS > cd “$ENV:SystemRoot\Program Files\Microsoft iSCSI Software Target”  
PS> Export-IscsiTargetServerConfiguration –FileName <settings XML file>  
```  
  
**Windows Server 2012 R2 file path:**  
  
```  
PS > cd “$ENV:SystemRoot\System32\WindowsPowerShell\V1.0\Modules\IscsiTarget”  
PS> Export-IscsiTargetServerConfiguration –FileName <settings XML file>  
```  
  
If the procedure is performed on a source server that is running iSCSI Target 3.3 from a destination server that is prepared as illustrated in the previous sections, the settings can be captured using the following Windows PowerShell commands:  
  
**Windows Server 2012 R2 file path:**  
  
```  
PS > cd “$ENV:SystemRoot\System32\WindowsPowerSehll\V1.0\Modules\IscsiTarget”  
PS> Export-IscsiTargetServerConfiguration –FileName <settings XML file> -ComputerName <source server computer name>  
  
```  
  
**Windows Server 2008 R2 and Windows Server 2008 file path**  
  
```  
PS > cd “$ENV:SystemRoot\Program Files\Microsoft iSCSI Software Target”  
PS> Export-IscsiTargetServerConfiguration –FileName <settings XML file> -ComputerName <source server computer name>  
```  
  
At the end of the settings capture process, the Windows PowerShell script will display the set of VHD files that are eligible for migration. This list is needed for the destination server during migration.  
  
### <a name="BKMK_capturesettings_cluster"></a>Capture the existing settings: clustered configuration  
Before capturing the iSCSI Software Target source server settings that are not hardware configuration specific, we recommend that all the resource groups with iSCSI target resources are moved to a single node in the cluster.  
  
This can be accomplished by using the following Windows PowerShell commands. These commands assume that you previously followed the steps in [Cluster resource group configuration](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_clusterresource).  
  
```  
PS > $iSCSITargetResources | Format-List -Property OwnerGroup  
PS > foreach($Res in $iSCSITargetResources) { & cluster group  $Res.OwnerGroup /moveto:$ENV:COMPUTERNAME }  
  
```  
  
After all the resource groups have been moved to a single node, the settings can be gathered by using the following Windows PowerShell commands:  
  
**Windows Server 2012 R2 file path:**  
  
```  
PS > cd “$ENV:Programfiles\ISCSI Target”  
PS> .\ Export-IscsiTargetServerConfiguration –FileName <settings XML file>  
  
```  
  
**Windows Server 2008 R2 and Windows Server 2008 file path**  
  
```  
PS > cd “$ENV:SystemRoot\Program Files\Microsoft iSCSI Software Target”  
PS> .\ Export-IscsiTargetServerConfiguration –FileName <settings XML file>  
```  
  
If the procedure is performed on a source server that is running iSCSI Target 3.2, the resources can be moved to a single node by using the following Windows PowerShell commands:  
  
```  
PS >  $Groups = &{foreach($res in $iSCSITargetResources) { Get-WmiObject -NameSpace root\mscluster -Authentication PacketPrivacy -Query "associators of {$($res.__RELPATH)}  WHERE ResultClass = MSCluster_ResourceGroup" }}  
PS > foreach($Group in $Groups) { & cluster group $Group.Name /moveto:<node name source server> }  
  
```  
  
The iSCSI Target Server settings need to be gathered from a destination server that is prepared as illustrated in the previous sections. Run the script from a source server that is running iSCSI Target 3.3 by using the following Windows PowerShell command:  
  
**Windows Server 2012 R2 file path:**  
  
```  
PS > cd “$ENV:Programfiles\ISCSI Target”  
PS> .\ Export-IscsiTargetServerConfiguration –FileName <settings XML file> -ComputerName <source server computer name>   
```  
  
**Windows Server 2008 R2 and Windows Server 2008 file path**  
  
```  
PS > cd “$ENV:SystemRoot\Program Files\Microsoft iSCSI Software Target”  
PS> .\ Export-IscsiTargetServerConfiguration –Export –FileName <settings XML file> -ComputerName <source server computer name>  
```  
  
In the previous example, the source server computer name is the name of the node. At the end of the settings capture process, the Windows PowerShell script will display the set of VHD files that are eligible for migration. This list is needed for the destination server during migration.  
  
### <a name="BKMK_networkidentity"></a>Remove the network identity of the iSCSI Software Target computer  
In a network with an iSCSI Software Target source computer, the identity of the server is known to iSCSI initiators in the form of NetBIOS names, fully qualified domain names \(FQDN\), or IP addresses. When a server is being replaced, as part of planning, a strategy to replace the server network identity must be devised. Possible scenarios include:  
  
-   Transfer the NetBIOS and FQDNs to the destination server, and then assign new IP addresses to the destination server.  
  
-   Create new NetBIOS and FQDNs for the destination server, and then assign the existing IP addresses to the destination server.  
  
-   Create new NetBIOS and FQDNs for the destination server, and then assign new IP addresses to the destination server.  
  
Each scenario requires potentially updating information in the DNS server, Active Directory, or DHCP server, according to the methodology that is used to assign IP addresses and network names to the servers in the enterprise.  
  
The intent of this step is to ensure that upon completion of the migration steps, the iSCSI initiators are able to locate the destination server \(either through explicit reconfiguration, or implicitly through the computer name or IP address re\-assignment\).  
  
For more information, see [Migrate Roles and Features to Windows Server](http://technet.microsoft.com/library/jj134039.aspx).  
  
## Prepare the iSCSI initiator computers  
The other computers in the enterprise that are affected by migration are the iSCSI initiators. The users of the computers that are acting as iSCSI initiators should be sent an outage notification. If the iSCSI Software Target is being used as a boot node for the iSCSI initiator computers, the computers may be completely unusable for the duration of the migration.  
  
### Capture the session information  
The information regarding the active session for an iSCSI Software Target source server can be obtained by using the following Windows PowerShell command:  
  
```  
PS > & iscsicli.exe sessionlist  
```  
  
This information is needed to disconnect the session.  
  
### Disconnect the session  
The session can be disconnected by using the following Windows PowerShell command:  
  
```  
PS > & iscsicli.exe LogoutTarget <session id>  
```  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[Migrate iSCSI Software Target](../Topic/Migrate-iSCSI-Software-Target.md)  
[Verify the iSCSI Software Target Migration](../Topic/Verify-the-iSCSI-Software-Target-Migration.md)  
[Troubleshoot the iSCSI Software Target Migration](../Topic/Troubleshoot-the-iSCSI-Software-Target-Migration.md)  
[Roll Back a Failed iSCSI Software Target Migration](../Topic/Roll-Back-a-Failed-iSCSI-Software-Target-Migration.md)  
  
