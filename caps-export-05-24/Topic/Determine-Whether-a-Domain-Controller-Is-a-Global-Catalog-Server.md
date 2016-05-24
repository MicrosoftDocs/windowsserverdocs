---
title: Determine Whether a Domain Controller Is a Global Catalog Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c4bf503c-19a8-451c-9c05-0d5da8187066
author: Femila
---
# Determine Whether a Domain Controller Is a Global Catalog Server
  You can use the setting on the NTDS Settings object to determine whether a domain controller is designated as a global catalog server.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure when you perform the procedure remotely by using Remote Server Administration Tools \(RSAT\). [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine whether a domain controller is a global catalog server  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  In the console tree, expand the **Sites** container, expand the site of the domain controller that you want to check, expand the **Servers** container, and then expand the **Server** object.  
  
3.  Right\-click the **NTDS Settings** object, and then click **Properties**.  
  
4.  On the **General** tab, if the **Global Catalog** box is selected, the domain controller is designated as a global catalog server.  
  
  