---
title: Enable Domain-Wide Authentication over an External Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2c90d176-81ed-43af-b5f2-bd0066f75590
author: Femila
---
# Enable Domain-Wide Authentication over an External Trust
  The domain\-wide authentication setting permits unrestricted access by any users in the trusted domain to all available shared resources in the trusting domain. This is the default authentication setting for external trusts, and it is representative of the way authentications were routed—without restriction—over Windows 2000 Server trusts. For more information about the domain\-wide authentication setting, see Security Considerations for Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846](http://go.microsoft.com/fwlink/?LinkID=111846)\).  
  
 You can use this procedure to enable domain\-wide authentication over an external trust.  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable domain\-wide authentication over an external trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain that you want to administer, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the external trust that you want to administer, and then click **Properties**.  
  
4.  On the **Authentication** tab, click **Domain\-wide authentication**, and then click **OK**.  
  
> [!NOTE]  
>  Only the authentication settings for the outgoing trust appear when you click **Properties** and then click the **Authentication** tab in Active Directory Domains and Trusts. To view the correct authentication settings for the incoming side of a two\-way, external trust, connect to a domain controller in the trusted domain and then use Active Directory Domains and Trusts to view the authentication settings for the outgoing side of the same trust.  
  
  