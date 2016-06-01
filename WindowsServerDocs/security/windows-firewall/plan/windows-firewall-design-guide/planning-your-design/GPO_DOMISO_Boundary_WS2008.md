---
title: GPO_DOMISO_Boundary_WS2008
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7da694d8-966b-41d7-9f6a-1afeaacc0744
---
# GPO_DOMISO_Boundary_WS2008
This GPO is authored by using the [!INCLUDE[wfas](includes/wfas_md.md)] interface in the Group Policy editing tools. Woodgrove Bank began by copying and pasting the GPO for the [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] version of the isolated domain GPO, and then renamed the copy to reflect its new purpose.

This GPO supports the ability for computers that are not part of the isolated domain to access specific servers that must be available to those untrusted computers. It is intended to only apply to server computers that are running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)].

## IPsec settings
The copied GPO includes and continues to use the IPsec settings that configure key exchange, main mode, and quick mode algorithms for the isolated domain when authentication can be used.

## Connection security rules
Rename the **Isolated Domain Rule** to **Boundary Zone Rule**. Change the authentication mode to **Request inbound and request outbound**. In this mode, the computer uses authentication when it can, such as during communication with a member of the isolated domain. It also supports the "fall back to clear" ability of request mode when an untrusted computer that is not part of the isolated domain connects.

## Registry settings
The boundary zone uses the same registry settings as the isolated domain to optimize IPsec operation. For more information, see the description of the registry settings in [Isolated Domain](Isolated-Domain.md).

## Firewall rules
Copy the firewall rules for the boundary zone from the GPO that contains the firewall rules for the isolated domain. Customize this copy, removing rules for services not needed on servers in this zone, and adding inbound rules to allow the network traffic for the services that are to be accessed by other computers. For example, Woodgrove Bank added a firewall rule to allow inbound network traffic to TCP port 80 for Web client requests.

Make sure that the GPO that contains firewall rules for the isolated domain does not also apply to the boundary zone to prevent overlapping, and possibly conflicting rules.

**Next:**[Encryption Zone GPOs](Encryption-Zone-GPOs.md)


