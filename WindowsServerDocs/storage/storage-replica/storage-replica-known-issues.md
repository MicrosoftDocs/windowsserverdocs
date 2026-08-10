---
title: Storage Replica Known Issues
description: Review known issues with Storage Replica in Windows Server and how to resolve them.
ms.author: roharwoo
ms.topic: troubleshooting
author: robinharwood
ms.date: 05/31/2023
---

# Known issues in Storage Replica

This article describes some of the known issues with Storage Replica in Windows Server.

## Disks are offline after you remove replication, and you can't set up replication

You might be unable to provision replication on a volume that was previously replicated, or you might find unmountable volumes. Disks can remain offline when replication isn't removed or when you reinstall the operating system on a computer that was previously replicating data.

To resolve the issue, clear the hidden Storage Replica partition from the disks and return them to a writeable state by using the `Clear-SRMetadata` cmdlet.

- To remove all orphaned Storage Replica partition database slots and remount all partitions, use the `-AllPartitions` parameter:

    ```powershell
    Clear-SRMetadata -AllPartitions
    ```

- To remove all orphaned Storage Replica log data, use the `-AllLogs` parameter:

    ```powershell
    Clear-SRMetadata -AllLogs
    ```

- To remove all orphaned failover cluster configuration data, use the `-AllConfiguration` parameter:

    ```powershell
    Clear-SRMetadata -AllConfiguration
    ```

- To remove individual replication group metadata, use the `-Name` parameter and specify a replication group:

    ```powershell
    Clear-SRMetadata -Name RG01 -Logs -Partition
    ```

The server might need to restart after you clean the partition database. You can temporarily prevent the server from restarting by using the `-NoRestart` parameter, but you shouldn't skip restarting if the cmdlet prompts a restart. This cmdlet doesn't remove data volumes or data contained within those volumes.

## During initial sync, event ID 4004 warnings appear in the event log

During initial sync after you configure replication, both the source and the destination servers might show multiple warning events with event ID 4004 in the `StorageReplica\Admin` event log. The event description shows the status "insufficient system resources exist to complete the API." You likely also see event ID 5014 errors. These events indicate that the servers don't have enough available memory (RAM) to both perform initial synchronization and run workloads. Either add RAM or reduce the used RAM from features and applications other than Storage Replica.

## Configure in-guest replication: Virtual machines stop responding

Virtual machines stop responding after you configure replication when you use in-guest clustering and Storage Replica on a shared Virtual Hard Disk v2 (VHDX), and not on a cluster shared volume (CSV). If you restart the Hyper-V host, the virtual machines start responding, but the replication configuration isn't complete, and no replication occurs.

This scenario happens if you use `fltmc.exe attach svhdxflt` to bypass the requirement for the Hyper-V host running a CSV. This command isn't supported and is intended only for test and demonstration purposes.

The cause of the slowdown is an interoperability issue between Storage Quality of Service (Storage QoS) in Windows Server and the manually attached shared VHDX filter.

To resolve this issue, disable the Storage QoS filter driver and restart the Hyper-V host:

```console
SC config storqosflt start= disabled
```

## Configure replication by using New-Volume and differing storage

When you use the `New-Volume` cmdlet with differing sets of storage on the source and destination server, such as two different SANs or two JBODs with differing disks, you might not be able to configure replication using the `New-SRPartnership` cmdlet.

The error that's shown might include this output:

```output
Data partition sizes are different in those two groups
```

Use the `New-Partition` cmdlet instead of `New-Volume` to create volumes and format them. The `New-Volume` cmdlet might round the volume size on differing storage arrays. If you already created a New Technology File System (NTFS) volume, you can use `Resize-Partition` to grow or shrink one of the volumes to match the other. You can't use this method with Resilient File System (ReFS) volumes. If you use Diskmgmt or Server Manager, no rounding occurs.

## Test-SRTopology fails with name-related errors

When you attempt to use `Test-SRTopology`, one of the following errors occurs:

**ERROR EXAMPLE 1:**

```output
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

```output
WARNING: Invalid value entered for source computer name
```

**ERROR EXAMPLE 3:**

```output
The specified volume cannot be found G: cannot be found on computer SRCLUSTERNODE1
```

This cmdlet has limited error reporting in Windows Server and returns the same output for many common issues. The error can appear for the following reasons:

- You're logged on to the source computer as a local user, not a domain user.

- The destination computer isn't running or isn't accessible over the network.

- You specified an incorrect name for the destination computer.

- You specified an IP address for the destination server.

- The destination computer firewall is blocking access to PowerShell and/or CIM calls.

- The destination computer isn't running the WMI service.

- You didn't use CREDSSP when running the `Test-SRTopology` cmdlet remotely from a management computer.

- The source or destination volume specified is a local disk on a cluster node, not a clustered disk.

## Configure a new partnership fails: "Failed to provision partition"

When you attempt to create a new replication partnership by using `New-SRPartnership`, the following error occurs:

```output
New-SRPartnership : Unable to create replication group test01, detailed reason: Failed to provision partition ed0dc93f-107c-4ab4-a785-afd687d3e734.
At line: 1 char: 1
+ New-SRPartnership -SourceComputerName srv1 -SourceRGName test01
+ Categorylnfo : ObjectNotFound: (MSFT_WvrAdminTasks : root/ Microsoft/. . s) CNew-SRPartnership], CimException
+ FullyQua1ifiedErrorId : Windows System Error 1168 ,New-SRPartnership
```

You experience this error when you select a data volume that is on the same partition as the system drive (that is, on `C:` with the Windows folder). For example, on a drive that contains both the `C:` and `D:` volumes created from the same partition. Using a system drive isn't supported in Storage Replica. In this scenario, you must choose a different volume to replicate.

## Extend a replicated volume fails because of a missing update

You attempt to grow or extend a replicated volume, and this error occurs:

```output
Resize-Partition -DriveLetter d -Size 44GB
Resize-Partition : The operation failed with return code 8
At line:1 char:1
+ Resize-Partition -DriveLetter d -Size 44GB
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (StorageWMI:ROOT/Microsoft/.../MSFT_Partition
[Resize-Partition], CimException
+ FullyQualifiedErrorId : StorageWMI 8,Resize-Partition
```

You use the Disk Management MMC snap-in, and this error occurs:

```output
Element not found
```

The error message "The operation failed with return code 8" appears, even if you correctly enable volume resizing on the source server by using the command `Set-SRGroup -Name rg01 -AllowVolumeResize $TRUE`.

The issue was fixed in Cumulative Update for Windows 10 version 1607 (Anniversary Update) and Windows Server 2016: December 9, 2016 ([KB3201845](https://support.microsoft.com/help/3201845)).

## Extend a replicated volume fails because of a missing step

You attempt to resize a replicated volume on the source server without setting `-AllowResizeVolume $TRUE` first, and this error occurs:

```output
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

```output
An unexpected error has occurred
```

After you resize the volume, remember to disable resizing by running `Set-SRGroup -Name rg01 -AllowVolumeResize $FALSE`. This parameter prevents admins from attempting to resize volumes before they ensure that there's sufficient space on the destination volume, typically because they're unaware that Storage Replica is in use.

## Move a physical disk resource between sites on an asynchronous stretch cluster

You attempt to move a physical disk resource (PDR) attached role to move the associated storage in an asynchronous stretch cluster, and an error occurs. For example, you tried to move a file server role to the asynchronous site.

If you use the Failover Cluster Manager snap-in:

```output
Error
The operation has failed.
The action 'Move' did not complete.
Error Code: 0x80071398
The operation failed because either the specified cluster node is not the owner of the group, or the node is not a possible owner of the group
```

If you use the `Cluster` PowerShell cmdlet:

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

Use the `Set-SRPartnership` cmdlet to move these PDR disks in an asynchronous stretched cluster. Based on customer feedback, the moved behavior changed beginning with Windows Server 2019 to allow manual and automated failovers with asynchronous replication.

## Add disks to a two-node asymmetric cluster: "No disks suitable for cluster disks found"

To provision a cluster that has only two nodes, before you add Storage Replica stretch replication, you attempt to add the disks in the second site to the available disks. The following error occurs:

```output
No disks suitable for cluster disks found. For diagnostic information about disks available to the cluster, use the Validate a Configuration Wizard to run Storage tests.
```

You won't experience the error if you have at least three nodes in the cluster. To add the storage, you can run the following command on the node in the second site:

```powershell
Get-ClusterAvailableDisk -All | Add-ClusterDisk
```

The command doesn't work with node local storage. You can use Storage Replica to replicate a stretch cluster between two total nodes, *each one using its own set of shared storage*.

## Event ID 1241 warning repeats during initial sync

You specify that a replication partnership is asynchronous, and the source computer repeatedly logs event ID 1241 warning events in the Storage Replica Admin channel. For example:

```output
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

Event ID 1241, "The Recovery Point Objective (RPO) of the asynchronous destination is unavailable," typically occurs for one of the following reasons:

- The asynchronous destination is currently disconnected. The RPO might become available after the connection is restored.

- The asynchronous destination can't keep pace with the source, so the most recent destination log record is no longer present in the source log. The destination begins block copying. The RPO should become available after block copying completes.

During initial sync, this event is expected and can be safely ignored. The event behavior might change in a later release. If you see this behavior during ongoing asynchronous replication, investigate the partnership to determine why replication is delayed beyond your configured RPO (30 seconds by default).

## Event ID 4004 warning repeats after you restart a replicated node

Under rare circumstances, restarting a server that is in a partnership leads to replication failing. The restarted node logs event ID 4004 as a warning event, with an "access denied" error.

```output
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

Note `Status: "{Access Denied}"` and the message `A process has requested access to an object, but has not been granted those access rights.` This is a known issue within Storage Replica and was fixed in Quality Update September 12, 2017 [KB4038782](https://support.microsoft.com/help/4038782) (OS Build 14393.1715).

## Error "Failed to bring the resource 'Cluster Disk x' online" with a stretch cluster

To bring a cluster disk online after a successful failover, you attempt to make the original source site the primary again, and an error occurs in Failover Cluster Manager.

For example:

```output
Error
The operation has failed.
Failed to bring the resource 'Cluster Disk 2' online.

Error Code: 0x80071397
The operation failed because either the specified cluster node is not the owner of the resource, or the node is not a possible owner of the resource.
```

If you attempt to move the disk or CSV manually, another error occurs. For example:

```output
Error
The operation has failed.
The action 'Move' did not complete.

Error Code: 0x8007138d
A cluster node is not available for this operation
```

This issue occurs when one or more uninitialized disks are attached to one or more cluster nodes. To resolve the issue, initialize all attached storage by using `DiskMgmt.msc`, `DiskPart.exe`, or the `Initialize-Disk` PowerShell cmdlet.

We're working on providing an update that permanently resolves this issue. For more information, contact Microsoft Support.

## GPT error when you attempt to create a new Storage Replica partnership

You run the `New-SRPartnership` cmdlet, but it fails and shows this error:

```output
Disk layout type for volume \\?\Volume{GUID}\ is not a valid GPT style layout.
New-SRPartnership : Unable to create replication group SRG01, detailed reason: Disk layout type for volume
\\?\Volume{GUID}\ is not a valid GPT style layout.
At line:1 char:1
+ New-SRPartnership -SourceComputerName nodesrc01 -SourceRGName SRG01 ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : NotSpecified: (MSFT_WvrAdminTasks:root/Microsoft/...T_WvrAdminTasks) [New-SRPartnership], CimException
+ FullyQualifiedErrorId : Windows System Error 5078,New-SRPartnership
```

You can't set up replication for the disk by using Failover Cluster Manager.

You run the `Test-SRTopology` cmdlet, but it fails and shows the following output:

```output
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

The error occurs because the cluster functional level is still set to Windows Server 2012 R2 (that is, FL 8). Storage Replica is supposed to return a specific error here, but instead, it returns an incorrect error mapping.

In a PowerShell session with administrator permissions, run the following command on each node:

```powershell
Get-Cluster | fl *
```

If the `ClusterFunctionalLevel` attribute is `9` or higher, the wrong value is set to implement Storage Replica. If `ClusterFunctionalLevel` isn't `9`, the `ClusterFunctionalLevel` must be updated to implement Storage Replica on this node.

To resolve the issue, raise the cluster functional level by running the PowerShell cmdlet [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/update-clusterfunctionallevel).

## Small unknown volume is listed in DISKMGMT for each replicated volume

When you run the Disk Management snap-in (`DiskMgmt.msc`), you notice one or more volumes listed with no label or drive letter. The volumes are 1 MB in size. You might be able to delete the unknown volumes, or you might see this error:

```output
An Unexpected Error has Occurred
```

This message is expected and is by design. The listed items are partitions, not volumes. Storage Replica creates a 512-KB partition as a database slot for replication operations (the legacy `DiskMgmt.msc` tool rounds to the nearest megabyte). It's typical to have a partition like this for each replicated volume. When the disk is no longer used by Storage Replica, you can delete this 512-KB partition. You can't delete a partition if it is in use. The partition size never changes. If you're re-creating replication, we recommend that you delete the partition because Storage Replica claims unused partitions.

To view details, use the DISKPART tool or the `Get-Partition` cmdlet. These partitions have a GPT type `558d43c5-a1ac-43c0-aac8-d1472b2923d1`.

## A Storage Replica node stops responding when you create snapshots

You create a Volume Shadow Copy Service (VSS) snapshot, such as through backup or by using vssadmin, and a Storage Replica node stops responding, or *hangs*. You must force a restart of the node to recover.

This issue occurs when you create a VSS snapshot of the log volume. The underlying cause is a legacy design aspect of VSS, not Storage Replica. The resulting behavior when you take a snapshot of the Storage Replica log volume is a VSS I/O queuing mechanism deadlocks the server.

To prevent this scenario, don't snapshot Storage Replica log volumes. The logs can't be restored, so there's no need to snapshot the log volumes. Also, the log volume should never contain any other workloads, so no snapshot is needed in general.

## High I/O latency when you use Storage Spaces Direct with Storage Replica

When you use Storage Spaces Direct with a nonvolatile memory express (NVMe) device or a solid-state drive (SSD) cache, you see a greater than expected increase in latency when configuring Storage Replica replication between Storage Spaces Direct clusters. The change in latency is proportionally much higher than you see when you use NVMe and SSD in a *performance + capacity* configuration and no HDD tier or capacity tier.

This issue occurs because of architectural limitations in the Storage Replica log mechanism combined with the low latency of NVMe compared to slower media. In Storage Spaces Direct cache, all Storage Replica log I/O and all recent read/write I/Os from applications occur in the cache and never on the performance or capacity tiers. All Storage Replica activity happens on same-speed media. The configuration is supported, but we don't recommend it. For log recommendations, see [Frequently asked questions about Storage Replica](storage-replica-frequently-asked-questions.yml).


When you use Storage Spaces Direct with HDDs, you can't disable or avoid creating a cache. As a workaround, if you use only SSD and NVMe, you can configure only performance and capacity tiers. In that scenario, if you place only the Storage Replica logs on the performance tier and place only the data volumes they service on the capacity tier, you avoid a high-latency scenario. You can get a similar result by using a mix of faster and slower SSDs and no NVMe.

This workaround isn't ideal, and some customers might not be able to use it. The Storage Replica team is working on optimizations and an updated log mechanism to reduce these artificial bottlenecks. This v1.1 log first became available in Windows Server 2019. Its improved performance is described on [Storage at Microsoft](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB).

## "Could not find file" error when you run Test-SRTopology between two clusters

You run the `Test-SRTopology` cmdlet between two clusters, but their CSV paths fail, and you see this error:

```output
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

The error shown in the example occurs because of a known code defect in Windows Server 2016. This issue was fixed in Windows Server 2019 and the associated RSAT tools. For a downlevel resolution, contact Microsoft Support. There's no workaround.

## "Specified volume couldn't be found" error when you run Test-SRTopology between two clusters

You run the `Test-SRTopology` cmdlet between two clusters, but their CSV paths fail, and you see this error:

```output
Test-SRTopology : The specified volume C:\ClusterStorage\Volume1 cannot be found on computer RRN44-14-09. If this is a cluster node, the volume must be part of a role or CSV; volumes in Available Storage are not accessible
At line:1 char:1
+ Test-SRTopology -SourceComputerName RRN44-14-09 -SourceVolumeName C:\ ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (:) [Test-SRTopology], Exception
    + FullyQualifiedErrorId : TestSRTopologyFailure,Microsoft.FileServices.SR.Powershell.TestSRTopologyCommand
```

When you specify the source node CSV as the source volume, you must select the node that owns the CSV. You can either move the CSV to the specified node or change the node name that you set in `-SourceComputerName`. An improved message was introduced beginning with Windows Server 2019.

## You can't access the data drive in Storage Replica after an unexpected restart when BitLocker is enabled

If BitLocker is enabled on both drives (the log drive and the data drive), the primary server restarts. After the server restarts, you can't access the primary drive, even after you unlock the log drive in BitLocker.

To recover the data or to access the drive, first unlock the log drive, and then open `Diskmgmt.msc` to locate the data drive. Mark the data drive as offline and then online again. Locate the BitLocker icon on the drive and unlock the drive.

## You can't unlock the data drive on the secondary server after you break the Storage Replica partnership

After you disable the Storage Replica partnership and then remove the partnership, you can't unlock the secondary server's data drive by using its respective password or key.

To unlock the secondary server's data drive, you must use the key or password of the primary server's data drive.

## Test failover doesn't mount in asynchronous replication

You run the `Mount-SRDestination` cmdlet to bring a destination volume online during test failover fails, and you see this error:

```output
Mount-SRDestination: Unable to mount SR group <TEST>, detailed reason: The group or resource is not in the correct state to perform the supported operation.
    At line:1 char:1
    + Mount-SRDestination -ComputerName SRV1 -Name TEST -TemporaryP . . .
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : NotSpecified: {MSFT WvrAdminTasks : root/Microsoft/...(MSFT WvrAdminTasks : root/Microsoft/. T_WvrAdminTasks)} [Mount-SRDestination], CimException
        + FullyQualifiedErrorId : Windows System Error 5823, Mount-SRDestination.
```

If you use a synchronous partnership type, test failover works normally.

A known code defect in Windows Server version 1709 causes this error. To resolve this issue, install the [October 18, 2018 update](https://support.microsoft.com/help/4462932/windows-10-update-kb4462932). The issue isn't present in Windows Server 2019 and later versions.

## You can't set up Storage Replica with a physical sector size larger than 4 KB

Currently, Storage Replica doesn't support disks that have a physical sector size larger than 4 KB. For more information and to learn about resolutions, see [Troubleshoot 4-KB disk sector size](/troubleshoot/sql/database-engine/database-file-operations/troubleshoot-os-4kb-disk-sector-size#resolutions).

## Related content

- [Storage Replica overview](storage-replica-overview.md)
- [Stretch cluster replication by using shared storage](stretch-cluster-replication-using-shared-storage.md)
- [Server-to-server storage replication](server-to-server-storage-replication.md)
- [Cluster-to-cluster storage replication](cluster-to-cluster-storage-replication.md)
- [Storage Replica FAQ](storage-replica-frequently-asked-questions.yml)
- [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md)



