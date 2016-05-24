---
title: Modify Routing for a Forest Name Suffix
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 67d6de73-05dd-4838-9960-86cbae77a38a
author: Femila
---
# Modify Routing for a Forest Name Suffix
  If you want to prevent or allow authentication requests for all name suffixes that are identified by a forest trust \(\*.*forestname*.com\) from being routed to a forest, you can use this procedure to enable or disable routing for the forest name. You can enable or disable routing for a name suffix by using the Active Directory Domains and Trusts snap\-in. You can also use the Netdom command\-line tool. For more information about using the Netdom command\-line tool to modify name suffix routing settings, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
> [!NOTE]  
>  When you disable a name suffix, the Domain Name System \(DNS\) name and all child names of that name will be disabled.  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##  
  
#### To modify routing for a forest name suffix  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the forest root domain for the forest trust that you want to administer, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the forest trust that you want to administer, and then click **Properties**.  
  
4.  Click the **Name Suffix Routing** tab, and then, under **Name suffixes in the x.x forest,** do one of the following:  
  
    -   To enable routing for a name suffix, click the suffix that you want to enable, and then click **Enable**. If the **Enable** button is unavailable, the name suffix is already enabled.  
  
    -   To disable routing for a name suffix, click the suffix that you want to disable, and then click **Disable**. If the **Disable** button is unavailable, the name suffix is already disabled.  
  
  