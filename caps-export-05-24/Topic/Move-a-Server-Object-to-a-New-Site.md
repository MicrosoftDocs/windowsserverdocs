---
title: Move a Server Object to a New Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 282cde8d-12c4-49d0-b487-d6827d72009e
author: Femila
---
# Move a Server Object to a New Site
  When you move a server object in Active Directory Domain Services \(AD DS\), the Active Directory Sites and Services snap\-in does not require that the IP address of the server maps to the site to which you are moving the server object. If the IP address does not map to a subnet that is associated with the site to which you move it, the server might be forced to communicate over a potentially slow wide area network \(WAN\) link to locate resources rather than locating resources in its own site. Before you move the server object, verify that the IP address maps to the target site.  
  
 You can use this procedure to move a server object to a new site.  
  
 Membership in **Enterprise Admins**, or equivalent, is required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To move a server object to a new site  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites** and the site in which the server object resides.  
  
3.  Expand **Servers** to display the domain controllers that are currently configured for that site.  
  
4.  Right\-click the server object that you want to move, and then click **Move**.  
  
5.  In **Site Name**, click the destination site, and then click **OK**.  
  
6.  Expand the site object to which you moved the server, and then expand the **Servers** container.  
  
7.  Verify that an object for the server that you moved exists.  
  
8.  Expand the server object, and verify that an NTDS Settings object exists.  
  
 Within an hour, the Net Logon service on the domain controller registers the new site information in Domain Name System \(DNS\). Wait an hour, and then open Event Viewer and connect to the domain controller whose server object you moved. Review the System log for NETLOGON errors regarding registration of service \(SRV\) resource records in DNS that have occurred within the last hour. The absence of errors indicates that the Net Logon service has updated DNS with site\-specific service \(SRV\) resource records. NETLOGON Event ID 5774 indicates that the dynamic registration of DNS resource records has failed. If this error occurs, contact a supervisor and pursue DNS troubleshooting.  
  
## See Also  
 [Verify That an IP Address Maps to a Subnet and Determine the Site Association](../Topic/Verify-That-an-IP-Address-Maps-to-a-Subnet-and-Determine-the-Site-Association.md)  
  
  