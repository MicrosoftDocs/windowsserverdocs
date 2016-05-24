---
title: AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 17d5b1f1-7662-4362-abfc-37380acd1fd0
author: Femila
---
# AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet
    
## Using the verification worksheet  
 You can use this worksheet to verify successful migration of Active Directory Domain Services \(AD DS\) Server and Domain Name System \(DNS\) Server from a source server to a destination server. Perform the following verification steps on the destination server unless otherwise noted.  
  
### Verification worksheet  
  
|\#|Verification step|Verification process|  
|------|---------------------|------------------------|  
|01|Verify that AD DS is installed. Verify that the destination server is now a domain controller and that it is configured in the same way as the source server.|Attempt to log on and use some of the administrative tools:<br /><br />1.  Open the Active Directory Users and Computers snap\-in. In the console tree, expand the domain.<br />2.  Find the destination domain controller in the appropriate organizational unit \(OU\). \(The destination domain controller should be in the OU that the source server was in—typically, **Domain Controller**.\)<br />3.  Open the Active Directory Sites and Services snap\-in. In the console tree, locate the destination server in the site’s container and verify that the destination server is in the correct site. If the source server was a global catalog server, verify that the destination server is also a global catalog server.|  
|02|Verify that TCP\/IP is configured properly. At a command prompt, type the following command, and then press ENTER: ipconfig \/all<br /><br />Make sure that the information that is returned is correct and that the domain controller has the correct IP addresses:<br /><br />IPv4: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_<br /><br />IPv6: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|Record the IP address of each network adapter \(excluding tunnel adapters\), and compare them to the IP addresses of the source domain controller. The addresses should be the same. The IPv6 Global IPs must be the same. At the command prompt, type the following command, and then press ENTER: ping loopback|  
|03|Verify the health of the destination domain controller. At a command prompt, type the following command, and then press ENTER: dcdiag.exe<br /><br />Dcdiag analyzes the state of domain controllers in a forest or enterprise and reports any problems to help in troubleshooting. For more information, see [Dcdiag](http://go.microsoft.com/fwlink/?LinkID=133110) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133110\).|At a command prompt, type the following command, and then press ENTER:  dcdiag \/s:\<destination domain controller name\><br /><br />Verify that no errors are listed in the command output, and confirm that the domain controller passed the connectivity test.|  
|04|Verify that the operations master \(also known as flexible single master operations or FSMO\) roles are properly assigned. For more information, see [article 324790](http://go.microsoft.com/fwlink/?LinkID=93375) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93375\).|At a command prompt, type the following command, and then press ENTER:  netdom query \/domain:\<domain name\> fsmo|  
|05|Verify that replication is occurring.|At a command prompt, type the following command, and then press ENTER:  repadmin \/showreps<br /><br />Ensure that no errors are returned in the command output. At the command prompt, type the following command, and then press ENTER:  repadmin \/replsum localhost \/bysrc \/bydest<br /><br />Confirm that replication is occurring by using the Convergence Verification Script.|  
|06|Verify that Group Policy is being applied on the destination server as it was on the source server. If you are running the command on Windows Server 2003, at a command prompt, type the following command, and then press ENTER:  gpresult \/scope computer \>GPO.txt<br /><br />If you are running the command on Windows Server 2008 or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], at the command prompt, type the following command, and then press ENTER:  gpresult \/scope computer \/r \>GPO.txt<br /><br />Either command prints a text document that contains the Group Policy objects \(GPOs\) that are applied on the source server.|Confirm that the command results match the text file of GPOs that was created during the premigration step.|  
|07|Verify that DNS Server and DNS name resolution are functioning properly on the destination server.|At a command prompt, type the following command, and then press ENTER:  dcdiag \/test:dns|  
|08|Verify that the Lightweight Directory Access Protocol \(LDAP\) is functioning properly on the destination server. In addition, if the source domain controller had custom LDAP policy settings, ensure that these settings were migrated successfully. For information about viewing the LDAP policy, see [article 315071](http://go.microsoft.com/fwlink/?LinkId=135481) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135481\).|Using Dsquery.exe, run a simple LDAP query to ensure that LDAP is functioning. At a command prompt, type the following command, and then press ENTER:  dsquery \* domainroot \-filter "objectcategory\=container" \-scope onelevel \-s \<destination server\><br /><br />where `<destination server>` is the IP address or name of the destination server. A list of containers should be returned.|  
|09|Verify that no errors are logged in the destination domain controller’s log files.|Look at logs in Event Viewer—specifically, the System, DNS, Security, and Directory Services logs—to make certain that no errors occurred during migration.|  
  
## See Also  
 [Active Directory Domain Services and DNS Server Migration Guide](../Topic/Active-Directory-Domain-Services-and-DNS-Server-Migration-Guide.md)   
 [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md)   
 [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](../Topic/AD-DS-and-DNS-Server-Migration--Migrating-the-AD-DS-and-DNS-Server-Roles.md)   
 [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md)   
 [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md)   
 [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md)  
  
  