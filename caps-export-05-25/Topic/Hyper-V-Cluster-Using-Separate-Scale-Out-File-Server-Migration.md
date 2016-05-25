---
title: Hyper-V Cluster Using Separate Scale-Out File Server Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2c967ac5-96f8-49bb-a290-56ba8dfd1954
author: cwatsonmsft
---
# Hyper-V Cluster Using Separate Scale-Out File Server Migration
This scenario describes how to migrate virtual machines from a Hyper\-V cluster by using a separate Scale\-out File Server that runs on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system. In this scenario,  you move the virtual machines that runs on a Hyper\-V cluster from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a Hyper\-V cluster that runs on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Depending on your requirements, you have two main options to move your virtual machines from a Hyper\-V cluster that runs on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a Hyper\-V cluster that runs on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For information about the advantages or disadvantages for each option, see [Hyper-V: Migration Options](../Topic/Hyper-V--Migration-Options.md).  
  
-   [Cross version live migration](../Topic/Hyper-V-Cluster-Using-Separate-Scale-Out-File-Server-Migration.md#bkmk_cross)  
  
-   [Copy Cluster Roles Wizard](../Topic/Hyper-V-Cluster-Using-Separate-Scale-Out-File-Server-Migration.md#bkmk_ccrw)  
  
> [!NOTE]  
> Because the Hyper\-V cluster and Scale\-Out File Server run on separate clusters, you can upgrade each cluster independently of the other. This topic only describes how to move the virtual machines to a new Hyper\-V cluster, while the storage remains on the same Scale\-out File Server.  
  
### <a name="bkmk_cross"></a>Cross\-version live migration  
With cross\-version live migration, you can move a running virtual machine from a server running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a server running Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Cross\-version live migration does not support moving a virtual machine to a down\-level version of Hyper\-V.  
  
> [!IMPORTANT]  
> To use cross\-version live migration, the virtual machine must be removed from the cluster. The virtual machine is then moved to one of the servers in the new cluster. After the virtual machine has successfully moved to the new server, the virtual machine is configured for high availability on the new cluster. During this process, the virtual machine is not highly available.  
  
In this option, you must create a new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Hyper\-V cluster. You have various options to create the new Hyper\-V cluster:  
  
-   Evict two nodes from the existing cluster and create a new two\-node cluster.  
  
-   Evict one node from the existing cluster and use new hardware to create a new two\-node cluster.  
  
-   Use two new servers to create the new cluster.  
  
-   Evict one node from the existing cluster and create the new one\-node cluster. Until a second node is added, the virtual machines that are moved to the new cluster are not highly available.  
  
-   Use one new server to create a new cluster with one node. Until a second node is added, the virtual machines that are moved to the new cluster are not highly available.  
  
Now that the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Hyper\-V cluster is running, you can move the virtual machines that are currently running on one of the nodes to the new cluster.  
  
> [!IMPORTANT]  
> The folder that Hyper\-V uses to store virtual machine data requires specific permissions to access the Server Message Block \(SMB\) file share. You must ensure that the Hyper\-V computer accounts, the SYSTEM account, and all Hyper\-V administrators have full control permissions. For more information about deploying Hyper\-V over SMB, see [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98).  
  
#### Cross\-version live migration scenario  
The following migration scenario is based on the following factors:  
  
The following table lists the servers at the start of the migration.  
  
For the old cluster, there are three servers running Hyper\-V with eight highly available virtual machines.  
  
A two\-node [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cluster has been prepared and is ready to receive the virtual machines from the server running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> You must enable and configure Hyper\-V live migration on all of the servers running Hyper\-V.  
  
|Name|Windows Server operating system|Cluster name|  
|--------|-----------------------------------|----------------|  
|HVSRV1|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|HVHA2012|  
|HVSRV2|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|HVHA2012|  
|HVSRV3|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|HVHA2012|  
|HVR2\_1|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|HVHAR2|  
|HVR2\_2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|HVHAR2|  
  
The following table lists the virtual machines that are currently running on each of the nodes at the start of the migration.  
  
|Virtual machine name|Server running Hyper\-V|  
|------------------------|---------------------------|  
|Testvm\_1|HVSRV1|  
|Testvm\_2|HVSRV1|  
|Testvm\_3|HVSRV2|  
|Testvm\_4|HVSRV2|  
|Testvm\_5|HVSRV3|  
|Testvm\_6|HVSRV3|  
  
The following are the general steps to move the virtual machines from the HVHA2012 cluster to the new HVHAR2 cluster.  
  
1.  Create a new Hyper\-V cluster by using a separate Scale\-Out File Server.  
  
2.  Move all of the virtual machines from HVSRV1 to HVR2\_1.  
  
    1.  On the HVHA2012 cluster, remove one virtual machine that runs on HVSRV1. The virtual machine still runs on Hyper\-V, but it is no longer highly available.  
  
    2.  From the Hyper\-V Manager console, move the virtual machine that was removed in step 2a to the HVR2\_1 server. Because there is shared storage, you must move only the virtual machine, not the storage.  
  
    3.  On the HVHAR2 cluster, add the virtual machine that was moved to HVR2\_1 in step 2b to the new cluster. The virtual machine is now highly available.  
  
    4.  Repeat steps 2a\-2c until all of the virtual machines from HVSRV1 node have been moved to the new R2Cluster cluster.  
  
3.  Evict HVSRV1 from the HVHA2012 cluster.  
  
4.  Install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on HVSRV1, and then join the server to the HVHAR2 cluster.  
  
5.  Repeat steps 2\-4 for HVSRV2 and HVSRV3.  
  
> [!NOTE]  
> When you get down to the last two servers in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] cluster, if you evict another node, you have a single\-node cluster, and the remaining virtual machines are no longer highly available. If there is enough capacity on the new cluster to run the remaining virtual machines, move all of the remaining virtual machines to the new cluster, and then evict the last two servers at the same time.  
  
###### To create a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Hyper\-V cluster  
  
1.  Create a new Hyper\-V cluster that is connected to the same Scale\-out File Server, to which [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is connected.  
  
    Configure live migration on the new servers running Hyper\-V and the old servers running Hyper\-V.  
  
    If Hyper\-V replication is enabled, configure the Hyper\-V Replica Broker on the new cluster, HVHAR2.  
  
    For more information about creating a Hyper\-V cluster, see [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md).  
  
    > [!IMPORTANT]  
    > The folder that Hyper\-V uses to store virtual machine data requires specific permissions to access the SMB file share. You must ensure that the Hyper\-V computer accounts, the SYSTEM account, and all Hyper\-V administrators have full control permissions. For more information about deploying Hyper\-V over SMB, see [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98).  
  
##### <a name="bkmk_movevms"></a>To move the virtual machines to the new cluster  
  
1.  On HVSRV1, open the Failover Cluster Manager and select **Nodes**.  
  
2.  Right\-click the HVSRV1 node, and then click **Pause** and **Do Not Drain Roles**.  
  
3.  In the information pane for the HVSRV1, select **Roles** to see the virtual machines on the node.  
  
4.  Right\-click the **Testvm\_1** virtual machine, and then select **Remove**. The virtual machine is still running but is no longer highly available.  
  
5.  On HVSRV1, open the Hyper\-V Manager console.  
  
6.  Right\-click the **Testvm\_1** virtual machine, and then select **Move**.  
  
    1.  On the **Choose Move Type** page, select **Move the virtual machine**.  
  
    2.  On the **Specify Destination Computer** page, specify the name or server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], HVR2\_1. Do not enter the name of the new cluster, HVHAR2.  
  
    3.  On the **Choose Move Options** page, select **Move only the virtual machine**.  
  
    You can also use the [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet **Move\-VM**. In the following example, a virtual machine *test VM* was moved to a remote computer *NewServer* where the virtual machine is stored on an SMB share.  
  
    ```  
    PS C:\> Move-VM –Name "Test VM" –DestinationServer NewServer  
    ```  
  
7.  After the move finishes successfully, on HVR2\_1, open Hyper\-V Manager and confirm that the virtual machine runs correctly.  
  
8.  On HVR2\_1, open the Failover Cluster Manager, and then select **Roles**.  
  
9. In the **Actions** pane, select **Configure Roles** to open the **High Availability Wizard**.  
  
    On the **Select Role** page, select **Virtual Machine**.  
  
    On the **Select Virtual Machine** page, select **Testvm\_1**.  
  
10. The virtual machine is now highly available.  
  
11. Update the integration services on **Testvm\_1**. Because the virtual machine was never shut down during the migration, you can update the integration services silently without a restart. The update occurs the next time that the virtual machine is restarted during its scheduled maintenance period.  
  
    1.  Modify the settings of the virtual machine and specify the following media to be used for the CD\/DVD drive, *%Systemroot%\\System32\\Vmguest.iso*.  
  
    2.  Run the following command from an elevated command prompt in the virtual machine:  
  
        1.  For 64\-bit Windows Server operating systems, *drive:\\\\Support\\Amd64\\Setup.exe \/quiet \/norestart*.  
  
        2.  For 32\-bit Windows Server operating systems, *drive:\\\\Support\\X86\\Setup.exe \/quiet \/norestart*.  
  
12. Repeat steps 1 – 11 for all of the virtual machines on HVSRV1.  
  
13. **\[Optional\]** For virtual machines that are moved from a Hyper\-V Replica server, you must update the virtual machine replication settings on the Hyper\-V primary server to reestablish replication.  
  
    1.  Open Failover Cluster Manager on the cluster where the primary virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine, and then select **Settings** from the **Actions** pane.  
  
    3.  Select **Replication** and update the value for the **Replica server** with the name of the Hyper\-V Replica Broker that runs on the new cluster, HVHAR2.  
  
#### <a name="bkmk_moveoldnode"></a>Migrate the old cluster node to the new cluster  
After all of the virtual machines from HVSRV1 have been moved to the HVHAR2 cluster, you can evict HVSRV1 from the HVHA201 cluster, install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and join the HVHAR2 cluster.  
  
###### To evict the node from the old cluster  
  
1.  On HVSRV2, open the Failover Cluster Manager and select **Nodes**.  
  
2.  Select **HVSRV1** and confirm that there are no virtual machines that have moved to **HVSRV1**.  
  
3.  Right\-click **HVSRV1** to select **More Actions**, and then select **Evict**.  
  
###### To install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and join the new Hyper\-V cluster  
  
1.  Install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on HVSRV1.  
  
2.  Install the Hyper\-V role and Failover Clustering feature if a clean installation was performed.  
  
3.  On HVR2\_1, open the Failover Cluster Manager, and then select **Nodes**.  
  
4.  In the **Actions** pane, select **Add Node** to open the **Add Node Wizard**.  
  
    Enter the name of the server to be added to the cluster, **HVSRV1**.  
  
    Review the report.  
  
#### To move the remaining virtual machines  
Repeat the following procedures for the HVSRV2 and HVSRV3 servers to complete the migration.  
  
-   [Move the virtual machines to the new cluster.](../Topic/Hyper-V-Cluster-Using-Separate-Scale-Out-File-Server-Migration.md#bkmk_movevms)  
  
-   [Migrate the old cluster node to the new cluster](../Topic/Hyper-V-Cluster-Using-Separate-Scale-Out-File-Server-Migration.md#bkmk_moveoldnode)  
  
### <a name="bkmk_ccrw"></a>Copy Cluster Roles Wizard  
The Copy Cluster Role Wizard helps you copy clustered roles from clusters running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a new cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. After the virtual machine has been created on the new cluster, to complete the migration, you must shut down each virtual machine on the source cluster before you start the virtual machine on the destination cluster.  
  
You can use the Copy Cluster Roles Wizard to do the following:  
  
-   Test the Copy Cluster Roles process without affecting production.  
  
-   Reverse the process if you encounter any issues.  
  
-   Copy roles on test clusters to production clusters.  
  
The Copy Cluster Role Wizard assumes that storage is reused between the old cluster and the new cluster. The cluster role settings are the only data that is copied.  
  
Before migration of the virtual machines from the old cluster, perform the following actions:  
  
-   Before running the wizard, you must ensure that the new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cluster is configured and is connected to the same storage as the old Hyper\-V cluster. For more information about installing a Hyper\-V cluster, see [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md).  
  
-   Before you work with shadow copies, you should back up all volumes that are attached to the virtual machines.  
  
-   Merge or discard all shadow copies for the volumes that store the virtual machines.  
  
-   Install the latest updates on all cluster nodes on both clusters.  
  
> [!IMPORTANT]  
> When you run the Copy Cluster Roles Wizard, the virtual machines are created on the new cluster, but they are not turned on. The virtual machines on the old cluster are still running. After the wizard has finished, you must turn off the virtual machines on the old cluster, and then, on the new cluster, you must start the virtual machines. There is some downtime but its duration should be limited, and you control when the downtime occurs.  
  
##### To run the Copy Cluster Roles Wizard  
  
1.  You must have local Administrator rights on the new and old cluster to run the Copy Cluster Roles Wizard.  
  
2.  On the new cluster, open Failover Cluster Manager.  
  
3.  Select the top node for the cluster, and click **Copy Cluster Roles** from the **Configure** window.  
  
4.  On the **Specify Old Cluster** page, enter the name of the old cluster.  
  
5.  On the **Select Roles** page, select the role that you must copy.  
  
6.  On the **Customize Virtual Machine Networks** page, specify which virtual network switch the virtual machines are to use on the new cluster.  
  
7.  Review the settings and complete the wizard.  
  
8.  Review the Failover Cluster Copy Roles Report for any issues.  
  
9. The virtual machines are still running on the old cluster, and the virtual machines that are created on the new cluster are off.  
  
##### To run the virtual machine on new cluster  
  
1.  On the old cluster, open Failover Cluster Manager.  
  
2.  Turn off the virtual machines that have been copied over to the new cluster.  
  
    > [!WARNING]  
    > At no time should a virtual machine be running on both the old cluster and the new cluster. A virtual machine that runs on both the old cluster and the new cluster at the same time might become corrupted. You can run a virtual machine on the old cluster while you migrate it to a new cluster with no problems; the virtual machine on the new cluster is created in a Stopped state. However, to avoid corruption, it is important that you do not turn on the virtual machine on the new cluster until after you stop the virtual machine on the old cluster.  
  
3.  On the new cluster, open Failover Cluster Manager.  
  
4.  Start the virtual machines and verify that the virtual machine runs correctly.  
  
    > [!NOTE]  
    > If the migrated cluster is a Hyper\-V Replica server, do not start the virtual machines and go to step 6.  
  
    -   Run the necessary application\-specific tests to ensure that the application on the virtual machine can provide the same service levels as it provided before the virtual machine was migrated.  
  
    -   Verify that you can connect to the virtual machine by using **Remote Desktop** or **Virtual Machine Connection**.  
  
5.  Update integration services on each virtual machine.  
  
6.  **\[Optional\]** For virtual machines that were copied from a Hyper\-V Replica server, you must remove replication and re\-enable replication of the virtual machine on the Hyper\-V primary server to reestablish replication.  
  
    1.  Open Failover Cluster Manager on the cluster where the primary virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine whose Replica virtual machine was copied, and in the **Actions** pane, select **Replication**, and then select **Remove Replication**.  
  
    3.  Select the virtual machine, and in the **Actions** pane, select **Replication**, and then select **Enable Replication**. This process opens the **Enable Replication Wizard**.  
  
        -   On the **Specify Replica Server** page, specify the name of the Hyper\-V Replica Broker in the **Replica server** box.  
  
        -   On the **Choose Initial Replication Method** page, select **Use an existing virtual machine on the Replica server as the initial copy**.  
  
7.  **\[Optional\]** For virtual machines that are copied from a Hyper\-V primary server, you must remove replication from the Replica virtual machine and enable replication on the virtual machine on the Hyper\-V primary server to re\-establish replication.  
  
    Perform the following steps on the Replica virtual machine:  
  
    1.  Open Failover Cluster Manager on the cluster where the Replica virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine whose primary virtual machine was copied, and in the **Actions** pane, select **Replication**, and then select **Remove Replication**.  
  
    Perform the following steps on the primary virtual machine:  
  
    1.  Open Failover Cluster Manager on the new cluster where the primary virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine that was just copied, and in the **Actions** pane, select **Replication**, and then select **Enable Replication**. This process opens the **Enable Replication Wizard**.  
  
        -   On the **Specify Replica Server** page, specify the name of the Hyper\-V Replica Broker in the **Replica server** box.  
  
        -   On the **Choose Initial Replication Method** page, select **Use an existing virtual machine on the Replica server as the initial copy**.  
  
## See also  
[Migrating Clustered Services and Applications to Windows Server 2012](assetId:///40adc868-a787-4062-bacb-61207538d4ce)  
  
[Configuring Hyper\-V Replica Broker in a Failover Cluster](assetId:///a037f0a5-1591-4a56-85fb-4ffa8db1e383)  
  
[Hyper\-V Replica Feature Overview](assetId:///b426b7ba-162d-4829-9092-833312e00eee)  
  
