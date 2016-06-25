---
title: Fixing Replication Topology Problems (Event ID 1311)
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 9c4c29cf-8aff-4a98-af2a-88df9880f7f6
---
# Fixing Replication Topology Problems (Event ID 1311)
This problem typically occurs when the replication configuration information in Active Directory Domain Services \(AD DS\) does not accurately reflect the physical topology of the network.  
  
 The Knowledge Consistency Checker \(KCC\) constructs and maintains the Active Directory replication topology automatically. Every 15 minutes, the KCC examines the sum of all directory partition replicas that reside on domain controllers in the forest, as well as administrator\-defined settings for connections, sites, and site links.  
  
 Although generation of the replication topology occurs automatically, administrative configuration errors can result in an Active Directory replication topology that is inconsistent with the physical connections that are available. In AD DS it is possible to create objects for which there is no physical network support. For example, you can use the Active Directory Sites and Services snap\-in to create a site object and assign subnet addresses that do not exist. The KCC will attempt to use these objects to create connections between domain controllers, but replication cannot occur because the network does not exist to support the replication topology as it is configured.  
  
 Event ID 1311 is logged in the Directory Service event log when the replication configuration information in AD DS does not accurately reflect the physical topology of the network. Use the information in Event ID 1311 — KCC Replication Path Computation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124054](http://go.microsoft.com/fwlink/?LinkId=124054)\) to identify and fix topology problems.