---
title: Verify AD DS Installation on the First Forest Root Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d0336e4d-a643-40e4-84f6-c32b969d1fca
author: Femila
---
# Verify AD DS Installation on the First Forest Root Domain Controller
To verify Active Directory Domain Services \(AD DS\) installation on the first forest root domain controller, perform the following tasks:  
  
-   Review the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] event log, and then resolve any errors.  
  
-   At a command prompt, run the Domain Controller Diagnostics tool, Dcdiag.exe, and then resolve any errors that are reported.  
  
    > [!NOTE]  
    > For more information about tests that you can perform by using Dcdiag.exe, see Dcdiag Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93660](http://go.microsoft.com/fwlink/?LinkId=93660)\).  
  
-   Run Task Manager to verify that the processor and memory system resources are within acceptable limits.  
  
-   If you installed Domain Name System \(DNS\) when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), follow these steps:  
  
    -   Open DNS Manager.  
  
    -   Click **Start**, click **Server Manager**, and then navigate to the **DNS Server** page.  
  
    -   Navigate to the **Forward Lookup Zones** page to verify that the \_msdcs.forest\_root\_domain and forest\_root\_domain zones were created.  
  
    -   Expand the **forest\_root\_domain** node to verify that the DomainDnsZones and ForestDnsZones application directory partitions were created.  
  
For more information, see Verifying Active Directory Installation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68736](http://go.microsoft.com/fwlink/?LinkId=68736).  
  
