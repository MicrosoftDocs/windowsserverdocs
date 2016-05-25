---
title: Storage Spaces Optimize Pool
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0eec0e7e-28f3-4fb2-bd41-e97bc3560bcb
author: kumudd
---
# Storage Spaces Optimize Pool
[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] Storage Spaces Direct can optimize a storage pool to balance data equally across the set of physical disks that comprise the pool.  
  
Over time, as physical disks are added or removed or as data is written or deleted, the distribution of data among the set of physical disks that comprise the pool may become uneven. In some cases, this may result in certain physical disks becoming full while other disks in the same pool have much lower consumption.  
  
Similarly, if new storage is added to the pool, optimizing the existing data to utilize the new storage will result in better storage efficiency across the pool and, potentially, improved performance from the newly available additional physical storage throughput.  Optimizing the pool is a maintenance task which is performed by the administrator.  
  
You can optimize a storage pool with the following command:  
  
```  
Optimize-StoragePool <PoolName>  
```  
  
The output of the Optimize\-StoragePool command include a progress bar that measures the progress of the re\-balance operation  
  
You can monitor the progress of the optimize job with the following command:  
  
```  
Get-StorageJob | ? Name –eq Optimize  
```  
  
## Related Topics  
  
-   [Storage Spaces Direct in Windows Server 2016 Technical Preview](Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  
-   [Hyper-converged solution using Storage Spaces Direct in Windows Server 2016](Hyper-converged-solution-using-Storage-Spaces-Direct-in-Windows-Server-2016.md)  
-   [Storage Spaces Direct Overview](Storage-Spaces-Direct-Overview.md)  
  
-   [Storage Spaces Direct Hardware Requirements](Storage-Spaces-Direct-Hardware-Requirements.md)  
  
-   [Storage Spaces Fault Tolerance](Storage-Spaces-Fault-Tolerance.md)  
  
  
  
## See Also  
  
-   [Enabling Private Cloud Storage Using Servers with Local Disks](http://channel9.msdn.com/Events/Ignite/2015/BRK3474) \(video\)  
  
-   [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx) \(blog\)  
  
-   [What's New in Failover Clustering in Windows Server Technical Preview](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md)  
  
-   [Storage Replica in Windows Server 2016 Technical Preview](Storage-Replica-in-Windows-Server-2016-Technical-Preview.md)  
  
-   [Storage Quality of Service](Storage-Quality-of-Service.md)  
  

