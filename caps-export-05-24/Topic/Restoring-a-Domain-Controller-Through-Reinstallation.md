---
title: Restoring a Domain Controller Through Reinstallation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 13152859-3ab6-423a-b938-e34554935db0
author: Femila
---
# Restoring a Domain Controller Through Reinstallation
  Restoring a domain controller through reinstallation is the same process as creating a new domain controller. It does not involve restoring from backup. This method relies on Active Directory replication to restore a domain controller to a working state, and it is valid only if another healthy domain controller exists in the same domain. This method is normally used on computers that function only as domain controllers.  
  
 Restoring through reinstallation is the only method by which a domain controller that is not part of the backup set can be restored. In addition, you might decide to use this method instead of a nonauthoritative restore because backup media is inaccessible or because this method is more convenient. Restoring a domain controller through reinstallation should not be a substitute for regular backup routines.  
  
 This method of restoring a domain controller requires a complete reinstallation of the operating system. We recommend that, before you install the operating system, you format the entire system disk, which removes all information on the system disk. Ensure that any important or relevant data is moved or backed up before you format the disk.  
  
 Bandwidth is the primary consideration for restoring a domain controller through reinstallation. The bandwidth that is required is directly proportional to the size of the Active Directory database and the time in which the domain controller is required to be in a functioning state. Ideally, the existing functional domain controller should be located in the same Active Directory site as the replicating domain controller \(the new domain controller\) to reduce the impact on the network and the time that the reinstallation takes to complete.  
  
> [!NOTE]  
>  Before you restore a domain controller through reinstallation, ensure that hardware failure is not the cause of the problem. If faulty hardware is not changed, restoring through reinstallation might not solve the problems with the domain controller.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Ntdsutil.exe  
  
-   Dcdiag.exe  
  
-   Dcpromo.exe  
  
 To complete this task, perform the following procedures:  
  
1.  Use the following procedure to clean up server metadata to remove the NTDS Settings object of the failed domain controller:  
  
     [Clean Up Server Metadata](../Topic/Clean-Up-Server-Metadata.md)  
  
     If you plan to give the new domain controller a different name from the name of the failed domain controller, in addition to cleaning up server metadata perform the following procedure:  
  
     [Delete a Server Object from a Site](../Topic/Delete-a-Server-Object-from-a-Site.md)  
  
2.  Install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
     A fresh installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] is assumed. Prepare for installation of the operating system by partitioning or reformatting the hard disk drive, if necessary.  
  
    > [!NOTE]  
    >  This guide does not provide information about installing [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. For information about installing [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see Installing [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111104](http://go.microsoft.com/fwlink/?LinkID=111104)\).  
  
3.  [Verify DNS Registration and TCP - IP Connectivity](../Topic/Verify-DNS-Registration-and-TCP---IP-Connectivity.md)  
  
4.  [Verify the Availability of the Operations Masters](../Topic/Verify-the-Availability-of-the-Operations-Masters.md)  
  
5.  [Install an Additional Domain Controller by Using the Windows Interface](../Topic/Install-an-Additional-Domain-Controller-by-Using-the-Windows-Interface.md)  
  
     During the installation process, replication occurs, which ensures that the domain controller has an accurate and up\-to\-date copy of Active Directory Domain Services \(AD DS\). You have the option to use the same information for this domain controller as the domain controller that it is replacing: site placement, domain controller name, and domain membership should remain the same. If you plan to install the domain controller under a different name, see [Installing a Domain Controller in an Existing Domain](../Topic/Installing-a-Domain-Controller-in-an-Existing-Domain.md).  
  
6.  After you install AD DS, see [Verifying Active Directory Installation](../Topic/Verifying-Active-Directory-Installation.md) and perform procedures for verification of the installation.  
  
  