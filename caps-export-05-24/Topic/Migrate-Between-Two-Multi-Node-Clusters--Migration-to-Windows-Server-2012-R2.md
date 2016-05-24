---
title: Migrate Between Two Multi-Node Clusters: Migration to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: edf51f98-f80e-4d49-87a8-e89ef4dcc0b9
author: kumudd
---
# Migrate Between Two Multi-Node Clusters: Migration to Windows Server 2012 R2
This topic provides step\-by\-step instructions for migrating cluster roles from a multi\-node failover cluster running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a multimode cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. \(Alternatively, you can perform an in\-place migration using a single two\-node cluster. For more information, see [In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2](../Topic/In-Place-Migration-for-a-Two-Node-Cluster--Migration-to-Windows-Server-2012-R2.md).\) If you plan to migrate highly available Hyper\-V virtual machines \(by migrating the Virtual Machine cluster role\), see [Hyper\-V: Hyper\-V Cluster Migration](http://technet.microsoft.com/library/dn486823.aspx) for step\-by\-step instructions.  
  
> [!IMPORTANT]  
> Before you begin your migration, review [Migration Paths for Migrating to a Failover Cluster Running Windows Server 2012 R2](../Topic/Migration-Paths-for-Migrating-to-a-Failover-Cluster-Running-Windows-Server-2012-R2.md) to confirm that the clustered service or application can be migrated by using the Copy Cluster Roles Wizard.  
  
## Overview of migration of cluster roles between two multi\-node failover clusters  
The procedures in this topic describe the following process for migrating cluster roles from an existing multi\-node cluster to a new multi\-node [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster.  
  
1.  [Prepare to migrate](#BKMK_PreparetoMigrate)  
  
    -   [Prepare the servers](#BKMK_PreparetheServers) – Install the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system, required server roles and features, and any services or applications that will run on the new failover cluster. Pre\-test services and applications to make sure they are compatible with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Verify that your storage is certified for use with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    -   [Prepare storage](#BKMK_PrepareStorage) – Storage preparation differs slightly depending on whether you will use the same storage for the new cluster that the old cluster is using or you plan to migrate to new storage. If you migrate highly available virtual machines, some additional storage preparation is required.  
  
    -   [Create a new failover cluster](#BKMK_CreatetheCluster)  
  
2.  [Migrate the cluster roles](#BKMK_MigrateClusterRoles) – Use the Copy Cluster Roles Wizard in Failover Cluster Manager to migrate the cluster roles to the new cluster.  
  
3.  [Perform post\-migration tasks](#BKMK_PostMigrationTasks) – Before you can bring a cluster role online on the new cluster, take the role offline on the new server, take the storage offline on the old cluster, and bring the storage on the new cluster online on the new cluster online. If you migrated highly available virtual machines, install the latest integration services on the virtual machines.  
  
4.  [Verify the migration](#BKMK_VerifyClusterRoleMigration):  
  
    -   [Verify that the migrated cluster roles are performing as expected on the new cluster](#BKMK_VerifyClusteredRolePerformance) \- Verify that the workload is available on the new cluster, and that service is provided at the required service\-level agreement \(SLA\). For virtual machines, verify the status of the virtual machines in Hyper\-V Manager, and confirm that you can connect to the virtual machines by using Remote Desktop or Virtual Machine Connection.  
  
    -   [Verify that the migrated cluster roles can fail over successfully](#BKMK_VerifyFailover)  
  
    -   [Troubleshoot issues with failover for the migrated cluster roles](#BKMK_TroubleshootFailover)  
  
### Impact of a migration between two multi\-node clusters  
When you migrate a cluster role between two multi\-node failover clusters, you can prepare the destination failover cluster, configure storage on the new cluster, and copy the cluster role to the new cluster while maintaining service availability on the old cluster. However, customers will experience a brief downtime after the cluster role is migrated and before you bring the role online on the new cluster.  
  
If the new cluster will use the same storage that the old cluster is using, before you bring the role online on the new cluster, you must take the clustered role offline on the old cluster, mask the storage to the old cluster, unmask the storage to the new cluster, and then bring the volumes or disks online on the new cluster.  
  
If you are migrating to new storage, before you can bring the role online on the new cluster, you must take the role offline on the old cluster, copy data and files for the clustered role to the new storage \(the Copy Cluster Roles Wizard does not move data\), and then bring the new storage online on the new cluster.  
  
> [!WARNING]  
> If you plan to use the Copy Cluster Roles Wizard to migrate a highly available Hyper\-V virtual machine from a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] failover cluster to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster, be aware that live migration is not supported for that scenario. However, you can live migrate an HAVM from a cluster running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster.  
  
### Access rights required to complete migration  
To migrate a cluster role by using the Copy Cluster Roles Wizard, you must be a local administrator on the destination failover cluster and on the cluster or cluster node from which you are migrating.  
  
### Additional references  
[In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2](../Topic/In-Place-Migration-for-a-Two-Node-Cluster--Migration-to-Windows-Server-2012-R2.md)  
  
[Hyper\-V: Migration Options](http://technet.microsoft.com/library/dn486792.aspx)  
  
[Hyper\-V: Hyper\-V Cluster Migration](http://technet.microsoft.com/library/dn486823.aspx)  
  
[Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md)  
  
[Migration Paths for Migrating to a Failover Cluster Running Windows Server 2012 R2](../Topic/Migration-Paths-for-Migrating-to-a-Failover-Cluster-Running-Windows-Server-2012-R2.md)  
  
[Windows Server Migration Forum](http://social.technet.microsoft.com/Forums/winserverMigration/threads?outputAs=rss)  
  
[Clustering Forum for Windows Server 2012](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserverClustering)  
  
## <a name="BKMK_PreparetoMigrate"></a>Cluster roles: Prepare to migrate between two multi\-node clusters  
To prepare to migrate cluster roles to a new failover cluster, perform the following tasks:  
  
-   [Prepare the servers for the new cluster](#BKMK_PreparetheServers)  
  
-   [Prepare storage for the new cluster](#BKMK_PrepareStorage)  
  
-   [Create a new failover cluster, and configure the firewall](#BKMK_CreatetheCluster)  
  
### <a name="BKMK_PreparetheServers"></a>To prepare servers for the new cluster  
  
1.  Perform a clean installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on each server that you will add to the new failover cluster.  
  
2.  Install the Failover Clustering feature on each server.  
  
3.  If you plan to migrate highly available virtual machines, add the Hyper\-V role to each server.  
  
4.  Install any needed services, applications, and server roles. For example, if you plan to migrate clustered Windows Internet Name Service \(WINS\) to the new cluster, install the WINS Server feature by using Server Manager.  
  
5.  If you are migrating a Generic Application, Generic Script, or Generic Service resource, confirm that any associated application is compatible with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. You also must confirm that any associated service exists in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and has the same name that it had in the old cluster. Test the application or service \(separately, not as part of a cluster\) to confirm that it runs as expected.  
  
### <a name="BKMK_PrepareStorage"></a>To prepare storage for the new cluster  
  
1.  If you plan to migrate to existing storage, verify that your existing storage is certified for use with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
2.  Make an appropriate number of LUNs or disks accessible to the servers, and do not make those LUNs or disks accessible to any other servers. If the new cluster will use old storage, for testing purposes, you can limit the number of LUNs or disks to one or two. If the new cluster will use new storage, make as many disks or LUNs accessible to the new server as you think the cluster will need.  
  
    > [!NOTE]  
    > We recommend that you keep a small disk or LUN available \(unused by clustered services and applications\) throughout the life of the cluster, so that you can always run storage validation tests without taking your services and applications offline.  
  
3.  Confirm that the intended cluster disks are visible and are formatted appropriately:  
  
    1.  On one of the servers that you plan to include in the cluster, open **Computer Management** from the Start screen, and then click **Disk Management** in the console tree.  
  
    2.  In Disk Management, confirm that the intended cluster disks are visible.  
  
    3.  Check the format of any exposed volume or LUN. We recommend that you use NTFS for the format. \(For a disk witness, you must use NTFS.\)  
  
4.  To prepare to migrate a highly available virtual machine, you must merge or discard all shadow copies that have been created for the virtual machine:  
  
    1.  Back up the volumes that store the virtual machines.  
  
    2.  Merge or discard shadow copies for each virtual hard disk \(VHD\).  
  
    3.  If you are migrating virtual machines stored on a Cluster Shared Volume \(CSV\) volume, make sure that you want to migrate all of the virtual machines on any volume that you plan to migrate. If you migrate one virtual machine that is stored on Cluster Shared Volume \(CVS\) volume, the Copy Cluster Roles Wizard migrates all virtual machines on that volume. This restriction does not apply when you migrate a Scale\-out File Server cluster, which does not use CSV volumes.  
  
5.  If you are using new storage, and your disk configuration uses mount points, review [Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md) to identify any additional steps that you need to perform.  
  
### <a name="BKMK_CreatetheCluster"></a>To create the new failover cluster and configure your firewall  
  
1.  Create the new failover cluster. For information about how to create a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster, see [Create a Failover Cluster](http://technet.microsoft.com/library/dn505754.aspx).  
  
2.  After you create the cluster, ensure that your firewall is configured appropriately. For example, if you are using Windows Firewall, and you will be sharing folders and files, use your preferred Windows Firewall interface to allow the exception for **Remote Volume Management**.  
  
## <a name="BKMK_MigrateClusterRoles"></a>Cluster roles: Migrate the cluster roles  
Use the following instructions to migrate clustered services and applications from your old cluster to your new cluster. The Copy Cluster Roles Wizard leaves most of the migrated resources offline so that you can perform additional steps before you bring them online.  
  
> [!NOTE]  
> To migrate a cluster role by using the Copy Cluster Roles Wizard, you must be a local administrator on the destination failover cluster and on the cluster or cluster node from which you are migrating.  
  
#### Before you copy cluster roles to a new failover cluster  
  
-   If you plan to use new storage with the migrated clustered roles, before you run the Copy Cluster Roles Wizard, ensure that the storage is available to the new cluster – that is, ensure that the volumes have been added to the new cluster and that the volumes are online. This enables the wizard to update storage settings during migration.  
  
#### To copy cluster roles from an existing cluster to a new cluster  
  
1.  From the **Start** screen or from **Server Manager** \(**Tools**\), open **Failover Cluster Manager**.  
  
2.  In the console tree, if the cluster that you created is not displayed, right\-click **Failover Cluster Manager**, click **Connect to Cluster**, and then select the cluster that you want to configure.  
  
3.  In the console tree, expand the cluster that you created to see the items underneath it.  
  
4.  If the clustered servers are connected to a network that is not to be used for cluster communications \(for example, a network intended only for iSCSI\), then under **Networks**, right\-click that network, click **Properties**, and then click **Do not allow cluster network communication on this network**. Click **OK**.  
  
5.  In the console tree, select the cluster.  
  
6.  Under **Configure**, click **Copy Cluster Roles**.  
  
    The Copy Cluster Roles Wizard opens.  
  
7.  Read the Welcome page, and then click **Next**.  
  
8.  Specify the name or IP address of the cluster or cluster node from which you want to migrate services and applications, and then click **Next**.  
  
9. The **Select Roles** page lists the clustered roles that can be migrated from the old cluster. The list does not contain any role that is not eligible for migration. Click **View Report** to view details in the Failover Cluster Pre\-Copy Report. Then select each cluster role that you want to copy to the new cluster, and click **Next**.  
  
    > [!IMPORTANT]  
    > We recommend that you read the report, which explains whether each resource is eligible for migration. \(The wizard also provides a report after it finishes, which describes any additional steps that might be needed before you bring the migrated resource groups online.\)  
  
    If storage is available on the new cluster, the **Specify Storage for Migration** page appears, giving you the option to migrate to new storage. If storage is not available on the new cluster, the wizard retains existing storage settings and does not display the page.  
  
    > [!NOTE]  
    > Not all clustered roles can be migrated to new storage. For example, the wizard cannot be used to migrate highly available virtual machines \(the Virtual Machine role\) to new storage. For an overview of options for migrating highly available virtual machines to a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster and step\-by\-step instructions for each migration option, see [Hyper\-V: Hyper\-V Cluster Migration](http://technet.microsoft.com/library/dn486823.aspx).  
  
10. If you want to use new storage for a service or application:  
  
    1.  On the **Specify Storage for Migration** page, select the cluster disk that you want to migrate to new storage, and then click **Select Storage**.  
  
    2.  In the **Select Storage for Resource Group** dialog box, under **Available Storage in New Cluster**, select the cluster disk that you want the service or application to use in the new cluster, and then click **OK**.  
  
    3.  Repeat these steps for each cluster disk that you want to migrate to new storage. Then click **Next**.  
  
    > [!IMPORTANT]  
    > The Copy Cluster Roles Wizard does not move existing data and folders to the new storage. You must copy the folders and data manually.  
  
11. Follow the instructions in the wizard to perform the migration. From the **Summary** page, we recommend that you read the Failover Cluster Post\-Copy Roles Report, which describes any additional steps that you might need to complete before you bring the roles online. For example, if you have not already installed needed applications on the new cluster node, you might need to install them.  
  
After the wizard completes, most migrated resources will be offline. Leave them offline at this stage.  
  
> [!CAUTION]  
> At no time should a virtual machine be running on both the old cluster and the new cluster. A virtual machine that runs on both the old cluster and the new cluster at the same time might become corrupted. You can run a virtual machine on the old cluster while you migrate it to a new cluster with no problems; the virtual machine on the new cluster is created in a Stopped state. However, to avoid corruption, it is important that you do not turn on the virtual machine on the new cluster until after you stop the virtual machine on the old cluster.  
  
## <a name="BKMK_PostMigrationTasks"></a>Cluster roles: Post\-migration tasks for a migration between two multi\-node clusters  
To complete the transition to the new cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], perform the following steps. After you complete the transition, verify that the migrated workloads are available and are performing at the expected service levels, and verify that the cluster roles can successfully fail over within the new cluster.  
  
#### To complete the transition from the old cluster to the new cluster  
  
1.  Prepare for clients to experience downtime, probably briefly.  
  
2.  On the old cluster, take the role and resource that were copied to the new cluster offline.  
  
3.  Complete the transition for the storage:  
  
    -   If the new cluster will use old storage, follow your plan for making LUNs or disks inaccessible to the old cluster and accessible to the new cluster.  
  
    -   If the new cluster will use new storage, copy the appropriate folders and data to the storage. As needed for disk access on the old cluster, bring individual disk resources online on that cluster. \(Keep other resources offline, to ensure that clients cannot change data on the disks in storage.\) On the new cluster, use Disk Management to confirm that the appropriate LUNs or disks are visible to the new cluster and not visible to any other servers.  
  
4.  If the new cluster uses mount points, adjust the mount points as needed, and make each disk resource that uses a mount point dependent on the resource of the disk that hosts the mount point. For more information about mount points, see [Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md).  
  
5.  Bring the services and resources that were copied to the new cluster online.  
  
6.  If you migrated virtual machines, install the latest integration services on each virtual machine.  
  
> [!NOTE]  
> The Copy Cluster Roles Wizard does not migrate Volume Shadow Copy Service \(VSS\) tasks, Hyper\-V Replica Broker settings, Task Scheduler tasks, and Cluster\-Aware Updating \(CAU\) settings. If you were using any of these features on the old cluster, you will need to configure them on the new cluster.  
  
## <a name="BKMK_VerifyClusterRoleMigration"></a>Cluster roles: Verify the migration  
After you complete the transition to the new failover cluster, verify that the migrated workloads are available and are performing at the expected service levels, and verify that the cluster roles can successfully fail over within the new cluster.  
  
-   [Verify that the migrated cluster roles are performing as expected on the new cluster](#BKMK_VerifyClusteredRolePerformance)  
  
-   [Verify that the migrated cluster roles can fail over successfully](#BKMK_VerifyFailover)  
  
-   [Troubleshoot issues with failover for the migrated cluster roles](#BKMK_TroubleshootFailover)  
  
### <a name="BKMK_VerifyClusteredRolePerformance"></a>To verify that the migrated cluster roles are performing as expected on the new cluster  
  
1.  Verify that you can access the workload that was migrated. For example, can you connect to a highly available file server after it is migrated? Can you see the data that the server stores?  
  
2.  Run the necessary application\-specific tests to ensure that the new cluster can provide the same service levels for the migrated workload that was provided before the clustered role was migrated.  
  
3.  If you migrated virtual machines, verify the status of the virtual machines in Hyper\-V Manager, and confirm that you can connect to the virtual machines by using Remote Desktop or Virtual Machine Connection.  
  
### <a name="BKMK_VerifyFailover"></a>To verify that the migrated cluster roles can fail over successfully  
  
1.  In the console tree of **Failover Cluster Manager**, click the failover cluster on which the role is running.  
  
2.  Expand **Roles**, and then click a migrated role that you want to test.  
  
3.  On the **Actions** pane, expand **Roles**, and then click the cluster role that you want to test.  
  
    To perform a basic test of failover for the copied cluster role, on the **Actions** pane, click **Move**, and then either select a node to move the role to \(**Select Node** option\) or move the role to the best possible node. When prompted, confirm your choice.  
  
    You can observe the status changes in the center pane of Failover Cluster Manager as the cluster role is moved.  
  
If there are any issues with failover, use the following procedure to troubleshoot those issues.  
  
### <a name="BKMK_TroubleshootFailover"></a>To troubleshoot issues with failover for the migrated cluster roles  
  
1.  View events in Failover Cluster Manager. To do this, in the console tree, right\-click **Cluster Events**, and then click **Query**. In the **Cluster Events Filter** dialog box, select the criteria for the events that you want to display, or to return to the default criteria, click the **Reset** button. Click **OK**. To sort events, click a heading, for example, **Level** or **Date and Time**.  
  
2.  Confirm that necessary services, applications, or server roles are installed on all nodes. Confirm that services or applications are compatible with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and run as expected.  
  
3.  If you used old storage for the new cluster, use the **Validate Cluster** action in Failover Cluster Manager to rerun the Validate a Configuration Wizard and confirm the validation results for all LUNs or disks in the storage.  
  
4.  Review migrated resource settings and dependencies. If you are using new storage that includes disks that use mount points, see [Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md).  
  
5.  If you migrated one or more Network Name resources with the Kerberos protocol enabled, confirm that the computer account for the failover cluster has **Full Control** permission for the computer accounts \(computer objects\) of your Kerberos protocol\-enabled Network Name resources. On a domain controller, open **Active Directory Users and Computers**, and then verify the permissions for the appropriate computer accounts \(computer objects\).  
  
