---
title: Appendix A: Transition Namespaces
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c56b3a90-139e-49e5-9251-6e786f196350
author: Femila
---
# Appendix A: Transition Namespaces
If you decide to modify your network name resolution infrastructure after you read [Disjoint Namespace \[LH\]](assetId:///9b519506-a37f-4810-b0c5-4bb151f553c0), you must perform several steps. Whether you want to create a disjoint namespace or transition from a disjoint namespace to a contiguous namespace, you must configure the following components appropriately:  
  
-   Primary Domain Name System \(DNS\) suffixes  
  
-   Service principal names \(SPNs\)  
  
-   Group Policy objects \(GPOs\)  
  
-   Permissions to objects in Active Directory Domain Services \(AD DS\)  
  
The primary differences between implementing a disjoint namespace and transitioning to a contiguous namespace are as follows:  
  
-   When you transition to a contiguous namespace from a disjoint namespace, you must ensure that the Active Directory domain name and the DNS namespace are identical.  
  
-   When you create a disjoint namespace, you must create different Active Directory and DNS namespaces.  
  
If you create a disjoint namespace accidentally, you can reverse the erroneous steps. The process for reversing the erroneous steps is similar to transitioning a namespace, but not as complex.  
  
For more information about working with disjoint namespaces, see the following topics:  
  
-   [Create a Disjoint Namespace](Create-a-Disjoint-Namespace.md)  
  
-   [Reverse an Accidentally Created Disjoint Namespace](Reverse-an-Accidentally-Created-Disjoint-Namespace.md)  
  
-   [Transition from a Disjoint Namespace to a Contiguous Namespace](Transition-from-a-Disjoint-Namespace-to-a-Contiguous-Namespace.md)  
  

