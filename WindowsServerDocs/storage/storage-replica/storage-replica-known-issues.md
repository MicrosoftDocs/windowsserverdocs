---
description: Understand troubleshooting and known issues for Storage Replica in Windows Server
title: Known issues with Storage Replica
manager: candyc
ms.author: billy
ms.topic: troubleshooting
author: wbsmolen
ms.date: 05/31/2023
ms.assetid: ceddb0fa-e800-42b6-b4c6-c06eb1d4bc55
---

# Known Issues with Storage Replica

>Applies to: Azure Stack HCI, Windows Server 2022, Windows Server 2019, Windows Server 2016

This article describes some of the known issues with Storage Replica in Windows Server.

## Disks offline after removing replication and you can't configure replication

You may be unable to provision replication on a volume that was previously replicated or may find unmountable volumes. Disks can remain offline when replication isn't removed or when you reinstall the operating system on a computer that was previously replicating data.

To fix, you must clear the hidden Storage Replica partition off the disks and return them to a writeable state using the `Clear-SRMetadata` cmdlet.

- To remove all orphaned Storage Replica  partition databases slots and remount all partitions, use the `-AllPartitions` parameter as follows:

    ```powershell
    Clear-SRMetadata -AllPartitions
    ```

- To remove all orphaned Storage Replica log data, use the `-AllLogs` parameter as follows:

    ```powershell
    Clear-SRMetadata -AllLogs
    ```

- To remove all orphaned failover cluster configuration data, use the `-AllConfiguration` parameter as follows:

    ```powershell
    Clear-SRMetadata -AllConfiguration
    ```

- To remove individual replication group metadata, use the `-Name` parameter and specify a replication group as follows:

    ```powershell
    Clear-SRMetadata -Name RG01 -Logs -Partition
    ```

The server may need to restart after cleaning the partition database. You can prevent the server from rebooting temporarily with `-NoRestart` but you shouldn't skip restarting if requested by the cmdlet. This cmdlet doesn't remove data volumes nor data contained within those volumes.

## During initial sync, event ID 4004 warnings are seen in the event log

After configuring replication, during initial sync both the source and destination servers may show multiple warnings events with event ID 4004 in the **StorageReplica\Admin** event log. The event description shows the status "insufficient system resources exist to complete the API". You're likely to see 5014 errors as well. These events indicate that the servers don't have enough available memory (RAM) to perform both initial synchronization and run workloads. Either add RAM or reduce the used RAM from features and applications other than Storage Replica.

## Virtual machines stop responding after configuring in-guest replication

Virtual machines stop responding after you configure replication when using in-guest clustering and Storage Replica on a shared VHDX (not a cluster shared volume). If you restart the Hyper-V host, the virtual machines start responding, however the replication configuration won't be complete and no replication will occur.

This behavior occurs when you're using `fltmc.exe attach svhdxflt` to bypass the requirement for the Hyper-V host running a CSV. Use of this command isn't supported and is intended only for test and demonstration purposes.

The cause of the slowdown is an interoperability issue between Storage QoS  in Windows Server and the manually attached Shared VHDX filter. To resolve this issue, disable the Storage QoS filter driver and restart the Hyper-V host:

```Console
SC config storqosflt start= disabled
```

## Can't configure replication when using New-Volume and differing storage

When using the `New-Volume` cmdlet along with differing sets of storage on the source and destination server, such as two different SANs or two JBODs with differing disks, you may not be able to configure replication using `New-SRPartnership`. The error shown may include:

```Output
Data partition sizes are different in those two groups
```

Use the `New-Partition**` cmdlet to create volumes and format them instead of `New-Volume`, as the latter cmdlet may round the volume size on differing storage arrays. If you've already created an NTFS volume, you can use `Resize-Partition` to grow or shrink one of the volumes to match the other. You can't use this method with ReFS volumes. If using **Diskmgmt** or **Server Manager**, no rounding will occur.

## Running Test-SRTopology fails with name-related errors

When attempting to use `Test-SRTopology`, you receive one of the following errors:

**ERROR EXAMPLE 1:**

```Output
WARNING: Invalid value entered for target computer name: sr-srv03. Test-SrTopology cmdlet does not accept IP address as input for target computer name parameter. NetBIOS names and fully qualified domain names are acceptable inputs
WARNING: System.Exception
WARNING: at Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand.BeginProcessing()
Test-SRTopology : Invalid value entered for target computer name: sr-srv03. Test-SrTopology cmdlet does not accept IP address as input for target computer name parameter. NetBIOS names and fully qualified domain names are acceptable inputs
At line:1 char:1
+ Test-SRTopology -SourceComputerName sr-srv01 -SourceVolumeName d: -So ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : InvalidArgument: (:) [Test-SRTopology], Exception
+ FullyQualifiedErrorId : TestSRTopologyFailure,Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand
```

**ERROR EXAMPLE 2:**

```Output
WARNING: Invalid value entered for source computer name
```

**ERROR EXAMPLE 3:**

```Output
The specified volume cannot be found G: cannot be found on computer SRCLUSTERNODE1
```

This cmdlet has limited error reporting in Windows Server and will return the same output for many common issues. The error can appear for the following reasons:

- You're logged on to the source computer as a local user, not a domain user.

- The destination computer isn't running or isn't accessible over the network.

- You specified an incorrect name for the destination computer.

- You specified an IP address for the destination server.

- The destination computer firewall is blocking access to PowerShell and/or CIM calls.

- The destination computer isn't running the WMI service.

- You didn't use CREDSSP when running the `Test-SRTopology` cmdlet remotely from a management computer.

- The source or destination volume specified is a local disk on a cluster node, not a clustered disk.

## Configuring new Storage Replica partnership returns an error - "Failed to provision partition"

When attempting to create a new replication partnership with `New-SRPartnership`, you receive the following error:

```Output
New-SRPartnership : Unable to create replication group test01, detailed reason: Failed to provision partition ed0dc93f-107c-4ab4-a785-afd687d3e734.
At line: 1 char: 1
+ New-SRPartnership -SourceComputerName srv1 -SourceRGName test01
+ Categorylnfo : ObjectNotFound: (MSFT_WvrAdminTasks : root/ Microsoft/. . s) CNew-SRPartnership], CimException
+ FullyQua1ifiedErrorId : Windows System Error 1168 ,New-SRPartnership
```

You'll experience this error when selecting a data volume that is on the same partition as the system drive (that is, the *C:* drive with its Windows folder). For instance, on a drive that contains both the *C:* and *D:* volumes created from the same partition. Using a system drive isn't supported in Storage Replica; you must pick a different volume to replicate.

## Attempting to grow a replicated volume fails due to missing update

When attempting to grow or extend a replicated volume, you receive the following error:

```Output
Resize-Partition -DriveLetter d -Size 44GB
Resize-Partition : The operation failed with return code 8
At line:1 char:1
+ Resize-Partition -DriveLetter d -Size 44GB
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (StorageWMI:ROOT/Microsoft/.../MSFT_Partition
[Resize-Partition], CimException
+ FullyQualifiedErrorId : StorageWMI 8,Resize-Partition
```

If using the Disk Management MMC snap-in, you receive this error:

```Output
Element not found
```

You'll receive `The operation failed with return code 8` even if you correctly enable volume resizing on the source server using the command `Set-SRGroup -Name rg01 -AllowVolumeResize $TRUE`.

The issue was fixed in Cumulative Update for Windows 10, version 1607 (Anniversary Update) and Windows Server 2016: December 9, 2016 ([KB3201845](https://support.microsoft.com/help/3201845)).

## Attempting to grow a replicated volume fails due to missing step

If you attempt to resize a replicated volume on the source server without setting `-AllowResizeVolume $TRUE` first, you'll receive the following errors:

```Output
Resize-Partition -DriveLetter I -Size 8GB
Resize-Partition : Failed

Activity ID: {87aebbd6-4f47-4621-8aa4-5328dfa6c3be}
At line:1 char:1
+ Resize-Partition -DriveLetter I -Size 8GB
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (StorageWMI:ROOT/Microsoft/.../MSFT_Partition) [Resize-Partition], CimException
     + FullyQualifiedErrorId : StorageWMI 4,Resize-Partition

Storage Replica Event log error 10307:

Attempted to resize a partition that is protected by Storage Replica.

DeviceName: \Device\Harddisk1\DR1
PartitionNumber: 7
PartitionId: {b71a79ca-0efe-4f9a-a2b9-3ed4084a1822}

Guidance: To grow a source data partition, set the policy on the replication group containing the data partition.
```

```powershell
Set-SRGroup -ComputerName [ComputerName] -Name [ReplicationGroupName] -AllowVolumeResize $true
```

Before you grow the source data partition, ensure that the destination data partition has enough space to grow to an equal size. Shrinking of data partition protected by Storage Replica is blocked.

Disk Management Snap-in Error:

```Output
An unexpected error has occurred
```

After resizing the volume, remember to disable resizing with `Set-SRGroup -Name rg01 -AllowVolumeResize $FALSE`. This parameter prevents admins from attempting to resize volumes prior to ensuring that there's sufficient space on the destination volume, typically because they were unaware of Storage Replica's presence.

## Moving a physical disk resource between sites on an asynchronous stretch cluster fails

When attempting to move a physical disk resource (PDR) attached role in order to move the associated storage in an asynchronous stretch cluster, you receive an error. For example, trying moving a file server role to the asynchronous site.

If using the Failover Cluster Manager snap-in:

```Output
Error
The operation has failed.
The action 'Move' did not complete.
Error Code: 0x80071398
The operation failed because either the specified cluster node is not the owner of the group, or the node is not a possible owner of the group
```

If using the Cluster PowerShell cmdlet:

```powershell
Move-ClusterGroup -Name sr-fs-006 -Node sr-srv07
Move-ClusterGroup : An error occurred while moving the clustered role 'sr-fs-006'.
The operation failed because either the specified cluster node is not the owner of the group, or the node is not a possible owner of the group
At line:1 char:1
+ Move-ClusterGroup -Name sr-fs-006 -Node sr-srv07
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (:) [Move-ClusterGroup], ClusterCmdletException
+ FullyQualifiedErrorId : Move-ClusterGroup,Microsoft.FailoverClusters.PowerShell.MoveClusterGroupCommand
```

Use `Set-SRPartnership` to move these PDR disks in an asynchronous stretched cluster. The moved behavior has been changed beginning with Windows Server 2019 to allow manual and automated failovers with asynchronous replication, based on customer feedback.

## Attempting to add disks to a two-node asymmetric cluster returns "No disks suitable for cluster disks found"

When attempting to provision a cluster with only two nodes, prior to adding Storage Replica stretch replication, you attempt to add the disks in the second site to the Available Disks. You receive the following error:

```Output
No disks suitable for cluster disks found. For diagnostic information about disks available to the cluster, use the Validate a Configuration Wizard to run Storage tests.
```

You won't experience the error if you have at least three nodes in the cluster. To add the storage, you can run the following command on the node in the second site:

```powershell
Get-ClusterAvailableDisk -All | Add-ClusterDisk
```

The command won't work with node local storage. You can use Storage Replica to replicate a stretch cluster between two total nodes, **each one using its own set of shared storage.**

## Event ID 1241 warning repeated during initial sync

When specifying a replication partnership is asynchronous, the source computer repeatedly logs event ID 1241 warning events in the Storage Replica Admin channel. For example:

```Output
Log Name:      Microsoft-Windows-StorageReplica/Admin
Source:        Microsoft-Windows-StorageReplica
Date:          3/21/2017 3:10:41 PM
Event ID:      1241
Task Category: (1)
Level:         Warning
Keywords:      (1)
User:          SYSTEM
Computer:      sr-srv05.corp.contoso.com
Description:
The Recovery Point Objective (RPO) of the asynchronous destination is unavailable.

LocalReplicationGroupName: rg01
LocalReplicationGroupId: {e20b6c68-1758-4ce4-bd3b-84a5b5ef2a87}
LocalReplicaName: f:\
LocalPartitionId: {27484a49-0f62-4515-8588-3755a292657f}
ReplicaSetId: {1f6446b5-d5fd-4776-b29b-f235d97d8c63}
RemoteReplicationGroupName: rg02
RemoteReplicationGroupId: {7f18e5ea-53ca-4b50-989c-9ac6afb3cc81}
TargetRPO: 30
```

Event ID 1241, "The Recovery Point Objective (RPO) of the asynchronous destination is unavailable" is typically due to one of the following reasons:

- The asynchronous destination is currently disconnected. The RPO may become available after the connection is restored.

- The asynchronous destination is unable to keep pace with the source such that the most recent destination log record is no longer present in the source log. The destination will start block copying. The RPO should become available after block copying completes.

During initial sync, the event is expected behavior and can safely be ignored. The event behavior may change in a later release. If you see this behavior during ongoing asynchronous replication, investigate the partnership to determine why replication is delayed beyond your configured RPO (30 seconds, by default).

## Event ID 4004 warning repeated after rebooting a replicated node

Under rare circumstances, rebooting a server that is in a partnership leads to replication failing and the rebooted node logging event ID 4004 warning events with an access denied error.

```Output
Log Name:      Microsoft-Windows-StorageReplica/Admin
Source:        Microsoft-Windows-StorageReplica
Date:          3/21/2017 11:43:25 AM
Event ID:      4004
Task Category: (7)
Level:         Warning
Keywords:      (256)
User:          SYSTEM
Computer:      server.contoso.com
Description:
Failed to establish a connection to a remote computer.

RemoteComputerName: server
LocalReplicationGroupName: rg01
LocalReplicationGroupId: {a386f747-bcae-40ac-9f4b-1942eb4498a0}
RemoteReplicationGroupName: rg02
RemoteReplicationGroupId: {a386f747-bcae-40ac-9f4b-1942eb4498a0}
ReplicaSetId: {00000000-0000-0000-0000-000000000000}
RemoteShareName:{a386f747-bcae-40ac-9f4b-1942eb4498a0}.{00000000-0000-0000-0000-000000000000}
Status: {Access Denied}
A process has requested access to an object, but has not been granted those access rights.

Guidance: Possible causes include network failures, share creation failures for the remote replication group, or firewall settings. Make sure SMB traffic is allowed and there are no connectivity issues between the local computer and the remote computer. You should expect this event when suspending replication or removing a replication partnership.
```

Note the `Status: "{Access Denied}"` and the message `A process has requested access to an object, but has not been granted those access rights.` This is a known issue within Storage Replica and was fixed in Quality Update September 12, 2017 [KB4038782](https://support.microsoft.com/help/4038782) (OS Build 14393.1715).

## Error "Failed to bring the resource 'Cluster Disk x' online." with a stretch cluster

When attempting to bring a cluster disk online after a successful failover, where you're attempting to make the original source site primary again, you receive an error in Failover Cluster Manager. For example:

```Output
Error
The operation has failed.
Failed to bring the resource 'Cluster Disk 2' online.

Error Code: 0x80071397
The operation failed because either the specified cluster node is not the owner of the resource, or the node is not a possible owner of the resource.
```

If you attempt to move the disk or CSV manually, you receive another error. For example:

```Output
Error
The operation has failed.
The action 'Move' did not complete.

Error Code: 0x8007138d
A cluster node is not available for this operation
```

This issue is caused by one or more uninitialized disks being attached to one or more cluster nodes. To resolve the issue, initialize all attached storage using DiskMgmt.msc, DISKPART.EXE, or the `Initialize-Disk` PowerShell cmdlet.

We're working on providing an update that permanently resolves this issue. Contact Microsoft Support for more information.

## GPT error when attempting to create a new SR partnership

Running `New-SRPartnership` fails with the error:

```Output
Disk layout type for volume \\?\Volume{GUID}\ is not a valid GPT style layout.
New-SRPartnership : Unable to create replication group SRG01, detailed reason: Disk layout type for volume
\\?\Volume{GUID}\ is not a valid GPT style layout.
At line:1 char:1
+ New-SRPartnership -SourceComputerName nodesrc01 -SourceRGName SRG01 ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : NotSpecified: (MSFT_WvrAdminTasks:root/Microsoft/...T_WvrAdminTasks) [New-SRPartnership], CimException
+ FullyQualifiedErrorId : Windows System Error 5078,New-SRPartnership
```

In the Failover Cluster Manager GUI, there's no capability to set up replication for the disk.

Running `Test-SRTopology` fails with the following output:

```Output
WARNING: Object reference not set to an instance of an object.
WARNING: System.NullReferenceException
WARNING:    at Microsoft.FileServices.SR.Powershell.MSFTPartition.GetPartitionInStorageNodeByAccessPath(String AccessPath, String ComputerName, MIObject StorageNode)
    at Microsoft.FileServices.SR.Powershell.Volume.GetVolume(String Path, String ComputerName)
    at Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand.BeginProcessing()
Test-SRTopology : Object reference not set to an instance of an object.
At line:1 char:1
+ Test-SRTopology -SourceComputerName nodesrc01 -SourceVolumeName U: - ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : InvalidArgument: (:) [Test-SRTopology], NullReferenceException
+ FullyQualifiedErrorId : TestSRTopologyFailure,Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand
```

The error is caused by the cluster functional level still being set to Windows Server 2012 R2 (that is, FL 8). Storage Replica is supposed to return a specific error here but instead returns an incorrect error mapping.

From an elevated PowerShell session, run the following command on each node.

```powershell
Get-Cluster | fl *
```

If the `ClusterFunctionalLevel` attribute is `9` or higher, that is the version needed to implement Storage Replica. If `ClusterFunctionalLevel` isn't `9`, the `ClusterFunctionalLevel` will need to be updated in order to implement Storage Replica on this node.

To resolve the issue, raise the cluster functional level by running the PowerShell cmdlet: [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/update-clusterfunctionallevel).

## Small unknown volume listed in DISKMGMT for each replicated volume

When running the Disk Management snap-in (DISKMGMT.MSC), you notice one or more volumes listed with no label or drive letter and 1 MB in size. You may be able to delete the unknown volume or you may receive:

```Output
An Unexpected Error has Occurred
```

The message above is expected behavior and is by design. The listed items aren't volumes, but are partitions. Storage Replica creates a 512-KB partition as a database slot for replication operations (the legacy DiskMgmt.msc tool rounds to the nearest MB). Having a partition like this for each replicated volume is normal and desirable. Once the disk is no longer used by Storage Replica, you're free to delete this 512-KB partition; in-use partitions can't be deleted. The partition will never grow or shrink. If you're recreating replication, we recommend leaving the partition as Storage Replica will claim unused ones.

To view details, use the DISKPART tool or `Get-Partition` cmdlet. These partitions will have a GPT Type of `558d43c5-a1ac-43c0-aac8-d1472b2923d1`.

## A Storage Replica node hangs when creating snapshots

Creating a VSS snapshot (through backup, VSSADMIN, etc.) causes a Storage Replica node hangs, you must force a restart of the node to recover. There's no error, just a hard hang of the server.

This issue occurs when you create a VSS snapshot of the log volume. The underlying cause is a legacy design aspect of VSS, not Storage Replica. The resulting behavior when you snapshot the Storage Replica log volume is a VSS I/O queuing mechanism deadlocks the server.

To prevent this behavior, don't snapshot Storage Replica log volumes. There's no need to snapshot Storage Replica log volumes, as these logs can't be restored. Furthermore, the log volume should never contain any other workloads, so no snapshot is needed in general.

## High IO latency when using Storage Spaces Direct with Storage Replica

When using Storage Spaces Direct with an NVMe (nonvolatile memory express) device or SSD (solid-state drive) cache, you see a greater than expected increase in latency when configuring Storage Replica replication between Storage Spaces Direct clusters. The change in latency is proportionally much higher than you see when using NVMe and SSD in a performance + capacity configuration and no HDD tier nor capacity tier.

This issue occurs due to architectural limitations within Storage Replica's log mechanism combined with the low latency of NVMe when compared to slower media. With Storage Spaces Direct cache, all I/O of Storage Replica logs, along with all recent read/write IO of applications, will occur in the cache and never on the performance or capacity tiers. Meaning that all Storage Replica activity happens on the same speed media - the configuration is supported but not recommended (see [Frequently asked questions about Storage Replica](storage-replica-frequently-asked-questions.yml) for log recommendations).

When using Storage Spaces Direct with HDDs, you can't disable or avoid the cache. As a workaround, if using just SSD and NVMe, you can configure just performance and capacity tiers. If using that configuration, and by placing the SR logs on the performance tier only with the data volumes they service being on the capacity tier only, you'll avoid the high latency issue described above. The same could be done with a mix of faster and slower SSDs and no NVMe.

This workaround isn't ideal and some customers may not be able to make use of it. The Storage Replica team is working on optimizations and an updated log mechanism for the future to reduce these artificial bottlenecks. This v1.1 log first became available in Windows Server 2019 and its improved performance is described in on the [Server Storage Blog](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB).

## Error "Could not find file" when running Test-SRTopology between two clusters

Running `Test-SRTopology` between two clusters and their CSV paths fails with the error:

```Output
Validating data and log volumes...
Measuring Storage Replica recovery and initial synchronization performance...
WARNING: Could not find file '\\SERVER01\C$\CLUSTERSTORAGE\VOLUME1TestSRTopologyRecoveryTest\SRRecoveryTestFile01.txt'.
WARNING: System.IO.FileNotFoundException
WARNING:    at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost) at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share, Int32 bufferSize, FileOptions options) at Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand.GenerateWriteIOWorkload(String Path, UInt32 IoSizeInBytes, UInt32 Parallel IoCount, UInt32 Duration)at Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand.<>c__DisplayClass75_0.<PerformRecoveryTest>b__0()at System.Threading.Tasks.Task.Execute()
Test-SRTopology : Could not find file '\\SERVER01\C$\CLUSTERSTORAGE\VOLUME1TestSRTopologyRecoveryTest\SRRecoveryTestFile01.txt'.
At line:1 char:1
+ Test-SRTopology -SourceComputerName ClusterA -SourceVolumeName  ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : ObjectNotFound: (:) [Test-SRTopology], FileNotFoundException
+ FullyQualifiedErrorId : TestSRTopologyFailure,Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand
```

The error shown in the example is caused by a known code defect in Windows Server 2016. This issue was fixed in Windows Server 2019 and the associated RSAT tools. For a downlevel resolution, contact Microsoft Support. There's no workaround.

## Error "specified volume couldn't be found" when running Test-SRTopology between two clusters

Running `Test-SRTopology` between two clusters and their CSV paths fail with error:

```Output
Test-SRTopology : The specified volume C:\ClusterStorage\Volume1 cannot be found on computer RRN44-14-09. If this is a cluster node, the volume must be part of a role or CSV; volumes in Available Storage are not accessible
At line:1 char:1
+ Test-SRTopology -SourceComputerName RRN44-14-09 -SourceVolumeName C:\ ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (:) [Test-SRTopology], Exception
    + FullyQualifiedErrorId : TestSRTopologyFailure,Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand
```

When specifying the source node CSV as the source volume, you must select the node that owns the CSV. You can either move the CSV to the specified node or change the node name you specified in `-SourceComputerName`. An improved message was introduced beginning with Windows Server 2019.

## Unable to access the data drive in Storage Replica after unexpected reboot when BitLocker is enabled

If BitLocker is enabled on both drives (the Log Drive and Data Drive), the Primary Server reboots then you're unable to access the Primary Drive even after unlocking the Log Drive from BitLocker.

To recover the data or access the drive, you need to unlock the log drive first, and then open Diskmgmt.msc to locate the data drive. Mark the data drive offline and online again. Locate the BitLocker icon on the drive and unlock the drive.

## Issue unlocking the Data drive on secondary server after breaking the Storage Replica partnership

After disabling the SR Partnership and removing the Storage Replica partnership, it's expected if you're unable to unlock the Secondary Server's Data drive with its respective password or key.

You need to use key or password of primary server's data drive to unlock the secondary server's data drive.

## Test Failover doesn't mount when using asynchronous replication

Running `Mount-SRDestination` to bring a destination volume online as part of  Test Failover fails with error:

```Output
Mount-SRDestination: Unable to mount SR group <TEST>, detailed reason: The group or resource is not in the correct state to perform the supported operation.
    At line:1 char:1
    + Mount-SRDestination -ComputerName SRV1 -Name TEST -TemporaryP . . .
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : NotSpecified: (MSFT WvrAdminTasks : root/Microsoft/...(MSFT WvrAdminTasks : root/Microsoft/. T_WvrAdminTasks) (Mount-SRDestination], CimException
        + FullyQua1ifiedErrorId : Windows System Error 5823, Mount-SRDestination.
```

If using a synchronous partnership type, test failover works normally.

There's a known code defect in Windows Server, version 1709, which caused this error shown. To resolve this issue, install the [October 18, 2018 update](https://support.microsoft.com/help/4462932/windows-10-update-kb4462932). This issue isn't present in Windows Server 2019 and newer.

## Unable to set up Storage Replica with physical sector sizes greater than 4K

Storage Replica does not support disks with physical sector sizes greater than 4K today. We are exploring implementing this feature in future releases.

Please see [this document](/troubleshoot/sql/database-engine/database-file-operations/troubleshoot-os-4kb-disk-sector-size#resolutions) for more information & workarounds.

## Next steps

Now you understand some of the known issues with Storage Replica in Windows Servers, here are some articles that might help you as you use it.

- [Storage Replica](storage-replica-overview.md)
- [Stretch Cluster Replication Using Shared Storage](stretch-cluster-replication-using-shared-storage.md)
- [Server to Server Storage Replication](server-to-server-storage-replication.md)
- [Cluster to Cluster Storage Replication](cluster-to-cluster-storage-replication.md)
- [Storage Replica: Frequently Asked Questions](storage-replica-frequently-asked-questions.yml)
- [Storage Spaces Direct](/azure-stack/hci/concepts/storage-spaces-direct-overview)
