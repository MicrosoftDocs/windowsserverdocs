---
title: Migrate a Scale-Out File Server to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 199013aa-1202-48d0-a4e5-5a7428094065
author: kumudd
---
# Migrate a Scale-Out File Server to Windows Server 2012 R2
This topic discusses how to migrate a Scale\-Out File Server from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Overview  
There are several methods available to migrate a Scale\-Out File Server. Some considerations include whether you can afford to have some limited downtime and have extra storage hardware available.  
  
## Method 1: Migrate storage  
This method involves the live migration of the old storage to the new storage.  
  
The advantages of this method include:  
  
-   No downtime is required.  
  
The disadvantages of this method include:  
  
-   Additional storage \(of the same or larger capacity\) is required.  
  
-   Time and resources are required to move all of the data over the network.  
  
#### To migrate storage using live migration  
  
1.  Set up a new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster \(for storage\). For more information, see [Create a Failover Cluster](../Topic/Create-a-Failover-Cluster.md).  
  
2.  Configure access to the new failover cluster.  
  
3.  Migrate the storage of each virtual machine. For more information, see [How to Run a Live Migration in VMM](http://technet.microsoft.com/library/jj860434.aspx).  
  
## Method 2: Migrate using the Copy Cluster Role Wizard  
This method involves using the Copy Cluster Role Wizard to migrate cluster resources without having to move the data itself.  
  
The advantages of this method include:  
  
-   No data is moved over the network.  
  
-   No additional storage hardware is required.  
  
The disadvantages of this method include:  
  
-   Some downtime is required.  
  
-   Additional storage nodes are required.  
  
-   Some changes to storage cables may be required.  
  
#### To migrate using the Copy Cluster Role Wizard  
  
1.  Set up a new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] failover cluster \(for storage\). For more information, see [Create a Failover Cluster](../Topic/Create-a-Failover-Cluster.md).  
  
2.  Connect the new failover cluster to the existing storage.  
  
3.  Use the Copy Cluster Role Wizard to copy clustered roles. The Copy Cluster Roles Wizard supports migration to a new cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] from a cluster running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. After the virtual machine has been created on the new cluster, to complete the migration you are required to shut down each virtual machine on the source cluster before starting up the virtual machine on the destination cluster. For more information, see [Migrate Cluster Roles to WIndows Server 2012 R2](assetId:///2b07e52a-da12-448f-9aa8-966fc8b825e9).  
  
4.  Downtime starts when you remove cluster roles on the old cluster, and then add cluster roles on the new cluster.  
  
5.  When the downtime ends, the scale\-out file server is migrated.  
  
## Method 3: In\-place upgrade  
This method allows you to reuse existing cluster nodes and existing storage to migrate without moving data over the network.  
  
The advantages of this method include:  
  
-   No data is moved over the network.  
  
-   No additional storage hardware is required.  
  
-   No additional storage nodes are required.  
  
-   No changes to storage cables are required.  
  
The disadvantages of this method include:  
  
-   Limited downtime is required.  
  
-   Reduced availability when migrating.  
  
#### To migrate using an in\-place upgrade  
  
1.  Prepare to upgrade by doing the following:  
  
    1.  Evict a cluster node from the old failover cluster \(at this stage, if you have limited cluster nodes, high availability is degraded.  
  
    2.  Upgrade or perform a clean installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the evicted node.  
  
    3.  Create a new failover cluster with the evicted node.  
  
    4.  Use the Copy Cluster Roles Wizard to copy clustered roles from the cluster.  
  
2.  Migrate storage. Downtime starts when you remove cluster roles on the old cluster, and then add cluster roles on the new cluster and ends and the scale\-out file server is migrated.  
  
3.  Upgrade or perform a clean installation on the remaining cluster nodes.  
  
4.  Join the remaining nodes to the new failover cluster \(at this stage, high availability is restored\).  
  
## Method 4: Move storage pools  
This method involves the live migration of storage, one storage pool at a time. To use this method, the storage must be configured with:  
  
-   At least four cluster nodes on the file server  
  
-   At least four storage pools  
  
-   Enough available capacity on the storage to allow the evacuation of an entire pool  
  
The advantages of this method include:  
  
-   No downtime.  
  
-   No additional storage hardware is required.  
  
-   No additional storage nodes are required.  
  
-   No changes to storage cables are required.  
  
The disadvantages of this method include:  
  
-   Available capacity is required on existing storage \(sufficient to evacuate the entire storage pool\).  
  
-   The process of evacuating the storage pools is complex and moving data is required.  
  
-   Time and resources are required to move all data over the network.  
  
#### To move storage pools  
  
1.  Split the failover cluster.  
  
    1.  Evict the cluster nodes on the existing storage cluster.  
  
    2.  Upgrade the evicted nodes to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    3.  Create a side\-by\-side failover cluster with shared access to the storage.  
  
2.  Migrate the storage pools.  
  
    1.  Evacuate a pool of storage \(using storage live migration\).  
  
    2.  Migrate a pool of storage \(using storage live migration\).  
  
3.  Destroy the old failover cluster, upgrade the cluster nodes, and join the nodes to the new failover cluster.  
  
4.  Repeat these steps until all storage pools are migrated.  
  
5.  Rebalance the new failover cluster as necessary \(using storage live migration\).  
  
## See also  
The following list provides additional resources on the web about SMB and related technologies in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)  
  
-   [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
-   [Failover Clustering overview](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)  
  
