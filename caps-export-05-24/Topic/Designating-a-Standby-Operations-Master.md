---
title: Designating a Standby Operations Master
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 720ebcf9-6211-42ac-9387-68ee2b48782b
author: Femila
---
# Designating a Standby Operations Master
  A standby operations master is a domain controller that you identify as the computer that assumes the operations master role if the original computer fails. A single domain controller can act as the standby operations master for all the operations master roles in a domain, or you can designate a separate standby for each operations master role.  
  
 When you designate a domain controller as the standby operations master, follow all the recommendations in "Guidelines for Role Placement" in [Introduction to Administering Operations Master Roles](../Topic/Introduction-to-Administering-Operations-Master-Roles.md).  
  
## Standby operations master computer requirements  
 No utilities or special steps are required to designate a domain controller as a standby operations master. However, the current operations master and the standby operations master should be well connected. “Well connected” means that the network connection between them must support at least a 10\-megabit transmission rate and be available at all times. In addition, creating a manual connection object between the standby domain controller and the operations master will ensure direct replication between the two operations masters. By making the operations master and the standby operations master direct replication partners, you reduce the chance of data loss in the event of a role seizure, which reduces the chance of directory corruption.  
  
## Replication requirements  
 Before you transfer a role from the current role holder to the standby operations master, ensure that replication between the two computers is functioning properly. Because they are replication partners, the new operations master is already consistent with the original operations master, which reduces the time that is required for the transfer operation.  
  
 During role transfer, the two domain controllers exchange any unreplicated information to ensure that no transactions are lost. If the two domain controllers are not direct replication partners, a substantial amount of information might have to be replicated before the domain controllers completely synchronize with each other. The role transfer requires extra time to replicate the outstanding transactions. If the two domain controllers are direct replication partners, fewer outstanding transactions exist and the role transfer operation completes sooner.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Repadmin.exe  
  
 To complete this task, perform the following procedure:  
  
-   [Determine Whether a Domain Controller Is a Global Catalog Server](../Topic/Determine-Whether-a-Domain-Controller-Is-a-Global-Catalog-Server.md)  
  
-   [Create a Connection Object on the Operations Master and Standby](../Topic/Create-a-Connection-Object-on-the-Operations-Master-and-Standby.md)  
  
-   [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
  