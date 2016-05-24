---
title: Relocating the Active Directory Database Files
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: cd196cb7-f998-4795-aed2-61de1e53b174
author: Femila
---
# Relocating the Active Directory Database Files
  Relocating Active Directory database files usually involves moving files to a temporary location while hardware updates are being performed and then moving the files to a permanent location. On domain controllers that are running versions of Windows 2000 Server and Windows Server 2003, moving database files requires restarting the domain controller in Directory Services Restore Mode \(DSRM\). Windows Server 2008 introduces restartable Active Directory Domain Services \(AD DS\), which you can use to perform database management tasks without restarting the domain controller in DSRM. Before you move database files, you must stop AD DS as a service. For information about restartable AD DS, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\).  
  
 The following conditions require moving database files:  
  
-   **Hardware maintenance**: If the physical disk on which the database or log files are stored requires upgrading or maintenance, the database files must be moved—either temporarily or permanently.  
  
-   **Low disk space**: When free disk space is low on the logical drive that stores the database file \(Ntds.dit\), the log files, or both, first verify that no other files are causing the problem. If the database file or log files are the cause of the growth, provide more disk space by taking one of the following actions:  
  
    -   Expand the partition on the disk that currently stores the database file, the log files, or both. This procedure does not change the path to the files and does not require updating the registry.  
  
    -   Use Ntdsutil.exe to move the database file, the log files, or both to a larger existing partition. If you are not using Ntdsutil.exe when you move files to a different partition, you must update the registry manually.  
  
 If the path to the database file or log files will change as a result of moving the files, be sure that you:  
  
-   Use Ntdsutil.exe to move the files \(rather than copying them\) so that the registry is updated with the new path. Even if you are moving the files only temporarily, use Ntdsutil.exe to move files locally so that the registry remains current.  
  
-   Perform a system state or critical\-volume backup as soon as the move is complete so that the restore procedure uses the correct path.  
  
-   Verify that the correct permissions are applied on the destination folder after the move. Revise permissions to just the permissions that are required to protect the database files, if necessary.  
  
 The registry entries that Ntdsutil.exe updates when you move the database file are as follows:  
  
 In **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\**  
  
 **Parameters:**  
  
-   Database backup path  
  
-   Directory System Agent \(DSA\) database file  
  
-   DSA working directory  
  
 The registry entry that Ntdsutil.exe updates when you move the log files is as follows:  
  
 In **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\**  
  
 **Parameters:**  
  
-   Database log files path  
  
## Disk space requirements for relocating Active Directory database files  
 **Temporary location**. Free space on the destination drive equivalent to at least the current size of the database file, the combined log files, or both, depending on which files you are moving.  
  
 **Permanent location**. Free space on the destination NTFS drive equivalent to at least the following specified size, plus space to accommodate anticipated growth, depending on which file or files you are moving.  
  
> [!CAUTION]  
>  The drive that is the permanent location of the database file or log files must be formatted as NTFS.  
  
-   Database file only: The size of the database file, plus 20 percent of the Ntds.dit file or 500 megabytes \(MB\), whichever is greater.  
  
-   Log files only: The size of the combined log files, plus 20 percent of the combined logs or 500 MB, whichever is greater.  
  
-   Database and logs. If the database and log files are stored on the same partition, free space should be at least 20 percent of the combined Ntds.dit and log files, or 1 gigabyte \(GB\), whichever is greater.  
  
> [!IMPORTANT]  
>  The preceding levels are minimum recommended levels. Therefore, adding additional space according to anticipated growth is recommended.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   net use, net stop, net start  
  
-   dir  
  
-   xcopy  
  
-   Ntdsutil.exe  
  
-   Windows Server Backup  
  
-   Windows Explorer  
  
> [!NOTE]  
>  If you replace or reconfigure a drive that stores the SYSVOL folder, you must first move the SYSVOL folder manually. For information about moving SYSVOL manually, see [Relocating SYSVOL Manually](../Topic/Relocating-SYSVOL-Manually.md).  
  
 To complete this task, perform the following procedures:  
  
> [!NOTE]  
>  The domain controller will not be available during the time in which files are being moved and until the move is verified. Ensure that alternate domain controllers are available during the file relocation to handle the capacity.  
  
1.  Determine the size and location of the Active Directory database by using one of the following procedures:  
  
    -   [Determine the Database Size and Location Online](../Topic/Determine-the-Database-Size-and-Location-Online.md)  
  
    -   [Determine the Database Size and Location Offline_1](../Topic/Determine-the-Database-Size-and-Location-Offline_1.md)  
  
2.  [Compare the Size of the Directory Database Files to the Volume Size](../Topic/Compare-the-Size-of-the-Directory-Database-Files-to-the-Volume-Size.md)  
  
3.  Perform a System State Backup of a Domain Controller by Using the Command Line \(Wbadmin\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118357](http://go.microsoft.com/fwlink/?LinkId=118357)\)  
  
     System state includes the database file and log files as well as SYSVOL and Net Logon shared folders, among other things. Always ensure that you have a current system state or critical\-volume backup before you move database files.  
  
4.  Move or copy the directory database and log files by performing one of the following procedures:  
  
    -   [Move the Directory Database and Log Files to a Local Drive](../Topic/Move-the-Directory-Database-and-Log-Files-to-a-Local-Drive.md)  
  
    -   [Copy the Directory Database and Log Files to a Remote Share](../Topic/Copy-the-Directory-Database-and-Log-Files-to-a-Remote-Share.md)  
  
         The shared folder on a remote drive must have enough free space to hold the database file \(Ntds.dit\) and log files. Create separate subdirectories for copying the database file and the log files.  
  
5.  Perform a System State Backup of a Domain Controller by Using the Command Line \(Wbadmin\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118357](http://go.microsoft.com/fwlink/?LinkId=118357)\)  
  
  