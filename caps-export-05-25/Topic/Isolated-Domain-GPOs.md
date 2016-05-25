---
title: Isolated Domain GPOs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e1741894-fc4d-432b-91aa-6c0941fcee6d
author: vhorne
---
# Isolated Domain GPOs
All of the computers in the isolated domain are added to the group CG\_DOMISO\_IsolatedDomain. You must create multiple GPOs to align with this group, one for each Windows operating system that must have different rules or settings to implement the basic isolated domain functionality that you have in your isolated domain. This group is granted Read and Apply Group Policy permissions on all the GPOs described in this section.  
  
Each GPO has a security group filter that prevents the GPO from applying to members of the group GP\_DOMISO\_No\_IPsec. A WMI filter is attached to each GPO to ensure that the GPO is applied to only the specified version of Windows. For more information, see the [Planning GPO Deployment](../Topic/Planning-GPO-Deployment.md) section.  
  
The GPOs created for the Woodgrove Bank isolated domain include the following:  
  
-   [GPO_DOMISO_IsolatedDomain_Clients](../Topic/GPO_DOMISO_IsolatedDomain_Clients.md)  
  
-   [GPO_DOMISO_IsolatedDomain_Servers](../Topic/GPO_DOMISO_IsolatedDomain_Servers.md)  
  
