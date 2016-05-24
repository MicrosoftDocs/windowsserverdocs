---
title: Stop the DFS Replication Service and Netlogon Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d47ca783-9378-41b5-b2c2-6412fe6b47b6
author: Femila
---
# Stop the DFS Replication Service and Netlogon Service
  You can use this procedure to stop the Distributed File System \(DFS\) Replication service and the Netlogon service when you are performing offline updates to the SYSVOL tree. The Netlogon service advertises the server as a domain controller by sharing out the SYSVOL folder. The services must be turned off until updates to the SYSVOL path information are complete and the SYSVOL junction point has been updated for the new location.  
  
 You can use the Windows graphical user interface \(GUI\) or the command line to stop the DFS Replication service and the Netlogon service.  
  
> [!NOTE]  
>  The staging path junction point is updated automatically when DFS Replication is restarted.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To stop the DFS Replication service or Netlogon service, or both, by using the Windows GUI  
  
1.  On the **Start** menu, point to **Administrative Tools**, and then click **Services**.  
  
2.  In the **Name** column, right\-click **DFS Replication** or **Netlogon**, and then click **Stop**.  
  
### To stop the DFS Replication service and the Netlogon service by using the command line  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net stop dfsr  
    ```  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
     `net stop netlogon`  
  
 After you move or restore SYSVOL, when you update the SYSVOL Netlogon path in the registry, you must also update the **SysvolReady** parameter in **Netlogon** parameters, as described in [Change the SYSVOL Netlogon Parameters](../Topic/Change-the-SYSVOL-Netlogon-Parameters.md).  
  
  