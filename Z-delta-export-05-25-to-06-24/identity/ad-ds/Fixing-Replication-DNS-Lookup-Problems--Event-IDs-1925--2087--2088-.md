---
title: Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: b506eb78-51ad-4be2-b205-85756cabe766
---
# Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)
This section provides a description of Domain Name System \(DNS\) lookup problems that you might experience when Active Directory replication is enabled.  
  
 Domain controllers running Windows 2000 Server, Windows Server 2003, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] cannot replicate Active Directory updates if DNS lookup failures prevent a destination domain controller from contacting its source replication partner to request changes. Lookup failures occur when a destination domain controller cannot resolve its source replication partner's globally unique identifier \(GUID\)–based alias \(CNAME\) resource record to an IP address by using DNS. GUID\-based alias \(CNAME\) resource records are always registered in the DNS zone \_msdcs.*ForestRootDomain*.  
  
 The most common DNS failures occur when DNS client settings are misconfigured on the destination or source domain controller, or the direct and intermediate DNS servers that are used to resolve the query are misconfigured. Network problems or domain controller disconnection problems might also be present. If the problem is due to DNS configuration errors or replication latency, the effect on Active Directory replication is minimized by improvements to domain controller name resolution that were introduced in Windows Server 2003 Service Pack 1 \(SP1\).  
  
 **In this topic**  
  
-   [Improvements to domain controller name resolution](#BKMK_Improvements)  
  
    -   [DNS failure scenarios](#BKMK_DNS_Failure)  
  
    -   [DNS events for lookup failure](#BKMK_DNS_Events)  
  
-   [DNS requirements for CNAME lookup success](#BKMK_DNS_Requirements)  
  
    -   [Potential preliminary failures due to replication latency](#BKMK_Potential_Failures)  
  
##  <a name="BKMK_Improvements"></a> Improvements to domain controller name resolution  
 Domain controllers running Windows Server 2003 with SP1, Windows Server 2003 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] have a more robust response to DNS name resolution failures than earlier versions of Windows Server. Rather than failing on the first attempt to resolve the IP address of a source domain controller by using its alias \(CNAME\) resource record, destination domain controllers running these operating systems use alternate names to attempt resolution. They also log events that report problems and prescribe solutions.  
  
###  <a name="BKMK_DNS_Failure"></a> DNS failure scenarios  
 All domain controllers register multiple service location \(SRV\) resource records in DNS as well as a hosting address \(A\) resource records for each IP address of the domain controller, plus an additional host \(A\) resource record for each IP address if the domain controller is a global catalog server. In addition, each domain controller registers a single alias \(CNAME\) resource record.  
  
 The following table shows the DNS resource records that are required for proper Active Directory functionality.  
  
|Mnemonic|Type|DNS resource record|  
|--------------|----------|-------------------------|  
|pdc|SRV|\_ldap.\_tcp.pdc.\_msdcs.*DnsDomainName*|  
|gc|SRV|\_ldap\_tcp.gc.\_msdcs.*DnsForestRootDomainName*|  
|GcIpAddress|A|\_gc.\_msdcs.*DnsForestRootDomainName*|  
|DsaCname|CNAME|*DsaGuid*.\_msdcs.*DnsForestRootDomainName*|  
|kdc|SRV|\_kerberos.\_tcp.dc.\_msdcs.*DnsDomainName*|  
|dc|SRV|\_ldap.\_tcp.dc.\_msdcs.*DnsDomainName*|  
|None|A|*DomainControllerFQDN*|  
  
 In the alias \(CNAME\) resource record \(*DSA\_GUID*.\_msdcs.*ForestRootDNSDomainName*\), *DSA\_GUID* is the GUID of the NTDS Settings object \(also called the Directory System Agent \(DSA\) object\) for the domain controller. *ForestRootDNSDomainName* is the DNS name of the forest where the domain controller is located. Destination domain controllers use the alias \(CNAME\) resource record to identify and locate their replication partners.  
  
 The Netlogon service on the domain controller registers all service \(SRV\) resource records when the operating system starts up and at regular intervals thereafter. The DNS client service on the domain controller registers the DNS host \(A\) resource record.  
  
 A domain controller uses the following steps to locate its replication partner:  
  
1.  The destination domain controller queries its DNS server to look for the alias \(CNAME\) resource record of its replication partner. On domain controllers running Windows 2000 Server or Windows Server 2003 with no service pack applied, if this lookup fails to resolve the alias \(CNAME\) resource record to an IP address, DNS lookup \(and replication\) fails.  
  
2.  On domain controllers running Windows Server 2003 with SP1, Windows Server 2003 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], if the CNAME lookup is unsuccessful, the domain controller looks for the DNS host \(A\) resource record of its replication partner. For example, the domain controller looks for DC03.corp.contoso.com.  
  
3.  If the DNS host \(A\) resource record lookup is unsuccessful, the domain controller performs a NetBIOS broadcast by using the host name of its replication partner. For example, the domain controller uses DC03.  
  
 When lookups fail, events that describe the condition are logged in the Directory Service event log.  
  
###  <a name="BKMK_DNS_Events"></a> DNS events for lookup failure  
 Two events, Event ID 2087 and Event ID 2088, are logged on destination domain controllers running Windows Server 2003 with SP1, Windows Server 2003 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]:  
  
-   If all lookups fail, Event ID 2087 is logged.  
  
-   If lookup succeeds but either the first or second attempt fails, Event ID 2088 is logged.  
  
 On domain controllers running all versions of Windows Server, the destination domain controller that cannot successfully locate its replication partner in DNS logs Event ID 1925.  
  
 Regardless of whether replication succeeds or fails, if you receive Event ID 1925, Event ID 2087, or Event ID 2088, you should investigate and correct the cause of the failure, because incorrect DNS configuration can affect other essential operations—including logon authentication and access to network resources—on member computers, domain controllers, and application servers. In addition, although fallback name resolution might allow replication to occur, it introduces unnecessary latency and overhead into the replication process.  
  
##  <a name="BKMK_DNS_Requirements"></a> DNS requirements for CNAME lookup success  
 Failure of CNAME lookup indicates that either the DNS clients or DNS servers are not configured properly. It is important to understand the requirements for successful CNAME lookup and to ensure that DNS is functioning accordingly.  
  
 Resolving the fully qualified, GUID\-based, alias \(CNAME\) resource record of the source domain controller to the current IP address of the source domain controller requires the following DNS configurations:  
  
1.  In their respective TCP\/IP client settings, the source domain controller and destination domain controller must be configured to resolve DNS names by using only valid DNS servers that directly host, forward, or delegate to the following DNS zones:  
  
    1.  \_msdcs.*ForestRootDNSDomainName*, to resolve queries for computers in the forest.  
  
    2.  The DNS zone that corresponds to the primary DNS suffix of the respective target domain controller, to resolve queries for computers in the domain. \(The source domain controller can resolve the domain name of the target domain controller, and the reverse is also true.\) The primary DNS suffix is usually the same as the DNS name of the domain to which a computer is joined. You can view the primary DNS suffix in the properties of My Computer.  
  
     If the DNS servers that the source domain controller is configured to use for name resolution do not host these zones directly, the DNS servers that are used must forward or delegate to DNS servers that do host these zones.  
  
2.  The source domain controller must have successfully registered the following resource records:  
  
    -   GUID\-based alias \(CNAME\) resource record in the DNS zone \_msdcs.*ForestRootDNSDomainName*  
  
    -   Host \(A\) resource record in the DNS zone that corresponds to its primary DNS suffix  
  
###  <a name="BKMK_Potential_Failures"></a> Potential preliminary failures due to replication latency  
 At the time that the destination domain controller queries its DNS servers for the location of its source replication partner, DNS configurations might be correct on both the source and destination domain controllers, but DNS resource record registrations might be in flux as a result of configuration changes on the source domain controller. In this case, DNS lookup can fail as a result of replication latency, as follows:  
  
-   If the source domain controller changes the DNS server on which it registers its alias \(CNAME\) and host \(A\) resource records, it is possible that the initial DNS server that the destination domain controller queries to resolve the name of the source domain controller is different than any of the DNS servers on which the alias \(CNAME\) and host \(A\) resource records for the source domain controller are currently registered. In this case, DNS replication latency or failures might prevent DNS records that are successfully registered on the DNS servers that the source controller uses from being located by the DNS server that the destination domain controller queries.  
  
-   If the Active Directory domain of the DNS server that the destination domain controller uses initially has a parent\-child relationship with the Active Directory domain of the servers on which the source domain controller registers its resource records, the forwarder and delegation configuration on both the DNS servers that the source domain controller uses and the DNS servers that the destination domain controller uses—as well as any intermediate DNS servers that are used to resolve the DNS query—must be valid. Any required records on those DNS servers might be subject to replication latency and failure.  
  
 Understanding these basic requirements for name resolution that locates the source replication partner provides a more meaningful context for working through solutions when you have replication DNS lookup problems.  
  
 From the following list, choose a problem that best describes your situation, and then complete the procedures for the suggested fix:  
  
 [Event ID 1925: Attempt to establish a replication link failed due to DNS lookup problem](../Topic/Event%20ID%201925:%20Attempt%20to%20establish%20a%20replication%20link%20failed%20due%20to%20DNS%20lookup%20problem.md)  
  
 [Event ID 2087: DNS lookup failure caused replication to fail](../Topic/Event%20ID%202087:%20DNS%20lookup%20failure%20caused%20replication%20to%20fail.md)  
  
 [Event ID 2088: DNS lookup failure occurred with replication success](../Topic/Event%20ID%202088:%20DNS%20lookup%20failure%20occurred%20with%20replication%20success.md)