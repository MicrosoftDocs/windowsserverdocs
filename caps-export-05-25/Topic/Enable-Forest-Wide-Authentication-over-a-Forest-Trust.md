---
title: Enable Forest-Wide Authentication over a Forest Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f0aac728-e75b-4a1c-8d0c-10b07747d25d
author: Femila
---
# Enable Forest-Wide Authentication over a Forest Trust
  The forest\-wide authentication setting permits unrestricted access by any users in the trusted forest to all available shared resources in any of the domains in the trusting forest. This is the default authentication setting for forest trusts, and it is representative of the way authentications were routed—without restriction—over Windows 2000 Server trusts. For more information about the forest\-wide authentication setting, see Security Considerations for Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846](http://go.microsoft.com/fwlink/?LinkID=111846)\).  
  
 You can use this procedure to enable forest\-wide authentication over a forest trust.  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable forest\-wide authentication over a forest trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the forest root domain, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the forest trust that you want to administer, and then click **Properties**.  
  
4.  On the **Authentication** tab, click **Forest\-wide authentication**, and then click **OK**.  
  
> [!NOTE]  
>  Only the authentication settings for the outgoing trust are displayed when you click **Properties** and then click the **Authentication** tab in Active Directory Domains and Trusts. To view the correct authentication settings for the incoming side of a two\-way, forest trust, connect to a domain controller in the trusted domain \(the forest root domain in the other forest\), and then use Active Directory Domains and Trusts to view the authentication settings for the outgoing side of the same trust.  
  
  