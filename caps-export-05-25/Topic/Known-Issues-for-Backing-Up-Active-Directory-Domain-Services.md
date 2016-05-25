---
title: Known Issues for Backing Up Active Directory Domain Services
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5fe1e68c-8aa7-4620-94c7-d4ca3518ef71
author: Femila
---
# Known Issues for Backing Up Active Directory Domain Services
  The following known issues exist for backing up Active Directory Domain Services \(AD DS\) in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]:  
  
-   Administrator credentials are required for scheduling backups. A member of Backup Operators cannot schedule backups by default, and the privilege cannot be delegated.  
  
-   Windows Server Backup tools are not installed automatically. You must use Server Manager to install the Windows Server Backup Features, which include the Windows Server Backup snap\-in \(Wbadmin.msc\) and the Wbadmin.exe component of Windows PowerShell command\-line tools.  
  
-   Windows Server Backup does not support backing up to tape media.  
  
-   You cannot back up individual files and folders.  
  
-   You cannot perform or schedule system state backups by using Windows Server Backup. You must use the Wbadmin.exe command\-line tool.  
  
-   You cannot schedule weekly or monthly backups by using Windows Server Backup. However, you can use Task Scheduler to schedule manual backups that are performed at different times of the week.  
  
-   A system state backup and recovery includes Active Directory–integrated Domain Name System \(DNS\) zones but does not include file\-based DNS zones. To back up and restore file\-based DNS zones, you have to back up and recover the entire volume that hosts the files.  
  
-   The target volume for a system state backup cannot be a source volume by default. A source volume is any volume that has a file that is included in the backup. Therefore, the target volume cannot be any volume that hosts the operating system, Ntds.dit file, Ntds log files, or SYSVOL directory. To change this restriction, you can add the **AllowSSBToAnyVolume** registry entry to the server. However, there are known issues with storing a system state backup on a source volume:  
  
    -   Backups can fail. The backup can be modified during the backup process, which might cause the backup to fail.  
  
    -   Use of target space is inefficient. Twice the amount of space is necessary for a backup than for the original data. The volume must allocate twice the amount of space for the shadow copy process.  
  
         The path for adding the new registry entry is as follows:  
  
         **HKLM\\SYSTEM\\CurrentControlSet\\Services\\wbengine\\SystemStateBackup\\AllowSSBToAnyVolume**  
  
         Type: **DWORD**  
  
         A value of **0** prevents the storing of system state backup on a source volume. A value of **1** allows the storing of system state backup on a source volume.  
  
  