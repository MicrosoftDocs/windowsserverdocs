---
title: Hyper-V: Migration Options
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f45c89b-f201-4373-99a3-3d1c28be38a5
author: cwatsonmsft
---
# Hyper-V: Migration Options
When you migrate virtual machines from the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system, you have various options on how to migrate your virtual machines. You now can select the migration options that meet the requirements of your environment.  
  
## <a name="bmbk_options"></a>Hyper\-V migration options  
Depending on your requirements and service level agreements that must be maintained, you can use one migration option or a combination of migration options. For example, if you have virtual machines that either must be running all the time or that only have a short maintenance  period for you to shut them down, you might select to use cross\-version live migration to move the virtual machines from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For other virtual machines that are not as critical, have a long maintenance period, or might take too long to move by using live migration, you can use the Copy Cluster Roles Wizard or Export and  Import, which depends on your environment.  
  
The following table shows the benefits and disadvantages of the various migration options.  
  
|Migration option|Benefits|Disadvantages|  
|--------------------|------------|-----------------|  
|In\-place upgrade|-   No new hardware required.|-   Virtual machines must be shut off during the upgrade.|  
|Cross\-version live migration|-   Virtual machines continue running during migration.<br />-   If the virtual hard disk is stored on a Scale\-out File Server share that is accessible from both servers, the virtual hard disks do not have to be copied.<br />-   Moves virtual machines from one Hyper\-V cluster to another cluster without any downtime.<br />-   Migrates individual virtual machines that are part of the Hyper\-V cluster.|-   Requires additional hardware or extra capacity in the existing cluster to create the destination cluster.<br />-   The amount of time it takes to migrate a virtual machine depends on various factors, for example, the size of memory that is configured for the virtual machine and the network configuration. If the virtual hard disks are not stored on a Scale\-out File Server, additional time is required to move the virtual hard disk.<br />-   The virtual machine must be removed from the existing cluster before it is moved to the new cluster. After the virtual machine has successfully moved to new cluster node, high availability is added to the virtual machine. During the move process, the virtual machine is not protected by the cluster services.|  
|Copy Cluster Roles Wizard|-   Easily migrates a Hyper\-V cluster from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].<br />-   Tests the Copy Cluster Roles process without affecting production.<br />-   Reverses the process if you encounter any issues.<br />-   Copies roles on test clusters to production clusters.|-   All virtual machines on the same Shared Clustered Volume are migrated at the same time.<br />-   Virtual machines must be shut down for a short period of time.<br />-   The Copy Cluster Wizard does not copy the Hyper\-V replication settings when it copies a virtual machine to a new failover cluster. Hyper\-V replication must be re\-enabled on the virtual machine after it is copied. For the **Initial Replication Method**, select **Use an existing virtual machine on the Replica server as the initial copy**.<br />-   Requires additional hardware.|  
|Export and Import|-   Migrates one virtual machine at a time.<br />-   Controls the method of copying the virtual machine to the new server.|-   The virtual machine is shut down during the Export \/ Import process.<br />-   Requires additional hardware.<br />-   The Import of a virtual machine removes any Hyper\-V Replica configuration settings for a virtual machine. Hyper\-V replication must be re\-enabled on the virtual machine after it is imported. For the **Initial Replication Method**, select **Use an existing virtual machine on the Replica server as the initial copy**.|  
  
The following table shows the available options to use in different deployments of Hyper\-V.  
  
|Scenario \/ Migration option|In\-place upgrade|Export \/ Import|Cross\-version live migration|Copy Cluster Roles Wizard|  
|--------------------------------|---------------------|--------------------|---------------------------------|-----------------------------|  
|Standalone host|Yes|Yes|Yes|No|  
|Hyper\-V Cluster with Cluster Shared Volumes \(CSV\)|No|Yes|Yes, the virtual machine must be removed from the cluster first, and the virtual hard disks must be copied as part of the live migration.|Yes|  
|Hyper\-V Cluster with a separate Scale\-out File Server for storage|No|Yes|Yes, the virtual machine must be removed from the cluster first.|Yes|  
  
> [!IMPORTANT]  
> When Hyper\-V Replica is enabled, we recommend that you migrate the virtual machines on the Replica site first, and then migrate the primary site.  
  
### Cross\-version live migration  
The upgrade to a new version of Windows Server no longer requires downtime of the virtual machines. In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Hyper\-V live migration has been updated to support the migration of virtual machines in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If the virtual hard disk files are stored on an SMB 3.0 share that is accessible from both the source and destination server, you only must move the virtual machine configuration and memory files, but not the virtual hard disk files. If the virtual hard disk files are not stored on an SMB 3.0 share, or if the share is not accessible to the destination server, you can use the Shared Nothing Live Migration to migrate the virtual hard disk files, virtual machine configuration files, and the running virtual machine with no downtime.  
  
## Hyper\-V Replica  
Hyper\-V Replica was introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and provides asynchronous replication of Hyper\-V virtual machines between two hosting servers. It is simple to configure and does not require either shared storage or any particular storage hardware. Any server workload that can be virtualized in Hyper\-V can be replicated. Replication works over any ordinary IP\-based network, and the replicated data can be encrypted during transmission. Hyper\-V Replica works with standalone servers, failover clusters, or a mixture of both. The servers can be physically co\-located or widely separated geographically. The physical servers do not have to be in the same domain or even be joined to any domain at all.  
  
Consider the following factors for the move from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] when you use Hyper\-V Replica:  
  
-   You must upgrade the Replica server first. A [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Replica server can accept replication from a primary server that runs [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. However, a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Replica server cannot accept replication from a primary server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   When you upgrade the Replica server, consider the following factors:  
  
    -   When you perform an in\-place upgrade on the Replica server, the post\-upgrade of the Replica server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] replication continues from the primary server that runs [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] at the default replication frequency of 5 minutes.  
  
    -   When you move the virtual machines to a new server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must update the virtual machine replication settings on the primary server with the name of the new Replica server or Hyper\-V Replica Broker. Until the Replica server name is updated, replication does not resume.  
  
    -   You can start to use new Hyper\-V Replica features, such as extended replication from the Replica server.  
  
    -   You can add new virtual machines to the primary server that runs [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and start replication to a Replica server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    -   In case of emergency, you can fail over your virtual machines from the primary server to the Replica server. You cannot start reverse replication because replication is not supported from [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
        > [!NOTE]  
        > At this point, the virtual machine is no longer protected by Hyper\-V Replica. You can configure extended replication by using another server running Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. After the primary server has been upgraded to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can reverse replication back to the primary server. When you reverse replication, you can select to use an existing virtual machine to limit the amount of replication that must be transmitted over the network.  
  
    -   Migration cancels a test failover that currently runs for a Replica virtual machine and deletes the test virtual machine.  
  
-   When you upgrade the primary server, consider the following factors:  
  
    -   The Replica server has already been upgraded to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If the Replica server has not been upgraded to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], replication fails until the Replica server is upgraded to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    -   Replication continues at the default frequency of 5 minutes, which can be modified if it is required.  
  
    -   When you use certificate\-based authentication for Hyper\-V Replica, after you move the primary virtual machine to a new server, you must update the certificate thumbprint for the virtual machine.  
  
        You can update the certificate thumbprint in the Hyper\-V Manager console by editing the Replication settings of the virtual machine, or you can use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet, **Set\-VMReplication**.  
  
        ```  
        Set-VMReplication –VMName <virtual machine name. –CertificateThumbprint <thumbprint>  
        ```  
  
## See also  
[Hyper\-V Replica Overview](assetId:///3d81d4f3-2db8-431b-9796-79ab4fe477be)  
  
[Virtual Machine Live Migration Overview](../Topic/Virtual-Machine-Live-Migration-Overview.md)  
  
[Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)  
  
[Failover Clustering overview](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)  
  
[Migrating Clustered Services and Applications to Windows Server 2012](assetId:///40adc868-a787-4062-bacb-61207538d4ce)  
  
