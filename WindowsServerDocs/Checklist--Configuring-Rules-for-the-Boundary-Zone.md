---
title: Checklist: Configuring Rules for the Boundary Zone
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c081f519-4f6e-4ad6-82c8-b68a39f4c176
---
# Checklist: Configuring Rules for the Boundary Zone
The following checklists include tasks for configuring connection security rules and IPsec settings in your GPOs to implement the boundary zone in an isolated domain.

Rules for the boundary zone are typically the same as those for the isolated domain, with the exception that the final rule is left to only request, not require, authentication.

## <a name="bkmk_section1"></a>![](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring boundary zone rules for computers running Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2**

A GPO for [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] can simply be copied and then customized. This checklist assumes that you have already created the GPO for the isolated domain as described in [Checklist: Implementing a Domain Isolation Policy Design](Checklist--Implementing-a-Domain-Isolation-Policy-Design.md). After you create a copy for the boundary zone, make sure that you do not change the rule from request authentication to require authentication when you create the other GPOs.

||Task|Reference|
|-|--------|-------------|
|![](media/WFAS_icon_checkbox.gif)|Make a copy of the domain isolation GPO for this version of Windows to serve as a starting point for the GPO for the boundary zone. Unlike the GPO for the main isolated domain zone, this copy is not changed after deployment to require authentication.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Copy a GPO to Create a New GPO](Copy-a-GPO-to-Create-a-New-GPO.md)|
|![](media/WFAS_icon_checkbox.gif)|If you are working on a copy of a GPO, modify the group memberships and WMI filters so that they are correct for the boundary zone and version of Windows for which this GPO is intended.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|
|![](media/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the Active Directory organizational unit hierarchy.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](Link-the-GPO-to-the-Domain.md)|
|![](media/WFAS_icon_checkbox.gif)|Add your test computers to the membership group for the boundary zone. Be sure to add at least one for each operating system supported by a different GPO in the group.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|
|![](media/WFAS_icon_checkbox.gif)|Verify that the connection security configuration is protecting network traffic with authentication when it can, and that unauthenticated traffic is accepted.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Verify That Network Traffic Is Authenticated](Verify-That-Network-Traffic-Is-Authenticated.md)|


