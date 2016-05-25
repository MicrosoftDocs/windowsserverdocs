---
title: Relocating the SYSVOL Staging Area
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 278b0321-b144-43c8-8103-a66c5bd79363
author: Femila
---
# Relocating the SYSVOL Staging Area
  When you install Active Directory Domain Services \(AD DS\), the Active Directory Domain Services Installation Wizard installs folders that are referred to as “the SYSVOL staging area.” The Active Directory Domain Services Installation Wizard creates two folders—%systemroot%\\SYSVOL\\staging and %systemroot%\\SYSVOL\\staging areas—which the Distributed File System \(DFS\) Replication service uses as the queue for changes that are to be replicated to other domain controllers. “Staging” and “staging areas” are default names. When you relocate these staging folders, you can change the name. Ensure that you identify the proper area in the SYSVOL tree in case it is renamed in your environment.  
  
> [!IMPORTANT]  
>  Before you relocate all or part of SYSVOL, be sure to inform domain administrators that you are doing so and that they should not make any changes in the SYSVOL directory until the move is complete.  
  
 Two values determine the location of the staging area:  
  
-   The **msDFSR\-StagingPath** attribute of the object CN\=SYSVOL Subscription,CN\=Domain System Volume,CN\=DFSR\-LocalSettings,CN\=DomainControllerName,OU\=Domain Controllers,DC\=DomainName in AD DS. This attribute contains the path to the actual location that DFS Replication uses to stage files.  
  
-   A junction point that is stored in the staging areas folder in SYSVOL that links to the actual location that DFS Replication uses to stage files.  
  
 After you move the staging areas folders, you must change the staging folder path in AD DS. The staging junction point is updated automatically to reference the new location when you restart the DFS Replication service and Netlogon service. You do not have to update the staging junction point manually. After you move the staging areas folders, force replication of the changes to a replication partner in the domain.  
  
 Except where noted, perform these procedures on the domain controller that contains the staging folder that you want to relocate.  
  
 **Task requirements**  
  
 An understanding of the SYSVOL folder structure is necessary for this task. For information about the SYSVOL folder structure, see [Introduction to Administering DFS-Replicated SYSVOL](../Topic/Introduction-to-Administering-DFS-Replicated-SYSVOL.md).  
  
 The following tools are required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Event Viewer  
  
-   Net.exe  
  
-   Dcdiag.exe  
  
-   Regedit.exe  
  
-   ADSI Edit  
  
 To complete this task, perform the following procedures:  
  
-   [Identify Replication Partners](../Topic/Identify-Replication-Partners.md)  
  
-   [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md)  
  
-   [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md)  
  
-   [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md)  
  
-   [Stop the DFS Replication Service and Netlogon Service](../Topic/Stop-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
-   [Create the SYSVOL Staging Areas Folder Structure](../Topic/Create-the-SYSVOL-Staging-Areas-Folder-Structure.md)  
  
-   [Change the SYSVOL Root Path or Staging Areas Path, or Both](../Topic/Change-the-SYSVOL-Root-Path-or-Staging-Areas-Path,-or-Both.md)  
  
-   [Start the DFS Replication Service and Netlogon Service](../Topic/Start-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
-   [Force Replication Between Domain Controllers](../Topic/Force-Replication-Between-Domain-Controllers.md)  
  
  