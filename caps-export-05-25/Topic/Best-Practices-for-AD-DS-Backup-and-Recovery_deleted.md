---
title: Best Practices for AD DS Backup and Recovery_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 185163fe-daa2-4a0c-bf4e-318a45677201
author: femila
---
# Best Practices for AD DS Backup and Recovery_deleted
Use the following best practices for backing up and recovering Active Directory Domain Services \(AD DS\):  
  
-   Store operating system files, the Active Directory database \(Ntds.dit\), and SYSVOL on separate volumes that do not contain other user, operating system, or application data.  
  
-   For domain controllers, perform regular backups of system state data by using the **wbadmin start systemstatebackup** command. For more information, see Wbadmin start systemstatebackup \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111741](http://go.microsoft.com/fwlink/?LinkId=111741)\).  
  
-   Create a backup volume on a dedicated internal or external hard drive. You cannot use a network shared folder as a backup target for a system state backup. To store a system state backup on a network shared folder, you must use a local volume as the backup target and then copy the backup to the network shared folder.  
  
-   To restore a domain controller, use the **wbadmin start systemstaterecovery** command. For more information, see Wbadmin start systemstaterecovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93337](http://go.microsoft.com/fwlink/?LinkID=93337)\).  
  
-   To avoid having to use the operating system media during recovery, use the Windows Automated Installation Kit to install Windows RE on a separate partition. Use that partition to access Windows Recovery options. For more information about the Windows Automated Installation Kit, see Windows Automated Installation Kit \(Windows AIK\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=90643](http://go.microsoft.com/fwlink/?LinkId=90643)\).  
  
