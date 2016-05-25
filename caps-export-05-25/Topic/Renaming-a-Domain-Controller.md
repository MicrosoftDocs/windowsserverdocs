---
title: Renaming a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: aefed46f-dde3-4e62-bc6b-1195cf31ba55
author: Femila
---
# Renaming a Domain Controller
  You can use the Netdom.exe command\-line tool to rename a domain controller if the domain functional level is Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. At these domain functional levels, Netdom provides the required preparation for Domain Name System \(DNS\) and service recognition of the new domain controller name. You can also use the System Properties user interface \(UI\), which does not require a domain functional level and does not provide the same preparation but which relies solely on replication to update the domain controller DNS name and service principal name \(SPN\). This method can result in a longer delay before clients can use the renamed domain controller.  
  
 The ability to rename domain controllers provides you with the flexibility to:  
  
-   Restructure your network for organizational and business needs.  
  
-   Make management and administrative control easier.  
  
 Renaming a domain controller is a common operation in many organizations, and it usually occurs when:  
  
-   New hardware is purchased to replace an existing domain controller.  
  
-   Domain controllers are decommissioned or promoted and renamed to maintain a naming convention.  
  
-   Domain controllers are moved or placed in sites.  
  
> [!NOTE]  
>  It is important to note that domain controller names have a primary impact on administration, rather than client access. Renaming a domain controller is an optional exercise, and the effects of renaming a domain controller should be well understood before the domain controller is renamed.  
  
 Although you can use System Properties to rename a domain controller \(as you can for any computer\), Active Directory and DNS replication latency might temporarily prevent clients from locating or authenticating \(or both\) to the renamed domain controller. To avoid this delay, you can use the Netdom command\-line tool to rename a domain controller.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   System Properties or Netdom.exe  
  
-   Ldp.exe or ADSI Edit  
  
 If you want to use Netdom, the domain functional level must be set to Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 To complete this task, use one of the following two sets of procedures:  
  
1.  [Rename a Domain Controller Using System Properties](../Topic/Rename-a-Domain-Controller-Using-System-Properties.md)  
  
2.  [Update the FRS or DFS Replication Member Object](../Topic/Update-the-FRS-or-DFS-Replication-Member-Object.md)  
  
 Or  
  
1.  [Rename a Domain Controller Using Netdom](../Topic/Rename-a-Domain-Controller-Using-Netdom.md)  
  
2.  [Update the FRS or DFS Replication Member Object](../Topic/Update-the-FRS-or-DFS-Replication-Member-Object.md)  
  
> [!NOTE]  
>  After you rename your domain controller, you must manually update the File Replication Service \(FRS\) or Distributed File System \(DFS\) Replication member object. This object must be updated with the new domain controller name so that the domain controller can replicate SYSVOL. Because the FRS or DFS Replication member object is not updated with the domain controller name automatically during the domain controller rename, we recommend that you rename your server before you promote it to domain controller status.  
  
  