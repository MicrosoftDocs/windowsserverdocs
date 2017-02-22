---
title: Software Storage Bus Overview
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dongill
ms.technology: storage-spaces
ms.topic: article
author: kumudd
ms.date: 12/7/2016
ms.assetid: 7266d237-4d46-4a37-8165-d68df509e215
---
# Software Storage Bus Overview
> Applies To: Windows Server 2016

The Software Storage Bus is a virtual storage bus spanning all the servers that make up the cluster. Software Storage Bus essentially makes it possible for each server to see all disks across all servers in the cluster providing full mesh connectivity. Software Storage Bus consists of two components on each server in the cluster; ClusPort and ClusBlft. ClusPort implements a virtual host bus adapter (HBA) that allows the node to connect to disk devices in all the other servers in the cluster. ClusBlft implements virtualization of the disk devices and enclosures in each server for ClusPort in other servers to connect to.  

![A diagram showing how two cluster nodes use the Software Storage Bus to share storage over an Ethernet connection](media/Software-Storage-Bus-Overview/S2D_SoftwareStorageBus.png)  

## SMB as transport  
Software Storage Bus uses SMB3 and SMB Direct as the transport for communication between the servers in the cluster. Software Storage Bus uses a separate named instance of SMB in each server, which separates it from other consumers of SMB, such as CSVFS, to provide additional resiliency. Using SMB3 enables Software Storage Bus to take advantage of the innovation we have done in SMB3, including SMB Multichannel and SMB Direct. SMB Multichannel can aggregate bandwidth across multiple network interfaces for higher throughput and provide resiliency to a failed network interface. For more information about SMB Multichannel, see [Deploy SMB Multichannel](https://technet.microsoft.com/library/dn610980.aspx). SMB Direct enables use of RDMA enabled network adapters, including iWARP and RoCE, which can dramatically lower the CPU overhead of doing IO over the network and reduce the latency to disk devices. For more information about SMB Direct, see [Improve Performance of a File Server with SMB Direct](https://technet.microsoft.com/library/jj134210.aspx). To view a demonstration of the  IOPS difference in a system with and without RDMA enabled , see [Enabling Private Cloud Storage Using Servers with Local Disks](https://channel9.msdn.com/Events/Ignite/2015/BRK3474).  

## Software Storage Bus Bandwidth Management  
Software Storage Bus also implements a fair access algorithm that ensures fair device access from any server to protect against one server starving out other servers. It also implements an algorithm for IO prioritization that prioritizes Application IO, which usually is IO from virtual machines, over system IO, which usually would be rebalance or repair operations. However, at the same time it ensures that rebalance and repair operations can make forward progress. 

## Related Topics  
-   [Storage Spaces Direct in Windows Server 2016](storage-spaces-direct-overview.md)  
-   [Storage Spaces Direct Hardware Requirements](Storage-Spaces-Direct-Hardware-Requirements.md)  
-   [Hyper-converged solution using Storage Spaces Direct in Windows Server 2016](hyper-converged-solution-using-storage-spaces-direct.md)  
-   [Storage Spaces Optimize Pool](Storage-Spaces-Optimize-Pool.md)  
-   [Storage Spaces Fault Tolerance](Storage-Spaces-Fault-Tolerance.md)  

## See Also  
-   [Enabling Private Cloud Storage Using Servers with Local Disks](http://channel9.msdn.com/Events/Ignite/2015/BRK3474) (video)  
-   [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx) (blog)  
-   [What's New in Failover Clustering in Windows Server 2016](../../failover-clustering/whats-new-in-failover-clustering.md)  
-   [Storage Replica in Windows Server 2016](../storage-replica/storage-replica-overview.md)  
-   [Storage Quality of Service](../storage-qos/storage-qos-overview.md)  
