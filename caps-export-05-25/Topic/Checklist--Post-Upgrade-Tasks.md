---
title: Checklist: Post-Upgrade Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f30e0e82-d711-48f5-818d-cdb5cae708ca
author: Femila
---
# Checklist: Post-Upgrade Tasks
Complete the tasks in this checklist in the order in which they are presented.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Post\-Upgrade Tasks**  
  
||Task|Reference|  
|----|--------|-------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Raise the functional levels of domains and forests to enable all advanced features of Active Directory Domain Services \(AD DS\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Raise the Functional Levels of Domains and Forests](../Topic/Raise-the-Functional-Levels-of-Domains-and-Forests.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Move Domain Name System \(DNS\) zones into DNS application directory partitions. **Note:** This step is optional. If you are upgrading Windows Server 2003 Active Directory domains, your DNS zones have already been stored in the DNS application directory partitions. However, if you are upgrading Windows 2000 Active Directory domains, you might choose to move your DNS zones into the newly created DNS application directory partitions.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Move DNS Data into DNS Application Directory Partitions](../Topic/Move-DNS-Data-into-DNS-Application-Directory-Partitions.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Redirect users and computers to organizational units \(OUs\). **Note:** The procedures described in this section are required only if you are upgrading Windows 2000 Active Directory domains. A Windows Server 2003 Active Directory domain OU structure will remain the same after the upgrade is complete.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Redirect Users and Computers](../Topic/Redirect-Users-and-Computers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Complete the upgrade.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Complete the Upgrade](../Topic/Complete-the-Upgrade.md)|  
  
