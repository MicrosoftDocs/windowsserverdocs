---
title: Delete a Server Object from a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 59ef6c02-3d20-4d2f-b468-b2fca8e370f3
author: Femila
---
# Delete a Server Object from a Site
  When you remove a domain controller from service by uninstalling Active Directory Domain Services \(AD DS\), the domain controller object is removed from the domain directory partition automatically. You can check this deletion by looking in the Domain Controllers container in the Active Directory Users and Computers snap\-in.  
  
 The server object, which represents the domain controller in the configuration directory partition, can have child objects and is therefore not removed automatically. When no child objects are visible below the server object in Active Directory Sites and Services, you can use this procedure to remove the server object.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To delete a server object from a site  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  In the console tree, expand the **Sites** container, and then expand the site from which you want to delete a server object.  
  
3.  If no child objects appear below the server object, right\-click the server object, and then click **Delete**.  
  
    > [!IMPORTANT]  
    >  Do not delete a server object that has a child object. If an NTDS Settings object appears below the server object you want to delete, either replication on the domain controller on which you are viewing the configuration container has not occurred or the server whose server object you are removing has not been properly decommissioned. If a child object other than NTDS Settings appears below the server object that you want to delete, another application has published the object. You must contact an administrator for the application and determine the appropriate action to remove the child object.  
  
4.  Click **Yes** to confirm your choice.  
  
## See Also  
 [Decommissioning a Domain Controller](../Topic/Decommissioning-a-Domain-Controller.md)   
 [Forcing the Removal of a Domain Controller_1](../Topic/Forcing-the-Removal-of-a-Domain-Controller_1.md)  
  
  