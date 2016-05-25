---
title: Roll Back a Failed iSCSI Software Target Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2eb0215-0ca1-43b9-90b7-d15d13f918be
author: JasonGerend
---
# Roll Back a Failed iSCSI Software Target Migration
If iSCSI initiators have successfully reconnected to the iSCSI Target Server computer, the migration is successful and complete. This topic discusses the tasks that should be performed in the event of a failed migration.  
  
## Restoring the role if the migration failed  
If migration does not complete successfully, a rollback procedure is required to undo any changes to the source server, other servers, and client computers, and then restore the source server back into service.  
  
### Rollback requirements  
The rollback procedure requires that the source server is available in the same state as it was after removing the network identity of the iSCSI Software Target server. For more information, see [Remove the network identity of the iSCSI Software Target computer](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_networkidentity).  
  
During the source server preparation steps, none of the steps performed permanently changed the existing configuration of the server because all of the operations were substantially read operations.  
  
The estimated time to complete the rollback is equivalent to the time that it takes to re\-establish the network identity of the source server. This operation may require rolling back changes to the DHCP servers, DNS server, or Active Directory Domain controllers.  
  
### Roll back iSCSI initiators on other computers  
The other computers in the enterprise that are affected by migrating ISCSI Software Target are the iSCSI initiators.  
  
In the case of a rollback, the iSCSI initiators that were configured to log on to the destination server need to be rolled back to the source server. Use the following Windows PowerShell commands:  
  
1.  To log out of an existing iSCSI session:  
  
    `PS > & iscsicli.exe sessionlist``PS > & iscsicli.exe LogoutTarget <session id>`  
  
2.  To discover the iSCSI Software Target source server:  
  
    `PS > & iscsicli AddTargetPortal <source server ip address> 3260``PS > iscsicli.exe ListTargets`  
  
3.  To log on to the targets on the iSCSI Software Target source server:  
  
    `PS > & iscsicli.exe  LoginTarget <target IQN> T < source server ip address> 3260 Root\ISCSIPRT\0000_0 * * * * * * * * * * * * *`  
  
### Roll back iSCSI Software Target on a stand\-alone source server  
This step will undo the network identity removal that is described in [Remove the network identity of the iSCSI Software Target computer](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_networkidentity).  
  
Possible scenarios include:  
  
-   Restore the NetBIOS fully qualified domain name to the source server, and assign the required IP addresses to the source server.  
  
-   Restore any DNS assignments \(for example, reverse lookup and DHCP assignment\).  
  
-   Restore any identities that were previously assigned in Active Directory.  
  
Each scenario requires potentially updating information in the DNS server, Active Directory, or DHCP server, according to the methodology that is used to assign IP addresses and network names to the servers in the enterprise.  
  
The intent of this step is to ensure that upon completion of the migration steps, the iSCSI initiators are able to locate the source server \(either through explicit reconfiguration, or implicitly through the computer name or IP address reassignment\).  
  
### Roll back iSCSI Software Target on a clustered source server  
Rolling back iSCSI Software Target on a clustered source server requires two steps:  
  
**Step 1: Roll back cluster network name changes**  
  
This step will undo the network identity removal described in [Remove the network identity of the iSCSI Software Target computer](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_networkidentity).  
  
In a clustered configuration, network names are established by the server principal name that is assigned in Active Directory to the cluster when the cluster was formed.  
  
To re\-establish network names that were possibly deleted or retired, the cluster administration utilities must be used. For more information, see [Migrating Clustered Services and Applications to Windows Server 2012](assetId:///40adc868-a787-4062-bacb-61207538d4ce).  
  
**Step 2: Move resource groups to the preferred owner node**  
  
After the client access points have been re\-established, the resource groups need to be moved back to their preferred owner node.  
  
The resource groups were moved to a single node as part of the steps performed in [Capture the existing settings: clustered configuration](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md#BKMK_capturesettings_cluster).  
  
To move the resource groups back to their preferred owner node, use the following Windows PowerShell command:  
  
`PS > & cluster.exe /cluster:<cluster name> GROUP <group name> /moveto:<node name>`  
  
> [!NOTE]  
> The group name and the node names were obtained during the previous preparation tasks.  
  
### Roll back iSCSI Target Server on a stand\-alone destination server  
To roll back iSCSI Target Server on a stand\-alone destination server that is running Windows Server 2012 or Windows Storage Server 2012, uninstall the **iSCSI Target Server** role service using Server Manager.  
  
### Roll back iSCSI Target Server on a clustered destination server  
To roll back iSCSI Target Server on a destination server that is running Windows Server 2012 or Windows Storage Server 2012 in a clustered configuration, first remove any client access point that was created for iSCSI Target Server and then uninstall the **iSCSI Target Server** role service using Server Manager.  
  
## Retiring iSCSI Software Target on a source server  
Retiring iSCSI Software Target 3.2 or iSCSI Software Target 3.3 on your source server requires using the following Windows PowerShell commands:  
  
#### Retire iSCSI Software Target  
  
1.  Find the package GUID:  
  
    `PS > Get-WmiObject -Class Win32_product | Where-Object { $_.packageName –match 'iscsitarget'}`  
  
2.  Uninstall the package:  
  
    `PS > & msiexec /uninstall <package GUID> /qr`  
  
## Retiring a source server  
In a stand\-alone configuration, there are no particular procedures for retiring the source server. In a clustered configuration, the client access points that are devoted to iSCSI Software Target access can be removed by using the following Windows PowerShell command:  
  
`PS > Remove-ClusterGroup -Name <resource group name> -RemoveResources -Force`  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[Prepare to Migrate iSCSI Software Target](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md)  
[Migrate iSCSI Software Target](../Topic/Migrate-iSCSI-Software-Target.md)  
[Verify the iSCSI Software Target Migration](../Topic/Verify-the-iSCSI-Software-Target-Migration.md)  
[Troubleshoot the iSCSI Software Target Migration](../Topic/Troubleshoot-the-iSCSI-Software-Target-Migration.md)  
  
