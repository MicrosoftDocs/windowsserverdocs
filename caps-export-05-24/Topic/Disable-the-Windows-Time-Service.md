---
title: Disable the Windows Time Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8371618f-3e1e-4e92-8d56-ec9434cae455
author: Femila
---
# Disable the Windows Time Service
  You can use this procedure to disable the Windows Time service \(W32time\) if you choose to implement another time synchronization product that uses Network Time Protocol \(NTP\).  
  
 Perform this procedure on the forest root domain reliable time source.  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To disable the Windows Time service  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Services**.  
  
2.  Right\-click **Windows Time**, and then click **Properties**.  
  
3.  In the **Windows Time Properties** dialog box, in **Startup type**, click **Disabled**, and then click **OK**.  
  
4.  In the **Services** list, verify that the **Startup Type** for the Windows Time service is **Disabled**.  
  
  