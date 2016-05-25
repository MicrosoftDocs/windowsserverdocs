---
title: Compare the Size of the Directory Database Files to the Volume Size
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 70253f8e-0ee0-4871-99c0-71e1935330ab
author: Femila
---
# Compare the Size of the Directory Database Files to the Volume Size
  Before you move any Active Directory database files in response to low disk space, verify that no other files on the volume are responsible for the condition of low disk space.  
  
 You might have to relocate the database file, the log files, or both, if disk space on the volume on which they are stored becomes low. Before you move the database file or log files, examine the size of the database folder, logs folder, or both—if they are stored in the same location—compared to the size of the volume to verify that these files are the cause of low disk space. Include the size of the SYSVOL folder if it is on the same partition. You can use this procedure to compare the size of the directory database files to the size of the volume.  
  
 If Active Directory Domain Services \(AD DS\) is started when you are comparing the size of the directory database files and volume, membership in **Domain Admins** is the minimum required to complete this procedure. If AD DS is stopped, membership in **Builtin Administrators** is the minimum required to complete this procedure. If the domain controller is restarted in Directory Services Restore Mode \(DSRM\), the DSRM administrator password is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To compare the size of the directory database files to the volume size  
  
1.  On the **Start** menu, click **Computer**.  
  
2.  In the **Folders** list, click **Computer**.  
  
3.  In the details pane, locate the volume that has low disk space. Make a note of the value in the **Total Size** column for that volume.  
  
4.  Navigate to the folder that stores the database file, the log files, or both.  
  
5.  Right\-click the folder, and then click **Properties**. Make a note of the value in **Size on disk**.  
  
6.  If the volume includes **SYSVOL**, navigate to that folder and repeat step 5.  
  
7.  Compare the values of **Total Size** \(volume\) and **Size on disk** \(database files plus SYSVOL if SYSVOL is on the same volume\). If the combined size of the relevant database files and SYSVOL files \(if appropriate\) is significantly smaller than the volume size, check the contents of the volume for other files.  
  
8.  If other files are present, move those files and then reassess the disk space on the volume.  
  
  