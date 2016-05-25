---
title: Relocating SYSVOL Manually
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 08fe006f-61ed-4eb4-8a77-2ca5fa4ba9a3
author: Femila
---
# Relocating SYSVOL Manually
  If you want to move all folders in the SYSVOL directory, you can relocate these folders manually. You must carefully copy all folders and retain the same level of security at the new location.  
  
> [!CAUTION]  
>  The recommended method for relocating SYSVOL is to remove Active Directory Domain Services \(AD DS\) and then reinstall AD DS with the new SYSVOL path. Because of the potential for error, we do not recommend relocating SYSVOL manually.  
  
 If you choose to move SYSVOL manually, you first copy the entire folder structure to a new location; then, you update the SYSVOL junction point and the parameters that are stored in the registry and in AD DS. As an option, you can relocate the staging areas subdirectory only. For information about relocating the staging areas subdirectory, see [Relocating the SYSVOL Staging Area](../Topic/Relocating-the-SYSVOL-Staging-Area.md).  
  
> [!IMPORTANT]  
>  Before you relocate all or part of SYSVOL, be sure to inform domain administrators that you are doing so and that they should not make any changes in the SYSVOL directory until the move is complete.  
  
 Relocating SYSVOL can alter security settings if you do not use a copy method that retains file ownership and access control list \(ACL\) settings. The copy method that is described in this procedure retains security settings. After you move the SYSVOL tree, verify that the security settings on the relocated SYSVOL folders match the settings on the original SYSVOL folder structure. As an alternative, you can reapply security settings on the moved SYSVOL.  
  
 When you have completed SYSVOL relocation, force replication from the updated domain controller to a replication partner in the domain.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Net.exe  
  
-   Dcdiag.exe  
  
-   Event Viewer  
  
-   ADSI Edit  
  
-   Regedit.exe  
  
-   Dir.exe  
  
-   Windows Explorer  
  
-   Robocopy.exe  
  
     To prevent conflicts, use the updated version of Robocopy available in [Microsoft Knowledge Base article 979808](http://support.microsoft.com/kb/979808).  
  
-   Mklink.exe  
  
-   If you choose to reapply security settings manually, the following additional tools are required:  
  
    -   Notepad.exe  
  
    -   Secedit.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Identify Replication Partners](../Topic/Identify-Replication-Partners.md)  
  
2.  [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md)  
  
3.  [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md)  
  
4.  [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md)  
  
5.  [Stop the DFS Replication Service and Netlogon Service](../Topic/Stop-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
6.  [Change the SYSVOL Netlogon Parameters](../Topic/Change-the-SYSVOL-Netlogon-Parameters.md)  
  
7.  [Copy SYSVOL to a New Location](../Topic/Copy-SYSVOL-to-a-New-Location.md)  
  
8.  [Create the SYSVOL Root and Staging Areas Junction Point](../Topic/Create-the-SYSVOL-Root-and-Staging-Areas-Junction-Point.md)  
  
9. [Change the SYSVOL Root Path or Staging Areas Path, or Both](../Topic/Change-the-SYSVOL-Root-Path-or-Staging-Areas-Path,-or-Both.md)  
  
10. [Reapply Default SYSVOL Security Settings](../Topic/Reapply-Default-SYSVOL-Security-Settings.md)  
  
     You can use this procedure if you want to reapply the default security settings to the SYSVOL directory. However, if you use the Robocopy command that is specified in [Copy SYSVOL to a New Location](../Topic/Copy-SYSVOL-to-a-New-Location.md), file ownership and access control list \(ACL\) settings are retained on the copied SYSVOL folders and files, and reapplying security settings is not required.  
  
11. [Start the DFS Replication Service and Netlogon Service](../Topic/Start-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
12. [Verify SYSVOL is shared in the new location](../Topic/Verify-SYSVOL-is-shared-in-the-new-location.md)  
  
13. [Force Replication Between Domain Controllers](../Topic/Force-Replication-Between-Domain-Controllers.md)  
  
 After all these steps are complete and you verify replication succeeds, delete the original location of SYSVOL so only the new SYSVOL folder exists on the domain controller. By default, administrators are denied from deleting SYSVOL. You need to grant full control on all files, folders, and subfolders before you can complete the deletion.  
  
  