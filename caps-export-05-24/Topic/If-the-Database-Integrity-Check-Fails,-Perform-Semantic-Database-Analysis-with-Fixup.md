---
title: If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 487804f1-7cf0-4c24-99cd-dad3a8d8a7da
author: Femila
---
# If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup
  When you move or compact the Active Directory database, if the integrity check fails, you must run a subsequent database test called semantic database analysis. When you run semantic database analysis with the **Go Fixup** command instead of the **Go** command, errors are written into Dsdit.dmp.xx log files. A progress indicator reports the status of the check. You can use this procedure to perform semantic database analysis with fixup.  
  
> [!NOTE]  
>  To perform this procedure, Active Directory Domain Services \(AD DS\) must be offline. On domain controllers that are running Windows Server 2008, you can take AD DS offline by stopping the service. Otherwise, the domain controller must be started in Directory Services Restore Mode \(DSRM\). For information about stopping the AD DS service on domain controllers that are running Windows Server 2008, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\). For information about performing this procedure in DSRM, see If database integrity check fails, perform semantic database analysis with fixup on the Microsoft Web site \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=121568](http://go.microsoft.com/fwlink/?LinkId=121568)\).  
  
 Membership in **Builtin Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To perform semantic database analysis with fixup  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `net stop ntds`  
  
     Type `Y` to agree to stop additional services, and then press ENTER.  
  
3.  At the command prompt, type `ntdsutil`, and then press ENTER.  
  
4.  At the `ntdsutil:` prompt, type `activate instance ntds`, and then press ENTER.  
  
5.  At the `ntdsutil:` prompt, type `semantic database analysis`, and then press ENTER.  
  
6.  At the `semantic checker:` prompt, type `verbose on`, and then press ENTER.  
  
7.  At the `semantic checker:` prompt, type `go fixup`, and then press ENTER.  
  
    -   If errors are reported during the semantic database analysis `Go Fixup` phase, perform directory database recovery: Go to the `file maintenance:` prompt, type `recover`, and then press ENTER.  
  
    -   If semantic database analysis with fixup succeeds, at the `semantic checker` prompt, type `quit`, and then type `quit` again to close Ntdsutil.exe.  
  
8.  At the command prompt, type the following command, and then press ENTER:  
  
     `net start ntds`  
  
  