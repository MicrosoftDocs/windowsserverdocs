---
title: Active Directory Recycle Bin Step-by-Step Guide
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d2fc54a2-bbfc-40e7-aee0-65f84d908a1b
author: Femila
---
# Active Directory Recycle Bin Step-by-Step Guide
This guide provides step\-by\-step instructions and background information for enabling and using the Active Directory® Recycle Bin feature in the [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] operating system.  
  
Active Directory Recycle Bin helps minimize directory service downtime by enhancing your ability to preserve and restore accidentally deleted Active Directory objects without restoring Active Directory data from backups, restarting Active Directory Domain Services \(AD DS\), or rebooting domain controllers.  
  
When you enable Active Directory Recycle Bin, all link\-valued and non\-link\-valued attributes of the deleted Active Directory objects are preserved and the objects are restored in their entirety to the same consistent logical state that they were in immediately before deletion. For example, restored user accounts automatically regain all group memberships and corresponding access rights that they had immediately before deletion, within and across domains.  
  
Active Directory Recycle Bin is functional for both AD DS and Active Directory Lightweight Directory Services \(AD LDS\) environments.  
  
> [!IMPORTANT]  
> -   By default, Active Directory Recycle Bin in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is disabled. To enable it, you must first raise the forest functional level of your AD DS or AD LDS environment to Windows Server 2008 R2, which in turn requires all forest domain controllers or all servers that host instances of AD LDS configuration sets to be running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. After you set the forest functional level of your environment to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can use the instructions in this guide to enable Active Directory Recycle Bin.  
> -   In this release of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the process of enabling Active Directory Recycle Bin is irreversible. After you enable Active Directory Recycle Bin in your environment, you cannot disable it. For more information, see [Appendix A: Additional Active Directory Recycle Bin Tasks](../Topic/Appendix-A--Additional-Active-Directory-Recycle-Bin-Tasks.md).  
  
## In this guide  
  
-   [Scenario Overview for Restoring Deleted Active Directory Objects](../Topic/Scenario-Overview-for-Restoring-Deleted-Active-Directory-Objects.md)  
  
-   [Requirements for Active Directory Recycle Bin](../Topic/Requirements-for-Active-Directory-Recycle-Bin.md)  
  
-   [Step 1: Enable Active Directory Recycle Bin](../Topic/Step-1--Enable-Active-Directory-Recycle-Bin.md)  
  
-   [Step 2: Restore a Deleted Active Directory Object](../Topic/Step-2--Restore-a-Deleted-Active-Directory-Object.md)  
  
-   [Appendix A: Additional Active Directory Recycle Bin Tasks](../Topic/Appendix-A--Additional-Active-Directory-Recycle-Bin-Tasks.md)  
  
-   [Appendix B: Restore Multiple, Deleted Active Directory Objects &#40;Sample Script&#41;](../Topic/Appendix-B--Restore-Multiple,-Deleted-Active-Directory-Objects--Sample-Script-.md)  
  
-   [Appendix C: Possible Issues When Restoring Attributes Used by Directory-Enabled Applications](../Topic/Appendix-C--Possible-Issues-When-Restoring-Attributes-Used-by-Directory-Enabled-Applications.md)  
  
