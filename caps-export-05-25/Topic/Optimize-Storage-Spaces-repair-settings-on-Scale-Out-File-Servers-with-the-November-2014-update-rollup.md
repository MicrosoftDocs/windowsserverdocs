---
title: Optimize Storage Spaces repair settings on Scale-Out File Servers with the November 2014 update rollup
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1876b37d-300f-4068-b53e-ddfffa0bde09
author: JasonGerend
---
# Optimize Storage Spaces repair settings on Scale-Out File Servers with the November 2014 update rollup
All Scale\-out File Servers \(SOFS\) running Windows Server 2012 R2 that use virtual disks created with Storage Spaces should apply the November 2014 update rollup for Windows Server 2012 R2. After applying the update, use this topic to optimize how Storage Spaces repairs virtual disks after a physical disk failure.  
  
For info about the November 2014 update rollup for Windows Server 2012 R2, see [article 3000850](http://support.microsoft.com/kb/3000850) in the Microsoft Knowledge Base. For more info about Storage Spaces, see [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md).  
  
## Optimize virtual disk repair settings  
  
1.  Install the November 2014 Update Roll\-up on each node of every Scale\-out File Server that uses Storage Spaces.  
  
2.  Open a Windows PowerShell session with local administrative privileges, and then run the following commands on each node:  
  
    ```powershell  
    Set-ItemProperty hklm:\System\CurrentControlSet\Services\Spaceport\Parameters -Name ReallocationsPerInterval 32  
    Set-ItemProperty hklm:\System\CurrentControlSet\Services\Spaceport\Parameters -Name ReallocationInterval 15  
    Set-ItemProperty hklm:\System\CurrentControlSet\Services\Spaceport\Parameters -Name RepairQueueDepth 4  
    Set-ItemProperty hklm:\System\CurrentControlSet\Services\Spaceport\Parameters -Name RepairQueueWidth 8  
    Get-ClusterResourceType "Storage Pool" |   
    Set-ClusterParameter -Name ReEvaluatePlacementTimeout -Value $([uint32]300) –create  
    ```  
  
3.  Use the following commands to verify the new settings:  
  
    ```powershell  
    Get-ItemProperty hklm:\System\CurrentControlSet\Services\Spaceport\Parameters | Select-Object ReallocationsPerInterval,ReallocationInterval,RepairQueueDepth,RepairQueueWidth |   
    Format-List  
    Get-ClusterResourceType 'Storage Pool' | Get-ClusterParameter  
    ```  
  
    Here's some example output, showing the new settings:  
  
    ```  
    ReallocationsPerInterval : 32  
    ReallocationInterval     : 15  
    RepairQueueDepth         : 4  
    RepairQueueWidth         : 8  
  
    Object       Name                       Value Type    
    ------       ----                       ----- ----    
    Storage Pool ReEvaluatePlacementTimeout 300   UInt32  
    ```  
  
> [!IMPORTANT]  
> Make sure to install the roll\-up and perform this procedure on any newly added nodes as well as any nodes that you restore from a previous backup.  
  
## See Also  
[Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md)  
  
