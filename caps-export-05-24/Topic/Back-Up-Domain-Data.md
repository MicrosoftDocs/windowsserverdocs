---
title: Back Up Domain Data
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6522b8be-20d8-4b3f-8a35-a989476b7343
author: Femila
---
# Back Up Domain Data
Back up your domain data before you begin the upgrade. This task varies based on the operations and procedures that already exist in your environment. At a minimum, complete the following steps:  
  
-   To allow for fault tolerance, ensure successful replication between two domain controllers in each domain.  
  
-   Back up two domain controllers in each domain in the forest, including System State data.  
  
-   Test all backup media to ensure that the data can be restored successfully.  
  
    > [!IMPORTANT]  
    > Store backup media in a secure offsite location designated by \(and accessible to\) the upgrade team before you begin the upgrade process.  
  
Develop a recovery plan to use if some portion of your domain upgrade process fails. A successful recovery plan includes the following:  
  
-   Step\-by\-step instructions that enable the upgrade team to restore normal operations to the organization.  
  
-   An approval process, ensuring that all team members review, agree on, and approve the recovery plan.  
  
> [!NOTE]  
> If you plan to retire or upgrade the first promoted domain controllers of your Windows 2000 or Windows Server 2003 domains, we highly recommend that you export and back up the private key of the Encrypting File System \(EFS\) recovery agent. EFS is a component of the NTFS file system that enables transparent encryption and decryption of files by using advanced, standard cryptographic algorithms. You can use EFS to encrypt data files to prevent unauthorized access. For more information, see [article 241201](http://go.microsoft.com/fwlink/?LinkId=114578) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114578\).  
  
