---
title: Storage Spaces Direct Hardware Requirements
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 0a988dc0-37e6-4b56-a411-5896af814eda
author: kumudd
---
# Storage Spaces Direct Hardware Requirements

>Applies To: Windows Server 2016

We are working with our hardware partners to define and validate specific hardware configurations, including SAS HBA, SATA SSD and HDD, RDMA enabled network adapters etc.  to make sure of a good user experience.  

Use PowerShell to deploy and manage Storage Spaces Direct.  Do not use Server Manager or Failover Cluster Manager to manage Storage Spaces Direct.  

To evaluate Storage Spaces Direct in Windows Server 2016, the simplest deployment is to use at least four generation 2 Hyper-V virtual machines with at least four data disks per virtual machine. To test Storage Spaces Direct in Windows Server 2016, see [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx).  

> [!NOTE]
>  Storage Spaces Direct does not support disks connected via multiple paths, and the Microsoft Multipath MPIO software stack.  

## Configurations using different disk types  
Storage Spaces Direct in Windows Server 2016 supports use of locally connected disks such as SAS HBA and SATA connected HDD, SATA SSD, and NVMe. These devices can be used in different configurations to allow flexibility to choose based on performance and cost.   

## Related Topics  
-   [Storage Spaces Direct in Windows Server 2016](overview.md)  
-   [Hyper-converged solution using Storage Spaces Direct in Windows Server 2016](../hyper-converged.md)  
-   [Storage Spaces Optimize Pool](Storage-Spaces-Optimize-Pool.md)  
-   [Storage Spaces Fault Tolerance](Storage-Spaces-Fault-Tolerance.md)  

## See Also  
-   [Enabling Private Cloud Storage Using Servers with Local Disks](http://channel9.msdn.com/Events/Ignite/2015/BRK3474) (video)  
-   [What's New in Failover Clustering in Windows Server](../../failover-clustering/whats-new.md)  
-   [Health Service](../../failover-clustering/health-service/overview.md)  
-   [Storage Quality of Service](../storage-qos/overview.md)  
-   [Storage Replica in Windows Server 2016](../storage-replica/overview.md)