---
title: Verify AD DS Installation on the First Domain Controller in a New Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 42cd867c-0f92-441f-8bb1-8c13d8893a13
author: Femila
---
# Verify AD DS Installation on the First Domain Controller in a New Regional Domain
To verify the Active Directory Domain Services \(AD DS\) installation on the first domain controller in a new regional domain, complete the following tasks:  
  
-   Review the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] event log, and then resolve any errors.  
  
-   At a command prompt, run the Domain Controller Diagnostics tool, Dcdiag.exe, and then resolve any errors that are reported.  
  
    > [!NOTE]  
    > For more information about tests that you can perform by using Dcdiag.exe, see Dcdiag Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93660](http://go.microsoft.com/fwlink/?LinkId=93660)\).  
  
-   Run Task Manager to verify that the processor and memory system resources are within acceptable limits.  
  
-   If you installed Domain Name System \(DNS\) when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), complete the following steps:  
  
    1.  Open DNS Manager.  
  
    2.  Click **Start**, click **Server Manager**, and then navigate to the **DNS Server** page.  
  
    3.  Navigate to the **Forward Lookup Zones** page to verify that the zones \_msdcs.forest\_root\_domain\_name and regional\_domain\_name were created.  
  
For more information, see Verifying Active Directory Installation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68736](http://go.microsoft.com/fwlink/?LinkId=68736)\).  
  
