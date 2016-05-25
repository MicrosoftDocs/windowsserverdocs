---
title: Seizing an operations master role
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 45a3934a-a831-4ba7-bcb1-d091f4014612
author: Femila
---
# Seizing an operations master role
  Role seizure is the act of assigning an operations master \(also known as flexible single master operations or FSMO\) role to a new domain controller without the cooperation of the current role holder—usually, because the current role holder is offline as a result of a hardware failure. During role seizure, the new domain controller assumes the operations master role without communicating with the current role holder.  
  
 Role seizure should be performed only as a last resort. Role seizure can cause the following directory problems:  
  
-   **Data loss or directory inconsistency as a result of replication latency.** The new role holder starts performing its duties based on the data that is located in its current directory partition. If replication did not complete before the time that the original role holder went offline, the new role holder might not have received the latest changes.  
  
     To minimize the risk of losing data to incomplete replication, do not perform a role seizure until enough time has passed to complete at least one end\-to\-end replication cycle across your network. Allowing enough time for complete end\-to\-end replication ensures that the domain controller that assumes the role is as up to date as possible.  
  
-   **Two domain controllers performing the same role.** Because the original role holder is offline when role seizure occurs, the original role holder is not informed that it is no longer the operations master role holder, which is not a problem if the original role holder stays offline. However, if the original role holder comes back online—for example, if the hardware is repaired or the server is restored from a backup\)—it might try to perform the operations master role that it previously owned. If two domain controllers are performing the same operations master role simultaneously, the severity of the effect from duplicate operations master roles varies, depending on the role that was seized. The effect can range from no visible effect to potential corruption of the Active Directory database. Do not allow a former operations master role holder whose role has been seized to return to an online domain controller.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Repadmin.exe  
  
-   Ntdsutil.exe  
  
 To complete this task, perform the following procedure:  
  
-   [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
     Verify replication to the domain controller that will be seizing the role.  
  
-   [Seize the Operations Master Role](../Topic/Seize-the-Operations-Master-Role.md)  
  
-   [View the Current Operations Master Role Holders](../Topic/View-the-Current-Operations-Master-Role-Holders.md)  
  
  