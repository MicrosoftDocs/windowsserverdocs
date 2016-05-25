---
title: Configuring DNS for the Forest Root Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8bfcfe47-7568-4088-9a5f-96d0746ef675
author: Femila
---
# Configuring DNS for the Forest Root Domain
Active Directory Domain Services \(AD DS\) uses Domain Name System \(DNS\) name resolution services to enable clients to locate domain controllers and to enable the domain controllers that host the directory service to communicate with each other.  
  
When you deploy AD DS in your environment, you must have a DNS infrastructure available to support the directory service. If you do not have a DNS infrastructure in place, you must design and deploy a new DNS infrastructure to support AD DS. If you have an existing DNS infrastructure, you must integrate the AD DS namespace into that environment, which involves creating a DNS server and DNS client configuration. To create a DNS server configuration, you set the first domain controller in an AD DS forest root domain to host the DNS zone for the AD DS forest.  
  
We recommend that you install the DNS Server service on the first domain controller in a new forest root domain when you run the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\). If you do so, Dcpromo.exe automatically creates and delegates the forest root domain DNS zone and the DNS zone that contains the Active Directory forest\-wide locator records, which is the \_msdcs.<*forestname*> zone. Dcpromo.exe also creates the AD DS database and initializes the directory data in that database. In addition, on the first domain controller in the domain, the wizard takes the following actions:  
  
-   Prompts the administrator to verify the installation and configuration of the DNS Server service and the DNS Client service configuration.  
  
-   Configures DNS recursive name resolution by adding the IP addresses of the existing entries for the **Preferred DNS server** and the **Alternate DNS server** to the list of DNS servers on the Forwarders list for the domain controller.  
  
    > [!NOTE]  
    > If you want to set different forwarders or do not want to enable forwarding, you can use the DNS snap\-in to change this setting manually. If your domain controller is multihomed, forwarding is not configured automatically. For manual configuration instructions, see [Verify DNS Server Recursive Name Resolution on the First Forest Root Domain Controller](../Topic/Verify-DNS-Server-Recursive-Name-Resolution-on-the-First-Forest-Root-Domain-Controller.md).  
  
-   Configures DNS recursive name resolution by adding root hints that are configured on the preferred DNS server.  
  
-   Configures the preferred DNS server to point to the DNS server that is running locally on the domain controller, and configures the alternate DNS server to point to the DNS server that is connected through the minimum number of network segments.  
  
-   Creates two application directory partitions that DNS uses. The DomainDnsZones application directory partition holds domain\-wide DNS data, and the ForestDnsZones application directory partition holds forest\-wide DNS data.  
  
> [!NOTE]  
> Having set up the DNS infrastructure in your forest, it is recommended to include at least two DNS server IP addresses in the Client DNS Server List of the first domain controller in the forest root domain:  the IP address for a preferred DNS server and the IP address for an alternate DNS server.  
  
Although you can create DNS zones manually, we do not recommend that you do so. The following procedure shows how to manually create DNS forward lookup zones that are integrated with AD DS.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To add an \_msdcs forest\-wide locator zone and forest root DNS zone  
  
1.  To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
2.  In the console tree, right\-click a DNS server, and then click **New Zone** to open the **New Zone Wizard**.  
  
3.  On the **Welcome to the New Zone Wizard** page, click **Next**.  
  
4.  On the **Zone type** page, select **Primary zone**, and then click **Next**.  
  
5.  On the **Active Directory Zone Replication Scope** page, select how you want the zone data to replicate to every DNS server in the forest, and then click **Next**.  
  
    > [!NOTE]  
    > When you create the \_msdcs forest\-wide locator zone, set the zone data to replicate to every DNS server in the forest. AD DS uses forest\-wide locator records to make it possible for replication partners to find each other and for clients to find global catalog servers. AD DS stores the forest\-wide locator records in the \_msdcs.<*forest\_name*> zone. Because the information in the zone must be widely available, AD DS uses the forest\-wide DNS application directory partition to replicate this zone to all DNS servers in the forest.  
  
6.  On the **Forward or Reverse Lookup Zone** page, select **Forward lookup zone**, and then click **Next**.  
  
7.  On the **Zone Name** page, in **Zone name**, type the name of the new zone, for example, **contoso.com**.  
  
    > [!NOTE]  
    > When you create the \_msdcs forest\-wide locator zone, type the name of the new zone, starting with \_msdcs, for example, \_msdcs.contoso.com.  
  
8.  To create a new zone, follow the rest of the instructions in the **New Zone Wizard**.  
  
9. Repeat steps 2 through 8 to create an \_msdcs forest\-wide locator zone.  
  
## Delegating the DNS zone for the forest root domain  
  
> [!NOTE]  
> If no DNS infrastructure exists, skip this step in the forest root domain deployment process.  
  
To configure DNS for the forest root domain, the DNS administrator of your organization must delegate the zone that matches the name of the AD DS forest root domain to the DNS servers \(domain controllers\) that you will install in the forest root domain.  
  
The following procedure shows how to configure and delegate a zone in the existing DNS internal namespace.  
  
In preparation for the forest root domain deployment, create a delegation for the DNS servers that will run on the domain controllers in the forest root domain. You create the delegations that will point to the DNS servers \(domain controllers\) in the forest root domain by adding resource records for DNS name server \(NS\) and host \(A or AAAA\) resource records to the parent DNS zone.  
  
> [!NOTE]  
> The delegation that occurs in the following procedure references the first forest root domain controller, which does not currently exist. For information about how to install and configure the first forest root domain controller, see [Install AD DS on the First Forest Root Domain Controller](../Topic/Install-AD-DS-on-the-First-Forest-Root-Domain-Controller.md).  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To delegate the DNS zone for the forest root domain  
  
1.  Create a name server \(NS\) resource record in the parent zone.  
  
    Use the left\-most label of the fully qualified DNS name of the forest root domain and the fully qualified DNS name of the domain controller: forest\_root\_domain in NS domain\_controller\_name.  
  
2.  Create a host \(A\) resource record and a host \(AAAA\) resource record in the parent zone.  
  
    Use the fully qualified DNS name of the domain controller and the IP addresses of the domain controller: domain\_controller\_name in a domain\_controller\_ip\_address.  
  
## Related information  
  
-   For more information about installing and configuring a DNS server, see Deploying Domain Name System \(DNS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93656](http://go.microsoft.com/fwlink/?LinkId=93656)\).  
  
-   For more information about zone delegation, see Delegating a Zone \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=101692](http://go.microsoft.com/fwlink/?LinkId=101692)\).  
  
