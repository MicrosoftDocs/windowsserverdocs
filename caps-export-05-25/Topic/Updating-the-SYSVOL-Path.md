---
title: Updating the SYSVOL Path
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8a285bd9-8b67-4f77-be5f-beb6543c215e
author: Femila
---
# Updating the SYSVOL Path
  When you add or remove disk drives, the logical drive letters of the other drives on the system can change. If either your %systemroot%\\SYSVOL\\sysvol folder or your %systemroot%\\SYSVOL\\staging areas folder is located on one of the drives whose letter changes, Distributed File System \(DFS\) Replication cannot locate these folders. To solve this problem, you must update the paths that DFS Replication uses to locate these folders.  
  
 Before you update SYSVOL path information, you must stop the DFS Replication service and the Netlogon service. To change the path for the %systemroot%\\SYSVOL\\sysvol root folder and staging areas folder, you update path values in Active Directory Domain Services \(AD DS\). You also update the registry to change the path to the %systemroot%\\SYSVOL\\sysvol shared folder that is used by the Netlogon service. In addition, you must update the junction point that references the %systemroot%\\SYSVOL\\domain folder in the SYSVOL tree. The junction point that references the domain folder in the staging areas subdirectory \(%systemroot%\\SYSVOL\\staging areas\\*DomainName*\) is updated automatically when you restart DFS Replication and Netlogon.  
  
 After you update the path information, when you restart DFS Replication and Netlogon, the new path values are initialized. To be sure that SYSVOL is not advertised on the network before the new paths are initalized, you must also modify the SysvolReady Netlogon parameter while the services are stopped. You can make this change at the same time you update the Sysvol Netlogon path in the registry.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Net.exe  
  
-   ADSI Edit  
  
-   Regedit.exe  
  
-   Dir.exe  
  
-   Mklink.exe  
  
 To complete this task, perform the following procedures in order:  
  
1.  [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md)  
  
2.  [Stop the DFS Replication Service and Netlogon Service](../Topic/Stop-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
3.  [Change the SYSVOL Netlogon Parameters](../Topic/Change-the-SYSVOL-Netlogon-Parameters.md)  
  
4.  [Create the SYSVOL Root and Staging Areas Junction Point](../Topic/Create-the-SYSVOL-Root-and-Staging-Areas-Junction-Point.md)  
  
5.  [Start the DFS Replication Service and Netlogon Service](../Topic/Start-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
  