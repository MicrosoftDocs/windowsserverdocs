---
title: Verify Global Catalog DNS Registrations
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 05b0ca40-8e85-4f36-beab-c2fe266bf06b
author: Femila
---
# Verify Global Catalog DNS Registrations
  To verify that a server is advertised as a global catalog server, confirm the presence of Domain Name System \(DNS\) service \(SRV\) resource records for the server. You can use this procedure to verify global catalog DNS registrations.  
  
 Membership in **DNSAdmins** and the right to log on locally to the domain controller is the minimum required to complete this procedure. By default, members of **Account Operators**, **Administrators**, **Enterprise Admins**, **Domain Admins**, **Backup Operators**, **Print Operators**, and **Server Operators** have the right to log on locally to a domain controller. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify global catalog DNS registrations  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **DNS**.  
  
2.  Connect to a domain controller in the forest root domain: Right\-click **DNS**, click **Connect to DNS Server**, and then click **The following computer**. Type the computer name, and then click **OK**.  
  
3.  Expand **Forward Lookup Zones**, and then expand the forest root domain.  
  
4.  Click the **\_tcp** container.  
  
5.  In the details pane, look in the **Name** column for **\_gc** and in the **Data** column for the name of the server. The records that begin with **\_gc** are global catalog service \(SRV\) resource records.  
  
  