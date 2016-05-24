---
title: Performing the Domain Rename Operation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 996c84df-cee5-47e7-b5db-29808e05abb0
author: Femila
---
# Performing the Domain Rename Operation
  This task provides information about performing the domain rename operation. This task describes in detail the procedures that you complete to perform the domain rename operation in your forest. Be sure that you have reviewed and completed every preliminary procedure that applies to your domain rename conditions, as described in [Preparing for the Domain Rename Operation](../Topic/Preparing-for-the-Domain-Rename-Operation.md).  
  
 After you complete all the procedures in this task, the target domain name changes will be effective in your forest. The domain name changes will have propagated toall the domain controllers in your forest, as well as to the member computers in the renamed domains.  
  
 A brief period of interruption in your Active Directory forest service occurs during the time when all of the domain controllers in the forest are automatically restarting. The exact point at which the service interruption occurs is indicated in [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md). Except for this brief period of interruption, the Active Directory Domain Services \(AD DS\) service should continue to be available and function normally throughout the rest of the domain rename process.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Rendom.exe  
  
-   Repadmin.exe  
  
-   Gpfixup.exe  
  
 To complete this task, perform the following procedures:  
  
-   [Set Up the Control Station](../Topic/Set-Up-the-Control-Station.md)  
  
-   [Freeze the Forest Configuration](../Topic/Freeze-the-Forest-Configuration.md)  
  
-   [Back Up All Domain Controllers](../Topic/Back-Up-All-Domain-Controllers.md)  
  
-   [Generate the Current Forest Description](../Topic/Generate-the-Current-Forest-Description.md)  
  
-   [Specify the New Forest Description](../Topic/Specify-the-New-Forest-Description.md)  
  
-   [Generate Domain Rename Instructions](../Topic/Generate-Domain-Rename-Instructions.md)  
  
-   [Push Domain Rename Instructions to All Domain Controllers and Verify DNS Readiness](../Topic/Push-Domain-Rename-Instructions-to-All-Domain-Controllers-and-Verify-DNS-Readiness.md)  
  
-   [Verify Readiness of Domain Controllers](../Topic/Verify-Readiness-of-Domain-Controllers.md)  
  
-   [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md)  
  
-   [Exchange-Specific Steps: Update the Exchange Configuration and Restart Exchange Servers](../Topic/Exchange-Specific-Steps--Update-the-Exchange-Configuration-and-Restart-Exchange-Servers.md)  
  
-   [Unfreeze the Forest Configuration](../Topic/Unfreeze-the-Forest-Configuration.md)  
  
-   [Re-establish External Trusts](../Topic/Re-establish-External-Trusts.md)  
  
-   [Fix Group Policy Objects and Links](../Topic/Fix-Group-Policy-Objects-and-Links.md)  
  
  