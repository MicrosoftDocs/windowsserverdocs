---
title: Delegate AD DS Site Topology Administration
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 847cc3c8-d4c5-4cbb-96f6-ab31f0b7305f
author: Femila
---
# Delegate AD DS Site Topology Administration
Configuring the site topology for the forest begins when the forest owner delegates administration of the Active Directory Domain Services \(AD DS\) sites and site topology to the site topology owner.  
  
### To delegate AD DS site topology administration in your environment  
  
1.  Create a global group named SiteAdmins in the forest root domain.  
  
    For more information about creating a group, see Create a new group \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=98721](http://go.microsoft.com/fwlink/?LinkId=98721)\).  
  
2.  Add administrative users to the SiteAdmins global group.  
  
    For more information about adding members to a group, see Add a member to a group \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88434](http://go.microsoft.com/fwlink/?LinkId=88434)\).  
  
    > [!NOTE]  
    > The user accounts that you add must reside in the forest root domain. If you want to add users from regional domains to this group, the group must be a universal group and the forest root domain and the regional domain must operate at the Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] functional level. For more information about group scope in Active Directory Domain Services, see Group scope \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93663](http://go.microsoft.com/fwlink/?LinkId=93663)\).  
  
3.  Open the Active Directory Sites and Services snap\-in, click **Start**, click **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
4.  Right\-click the **Sites** node, and then click **Delegate Control**.  
  
5.  Complete the Delegation of Control Wizard to delegate full control of the **Sites** node to the SiteAdmins group.  
  
