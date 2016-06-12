---
title: DNS and AD DS
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: ffcf3650-b072-4619-98f2-c05cc5082562
author: Femila
---
# DNS and AD DS
Active Directory Domain Services \(AD DS\) uses Domain Name System \(DNS\) name resolution services to make it possible for clients to locate domain controllers and for the domain controllers that host the directory service to communicate with each other.  
  
AD DS enables easy integration of the Active Directory namespace into an existing DNS namespace. Features such as Active Directory–integrated DNS zones make it easier for you to deploy DNS by eliminating the need to set up secondary zones, and then configure zone transfers.  
  
For information about how DNS supports AD DS, see the DNS Support for Active Directory Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=48147](http://go.microsoft.com/fwlink/?LinkID=48147)\).  
  
> [!NOTE]  
> If you implement a disjoint namespace in which the AD DS domain name differs from the primary DNS suffix that clients use, AD DS integration with DNS is more complex. For more information, see [Disjoint Namespace](../../active-directory-domain-services/plan/../../active-directory-domain-services/plan/disjoint-namespace.md).  
  
## In this section  
  
-   [Domain Controller Location](../../active-directory-domain-services/plan/domain-controller-location.md)  
  
-   [Active Directory-Integrated DNS Zones](../../active-directory-domain-services/plan/active-directoryintegrated-dns-zones.md)  
  
-   [Computer Naming](../../active-directory-domain-services/plan/computer-naming.md)  
  
-   [Disjoint Namespace](../../active-directory-domain-services/plan/../../active-directory-domain-services/plan/disjoint-namespace.md)  
  

