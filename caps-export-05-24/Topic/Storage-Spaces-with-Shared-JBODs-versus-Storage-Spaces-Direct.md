---
title: Storage Spaces with Shared JBODs versus Storage Spaces Direct
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 1b2bef81-4646-4e2d-b397-e77e21ffa68f
author: kumudd
---
# Storage Spaces with Shared JBODs versus Storage Spaces Direct
To help understand Storage Spaces Direct, let’s examine Storage Spaces in Windows Server 2012 R2 highly available storage systems. In Windows Server 2012 R2, an HA system using Storage Spaces requires disks to be physically connected to all storage nodes. To allow for the disks to be physically connected to all storage nodes, they need to reside in an external JBOD chassis with each storage node having physical connectivity to the external JBOD. Also, only SAS disk devices are supported because, unlike SATA, SAS supports multi\-initiator \(connection from multiple servers\). Because of these requirements, we have named this deployment “Storage Spaces with Shared JBODs” in contrast to Storage Spaces Direct. The following figure  illustrates a "Storage Spaces with Shared JBODs"deployment.  
  
![](../Image/StorageSpacesSharedJBODs.png)  
  
**FIGURE : Storage Spaces with shared JBODs**  
  
“Storage Spaces with Shared JBODs” provides many benefits compared to past highly available storage systems. However, requiring that disk devices are physically connected to every single node limits the type of disk devices that can be used and can lead to complex SAS fabric configurations, especially as these deployments scale out.  
  
## Related Topics  
  
-   [Storage Spaces Direct in Windows Server 2016 Technical Preview](../Topic/Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  
  
-   [Storage Spaces Direct Overview](../Topic/Storage-Spaces-Direct-Overview.md)  
  
-   [Storage Spaces Direct Hardware Requirements](../Topic/Storage-Spaces-Direct-Hardware-Requirements.md)  
  
-   [Installing and Configuring Storage Spaces Direct](../Topic/Installing-and-Configuring-Storage-Spaces-Direct.md)  
  
-   [Windows PowerShell Example for all-flash configurations](../Topic/Windows-PowerShell-Example-for-all-flash-configurations.md)  
  
-   [Storage Spaces Optimize Pool](../Topic/Storage-Spaces-Optimize-Pool.md)  
  
-   [Storage Spaces Fault Tolerance](../Topic/Storage-Spaces-Fault-Tolerance.md)  
  
-   [Storage Spaces with Shared JBODs versus Storage Spaces Direct](../Topic/Storage-Spaces-with-Shared-JBODs-versus-Storage-Spaces-Direct.md)  
  
## See Also  
  
-   [Enabling Private Cloud Storage Using Servers with Local Disks](http://channel9.msdn.com/Events/Ignite/2015/BRK3474) \(video\)  
  
-   [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx) \(blog\)  
  
-   [What's New in Failover Clustering in Windows Server Technical Preview](../Topic/What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md)  
  
-   [Storage Replica in Windows Server 2016 Technical Preview](../Topic/Storage-Replica-in-Windows-Server-2016-Technical-Preview.md)  
  
-   [Storage Quality of Service](../Topic/Storage-Quality-of-Service.md)  
  
