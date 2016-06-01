---
title: GPO_DOMISO_Encryption_WS2008
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: de62cc4a-210d-46b0-942e-f768ca3f0f82
---
# GPO_DOMISO_Encryption_WS2008
This GPO is authored by using the [!INCLUDE[wfas](includes/wfas_md.md)] interface in the Group Policy editing tools. Woodgrove Bank began by copying and pasting the GPO for the [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] version of the isolated domain GPO, and then renamed the copy to reflect its new purpose.

This GPO supports the ability for servers that contain sensitive data to require encryption for all connection requests. It is intended to only apply to server computers that are running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)].

## IPsec settings
The copied GPO includes and continues to use the IPsec settings that configure key exchange, main mode, and quick mode algorithms for the isolated domain The following changes are made to encryption zone copy of the GPO:

The encryption zone servers require all connections to be encrypted. To do this, change the IPsec default settings for the GPO to enable the setting **Require encryption for all connection security rules that use these settings**. This disables all integrity\-only algorithm combinations.

## Connection security rules
Rename the **Isolated Domain Rule** to **Encryption Zone Rule**. Leave the authentication mode setting on **Require inbound and request outbound**. In this mode, the computer forces authentication for all inbound network traffic, and uses it when it can on outbound traffic.

## Registry settings
The encryption zone uses the same registry settings as the isolated domain to optimize IPsec operation. For more information, see the description of the registry settings in [Isolated Domain](Isolated-Domain.md).

## Firewall rules
Copy the firewall rules for the encryption zone from the GPO that contains the firewall rules for the isolated domain. Customize this copy, removing rules for services not needed on servers in this zone, and adding inbound rules to allow the network traffic for the services that are to be accessed by other computers. For example, Woodgrove Bank added a firewall rule to allow inbound network traffic to TCP port 1433 for SQL Server client requests.

Change the action for every inbound firewall rule from **Allow the connection** to **Allow only secure connections**, and then select **Require the connections to be encrypted**.

Make sure that the GPO that contains firewall rules for the isolated domain does not also apply to the boundary zone to prevent overlapping, and possibly conflicting rules.

**Next:**[Server Isolation GPOs](Server-Isolation-GPOs.md)


