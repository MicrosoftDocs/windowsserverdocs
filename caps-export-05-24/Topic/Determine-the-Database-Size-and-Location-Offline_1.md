---
title: Determine the Database Size and Location Offline_1
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 521ecae8-372c-488f-ace1-a7ac22c61eda
author: Femila
---
# Determine the Database Size and Location Offline_1
  You can use this procedure to determine the size and location of the Active Directory database when Active Directory Domain Services \(AD DS\) is offline. When you determine the database size and location offline, the size is reported in megabytes \(MB\). On domain controllers that are running Windows Server 2008, you can take AD DS offline by stopping the service. Otherwise, the domain controller must be started in Directory Services Restore Mode \(DSRM\). For information about stopping the AD DS service on domain controllers that are running Windows Server 2008, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\).  
  
> [!IMPORTANT]  
>  Be sure to use the same method to check file sizes when you compare them. The size is reported differently, depending on whether the domain controller is online or offline. For information about determining database size online, see [Determine the Database Size and Location Online](../Topic/Determine-the-Database-Size-and-Location-Online.md).  
  
 If you have set garbage collection logging to report free disk space, Event ID 1646 in the Directory Service log also reports the size of the database file: “Total allocated hard disk space \(megabytes\):”  
  
 As an alternative, you can determine the size of the database file by listing the contents of the directory that contains the files.  
  
 Membership in **Builtin Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine the database size and location offline  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `net stop ntds`  
  
     Type `Y` to agree to stop additional services, and then press ENTER.  
  
3.  At the command prompt, type `ntdsutil`, and then press ENTER.  
  
4.  At the `ntdsutil` prompt, type `activate instance ntds`, and then press ENTER.  
  
5.  At the `ntdsutil` prompt, type `files`, and then press ENTER.  
  
6.  At the `file maintenance` prompt, type `info`, and then press ENTER. Make a note of the file sizes that appear.  
  
7.  At the `file maintenance` prompt, type **quit**, and then press ENTER. Type `quit`, and then press ENTER again to quit Ntdsutil.exe.  
  
8.  At the command prompt, type the following command, and then press ENTER:  
  
     `net start ntds`  
  
## See Also  
 [Determine the Database Size and Location Online](../Topic/Determine-the-Database-Size-and-Location-Online.md)  
  
  