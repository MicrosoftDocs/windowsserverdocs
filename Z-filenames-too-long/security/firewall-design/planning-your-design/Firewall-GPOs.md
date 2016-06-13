---
title: Firewall GPOs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0d9a1c6b-243a-4764-80da-2fe11730e5f4
---
# Firewall GPOs
All the computers on Woodgrove Bank's network that run Windows are part of the isolated domain, except domain controllers. To configure firewall rules, the GPO described in this section is linked to the domain container in the Active Directory OU hierarchy, and then filtered by using security group filters and WMI filters.

The GPO created for the example Woodgrove Bank scenario include the following:

-   [GPO_DOMISO_Firewall](GPO_DOMISO_Firewall.md)


