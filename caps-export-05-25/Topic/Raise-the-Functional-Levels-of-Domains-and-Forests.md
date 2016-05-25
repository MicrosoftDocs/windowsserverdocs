---
title: Raise the Functional Levels of Domains and Forests
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2d1c9ed8-93ab-4d12-8f55-39643627f6d9
author: Femila
---
# Raise the Functional Levels of Domains and Forests
To enable all [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] advanced features in Active Directory Domain Services \(AD DS\), raise the functional level of your forest to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. This will automatically raise the functional level of all domains to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. To enable all [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] advanced AD DS features, raise the functional level of your forest to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. This will automatically raise the functional level of all domains to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
> [!CAUTION]  
> Do not raise the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] if you have or will have any domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or earlier.  
  
> [!IMPORTANT]  
> After you set the forest functional level to a certain value, you cannot roll back or lower the forest functional level, with one exception: when you raise the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and if Active Directory Recycle Bin is not enabled, you have the option of rolling the forest functional level back to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can lower the forest functional level only from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. If the forest functional level is set to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], it cannot be rolled back, for example, to Windows Server 2003.  
>   
> For more information about the Active Directory Recycle Bin, see Active Directory Recycle Bin Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133971](http://go.microsoft.com/fwlink/?LinkId=133971)\).  
  
Use the following procedure to raise the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To raise the forest functional level  
  
1.  Open the Active Directory Domains and Trusts snap\-in. Click **Start**, click **Administrative Tools**, and then click **Active Directory Domains and Trusts**.  
  
2.  In the console tree, right\-click **Active Directory Domains and Trusts**, and then click **Raise Forest Functional Level**.  
  
3.  In **Select an available forest functional level**, do one of the following:  
  
    -   To raise the forest functional level to Windows Server 2003, click **Windows Server 2003**, and then click **Raise**.  
  
    -   To raise the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], click [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and then click **Raise**.  
  
    -   To raise the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], click [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and then click **Raise**.  
  
For more information about [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] advanced AD DS features, see [Enabling Advanced Features for AD DS](../Topic/Enabling-Advanced-Features-for-AD-DS.md).  
  
