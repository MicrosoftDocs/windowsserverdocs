---
title: Windows PowerShell Example for all-flash configurations
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a1fadf69-99d1-474e-9c84-fced96b31fa6
author: kumudd
---
# Windows PowerShell Example for all-flash configurations
This section includes steps  to configure all\-flash \(NVMe SSD \+ SATA SSD\) and multi\-resilient virtual disks using PowerShell:  
  
-   **Step 4. Enable Storage Spaces Direct**  
  
    ```  
    # Enable Storage Spaces Direct for NVMe + SATA SSD   
    Enable-ClusterS2D –S2DCacheDevice NVMe  
    ```  
  
-   **Step 5. Create storage pools**  
  
    ```  
    # Create storage pool  
    New-StoragePool -StorageSubSystemFriendlyName <FQDN of the subsystem> -FriendlyName <StoragePoolName> -ProvisioningTypeDefault Fixed -PhysicalDisk (Get-PhysicalDisk | ? CanPool -eq $true)  
  
    Get-StoragePool <StoragePoolName> | Get-PhysicalDisk |? BusType -eq NVMe | Set-PhysicalDisk -Usage Journal  
    ```  
  
-   **Step 6. Create storage tiers**  
  
    ```  
    # Define Storage Tiers  
    $mt = New-StorageTier -StoragePoolFriendlyName <StoragePoolName> -FriendlyName <MirrorTierName> -MediaType SSD -ResiliencySettingName Mirror -NumberOfColumns 4 -PhysicalDiskRedundancy 2  
    $pt = New-StorageTier -StoragePoolFriendlyName <StoragePoolName> -FriendlyName <ParityTierName> -MediaType SSD -ResiliencySettingName Parity -NumberOfColumns 7 -PhysicalDiskRedundancy 2  
    ```  
  
    > [!NOTE]  
    > If you have more than 10 capacity devices per node, you can change the number of columns to 8 for the mirror tier.  
  
-   **Step 7. Create virtual disks**  
  
    ```  
    New-Volume -StoragePoolFriendlyName <StoragePoolName> -FriendlyName <VirtualDiskName> -FileSystem CSVFS_ReFS -StorageTiers $mt,$pt -StorageTierSizes 100GB,800GB  
    ```  
  
## Related Topics  
  
-   [Storage Spaces Direct in Windows Server 2016 Technical Preview](../Topic/Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  
  
-   [Storage Spaces Direct Overview](../Topic/Storage-Spaces-Direct-Overview.md)  
  
-   [Storage Spaces Direct Hardware Requirements](../Topic/Storage-Spaces-Direct-Hardware-Requirements.md)  
  
-   [Installing and Configuring Storage Spaces Direct](../Topic/Installing-and-Configuring-Storage-Spaces-Direct.md)  
  
-   [Storage Spaces Optimize Pool](../Topic/Storage-Spaces-Optimize-Pool.md)  
  
-   [Storage Spaces Fault Tolerance](../Topic/Storage-Spaces-Fault-Tolerance.md)  
  
-   [Storage Spaces with Shared JBODs versus Storage Spaces Direct](../Topic/Storage-Spaces-with-Shared-JBODs-versus-Storage-Spaces-Direct.md)  
  
## See Also  
  
-   [Enabling Private Cloud Storage Using Servers with Local Disks](http://channel9.msdn.com/Events/Ignite/2015/BRK3474) \(video\)  
  
-   [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx) \(blog\)  
  
-   [What's New in Failover Clustering in Windows Server Technical Preview](../Topic/What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md)  
  
-   [Storage Replica in Windows Server 2016 Technical Preview](../Topic/Storage-Replica-in-Windows-Server-2016-Technical-Preview.md)  
  
-   [Storage Quality of Service](../Topic/Storage-Quality-of-Service.md)  
  
