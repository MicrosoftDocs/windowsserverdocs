---
title: Clear the Global Catalog Setting
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e49d8e01-bc53-48b9-bf6d-232ea5e092b1
author: Femila
---
# Clear the Global Catalog Setting
  Clearing the global catalog setting begins the removal of the partial, read\-only directory partitions from the directory database of the domain controller. You can use this procedure to clear the global catalog setting.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To clear the global catalog setting  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  Expand the **Sites** container, and then expand the site from which you are removing a global catalog server.  
  
3.  Expand the **Servers** container, and then expand the **Server** object for the domain controller from which you want to remove the global catalog.  
  
4.  Right\-click the **NTDS Settings** object for the target server, and then click **Properties**.  
  
5.  If the **Global Catalog** check box is selected, clear the check box, and then click **OK**.  
  
  