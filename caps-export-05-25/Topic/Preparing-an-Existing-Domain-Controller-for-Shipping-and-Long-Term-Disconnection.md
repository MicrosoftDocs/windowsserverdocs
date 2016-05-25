---
title: Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e62f6411-66f5-48a0-b10a-7add3f0c6a0a
author: Femila
---
# Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection
  When you ship a domain controller to a remote site, you must disconnect it from the network and, consequently, from the replication topology. If a domain controller must be separated from the replication topology for a period of time that might be longer than a tombstone lifetime, you must take preliminary steps to ensure a smooth reconnection. Otherwise, it is possible that a long\-term disconnection can result in a deleted object being reintroduced into the directory. Such deleted objects, when they are retained on a domain controller that has been disconnected for a period that is longer than a tombstone lifetime, are called "lingering objects." Lingering objects that are security principals, such as users or groups, can cause problems with Active Directory searches and e\-mail delivery. Lingering objects can also jeopardize security if a user is allowed access to a resource by virtue of membership in a group that has been deleted. For more information about lingering objects, see "Maintaining Directory Consistency When Disconnecting a Domain Controller" in [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md).  
  
 By taking preliminary precautions, you can ensure that long\-term disconnections do not result in directory inconsistency from lingering objects.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   ADSI Edit  
  
-   Ntdsutil.exe  
  
-   Active Directory Users and Computers  
  
-   Active Directory Schema  
  
-   Active Directory Domains and Trusts  
  
-   Repadmin.exe  
  
 To complete this task, perform the following procedures:  
  
1.  Determine the anticipated length of the disconnection.  
  
2.  [Determine the Tombstone Lifetime for the Forest &#91;lhsad&#93;](assetId:///e4b69fc8-c041-4bc6-baf1-581d3ad4651e).  
  
3.  Determine the maximum safe\-disconnection period by subtracting a generous estimate of the end\-to\-end replication latency from the tombstone lifetime. Either find the latency estimate in the design documentation for your deployment or request the information from a member of your design or deployment team.  
  
    -   If the anticipated time of disconnection exceeds the maximum safedisconnection period, make a decision about whether to extend the tombstone lifetime. To change the tombstone lifetime, see [Determine the Tombstone Lifetime for the Forest &#91;lhsad&#93;](assetId:///e4b69fc8-c041-4bc6-baf1-581d3ad4651e) and change the value in the **tombstoneLifetime** attribute.  
  
    -   If the estimated time of disconnection does not exceed the maximum safe disconnection time, proceed with preparations for disconnection.  
  
4.  [View the Current Operations Master Role Holders](../Topic/View-the-Current-Operations-Master-Role-Holders.md) to determine whether the domain controller is an operations master role holder.  
  
5.  [Transfer the Domain-Level Operations Master Roles](../Topic/Transfer-the-Domain-Level-Operations-Master-Roles.md), if appropriate.  
  
6.  [Transfer the Schema Master](../Topic/Transfer-the-Schema-Master.md), if appropriate.  
  
7.  [Transfer the Domain Naming Master](../Topic/Transfer-the-Domain-Naming-Master.md), if appropriate.  
  
8.  If you use File Replication Service \(FRS\) to replicate SYSVOL, you can decrease the time required to update SYSVOL when the domain controller is restarted by performing a preliminary registry update on the server. For instructions, see Prepare a domain controller for nonauthoritative SYSVOL restart \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122831](http://go.microsoft.com/fwlink/?LinkID=122831)\). This procedure is not necessary if you use Distributed File System \(DFS\) Replication.  
  
9. [Enable Strict Replication Consistency](../Topic/Enable-Strict-Replication-Consistency.md), if necessary. If strict replication consistency is not enabled on the domain controller that you are disconnecting, use this command\-line procedure to enable strict replication consistency on specific domain controllers or on all domain controllers in the forest.  
  
10. [Synchronize Replication with All Partners](../Topic/Synchronize-Replication-with-All-Partners.md). Update the domain controller with the latest changes just before you disconnect it.  
  
11. [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md) for the domain controller that you are disconnecting.  
  
12. Label the domain controller with the date and time of disconnection and the maximum safe\-disconnection period.  
  
## See Also  
 [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md)   
 [Managing Operations Master Roles](../Topic/Managing-Operations-Master-Roles.md)   
 [Managing DFS-Replicated SYSVOL](../Topic/Managing-DFS-Replicated-SYSVOL.md)   
 [Reconnecting a Domain Controller After a Long-Term Disconnection](../Topic/Reconnecting-a-Domain-Controller-After-a-Long-Term-Disconnection.md)  
  
  