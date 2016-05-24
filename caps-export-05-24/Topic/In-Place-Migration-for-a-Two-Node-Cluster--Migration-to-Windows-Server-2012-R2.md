---
title: In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ca8af05-2bed-4de0-a8e7-673748e7640f
author: kumudd
---
# In-Place Migration for a Two-Node Cluster: Migration to Windows Server 2012 R2
This topic provides an overview and steps for upgrading an existing failover cluster to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] when you have only two servers \- that is, for performing an *in\-place migration*.  
  
> [!IMPORTANT]  
> Before you begin the migration, confirm that the cluster role that you want to migrate can be migrated by using the Copy Cluster Roles Wizard, as described in [Migration Paths for Migrating to a Failover Cluster Running Windows Server 2012 R2](../Topic/Migration-Paths-for-Migrating-to-a-Failover-Cluster-Running-Windows-Server-2012-R2.md), and note any preparation or follow\-up steps that are required for the role that is being migrated.  
  
> [!NOTE]  
> For an alternative approach to failover cluster migration, see [Migrate Between Two Multi-Node Clusters: Migration to Windows Server 2012 R2](../Topic/Migrate-Between-Two-Multi-Node-Clusters--Migration-to-Windows-Server-2012-R2.md). If you plan to migrate highly available Hyper\-V virtual machines \(by migrating the Virtual Machine cluster role\), see [Hyper\-V: Hyper\-V Cluster Migration](http://technet.microsoft.com/library/dn486823.aspx) for step\-by\-step instructions that use the Copy Cluster Roles Wizard to migrate virtual machines.  
  
## Overview of an in\-place migration for a two\-node cluster  
The procedures in this topic describe the following process for upgrading an existing failover cluster to Windows Server 2012 R2 when only two servers are available.  
  
1.  [Create a new cluster from a node in the old cluster](#BKMK_CreateNewCluster)—You will evict a node from the old cluster; upgrade that server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and install roles, features, and any needed software; prepare storage for the new cluster; and then create the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster.  
  
2.  [Copy cluster roles to the new cluster](#BKMK_CopyClusterRoles)—Use the Copy Cluster Roles Wizard to copy the clustered roles and features from the old cluster to the new cluster.  
  
3.  [Perform post\-migration tasks](#BKMK_PerformPostMigrationTasks)—Make existing data and files available to the new cluster; if you migrated to new storage, you will need to copy the data and files to the new storage location. Then bring the new cluster online, and verify that the migrated cluster roles and resources are available and are performing as expected.  
  
4.  [Add the second node to the new cluster](#BKMK_SectionAddtheOtherNode)—First, you will destroy the old cluster. Then you will prepare the remaining node for the new cluster as you did the first node. Perform a complete set of cluster validation tests to validate the configurations of both nodes. Add the second node to the new cluster. Then configure quorum settings on the new cluster.  
  
5.  [Verify failover for the migrated cluster roles](#BKMK_SectionVerifyFailover)—After you add the second node to the new cluster, you can verify that the migrated cluster roles fail over successfully, and you can troubleshoot any issues with failover.  
  
### Impact of the migration  
When you perform an in\-place migration on a two\-node failover cluster, you can prepare the destination failover cluster, configure storage, and copy the cluster role to the new cluster while maintaining service availability. High availability is lost when you evict the first node from the old cluster to use for the new cluster, and it is not restored until you have repurposed the remaining cluster node and added it to the new cluster.  
  
Customers will experience a brief downtime after the cluster role is migrated and before you bring the role online on the new cluster.  
  
If the new cluster will use the same storage that the old cluster is using, before you bring the role online on the new cluster, you must take the clustered role offline on the old cluster, mask the storage to the old cluster, unmask the storage to the new cluster, and then bring the volumes or disks online on the new cluster.  
  
If you are migrating to new storage, before you can bring the role online on the new cluster, you must take the role offline on the old cluster, copy data and files for the clustered role to the new storage \(the Copy Cluster Roles Wizard does not move data\), and then bring the new storage online on the new cluster.  
  
### Access rights required to complete migration  
To migrate a clustered role by using the Copy Cluster Roles Wizard, you must be a local administrator on the destination failover cluster and on the cluster or cluster node from which you are migrating.  
  
### Additional references  
[Migrate Between Two Multi-Node Clusters: Migration to Windows Server 2012 R2](../Topic/Migrate-Between-Two-Multi-Node-Clusters--Migration-to-Windows-Server-2012-R2.md)  
  
[Hyper\-V: Migration Options](http://technet.microsoft.com/library/dn486792.aspx)  
  
[Hyper\-V: Hyper\-V Cluster Migration](http://technet.microsoft.com/library/dn486823.aspx)  
  
[Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md)  
  
[Migration Paths for Migrating to a Failover Cluster Running Windows Server 2012 R2](../Topic/Migration-Paths-for-Migrating-to-a-Failover-Cluster-Running-Windows-Server-2012-R2.md)  
  
[Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606)  
  
[High Availability \(Clustering\) forum for Windows Server 2012](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserverClustering)  
  
## <a name="BKMK_CreateNewCluster"></a>Create a new cluster from a node in the old cluster  
For this phase of the migration, allow one existing server to continue running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and the Cluster service while you prepare to migrate the cluster roles.  
  
In this phase, you will perform the following tasks:  
  
-   [Evict a node from the old cluster](#BKMK_EvictNode1)  
  
-   [Prepare the node for the new cluster](#BKMK_PrepareNode1)  
  
-   [Prepare storage for the new cluster](#BKMK_PrepareStorage)  
  
-   [Create a new Windows Server 2012 R2 failover cluster](#BKMK_CreatetheCluster)  
  
### <a name="BKMK_EvictNode1"></a>To evict a node from the old cluster  
  
1.  Before you evict a node from a failover cluster, take the following precautions:  
  
    -   For each clustered role that you plan to migrate, verify that there are no special requirements or procedures for removing or evicting a node from the cluster. You can evict a node from a clustered file server or a cluster with the Hyper\-V role with no special preparation. However, you might need to uncluster some services or applications before you evict a node.  
  
    -   If you are migrating from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you should migrate all roles, including cluster core roles, to the remaining node before you evict a node.  
  
    -   To prevent any loss of application data when the node is evicted, shut down all services and applications on the cluster before you evict the node.  
  
2.  From the Start screen of either node in the cluster, open **Failover Cluster Manager**.  
  
3.  In the console tree, expand the cluster, expand Nodes, and then click the node that you want to evict to select it.  
  
4.  Right\-click the node, click **More Actions**, and then click **Evict**.  
  
### <a name="BKMK_PrepareNode1"></a>To prepare the node for the new cluster  
  
1.  Perform a clean installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the server that you removed from the old cluster.  
  
2.  Add the Failover Clustering feature to the server.  
  
3.  If you plan to migrate highly available virtual machines, add the Hyper\-V role to the server.  
  
4.  Install any other needed services, applications, and server roles. For example, if you plan to migrate clustered Windows Internet Name Service \(WINS\) to the new cluster, install the WINS Server feature by using Server Manager.  
  
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
  
5.  If you are using new storage and your disk configuration uses mount points, review [Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md) to identify any additional steps that you need to perform.  
  
### <a name="BKMK_CreatetheCluster"></a>To create the new failover cluster and configure your firewall  
  
1.  Create the new failover cluster. For information about how to create a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster, see [Create a Failover Cluster](http://technet.microsoft.com/library/dn505754.aspx).  
  
2.  After you create the cluster, ensure that your firewall is configured appropriately. For example, if you are using Windows Firewall, and you will be sharing folders and files, use your preferred Windows Firewall interface to allow the exception for **Remote Volume Management**.  
  
## <a name="BKMK_CopyClusterRoles"></a>Copy the cluster roles to the new cluster  
Use the following instructions to copy cluster roles from your old one\-node cluster to your new one\-node cluster. The Copy Cluster Roles Wizard leaves most of the migrated resources offline so that you can perform additional steps before you bring them online.  
  
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
  
7.  Read the **Welcome** page, and then click **Next**.  
  
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
  
## <a name="BKMK_PerformPostMigrationTasks"></a>Perform post\-migration tasks  
During this phase of migration, you will perform the following tasks:  
  
-   [Make existing data available to the new cluster, and bring the cluster online](#BKMK_MakeDataAvailableAndBringClusterOnline)  
  
-   [Verify that the migrated cluster roles and resources are available and are performing as expected](#BKMK_VerifyClusterRoles)  
  
### <a name="BKMK_MakeDataAvailableAndBringClusterOnline"></a>To make existing data available to the new cluster and bring the cluster online  
  
1.  Prepare for clients to experience downtime, probably briefly.  
  
2.  On the old cluster, take the roles and resources that were copied to the new cluster offline.  
  
3.  Complete the transition of storage to the new cluster:  
  
    -   If the new cluster will use old storage, follow your plan for making LUNs or disks inaccessible to the old cluster and accessible to the new cluster.  
  
    -   If the new cluster will use new storage, copy the appropriate folders and data to the storage. As needed for disk access on the old cluster, bring individual disk resources online on that cluster. \(Keep other resources offline to ensure that clients cannot change data on the disks in storage.\) Then, on the new cluster node, use Disk Management to confirm that the appropriate LUNs or disks are visible to the new cluster and not visible to any other servers.  
  
4.  If the new cluster uses mount points, adjust the mount points as needed, and make each disk resource that uses a mount point dependent on the resource of the disk that hosts the mount point. For more information about mount points, see [Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md).  
  
5.  Bring the cluster roles and resources that were copied to the new cluster online.  
  
6.  If you migrated virtual machines, install the latest integration services on each virtual machine.  
  
> [!NOTE]  
> The Copy Cluster Roles Wizard does not migrate Volume Shadow Copy Service \(VSS\) tasks, Hyper\-V Replica Broker settings, Task Scheduler tasks, and Cluster\-Aware Updating \(CAU\) settings. If you were using any of these features on the old cluster, you will need to configure them on the new cluster.  
  
### <a name="BKMK_VerifyClusterRoles"></a>To verify that the migrated cluster roles are performing as expected on the new cluster  
  
1.  Verify that you can access the workload that was migrated. For example, can you connect to a highly available file server after it is migrated? Can you see the data that the server stores?  
  
2.  Run the necessary application\-specific tests to ensure that the new cluster can provide the same service levels for the migrated workload that was provided before the clustered role was migrated.  
  
3.  If you migrated virtual machines, verify the status of the virtual machines in Hyper\-V Manager, and confirm that you can connect to the virtual machines by using Remote Desktop or Virtual Machine Connection.  
  
## <a name="BKMK_SectionAddtheOtherNode"></a>Add the second node to the new cluster  
Use the following procedures to prepare the second node and then add it to the new cluster. As part of this process, you will run validation tests that include both servers.  
  
-   [Delete migrated cluster roles, and destroy the old cluster](#BKMK_DeleteRolesAndDestroy)  
  
-   [Prepare the second node for the new cluster](#BKMK_PrepareNode2)  
  
-   [Validate the configuration of both cluster nodes](#BKMK_ValidateBothNodes)  
  
-   [Add the node to the cluster](#BKMK_AddNode2)  
  
-   [Verify storage for the new cluster](#BKMK_VerifyStorageforNewCluster)  
  
-   [Configure quorum settings on the new cluster](#BKMK_ConfigureClusterQuorum)  
  
### <a name="BKMK_DeleteRolesAndDestroy"></a>To delete the copied cluster roles and destroy the old cluster  
  
1.  From the Start screen, open **Failover Cluster Manager**.  
  
2.  Remove cluster roles that were copied to the new cluster:  
  
    1.  Expand the old cluster in the console tree, and then expand **Roles**.  
  
    2.  To delete a role, right\-click the role, and click **Delete**.  
  
3.  To destroy the cluster, right\-click the cluster in the console tree, click **More Actions**, and then click **Destroy Cluster**.  
  
### <a name="BKMK_PrepareNode2"></a>To prepare the second node for the new cluster  
  
1.  Perform a clean installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
2.  Add the Failover Clustering feature in the same way that you added it to the other server.  
  
3.  If the new cluster hosts virtual machines, add the Hyper\-V role to the server.  
  
4.  Connect the newly installed server to the same networks and storage that the existing failover cluster node is connected to.  
  
5.  Install any other needed server roles, services, and applications.  
  
6.  Identify the disks or LUNs that are exposed to the new one\-node failover cluster, and expose them to the newly installed server also.  
  
    We recommend that you keep a small disk or LUN accessible to both nodes, and unused by clustered services and applications, throughout the life of the cluster. With this LUN, you can always run storage validation tests without taking your services and applications offline.  
  
### <a name="BKMK_ValidateBothNodes"></a>To perform a full validation of both cluster nodes  
  
1.  On either server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], open **Failover Cluster Manager** from the Start screen.  
  
2.  In the console tree, confirm that **Failover Cluster Manager** is selected, and then, in the center pane, under **Management**, click **Validate Cluster**.  
  
3.  Follow the instructions in the Validate a Configuration Wizard, but this time, be sure to specify both servers \(not just the existing cluster node\) and specify that you want to run all tests. Then, run the tests. Because two nodes are now being tested, a more complete set of tests runs, which takes longer than testing one node.  
  
    > [!IMPORTANT]  
    > If any cluster role is using a disk when you start the wizard, the wizard asks whether to take that cluster role offline for testing. If you choose to take a cluster role offline, the role remains offline until the tests are complete.  
  
4.  On the **Summary** page, which appears after the tests run, review the test results:  
  
    -   Click **View Report** and view the full set of test results in the Failover Cluster Validation Report.  
  
        > [!NOTE]  
        > To view the results of the tests after you close the wizard, open the report on the following path:  
        >   
        > *systemroot*\\Cluster\\Reports\\Validation Report *date and time*.mht  
        >   
        > where *systemroot* is the folder in which the operating system is installed \(for example, C:\\Windows\\\).  
  
    -   To view Help topics to help you interpret the results, click **More about cluster validation tests**.  
  
5.  As necessary, make changes in the configuration, and then rerun the tests.  
  
> [!NOTE]  
> For more information about failover cluster validation tests, see [Validate Hardware for a Failover Cluster](http://technet.microsoft.com/library/jj134244.aspx).  
  
### <a name="BKMK_AddNode2"></a>To add the node to the cluster  
  
1.  If the new cluster is not displayed, in the console tree, right\-click **Failover Cluster Manager**, click **Connect to Cluster**, and then select the new cluster.  
  
2.  Select the new cluster in the console tree. Then, on the **Actions** pane, click **Add Node**.  
  
3.  Follow the instructions in the wizard to specify the server that you want to add to the cluster. On the **Summary** page, click **View Report** to review the tasks that the wizard performed.  
  
    After the wizard closes, you can view the report in the *systemroot*\\Cluster\\Reports\\ folder.  
  
    > [!NOTE]  
    > After you close the wizard, in the center pane, you might see a warning about “Node Majority.” You will correct this issue when you configure quorum settings for the new cluster.  
  
### <a name="BKMK_VerifyStorageforNewCluster"></a>To verify storage for the new cluster  
  
1.  In the console tree of Failover Cluster Manager, select the new cluster.  
  
2.  Expand **Storage**. Then check to see if all the disks that you want to make available to the new cluster are shown, either in one of the clustered services or applications or in **Available Storage**.  
  
3.  In most cases, you need at least one disk in **Available Storage** for your next task \(specifying a witness disk\). If you need to add a disk, on the **Actions** pane, click **Add Disk**, and follow the steps in the wizard.  
  
    Before you can add a disk to storage, the disk must be accessible from both nodes in the cluster. To be used for a witness disk, a disk can be a relatively small, but must be at least 512 MB.  
  
### <a name="BKMK_ConfigureClusterQuorum"></a>To configure quorum settings for the new cluster  
  
1.  In the console tree of Failover Cluster Manager, right\-click the new cluster, click **More Actions**, and then click **Configure Cluster Quorum Settings**.  
  
2.  Follow the instructions in the wizard to select the most appropriate quorum setting for your needs. In most cases, this is the Node Majority quorum configuration, which requires that you specify an appropriate disk \(from **Available Storage**\) for the witness disk. For more information about quorum settings in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [Configure and Manage the Quorum in a Windows Server 2012 Failover Cluster](http://technet.microsoft.com/library/jj612870.aspx).  
  
## <a name="BKMK_SectionVerifyFailover"></a>Verify failover for the migrated cluster roles  
Earlier, after you copied the cluster roles to the new single\-node cluster, you verified that workloads were accessible on the new cluster and that the services and applications performed as expected. Now that you have a multi\-node cluster, and have configured quorum settings, you can verify failover for the migrated cluster roles.  
  
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
  
