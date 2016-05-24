---
title: DNS Clients
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bd639cf2-6d2f-43e5-b9ea-b6c6644e7f9b
---
# DNS Clients
In [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and later operating systems, the Windows DNS client is security\-aware, which means it can determine whether a DNS response that it receives was validated as genuine or not. The DNS client itself is non\-validating, and it depends on a DNS server to provide DNSSEC validation. The client can require that this validation is performed if rules are configured in the Name Resolution Policy Table \(NRPT\) and applied by Group Policy. See the following figure.  
  
![](../Image/DNSSEC_clients.png)  
  
For information about configuring name resolution policy, see the [The NRPT](../Topic/The-NRPT.md).  
  
DNS clients are much less susceptible to DNS spoofing attacks when name resolution policies are applied and DNS responses are validated. For more information about DNS spoofing attacks, see [Why DNSSEC](../Topic/Why-DNSSEC.md).  
  
## In this section  
  
-   [Security\-aware client](../Topic/DNS-Clients.md#sec_aware)  
  
    -   [DNS queries and responses](../Topic/DNS-Clients.md#responses)  
  
-   [Managing validation](../Topic/DNS-Clients.md#goals)  
  
-   [DNS client resolver behavior](../Topic/DNS-Clients.md#dns_client)  
  
## <a name="sec_aware"></a>Security\-aware client  
With the implementation of DNSSEC in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], the client is security\-aware, which means that it understands DNSSEC and can require validation of DNS responses. Validation is not possible unless a zone is signed and the validating DNS server supports DNSSEC. For more information about how validation works, see [Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md).  
  
The DNS Client service in previous operating systems was not security\-aware. The following table summarizes DNS client security\-aware status.  
  
|Operating system|Security\-aware|  
|--------------------|-------------------|  
|Windows XP, Windows Server 2003, and previous operating systems|No|  
|[!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]|No|  
|[!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|Yes|  
|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and later operating systems|Yes|  
  
**Note**: A Windows DNS client is any computer that is running the Windows DNS Client service. The DNS Client service is included in every version of the Windows operating system, even if the computer is also a DNS server.  
  
Security\-aware DNS clients do not automatically require that DNS responses are validated. This requirement must be specifically enabled for a given namespace by the name resolution policy. Policies can be configured to require validation for some DNS zones \(namespaces\) and not for other zones.  
  
The following section summarizes how DNS queries and responses are affected when a zone is signed with DNSSEC.  
  
### <a name="responses"></a>DNS queries and responses  
When a zone has been signed with DNSSEC, the success or failure of a DNS query depends on the following settings:  
  
-   **Name resolution policy**: Name resolution policy can only be applied to security\-aware DNS clients. Non\-security\-aware clients will ignore policy settings. Policy can be configured to either require DNSSEC validation or not require DNSSEC validation for a given namespace. Rules for specific namespaces are created in Group Policy using a special policy table called the Name Resolution Policy Table, or NRPT. For more information, see [The NRPT](../Topic/The-NRPT.md).  
  
-   **Trust anchor status**: Trust anchors are installed on DNS servers. A trust anchor is a special resource record that holds a public cryptographic key that is used to validate DNSSEC\-signed DNS responses for a specific namespace. A trust anchor must be installed on any DNS server that will perform DNSSEC validation for DNS clients, unless the DNS server is already authoritative for the namespace \(it hosts the zone\). A trust anchor can be 1\) available and valid, 2\) available and invalid, or 3\) missing. A security\-aware DNS server automatically attempts to validate a DNS response if the server has a trust anchor installed for the specified zone. You cannot install a trust anchor on a DNS server that does not support DNSSEC. For more information about trust anchors, see [How DNSSEC works](../Topic/Overview-of-DNSSEC.md#how) and [Trust Anchors](../Topic/Trust-Anchors.md).  
  
-   **Security\-aware status**: If a DNS client is not security\-aware, it can still be protected by DNSSEC because a DNS server with an installed trust anchor for a given namespace automatically attempts to validate all responses in that namespace, and discards invalid \(spoofed\) responses. However, a non\-security\-aware client ignores name resolution policy requirements for DNSSEC validation. Therefore, if a trust anchor is not installed on a DNS server that is used by the client, and NRPT policy requires that validation be performed, only a security\-aware DNS client will fail DNS resolution. The behavior of a non\-security\-aware client is the same as a security\-aware client that does not have any NRPT rules applied.  
  
The following table summarizes how DNSSEC validation works for security\-aware and non\-security aware DNS clients under different conditions.  
  
|DNSSEC validation required|Trust anchor \(TA\) status|Non\-security\-aware client|Security\-aware client|  
|------------------------------|------------------------------|-------------------------------|--------------------------|  
|No|TA: None|Success|Success|  
|No|TA: Valid|Success|Success|  
|No|TA: Invalid|Failure|Failure|  
|Yes|TA: None|Success|Failure|  
|Yes|TA: Valid|Success|Success\+RRSIG|  
|Yes|TA: Invalid|Failure|Failure|  
  
> [!IMPORTANT]  
> If the DNS server that is used by a DNS client has a trust anchor for the zone that is queried, DNSSEC validation is attempted even if it is not required by NRPT policy. Consequently, if a zone is unsigned, it is critical that you also remove all trust anchors that were installed on DNS servers.  
>   
> The results that are displayed for **TA: Invalid** apply to all cases where validation fails, such as during a DNS spoofing attack. In a spoofing attack, the trust anchor itself is valid, but the resource records to be validated are invalid. The DNS server returns a failure in this case to both the security\-aware and non\-security\-aware client.  
>   
> If no TA is present, the DNS server does not attempt validation, and the DNS client will fail to resolve the name only if: 1\) it is security\-aware, and 2\) the NRPT policy that is applied to the client requires validation for that namespace.  
  
## <a name="goals"></a>Managing validation  
In some cases, DNSSEC validation might be broken for a specific namespace. To temporarily disable DNSSEC validation for this zone, but continue requiring DNSSEC validation for other zones, consider a forward\-around design. See the following example:  
  
![](../Image/DNSSEC_forward.gif)  
  
In this example, a conditional forwarder is added to non\-authoritative resolving DNS servers to temporarily disable DNSSEC validation for the zone *bad\-dnssec.com*. DNS queries for this zone are sent to the DNS server at *10.6.6.6* that does not have a trust anchor installed and does not perform DNSSEC validation. Other queries are sent to the DNS server at *10.1.1.1* where DNSSEC validation is performed.  
  
## <a name="dns_client"></a>DNS client resolver behavior  
It is important to remember that a DNS client can be configured to query multiple DNS servers to obtain a response. Queries will continue until a response is received, therefore it is important to enable DNSSEC validation on secondary DNS servers in case the primary DNS server fails to respond. A response of SERVFAIL from a DNS server is considered a response; therefore a Windows DNS client will not attempt to obtain additional responses after DNSSEC validation has failed. The DNS query process is summarized in the following section. The DNS query process includes queries that can be issued from a DNS client with multiple network adapters installed.  
  
**DNS query process**  
  
The Windows DNS client is a stub resolver, which means that when it needs to resolve a DNS name, it issues a single recursive query to the primary DNS server that is configured on its network interface.  
  
As long as that DNS server responds, no other DNS queries are issued. The DNS server is responsible for handling all additional tasks that are necessary to resolve the DNS query, and the final result is returned to the DNS client.  
  
If a DNS client does not receive a response to a DNS query and additional DNS servers are configured on one or more network interfaces, it can send additional queries to these DNS servers until it receives a response. A negative response, such as "name not found" is also considered a valid response.  
  
In [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and later operating systems, the DNS client will query DNS servers that are configured on its network interfaces using the following process:  
  
-   **Query 1**: The DNS Client service sends the query to the first DNS server on the preferred network adapter’s list of DNS servers and waits one \(1\) second for a response. The preferred network adapter on a computer with multiple network interfaces is the one that is first in the binding order.  
  
-   **Query 2**: If the DNS Client service does not receive a response from the first DNS server on the preferred network adapter within one second, it sends the query to the next DNS server on the preferred interface and first DNS servers on all other network adapters and waits one \(1\) second for a response.  
  
-   **Query 3**: If the DNS Client service does not receive a response from any of the DNS servers, it sends the query to the next DNS servers on each of the network adapters that are still under consideration and waits two \(2\) seconds for a response. A network interface is considered "under consideration" if no response has been received from any DNS server that is configured on that interface, and the list of DNS servers has not been exhausted.  
  
-   **Query 4**: If the DNS Client service still does not receive a response from any DNS server, it sends the name query to all DNS servers on all network adapters that are still under consideration and waits four \(4\) seconds for a response.  
  
-   **Query 5**: If the DNS Client service still does not receive a response from any DNS server, it repeats the previous query, sending the name query to all DNS servers on all adapters that are still under consideration and waiting four \(4\) seconds for a response.  
  
The total wait time is 12 seconds \(1, 1, 2, 4, 4\) if there is no response. If a query is sent to multiple DNS servers and more than one DNS server responds, the first response that is received is used.  
  
If it is necessary for a DNS client to use another DNS server to resolve a query, this server is temporarily set to be first on the priority list of DNS servers used. After 15 minutes, the DNS client resets the DNS server priority list back to default settings.  
  
## <a name="also"></a>See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNS Servers](../Topic/DNS-Servers.md)  
  
[DNS Zones](../Topic/DNS-Zones.md)  
  
[The NRPT](../Topic/The-NRPT.md)  
  
