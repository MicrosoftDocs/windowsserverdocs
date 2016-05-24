---
title: Update the FRS or DFS Replication Member Object
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7bde7c10-9744-462a-970b-51c8d340d19d
author: Femila
---
# Update the FRS or DFS Replication Member Object
  You can use this procedure to update the File Replication Service \(FRS\) or Distributed File System \(DFS\) Replication member object after you rename a domain controller. This object must be updated with the new domain controller name so that the domain controller can replicate SYSVOL.  
  
 For more information about this procedure, see article 316826 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=82821](http://go.microsoft.com/fwlink/?LinkId=82821)\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To update the FRS member object  
  
1.  On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.  
  
2.  On the **View** menu, click **Advanced Features**.  
  
3.  Expand the domain node, **System**, **File Replication Service**, and **Domain System Volume \(SYSVOL share\)**. The \<DomainControllerName\> objects below **Domain System Volume \(SYSVOL share\)** are the FSR Member objects that correspond to domain controllers in the domain. Find the \<DomainControllerName\> object that shows the old name of the domain controller.  
  
4.  Right\-click the FRS Member object for the old name of the domain controller, and then click **Rename**.  
  
5.  Type the new name of the domain controller.  
  
6.  To verify the name change, open ADSI Edit: On the **Start** menu, point to **Administrative Tools**, and then click **ADSI Edit**.  
  
     View the **fRSMemberReference** attribute of the object CN\=Domain System Volume \(SYSVOL share\),CN\=NTFRS Subscriptions,CN\=\<DomainControllerName\>,OU\=Domain Controllers,DC\=\<DomainName\> and confirm that the value in CN\=\<DomainControllerName\> is the new name.  
  
### To update the DFS Replication member object  
  
1.  On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.  
  
2.  On the **View** menu, click **Advanced Features**.  
  
3.  Expand the domain node, **System**, **DFSR\-GlobalSettings**, **Domain System Volume**, and **Topology**. The \<DomainControllerName\> objects below **Domain System Volume** are the msDFSR\-Member objects that correspond to domain controllers in the domain. Find the \<DomainControllerName\> object that shows the old name of the domain controller.  
  
4.  Right\-click the msDFSR\-Member object for the old name of the domain controller, and then click **Rename**.  
  
5.  Type the new name of the domain controller.  
  
6.  To verify the name change, open ADSI Edit: On the **Start** menu, point to **Administrative Tools**, and then click **ADSI Edit**.  
  
     View the **msDFSR\-MemberReference** attribute of the object CN\=Domain System Volume,CN\=DFSR\-LocalSettings,CN\=\<DomainControllerName\>,OU\=Domain Controllers,DC\=\<DomainName\> and confirm that the value in CN\=\<DomainControllerName\> is the new name.  
  
  