---
title: Transferring an Operations Master Role
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fef7dc3c-d2c9-47d5-bc1a-46dffc90f1f9
author: Femila
---
# Transferring an Operations Master Role
  When you create a new domain, the Active Directory Domain Services Installation Wizard automatically assigns all the domain\-level operations master roles to the first domain controller that is created in that domain. When you create a new forest, the wizard also assigns the two forest\-level operations master roles to the first domain controller. After the domain is created and functioning, you might transfer various operations master roles to different domain controllers to optimize performance and simplify administration.  
  
 The first domain controller that you install to create a new forest is necessarily both a global catalog server and the infrastructure operations master role holder. When you install the second domain controller in the forest root domain, the Active Directory Domain Services Installation Wizard prompts you to transfer the infrastructure master role to the domain controller that you are installing. Select this option to avoid having to transfer the infrastructure operations master role manually.  
  
 The transfer of forest\-level and domain\-level operations master roles is performed as needed, and it is governed by the guidelines for placing operations master roles. Before you transfer an operations master role, ensure that replication between the current role holder and the domain controller that is assuming the role is updated.  
  
 When you transfer domain\-level roles, you must determine whether the domain controller that you want to assume an operations master role is a global catalog server. The infrastructure master for each domain must not host the global catalog.  
  
> [!CAUTION]  
>  Do not change the global catalog configuration on the domain controller that you want to assume an operations master role unless your information technology \(IT\) management authorizes that change. Changing the global catalog configuration can cause changes that can take days to complete, and the domain controller might not be available during that period. Instead, transfer the operations master roles to a different domain controller that is already properly configured.  
  
## Transferring to a standby operations master  
 When you follow the recommendations for operations master role placement, the standby operations master is a direct replication partner and it is ready to assume the operations master roles. Remember to designate a new standby operations master for the domain controller that assumes the operations master roles. For more information, see [Designating a Standby Operations Master](../Topic/Designating-a-Standby-Operations-Master.md).  
  
## Transferring an operations master role when no standby is ready  
 If you have not designated a standby operations master, you must properly prepare a domain controller to which you intend to transfer the operations master roles. If you are transferring the infrastructure master role, make sure that the target domain controller is not a global catalog server. Preparing the future operations master role holder is the same process as preparing a standby operations master. You must manually create a connection object to ensure that the standby operations master is a replication partner with the current role holder and that replication between the two domain controllers is updated.  
  
 **Task requirements**  
  
 The following are required to perform the procedures for this task:  
  
-   Repadmin.exe  
  
-   Active Directory Sites and Services  
  
-   Active Directory Domains and Trusts  
  
-   Active Directory Schema snap\-in  
  
-   Active Directory Users and Computers  
  
-   Ntdsutil.exe  
  
 To complete this task, perform the following procedure:  
  
-   [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
-   [Determine Whether a Domain Controller Is a Global Catalog Server](../Topic/Determine-Whether-a-Domain-Controller-Is-a-Global-Catalog-Server.md)  
  
-   [Install the Schema Snap-In](../Topic/Install-the-Schema-Snap-In.md)  
  
-   [Transfer the Schema Master](../Topic/Transfer-the-Schema-Master.md)  
  
-   [Transfer the Domain Naming Master](../Topic/Transfer-the-Domain-Naming-Master.md)  
  
-   [Transfer the Domain-Level Operations Master Roles](../Topic/Transfer-the-Domain-Level-Operations-Master-Roles.md)  
  
-   [View the Current Operations Master Role Holders](../Topic/View-the-Current-Operations-Master-Role-Holders.md)  
  
  