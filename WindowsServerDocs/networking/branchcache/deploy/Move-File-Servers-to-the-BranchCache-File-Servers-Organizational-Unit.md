---
title: Move File Servers to the BranchCache File Servers Organizational Unit
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 56c915ec-edb1-43b0-8ad2-c93841bb566f
ms.author: lizross
author: eross-msft
---
# Move File Servers to the BranchCache File Servers Organizational Unit

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to add BranchCache file servers to an organizational unit (OU) in Active Directory Domain Services (AD DS).  
  
Membership in **Domain Admins**, or equivalent is the minimum required to perform this procedure.  
  
> [!NOTE]  
> You must create a BranchCache file servers OU in the Active Directory Users and Computers console before you add computer accounts to the OU with this procedure. For more information, see [Create the BranchCache File Servers Organizational Unit](../../branchcache/deploy/Create-the-BranchCache-File-Servers-Organizational-Unit.md).  
  
### To move file servers to the BranchCache file servers organizational unit  
  
1.  On a computer where AD DS is installed, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers console opens.  
  
2.  In the Active Directory Users and Computers console, locate the computer account for a BranchCache file server, left-click to select the account, and then drag and drop the computer account on the BranchCache file servers OU that you previously created. For example, if you previously created an OU named **BranchCache file servers**, drag and drop the computer account on the **BranchCache file servers** OU.  
  
3.  Repeat the previous step for each BranchCache file server in the domain that you want to move to the OU.  
  


