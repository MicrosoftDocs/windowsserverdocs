---
title: Known Issues with Storage Replica
ms.prod: windows-server-threshold
manager: dongill
ms.author: JGerend
ms.technology: storage-replica
ms.topic: get-started-article
author: kumudd
ms.date: 10/06/2016
ms.assetid: ceddb0fa-e800-42b6-b4c6-c06eb1d4bc55
---
# Known Issues with Storage Replica

>Applies To: Windows Server 2016

This section discusses known issues with Storage Replica in Windows Server 2016.  

## After removing replication, disks are offline and you cannot configure replication again  
In Windows Server 2016, you may be unable to provision replication on a volume that was previously replicated or may find un-mountable volumes. This may occur when some error condition prevents removal of replication or when you reinstall the operating system on a computer that was previously replicating data.  

To fix, you must clear the hidden Storage Replica partition off the disks and return them to a writeable state using the `Clear-SRMetadata` cmdlet.  

-   To remove all orphaned Storage Replica  partition databases slots and remount all partitions, use the `-AllPartitions` parameter as follows:  

    ```  
    Clear-SRMetadata -AllPartitions  
    ```  

-   To remove all orphaned Storage Replica log data, use the `-AllLogs` parameter as follows:  

    ```  
    Clear-SRMetadata -AllLogs  
    ```  

-   To remove all orphaned failover cluster configuration data, use the `-AllConfiguration` parameter as follows:  

    ```  
    Clear-SRMetadata -AllConfiguration  
    ```  

-   To remove individual replication group metadata, use the `-Name` parameter and specify a replication group as follows:  

    ```  
    Clear-SRMetadata -Name RG01 -Logs -Partition  
    ```  

The server may need to restart after cleaning the partition database; you can suppress this temporarily with `-NoRestart` but you should not skip restarting the server if requested by the cmdlet. This cmdlet does not remove data volumes nor data contained within those volumes.  

## During initial sync, see event log 4004 warnings  
In Windows Server 2016, when configuring replication, both the source and destination servers may show multiple **StorageReplica\Admin** event log 4004 warnings each during initial sync, with a status of "insufficient system resources exist to complete the API". You are likely to see 5014 errors as well. These indicate that the servers do not have enough available memory (RAM) to perform both initial synchronization as well as run workloads. Either add RAM or reduce the used RAM from features and applications other than Storage Replica.  

## When using guest clusters with Shared VHDX and a host without a CSV, virtual machines stop responding after configuring replication  
In Windows Server 2016, when using Hyper-V guest clusters for Storage Replica testing or demonstration purposes, and using Shared VHDX as the guest cluster storage, the virtual machines stop responding after you configure replication. If you restart the Hyper-V host, the virtual machines start responding but replication configuration will not be complete and no replication will occur.  

This behavior occurs when you are using **fltmc.exe attach svhdxflt** to bypass the requirement for the Hyper-V host running a CSV. Use of this command is not supported and is intended only for test and demonstration purposes.  

The cause of the slowdown is a by-design interoperability issue between the Storage QoS feature in Windows Server 2016 and the manually attached Shared VHDX filter. To resolve this issue, disable the Storage QoS filter driver and restart the Hyper-V host:  

```  
SC config storqosflt start= disabled  
```  

## Cannot configure replication when using New-Volume and differing storage  
When using the `New-Volume` cmdlet along with differing sets of storage on the source and destination server, such as two different SANs or two JBODs with differing disks, you may not be able to subsequently configure replication using `New-SRPartnership`. The error shown may include:  

    Data partition sizes are different in those two groups  

Use the `New-Partition**` cmdlet to create volumes and format them instead of `New-Volume`, as the latter cmdlet may round the volume size on differing storage arrays. If you have already created an NTFS volume, you can use `Resize-Partition` to grow or shrink one of the volumes to match the other (this cannot be done with ReFS volumes). If using **Diskmgmt** or **Server Manager**, no rounding will occur.  

## Running Test-SRTopology fails with name-related errors

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

**ERROR EXAMPLE 3:**

    The specified volume cannot be found G: cannot be found on computer SRCLUSTERNODE1

This cmdlet has limited error reporting in Windows Server 2016 and will return the same output for many common issues. The error can appear for the following reasons:  

* You are logged on to the source computer as a local user, not a domain user.  
* The destination computer is not running or is not accessible over the network.  
* You specified an incorrect name for the destination computer.  
* You specified an IP address for the destination server.  
* The destination computer firewall is blocking access to PowerShell and/or CIM calls.  
* The destination computer is not running the WMI service.   
* You did not use CREDSSP when running the `Test-SRTopology` cmdlet remotely from a management computer.
* The source or destination volume specified are local disks on a cluster node, not clustered disks.  

## Configuring new Storage Replica partnership returns an error - "Failed to provision partition"
When attempting to create a new replication partnership with `New-SRPartnership`, you receive the following error:

    New-SRPartnership : Unable to create replication group test01, detailed reason: Failed to provision partition ed0dc93f-107c-4ab4-a785-afd687d3e734.
    At line: 1 char: 1
    + New-SRPartnership -SourceComputerName srv1 -SourceRGName test01
    + Categorylnfo : ObjectNotFound: (MSFT_WvrAdminTasks : root/ Microsoft/. . s) CNew-SRPartnership], CimException
    + FullyQua1ifiedErrorId : Windows System Error 1168 ,New-SRPartnership

This is caused by selecting a data volume that is on the same partition as the System Drive (i.e. the **C:** drive with its Windows folder). For instance, on a drive that contains both the **C:** and **D:** volumes created from the same partition. This is not supported in Storage Replica; you must pick a different volume to replicate.

## Attempting to grow a replicated volume fails
When attempting to grow or tended a replicated volume, you receive the following error:

    PS C:\> Resize-Partition -DriveLetter d -Size 44GB
    Resize-Partition : The operation failed with return code 8
    At line:1 char:1
    + Resize-Partition -DriveLetter d -Size 44GB
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (StorageWMI:ROOT/Microsoft/.../MSFT_Partition
    [Resize-Partition], CimException
    + FullyQualifiedErrorId : StorageWMI 8,Resize-Partition

If using the DISKMGMT.MSC snapin, you receive error: 

    Element not found

This occurs even if you correctly enable volume resizing using `Set-SRGroup -Name rg01 -AllowVolumeResize $true`.  This issue is caused by a code defect in the RTM version fo Windows Server 2016. A cumulative update packge will be issued to resolve this problem. For more information, email srfeed@microsoft.com. 

## See also  
- [Storage Replica](storage-replica-overview.md)  
- [Stretch Cluster Replication Using Shared Storage](stretch-cluster-replication-using-shared-storage.md)  
- [Server to Server Storage Replication](server-to-server-storage-replication.md)  
- [Cluster to Cluster Storage Replication](cluster-to-cluster-storage-replication.md)  
- [Storage Replica: Frequently Asked Questions](storage-replica--frequently-asked-questions.md)  
- [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md)  
