---
title: Storage Replica: Known Issues
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: ceddb0fa-e800-42b6-b4c6-c06eb1d4bc55
author: kumudd
---
# Storage Replica: Known Issues
This section discusses known issues with Storage Replica in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)].  
  
## After removing replication, disks are offline and you cannot configure replication again  
In [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], you may be unable to provision replication on a volume that was previously replicated or may find un\-mountable volumes. This may occur when some error condition prevents removal of replication or when you reinstall the operating system on a computer that was previously replicating data.  
  
To fix, you must clear the hidden Storage Replica partition off the disks and return them to a writeable state. Previously this required complex **DISKPART** steps but [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] introduces a simple cmdlet named `Clear-SRMetadata`.  
  
-   To remove all orphaned Storage Replica  partition databases slots and remount all partitions, use the `–AllPartitions` parameter as follows:  
  
    ```  
    Clear-SRMetadata -AllPartitions  
    ```  
  
-   To remove all orphaned Storage Replica log data, use the `–AllLogs` parameter as follows:  
  
    ```  
    Clear-SRMetadata -AllLogs  
    ```  
  
-   To remove all orphaned failover cluster configuration data, use the `–AllConfiguration` parameter as follows:  
  
    ```  
    Clear-SRMetadata -AllConfiguration  
    ```  
  
-   To remove individual replication group metadata, use the `–Name` parameter and specify a replication group as follows:  
  
    ```  
    Clear-SRMetadata –Name RG01 –Logs -Partition  
    ```  
  
The server may need to restart after cleaning the partition database; you can suppress this temporarily with `–NoRestart` but you should not skip restarting the server if requested by the cmdlet. This cmdlet does not remove data volumes nor data contained within those volumes.  
  
## During initial sync, see event log 4004 warnings  
In [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], when configuring replication, both the source and destination servers may show multiple **StorageReplica\Admin** event log 4004 warnings each during initial sync, with a status of “insufficient system resources exist to complete the API”. You are likely to see 5014 errors as well. These indicate that the servers do not have enough physical memory \(RAM\) to perform both initial synchronization as well as run workloads. Either add RAM or reduce the used RAM from features and applications other than Storage Replica.  
  
## When using guest clusters with Shared VHDX and a host without a CSV, virtual machines stop responding after configuring replication  
In [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], when using Hyper\-V guest clusters for Storage Replica testing or demonstration purposes, and using Shared VHDX as the guest cluster storage, the virtual machines stop responding after you configure replication. If you restart the Hyper\-V host, the virtual machines start responding but replication configuration will not be complete and no replication will occur.  
  
This behavior occurs when you are using **fltmc.exe attach svhdxflt** to bypass the requirement for the Hyper\-V host running a CSV. Use of this command is not supported and is intended only for test and demonstration purposes.  
  
The cause of the slowdown is a by\-design interoperability issue between the new Storage QoS feature in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] and the manually attached Shared VHDX filter. To resolve this issue, disable the Storage QoS filter driver and restart the Hyper\-V host:  
  
```  
SC config storqosflt start= disabled  
```  
  
## Removing disks from Available Storage prevents them from use again  
In [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], when using Failover Cluster Manager to remove available storage asymmetric shared disks, you can no longer add some of them back later. They do not appear in the **Add Disks** view.  
  
Use `Clear-ClusterDiskReservation` to make these disks eligible to Available Storage. To prevent the issue, only remove disks when they show as Online and owned by the cluster nodes that physically attach to them.  
  
## Cannot configure replication when using New-Volume and differing storage  
When using the `New-Volume` cmdlet along with differing sets of storage on the source and destination server, such as two different SANs or two JBODs with differing disks, you may not be able to subsequently configure replication using `New-SRPartnership`. The error shown may include:  
  
    Data partition sizes are different in those two groups  
  
Use the `New-Partition**` cmdlet to create volumes and format them instead of `New-Volume`, as the latter cmdlet may round the volume size on differing storage arrays. If you have already created an NTFS volume, you can use `Resize-Partition` to grow or shrink one of the volumes to match the other \(this cannot be done with ReFS volumes\). If using **Diskmgmt** or **Server Manager**, no rounding will occur.  
  
## Changing replication direction during initial sync is possible, leading to data loss  
   
When running `Set-SRPartnership` with `-NewSourceComputerName`, you are allowed to change replication direction in the middle of initial sync. If the destination server contained no data, it now authoritatively sends an empty volume back to the previous source, potentially wiping out all data.  
  
This is caused by a known issue in Windows Server 2016 Technical Preview. Do not switch replication direction during initial sync. You can use the event log and `Get-SRGroup` on the destination server to ensure that initial sync completed, before switching direction.  
## Adding additional disks to an existing replication group using Failover Cluster Manager fails  
  
When attempting to use the Add Replication Partnership Wizard in Failover Cluster Manager, you successfully select all desired storage and reach the Summary page, where you then receive error:  
  
    ERROR CODE: 0x80131500  
  
    NATIVE ERROR CODE: 1  
      
    Unable to move cluster resource group Available Storage to cluster node <node name>  
  
This is caused by a known issue in Windows Server 2016 Technical Preview. As a workaround, add an additional disk to Available Storage. This need for an additional ‘dummy’ disk in available storage is due to a regression and not intentional. Failover Cluster Manager previously supported addition of more disks normally, and will again in a later release.  
  
## Setting partnership on a previously replicated group leads to suspended state  
When attempting set a partnership on replication groups in a stretch cluster that were previously in a partnership, the replication groups enter a suspended state. Replication does to commence and the volumes are not available to user access. This does not happen with server to server replication.  
  
This is caused by a known issue in Windows Server 2016 Technical Preview. As a workaround, recreate the replication groups before adding them back to replication. If already in a suspended state, remove the partnership and recreate the replication groups.  
  
## SMB Multichannel not used with Storage Replica   
  
When replicating data with Storage Replica, SMB multichannel is not used, even when other SMB traffic shows use of multichannel on the same network interfaces.  
  
This is caused by a known issue in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]. As a workaround for using SMB mulitchannel with Storage Replica, configure Storage Replica network constraints for all NICs or RNICs that you want to replicate on. This issue will be fixed in a later release of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)].  
  
## Replication does not automatically resume after rebooting servers  
  
When replicating data with Storage Replica and rebooting the participating servers, they may fail to resume replication. The Storage Replica event logs show Warning 4004 with message **Failed to establish a connection to the remote computer** and Error 12000 with message **Computer account to security identifier (SID) conversion failed.** If you run the `(Get-SRGroup).replicas` cmdlet it shows ReplicationStatus as **ConnectingToSource** on the destination server. If you then manually restart the **Storage Replica** service, they immediately resume replicating.  
  
This is caused by a timing issue in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] where network conditions prevent access to a Domain Controller during the boot up phase. As a workaround, configure the **Storage Replica** service to have a startup type of **Automatic (Delayed Start)** using Services.msc, SC.exe, or Set-Service. This issue will be fixed in a later release of Windows Server 2016.  
  
## Running Test-SRTopology fails with error “Invalid value entered for target computer name”  
  
When attempting to use `Test-SRTopology`, you receive the following error:  
  
    WARNING: Invalid value entered for target computer name: sr-srv03. Test-SrTopology cmdlet does not accept IP address as  
    input for target computer name parameter. NetBIOS names and fully qualified domain names are acceptable inputs  
    WARNING: System.Exception  
    WARNING:    at Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand.BeginProcessing()  
    Test-SRTopology : Invalid value entered for target computer name: sr-srv03. Test-SrTopology cmdlet does not accept IP  
    address as input for target computer name parameter. NetBIOS names and fully qualified domain names are acceptable  
    inputs  
    At line:1 char:1  
    + Test-SRTopology -SourceComputerName sr-srv01 -SourceVolumeName d: -So ...  
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
        + CategoryInfo          : InvalidArgument: (:) [Test-SRTopology], Exception  
        + FullyQualifiedErrorId : TestSRTopologyFailure,Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand  
  
This cmdlet has limited error handing in Windows Server 2016 Technical Preview and will return the same output for many common issues. The error can appear for the following reasons:  
  
* You are logged on to the source computer as a local user, not a domain user.  
* The destination computer is not running or is not accessible over the network.  
* You specified an incorrect name for the destination computer.  
* You specified an IP address for the destination server.  
* The destination computer firewall is blocking access to PowerShell and/or CIM calls.  
* The destination computer is not running the WMI service.   
* You did not use CREDSSP when running the `Test-SRTopology` cmdlet remotely from a management computer.  
  
### Related Topics  
  
-   [Storage Replica in Windows Server 2016 Technical Preview](../Topic/Storage-Replica-in-Windows-Server-2016-Technical-Preview.md)  
-  [Stretch Cluster Replication Using Shared Storage](../Topic/Stretch-Cluster-Replication-Using-Shared-Storage.md)  
  
-   [Server to Server Storage Replication](../Topic/Server-to-Server-Storage-Replication.md)  
  
-   [Cluster to Cluster Storage Replication](../Topic/Cluster-to-Cluster-Storage-Replication.md)  
  
-   [Storage Replica: Frequently Asked Questions](../Topic/Storage-Replica--Frequently-Asked-Questions.md)  
  
## See Also  
  
-   [Storage Spaces Direct in Windows Server 2016 Technical Preview](../Topic/Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  
  
