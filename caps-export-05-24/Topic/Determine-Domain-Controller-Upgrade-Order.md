---
title: Determine Domain Controller Upgrade Order
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b2683565-6657-4c16-acdb-94fda97cf4de
author: Femila
---
# Determine Domain Controller Upgrade Order
Determine the order in which you will upgrade your domain controllers before you begin the domain upgrade process. Record the name, IP address, the domain in which the domain controller will be located, and the operations master roles held by each domain controller before and after the upgrade. Finally, record the order in which you will upgrade the operating system on each domain controller.  
  
For more information about the process for upgrading domain controllers to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], including known issues and hotfixes you can install, see [Microsoft Support Quick Start for Adding Windows Server 2008 or Windows Server 2008 R2 Domain Controllers to Existing Domains](assetId:///255b83fa-5f20-455a-b6b0-bef198979268).  
  
One possible order for upgrading domain controllers is as follows:  
  
-   Install Active Directory Domain Services \(AD DS\) on a member server that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in the forest root domain by using the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\).  
  
-   In each domain, upgrade the operating system on the domain controller that holds the primary domain controller \(PDC\) emulator operations master role, or transfer the role to a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
    Some tasks, such as creation of the Enterprise Read\-Only Domain Controllers group, are performed on the PDC emulator only if it is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. It may be preferable to upgrade the PDC emulator for that reason, but it is not a requirement. If the PDC emulator is not upgraded, the Enterprise Read\-Only Domain Controllers group is created when the first read\-only domain controller \(RODC\) is added to the domain.  
  
-   Continue upgrading domain controllers or retiring domain controllers that you no longer want to keep in your infrastructure, until the domain upgrade is complete.  
  
> [!NOTE]  
> This order for upgrading or adding new domain controllers is a recommendation only. It is safe to upgrade the domain controllers holding any operations master role at any time in the upgrade process.  
>   
> Similarly, you can independently upgrade each domain within a forest that has multiple domains. For example, you can begin upgrading domain controllers in a child domain before you upgrade domain controllers in the root domain of the same forest.  
  
Use a domain controller documentation table to document information about each domain controller in the forest. For a worksheet to assist in documenting your domain controller information, see Job Aids for Windows Server 2003 Deployment Kit \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=102558](http://go.microsoft.com/fwlink/?LinkID=102558)\). Download Job\_Aids\_Designing\_and\_Deploying\_Directory\_and\_Security\_Services.zip, and then open DSSUPWN\_2.doc.  
  
