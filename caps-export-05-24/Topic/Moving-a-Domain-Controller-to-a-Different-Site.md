---
title: Moving a Domain Controller to a Different Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6bab0db3-87a7-461e-b6d0-c9b3aa1b75db
author: Femila
---
# Moving a Domain Controller to a Different Site
  When you install Active Directory Domain Services \(AD DS\) on a server running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can select the site for the domain controller. If you do not make this selection, the domain controller is placed into the site that its IP address maps to. If you change the IP address or the subnet\-to\-site association of a domain controller after AD DS is installed on the server, the server object does not change sites automatically. You must move it to the new site manually. When you move the server object, the Netlogon service on the domain controller registers Domain Name System \(DNS\) service \(SRV\) resource records for the appropriate site.  
  
## TCP\/IP settings  
 When you move a domain controller to a different site, if an IP address of the domain controller is configured statically, you must change the TCP\/IP settings accordingly. The IP address of the domain controller must map to a subnet object that is associated with the site to which you are moving the domain controller. If the IP address of a domain controller does not match the site in which the server object appears, the domain controller might be forced to communicate over a potentially slow wide area network \(WAN\) link to locate resources, rather than locating resources in its own site.  
  
 Before you move the domain controller, ensure that the following TCP\/IP client values are appropriate for the new location:  
  
-   IP address, including the subnet mask and default gateway  
  
-   DNS server addresses  
  
-   Windows Internet Name Service \(WINS\) server addresses \(if appropriate\)  
  
 If the domain controller that you are moving is a DNS server, you must also change the TCP\/IP settings on any clients that have static references to the domain controller as the preferred or alternate DNS server.  
  
## DNS settings  
 If the domain controller is a DNS server, you must update the IP address in any DNS delegations or forwarders that reference the IP address. With dynamic update enabled, DNS updates host \(A\), host \(AAAA\), and name server \(NS\) resource records automatically. However, you must update delegations and forwarders as follows:  
  
-   Delegations: Determine whether the parent DNS zone of any zone that is hosted by this DNS server contains a delegation to this DNS server. If the parent DNS zone does contain a delegation to this DNS server, update the IP address in the name server \(NS\) resource record in the parent domain DNS zone that points to this DNS server.  
  
-   Forwarders: Determine whether the server acts as a forwarder for any DNS servers. If a DNS server uses this server as a forwarder, change the name server \(NS\) resource record for the forwarder on that DNS server.  
  
## Preferred bridgehead server status  
 Before you move any server object, check the server object to see whether it is acting as a preferred bridgehead server for the site. This condition has implications for the Intersite Topology Generator \(ISTG\) in both sites, as follows:  
  
-   In the site to which you are moving the server: If you move a preferred bridgehead server to a different site, it becomes a preferred bridgehead server in the new site. If preferred bridgehead servers are not currently in use in this site, the ISTG behavior in this site changes to support preferred bridgehead servers. For this reason, you must either configure the server to not be a preferred bridgehead server \(recommended\), or select additional preferred bridgehead servers in the site \(not recommended\).  
  
-   In the site from which you are moving the server: If the server is the last preferred bridgehead server in the original site for its domain, and if other domain controllers for the domain are in the site, the ISTG selects a bridgehead server for the domain. If you use preferred bridgehead servers, always select more than one server as the preferred bridgehead server for the domain. If, after the removal of this domain controller from the site, multiple domain controllers remain that are hosting the same domain and only one of them is configured as a preferred bridgehead server, either configure the server to not be a preferred bridgehead server \(recommended\), or select additional preferred bridgehead servers that host the same domain in the site \(not recommended\).  
  
> [!NOTE]  
>  If you select preferred bridgehead servers and all selected preferred bridgehead servers for a domain are unavailable in the site, the ISTG does not select a new bridgehead server. In this case, replication of this domain to and from other sites does not occur. However, if no preferred bridgehead server is selected for a domain or transport \(through administrator error or as the result of moving the only preferred bridgehead server to a different site\), the ISTG automatically selects a preferred bridgehead server for the domain and replication proceeds as scheduled.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Network Connections  
  
-   DNS snap\-in  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures in order:  
  
1.  [Change the Static IP Address of a Domain Controller](../Topic/Change-the-Static-IP-Address-of-a-Domain-Controller.md)  
  
2.  [Update the IP Address for a DNS Delegation](../Topic/Update-the-IP-Address-for-a-DNS-Delegation.md)  
  
     If the parent DNS zone of any zone that is hosted by this DNS server contains a delegation to this DNS server, use this procedure to update the IP address in all such delegations.  
  
     If your forest root domain has a parent DNS domain, perform this procedure on a DNS server in the parent domain. If you just added a new domain controller to a child domain, perform this procedure on a DNS server in the DNS parent domain. If you are following recommended practices, the parent domain is the forest root domain.  
  
3.  [Update the IP Address for a DNS Forwarder](../Topic/Update-the-IP-Address-for-a-DNS-Forwarder.md)  
  
     If the DNS server is configured as a forwarder for any other DNS server, use this procedure to update the IP address in all forwarders.  
  
4.  [Verify That an IP Address Maps to a Subnet and Determine the Site Association](../Topic/Verify-That-an-IP-Address-Maps-to-a-Subnet-and-Determine-the-Site-Association.md)  
  
5.  To determine whether the server is a preferred bridgehead server, you can check a single server or you can view the entire preferred bridgehead server list:  
  
    -   [Determine Whether a Server is a Preferred Bridgehead Server](../Topic/Determine-Whether-a-Server-is-a-Preferred-Bridgehead-Server.md)  
  
    -   [View the List of All Preferred Bridgehead Servers](../Topic/View-the-List-of-All-Preferred-Bridgehead-Servers.md)  
  
6.  [Configure a Server to Not Be a Preferred Bridgehead Server](../Topic/Configure-a-Server-to-Not-Be-a-Preferred-Bridgehead-Server.md)  
  
7.  [Move a Server Object to a New Site](../Topic/Move-a-Server-Object-to-a-New-Site.md)  
  
  