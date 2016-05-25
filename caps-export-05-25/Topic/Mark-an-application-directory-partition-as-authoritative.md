---
title: Mark an application directory partition as authoritative
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 91dc08a9-5519-4160-93cb-8c57956ea104
author: Femila
---
# Mark an application directory partition as authoritative
  If you are performing an authoritative restore to recover deletions in an application directory partition, you must mark the application directory partition as authoritative. Marking an application directory partition as authoritative requires a different procedure from the procedure that you use to mark other Active Directory objects as authoritative. You can use this procedure to select the application directory partition that you want to replicate authoritatively to other domain controllers that host the application directory partition.  
  
 This procedure has the following preliminary requirements:  
  
-   Before you perform this procedure, back up the domain controller that you are restoring. You should have a current valid backup of the application directory partition before restoring in case some object changes are lost as the result of changes that have occurred since the backup that you are using to restore the domain controller was made.  
  
-   If the entire application directory partition has been deleted, you must perform a nonauthoritative restore from backup on the domain naming operations master.  
  
-   You must have completed a nonauthoritative restore procedure, after which the domain controller has not been restarted and remains in Directory Services Restore Mode \(DSRM\).  
  
 The Ntdsutil functionality that is described in this procedure is available on domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. To perform authoritative restore on a domain controller that is running a version of Windows Server 2003, see Performing an Authoritative Restore of Active Directory Objects \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=44194](http://go.microsoft.com/fwlink/?LinkId=44194)\).  
  
 If you are performing this procedure in DSRM, the Administrator password for DSRM is the minimum required to complete this procedure. If you are performing this procedure with AD DS stopped on the domain controller, membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To mark an application directory partition as authoritative  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `ntdsutil`  
  
3.  At the `ntdsutil:` prompt, type `activate instance ntds`, and then press ENTER. For assistance with the Ntdsutil command line\-tool, type `help` at any time.  
  
4.  At the `ntdsutil:` prompt, type `authoritative restore`, and then press ENTER.  
  
5.  At the `authoritative restore:` prompt, type `List NC CRs`, and then press ENTER.  
  
     Ntdsutil displays a list of directory partition distinguished names and their associated cross\-reference object distinguished names. Note the cross\-reference distinguished name and application directory partition distinguished name that correspond to the application directory partition that you want to restore.  
  
6.  Type `restore subtree <App Partition DN>`, where `<App Partition DN>` is the distinguished name of the application directory partition that you want to restore.  
  
7.  In the confirmation dialog box, click **Yes**.  
  
     The output message indicates the status of the operation. There should be no failures.  
  
8.  Type `restore object <Cross Ref DN>`, where `<Cross Ref DN>` is the distinguished name of the cross\-reference object for the application directory partition that you want to restore, and then press ENTER.  
  
9. In the confirmation dialog box, click **Yes**.  
  
     The output message indicates the status of the operation. There should be no failures.  
  
10. Quit the Ntdsutil tool by typing `quit` at each prompt.  
  
## See Also  
 [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md)  
  
  