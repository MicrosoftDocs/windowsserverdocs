---
title: Change the Quota That Is Allocated to the SYSVOL Staging Folder
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f57283d2-1b40-4563-b909-84a4e867e352
author: Femila
---
# Change the Quota That Is Allocated to the SYSVOL Staging Folder
  You can use this procedure to modify the amount of disk space that is allocated to the staging folder in SYSVOL. If space is available on the volume, you can increase the quota that is allocated to the staging folder to improve SYSVOL replication efficiency. For more information, see [Optimize the size of staging folders](http://technet.microsoft.com/library/cc754229.aspx).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the space that is allocated to the staging folder  
  
1.  On the **Start** menu, point to **Administrative Tools**, and then click **DFS Management**.  
  
2.  In the console tree, expand **Replication**, and then click **Domain System Volume**.  
  
3.  In the details pane, right\-click the SYSVOL replication member whose staging folder allocation you want to change, and then click **Properties**.  
  
4.  On the **Staging** tab, change the value in **Quota \(in megabytes\)**, and then click **OK**.  
  
  