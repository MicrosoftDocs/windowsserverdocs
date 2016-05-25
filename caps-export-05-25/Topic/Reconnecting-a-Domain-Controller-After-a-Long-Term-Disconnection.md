---
title: Reconnecting a Domain Controller After a Long-Term Disconnection
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b24fd042-56fb-46b3-86f5-6db8bf179fa0
author: Femila
---
# Reconnecting a Domain Controller After a Long-Term Disconnection
  Assuming that a domain controller has not been disconnected for longer than the maximum safe period for disconnection \(the tombstone lifetime minus end\-to\-end replication latency\), reconnecting the domain controller to the replication topology requires no special procedures. By default, the Knowledge Consistency Checker \(KCC\) on a domain controller runs five minutes after the domain controller starts, automatically incorporating the reconnected domain controller into the replication topology.  
  
## Reconnecting an outdated domain controller  
 If you plan appropriately for disconnecting and reconnecting domain controllers, no domain controller will be disconnected from the replication topology for longer than a tombstone lifetime. However, if unexpected events result in a domain controller becoming outdated, you can perform a procedure to safely remove lingering objects. If the disconnected domain controller is running Windows Server 2003 or Windows Server 2008 and an authoritative domain controller running Windows Server 2003 or Windows Server 2008 is available in this site or a neighboring site, reconnect the domain controller and immediately follow the instructions in [Use Repadmin to Remove Lingering Objects](../Topic/Use-Repadmin-to-Remove-Lingering-Objects.md).  
  
 The following conditions require using a different method of remove lingering objects:  
  
-   The disconnected domain controller is running Windows Server 2003 or Windows Server 2008, but no other authoritative domain controller running Windows Server 2003 or Windows Server 2008 is available in the domain: Reconnect the domain controller, and follow the instructions in article 314282 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=119208](http://go.microsoft.com/fwlink/?LinkId=119208)\).  
  
-   The disconnected domain controller is running Windows 2000 Server, and no other domain controller is available in the domain: If you want to recover the domain, reconnect the domain controller, and follow the instructions in article 314282 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=37924](http://go.microsoft.com/fwlink/?LinkId=37924)\).  
  
-   The disconnected domain controller is running Windows 2000 Server, and another domain controller is available in the domain: Do not reconnect the domain controller. Instead, force Active Directory removal on the disconnected domain controller, perform metadata cleanup, and then reinstall Active Directory. To complete these tasks, follow the instructions in [Forcing the Removal of a Domain Controller_1](../Topic/Forcing-the-Removal-of-a-Domain-Controller_1.md) and [Installing a Domain Controller in an Existing Domain](../Topic/Installing-a-Domain-Controller-in-an-Existing-Domain.md).  
  
## Updating SYSVOL  
 To update SYSVOL as soon as possible after you reconnect a domain controller, plan the time that you restart the domain controller to optimize the replication schedule, as follows:  
  
-   If the closest replication partner for the domain is in a different site, view site link properties to determine the replication schedule, and then restart the domain controller as soon as possible after replication is scheduled to start.  
  
-   If a replication partner for the domain is available within the site, verify replication success on that partner before you restart the domain controller.  
  
> [!IMPORTANT]  
>  If you use File Replication Service \(FRS\) to replicate SYSVOL, the recommended practice to reduce the time required to update SYSVOL is to modify the registry before you disconnect the domain controller so that SYSVOL is updated with only the latest file changes when you restart the domain controller. For information about preparing for SYSVOL replication when using FRS, see Preparing an Existing Domain Controller for Shipping and Long\-Term Disconnection \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122834](http://go.microsoft.com/fwlink/?LinkId=122834)\).  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   ADSI Edit  
  
-   Active Directory Sites and Services  
  
-   Repadmin.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Determine the Tombstone Lifetime for the Forest &#91;lhsad&#93;](assetId:///e4b69fc8-c041-4bc6-baf1-581d3ad4651e).  
  
2.  Determine whether the maximum safe disconnection time has been exceeded. The maximum safe disconnection time should have been established at the time of disconnection, as follows:  
  
     Subtract a generous estimate of the amount of time for end\-to\-end replication latency from the tombstone lifetime. Either find the latency estimate in the design documentation for your deployment or request the information from a member of your design or deployment team.  
  
3.  If the maximum safe disconnection time has not been exceeded, proceed with the reconnection process as follows:  
  
    -   [Move a Server Object to a New Site](../Topic/Move-a-Server-Object-to-a-New-Site.md)  
  
         If the server object for the domain controller is still in the site where the domain controller was installed, move the server object to the site in which you are reconnecting the domain controller.  
  
    -   If the site in which you are reconnecting the domain controller has one or more other domain controllers that are authoritative for the domain, start the domain controller anytime.  
  
    -   If the site in which you are reconnecting the domain controller has no other domain controllers that are authoritative for the domain, proceed as follows:  
  
         [Determine When Intersite Replication Is Scheduled to Begin](../Topic/Determine-When-Intersite-Replication-Is-Scheduled-to-Begin.md) by viewing the replication properties on the site link that connects this site to the next closest site that includes a domain controller that is authoritative for this domain.  
  
         As soon as possible after the next replication cycle begins, start the domain controller.  
  
     If the maximum safe disconnection time has been exceeded, proceed in the appropriate manner according to the operating system, as described in "Reconnecting an Outdated Domain Controller" earlier in this topic.  
  
4.  [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
     After replication is complete, verify replication of the domain, configuration, and schema directory partitions. If the domain controller is a global catalog server, verify replication of all domain directory partitions. If the domain controller is a Domain Name System \(DNS\) server, verify replication of the domain and forest DNS application directory partitions.  
  
## See Also  
 [Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection](../Topic/Preparing-an-Existing-Domain-Controller-for-Shipping-and-Long-Term-Disconnection.md)  
  
  