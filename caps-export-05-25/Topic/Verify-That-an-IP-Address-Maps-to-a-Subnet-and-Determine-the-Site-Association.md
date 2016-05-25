---
title: Verify That an IP Address Maps to a Subnet and Determine the Site Association
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 008c5ec3-ade9-4733-b184-a25465257e83
author: Femila
---
# Verify That an IP Address Maps to a Subnet and Determine the Site Association
  You can use this procedure to determine the site to which you want to add a server object before you install Active Directory Domain Services \(AD DS\). You can also use this procedure to verify the site after you install AD DS or before you move a server object.  
  
 To be associated with a site, the IP address of a domain controller must map to a subnet object that is defined in AD DS. The site to which the subnet is associated is the site of the domain controller.  
  
 The subnet address, which is computed from the IP network address and the subnet mask, is the name of a subnet object in AD DS. When you know the subnet address, you can locate the subnet object and determine the site to which the subnet is associated.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify that an IP address maps to a subnet and to determine the site association  
  
1.  Log on locally or open a Remote Desktop connection to the server for which you want to check the IP address.  
  
2.  In Server Manager, click **View Network Connections**.  
  
3.  Right\-click the connection that represents the connection the server or domain controller uses to attach to the network, and then click **Properties**.  
  
4.  In the **Connection Properties** dialog box, double\-click **Internet Protocol Version 4 \(TCP\/IPv4\)** or **Internet Protocol Version 6 \(TCP\/IPv6\)**.  
  
5.  Use an IP subnet calculator and the values in **IP address** and **Subnet mask** to calculate the subnet address, and then click **OK** twice.  
  
6.  Open the Active Directory Sites and Services snap\-in: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
7.  Expand the **Sites** container, and then click the **Subnets** container.  
  
8.  In the **Name** column in the details pane, find the subnet object that matches the subnet address for the server or domain controller.  
  
9. In the **Site** column, note the site to which the IP subnet address is associated.  
  
     If the site that appears in the **Site** column is not the appropriate site, contact a site administrator and find out whether the IP address is incorrect or whether you should move the server object to the site that is indicated by the subnet\-to\-site association.  
  
## See Also  
 [Move a Server Object to a New Site](../Topic/Move-a-Server-Object-to-a-New-Site.md)  
  
  