---
title: Restoring and Rebuilding SYSVOL
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 09f6db67-0ca4-4ce3-ae26-fcce99111943
author: Femila
---
# Restoring and Rebuilding SYSVOL
  A domain controller cannot function without a properly shared and replicating SYSVOL. If your efforts to move SYSVOL or perform certain maintenance tasks fail and SYSVOL is not replicating, you must recreate \(rebuild\) SYSVOL on the domain controller. Attempt to rebuild SYSVOL on a domain controller only when all other domain controllers in the domain have a healthy and functioning SYSVOL. Do not attempt to rebuild SYSVOL until you correct any problems that may be occurring with Distributed File System \(DFS\) Replication in a domain.  
  
 Use the procedures in this section only on a domain controller that does not have a functioning SYSVOL.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Event Viewer  
  
-   Dcdiag.exe  
  
-   ADSI Edit  
  
-   Net.exe  
  
-   Regedit.exe  
  
-   Windows Explorer  
  
-   Mklink.exe  
  
 To complete this task, perform the following procedures in order:  
  
1.  [Identify Replication Partners](../Topic/Identify-Replication-Partners.md)  
  
     You will import the SYSVOL from a replication partner.  
  
2.  [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md)  
  
     Perform this procedure on the replication partner from which you are copying SYSVOL to make sure that the SYSVOL tree that you copy from the partner is shared and replicating properly.  
  
3.  [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md)  
  
     Verify that replication is working on both replication partners.  
  
4.  [Gather the SYSVOL Path Information](../Topic/Gather-the-SYSVOL-Path-Information.md)  
  
5.  Restart the domain controller in Directory Services Restore Mode \(DSRM\) by using one of the following methods:  
  
    -   [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
         If you are sitting at the console of the domain controller, restart the domain controller locally in DSRM.  
  
    -   [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
         If you are accessing the domain controller remotely using Remote Desktop Connection, restart the domain controller remotely in DSRM.  
  
6.  [Stop the DFS Replication Service and Netlogon Service](../Topic/Stop-the-DFS-Replication-Service-and-Netlogon-Service.md)  
  
     In DSRM, the DFS Replication service is stopped automatically. You have to stop only the Netlogon service. Both services restart automatically when you restart the domain controller normally after you complete the procedure to import the SYSVOL folder structure.  
  
7.  [Import the SYSVOL Folder Structure](../Topic/Import-the-SYSVOL-Folder-Structure.md)  
  
8.  [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md)  
  
  