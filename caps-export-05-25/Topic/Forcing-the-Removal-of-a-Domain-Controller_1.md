---
title: Forcing the Removal of a Domain Controller_1
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: beaba727-e1d0-44ef-ba86-e05a26cb0ec4
author: Femila
---
# Forcing the Removal of a Domain Controller_1
  Forced removal of a domain controller from Active Directory Domain Services \(AD DS\) is intended to be used as a last resort to avoid having to reinstall the operating system on a domain controller that has failed and cannot be recovered. When a domain controller can no longer function in a domain \(that is, it is offline\), you cannot remove AD DS in the normal way, which requires connectivity to the domain. Forced removal is not intended to replace the normal AD DS removal procedure in any way. It is equivalent to permanently disconnecting the domain controller. However, after successful metadata cleanup of a forcibly removed domain controller, you can recreate the domain controller using the same name.  
  
> [!NOTE]  
>  On domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can perform a forced removal of AD DS on a server that can be started only in Directory Services Restore Mode \(DSRM\).  
  
 AD DS stores a considerable amount of metadata about a domain controller. During the normal process of uninstalling AD DS on a domain controller, this metadata is removed from AD DS through a connection to another domain controller in the domain. In a forced removal, it is assumed that there is no connectivity to the domain. Therefore, there is no attempt at metadata removal \(cleanup\) after a forced removal.  
  
 Consequently, forced removal of AD DS from a domain controller must always be followed by the metadata cleanup procedure, which removes all references to the domain controller from the domain and forest.  
  
 Forced removal should not be performed on the last domain controller in a domain. For this domain controller, you can reinstall the operating system to restore the server to network operation.  
  
 If the domain controller that you are forcibly removing holds an operations master \(also known as flexible single master operations or FSMO\) role or roles, transfer the roles before you perform the forced removal procedure. From a healthy domain controller in the domain of the operations master role, or in the forest if the role is a forest\-wide role, attempt to transfer the role to another domain controller. If you do not transfer operations master roles before you forcibly remove AD DS, the roles are transferred during the metadata cleanup process automatically. However, during metadata cleanup, you do not have the option to select the domain controller to which the roles are transferred. The cleanup application makes the selection automatically. If role transfer fails during metadata cleanup, you must seize the role following the metadata cleanup procedure. For more information about transferring and seizing operations master roles, see [Introduction to Administering Operations Master Roles](../Topic/Introduction-to-Administering-Operations-Master-Roles.md).  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Dcpromo.exe  
  
-   Ntdsutil.exe or Active Directory Users and Computers  
  
 To complete this task, perform the following procedures:  
  
1.  [Identify Replication Partners](../Topic/Identify-Replication-Partners.md). Use this procedure to identify a domain controller that is a replication partner of the domain controller that you are removing. Identify a replication partner in the same site, if possible. You will connect to this domain controller when you clean up server metadata.  
  
2.  [Force Domain Controller Removal](../Topic/Force-Domain-Controller-Removal.md)  
  
3.  [Clean Up Server Metadata](../Topic/Clean-Up-Server-Metadata.md)  
  
  