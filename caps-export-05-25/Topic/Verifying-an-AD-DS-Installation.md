---
title: Verifying an AD DS Installation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fd18ee00-df21-49fa-9340-09b9f442e69a
author: Femila
---
# Verifying an AD DS Installation
  After you install Active Directory Domain Services \(AD DS\), verify functionality such as Domain Name System \(DNS\) resource record registrations and SYSVOL replication, and make a system state backup. For verification steps to perform after you install AD DS, see Verifying Active Directory Installation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68736](http://go.microsoft.com/fwlink/?LinkId=68736)\). Those verification steps are part of the AD DS Operations Guide, which also covers many other procedures for operating AD DS.  
  
 If the domain controller is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can run the AD DS Best Practice Analyzer after you install AD DS to determine how it complies with best practices for domain controller configuration. To start the AD DS Best Practice Analyzer, click **Start**, click **Administrative Tools**, and then **Server Manager**. Double\-click **Roles**, and click **Active Directory Domain Services**. In the **Best Practices Analyzer** section, click **Scan this role**.  
  
 If the domain controller is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can run the [Microsoft IT Environment Health Scanner](http://go.microsoft.com/fwlink/?LinkID=155170) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=155170\) to perform diagnostic tests of the entire directory. The Microsoft IT Environment Health Scanner does not complete tests on AD DS is the domain functional level is [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
  