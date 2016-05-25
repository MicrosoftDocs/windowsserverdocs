---
title: Known Issues for AD DS Backup and Recovery_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 36c24f8b-462a-4b6f-8fcb-545a0c786d3c
author: femila
---
# Known Issues for AD DS Backup and Recovery_deleted
The following known issues exist for Active Directory Domain Services \(AD DS\) Backup and Recovery in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]:  
  
-   Administrator credentials are required for scheduling backups. Backup Operator cannot schedule backups by default, and the privilege cannot be delegated.  
  
-   Windows Recovery Environment \(Windows RE\), which is required for volume recovery, does not support Terminal Services.  
  
-   A system state backup and recovery includes Active Directory–integrated Domain Name System \(DNS\) zones but does not include file\-based DNS zones. To back up and restore file\-based DNS zones, you have to back up and recover the entire volume that hosts the files.  
  
    > [!NOTE]  
    > Windows RE is available on the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system product disc.  
  
-   The target volume for a system state backup cannot be a critical volume by default. A critical volume is any volume that has a file that is included in the system state backup. To change that behavior, you can add the **AllowSSBToAnyVolume** registry entry to the server. You must also verify that the following prerequisites are met before you perform a system state backup to a critical volume:  
  
    -   The volume used to store the system state backup needs twice the amount of free space as the size of the system state backup, until the backup completes.  
  
    -   Make sure that the target volume has no shadow copy before the backup starts.  
  
    -   If a system state backup is stored on a source volume, backup settings should be configured for full backups. By default, these settings are configured for full backups.  
  
    -   Periodically check that no other user or program maintains a shadow copy on the target volume.  
  
    -   Do not keep volume\-level backups and system state backups in the same location.  
  
    To add the **AllowSSBToAnyVolume** value to the registry:  
  
    1.  Open Registry Editor. [!INCLUDE[regedit](../Token/regedit_md.md)]  
  
    2.  Browse to HKLM\\SYSTEM\\CurrentControlSet\\Services\\wbengine.  
  
    3.  Right\-click the **wbengine** key, click **New**, click **Key**, and then type **SystemStateBackup**.  
  
    4.  Click **SystemStateBackup**. Click **Edit**, click **New**, click **DWORD \(32\-bit\) value**, type **AllowSSBToAnyVolume** and press ENTER.  
  
    5.  Double\-click **AllowSSBToAnyVolume** and type **1** as the value and then click **OK**.  
  
    A value of **0** prevents the storing of system state backup on a source volume. A value of **1** allows the storing of system state backup on a source volume.  
  
