---
title: Checklist: Configuring Rules for the Encryption Zone
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2aa9c02d-fbab-460c-860a-244ddaa56e17
author: vhorne
---
# Checklist: Configuring Rules for the Encryption Zone
This checklist includes tasks for configuring connection security rules and IPsec settings in your GPOs to implement the encryption zone in an isolated domain.  
  
Rules for the encryption zone are typically the same as those for the isolated domain, with the exception that the main rule requires encryption in addition to authentication.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring encryption zone rules for Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2**  
  
A GPO for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] can simply be copied and then customized. This checklist assumes that you have already created the GPO for the isolated domain as described in [Checklist: Implementing a Domain Isolation Policy Design](../Topic/Checklist--Implementing-a-Domain-Isolation-Policy-Design.md). You can then copy those GPOs for use with the encryption zone. After you create the copies, modify the main rule to require encryption in addition to the authentication required by the rest of the isolated domain.  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/WFAS_icon_checkbox.gif)|Make a copy of the domain isolation GPOs to serve as a starting point for the GPOs for the encryption zone.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Copy a GPO to Create a New GPO](../Topic/Copy-a-GPO-to-Create-a-New-GPO.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Modify the group memberships and WMI filters so that they are correct for the encryption zone and the version of Windows for which this GPO is intended.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](../Topic/Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Add the encryption requirements for the zone.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure the Rules to Require Encryption on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](../Topic/Configure-the-Rules-to-Require-Encryption-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the Active Directory organizational unit hierarchy.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](../Topic/Link-the-GPO-to-the-Domain.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Add your test computers to the membership group for the encryption zone. Be sure to add at least one for each operating system supported by a different GPO in the group.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](../Topic/Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Verify that the connection security rules are protecting network traffic.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Verify That Network Traffic Is Authenticated](../Topic/Verify-That-Network-Traffic-Is-Authenticated.md)|  
  
