---
title: Verify AD DS Installation on the Second Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: eb2a29dc-c2a1-4adc-be36-ab3bbd56fc30
author: Femila
---
# Verify AD DS Installation on the Second Domain Controller
To verify Active Directory Doman Services \(AD DS\) installation on the second domain controller in the forest root domain, or on any additional domain controllers in that domain, perform the following tasks:  
  
-   Review the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] event log, and then resolve any errors.  
  
-   At a command prompt, run Dcdiag.exe, and then resolve any errors that it reports.  
  
    > [!NOTE]  
    > For more information about tests that you can perform by using Dcdiag, see Dcdiag Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93660](http://go.microsoft.com/fwlink/?LinkId=93660)\).  
  
-   Run Task Manager to verify that the processor and memory system resources are within acceptable limits.  
  
-   If you installed Domain Naming System \(DNS\) when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), follow these steps:  
  
    -   Open DNS Manager.  
  
    -   Click **Start**, click **Server Manager**, and then navigate to the **DNS Server** page.  
  
    -   Navigate to the **Forward Lookup Zones** page to verify that the \_msdcs.forest\_root\_domain and forest\_root\_domain zones were created.  
  
    -   Expand the **forest\_root\_domain** node, and then use the **repadmin \/showreps** command to verify that the ForestDnsZones and DomainDnsZones application directory partitions replicated successfully.  
  
    -   Use DNS Manager to verify that you configured DNS server recursive name resolution to meet the requirements of your organization.  
  
For more information, see Verifying Active Directory Installation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68736](http://go.microsoft.com/fwlink/?LinkId=68736)\).  
  
