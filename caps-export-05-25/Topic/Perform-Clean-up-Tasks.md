---
title: Perform Clean-up Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9d4c4efc-5437-466c-a53a-eb07cf04236e
author: Femila
---
# Perform Clean-up Tasks
After upgrading your Active Directory infrastructure to Active Directory Domain Services \(AD DS\), perform the following clean\-up operations:  
  
-   After the security descriptor propagator has finished building the single\-instance store, perform an offline defragmentation of the database on each upgraded domain controller. This reduces the size of AD DS on the file system by up to 40 percent, reduces the memory footprint, and updates pages in the database to the new format. For more information, see Compact the directory database file \(offline defragmentation\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=106343](http://go.microsoft.com/fwlink/?LinkID=106343)\).  
  
    > [!NOTE]  
    > This task is relevant only when you are performing an in\-place upgrade from Windows 2000 to Windows Server 2003. If you are upgrading a Windows 2000 domain controller to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \(which requires an in\-place upgrade from Windows 2000 to Windows Server 2003, followed by an in\-place upgrade from Windows Server 2003 to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]\), we recommend that you perform this task after your domain controller is upgraded to Windows Server 2003.  
  
-   Create a new System State backup for at least two domain controllers in your environment. For more information about backing up AD DS, see the AD DS Backup and Recovery Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93077](http://go.microsoft.com/fwlink/?LinkID=93077)\). Be sure to label all backup tapes with the operating system version that the domain controller is running, including service packs and hotfixes.  
  
