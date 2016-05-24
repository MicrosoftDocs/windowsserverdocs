---
title: Determine Whether a Server Object Has Child Objects
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9a9e4a00-bd23-49d9-b123-a1a1f4231cf1
author: Femila
---
# Determine Whether a Server Object Has Child Objects
  After Active Directory Domain Services \(AD DS\) is properly installed on a domain controller, the server object for the domain controller has a child NTDS Settings object. Other applications that are running on domain controllers can also publish child objects.  
  
 When you remove AD DS from a server, the NTDS Settings child object is removed automatically from the server object in the Servers container in Active Directory Sites and Services. Before you delete a server object from the Servers container for a site, verify that the server object has no child objects. The following conditions might result in the presence of a child object:  
  
-   If an NTDS Settings object is present, it is possible that replication of the deletion has not reached the domain controller whose objects you are viewing. Check the presence of the object on another domain controller, or force replication from another domain controller in the domain. \(See [Force Replication Between Domain Controllers](../Topic/Force-Replication-Between-Domain-Controllers.md).\)  
  
-   If a child object other than NTDS Settings is present, another application has published the object and is using the server object. In this case, do not delete the server object.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure when you perform the procedure remotely by using Remote Server Administration Tools \(RSAT\). [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine whether a server object has child objects  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  In the console tree, expand the **Sites** container, and then expand the site of the server object.  
  
3.  Expand the **Servers** container, and then expand the server object to view any child objects.  
  
  