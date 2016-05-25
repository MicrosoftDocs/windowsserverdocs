---
title: Designate a Domain Controller to Be a Global Catalog Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dbf699e2-7a6a-4cab-b243-df58b923cb1c
author: Femila
---
# Designate a Domain Controller to Be a Global Catalog Server
  You use this procedure to designate a domain controller as a global catalog server. When you designate a domain controller as a global catalog server, a partial, read\-only directory partition for each domain in the forest, other than the full, writable directory partition of the local domain, is replicated to create the global catalog instance on the server.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To designate a domain controller to be a global catalog server  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand the **Sites** container, and then expand the site in which you are designating a global catalog server.  
  
3.  Expand the **Servers** container, and then expand the **Server** object for the domain controller that you want to designate as a global catalog server.  
  
4.  Right\-click the **NTDS Settings** object for the target server, and then click **Properties**.  
  
5.  Select the **Global Catalog** check box, and then click **OK**.  
  
  