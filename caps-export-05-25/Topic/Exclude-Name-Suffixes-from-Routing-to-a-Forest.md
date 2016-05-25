---
title: Exclude Name Suffixes from Routing to a Forest
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 241a85fa-ac22-40ce-b864-0e72f78b5d05
author: Femila
---
# Exclude Name Suffixes from Routing to a Forest
  You can use the following procedure to exclude existing name suffixes from routing to a forest by using the Active Directory Domains and Trusts snap\-in. You can also use the Netdom command\-line tool. For more information about how to use the Netdom command\-line tool to modify name suffix routing settings, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
> [!NOTE]  
>  When you exclude a name suffix, the Domain Name System \(DNS\) name and all child names of that name will be excluded.  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##  
  
#### To exclude name suffixes from routing to a forest  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain that you want to administer, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the forest trust that you want to administer, and then click **Properties**.  
  
4.  On the **Name Suffix Routing** tab, under **Name suffixes in the x.x forest**, click the unique name suffix whose subordinate name suffix you want to exclude from routing, and then click **Edit**.  
  
5.  In **Name suffixes to exclude from routing to x.x**, click **Add**, type a DNS name suffix that is subordinate to the unique name suffix, and then click **OK**.  
  
  