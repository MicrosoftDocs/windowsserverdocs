---
title: Scenarios for Removing AD DS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d4ce8fb8-7fa7-4d2d-87d4-03e3cdc9e6d0
author: Femila
---
# Scenarios for Removing AD DS
  You can remove the Active Directory Domain Services \(AD DS\) server role by using the Active Directory Domain Services Installation Wizard or an answer file or by running Dcpromo.exe at a command line.  
  
 For more information about parameters that are available for removing AD DS, see [Demotion Operation](../Topic/Demotion-Operation.md). For information about unattended AD DS removal return codes, see the [Unattended Installation Return Codes](../Topic/Unattended-Installation-Return-Codes.md).  
  
 These procedures for removing AD DS are applicable to domain controllers that run Windows 2000 Server, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
## Remove a domain controller from a domain  
 For procedures to remove a domain controller from an existing domain, see [Removing a Domain Controller from a Domain](../Topic/Removing-a-Domain-Controller-from-a-Domain.md).  
  
## Remove the last domain controller in a domain  
 For procedures to remove the last domain controller in a domain, see [Removing the Last Domain Controller in a Domain](../Topic/Removing-the-Last-Domain-Controller-in-a-Domain.md).  
  
## Remove the last domain controller in a forest  
 For procedures to remove the last domain controller in a forest, see [Removing the Last Domain Controller in a Forest](../Topic/Removing-the-Last-Domain-Controller-in-a-Forest.md).  
  
## Force the removal of a domain controller  
 As a last resort, if you do not have connectivity to other domain controllers, you might need to force the removal of AD DS from a domain controller. On domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can force the removal of AD DS while the server is started in Directory Services Restore Mode \(DSRM\). For procedures to force the removal of a domain controller, see [Forcing the Removal of a Domain Controller](../Topic/Forcing-the-Removal-of-a-Domain-Controller.md).  
  
  