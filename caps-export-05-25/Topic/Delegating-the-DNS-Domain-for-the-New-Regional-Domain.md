---
title: Delegating the DNS Domain for the New Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 18b2c452-bfa1-45bd-95ad-3438f833d5c9
author: Femila
---
# Delegating the DNS Domain for the New Regional Domain
The Domain Name System \(DNS\) owner for Active Directory Domain Services \(AD DS\) is responsible for delegating the zone that matches the name of the regional domain to the DNS servers \(domain controllers\) that you want to install in the regional domain.  
  
Before you create the new regional domain, you delegate the DNS domain for the new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] regional domain at the following locations:  
  
-   In the DNS zone for the forest root domain  
  
-   On any forest root domain controller  
  
> [!NOTE]  
> We recommend that you install the DNS Server service on the domain controllers in AD DS regional domains when you run the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\). If you do so, DNS zone delegation occurs automatically.  
  
The following procedure shows how to manually delegate the DNS domain for the new regional domain.  
  
### To delegate the DNS domain for the new regional domain  
  
1.  To open DNS Manager, click **Start**, then click **Administrative Tools**, and then click **DNS** on any domain controller in the forest root domain.  
  
2.  In the console tree, expand the forest root domain zone, expand **Forward Lookup Zones** node, right\-click the forest root domain zone, and then click **New Delegation**.  
  
3.  On the **Welcome to the New Delegation Wizard** page, click **Next**.  
  
4.  On the **Delegated Domain Name** page, in **Delegated Domain**, type the name of the new regional domain.  
  
5.  On the **Name Servers** page, click **Add**.  
  
6.  In the **New Resource Record** dialog box, in **Server fully qualified domain name \(FQDN\)**, type the name of the first domain controller that you want to deploy.  
  
7.  In the **New Resource Record** dialog box, in **IP address**, type the corresponding IP address of the domain controller, and then click **OK**.  
  
    If you want to deploy additional domain controllers in this regional domain, repeat steps 5 and 6, and enter the FQDNs and the IP addresses of these additional domain controllers.  
  
