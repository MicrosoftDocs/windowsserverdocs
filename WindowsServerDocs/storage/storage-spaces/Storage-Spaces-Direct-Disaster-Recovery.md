---
title: Disaster Recovery Scenarios for Storage Spaces Direct in Windows Server
ms.topic: example-scenario
ms.author: roharwoo
author: robinharwood
ms.date: 10/01/2025
description: This article describes the scenarios available today for disaster recovery of Storage Spaces Direct
appliesto: [
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
			"✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
		   ]
---
# Disaster recovery with Storage Spaces Direct

This article provides scenarios on how Storage Spaces Direct can be configured for disaster recovery.

Numerous companies are running hyper-converged solutions. Planning for a disaster gives the ability to remain in or get back to production quickly if a disaster were to occur. There are several ways to configure Storage Spaces Direct for disaster recovery and this document explains the options that are available to you today.

Restoring availability if a disaster occurs is known as Recovery Time Objective (RTO). The RTO is the duration of time targeted where services must be restored to avoid unacceptable consequences to the business. In some cases, this process can occur automatically with production restored nearly immediately. In other cases, manual administrator intervention must occur to restore services.

The disaster recovery options with a hyper-converged today are:

1. Multiple clusters utilizing Storage Replica
2. Hyper-V Replica between clusters
3. Backup and Restore

## Multiple clusters utilizing Storage Replica

[Storage Replica](../storage-replica/storage-replica-overview.md) enables the replication of volumes and supports both synchronous and asynchronous replication. When choosing between using either synchronous or asynchronous replication, you should consider your Recovery Point Objective (RPO). Recovery Point Objective is the amount of possible data loss you're willing to incur before it's considered major loss. If you go with synchronous replication, it sequentially writes to both ends at the same time. If you go with asynchronous, writes replicate very fast but could still be lost. You should consider the application or file usage to see which best works for you.

Storage Replica is a block-level copy mechanism versus file-level; meaning, it doesn't matter what types of data are being replicated. This approach makes it a popular option for hyper-converged infrastructure. Storage Replica also can utilize different types of drives between the replication partners, so having all of one type storage on one cluster and another type storage on the other is perfectly fine.

One important capability of Storage Replica is that it can be run in Azure and on-premises. You can set up on-premises to on-premises, Azure to Azure, or even on-premises to Azure (or vice versa).

In this scenario, there are two separate independent clusters. For configuring Storage Replica between clusters, you can follow the steps in [Cluster-to-cluster storage replication](../storage-replica/cluster-to-cluster-storage-replication.md).

![Storage Replication diagram](media/storage-spaces-direct-disaster-recovery/Disaster-Recovery-Figure1.png)

The following considerations apply when deploying Storage Replica.

1.    Configuring replication is done outside of Failover Clustering.
2.    Choosing the method of replication is dependent upon your network latency and RPO requirements. Synchronous replicates the data on low-latency networks with crash consistency to ensure no data loss at a time of failure. Asynchronous replicates the data over networks with higher latencies, but each site might not have identical copies at a time of failure.
3.    For a disaster, failover between the clusters isn't automatic and needs to be orchestrated manually through the Storage Replica PowerShell cmdlets. In the previous diagram, ClusterA is the primary and ClusterB is the secondary. If ClusterA goes down, you would need to manually set ClusterB as Primary before you can bring up the resources. Once ClusterA is back up, you would need to make it Secondary. Once all data is synchronized, make the change and swap the roles back to the way they were originally set.
4.    Since Storage Replica is only replicating the data, a new virtual machine or Scale Out File Server (SOFS) utilizing this data would need to be created inside Failover Cluster Manager on the replica partner.

Storage Replica can be used if you have virtual machines or an SOFS running on your cluster. Bringing resources online in the replica cluster can be manual or automated by using PowerShell scripting.

## Hyper-V Replica

[Hyper-V Replica](../../virtualization/hyper-v/replication-overview.md) provides virtual machine level replication for disaster recovery on hyper-converged infrastructures. What Hyper-V Replica can do is to take a virtual machine and replicate it to a secondary site or Azure (replica). Then from the secondary site, Hyper-V Replica can replicate the virtual machine to a third (extended replica).

To learn more about Hyper-V Replica, see [Hyper-V Replica overview](../../virtualization/hyper-v/replication-overview.md).

## Backup and restore

One traditional disaster recovery option that isn't talked about very much but is just as important is the failure of the entire cluster or a node in the cluster. Either option with this scenario makes use of Windows Server Backup.

It's always a recommendation to have periodic backups of the hyper-converged infrastructure. While the Cluster Service is running, if you take a System State Backup, the cluster registry database would be a part of that backup. Restoring the cluster or the database has two different methods (Non-Authoritative and Authoritative).

### Non-authoritative

A Non-Authoritative restore can be accomplished using Windows Server Backup and equates to a full restore of just the cluster node itself. If you only need to restore a cluster node (and the cluster registry database) and all current cluster information good, you would restore using non-authoritative. Non-Authoritative restores can be done through the Windows Server Backup interface or the command line WBADMIN.EXE.

Once you restore the node, let it join the cluster. What happens is that it goes out to the existing running cluster and updates all of its information with what is currently there.

### Authoritative

An Authoritative restore of the cluster configuration, on the other hand, takes the cluster configuration back in time. This type of restore should only be accomplished when the cluster information itself is lost and needs restored. For example, someone accidentally deleted a File Server that contained over 1,000 shares and you need them back. Completing an Authoritative restore of the cluster requires that a backup is run from the command line.

When an Authoritative restore is initiated on a cluster node, the cluster service is stopped on all other nodes in the cluster view and the cluster configuration is frozen. It's critical that the cluster service on the node on which the restore was executed is started first so the cluster is formed using the new copy of the cluster configuration.

To run through an authoritative restore, the following steps can be accomplished.

1. Run WBADMIN.EXE from an administrative command prompt to get the latest version of backups that you want to install and ensure that System State is one of the components you can restore.

    ```powershell
    wbadmin get versions
    ```

2. Determine if the version backup you have has the cluster registry information in it as a component. There are a couple of items you need from this command, including the version and the application/component for use in Step 3. For the version, for example, say the backup was done January 3, 2018 at 2:04am and this backup is the one you need restored.

    ```powershell
    wbadmin get items -backuptarget:\\backupserver\location
    ```

3. Start the authoritative restore to recover only the cluster registry version you need.

    ```powershell
    wbadmin start recovery -version:01/03/2018-02:04 -itemtype:app -items:cluster
    ```

Once the restore is complete, this node must be the one to start the Cluster Service first and form the cluster. All other nodes would then need to be started and join the cluster.

## Summary

Hyper-converged disaster recovery is something that should be planned out carefully. There are several scenarios that can best meet your needs and should be thoroughly tested. One item to note is that if you're familiar with Failover Clusters in the past, stretch clusters have been a popular option over the years. There was a bit of a design change with the hyper-converged solution and it's based on resiliency. If you lose two nodes in a hyper-converged cluster, the entire cluster goes down. With this being the case, in a hyper-converged environment, the stretch scenario isn't supported.
