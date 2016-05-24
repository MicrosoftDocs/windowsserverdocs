---
title: Virtual Hard Disk Sharing Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 61e18c2b-18f0-40a9-a5ae-05645d0bf8c3
author: cwatsonmsft
---
# Virtual Hard Disk Sharing Overview
Starting in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Hyper\-V makes it possible to share a virtual hard disk file between multiple virtual machines. Sharing a virtual hard disk file \(.vhdx\) provides the shared storage that is necessary for a Hyper\-V guest failover cluster. This is also referred to as a virtual machine failover cluster. For information on creating and enabling a shared virtual hard disk, see [Configure a Shared Virtual Hard Disk](../Topic/Configure-a-Shared-Virtual-Hard-Disk.md).  
  
## Key benefits  
Sharing a virtual hard disk file \(.vhdx\) means that you can create and manage a guest failover cluster to protect the application services running inside your virtual machines. Before [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], if you wanted to create a Hyper\-V guest failover cluster, you needed to expose your storage topology to the virtual machine.  
  
Starting in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can deploy a Hyper\-V guest failover cluster that is no longer bound to your storage topology. You can implement a guest failover cluster by using a shared virtual hard disk, Fibre Channel, Server Message Block \(SMB\), Storage Spaces, or iSCSI storage options. Shared virtual hard disks are only available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Hyper\-V makes it possible to share a virtual hard disk file between multiple virtual machines. Sharing a virtual hard disk file \(.vhdx\) provides the shared storage that is necessary for a Hyper\-V guest failover cluster.  
  
Using a shared virtual hard disk is ideal for the following situations:  
  
-   SQL Server database files.  
  
-   File server services running within a virtual machine.  
  
-   Database files that reside on shared disks.  
  
> [!NOTE]  
> When you share a virtual hard disk file, these tasks aren't supported:  
>   
> -   Resizing  
> -   Migrating  
> -   Backing up or making replicas  
  
## Guest Failover Clusters  
The following information will help you understand and deploy a guest failover cluster by using a shared virtual hard disk.  
  
### Shared virtual hard disk format  
Shared virtual hard disk functionality in guest failover clusters exclusively uses the .vhdx file format. Although the shared virtual hard disk must use the .vhdx file format for the data drive, the operating system disk for a virtual machine can use either the .vhd or the .vhdx file format.  
  
### Supported virtual machines  
Generation 1 and Generation 2 virtual machines are supported in a guest failover cluster using a shared virtual hard disk.  
  
### Supported guest operating systems  
Supported guest operating systems for guest clusters that use a shared virtual hard disk include [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. To support [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as a guest operating system, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Integration Services must be installed within the guest \(virtual machine\).  
  
## Deploying a shared virtual hard disk in a guest failover cluster  
A Hyper\-V guest failover cluster that uses a shared virtual hard disk has two preferred deployment models. The shared virtual hard disk for the guest failover cluster can be deployed on:  
  
-   Cluster Shared Volumes \(CSVs\) on block storage \(including clustered Storage Spaces\).  
  
-   Scale\-Out File Server with SMB 3.0 on file\-based storage.  
  
A Hyper\-V guest failover cluster can be configured and deployed by using Hyper\-V Manager and Failover Cluster Manager. You can also use Windows PowerShell.  
  
> [!NOTE]  
> When you use shared VHDX with local block storage, synchronization must occur for shared VHDX file access. If the virtual machines are running on different nodes, this involves network redirection for the synchronization activity. If you have fast block connectivity combined with slow intra\-cluster network communication, this synchronization activity results in I\/O variance \(either redirected or direct\) based on the node. This happens on a per file basis. \(The entire CSV is not in redirected mode.\) To increase performance, we recommend that you scale the intra\-cluster network.  
>   
> Be aware that this is not a consideration when you use file\-based storage. When you use a compute layer of file\-based storage over SMB together with a remote Scale\-Out File Server \(SOFS\), this shared file access orchestration is performed by the SOFS. With a SOFS, SMB sessions are transitioned to optimize file access. The SMB sessions co\-exist on the same node that performs the synchronization. As a result, there is no network communication.  
  
For deployment steps, see [Deploy a Guest Cluster Using a Shared Virtual Hard Disk](../Topic/Deploy-a-Guest-Cluster-Using-a-Shared-Virtual-Hard-Disk.md).  
  
## Using Cluster Shared Volume  
One option for using virtual hard disk sharing is to use Cluster Shared Volumes. The following graphic provides an example configuration. You can also use other types of shared storage if required.  
  
![](../Image/Hyper-VGuestClusteringwithCSV.png)  
  
## Using Scale\-Out File Server with SMB 3.0  
A second option for virtual hard disk sharing is to use a Scale\-Out File Server. The following graphic provides an example configuration. You can also use other types of shared storage if required.  
  
![](../Image/Hyper-VwithScaleOutFileServerwithSMB3.png)  
  
## Requirements  
To configure a guest failover cluster that uses shared virtual hard disks, you require the following:  
  
-   At least a two\-node Hyper\-V failover cluster.  
  
-   Servers must be running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   Servers must belong to the same Active Directory domain.  
  
-   Availability of configured shared storage resources—for example, CSVs on block storage \(such as clustered storage spaces\) or a Scale\-Out File Server cluster \(running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\) with SMB 3.0 \(for file\-based storage\).  
  
-   Sufficient memory, disk, and processor capacity within the failover cluster to support multiple virtual machines that are implemented as guest failover clusters.  
  
## See Also  
[Hyper\-V Virtual Hard Disk Format Overview](assetId:///248806ae-6797-46d1-b1be-24cbf1bafba4)  
[Online Virtual Hard Disk Resizing Overview](../Topic/Online-Virtual-Hard-Disk-Resizing-Overview.md)  
  
