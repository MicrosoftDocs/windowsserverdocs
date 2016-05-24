---
title: Synchronize Replication with All Partners
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e12f801f-49a1-4cd3-a357-99596e6328f7
author: Femila
---
# Synchronize Replication with All Partners
  You can use this procedure to synchronize replication with all replication partners of a domain controller.  
  
 Membership in **Enterprise Admins** in the forest or **Domain Admins** in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To synchronize replication with all partners  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `repadmin /syncall <DomainControllerName> /e /d /A /P /q`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |repadmin \/syncall|Synchronizes a specified domain controller with all replication partners.|  
    |\<DomainControllerName\>|The Domain Name System \(DNS\) name of the domain controller on which you want to synchronize replication with all partners.|  
    |\/e|Enterprise; includes partners in all sites.|  
    |\/d|Identifies servers by their distinguished names in messages.|  
    |\/A|All; synchronizes all directory partitions that are held on the home server.|  
    |\/P|Pushes changes outward from the home server.|  
    |\/q|Runs in quiet mode; suppresses callback messages.|  
  
2.  Check for replication errors in the output of the command in the previous step. If there are no errors, replication is successful. For replication to complete, any errors must be corrected.  
  
## See Also  
 [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
  