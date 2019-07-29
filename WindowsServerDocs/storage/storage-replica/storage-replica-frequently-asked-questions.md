---
title: Frequently Asked Questions about Storage Replica
ms.prod: windows-server-threshold
manager: siroy
ms.author: nedpyle
ms.technology: storage-replica
ms.topic: get-started-article
author: nedpyle
ms.date: 04/26/2019
ms.assetid: 12bc8e11-d63c-4aef-8129-f92324b2bf1b
---
# Frequently Asked Questions about Storage Replica

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

This topic contains answers to frequently asked questions (FAQs) about Storage Replica.

## <a name="FAQ1"></a> Is Storage Replica supported on Azure?
Yes. You can use the following scenarios with Azure:

1. Server-to-server replication inside Azure (synchronously or asynchronously between IaaS VMs in one or two datacenter fault domains, or asynchronously between two separate regions)
2. Server-to-server asynchronous replication between Azure and on-premises (using VPN or Azure ExpressRoute)
3. Cluster-to-cluster replication inside Azure (synchronously or asynchronously between IaaS VMs in one or two datacenter fault domains, or asynchronously between two separate regions)
4. Cluster-to-cluster asynchronous replication between Azure and on-premises (using VPN or Azure ExpressRoute)

Further notes on guest clustering in Azure can be found at: [Deploying IaaS VM Guest Clusters in Microsoft Azure](https://techcommunity.microsoft.com/t5/Failover-Clustering/Deploying-IaaS-VM-Guest-Clusters-in-Microsoft-Azure/ba-p/372126).

Important notes:

1. Azure doesn't support shared VHDX guest clustering, so Windows Failover Cluster virtual machines must use iSCSI targets for classic shared-storage persistent disk reservation clustering or Storage Spaces Direct.
2. There are Azure Resource Manager templates for Storage Spaces Direct-based Storage Replica clustering at [Create a Storage Spaces Direct  SOFS Clusters with Storage Replica for Disaster Recovery across Azure Regions](https://aka.ms/azure-storage-replica-cluster).  
3. Cluster to cluster RPC communication in Azure (required by the cluster APIs for granting access between cluster) requires configuring network access for the CNO. You must allow TCP port 135 and the dynamic range above TCP port 49152. Reference [Building Windows Server Failover Cluster on Azure IAAS VM – Part 2 Network and Creation](https://blogs.technet.microsoft.com/askcore/2015/06/24/building-windows-server-failover-cluster-on-azure-iaas-vm-part-2-network-and-creation/).  
4. It's possible to use two-node guest clusters, where each node is using loopback iSCSI for an asymmetric cluster replicated by Storage Replica. But this will likely have very poor performance and should be used only for very limited workloads or testing.  

## <a name="FAQ2"></a> How do I see the progress of replication during initial sync?  
The Event 1237 messages shown in the Storage Replica Admin even log on the destination server show number of bytes copied and bytes remaining every 10 seconds. You can also use the Storage Replica performance counter on the destination showing **\Storage Replica Statistics\Total Bytes Received** for one or more replicated volumes. You can also query the replication group using Windows PowerShell. For instance,  this sample command gets the name of the groups on the destination  then queries one group named **Replication 2** every 10 seconds to show progress:  

```  
Get-SRGroup

do{
    $r=(Get-SRGroup -Name "Replication 2").replicas
    [System.Console]::Write("Number of remaining bytes {0}`n", $r.NumOfBytesRemaining)
    Start-Sleep 10
}until($r.ReplicationStatus -eq 'ContinuouslyReplicating')
Write-Output "Replica Status: "$r.replicationstatus

```  

## <a name="FAQ3"></a>Can I specify specific network interfaces to be used for replication?  

Yes, using `Set-SRNetworkConstraint`. This cmdlet operates at the interface layer and be used on both cluster and non-cluster scenarios.  
For example, with a standalone server (on each node):  

```  
Get-SRPartnership  

Get-NetIPConfiguration  
```  
Note the gateway and interface information (on both servers) and the partnership directions. Then run:  

```  
Set-SRNetworkConstraint -SourceComputerName sr-srv06 -SourceRGName rg02 -  
SourceNWInterface 2 -DestinationComputerName sr-srv05 -DestinationNWInterface 3 -DestinationRGName rg01  

Get-SRNetworkConstraint  

Update-SmbMultichannelConnection  

```  

For configuring network constraints on a stretch cluster:  

    Set-SRNetworkConstraint -SourceComputerName sr-cluster01 -SourceRGName group1 -SourceNWInterface "Cluster Network 1","Cluster Network 2" -DestinationComputerName sr-cluster02 -DestinationRGName group2 -DestinationNWInterface "Cluster Network 1","Cluster Network 2"

## <a name="FAQ4"></a> Can I configure one-to-many replication or transitive (A to B to C) replication?  
No, Storage Replica supports only one to one replication of a server, cluster, or stretch cluster node. This may change in a later release. You can of course configure replication between various servers of a specific volume pair, in either direction. For instance, Server 1 can replicate its D volume to server 2, and its E volume from Server 3.

## <a name="FAQ5"></a> Can I grow or shrink replicated volumes replicated by Storage Replica?  
You can grow (extend) volumes, but not shrink them. By default, Storage Replica prevents administrators from extending replicated volumes; use the `Set-SRGroup -AllowVolumeResize $TRUE` option on the source group, prior to resizing. For example:

1. Use against the source computer: `Set-SRGroup -Name YourRG -AllowVolumeResize $TRUE`
2. Grow the volume using whatever technique you prefer
3. Use against the source computer: `Set-SRGroup -Name YourRG -AllowVolumeResize $FALSE` 

## <a name="FAQ6"></a>Can I bring a destination volume online for read-only access?  
Not in Windows Server 2016. Storage Replica dismounts the destination volume when replication begins. 

However, in Windows Server 2019 and Windows Server Semi-Annual Channel starting with version, 1709, the option to mount the destination storage is now possible - this feature is called "Test Failover". To do this, you must have an unused, NTFS or ReFS formatted volume that is not currently replicating on the destination. Then you can mount a snapshot of the replicated storage temporarily for testing or backup purposes. 

For example, to create a test failover where you are replicating a volume "D:" in the Replication Group "RG2" on the destination server "SRV2" and have a "T:" drive on SRV2 that is not being replicated:

 `Mount-SRDestination -Name RG2 -Computername SRV2 -TemporaryPath T:\`
 
The replicated volume D: is now accessible on SRV2. You can read and write to it normally, copy files off it, or run an online backup that you save elsewhere for safekeeping, under the D: path. The T: volume will only contain log data.

To remove the test failover snapshot and discard its changes:

 `Dismount-SRDestination -Name RG2 -Computername SRV2`
 
You should only use the test failover feature for short-term temporary operations. It is not intended for long term usage. When in use, replication continues to the real destination volume. 

## <a name="FAQ7"></a> Can I configure Scale-out File Server (SOFS) in a stretch cluster?  
While technically possible, this is not a recommended configuration due to the lack of site awareness in the compute nodes contacting the SOFS. If using campus-distance networking, where latencies are typically sub-millisecond, this configuration typically works without issues.   

If configuring cluster-to-cluster replication, Storage Replica fully supports Scale-out File Servers, including the use of Storage Spaces Direct, when replicating between two clusters.  

## <a name="FAQ7.5"></a> Is CSV required to replicate in a stretch cluster or between clusters?  
No. You can replicate with CSV or persistent disk reservation (PDR) owned by a cluster resource, such as a File Server role. 

If configuring cluster-to-cluster replication, Storage Replica fully supports Scale-out File Servers, including the use of Storage Spaces Direct, when replicating between two clusters.  

## <a name="FAQ8"></a>Can I configure Storage Spaces Direct in a stretch cluster with Storage Replica?  
This is not a supported configuration in Windows Server. This may change in a later release. If configuring cluster-to-cluster replication, Storage Replica fully supports Scale Out File Servers and Hyper-V Servers, including the use of Storage Spaces Direct.  

## <a name="FAQ9"></a>How do I configure asynchronous replication?  

Specify `New-SRPartnership -ReplicationMode` and provide argument **Asynchronous**. By default, all replication in Storage Replica is synchronous. You can also change the mode with `Set-SRPartnership -ReplicationMode`.  

## <a name="FAQ10"></a>How do I prevent automatic failover of a stretch cluster?  
To prevent automatic failover, you can use PowerShell to configure `Get-ClusterNode -Name "NodeName").NodeWeight=0`. This removes the vote on each node in the disaster recovery site. Then you can use `Start-ClusterNode -PreventQuorum` on nodes in the primary site and `Start-ClusterNode -ForceQuorum` on nodes in the disaster site to force failover. There is no graphical option for preventing automatic failover, and preventing automatic failover is not recommended.  

## <a name="FAQ11"></a>How do I disable virtual machine resiliency?
To prevent the new Hyper-V virtual machine resiliency feature from running and therefore pausing virtual machines instead of failing them over to the disaster recovery site, run `(Get-Cluster).ResiliencyDefaultPeriod=0`  

## <a name="FAQ12"></a> How can I reduce time for initial synchronization?

You can use thin-provisioned storage as one way to speed up initial sync times. Storage Replica queries for and automatically uses thin-provisioned storage, including non-clustered Storage Spaces, Hyper-V dynamic disks, and SAN LUNs.  

You can also use seeded data volumes to reduce bandwidth usage and sometimes time, by ensuring that the destination volume has some subset of data from the primary then using the Seeded option in Failover Cluster Manager or `New-SRPartnership`. If the volume is mostly empty, using seeded sync may reduce time and bandwidth usage. There are multiple ways to seed data, with varying degrees of efficacy:

1. Previous replication - by replicating with normal initial sync locally between nodes containing the disks and volumes, removing replication, shipping the destination disks elsewhere, then adding replication with the seeded option. This is the most effective method as Storage Replica guaranteed a block-copy mirror and the only thing to replicate is delta blocks.
2. Restored snapshot or restored snapshot-based backup - by restoring a volume-based snapshot onto the destination volume, there should be minimal differences in the block layout. This is the next most effective method as blocks are likely to match thanks to volume snapshots being mirror images.
3. Copied files - by creating a new volume on the destination that has never been used before and performing a full robocopy /MIR tree copy of the data, there are likely to be block matches. Using Windows File Explorer or copying some portion of the tree will not create many block matches. Copying files manually is the least effective method of seeding.

## <a name="FAQ13"></a> Can I delegate users to administer replication?  

You can use the `Grant-SRDelegation` cmdlet. This allows you to set specific users in server to server, cluster to cluster, and stretch cluster replication scenarios as having the permissions to create, modify, or remove replication, without being a member of the local administrators group. For example:  

    Grant-SRDelegation -UserName contso\tonywang  

The cmdlet will remind you that the user needs to log off and on of the server they are planning to administer in order for the change to take effect. You can use `Get-SRDelegation` and `Revoke-SRDelegation` to further control this.  

## <a name="FAQ13"></a> What are my backup and restore options for replicated volumes?
Storage Replica supports backing up and restoring the source volume. It also supports creating and restoring snapshots of the source volume. You cannot backup or restore the destination volume while protected by Storage Replica, as it is not mounted nor accessible. If you experience a disaster where the source volume is lost, using `Set-SRPartnership` to promote the previous destination volume to now be a read/writable source will allow you to backup or restore that volume. You can also remove replication with `Remove-SRPartnership` and `Remove-SRGroup` to remount that volume as read/writable.
To create periodic application consistent snapshots, you can use VSSADMIN.EXE on the source server to snapshot replicated data volumes. For example, where you are replicating the F: volume with Storage Replica:

    vssadmin create shadow /for=F:
Then, after you switch replication direction, remove replication, or are simply still on the same source volume, you can restore any snapshot to its point in time. For example, still using F:

    vssadmin list shadows
     vssadmin revert shadow /shadow={shadown copy ID GUID listed previously}
You can also schedule this tool to run periodically using a scheduled task. For more information on using VSS, review [Vssadmin](../../administration/windows-commands/vssadmin.md). There is no need or value in backing up the log volumes. Attempting to do so will be ignored by VSS.
Use of Windows Server Backup, Microsoft Azure Backup, Microsoft DPM, or other snapshot, VSS, virtual machine, or file-based technologies are supported by Storage Replica as long as they operate within the volume layer. Storage Replica does not support block-based backup and restore.

## <a name="FAQ14"></a> Can I configure replication to restrict bandwidth usage?
Yes, via the SMB bandwidth limiter. This is a global setting for all Storage Replica traffic and therefore affects all replication from this server. Typically, this is needed only with Storage Replica initial sync setup, where all the volume data must transfer. If needed after initial sync, your network bandwidth is too low for your IO workload; reduce the IO or increase the bandwidth.

This should only be used with asynchronous replication (note: initial sync is always asynchronous even if you have specified synchronous).
You can also use network QoS policies to shape Storage Replica traffic. Use of highly matched seeded Storage Replica replication will also lower overall initial sync bandwidth usage considerably.


To set the bandwidth limit, use:

    Set-SmbBandwidthLimit  -Category StorageReplication -BytesPerSecond x

To see the bandwidth limit, use:

    Get-SmbBandwidthLimit -Category StorageReplication

To remove the bandwidth limit, use:

    Remove-SmbBandwidthLimit -Category StorageReplication
    
## <a name="FAQ15"></a>What network ports does Storage Replica require?
Storage Replica relies on SMB and WSMAN for its replication and management. This means the following ports are required:

 445 (SMB - replication transport protocol, cluster RPC management protocol)
 5445 (iWARP SMB - only needed when using iWARP RDMA networking)
 5985 (WSManHTTP - Management protocol for WMI/CIM/PowerShell)

Note: The Test-SRTopology cmdlet requires ICMPv4/ICMPv6, but not for replication or management.

## <a name="FAQ15.5"></a>What are the log volume best practices?
The optimal size of the log varies widely per environment and workload, and is determined by how much write IO your workload performs. 

1.	A larger or smaller log doesn’t make you any faster or slower
2.	A larger or smaller log doesn’t have any bearing on a 10GB data volume versus a 10TB data volume, for instance

A larger log simply collects and retains more write IOs before they are wrapped out. This allows an interruption in service between the source and destination computer – such as a network outage or the destination being offline - to go longer. If the log can hold 10 hours of writes, and the network goes down for 2 hours, when the network returns the source can simply play the delta of unsynced changes back to the destination very fast and you are protected again very quickly. If the log holds 10 hours and the outage is 2 days, the source now has to play back from a different log called the bitmap – and will likely be slower to get back into sync. Once in sync it returns to using the log.

Storage Replica relies on the log for all write performance. Log performance critical to replication performance. You must ensure that the log volume performs better than the data volume, as the log will serialize and sequentialize all write IO. You should always use flash media like SSD on log volumes. You must never allow any other workloads to run on the log volume, the same way you would never allow other workloads to run on SQL database log volumes. 

Again: Microsoft strongly recommends that the log storage be faster than the data storage and that log volumes must never be used for other workloads.

You can get log sizing recommendations by running the Test-SRTopology tool. Alternatively, you can use performance counters on existing servers to make a log size judgement. The formula is simple:  monitor the data disk throughput (Avg Write Bytes/Sec) under the workload and use it to calculate the amount of time it will take to fill up the log of different sizes. For example, data disk throughput of 50 MB/s will cause the log of 120GB to wrap in 120GB/50MB seconds or 2400 seconds or 40 minutes. So the amount of time that the destination server could be unreachable before the log wrapped is 40 minutes. If the log wraps but the destination becomes reachable again, the source would replay blocks via the bit map log instead of the main log. The size of the log does not have an effect on performance.

ONLY the Data disk from the Source cluster should be backed-up. The Storage Replica Log disks should NOT be backed-up since a backup can conflict with Storage Replica operations.

## <a name="FAQ16"></a> Why would you choose a stretch cluster versus cluster-to-cluster versus server-to-server topology?  
Storage Replica comes in three main configurations: stretch cluster, cluster-to-cluster, and server-to-server. There are different advantages to each.

The stretch cluster topology is ideal for workloads requiring automatic failover with orchestration, such as Hyper-V private cloud clusters and SQL Server FCI. It also has a built-in graphical interface using Failover Cluster Manager. It utilizes the classic asymmetric cluster shared storage architecture of Storage Spaces, SAN, iSCSI, and RAID via persistent reservation. You can run this with as few as 2 nodes.

The cluster-to-cluster topology uses two separate clusters and is ideal for administrators who want manual failover, especially when the second site is provisioned for disaster recovery and not everyday usage. Orchestration is manual. Unlike stretch cluster, Storage Spaces Direct can be used in this configuration (with caveats - see the Storage Replica FAQ and cluster-to-cluster documentation). You can run this with as few as four nodes. 

The server-to-server topology is ideal for customers running hardware that cannot be clustered. It requires manual failover and orchestration. It is ideal for inexpensive deployments between branch offices and central data centers, especially when using asynchronous replication. This configuration can often replace instances of DFSR-protected File Servers used for single-master disaster recovery scenarios.

In all cases, the topologies support both running on physical hardware as well as virtual machines. When in virtual machines, the underlying hypervisor doesn't require Hyper-V; it can be VMware, KVM, Xen, etc.

Storage Replica also has a server-to-self mode, where you point replication to two different volumes on the same computer.

## <a name="FAQ18"></a> Is Data Deduplication supported with Storage Replica?

Yes, Data Deduplcation is supported with Storage Replica. Enable Data Deduplication on a volume on the source server, and during replication the destination server receives a deduplicated copy of the volume.

While you should *install* Data Deduplication on both the source and destination servers (see [Installing and enabling Data Deduplication](../data-deduplication/install-enable.md)), it’s important not to *enable* Data Deduplication on the destination server. Storage Replica allows writes only on the source server. Because Data Deduplication makes writes to the volume, it should run only on the source server. 

## <a name="FAQ19"></a> Can I replicate between Windows Server 2019 and Windows Server 2016?

Unfortunately, we don't support creating a *new* partnership between Windows Server 2019 and Windows Server 2016. You can safely upgrade a server or cluster running Windows Server 2016 to Windows Server 2019 and any *existing* partnerships will continue to work.

However, to get the improved replication performance of Windows Server 2019, all members of the partnership must run Windows Server 2019 and you must delete existing partnerships and associated replication groups and then recreate them with seeded data (either when creating the partnership in Windows Admin Center or with the New-SRPartnership cmdlet).

## <a name="FAQ17"></a> How do I report an issue with Storage Replica or this guide?  
For technical assistance with Storage Replica, you can post at [the Microsoft TechNet forums](https://social.technet.microsoft.com/Forums/windowsserver/en-US/home?forum=WinServerPreview). You can also email srfeed@microsoft.com for questions on Storage Replica or issues with this documentation. The <https://windowsserver.uservoice.com> site is preferred for design change requests, as it allows your fellow customers to provide support and feedback for your ideas.



## Related Topics  
- [Storage Replica Overview](storage-replica-overview.md) 
- [Stretch Cluster Replication Using Shared Storage](stretch-cluster-replication-using-shared-storage.md)  
- [Server to Server Storage Replication](server-to-server-storage-replication.md)  
- [Cluster to Cluster Storage Replication](cluster-to-cluster-storage-replication.md)  
- [Storage Replica: Known Issues](storage-replica-known-issues.md)  

## See Also  
- [Storage Overview](../storage.md)  
- [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md)  
