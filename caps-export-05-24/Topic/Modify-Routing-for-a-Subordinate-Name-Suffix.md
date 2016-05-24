---
title: Modify Routing for a Subordinate Name Suffix
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4a0835fa-c298-45dc-8fb0-f3d8e2f6b37a
author: Femila
---
# Modify Routing for a Subordinate Name Suffix
  You can change the routing status \(enable or disable\) of a name suffix that is subordinate to the name of a forest. For example, if the wingtiptoys.com forest trusts the fabrikam.com forest and the fabrikam.com forest includes a child domain sales.fabrikam.com, you can enable or disable routing specifically for the child domain name suffix. You can use this procedure to modify routing of an existing subordinate name suffix by using Active Directory Domains and Trusts. You can also use the Netdom command\-line tool. For more information about how to use the Netdom command\-line tool to modify name suffix routing settings, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##  
  
#### To modify routing for an existing subordinate name suffix  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the forest root domain node for the forest trust that you want to administer, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)**or **Domains that trust this domain \(incoming trusts\)**, click the forest trust that you want to administer, and then click **Properties**.  
  
4.  On the **Name Suffix Routing** tab, under **Name suffixes in the x.x forest**, click the forest suffix whose subordinate name suffix you want to modify for routing, and then click **Edit**.  
  
5.  In **Existing name suffixes in x.x**, click the suffix that you want to modify, and then click **Enable** or **Disable**.  
  
  