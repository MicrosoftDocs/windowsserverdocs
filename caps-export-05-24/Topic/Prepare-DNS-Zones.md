---
title: Prepare DNS Zones
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a00ed89c-bbe4-4264-aa92-247374b48a97
author: Femila
---
# Prepare DNS Zones
  You can use this procedure to prepare Domain Name System \(DNS\) zones for Active Directory domain rename. When an application or client requests access to Active Directory Domain Services \(AD DS\), an Active Directory domain controller is located by the domain locator \(DC Locator\) mechanism. In response to client requests for AD DS services, DC Locator uses service \(SRV\) resource records in Domain Name System \(DNS\) to locate domain controllers. In the absence of these DNS service location \(SRV\) resource records, directory clients experience failures when they attempt to access AD DS. For this reason, before you rename an Active Directory domain, you have to be sure that the appropriate DNS zones exist for the forest and for each domain. If the appropriate zones do not exist in DNS, you have to create the DNS zone or zones that will contain the service \(SRV\) resource records for the renamed domains. We also strongly recommend that you configure the zone\(s\) to allow secure dynamic updates. This DNS zone requirement applies to each domain that is renamed as part of the domain rename operation.  
  
 The DNS requirements to rename an Active Directory domain are identical to the DNS requirements to support an existing Active Directory domain. Your current DNS infrastructure already provides necessary support for your Active Directory domain by using its current name. Usually, you only have to mirror the existing DNS infrastructure to add support for the planned new name of your domain.  
  
 For example, suppose that you want to rename an existing Active Directory domain sales.cohovineyard.com to marketing.cohovineyard.com. If the service \(SRV\) resource records that are registered by the domain controllers of the sales.cohovineyard.com Active Directory domain are registered in the DNS zone named sales.cohovineyard.com, you have to create a new DNS zone called marketing.cohovineyard.com which corresponds to the new name of the domain. For more information about how to configure DNS to provide support for AD DS, see Creating a DNS Infrastructure Design \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124108](http://go.microsoft.com/fwlink/?LinkId=124108)\).  
  
 Before you begin the domain rename process, verify that any new zones that are required have been created and configured to allow dynamic updates. Analyze your current DNS infrastructure in relation to the new forest structure that you want after the domain rename operation has completed and compile a list of DNS zones that have to be created. You can use "Worksheet 3: DNS Zone Information" in [Appendix D: Worksheets for the Domain Rename Operation](../Topic/Appendix-D--Worksheets-for-the-Domain-Rename-Operation.md) to document this list.  
  
 For more information about how to create DNS zones, see Add a Forward Lookup Zone \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108851](http://go.microsoft.com/fwlink/?LinkID=108851)\). For more information about how to configure dynamic updates, see Allow Dynamic Updates \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124109](http://go.microsoft.com/fwlink/?LinkId=124109)\).  
  
  