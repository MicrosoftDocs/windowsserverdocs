---
title: Determine the Database Size and Location Online
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 84d64f3a-dac4-4b56-89ca-a9981423000e
author: Femila
---
# Determine the Database Size and Location Online
  You can use this procedure to determine the size and location of the Active Directory database when Active Directory Domain Services \(AD DS\) is running in normal Windows mode on a domain controller that is connected to the network \(that is, on a domain controller that is online\). When you determine the database size and location online, the size is reported in bytes. If you must manage the database file, the log files, or both, first determine the location and size of the files. By default, the database file and associated log files are stored in the *%systemroot%*\\NTDS directory.  
  
> [!IMPORTANT]  
>  Be sure to use the same method to check file sizes when you compare them. The size is reported differently, depending on whether the domain controller is online or offline. For information about determining database size offline, see [Determine the Database Size and Location Offline_1](../Topic/Determine-the-Database-Size-and-Location-Offline_1.md).  
  
 You can also use the **Search** command on the **Start** menu to locate the database file \(Ntds.dit\) or the edb\*.log file for the location of the database and log files, respectively.  
  
 If you have set garbage collection logging to report free disk space, Event ID 1646 in the Directory Service log also reports the size of the database file: “Total allocated hard disk space \(megabytes\):”  
  
 As an alternative, you can determine the size of the database file by listing the contents of the directory that contains the files.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine the database size and location online  
  
1.  On the domain controller on which you want to manage database files, open a command prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  Change directories to the directory that contains the files that you want to manage.  
  
3.  At the command prompt, type `dir`, and then press ENTER to examine the database size. In the following example command output, the Ntds.dit file and the log files are stored in the same directory. In the example, the files take up 58,761,256 bytes of disk space. This output is representative of a directory database to which few objects have been added.  
  
     **C:\\Windows\\NTDS\>dir**  
  
     **Volume in drive C has no label.**  
  
     **Volume Serial Number is 003D\-0E9E**  
  
     **Directory of C:\\Windows\\NTDS**  
  
     **01\/29\/2008  11:04 AM    \<DIR\>          .**  
  
     **01\/29\/2008  11:04 AM    \<DIR\>          ..**  
  
     **01\/29\/2008  10:29 AM             8,192 edb.chk**  
  
     **01\/29\/2008  10:29 AM        10,485,760 edb.log**  
  
     **01\/29\/2008  10:29 AM        10,485,760 edb00001.log**  
  
     **01\/29\/2008  10:29 AM        10,485,760 edbres00001.jrs**  
  
     **01\/29\/2008  10:29 AM        10,485,760 edbres00002.jrs**  
  
     **01\/29\/2008  10:29 AM        14,696,488 ntds.dit**  
  
     **01\/28\/2008  02:54 PM       2,113,536 temp.edb**  
  
     **7 File\(s\)     58,761,256 bytes**  
  
     **2 Dir\(s\)     126,027,243,520 bytes free**  
  
## See Also  
 [Determine the Database Size and Location Offline_1](../Topic/Determine-the-Database-Size-and-Location-Offline_1.md)  
  
  