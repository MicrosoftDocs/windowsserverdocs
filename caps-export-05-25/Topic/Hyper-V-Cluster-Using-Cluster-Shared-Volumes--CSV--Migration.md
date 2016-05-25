---
title: Hyper-V Cluster Using Cluster Shared Volumes (CSV) Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9159fbc-e393-47b7-b8ae-6325da55bcef
author: cwatsonmsft
---
# Hyper-V Cluster Using Cluster Shared Volumes (CSV) Migration
This scenario describes how to migrate virtual machines from a Hyper\-V cluster by using Cluster Shared Volumes \(CSV\) that run on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system. This scenario reuses the existing CSVs. Migrating the storage to a Scale\-out File Server is beyond the scope of the scenario.  
  
The Copy Cluster Roles Wizard is used to move the virtual machine roles to the new cluster.  
  
### Copy Cluster Roles Wizard  
The Copy Cluster Role Wizard helps you copy cluster roles from clusters that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a new cluster that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
The Copy Cluster Role Wizard assumes that storage is to be reused between the old cluster and the new cluster. The only data that is copied is the cluster role settings.  
  
You can use the Copy Cluster Roles Wizard to do the following:  
  
-   Test the Copy Cluster Roles process without affecting production.  
  
-   Reverse the process if you encounter any issues.  
  
-   Copy roles on test clusters to production clusters.  
  
Before you migrate the virtual machines from the old cluster, perform the following actions:  
  
-   Before you run the wizard, you must ensure that the new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] cluster is configured and is connected to the same logical unit numbers \(LUNs\) storage as the old Hyper\-V cluster. For more information about installing a Hyper\-V cluster, see [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md).  
  
-   Before you work with shadow copies, you should back up all volumes that are attached to the virtual machines.  
  
-   Merge or discard all shadow copies for the volumes that store the virtual machines.  
  
-   Ensure that no virtual machines that you do not want to migrate share a CSV volume with virtual machines that you plan to migrate.  
  
-   Install the latest updates on all cluster nodes on both clusters.  
  
> [!IMPORTANT]  
> When you run the Copy Cluster Roles Wizard, the virtual machines are created on the new cluster, but they are not turned on. The virtual machines on the old cluster are still running. After the wizard has finished, you must turn off the virtual machines and take the disk offline on the old cluster. Then, on the new cluster, you must enable the disk and start the virtual machines. There is some downtime, but its duration should be limited, and you control when the downtime occurs.  
  
> [!CAUTION]  
> The Copy Cluster Roles Wizard does not copy the replication settings for a virtual machine. After a virtual machine that has Hyper\-V replication enabled is moved by using the Copy Cluster Roles Wizard, Hyper\-V replication must be removed and be re\-enabled.  
  
##### To run the Copy Cluster Roles Wizard  
  
1.  You must be a local administrator on the new and old clusters to run the Copy Cluster Roles Wizard.  
  
2.  On the new cluster, open Failover Cluster Manager.  
  
3.  Select the top node for the cluster, and then click **Copy Cluster Roles** in the **Configure** window.  
  
4.  On the **Specify Old Cluster** page, enter the name of the old cluster.  
  
5.  On the **Select Roles** page, select the role that you want to copy.  
  
    > [!NOTE]  
    > All the virtual machines that are running on a CSV must be migrated at the same time. When you select one virtual machine on a CSV, it automatically selects all of the virtual machines on that CSV.  
  
6.  On the **Customize Virtual Machine Networks** page, specify which virtual network switch is to be used by the virtual machines on the new cluster.  
  
    Click **View Report**, to view the Pre\-migration report.  
  
7.  Review the settings and complete the wizard.  
  
8.  Review the Failover Cluster Copy Roles Report to verify that the virtual machines were migrated.  
  
9. The virtual machines are still running on the old cluster, and the virtual machines that are created on the new cluster are off. Additionally, the CSV disk on the new cluster is offline.  
  
##### To run the virtual machine on new cluster  
  
1.  On the old cluster, open Failover Cluster Manager.  
  
2.  Turn off the virtual machines that have been migrated over to the new cluster.  
  
3.  Take the CSV disk offline.  
  
4.  \[Optional\] In the storage, unmask the CSV disk so that the old cluster can no longer use it.  
  
    > [!NOTE]  
    > Depending on storage topology, LUN masking and LUN unmasking might be necessary at this stage to ensure that the old cluster does not have write access to the disks or LUNS that are used by the new cluster.  
  
    > [!WARNING]  
    > At no time should a virtual machine run on both the old cluster and the new cluster. A virtual machine that runs on both the old cluster and the new cluster at the same time might become corrupted. You can run a virtual machine on the old cluster while you migrate it to a new cluster with no problems; the virtual machine on the new cluster is created in a Stopped state. However, to avoid corruption, it is important that you do not turn on the virtual machine on the new cluster until after you stop the virtual machine on the old cluster.  
  
5.  On the new cluster, open Failover Cluster Manager.  
  
6.  Bring the CSV disk online.  
  
7.  Start the virtual machines and verify that the virtual machine runs correctly.  
  
    > [!NOTE]  
    > If the cluster that is migrated is a Hyper\-V Replica server, do not start the virtual machines and go to step 9.  
  
    -   Run the necessary application\-specific tests to ensure that the application on the virtual machine can provide the same service levels as it provided before the virtual machine was migrated.  
  
    -   Verify that you can connect to the virtual machine by using **Remote Desktop** or **Virtual Machine Connection**.  
  
8.  Update integration services on each virtual machine.  
  
9. **\[Optional\]** For virtual machines that are copied from a Hyper\-V Replica server, you must remove replication and re\-enable replication for the virtual machine on the Hyper\-V primary server to re\-establish replication.  
  
    1.  Open Failover Cluster Manager on the cluster where the primary virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine whose Replica virtual machine was copied, and in the **Actions** pane, select **Replication**, and then select **Remove Replication**.  
  
    3.  Select the virtual machine, and in the **Actions** pane, select **Replication**, and then select **Enable Replication**. This action opens the **Enable Replication Wizard**.  
  
        -   On the **Specify Replica Server** page, specify the name of the Hyper\-V Replica Broker in the **Replica server** box.  
  
        -   On the **Choose Initial Replication Method** page, select **Use an existing virtual machine on the Replica server as the initial copy**.  
  
10. **\[Optional\]** For virtual machines that are copied from a Hyper\-V primary server, you must remove replication from the Replica virtual machine and enable replication on the virtual machine on the Hyper\-V primary server to re\-establish replication.  
  
    Perform the following steps on the Replica virtual machine:  
  
    1.  Open Failover Cluster Manager on the cluster where the Replica virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine whose primary virtual machine was copied, and in the **Actions** pane, select **Replication**, and then select **Remove Replication**.  
  
    Perform the following steps on the primary virtual machine:  
  
    1.  Open Failover Cluster Manager on the new cluster where the primary virtual machine is running and select **Roles**.  
  
    2.  Select the virtual machine that was just copied, and in the **Actions** pane, select **Replication**, and then select **Enable Replication**. This action opens the **Enable Replication Wizard**.  
  
        -   On the **Specify Replica Server** page, specify the name of the Hyper\-V Replica Broker in the **Replica server** box.  
  
        -   On the **Choose Initial Replication Method** page, select **Use an existing virtual machine on the Replica server as the initial copy**.  
  
## See also  
[Migrating Clustered Services and Applications to Windows Server 2012](assetId:///40adc868-a787-4062-bacb-61207538d4ce)  
  
[Cluster Migrations Involving New Storage: Mount Points](../Topic/Cluster-Migrations-Involving-New-Storage--Mount-Points.md)  
  
[Deploy Hyper\-V Replica](assetId:///7c4f0c15-e88e-4067-84cf-8caa469298da)  
  
