---
title: Plan for live migration in Windows Server 2016
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 21a6f01a-04d2-45c8-b8c3-9edd6d5005d1
author: cwatsonmsft
---
# Plan for live migration in Windows Server 2016
Hyper\-V live migration moves running virtual machines from one physical server to another with no impact on virtual machine availability to users. Hyper\-V in  Windows Server 2012  and  Windows Server 2012 R2  introduce the following live migration improvements:  
  
**Faster and simultaneous migration.**  
  
In  Windows Server 2012  live migrations are now able to utilize higher network bandwidths \(up to 10 Gigabit\) to complete migrations faster. You can also perform multiple simultaneous live migrations to enable you to move many virtual machines quickly. These changes allow you to implement high levels of mobility and flexibility in private cloud solutions.  
  
In  Windows Server 2012 R2  Hyper\-V live migration has been updated to allow the administrator to select the optimal performance options when moving virtual machines to a different server. In larger scale deployments, such as private cloud deployments and hosting providers, this update can reduce the amount of time it takes to move a virtual machine to another server running Hyper\-V. The reduction in time to move a virtual machine can also reduce overhead on the network and CPU usage. For more information about live migration performance options, see [Performance options](Virtual-Machine-Live-Migration-Overview.md#BKMK_Performance).  
  
**Live migration outside of a clustered environment.**  
  
In  Windows Server 2012 , you can configure a virtual machine so that it is stored on an SMB file share. You can then perform a live migration on this running virtual machine between non\-clustered servers running Hyper\-V, while the virtual machine’s storage remains on the central SMB share. This allows users to gain the benefits of virtual machine mobility without having to invest in the clustering infrastructure if they do not need guarantees of availability in their environment. \(Hyper\-V with SMB storage can also be configured with Failover Clustering if you do require high availability. For information about different configurations of Hyper\-V with SMB storage, see [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98).\)  
  
You can also perform a live migration of a virtual machine between two non\-clustered servers running Hyper\-V when you are only using local storage for the virtual machine. \(This is sometimes referred to as a “shared nothing” live migration. In this case, the virtual machines storage is mirrored to the destination server over the network, and then the virtual machine is migrated, while it continues to run and provide network services. For instructions, see [Configure Live Migration and Migrating Virtual Machines without Failover Clustering](../manage/Configure-Live-Migration-and-Migrating-Virtual-Machines-without-Failover-Clustering.md).  
  
This functionality allows live migration in the most basic deployments and in more advanced scenarios, such as performing a live migration for a virtual machine between multiple, separate clusters to load balance across an entire data center.  
  
**Cross version live migration**  
  
Upgrading to a new version of Windows Server no longer requires downtime to the virtual machines. In  Windows Server 2012 R2  Hyper\-V live migration has been updated to support migrating Hyper\-V virtual machines in  Windows Server 2012  to Hyper\-V in  Windows Server 2012 R2 .  
  
When moving a virtual machine on  Windows Server 2012 , the specified destination server can now be a computer running  Windows Server 2012 R2 . This applies to a move that is initiated in Hyper\-V Manager or when using the **Move\-VM** Windows PowerShell cmdlet.  
  
> [!NOTE]  
> Moving a Hyper\-V virtual machine in  Windows Server 2012 R2  to Hyper\-V in  Windows Server 2012  is not supported.  
  
## Key benefits  
Live migration of virtual machines in  Windows Server 2012  delivers improved performance and flexibility. It is also now available inside and outside of clustered environments—both with and without shared storage.  
  
## Requirements  
Common requirements for any form of live migration:  
  
-   Two \(or more\) servers running Hyper\-V that:  
  
    -   Support hardware virtualization.  
  
    -   Use processors from the same manufacturer. For example, all AMD or all Intel.  
  
    -   Belong to either the same Active Directory domain, or to domains that trust each other.  
  
-   Virtual machines must be configured to use virtual hard disks or virtual Fibre Channel disks \(no physical disks\). For more information on virtual Fibre Channel, see [Hyper-V Virtual Fibre Channel Overview](Hyper-V-Virtual-Fibre-Channel-Overview.md).  
  
-   Use of an isolated network, physically or through another networking technology such as VLANs, is recommended for live migration network traffic.  
  
Requirements for live migration in a cluster:  
  
-   Windows Failover Clustering is enabled and configured.  
  
-   Cluster Shared Volume \(CSV\) storage in the cluster is enabled.  
  
> [!IMPORTANT]  
> Physical disks that are directly attached to a virtual machine \(pass\-through disks\) are supported when all of the following conditions are met:  
>   
> -   The virtual machine configured with one or more physical disks is running on a Hyper\-V failover cluster.  
> -   The virtual machine configuration file is hosted on a Cluster Shared Volume \(CSV\).  
> -   The physical disks are configured as a storage disk resource under control of the failover cluster and are properly configured as a dependent resource for the virtual machine.  
  
Requirements for live migration using shared storage:  
  
-   All files that comprise a virtual machine \(for example, virtual hard disks, snapshots, and configuration\) are stored on an SMB share.  
  
-   Permissions on the SMB share have been configured to grant access to the computer accounts of all servers running Hyper\-V.  
  
Requirements for live migration with no shared infrastructure:  
  
-   No extra requirements exist.  
  
> [!NOTE]  
> Physical disks that are directly attached to a virtual machine \(pass\-through disks\) are not supported in live migration without shared storage \(also known as “shared nothing” live migration\).  
  
## <a name="BKMK_Performance"></a>Performance options  
In larger scale deployments, such as private cloud deployments or cloud hosting providers, this update can reduce overhead on the network and CPU usage in addition to reducing the amount of time for a live migration. Hyper\-V administrators can configure the appropriate live migration performance options based on their environment and requirements. Live migration performance options are configured on the host settings in the Hyper\-V Manager console or via the **Set\-VMHost** Windows PowerShell cmdlet and applies to all live migrations initiated from the host.  
  
The following live migrations performance options are available.  
  
|Option|Description|  
|----------|---------------|  
|TCP\/IP|The memory of the virtual machine is copied to the destination server over a TCP\/IP connection. This is the same method that is used in Hyper\-V in  Windows Server 2012 .|  
|Compression|The memory content of the virtual machine that is being migrated is compressed and then copied to the destination server over a TCP\/IP connection. **Note:** This is the **default** setting in Hyper\-V in  Windows Server 2012 R2 .|  
|SMB|The memory content of the virtual machine is copied to the destination server over a SMB 3.0 connection.<br /><br />-   SMB Direct is used when the network adapters on the source and destination servers have Remote Direct Memory Access \(RDMA\) capabilities enabled.<br />-   SMB Multichannel automatically detects and uses multiple connections when a proper SMB Multichannel configuration is identified.<br /><br />For more information, see [Improve Performance of a File Server with SMB Direct](../../../storage/smb/Improve-Performance-of-a-File-Server-with-SMB-Direct.md).|  
  
For information about how to modify the live migration performance options, see [Step3: \[optional\] Configure performance options for live migration](../../failover-clustering/Configure-Live-Migration-and-Migrating-Virtual-Machines-without-Failover-Clustering.md#BKMK_Performance)    
  
## Technical overview  
Hyper\-V live migration moves running virtual machines from one physical server to another with no impact on virtual machine availability to users. By pre\-copying the memory of the migrating virtual machine to the destination server, live migration minimizes the transfer time of the virtual machine. A live migration is deterministic, which means that the administrator, or script, that initiates the live migration determines which computer is used as the destination for the live migration. The guest operating system of the migrating virtual machine is not aware that the migration is happening, so no special configuration for the guest operating system is needed.  
  
After initiating a live migration, the following process occurs:  
  
**1. Live migration setup occurs.**  
  
During the live migration setup stage, the source server creates a connection with the destination server. This connection transfers the virtual machine configuration data to the destination server. A skeleton virtual machine is set up on the destination server and memory is allocated to the destination virtual machine.  
  
**2. Memory pages are transferred from the source node to the destination node.**  
  
In the second stage of a live migration, the memory assigned to the migrating virtual machine is copied over the network to the destination server. This memory is referred to as the “working set” of the migrating virtual machine. A page of memory is 4 KB.  
  
For example, suppose that a virtual machine named “test virtual machine” configured with 1024 MB of RAM is migrating to another server running Hyper\-V. The entire 1024 MB of RAM assigned to this virtual machine is the working set of “test virtual machine.” The utilized pages within the “test virtual machine” working set are copied to the destination server.  
  
In addition to copying the working set of “test virtual machine” to the destination server, Hyper\-V monitors the pages in the working set for “test virtual machine” on the source server. As memory pages are modified by “test virtual machine,” they are tracked and marked as being modified. The list of modified pages is simply the list of memory pages “test virtual machine” has modified after the copy of its working set has begun.  
  
During this phase of the migration, the migrating virtual machine continues to run. Hyper\-V iterates the memory copy process several times, with each iteration requiring a smaller number of modified pages to be copied. After the working set is copied to the destination server, the next stage of the live migration begins.  
  
**3. Modified pages are transferred.**  
  
The third stage of a live migration is a memory copy process that duplicates the remaining modified memory pages for “test virtual machine” to the destination server. The source server transfers the CPU and device state of the virtual machine to the destination server.  
  
During this stage, the network bandwidth available between the source and destination servers is critical to the speed of the live migration. Using a 1 Gigabit Ethernet or faster is important. The faster the source server transfers the modified pages from the migrating virtual machines working set, the more quickly the live migration is completed.  
  
The number of pages transferred in this stage is determined by how actively the virtual machine accesses and modifies the memory pages. The more modified pages there are, the longer it takes to transfer all pages to the destination server.  
  
After the modified memory pages are copied completely to the destination server, the destination server has an up\-to\-date working set for “test virtual machine.” The working set for “test virtual machine” is present on the destination server in the exact state it was in when “test virtual machine” began the migration process.  
  
> [!NOTE]  
> You can cancel the live migration process at any point before this stage of the migration.  
  
**4. The storage handle is moved from the source server to the destination server.**  
  
During the fourth stage of a live migration, control of the storage associated with “test virtual machine,” such as any virtual hard disk files or physical storage attached through a virtual Fibre Channel adapter, is transferred to the destination server. \(Virtual Fibre Channel is also a new Hyper\-V feature in  Windows Server 2012 .\)  
  
**5. The virtual machine is brought online on the destination server.**  
  
In the fifth stage of a live migration, the destination server now has the up\-to\-date working set for “test virtual machine,” as well as access to any storage used by “test virtual machine.” At this point “test virtual machine” is resumed.  
  
**6. Network cleanup occurs.**  
  
In the final stage of a live migration, the migrated virtual machine is running on the destination server. At this point, a message is sent to the network switch. This message causes the network switch to obtain the new the MAC addresses of the migrated virtual machine so that network traffic to and from “test virtual machine” can use the correct switch port.  
  
The live migration process completes in less time than the TCP time\-out interval for the virtual machine being migrated. TCP time\-out intervals vary based on network topology and other factors. The following variables may affect live migration speed:  
  
-   The number of modified pages on the virtual machine to be migrated—the larger the number of modified pages, the longer the virtual machine will remain in a migrating state.  
  
-   Available network bandwidth between source and destination servers.  
  
-   Hardware configuration of source and destination servers.  
  
-   Load on source and destination servers.  
  
-   Available bandwidth \(network or Fibre Channel\) between servers running Hyper\-V and shared storage.  
  
The live migration process for a virtual machine inside a cluster \(when the virtual machine is stored on a CSV volume\) and for a virtual machine outside of a cluster \(when the virtual machine is stored on an SMB share\) is practically identical.  
  
When performing a live migration of a virtual machine between two computers with no shared infrastructure, the first thing that Hyper\-V does is perform a partial migration of the virtual machines storage, as follows:  
  
1.  Throughout most of the move operation, disk reads and writes go to the source virtual hard disk.  
  
2.  While reads and writes occur on the source virtual hard disk, the disk contents are copied over the network to the new destination virtual hard disk.  
  
3.  After the initial disk copy is complete, disk writes are mirrored to both the source and destination virtual hard disks while outstanding disk changes are replicated.  
  
4.  After the source and destination virtual hard disks are completely synchronized, the virtual machine live migration is initiated, following the same process that is used for live migration with shared storage.  
  
5.  Once the live migration is complete and the virtual machine is successfully running on the destination server, the files on the source server are deleted.  
  
## See Also  
[Configure Live Migration and Migrating Virtual Machines without Failover Clustering](../../failover-clustering/Configure-Live-Migration-and-Migrating-Virtual-Machines-without-Failover-Clustering.md)  
  

