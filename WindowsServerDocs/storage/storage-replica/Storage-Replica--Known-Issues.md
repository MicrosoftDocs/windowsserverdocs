---
title: Known Issues with Storage Replica
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
# Known Issues with Storage Replica

>Applies To: Windows Server Technical Preview

This section discusses known issues with Storage Replica in Windows Server 2016 Technical Preview.  

## After removing replication, disks are offline and you cannot configure replication again  
In Windows Server 2016 Technical Preview, you may be unable to provision replication on a volume that was previously replicated or may find un-mountable volumes. This may occur when some error condition prevents removal of replication or when you reinstall the operating system on a computer that was previously replicating data.  

To fix, you must clear the hidden Storage Replica partition off the disks and return them to a writeable state. Previously this required complex **DISKPART** steps but Windows Server 2016 Technical Preview introduces a simple cmdlet named `Clear-SRMetadata`.  

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
In Windows Server 2016 Technical Preview, when configuring replication, both the source and destination servers may show multiple **StorageReplica\Admin** event log 4004 warnings each during initial sync, with a status of “insufficient system resources exist to complete the API”. You are likely to see 5014 errors as well. These indicate that the servers do not have enough physical memory (RAM) to perform both initial synchronization as well as run workloads. Either add RAM or reduce the used RAM from features and applications other than Storage Replica.  

## When using guest clusters with Shared VHDX and a host without a CSV, virtual machines stop responding after configuring replication  
In Windows Server 2016 Technical Preview, when using Hyper-V guest clusters for Storage Replica testing or demonstration purposes, and using Shared VHDX as the guest cluster storage, the virtual machines stop responding after you configure replication. If you restart the Hyper-V host, the virtual machines start responding but replication configuration will not be complete and no replication will occur.  

This behavior occurs when you are using **fltmc.exe attach svhdxflt** to bypass the requirement for the Hyper-V host running a CSV. Use of this command is not supported and is intended only for test and demonstration purposes.  

The cause of the slowdown is a by-design interoperability issue between the new Storage QoS feature in Windows Server 2016 Technical Preview and the manually attached Shared VHDX filter. To resolve this issue, disable the Storage QoS filter driver and restart the Hyper-V host:  

```  
SC config storqosflt start= disabled  
```  

## Removing disks from Available Storage prevents them from use again  
In Windows Server 2016 Technical Preview, when using Failover Cluster Manager to remove available storage asymmetric shared disks, you can no longer add some of them back later. They do not appear in the **Add Disks** view.  

Use `Clear-ClusterDiskReservation` to make these disks eligible to Available Storage. To prevent the issue, only remove disks when they show as Online and owned by the cluster nodes that physically attach to them.  

## Cannot configure replication when using New-Volume and differing storage  
When using the `New-Volume` cmdlet along with differing sets of storage on the source and destination server, such as two different SANs or two JBODs with differing disks, you may not be able to subsequently configure replication using `New-SRPartnership`. The error shown may include:  

    Data partition sizes are different in those two groups  

Use the `New-Partition**` cmdlet to create volumes and format them instead of `New-Volume`, as the latter cmdlet may round the volume size on differing storage arrays. If you have already created an NTFS volume, you can use `Resize-Partition` to grow or shrink one of the volumes to match the other (this cannot be done with ReFS volumes). If using **Diskmgmt** or **Server Manager**, no rounding will occur.  

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

This is caused by a known issue in Windows Server 2016 Technical Preview. As a workaround for using SMB mulitchannel with Storage Replica, configure Storage Replica network constraints for all NICs or RNICs that you want to replicate on. This issue will be fixed in a later release of Windows Server 2016 Technical Preview.  

## Replication does not automatically resume after rebooting servers  

When replicating data with Storage Replica and rebooting the participating servers, they may fail to resume replication. The Storage Replica event logs show Warning 4004 with message **Failed to establish a connection to the remote computer** and Error 12000 with message **Computer account to security identifier (SID) conversion failed.** If you run the `(Get-SRGroup).replicas` cmdlet it shows ReplicationStatus as **ConnectingToSource** on the destination server. If you then manually restart the **Storage Replica** service, they immediately resume replicating.  

This is caused by a timing issue in Windows Server 2016 Technical Preview where network conditions prevent access to a Domain Controller during the boot up phase. As a workaround, configure the **Storage Replica** service to have a startup type of **Automatic (Delayed Start)** using Services.msc, SC.exe, or Set-Service. This issue will be fixed in a later release of Windows Server 2016.  

## Running Test-SRTopology fails with errors “Invalid value entered for target computer name” or "Invalid value entered for source computer name"  

When attempting to use `Test-SRTopology`, you receive one of the following errors:  

**ERROR EXAMPLE 1:**

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

**ERROR EXAMPLE 2:**

    WARNING: Invalid value entered for source computer name

This cmdlet has limited error handling in Windows Server 2016 Technical Preview and will return the same output for many common issues. The error can appear for the following reasons:  

* You are logged on to the source computer as a local user, not a domain user.  
* The destination computer is not running or is not accessible over the network.  
* You specified an incorrect name for the destination computer.  
* You specified an IP address for the destination server.  
* The destination computer firewall is blocking access to PowerShell and/or CIM calls.  
* The destination computer is not running the WMI service.   
* You did not use CREDSSP when running the `Test-SRTopology` cmdlet remotely from a management computer.  

## Attempting to move a cluster group returns an error
When using Failover Cluster Manager to move a group like File Server for General Use between asynchronously replicated sites, you receive the following error:

**The operation failed because either the specified cluster node is not the owner of the group, or the node is not a possible owner of the group**.

The same issue occurs with `Move-ClusterGroup`. Furthermore, automatic failover does not occur when using an asynchronously stretched cluster. You do not have this problem when attempting to move synchronously replicated storage between sites, or, when moving the group between servers in the same site, where replication direction does not change. This problem does not occur in server to server or cluster to cluster scenarios.

This is caused by a known issue in Windows Server 2016 Technical Preview. As a workaround, use `Set-SRPartnership` to switch the replication direction and move the role. You may receive an error here. Ignore it, and note that the switch does occur without issue.

## Configuring new Storage Replica partnership returns an error - "Failed to provision partition"
When attempting to create a new replication partnership with `New-SRPartnership`, you receive the following error:

    New-SRPartnership : Unable to create replication group test01, detailed reason: Failed to provision partition ed0dc93f-107c-4ab4-a785-afd687d3e734.
    At line: 1 char: 1
    + New-SRPartnership -SourceComputerName srv1 -SourceRGName test01
    + Categorylnfo : ObjectNotFound: (MSFT_WvrAdminTasks : root/ Microsoft/. . s) CNew-SRPartnership], CimException
    + FullyQua1ifiedErrorId : Windows System Error 1168 ,New-SRPartnership

This is caused by selecting a data volume that is on the same partition as the System Drive (i.e. the **C:** drive with its Windows folder). For instance, on a drive that contains both the **C:** and **D:** volumes created from the same partition. This is not supported in Storage Replica; you must pick a different volume to replicate.


### Related Topics  

-   [Storage Replica in Windows Server 2016 Technical Preview](Storage-Replica-in-Windows-Server-2016-Technical-Preview.md)  
-  [Stretch Cluster Replication Using Shared Storage](Stretch-Cluster-Replication-Using-Shared-Storage.md)  

-   [Server to Server Storage Replication](Server-to-Server-Storage-Replication.md)  

-   [Cluster to Cluster Storage Replication](Cluster-to-Cluster-Storage-Replication.md)  

-   [Storage Replica: Frequently Asked Questions](Storage-Replica--Frequently-Asked-Questions.md)  

## See Also  

-   [Storage Spaces Direct in Windows Server 2016 Technical Preview](../storage-spaces/Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  

