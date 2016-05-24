---
title: Move DNS Data into DNS Application Directory Partitions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8ebfc8f3-9cee-460f-badd-0a4d61e45499
author: Femila
---
# Move DNS Data into DNS Application Directory Partitions
  
> [!NOTE]  
> The procedures in this topic are optional. If you are upgrading Windows Server 2003 Active Directory domains, your Domain Name System \(DNS\) zones have already been stored in the DNS application directory partitions. However, if you are upgrading Windows 2000 Active Directory domains, you might choose to move your DNS zones into the newly created DNS application directory partitions.  
  
To reduce replication traffic and the amount of data stored in the global catalog, you can use application directory partitions for Active Directory–integrated DNS zones.  
  
After completing the upgrade of all Windows 2000–based domain controllers in the forest, move the Active Directory–integrated DNS data on all DNS servers from the domain partition into the newly created DNS application directory partitions. You can do this by changing the replication scope of the DNS zones.  
  
Move the DNS zones that you want to replicate to all DNS servers in the forest to the forest\-wide DNS application directory partition, ForestDnsZones. For each domain in the forest, move the DNS zones that you want to replicate to all DNS servers in the domain to the domain\-wide DNS application directory partition, DomainDnsZones.  
  
> [!IMPORTANT]  
> Before you attempt to move DNS data to an application directory partition, make sure that the domain naming operations master is hosted on at least a Windows Server 2003–based version domain controller.  
  
If the \_msdcs.forest\_root\_domain zone is not present as a separate zone on your DNS server, you do not need to perform this procedure because the DNS data that is stored in the \_msdcs.forest\_root\_domain is moved with the forest root domain zone to the domain\-wide application directory partition, DomainDnsZones.  
  
> [!NOTE]  
> For more information about DNS and application directory partitions, see [Appendix A: Background Information for Upgrading Active Directory Domains](../Topic/Appendix-A--Background-Information-for-Upgrading-Active-Directory-Domains.md).  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the replication scope of the domain\-wide DNS zone by using a DNS application directory partition  
  
1.  On a domain controller that hosts a DNS server in a particular domain, click **Start**, click **Administrative Tools**, and then click **DNS** to open the DNS Manager.  
  
2.  Right\-click the DNS zone that uses the fully qualified domain name \(FQDN\) of the Active Directory domain, and then click **Properties**.  
  
3.  Click the **Change** button next to **Replication: All DNS servers in this domain**.  
  
4.  Click **To all DNS servers in this domain:<domain\_name>**, and then click **OK**.  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the replication scope of the \_msdcs.forest\_root\_domain DNS zone by using a DNS application directory partition  
  
1.  On a domain controller that hosts a DNS server in the forest root domain, click **Start**, click **Administrative Tools**, and then click **DNS** to open DNS Manager.  
  
2.  Right\-click the \_msdcs.<forest\_root\_domain> DNS zone, and then click **Properties**.  
  
3.  Click the **Change** button next to **Replication: All DNS servers in this forest**.  
  
4.  Click **To all DNS servers in this forest:<forest\_name>**, and then click **OK**.  
  
For more information, see Deploying Domain Name System \(DNS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93656](http://go.microsoft.com/fwlink/?LinkId=93656)\).  
  
