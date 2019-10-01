---
ms.assetid: 133474ee-316d-4b1c-acc6-ad5434a064d5
title: Reviewing DNS Concepts
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Reviewing DNS Concepts

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Domain Name System (DNS) is a distributed database that represents a namespace. The namespace contains all of the information needed for any client to look up any name. Any DNS server can answer queries about any name within its namespace. A DNS server answers queries in one of the following ways:  
  
- If the answer is in its cache, it answers the query from the cache.  
- If the answer is in a zone hosted by the DNS server, it answers the query from its zone. A zone is a portion of the DNS tree stored on a DNS server. When a DNS server hosts a zone, it is authoritative for the names in that zone (that is, the DNS server can answer queries for any name in the zone). For example, a server hosting the zone contoso.com can answer queries for any name in contoso.com.  
- If the server cannot answer the query from its cache or zones, it queries other servers for the answer.  

It is important to understand the core features of DNS, such as delegation, recursive name resolution, and Active Directory-integrated DNS zones, because they have a direct impact on your Active Directory logical structure design.  
  
For more information about DNS and Active Directory Domain Services (AD DS), see [DNS and AD DS](../../ad-ds/plan/DNS-and-AD-DS.md).  
  
## Delegation

For a DNS server to answer queries about any name, it must have a direct or indirect path to every zone in the namespace. These paths are created by means of delegation. A delegation is a record in a parent zone that lists a name server that is authoritative for the zone in the next level of the hierarchy. Delegations make it possible for servers in one zone to refer clients to servers in other zones. The following illustration shows one example of delegation.  
  
![DNS concepts](../../media/Reviewing-DNS-Concepts/0c24b576-d41a-4e5d-ad3d-6be81e095835.gif)  
  
The DNS root server hosts the root zone represented as a dot ( . ). The root zone contains a delegation to a zone in the next level of the hierarchy, the com zone. The delegation in the root zone tells the DNS root server that, to find the com zone, it must contact the Com server. Likewise, the delegation in the com zone tells the Com server that, to find the contoso.com zone, it must contact the Contoso server.  
  
> [!NOTE]  
> A delegation uses two types of records. The name server (NS) resource record provides the name of an authoritative server. Host (A) and host (AAAA) resource records provide IP version 4 (IPv4) and IP version 6 (IPv6) addresses of an authoritative server.  
  
This system of zones and delegations creates a hierarchical tree that represents the DNS namespace. Each zone represents a layer in the hierarchy, and each delegation represents a branch of the tree.  
  
By using the hierarchy of zones and delegations, a DNS root server can find any name in the DNS namespace. The root zone includes delegations that lead directly or indirectly to all other zones in the hierarchy. Any server that can query the DNS root server can use the information in the delegations to find any name in the namespace.  
  
## Recursive name resolution

Recursive name resolution is the process by which a DNS server uses the hierarchy of zones and delegations to respond to queries for which it is not authoritative.  
  
In some configurations, DNS servers include root hints (that is, a list of names and IP addresses) that enable them to query the DNS root servers. In other configurations, servers forward all queries that they cannot answer to another server. Forwarding and root hints are both methods that DNS servers can use to resolve queries for which they are not authoritative.  
  
### Resolving names by using root hints

Root hints enable any DNS server to locate the DNS root servers. After a DNS server locates the DNS root server, it can resolve any query for that namespace. The following illustration describes how DNS resolves a name by using root hints.  
  
![DNS concepts](../../media/Reviewing-DNS-Concepts/1c044845-b104-4262-a7af-474ba3558a85.gif)  
  
In this example, the following events occur:  
  
1. A client sends a recursive query to a DNS server to request the IP address that corresponds to the name ftp.contoso.com. A recursive query indicates that the client wants a definitive answer to its query. The response to the recursive query must be a valid address or a message indicating that the address cannot be found.  
2. Because the DNS server is not authoritative for the name and does not have the answer in its cache, the DNS server uses root hints to find the IP address of the DNS root server.  
3. The DNS server uses an iterative query to ask the DNS root server to resolve the name ftp.contoso.com. An iterative query indicates that the server will accept a referral to another server in place of a definitive answer to the query. Because the name ftp.contoso.com ends with the label com, the DNS root server returns a referral to the Com server that hosts the com zone.  
4. The DNS server uses an iterative query to ask the Com server to resolve the name ftp.contoso.com. Because the name ftp.contoso.com ends with the name contoso.com, the Com server returns a referral to the Contoso server that hosts the contoso.com zone.  
5. The DNS server uses an iterative query to ask the Contoso server to resolve the name ftp.contoso.com. The Contoso server finds the answer in its zone data and then returns the answer to the server.  
6. The server then returns the result to the client.  
  
### Resolving names by using forwarding

Forwarding enables you to route name resolution through specific servers instead of using root hints. The following illustration describes how DNS resolves a name by using forwarding.  
  
![DNS concepts](../../media/Reviewing-DNS-Concepts/05bc2eb0-1033-4e53-ae30-244fa247d000.gif)  
  
In this example, the following events occur:  
  
1. A client queries a DNS server for the name ftp.contoso.com.  
2. The DNS server forwards the query to another DNS server, known as a forwarder.  
3. Because the forwarder is not authoritative for the name and does not have the answer in its cache, it uses root hints to find the IP address of the DNS root server.  
4. The forwarder uses an iterative query to ask the DNS root server to resolve the name ftp.contoso.com. Because the name ftp.contoso.com ends with the name com, the DNS root server returns a referral to the Com server that hosts the com zone.  
5. The forwarder uses an iterative query to ask the Com server to resolve the name ftp.contoso.com. Because the name ftp.contoso.com ends with the name contoso.com, the Com server returns a referral to the Contoso server that hosts the contoso.com zone.  
6. The forwarder uses an iterative query to ask the Contoso server to resolve the name ftp.contoso.com. The Contoso server finds the answer in its zone files, and then returns the answer to the server.  
7. The forwarder then returns the result to the original DNS server.  
8. The original DNS server then returns the result to the client.  
