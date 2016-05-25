---
title: Migration Paths for Migrating to a Failover Cluster Running Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2dcf89c3-ba0a-4480-b3a0-149ebb0171c8
author: kumudd
---
# Migration Paths for Migrating to a Failover Cluster Running Windows Server 2012 R2
This topic provides guidance for migrating specific cluster roles to a failover cluster running the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system by using the Copy Cluster Roles Wizard in Failover Cluster Manager. The topic covers supported migration paths, provides an overview of wizard\-based migration, and notes which cluster roles require special handling during migration.  
  
## Migration paths for specific migrations  
The following table lists the operating system versions on a source failover cluster that can be migrated to a failover cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] for each clustered service or application. Migrations between failover clusters created with physical computers and failover clusters that are created from virtual machines \(also known as *guest clusters*\) are supported.  
  
### Supported migrations for clustered roles and resources to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster  
  
|Clustered role or resource|From Windows Server 2008 R2 SP1|From Windows Server 2012|From Windows Server 2012 R2|  
|------------------------------|-----------------------------------|----------------------------|-------------------------------|  
|Cluster Registry settings|Yes|Yes|Yes|  
|Cluster Shared Volume \(CSV\) volumes|Yes|Yes|Yes|  
|DFS Namespace \(DFS\-N\)|Yes|Yes|Yes|  
|DFS Replication \(DFS\-R\)|Yes|Yes|Yes|  
|DHCP Server|Yes|Yes|Yes|  
|Distributed Network Name \(DNN\)|No|Yes|Yes|  
|File Server|Yes|Yes|Yes|  
|Scale\-Out File Server for application data|No|Yes|Yes|  
|Generic Application|Yes|Yes|Yes|  
|Generic Script|Yes|Yes|Yes|  
|Generic Service|Yes|Yes|Yes|  
|Virtual Machine|Yes|Yes|Yes|  
|Hyper\-V Replica Broker|No|Yes|Yes|  
|IP addresses \(IPV4, IPV6, IPv6 tunnel addresses\)|Yes|Yes|Yes|  
|iSCSI Target Server|Yes|Yes|Yes|  
|Internet Storage Name Service \(iSNS\)|Yes|Yes|Yes|  
|Message Queuing \(MSMQ\), MSMQ triggers|Yes|Yes|Yes|  
|Network Name resources|Yes|Yes|Yes|  
|NFS shares|Yes|Yes|Yes|  
|Other Server|Yes|Yes|Yes|  
|Physical Disk resource|Yes|Yes|Yes|  
|WINS Server|Yes|Yes|Yes|  
  
> [!NOTE]  
> In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can designate a virtual hard disk \(.vhdx file\) as shared storage for multiple virtual machines that are configured as a guest failover cluster. This new type of guest cluster, known as a *shared VHDX guest cluster*, enables scenarios such as Microsoft SQL Server Failover Cluster Instance \(FCI\) guest clusters. The Copy Cluster Roles Wizard supports migration of the roles in the table above \(except for the Virtual Machines role, which cannot exist in a guest cluster\) between shared\-VHDX guest clusters running the released version of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. However, if you created a shared\-VHDX guest cluster in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Preview, you cannot use the wizard to copy the cluster roles to a shared VDX guest cluster running the released version of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## <a name="BKMK_2003"></a>Cluster roles that cannot be migrated  
Some services and applications that can run in a failover cluster on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cannot be migrated by using the Copy Cluster Roles Wizard—in some cases because they were not supported on earlier versions of clustering. The Copy Cluster Roles Wizard in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cannot be used to migrate the following clustered roles:  
  
-   Microsoft SQL Server—For upgrade guidance for SQL Server, see the whitepaper [SQL Server 2012 Upgrade Technical Guide](http://msdn.microsoft.com/library/dn144931.aspx).  
  
-   Microsoft Exchange Server—For upgrade guidance for Exchange Server, see [Understanding Upgrade to Exchange 2010](http://technet.microsoft.com/library/aa998604(v=exchg.141).aspx).  
  
-   Print Spooler from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]—In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the print spooler is no longer a clustered resource. Instead, high availability is defined as a highly available virtual machine running on a single cluster node. The Print Server role is installed on a single virtual machine, which can be migrated to other nodes automatically or manually. For more information, see [High Availability Printing Overview](http://technet.microsoft.com/library/jj556311.aspx).  
  
-   Remote Desktop Connection Broker from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]—In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the active\/passive clustering model for the RD Connection Broker role service, used in earlier versions of Windows Server, is replaced by the Active\/Active Broker feature, which eliminates the need for clustering and provides a fully active\/active model. For more information, see the blog entry [RD Connection Broker High Availability in Windows Server 2012](http://blogs.msdn.com/b/rds/archive/2012/06/27/rd-connection-broker-high-availability-in-windows-server-2012.aspx).  
  
-   Volume Shadow Copy Service tasks  
  
-   Task Scheduler tasks \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] only\)  
  
-   Cluster Aware Updating \(CAU\) settings \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] only\)  
  
## Roles restricted to a single instance per cluster  
For the following roles, only one instance per failover cluster is supported:  
  
-   DHCP Server  
  
-   WINS Server  
  
-   iSCSI Target Server  
  
-   Hyper\-V Replica Broker \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] only\)  
  
For those roles, the Copy Cluster Roles Wizard will not attempt to create a second role instance if one instance already exists on the target cluster.  
  
## <a name="BKMK_wizard"></a>Migrations for which the Copy Cluster Roles Wizard performs most or all steps  
For the following clustered services or applications, The Copy Cluster Roles Wizard performs most or all steps for a migration to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster:  
  
-   Distributed File System \(DFS\) Namespace  
  
-   Generic Application  
  
-   Generic Script  
  
-   Generic Service  
  
-   IPv4 Address, when migrating within the same subnet  
  
-   IPv6 Address or IPv6 Tunnel Address  
  
-   Internet Storage Name Service \(iSNS\)  
  
-   Network Name \(other than the cluster name\)  
  
    If Kerberos authentication is enabled for the Network Name resource, the migration wizard prompts you for the password for the Cluster service account that is used by the old cluster.  
  
-   NFS  
  
-   Physical Disk \(resource settings only; does not copy data to new storage\)  
  
-   Windows Internet Name Service \(WINS\) \(Extra steps might be required if you migrate to new storage, and you use a different drive letter on the path to the new database.\)  
  
For more information about the Copy Cluster Roles Wizard, see [Create a Failover Cluster](http://technet.microsoft.com/library/dn505754.aspx). For step\-by\-step instructions for performing a migration between two multimode failover clusters, see [Migration Between Two Multi\-Node Clusters](assetId:///0bd0cdac-719f-48fc-813a-01207f02f4c7). For step\-by\-step instructions for performing a stand\-alone migration while upgrading a single failover cluster, see [In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2](../Topic/In-Place-Migration-for-a-Two-Node-Cluster--Migration-to-Windows-Server-2012-R2.md).  
  
### Migration within mixed environments  
The Copy Cluster Roles Wizard can migrate clustered resources within mixed environments. For example, the wizard accommodates the following differences in the source and destination environments:  
  
-   Migrate static IP addresses to a cluster using DHCP.  
  
-   Migrate IPv4 resources into an IPv6 environment.  
  
-   Migrate across routed subnets.  
  
-   Migrate a physical cluster to a guest \(virtual\) cluster \(with the exception of Hyper\-V clusters, which must run on physical computers\).  
  
-   Migrate between different editions of the operating system \(for example, from Windows Server Enterprise to Windows Server Datacenter\), between x86 and x64 processor architectures, and from a cluster running Windows Server Core or Microsoft Hyper\-V Server to a cluster running a full version of Windows Server.  
  
During migration, the wizard allows you to address name conflicts between resource groups, resources, and share names and to address drive letter collisions. The wizard resolves the conflicts as part of the post\-migration repair process.  
  
> [!IMPORTANT]  
> The Copy Cluster Roles Wizard moves resources, not data. If you plan to migrate to new storage, you must move the data and folders yourself.  
  
### Additional steps for a wizard\-based migration  
Some additional steps typically are needed before or after you run the wizard, including the following:  
  
-   Install server roles and features that are needed in the new cluster. In most cases, you must install the role or feature on all nodes of the cluster. For example, before you migrate a highly available virtual machine, you must install the Hyper\-V server role on each cluster node.  
  
-   Copy or install any associated applications, services, or scripts on the new cluster \(all nodes\).  
  
-   If a migrated role or feature uses the same storage, take the services and storage offline on the old cluster and then make the storage available to the new cluster.  
  
-   If a migrated role or feature uses new storage, ensure that any data and folders are copied to new storage. Verify permissions on any shared subfolders that were migrated.  
  
-   If the new cluster is on a different subnet, provide static IP addresses.  
  
-   If the new cluster uses a different volume letter, update drive path locations for applications.  
  
-   Configure Task Manager tasks on the new cluster. \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] only\)  
  
-   For a virtual machine, install the latest integration services on the virtual machine. Configure Volume Shadow Copy Service \(VSS\) backups. For a migration from [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], configure Hyper\-V Replica settings.  
  
-   Configure Cluster Aware Updating \(CAU\). \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] only\)  
  
### Failover Cluster Copy Roles reports  
The wizard provides a Failover Cluster Copy Roles Pre\-Copy Report \(formerly the Pre\-Migration Report\) and a Failover Cluster Copy Roles Post\-Copy Report \(formerly the Post\-Migration Report\), which provide important information. We recommend that you review both reports while performing a migration:  
  
-   The Pre\-Copy Roles Report explains whether each resource that you plan to migrate is eligible for migration.  
  
-   The Post\-Copy Roles Report contains information about the success of the migration, and describes additional steps that might be needed before you bring the migrated resources online.  
  
> [!NOTE]  
> Two resource groups are never migrated: **Cluster Core Resources Group** and **Available Storage Group**. You can ignore these resource groups in the Failover Cluster Copy Roles reports.  
  
## Clustered role and feature migrations that require extra steps  
This section provides guidance for migrating clustered roles and features that require additional steps before or after you run the Copy Cluster Roles Wizard to perform a migration between clusters.  
  
-   [Clustered DFS Replication migrations](#BKMK_dfsr)  
  
-   [Clustered DHCP migrations](#BKMK_dhcp)  
  
-   [Clustered DTC migrations](#BKMK_dtc)  
  
-   [Clustered File Server and Scale\-out File Server migrations](#BKMK_BKMK_FileServerMigrations)  
  
-   [Clustered FSRM migrations](#BKMK_FSRM)  
  
-   [Clustered Message Queuing \(MSMQ\) migrations](#BKMK_msmq)  
  
-   [Other Server migrations involving resource types not built into failover clusters](#BKMK_other)  
  
-   [Migration of highly available virtual machines](#BKMK_vm)  
  
### <a name="BKMK_dfsr"></a>Clustered DFS Replication migrations  
Before you migrate clustered Distributed File System \(DFS\) Replication \(also known as DFS\-R or DFSR\) to a cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must add the new cluster to the DFS replication group to which the old cluster belongs, and then wait until DFS Replication synchronizes the data to the new cluster. After data synchronization is complete, you can decommission the old cluster. For step\-by\-step guidance, see [Migrate File and Storage Services to Windows Server 2012 R2](http://technet.microsoft.com/library/dn479292.aspx) and [File and Storage Services: Post\-migration Tasks](http://technet.microsoft.com/library/jj863559.aspx).  
  
##### To migrate clustered instances of DFS Replication to a cluster running Windows Server 2012 R2  
  
1.  Obtain the name of the cluster to which you will migrate. In Active Directory, this is the name that is used for the computer account of the cluster itself \(also called the cluster name object or CNO\). Add this name to the replication group that you will migrate. For more information, see [Add a member to a replication group](http://go.microsoft.com/fwlink/?LinkId=169014).  
  
2.  Wait until DFS Replication finishes synchronizing the replicated data to the cluster to which you will migrate.  
  
3.  If you plan to decommission the cluster from which you migrated, remove its network name from the replication group. If necessary, destroy the cluster.  
  
For more information about DFS Replication in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [DFS Namespaces and DFS Replication Overview](http://technet.microsoft.com/library/jj127250.aspx). For step\-by\-step instructions for migrating DEF Replication, see [Migrate File and Storage Services to Windows Server 2012 R2](http://technet.microsoft.com/library/dn479292.aspx).  
  
### <a name="BKMK_dhcp"></a>Clustered DHCP migrations  
When migrating clustered Dynamic Host Configuration Protocol \(DHCP\) to a cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the Copy Cluster Roles Wizard migrates resources and settings, but not the DHCP database. For information about how to migrate the DHCP database, see [DHCP Server Migration: Migrating the DHCP Server Role](http://technet.microsoft.com/library/dd379483(v=ws.10).aspx). The information in the topic also applies to migrations from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The topic includes information about migrating from a cluster.  
  
> [!NOTE]  
> Although the migration of the clustered DHCP role is supported, in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] there is the option to use DHCP failover. DHCP failover provides redundancy and load balancing without clustered DHCP. For more information, see [Migrate to DHCP Failover](http://technet.microsoft.com/library/dn338990.aspx) and [Understand and Deploy DHCP Failover](http://technet.microsoft.com/library/dn338978.aspx).  
  
### <a name="BKMK_dtc"></a>Clustered DTC migrations  
Before you begin the migration of clustered Distributed Transaction Coordinator \(DTC\) to a cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must make sure the list of transactions stored by DTC is empty. This is referred to as *draining the transaction logs*. If you do not drain the logs, the information in the logs \(the transaction state information for unresolved transactions\) will be lost during the migration. Unresolved transactions include **Active**, **In Doubt**, and **Cannot Notify** transactions.  
  
##### To drain DTC transaction logs of unresolved transactions  
  
1.  Stop the application that creates transactions on the clustered instance of DTC that is being migrated.  
  
2.  On a node of the cluster that you are migrating from, click **Start**, point to **Administrative Tools**, and then click **Component Services**. \(In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], open **Component Services** directly from the Start screen.\)  
  
3.  Expand **Component Services**, expand **Computers**, expand **My Computer**, expand **Distributed Transaction Coordinator**, and then expand **Clustered DTCs**.  
  
4.  Expand the clustered instance of DTC that you are migrating, and then click **Transaction List**.  
  
5.  View the transaction list to see if it is empty. If there are transactions listed, then either wait for them to be completed or right\-click each transaction, click **Resolve**, and then select **Forget**, **Commit**, or **Abort**.  
  
    For information about the effect of each of these options, see [Transaction State Resolution After System Failure](http://go.microsoft.com/fwlink/?LinkId=169116).  
  
For additional information, see [View Transaction Information](http://go.microsoft.com/fwlink/?LinkId=169117).  
  
### <a name="BKMK_BKMK_FileServerMigrations"></a>Clustered File Server and Scale\-out File Server migrations  
Several methods are available for migrating a scale\-out file server or traditional clustered file server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For all methods, there are trade\-offs among required downtime, migration duration, resource usage, and required hardware. The best method for your environment depends on hardware and resources you have available, the volume of data to be moved, the number of clustered file servers that are affected, and service requirements.  
  
#### Choosing the best migration method for your file server  
When you plan your clustered file server migration, consider these methods:  
  
-   Virtual machine storage migration  
  
-   Copy Cluster Roles Wizard \- Migrate to a new multi\-node cluster  
  
-   Copy Cluster Roles Wizard – In\-place migration  
  
-   Migrate storage pools  
  
> [!NOTE]  
> For a fuller discussion of storage upgrade options as an integral part of upgrading your private cloud infrastructure, view the presentation [Upgrading Your Private Cloud with Windows Server 2012 R2](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2013/MDC-B331), presented at TechEd 2013.  
  
##### Virtual machine storage migration  
Introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], virtual machine storage migration enables you to the virtual hard disks used by one clustered file server to another clustered file server while the virtual machine remains running. This is known as *storage migration*. After you migrate storage for each virtual machine, you migrate the virtual machines to the new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster. For more information, see [Virtual Machine Storage Migration Overview](http://technet.microsoft.com/library/hh831656.aspx).  
  
This method is useful for moving to new storage if you have the resources available to maintain required service levels on all of the virtual machines during migration.  
  
### Migration method: Virtual machine storage migration  
  
|Advantages|Disadvantages|  
|--------------|-----------------|  
|Live\-migrate storage without any downtime for the virtual machines.|The process moves lots of data over the network, using lots of resources. If you are migrating a large number of virtual machines, and don’t have the network capacity to gracefully handle the large loads, this can have a large impact on performance.<br /><br />You must move to new storage.|  
  
##### Copy Cluster Roles Wizard \- Migrate to a new multi\-node cluster  
With this method, you set up a new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster, migrate the File Server role to the new cluster, and then take the file server offline while you redirect storage to the new cluster. The wizard does not move data; if you migrate to new storage, the wizard updates the storage settings for the role, but you must move the data and files manually during the migration. For step\-by\-step instructions, see [Migrate Between Two Multi-Node Clusters: Migration to Windows Server 2012 R2](../Topic/Migrate-Between-Two-Multi-Node-Clusters--Migration-to-Windows-Server-2012-R2.md).  
  
Use this method if you have too much data to move over the network without unacceptable impact on the performance of your clustered file servers.  
  
### Migration method: Copy Cluster Roles Wizard – Migrate to a new multi\-node cluster  
  
|Advantages|Disadvantages|  
|--------------|-----------------|  
|This method is much faster than storage migration. In a large enterprise with hundreds of clustered file servers, the migration can take hours rather than days.|Downtime is required. You must take the File Server roles offline on the old cluster while you redirect the storage to the new cluster, However, this method is faster than moving VHDs over the network, and you can schedule the downtime for a maintenance window, when you will experience a limited interruption in service but will not risk degrading service for running virtual machines over long periods.<br /><br />Additional hardware is required to create the new failover cluster.|  
  
##### Copy Cluster Roles Wizard – In\-place migration  
If you do not have the hardware available to create a new multi\-node [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster before you migrate the cluster roles, you can perform an in\-place migration. In an in\-place migration, you use hardware from an existing cluster to create the new cluster, evicting one node to use as the first node in the new cluster.  
  
For a two\-node cluster, you would evict one node, perform a clean installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on that node, create a new single\-node failover cluster with that node, and then migrate the File Server role from the old cluster to the new cluster. At that point, you must take the File Server roles offline on the old cluster while you redirect storage to the new cluster. When the migration is complete, you then destroy the old cluster, install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the other cluster node, and add that node to the new cluster. For step\-by\-step instructions, see [In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2](../Topic/In-Place-Migration-for-a-Two-Node-Cluster--Migration-to-Windows-Server-2012-R2.md).  
  
### Migration method: Copy Cluster Roles Wizard – In\-place migration  
  
|Advantages|Disadvantages|  
|--------------|-----------------|  
|No new hardware required.<br /><br />Data is not migrated over the network.|Downtime is required: you must take the File Server roles offline on the old cluster before you can redirect storage to the new cluster and then bring the roles and the storage online on the new cluster.<br /><br />While migrating a two\-node cluster in place, you take on the added risk of losing high availability for your file servers from the time when you remove the first node from the old cluster until you add the second node to the new cluster.<br /><br />Service can be degraded on the nodes that remain online during the migration, particularly if you are migrating large numbers of clustered file servers.|  
  
##### Storage pool migration  
If you are migrating from a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] failover cluster that uses storage pools, you can minimize the impact of migration by migrating one storage pool at a time, from the old cluster to the new cluster. With storage pools, instead of managing each disk individually, you add physical disks to one or more pools and then create virtual disks from the available capacity. You then create volumes on the virtual disks, as if they were physical disks. When you run low on the available capacity in the pool, add physical disks to the pool to create bigger pools with more capacity for more virtual disks.  
  
Storage Spaces uses commodity drives that are attached via Serial\-Attached SCSI \(SAS\), Serial ATA \(SATA\), or USB. When it is time to change from the old cluster using the storage to the new cluster using the storage, you might need to change the cabling. If you are reusing hardware \(that is, you are performing an in\-place migration\), when you evict a node from the old cluster, you need to disconnect that server’s connection to the disks. When it is time to change the storage from the old cluster to the new cluster, disconnect the storage from the old cluster before you connect the storage to the new cluster, so that only one cluster is connected to the disks at one time. When you connect the storage to the new cluster, the Storage Spaces and associated storage pools becomes available to the new cluster so that the migration can complete.  
  
For more information about using Storage Spaces and storage pools, see [Storage Spaces Overview](http://technet.microsoft.com/library/hh831739.aspx), [What's New in Storage Spaces in Windows Server 2012 R2](http://technet.microsoft.com/library/dn387076.aspx), and [Deploy Clustered Storage Spaces](http://technet.microsoft.com/library/jj822937.aspx). For a video presentation from TechEd 2013 that demonstrates Storage Spaces basics and new features, see [Storage Spaces: What’s New in Windows Server 2012 R2](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2013/MDC-B218).  
  
### Migration method: Storage pool migration  
  
|Advantages|Disadvantages|  
|--------------|-----------------|  
|No downtime is required.<br /><br />High availability is maintained throughout migration.|Data moves over the network.<br /><br />A four\-node cluster is required to enable you to maintain two nodes on both the old and new clusters during migration.|  
  
#### Additional tasks for file server migration using the Copy Cluster Roles Wizard  
If you choose to use the Copy Cluster Roles Wizard to migrate your file server, be aware of the following requirements:  
  
-   If you plan to migrate to new storage, keep in mind that if the migrated files and folder inherit permissions from their parents, during migration it is the inheritance setting that is migrated, not the inherited permissions. Therefore it is important to make sure that the parent folders on the source server and the destination server have the same permissions to maintain the permissions on migrated data that has inherited permissions. After the file server migration, it’s important to verify the folder permissions after the migration. Sometimes folder permissions reset to Read\-only during a file server migration.  
  
-   You do not need to migrate the quorum resource. When you run the Create a Cluster Wizard in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the cluster software automatically chooses the quorum configuration that provides the highest availability for your new failover cluster, and it dynamically updates the quorum configuration if you add or evict nodes. You can change the quorum configuration on the new cluster if necessary for your specific environment. However, Dynamic Quorum is not in effect on a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] failover cluster. If you evict a node to perform an in\-place migration, you will need to update the quorum configuration.  
  
### <a name="BKMK_FSRM"></a>Clustered FSRM migrations  
To migrate the File Server Resource Manager \(FSRM\) classification, storage reporting, and file management task configuration on a clustered file server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a failover cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must export the configuration from one FSRM server node in the cluster and then import the configuration to another FSRM server. These steps must be performed locally on one node of the cluster. You then fail over the other nodes until this process is complete. For step\-by\-step instructions, see [Migrate File and Storage Services to Windows Server 2012 R2](http://technet.microsoft.com/library/dn479292.aspx).  
  
> [!IMPORTANT]  
> When you migrate the configuration, FSRM requires that you use the same drive letters on both the source and destination servers.  
  
### <a name="BKMK_msmq"></a>Clustered Message Queuing \(MSMQ\) migrations  
When you migrate a clustered instance of Message Queuing \(also known as MSMQ\) to a cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], it’s important to take the following precautions to ensure that the data is preserved and you can bring the service online on the new cluster:  
  
-   Before you migrate, you should back up the data that is associated with clustered instances of Message Queuing. This ensures that you can restore service\-specific Message Queuing data if it is accidentally deleted during migration. For more information about Message Queuing backup and restore, see [Backing up and restoring messages](http://go.microsoft.com/fwlink/?LinkId=169118).  
  
-   During the migration, it’s important to make sure that the migration is complete before you delete either clustered instance of Message Queuing \(old or new\). Otherwise, service\-specific data for Message Queuing might be deleted from the shared storage, which prevents the remaining Message Queuing resource from coming online. After the migration is complete and you are ready to delete a clustered instance of Message Queuing \(old or new\), first remove the disk resource from that clustered instance and take the disk offline. Then delete the clustered instance of Message Queuing.  
  
### <a name="BKMK_other"></a>Other Server migrations involving resource types not built into failover clusters  
Before you use the Copy Cluster Roles Wizard to migrate an application that uses a clustered resource type that is not built into failover clustering, be sure to add the resource type to the new cluster. You can then use the Copy Cluster Roles Wizard to migrate your clustered application. In this situation, the Copy Cluster Roles Wizard attempts a "best effort" migration.  
  
##### To add a resource type to a failover cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
1.  Open Failover Cluster Manager from the Start screen of any node in the cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
2.  If the cluster to which you want to migrate is not displayed, in the console tree, right\-click **Failover Cluster Manager**, click **Connect to Cluster**, select the cluster that you want to migrate to, and then click **OK**.  
  
3.  In the console tree, right\-click the cluster, and then click **Properties**.  
  
4.  Click the **Resource Types** tab, and then click **Add**.  
  
5.  Specify the following information for the resource type:  
  
    -   **Resource DLL path and file name**: The path and file name of the resource dynamic\-link library \(DLL\) that the Cluster service should use when it communicates with your service or application.  
  
    -   **Resource type name**: The name that the Cluster service uses for the resource type. This name stays the same regardless of the regional and language options that are currently selected.  
  
    -   **Resource type display name**: The name that is displayed for the resource type. This name might vary when you make changes to regional and language options.  
  
### <a name="BKMK_vm"></a>Migration of highly available virtual machines  
You can use the Copy Cluster Roles Wizard to migrate highly available virtual machines created in Hyper\-V from a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster to a cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Using the wizard, you migrate the Virtual Machine clustered role, select highly available virtual machines to migrate, and update virtual network settings for the virtual machines on the new cluster.  
  
Migrating HAVMs by using the Copy Cluster Roles Wizard has the advantage of not copying VHDs over the network, so migration completes fairly quickly and downtime is limited. However, the wizard cannot migrate virtual machines to new storage. Also, if you migrate one virtual machine on a Cluster Shared Volume \(CSV\) volume, all virtual machines on that volume are migrated. And downtime is required: after you copy the Virtual Machine roles to the cluster, you must take the virtual machines on the old cluster offline, unmask the storage to the old cluster, mask the storage to the new cluster, then bring the storage online on the new cluster, and then start the virtual machines on the new cluster.  
  
> [!CAUTION]  
> It is very important that you not turn on the migrated virtual machines on the new cluster before you take the virtual machines offline on the old cluster. Running a virtual machine on both clusters at the same time might corrupt the virtual machine.  
  
For step\-by\-step instructions for migrating highly available virtual machines from a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] failover cluster to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster by using the Copy Cluster Roles Wizard, see [Copy Cluster Roles Wizard](http://technet.microsoft.com/library/dn486784.aspx#bkmk_ccrw) in [Hyper\-V Cluster Using Separate Scale\-out File Server Migration](http://technet.microsoft.com/library/dn486784.aspx), or, if your virtual machines are stored on Cluster Shared Volume \(CSV\) volumes, see [Hyper\-V Cluster Using Cluster Shared Volumes \(CSV\) Migration](http://technet.microsoft.com/library/dn486822.aspx). You can use the same procedures to migrate virtual machines from CSV volumes on a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] cluster to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cluster.  
  
#### Alternate methods for migrating HAVMs to a Windows Server 2012 R2 failover cluster  
Depending upon your environment and the service requirements for the migrated workloads, you should consider two alternate methods for migrating highly available virtual machines:  
  
-   **Cross version live migration** – [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] introduces a new method for migrating a highly available virtual machine from a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] cluster to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cluster. Using cross version live migration, you can migrate virtual machines to the new failover cluster without any downtime. If the virtual hard disks \(VHDs\) are stored on a Scale\-out File Server share that is accessible to both clusters, you don’t have to copy files over the network. However, depending on factors such as the amount of memory configured for the virtual machine, migration can be slow, and resource consumption during the live migrations can be high.  
  
-   **Export\/Import method** \- You also can migrate individual virtual machines by using the **Export** and **Import** actions in Hyper\-V Manager \(also available in Windows PowerShell\). The Export\/Import method lets you migrate virtual machines one at a time and control the method by which they the VHDs are copied to the new cluster. The virtual machine must be taken offline during the export and import, and you must re\-enable Hyper\-V replication on the virtual machine after migration.  
  
For a comparison of migration methods for migrating HAVMs to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster, see [Hyper\-V: Migration Options](http://technet.microsoft.com/library/dn486792.aspx).  
  
> [!NOTE]  
> You must use the Copy Cluster Roles Wizard or the **Export** and **Import** actions to migrate from a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] cluster to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cluster. Cross version live migration is only available when you migrate from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
#### Additional tasks for using the Copy Cluster Roles Wizard to migrate HAVMs  
When you migrate HAVMs by using the Copy Cluster Roles Wizard, a few extra steps are required:  
  
-   You must merge or discard all shadow copies before you migrate the volumes that are attached to the virtual machines. Before you begin working with shadow copies, you should back up volumes.  
  
-   After you migrate the virtual machines to the new cluster, install the latest Hyper\-V integration services on the new virtual machines.  
  
-   After you migrate, The Copy Cluster Roles Wizard does not migrate the following settings. You will need to configure the settings on the new cluster after migration.  
  
    -   Hyper\-V Replica settings  
  
        > [!IMPORTANT]  
        > If you using Hyper\-V Replica with the workload that you are migrating, see the “Hyper\-V Replica” section of [Hyper\-V: Migration Options](http://technet.microsoft.com/library/dn486792.aspx) for special considerations when migrating from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    -   Volume Shadow\-Copy Service \(VSS\) tasks  
  
    -   Cluster\-Aware Updating \(CAU\) settings  
  
## Additional references  
  
-   [Migrate Cluster Roles to Windows Server 2012 R2](assetId:///2b07e52a-da12-448f-9aa8-966fc8b825e9)  
  
-   [Windows Server Migration forum](http://social.technet.microsoft.com/Forums/winserverMigration/threads?outputAs=rss)  
  
-   Failover cluster basics:  
  
    -   [What's New in Failover Clustering in Windows Server 2012 R2](http://technet.microsoft.com/library/dn265972.aspx)  
  
    -   [Failover Clustering Overview](http://technet.microsoft.com/library/hh831579.aspx)  
  
-   Instructions for migrations that use the Copy Cluster Role Wizard:  
  
    -   [Migrate Between Two Multi-Node Clusters: Migration to Windows Server 2012 R2](../Topic/Migrate-Between-Two-Multi-Node-Clusters--Migration-to-Windows-Server-2012-R2.md)  
  
    -   [In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2](../Topic/In-Place-Migration-for-a-Two-Node-Cluster--Migration-to-Windows-Server-2012-R2.md)  
  
    -   [Hyper\-V: Hyper\-V Cluster Migration](http://technet.microsoft.com/library/dn486823.aspx) \(Migrating highly available virtual machines from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\)  
  
    -   [Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md)  
  
-   Migrating individual roles and features:  
  
    -   [Migrating Roles and Features in Windows Server](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
    -   [Migrate File and Storage Services to Windows Server 2012 R2](http://technet.microsoft.com/library/dn479292.aspx)  
  
-   High availability for Microsoft Exchange Server 2013: [Deploying High Availability and Site Resilience](http://technet.microsoft.com/library/dd638129(v=exchg.150).aspx)  
  
-   High availability for Microsoft SQL Server 2014: [High Availability Solutions \(SQL Server\)](http://technet.microsoft.com/library/ms190202(v=sql.120).aspx)  
  
-   High availability for Microsoft SQL Server 2012: [Microsoft SQL Server AlwaysOn Solutions Guide for High Availability and Disaster Recovery](http://download.microsoft.com/download/D/2/0/D20E1C5F-72EA-4505-9F26-FEF9550EFD44/Microsoft%20SQL%20Server%20AlwaysOn%20Solutions%20Guide%20for%20High%20Availability%20and%20Disaster%20Recovery.docx) \(whitepaper\)  
  
