---
title: Boundary Zone GPOs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9aa96e2a-6d92-436c-8255-43467f1a6779
author: vhorne
---
# Boundary Zone GPOs
All the computers in the boundary zone are added to the group CG\_DOMISO\_Boundary. You must create multiple GPOs to align with this group, one for each operating system that you have in your boundary zone. This group is granted Read and Apply permissions in Group Policy on the GPOs described in this section.  
  
> [!NOTE]  
> If you are designing GPOs for only [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can design your GPOs in nested groups. For example, you can make the boundary group a member of the isolated domain group, so that it receives the firewall and basic isolated domain settings through that nested membership, with only the changes supplied by the boundary zone GPO. For simplicity, this guide describes the techniques used to create the independent, non\-layered policies. We recommend that you create and periodically run a script that compares the memberships of the groups that must be mutually exclusive and reports any computers that are incorrectly assigned to more than one group.  
  
This means that you create a GPO for a boundary group for a specific operating system by copying and pasting the corresponding GPO for the isolated domain, and then modifying the new copy to provide the behavior required in the boundary zone.  
  
The boundary zone GPOs discussed in this guide are only for server versions of Windows because client computers are not expected to participate in the boundary zone. If the need for one occurs, either create a new GPO for that version of Windows, or expand the WMI filter attached to one of the existing boundary zone GPOs to make it apply to the client version of Windows.  
  
In the Woodgrove Bank example, only the GPO settings for a Web service on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] are discussed.  
  
-   [GPO_DOMISO_Boundary_WS2008](../Topic/GPO_DOMISO_Boundary_WS2008.md)  
  
