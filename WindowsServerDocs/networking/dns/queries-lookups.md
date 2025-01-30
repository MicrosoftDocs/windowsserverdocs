---
title: DNS processes and interactions in Windows and Windows Server
description: Learn about DNS processes, including client-server communications for query resolution, dynamic updates, and zone administration in Windows and Windows Server.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 01/29/2025

---

# DNS processes and interactions

DNS processes and interactions involve the communications between DNS clients and DNS servers during the resolution of DNS queries and dynamic update, and between DNS servers during name resolution and zone administration. Secondary processes and interactions depend on the support for technologies such as Unicode and WINS. In this article learn about DNS processes, including client-server communications for query resolution, dynamic updates, and zone administration in Windows and Windows Server.

## How DNS queries work

When a DNS client needs to look up a name used in a program, it queries DNS servers to resolve the name. Each query message the client sends contains three pieces of information, specifying a question for the server to answer:

- A specified DNS domain name, stated as a fully qualified domain name (FQDN).
- A specified query type, which can either specify a resource record (RR) by type or a specialized type of query operation.
- A specified class for the DNS domain name. For DNS servers running the Windows operating system, this should always be specified as the Internet (IN) class.

For example, the name specified could be the FQDN for a computer, such as 'host-a.example.contoso.com.', and the query type specified to look for an address (A) RR by that name. Think of a DNS query as a client asking a server a two-part question, such as “Do you have any A resource records for a computer named 'hostname.example.contoso.com.'?” When the client receives an answer from the server, it reads and interprets the answered A RR, learning the IP address for the computer it asked for by name.

The following table describes common DNS query types and corresponding IDs.

| Type | ID |
| --- | --- |
| A | 1 |
| AAAA | 28 |
| SOA | 6 |
| SRV | 33 |

DNS queries resolve in many different ways. A client can sometimes answer a query locally using cached information obtained from a previous query. The DNS server can use its own cache of resource record information to answer a query. A DNS server can also query or contact other DNS servers on behalf of the requesting client to fully resolve the name, and then send an answer back to the client. This process is known as recursion.

In addition, the client itself can attempt to contact other DNS servers to resolve a name. When a client does so, it uses separate and more queries based on referral answers from servers. This process is known as iteration.

In general, the DNS query process occurs in two parts:

- A name query begins at a client computer and is passed to a resolver, the DNS Client service, for resolution.
- When the query can't be resolved locally, DNS servers can be queried as needed to resolve the name.

Each process is explained in more detail in the following sections.

### DNS Client service resolver

The following figure shows an overview of the complete DNS query process.

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-1.png" alt-text="Diagram showing overview of complete DNS query process.":::

As shown in the initial steps of the query process, a DNS domain name is used in a program on the local computer. The request is then passed to the DNS Client service for resolution using locally cached information. If the queried name can be resolved, the query is answered and the process is completed.

The local resolver cache can include name information obtained from two possible sources:

- If a Hosts file is configured locally, any host name-to-address mappings from that file are loaded into the cache when the DNS Client service is started.
- Resource records obtained in answered responses from previous DNS queries are added to the cache and kept for a time determined by the time-to-live (TTL).

If the query doesn't match an entry in the cache, the resolution process continues with the client querying a DNS server to resolve the name.

### Querying a DNS server

As shown in the preceding figure, the client queries a preferred DNS server. The server used during the initial client/server query is selected from a global list.

When the DNS server receives a query, it first checks to see if it can answer the query authoritatively based on resource record information contained in a locally configured zone on the server. If the queried name matches a corresponding RR in local zone information, the server answers authoritatively, using this information to resolve the queried name.

If no zone information exists for the queried name, the server then checks to see if it can resolve the name using locally cached information from previous queries. If a match is found here, the server answers with this information. Again, if the preferred server can answer with a positive matched response from its cache to the requesting client, the query is completed.

If the queried name doesn't find a matched answer at its preferred server, either from its cache or zone information, the query process can continue, using recursion to fully resolve the name. This involves assistance from other DNS servers to help resolve the name. By default, the DNS Client service asks the server to use a process of recursion to fully resolve names on behalf of the client before returning an answer.

In order for the DNS server to do recursion properly, it first needs some helpful contact information about other DNS servers in the DNS domain namespace. This information is provided in the form of root hints, a list of preliminary RRs that can be used by the DNS service to locate other DNS servers that are authoritative for the root of the DNS domain namespace tree. Root servers are authoritative for the domain root and top-level domains in the DNS domain namespace tree.

By using root hints to find root servers, a DNS server is able to complete the use of recursion. In theory, this process enables any DNS server to locate the servers that are authoritative for any other DNS domain name used at any level in the namespace tree.

For example, consider the use of the recursion process to locate the name `host-b.example.contoso.com.` when the client queries a single DNS server. The process occurs when a DNS server and client are first started and have no locally cached information available to help resolve a name query. It assumes that the name queried by the client is for a domain name of which the server has no local knowledge, based on its configured zones.

First, the preferred server parses the full name and determines that it needs the location of the server that is authoritative for the top-level domain, `com`. It then uses an iterative query to the “com” DNS server to obtain a referral to the `microsoft.com` server. Next, a referral answer comes from the “microsoft.com” server to the DNS server for `example.contoso.com`.

Finally, the `example.contoso.com.` server is contacted. Because this server contains the queried name as part of its configured zones, it responds authoritatively back to the original server that initiated recursion. When the original server receives the response indicating that an authoritative answer was obtained to the requested query, it forwards this answer back to the requesting client and the recursive query process is completed.

Although the recursive query process can be resource-intensive when performed as described, it has some performance advantages for the DNS server. For example, during the recursion process, the DNS server performing the recursive lookup obtains information about the DNS domain namespace. The server caches the information, which can be used again to help speed the answering of subsequent queries that use or match it. Over time, this cached information can grow to occupy a significant portion of server memory resources, although it's cleared whenever the DNS service is cycled on and off.

The following three figures illustrate the process by which the DNS client queries the servers on each adapter.
 
:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-2.png" alt-text="Diagram showing overview of complete DNS query process.":::
**Querying the DNS Server - Part 1**

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-3.png" alt-text="Diagram showing overview of complete DNS query process.":::
**Querying the DNS Server - Part 2**

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-4.png" alt-text="Diagram showing overview of complete DNS query process.":::
**Querying the DNS Server - Part 3**

Configuring DNS clients with more than one DNS Server IP adds fault tolerance to your DNS infrastructure. Adding multiple DNS Servers IPs allows DNS names to continue to be resolved if failures of the only configured DNS Server, of the underlying network link, or the supporting network infrastructure that connects a given client to a DNS Server.

Name failures might cause application or component hangs, resource outages waiting for dependent time-out expirations that directly or indirectly cause operational failures. See [DNS client resolution time-outs](https://learn.contoso.com/en-us/troubleshoot/windows-server/networking/dns-client-resolution-timeouts) for more detailed discussion on all possible scenarios.

For these reasons, it's recommended to configure any Windows client with more than one DNS server, but it's important to be aware of the Windows client resolution process, as it's different based on how many DNS servers we've configured.

The DNS query adaptive time-out feature enables the time-out for DNS queries to adapt based on the time required for previous queries, reducing the time out for most queries. Time-outs can also be increased for high-latency links, such as satellite links. Configuration of DNS time-outs is enabled on a per network interface basis, and can be optimized by Windows Store apps.

Instead of waiting for 1000ms before timing out a DNS query, the first time out is adjusted to be between 25ms and 1000ms, based on past performance of the network.

### DNS server nonresponsive cache

Nonresponsive DNS servers are cached and periodically retried. This enables the DNS client to use the best available server consistently, and to spend less time waiting for unresponsive DNS servers.

The DNS Client service queries the DNS servers in the following sequence:

1. The DNS Client service sends the name query to the first DNS server on the preferred adapter’s list of DNS servers and waits one second for a response.
1. If the DNS Client service doesn't receive a response from the first DNS server within one second, it sends the name query to the first DNS servers on all adapters that are still under consideration and waits two seconds for a response.
1. If the DNS Client service doesn't receive a response from any DNS server within two seconds, the DNS Client service sends the query to all DNS servers on all adapters that are still under consideration and waits another two seconds for a response.
1. If the DNS Client service still doesn't receive a response from any DNS server, it sends the name query to all DNS servers on all adapters that are still under consideration and waits four seconds for a response.
1. If it the DNS Client service doesn't receive a response from any DNS server, the DNS client sends the query to all DNS servers on all adapters that are still under consideration and waits eight seconds for a response.

If the DNS Client service receives a positive response, it stops querying for the name, adds the response to the cache and returns the response to the client.

If the DNS Client service hasn't received a response from any server within eight seconds, the DNS Client service responds with a time out. Also, if it hasn't received a response from any DNS server on a specified adapter, then for the next 30 seconds, the DNS Client service responds to all queries destined for servers on that adapter with a time out and doesn't query those servers.

If at any point the DNS Client service receives a negative response from a server, it removes every server on that adapter from consideration during this search. For example, if in step 2, the first server on Alternate Adapter A gave a negative response, the DNS Client service wouldn't send the query to any other server on the list for Alternate Adapter A.

The DNS Client service keeps track of which servers answer name queries more quickly, and it moves servers up or down on the list based on how quickly they reply to name queries.

The following figure shows how the DNS client queries each server on each adapter.

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-5.png" alt-text="Diagram showing overview of complete DNS query process.":::
**Multihomed Name Resolution**

### Alternate query responses

The preceding description of DNS queries assumes that the process ends with a positive response returned to the client. However, queries can return other answers as well. The following are the most common query answers:

- An authoritative answer
- A positive answer
- A referral answer
- A negative answer

An authoritative answer is a positive answer returned to the client and delivered with the authority bit set in the DNS message to indicate the answer was obtained from a server with direct authority for the queried name.

A positive response can consist of the queried RR or a list of RRs (also known as a RRset) that fits the queried DNS domain name and record type specified in the query message.

A referral answer contains other RRs not specified by name or type in the query. This type of answer is returned to the client if the recursion process isn't supported. The records are meant to act as helpful reference answers that the client can use to continue the query using iteration. A referral answer contains more data such as RRs that are other than the type queried. For example, if the queried host name was “www” and no A RRs for this name were found in this zone but a CNAME RR for “www” was found instead, the DNS server can include that information when responding to the client. If the client is able to use iteration, it can make more queries using the referral information in an attempt to fully resolve the name for itself.

A negative response from the server can indicate that one of two possible results was encountered while the server attempted to process and recursively resolve the query fully and authoritatively. 

- An authoritative server reported that the queried name doesn't exist in the DNS namespace.
- An authoritative server reported that the queried name exists, but no records of the specified type exist for that name.

The resolver passes the results of the query, in the form of either a positive or negative response, back to the requesting program and caches the response.

If the resultant answer to a query is too long to be sent and resolved in a single UDP message packet, the DNS server can initiate a failover response over TCP port 53 to answer the client fully in a TCP connected session.

Disabling the use of recursion on a DNS server is done when DNS clients are being limited to resolving names to a specific DNS server, such as one located on your intranet. Recursion might also be disabled when the DNS server is incapable of resolving external DNS names, and clients are expected to fail over to another DNS server for resolution of these names. If you disable recursion on the DNS server, you won't be able to use forwarders on the same server.

By default, DNS servers use several default timings when performing a recursive query and contacting other DNS servers. These defaults include:

- A recursion retries interval of 3 seconds. This is the length of time the DNS service waits before retrying a query made during a recursive lookup.
- A recursion time-out interval of 8 seconds. This is the length of time the DNS service waits before failing a recursive lookup that has been retried.

Under most circumstances, these parameters don't need adjustment. However, if you're using recursive lookups over a slow-speed wide area network (WAN) link, you might be able to improve server performance and query completion by making slight adjustments to the settings.

## How iteration works

Iteration is the type of name resolution used between DNS clients and servers when the following conditions are in effect:

- The client requests the use of recursion, but recursion is disabled on the DNS server.
- The client doesn't request the use of recursion when querying the DNS server.

An iterative request from a client tells the DNS server that the client expects the best answer the DNS server can provide immediately, without contacting other DNS servers.

When iteration is used, a DNS server answers a client based on its own specific knowledge about the namespace regarding the names data being queried. For example, if a DNS server on your intranet receives a query from a local client for “www.contoso.com”, it might return an answer from its names cache. If the queried name isn't currently stored in the names cache of the server, the server might respond by providing a referral. A referral is a list of NS and A RRs for other DNS servers that are closer to the name queried by the client.

When iteration is used, a DNS server can further help a name query resolution beyond giving its own best answer back to the client. For most iterative queries, a client uses its locally configured list of DNS servers to contact other name servers throughout the DNS namespace if its primary DNS server can't resolve the query.

The Windows Server 2008 DNS Client service doesn't perform recursion.

## How caching works

As DNS servers process client queries using recursion or iteration, they discover and acquire a significant store of information about the DNS namespace. This information is then cached by the server.

Caching provides a way to speed up the performance of DNS resolution for subsequent queries of popular names, while substantially reducing DNS-related query traffic on the network.

As DNS servers make recursive queries on behalf of clients, they temporarily cache resource records. Cached RRs contain information obtained from DNS servers that are authoritative for DNS domain names learned while making iterative queries to search and fully answer a recursive query performed on behalf of a client. Later, when other clients place new queries that request RR information matching cached RRs, the DNS server can use the cached RR information to answer them.

When information is cached, a Time-To-Live (TTL) value applies to all cached RRs. As long as the TTL for a cached RR doesn't expire, a DNS server can continue to cache and use the RR again when answering queries by its clients that match these RRs. Caching TTL values used by RRs in most zone configurations are assigned the minimum (default) TTL which is set in the zone’s Start of Authority (SOA) RR. By default, the minimum TTL is 3,600 seconds (one hour) but can be adjusted or, if needed, individual caching TTLs can be set at each RR.

> [!NOTE]
> Information the user should notice even if skimmingBy default, the DNS Server service uses a root hints file, cache.dns, that is stored in the systemroot\\System32\\Dns folder on the server computer. This file contains the NS and A RRs for the root servers of the DNS namespace (the Internet root servers or intranet root servers). When the DNS Server service is started, the root server list is queried for a current list of all the root servers. The results of the query are used to update the root hints file. This operation is also performed periodically while the service is running. When changes are made to the root hints by an administrator, these changes are written back to the root hints file.

## Reverse lookup

In most DNS lookups, clients typically perform a forward lookup, which is a search based on the DNS name of another computer as stored in an address (A) RR. This type of query expects an IP address as the resource data for the answered response.

DNS also provides a reverse lookup process, enabling clients to use a known IP address during a name query and to look up a computer name based on its address. A reverse lookup takes the form of a question, such as “Can you tell me the DNS name of the computer that uses the IP address 192.168.1.20?”

DNS wasn't originally designed to support this type of query. One problem for supporting the reverse query process is the difference in how the DNS namespace organizes and indexes names and how IP addresses are assigned. If the only method available to answer the previous question was to search all domains in the DNS namespace, a reverse query would take too long and require too much processing to be useful.

To solve this problem, a special domain called the in-addr.arpa domain was defined in the DNS standards and reserved in the Internet DNS namespace to provide a practical and reliable way to perform reverse queries. To create the reverse namespace, subdomains within the in-addr.arpa domain are formed using the reverse ordering of the numbers in the dotted-decimal notation of IP addresses.

This reversed ordering of the domains for each octet value is needed because, unlike DNS names, when IP addresses are read from left to right, they're interpreted in the opposite manner. When an IP address is read from left to right, it's viewed from its most generalized information (an IP network address) in the first part of the address to the more specific information (an IP host address) contained in the last octets.

For this reason, the order of IP address octets must be reversed when building the in-addr.arpa domain tree. The IP addresses of the DNS in-addr.arpa tree can be delegated to companies as they're assigned a specific or limited set of IP addresses within the Internet-defined address classes.

Finally, the in-addr.arpa domain tree, as built into DNS, requires that another RR type, the pointer (PTR) RR, be defined. This RR is used to create a mapping in the reverse lookup zone that typically corresponds to a host (A) named RR for the DNS computer name of a host in its forward lookup zone.

The in-addr.arpa domain applies for use in all TCP/IP networks that are based on Internet Protocol version 4 (IPv4) addressing. The New Zone Wizard automatically assumes that you're using this domain when creating a new reverse lookup zone.

If you're installing DNS and configuring reverse lookup zones for an Internet Protocol version 6 (IPv6) network, you can specify an exact name in the New Zone Wizard. This permits you to create reverse lookup zones in the DNS console that can be used to support IPv6 networks, which use a different special domain name, the ip6.arpa domain.

For information about IPv6 and DNS, including examples of how to create and use ip6.arpa domain names as described in RFC 1886 (“DNS Extensions to support IP version 6”), see [DNS Reference Information](https://learn.contoso.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd197499\(v=ws.10\)).

> [!NOTE]
> Information the user should notice even if skimmingThe configuration of PTR RRs and reverse lookup zones for identifying hosts by reverse query is strictly an optional part of the DNS standard implementation. You aren't required to use reverse lookup zones, although for some networked applications, they're used to perform security checks.

### Example: Reverse query in IPv4 networks

The following figure shows an example of a reverse query initiated by a DNS client (host-b) to learn the name of another host (host-a) based on its IP address, 192.168.1.20.

**Reverse Query**

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-6.png" alt-text="Diagram showing overview of complete DNS query process.":::

The reverse query process as shown in this figure occurs in the following steps:

1. The client, “host-b”, queries the DNS server for a pointer (PTR) RR that maps to the IP address of 192.168.1.20 for “host-a”.

Because the query is for PTR records, the resolver reverses the address and appends the in-addr.arpa domain to the end of the reverse address. This forms the fully qualified domain name (“20.1.168.192.in-addr.arpa.”) to be searched in a reverse lookup zone.

1. After it has been located, the authoritative DNS server for “20.1.168.192.in-addr.arpa” can respond with the PTR record information. This includes the DNS domain name for “host-a”, completing the reverse lookup.

Keep in mind that if the queried reverse name isn't answerable from the DNS server, normal DNS resolution (either recursion or iteration) can be used to locate a DNS server that is authoritative for the reverse lookup zone and that contains the queried name. In this sense, the name resolution process used in a reverse lookup is identical to that of a forward lookup.

> [!NOTE]
> Information the user should notice even if skimmingThe DNS console provides a means for you to configure a subnetted reverse lookup “classless” zone when the **Advanced** view is selected. This allows you to configure a zone in the in-addr.arpa domain for a limited set of assigned IP addresses where a nondefault IP subnet mask is used with those addresses. Checked that on win2022 and it's not there so it needs to be removed or rephrased

### Forwarding

A forwarder is a DNS server on a network used to forward DNS queries for external DNS names to DNS servers outside of that network. You can also forward queries according to specific domain names using conditional forwarders.

A DNS server on a network is designated as a forwarder by having the other DNS servers in the network forward the queries they can't resolve locally to that DNS server. By using a forwarder, you can manage name resolution for names outside of your network, such as names on the Internet, and improve the efficiency of name resolution for the computers in your network.

The following figure illustrates how external name queries are directed using forwarders.

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-7.png" alt-text="Diagram showing overview of complete DNS query process.":::
**External Name Queries Directed Using Forwarders**

Without having a specific DNS server designated as a forwarder, all DNS servers can send queries outside of a network using their root hints. As a result, internal, and possibly critical, DNS information can be exposed on the Internet. In addition to this security and privacy issue, this method of resolution can result in a large volume of external traffic that is costly and inefficient for a network with a slow Internet connection or a company with high Internet service costs.

When you designate a DNS server as a forwarder, you make that forwarder responsible for handling external traffic, thereby limiting DNS server exposure to the Internet. A forwarder builds up a large cache of external DNS information because all of the external DNS queries in the network are resolved through it. In a short amount of time, a forwarder will resolve a good portion of external DNS queries using this cached data and thereby decrease the Internet traffic over the network and the response time for DNS clients.

#### Behavior of a DNS server configured to use forwarding

A DNS server configured to use a forwarder behaves differently from a DNS server that isn't configured to use a forwarder. A DNS server configured to use a forwarder behaves as follows:

1. When the DNS server receives a query, it attempts to resolve this query using the primary and secondary zones that it hosts and its cache.
1. If the query can't be resolved using this local data, then it forwards the query to the DNS server designated as a forwarder.
1. The DNS server waits briefly for an answer from the forwarder before attempting to contact the DNS servers specified in its root hints.

When a DNS server forwards a query to a forwarder, it sends a recursive query to the forwarder. This is different from the iterative query that a DNS server sends to another DNS server during standard name resolution (name resolution that doesn't involve a forwarder).

#### Forwarding sequence

The sequence in which the forwarders configured on a DNS server are used is determined by the order in which the IP addresses are listed on the DNS server. After the DNS server forwards the query to the forwarder with the first IP address, it waits a short period for an answer from that forwarder (according to the DNS server’s time-out setting) before resuming the forwarding operation with the next IP address. It continues this process until it receives an affirmative answer from a forwarder.

The following behavior in RED has changed and needs to be updated:

Which forwarder a Microsoft DNS Server uses depends on the server’s configuration.  By default, ‘Dynamic Forwarder Reordering’ is enabled, so if the default is kept, then this is how the algorithm works:

EXISTING REORDERING ALGORITHM

1. The DNS Server allows admin to create forwarders in a preferred order.

1. A dynamic list of forwarders is maintained. This gets reordered based on the response times. But this also gets reset to the configured order every 15 minutes (approximately as this is called by a thread which is overloaded to perform other works as well.).

1. For a given query, the forwarders are picked as they appear in the dynamic list.

1. If the response time is > 1 second, then it's considered a slow response. Each forwarder is allowed two consecutive slow responses, on the third it's put to the end of the dynamic list.

1. If all the servers in the list go dead, then DNS has no way to know if the server is dead or slow. This monitoring has to be done outside the system.

Unlike conventional resolution, where a roundtrip time (RTT) is associated with each server, the IP addresses in the forwarders list aren't ordered according to roundtrip time and must be reordered manually to change preference.

### Forwarders and delegation

A DNS server configured with a forwarder and hosting a parent zone will use its delegation information before forwarding queries. If no delegation record exists for the DNS name in the query, then the DNS server uses its forwarders to resolve the query.

### Forwarders and root servers

A common error when configuring forwarding is to attempt to configure forwarding on the root servers of a private DNS namespace. The goal of attempting to configure forwarding on root servers for a private DNS namespace is to forward all offsite queries to Internet DNS servers. Root servers can't be configured with standard forwarding. If a root server is queried about any domain name, then it refers to a DNS server that can answer the question (from its local zones, cache), or it responds with a failure (NXDOMAIN), but it can't be configured to forward to specific servers.

> [!NOTE]
> Information the user should notice even if skimmingA root server can be configured with a conditional forwarder. Conditional forwarding can be used to forward queries between root servers in separate DNS namespaces, although the DNS servers for the top-level domains in the namespace are better suited for this method of resolution.

### Conditional forwarders

A conditional forwarder is a DNS server on a network that is used to forward DNS queries according to the DNS domain name in the query. For example, a DNS server can be configured to forward all the queries it receives for names ending with widgets.example.com to the IP address of a DNS server or to the IP addresses of multiple DNS servers.

### Intranet name resolution

A conditional forwarder can be used to improve name resolution for domains within your intranet. Intranet name resolution can be improved by configuring DNS servers with forwarders for specific internal domain names. For example, all DNS servers in the domain widgets.example.com could be configured to forward queries for names that end with test.example.com to the authoritative DNS servers for merged.widgets.example.com, thereby removing the step of querying the root servers of example.com, or removing the step of configuring DNS servers in the widgets.example.com zone with secondary zones for test.example.com.

DNS servers can use conditional forwarders to resolve queries between the DNS domain names of companies that share information. For example, two companies, Widgets Toys and Tailspin Toys, want to improve how the DNS clients of Widgets Toys resolve the names of the DNS clients of Tailspin Toys. The administrators from Tailspin Toys inform the administrators of Widgets Toys about the set of DNS servers in the Tailspin Toys network where Widgets can send queries for the domain dolls.tailspintoys.com. The DNS servers within the Widgets Toys network are configured to forward all queries for names ending with dolls.tailspintoys.com to the designated DNS servers in the network for Tailspin Toys. So, the DNS servers in the Widgets Toys network don't need to query their internal root servers, or the Internet root servers, to resolve queries for names ending with dolls.tailspintoys.com.