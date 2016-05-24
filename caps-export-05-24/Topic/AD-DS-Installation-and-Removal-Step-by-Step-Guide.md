---
title: AD DS Installation and Removal Step-by-Step Guide
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f349e1e7-c3ce-4850-9e50-d8886c866b52
author: Femila
---
# AD DS Installation and Removal Step-by-Step Guide
  Active Directory® Domain Services \(AD DS\) is a server role of the [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating systems. AD DS provides a distributed directory service that you can use for centralized, secure management of your network.  
  
 This guide describes the installation and removal processes for the AD DS server role. You can use the procedures in this guide to install and remove AD DS on servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in a test lab environment.  
  
## In this guide  
  
-   [What's New in AD DS Installation and Removal](../Topic/What-s-New-in-AD-DS-Installation-and-Removal.md)  
  
-   [Known Issues for Installing and Removing AD DS](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md)  
  
-   [Scenarios for Installing AD DS](../Topic/Scenarios-for-Installing-AD-DS.md)  
  
-   [Scenarios for Removing AD DS](../Topic/Scenarios-for-Removing-AD-DS.md)  
  
-   [Requirements for Installing AD DS](../Topic/Requirements-for-Installing-AD-DS.md)  
  
-   [Steps for Installing AD DS](../Topic/Steps-for-Installing-AD-DS.md)  
  
-   [Steps for Removing AD DS](../Topic/Steps-for-Removing-AD-DS.md)  
  
-   [Appendix of Unattended Installation Parameters](../Topic/Appendix-of-Unattended-Installation-Parameters.md)  
  
-   [Appendix of Functional Level Features](../Topic/Appendix-of-Functional-Level-Features.md)  
  
-   [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
-   [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008-R2--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
## Publication and revision history  
 The following table summarizes the revision history for this guide, including its original publication on Microsoft TechNet.  
  
|||  
|-|-|  
|Date|Revision|  
|April 2006|Original publication on Technet|  
|January 2009|-   This guide was amended to refer to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in addition to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].<br />-   In [Forcing the Removal of a Domain Controller](../Topic/Forcing-the-Removal-of-a-Domain-Controller.md), examples were added to show how to forcefully remove AD DS in an unattended operation. This operation may be required if you must forcefully remove AD DS from a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].|  
  
  