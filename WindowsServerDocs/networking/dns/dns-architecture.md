---
title: DNS Architecture in Windows Server
description: Learn about the architecture of the Domain Name System (DNS) using Windows Server, including DNS domain names, DNS domain namespace, DNS resource records, and DNS zones.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 02/06/2025
ai-usage: ai-assisted # Used for image alt text
---

# DNS Architecture in Windows Server

DNS is a hierarchical distributed database and an associated set of protocols that define:

- A mechanism for querying and updating the database

- A mechanism for replicating the information in the database among servers

- A schema of the database

DNS host names reside in a database that can be distributed among multiple servers, decreasing the load on any one server, and provide the ability to administer this naming system on a per-partition basis. DNS supports hierarchical names and allows registration of various data types in addition to host name-to-IP address mapping used in HOSTS files. The DNS database is distributed, allowing it to both scale up and scale out, meaning performance isn't degraded when more servers are added.

The original DNS was based on [Request for Comment (RFC) 1035 (Domain Names–Implementation and Specification)](https://datatracker.ietf.org/doc/rfc1035/). Other RFCs describe DNS security, implementation, and administrative issues later augmented the original design specifications.

The RFCs used in the Windows Server operating systems are:

- Domain names - concepts and facilities [RFC 1034](https://datatracker.ietf.org/doc/rfc1034/)
- Domain names - implementation and specification [RFC 1035](https://datatracker.ietf.org/doc/rfc1035/)
- DNS Extensions to support IP version 6 [RFC 1886](https://datatracker.ietf.org/doc/rfc1886/)
- A Mechanism for Prompt Notification of Zone Changes (DNS NOTIFY) [RFC 1996](https://datatracker.ietf.org/doc/rfc1996/)
- Incremental Zone Transfer in DNS [RFC 1995](https://datatracker.ietf.org/doc/rfc1995/)
- Dynamic Updates in the Domain Name System (DNS UPDATE)[RFC 2136](https://datatracker.ietf.org/doc/rfc2136/)
- Negative Caching of DNS Queries (DNS NCACHE) [RFC 2308](https://datatracker.ietf.org/doc/rfc2308/)
- Resource Records for the DNS Security Extensions [RFC 4034](https://datatracker.ietf.org/doc/rfc4034/)
- Protocol Modifications for the DNS Security Extensions [RFC 4035](https://datatracker.ietf.org/doc/rfc4035/)
- A DNS RR for specifying the location of services (DNS SRV) [RFC 2052](https://datatracker.ietf.org/doc/rfc2052/)

## DNS domain names

DNS is implemented as a hierarchical and distributed database containing various types of data, including host names and domain names. The names in a DNS database form a hierarchical tree structure called the domain namespace. Domain names consist of individual labels separated by dots, for example: `mydomain.contoso.com`.

A fully qualified domain name (FQDN) uniquely identifies the host’s position within the DNS hierarchical tree. The FQDN specifies a list of names separated by dots in the path from the referenced host to the root. The following figure shows an example of a DNS tree with a host called `mydomain` within the `contoso.com` domain. The FQDN for the host would be `mydomain.contoso.com`.

:::image type="content" source="../media/dns-architecture/registration-authority.png" alt-text="The diagram shows hierarchical structure of DNS architecture and how DNS zones are managed by different authorities." lightbox="../media/dns-architecture/registration-authority.png":::

## Understanding the DNS domain namespace

The DNS domain namespace, as shown in the preceding figure, is based on the concept of a tree of named domains. Each level of the tree can represent a branch or a leaf. A branch is a level where more than one name is used to identify a collection of named resources. A leaf represents a single name used once at that level to indicate a specific resource.

## DNS Domain Name Hierarchy

DNS clients and servers use queries as the method of resolving names in the tree to specific types of resource information. This information is provided by DNS servers in query responses to DNS clients that then extract the information and pass it to a requesting program for resolving the queried name. In the process of resolving a name, DNS servers often function as DNS clients, querying other servers in order to fully resolve a queried name.

For example, Contoso is assigned authority by the Internet root servers for its own part of the DNS domain namespace tree on the Internet, that is, `contoso.com`. Resolving a name outside of the `contoso.com` namespace requires Contoso DNS servers to query other DNS servers, such as the root servers.

## How the DNS domain namespace is organized

Any DNS domain name used in the tree is technically a domain. However most DNS discussions identify names in one of five ways, based on the level and the way a name is commonly used. For example, the DNS domain name registered to Contoso (`contoso.com`) is known as a second-level domain. The name has two parts (known as labels) that indicate it's located two levels below the root or top of the tree. Most DNS domain names have two or more labels, each of which indicates a new level in the tree. Periods are used in names to separate labels.

The following table describes the five categories of DNS domain names by their function in the namespace, along with an example of each name type.

| Name type | Description | Example |
| --------- | ---------- | ---------- |
| Root domain | The top of the tree, representing an unnamed level; it's sometimes shown as two empty quotation marks (""), indicating a null value. When used in a DNS domain name, it's stated by a trailing period (.) to designate that the name is located at the root or highest level of the domain hierarchy. In this instance, the DNS domain name is considered to be complete and points to an exact location in the tree of names. Names stated this way are FQDNs. A single period (.) or a period used at the end of a name, such as `example.contoso.com.` | A single period (.) or a period used at the end of a name, such as `example.contoso.com.` |
| Top-level Domain (TLD) | A name used to indicate a country or region or the type of organization using a name. | `.com`, which indicates a name registered to a business for commercial use on the Internet. |
| Second-level domain | Variable-length names registered to an individual or organization for use on the Internet. These names are always based on an appropriate top-level domain, depending on the type of organization or geographic location where a name is used. | `contoso.com.` is the second-level domain name registered to Contoso by the Internet DNS domain name registrar. |
| Subdomain | Other names that an organization can create that are derived from the registered second-level domain name. Subdomains include names added to grow the DNS tree of names in an organization and divide it into departments or geographic locations. |  `example.contoso.com.` is a subdomain assigned by Contoso for use in documentation example names. |
| Host or resource name | Names that represent a leaf in the DNS tree of names and identify a specific resource. Typically, the left-most label of a DNS domain name identifies a specific computer on the network. For example, if a name at this level is used in a host (A) resource record, it's used to look up the IP address of computer based on its host name. | `host-a.example.contoso.com.` The first label (host-a) is the DNS host name for a specific computer on the network. |

## DNS and Internet domains

Internet registration authorities manage the Domain Name System. The registration authorities are responsible for maintaining top-level domains assigned by organization and by country/region. These domain names follow the International Standard for country codes (ISO 3166). There are hundreds of top-level-domain names available for use by the public. The following table shows a few common TLDs, as well example two-letter abbreviations used for countries and regions.

| DNS Domain Name | Type of Organization |
| ---------- | ---------- |
| .com | Commercial organizations |
| .edu | Educational institutions |
| .org | Non-profit organizations |
| .net | Networks (the backbone of the Internet) |
| .gov | Nonmilitary government organizations |
| .mil | Military government organizations |
| .arpa | Reverse DNS |
| .xx | Two-letter country codes (for example, `.us`, `.au`, `.ca`., `.fr`) |

## DNS resource records

DNS resource records contain the information that a zone maintains about the resources (such as
hosts) that the zone contains. A typical resource record consists of the:

- Name (host) of the resource record.
- Information about how long the resource record can remain in the cache.
- Resource record type, such as a host (A) resource record.
- Data that's specific to the record type, such as the hosts IPv4 address.

You can add resource records directly, or they can be added automatically when Windows-based,
Dynamic Host Configuration Protocol (DHCP) enabled clients join a network using
dynamic update.

### Types of resource records

Common resource records include:

| Resource record type | Description |
|--|--|
| Host (A, AAAA) records | Maps a hostname to an IP address. |
| Alias (CNAME) records | Forward an alias domain name or subdomain to another primary or canonical name. Alias (CNAME) resource records are also termed canonical name resource records. With these records, you can use more than one DNS name to point to a single host. |
| Mail exchanger (MX) records | Specifies the name of a computer that exchanges or forwards mail. E-mail applications use the mail exchanger (MX) resource record to locate a mail server based on a DNS domain name in the destination address for the e-mail recipient of a message. If multiple mail exchanger (MX) resource records exist, the DNS Client service attempts to contact mail servers in the order of preference from lowest value (highest priority) to highest value (lowest priority). |
| Pointer (PTR) records | Used by reverse DNS lookups to map an IP address to domain. Pointer (PTR) resource records support the reverse lookup process, based on zones that are created and rooted in the `in-addr.arpa` domain. You need to have the appropriate reverse lookup zone present on your DNS server to create a PTR record that maps an IP address to a specific hostname. |
| Service location (SRV) records | Specifies the host, port, and protocol for a service. Service location (SRV) resource records are required when clients use DNS to locate location services such as Active Directory domain controllers. |
| Name server (NS) records | Specifies the authoritative name servers for a domain. |
| Text (TXT) record | Enables the publication of text in a DNS record. Text records let you add text information that is returned by querying DNS. TXT records are often used to authenticate ownership of DNS zones. |
| Delegation name (DNAME) record | Provides an alias for a domain, like a CNAME record, but includes all subdomains. |
| Start of authority (SOA) record | Provides authoritative information about a DNS zone. The SOA record includes primary name server, contact of DNS zone administrator, refresh information, and other information. |

### Time-to-Live for resource records

The Time-to-Live (TTL) value in a resource record indicates a length of time used by other DNS servers to determine how long to cache information for a record before expiring and discarding it. For example, most resource records created by the DNS Server service inherit the minimum (default) TTL of one hour from the start of authority (SOA) resource record, which prevents extended caching by other DNS servers.

A DNS client resolver caches the responses it receives when it resolves DNS queries. These cached responses can then be used to answer later queries for the same information. The cached data, however, has a limited lifetime specified in the TTL parameter returned with the response data. TTL ensures that the DNS server doesn't keep information for so long that it becomes out of date. TTL for the cache can be set on the DNS database (for each individual resource record, by specifying the TTL field of the record and per zone through the minimum TTL field of the SOA record) and on the DNS client resolver side by specifying the maximum TTL the resolver allows to cache the resource records.

There are two competing factors to consider when setting the TTL. The first is the accuracy of the cached information, and the second is the utilization of the DNS servers and the amount of network traffic. If the TTL is short, then the likelihood of having old information is reduced considerably, but it increases utilization of DNS servers and network traffic, because the DNS client must query DNS servers for the expired data the next time it's requested. If the TTL is long, the cached responses could become outdated, meaning the resolver could give false answers to queries. At the same time, a long TTL decreases utilization of DNS servers and reduces network traffic because the DNS client answers queries using its cached data.

If a query is answered with an entry from cache, the TTL of the entry is also passed with the response. This way the resolvers that receive the response know how long the entry is valid. The resolvers honor the TTL from the responding server; they don't reset it based on their own TTL. So, entries truly expire rather than live in perpetuity as they move from DNS server to DNS server with an updated TTL.

> [!NOTE]
> In general, never configure the TTL to zero. The difference between a setting of 0 or 60 is minimal to the accuracy of the record, but when the TTL is set to 0, there's a significant impact on DNS server performance because the DNS server is constantly querying for the expired data.

## Zones and delegation

A DNS database can be partitioned into multiple zones. A zone is a portion of the DNS database that contains the resource records with the owner names belonging to the contiguous portion of the DNS namespace. Zone files are maintained on DNS servers. A single DNS server can be configured to host zero, one, or multiple zones.

Each zone is anchored at a specific domain name referred to as the zone’s root domain. A zone contains information about all names that end with the zone’s root domain name. A DNS server is considered authoritative for a name if it loads the zone containing that name. The first record in any zone file is a Start of Authority (SOA) resource record. The SOA resource record identifies a primary DNS name server for the zone as the best source of information for the data within that zone. The SOA also acts as an entity processing the updates for the zone.

A name within a zone can also be delegated to a different zone that's hosted on a different DNS server. Delegation is a process of assigning responsibility for a portion of a DNS namespace to a DNS server owned by a separate entity. This separate entity can be another organization, department, or workgroup within your company. Such delegation is represented by the NS resource record that specifies the delegated zone and the DNS name of the server authoritative for that zone. Delegating across multiple zones was part of the original design goal of DNS.

To learn more about the types and replication of DNS zones, see [DNS zones](zone-types.md).

Reasons to delegate a DNS namespace include:

- A need to delegate management of a DNS domain to many organizations or departments within an organization.

- A need to distribute the load of maintaining one large DNS database among multiple DNS servers to improve the name resolution performance and create a DNS fault-tolerant environment.

- A need to allow for a host’s organizational affiliation by including the host in appropriate domains.
The name server (NS) resource records facilitate delegation by identifying DNS servers for each zone and the NS resource records appear in all zones. Whenever a DNS server needs to cross a delegation in order to resolve a name, it refers to the NS resource records for DNS servers in the target zone.

The following image shows how management of the `contoso.com` domain is delegated across two zones, `contoso.com` and `mydomain.contoso.com`.

:::image type="content" source="../media/dns-architecture/dns-delegation.png" alt-text="The diagram illustrates the hierarchical structure of DNS zone delegation, further delegating to contoso.com and mydomain.contoso.com." lightbox="../media/dns-architecture/dns-delegation.png":::

> [!NOTE]
> If multiple NS records exist for a delegated zone identifying multiple DNS servers available for querying, the Windows Server DNS Server service will be able to select the closest DNS server based on the roundtrip intervals measured over time for every DNS server.

## DNS service architecture

The following diagram illustrates the DNS Client service architecture in its name resolution and update operations in the Windows client and Windows Server. Name resolution architecture is demonstrated using a client application and updates are represented by the DHCP client.

:::image type="content" source="../media/dns-architecture/dns-client-service-architecture.png" alt-text="A diagram illustrating the DNS Client service architecture in its name resolution and update operations in the Windows client and Windows Server. " lightbox="../media/dns-architecture/dns-client-service-architecture.png":::

The following diagram illustrates the DNS Server service architecture with its administration tools and the Windows Management Instrumentation (WMI) interface in Windows Server.

:::image type="content" source="../media/dns-architecture/dns-server-service-architecture.png" alt-text="A diagram illustrating the DNS Server service architecture in Windows Server." lightbox="../media/dns-architecture/dns-server-service-architecture.png":::

The following sections describe the DNS query process and how DNS updates are handled.

## DNS queries

DNS queries can be sent from a DNS client (resolver) to a DNS server, or between two DNS servers.

A DNS query is merely a request for DNS resource records of a specified resource record type with a specified DNS name. For example, a DNS query can request all resource records of type A (host) with a specified DNS name.

There are two types of DNS queries that can be sent to a DNS server:

- **Recursive**: A recursive query forces a DNS server to respond to a request with either a failure or a success response. DNS clients (resolvers) typically make recursive queries. With a recursive query, the DNS server must contact any other DNS servers it needs to resolve the request. When it receives a successful response from the other DNS server (or servers), it then sends a response to the DNS client. The recursive query is the typical query type used by a resolver querying a DNS server and by a DNS server querying its forwarder, which is another DNS server configured to handle requests forwarded to it.

  When a DNS server processes a recursive query and the query can't be resolved from local data (local zone files or cache of previous queries), the recursive query must be escalated to a root DNS server. Each standards-based implementation of DNS includes a cache file (or root server hints) that contains entries for the root DNS servers of the Internet domains. (If the DNS server is configured with a forwarder, the forwarder is used before a root server is used.)

- **Iterative**: An iterative query is one in which the DNS server is expected to respond with the best local information it has, based on what the DNS server knows from local zone files or from caching. This response is also known as a referral if the DNS server isn't authoritative for the name. If a DNS server doesn't have any local information that can answer the query, it simply sends a negative response. A DNS server makes this type of query as it tries to find names outside of its local domain (or domains) (when it isn't configured with a forwarder). It might have to query outside DNS servers in an attempt to resolve the name.

The following figure shows an example of both types of queries.

:::image type="content" source="../media/dns-architecture/dns-query-types.png" alt-text="The diagram shows how multiple queries were used to determine the IP address for www.contoso.com." lightbox="../media/dns-architecture/dns-query-types.png":::

The diagram shows how multiple queries were used to determine the IP address for `www.contoso.com`. The query sequence is described as follows:

1. Recursive query for `www.contoso.com` (A resource record).

1. Iterative query for `www.contoso.com` (A resource record).

1. Referral to the `.com` name server (NS resource records, for `.com`); for simplicity, iterative A queries by the DNS server to resolve the IP addresses of the Host names of the name server’s returned by other DNS servers have been omitted.

1. Iterative query for `www.contoso.com` (A resource record).

1. Referral to the `contoso.com` name server (NS resource record, for `contoso.com`).

1. Iterative query for `www.contoso.com` (A resource record).

1. Answer to the iterative query from contoso.com server (The `www.contoso.com` IP address).

1. Answer to the original recursive query from local DNS server to resolver (The `www.contoso.com` IP address).

## Update DNS

Resource records often change as computers, servers, and devices are added to or removed from the network. The implementation of DNS in Windows Server supports both static and dynamic updates of the DNS database.

Resource records can be added to an existing zone using the [Add-DNSServerResourceRecord](/powershell/module/dnsserver/add-dnsserverresourcerecord) PowerShell command. Some common resource record types have other PowerShell commands where you don't need to specify the resource record type. You can also add resource records using the DNS Manager console. See [Managing DNS resource records](manage-resource-records.md) for guidance on working with resource records, including creating and modifying existing resource records of all
types.

## Unicode character support

When DNS was introduced as part of RFC 1035, names were limited to using uppercase and lowercase letters (A-Z, a-z), numbers (0-9), and hyphens (-). In addition, the first character of the DNS name can be a number and names must be encoded and represented using US-ASCII-based characters. For use of DNS in international settings, this requirement creates significant limitations where extended character sets are used for local naming standards. The Windows Server DNS service provides enhanced support, beyond the [RFC 1035 specification](https://datatracker.ietf.org/doc/rfc1035/), for UTF-8 characters.

## What is UTF-8?

UTF-8 is the recommended character set for protocols evolving beyond the use of ASCII. The UTF-8 protocol provides for support of extended ASCII characters and translation of UCS-2, a 16-bit Unicode character set that encompasses most of the world’s writing systems. UTF-8 enables a far greater range of names than can be achieved using ASCII or extended ASCII encoding for character data.

Computers running Windows Server 2008 are UTF-8 aware. Meaning that when UTF-8-encoded characters are received or used as data by the server, the server can load and store this data in its zones. Although Windows-based DNS servers are UTF-8 aware, they remain compatible with other DNS servers that use traditional US-ASCII data encoding and current DNS standards.

### How the DNS service implements UTF-8

To provide standards compatibility and interoperability with other DNS implementations, the DNS service uses uniform downcasing of any received character data. In this process, the DNS service converts all uppercase characters used in standard US-ASCII data to lowercase equivalent data for the following reasons:

- To maintain compatibility with current and existing DNS standards.
- To provide interoperability with DNS server implementations that don't recognize or support UTF-8 encoding.

To understand why uniform downcasing was chosen, several related points must first be considered from the current revised Internet standards for DNS. Several key points in the standards pertain directly to how character data is to be handled between DNS servers and other servers and clients. Key points include:

- Any binary string can be used in a DNS name. ([RFC 2181](https://datatracker.ietf.org/doc/rfc2181/))
- DNS servers must be able to compare names in a case-insensitive way. ([RFC 1035](https://datatracker.ietf.org/doc/rfc1035/))
- The original case for character data should be preserved whenever possible as the data is entered into the system. ([RFC 1035](https://datatracker.ietf.org/doc/rfc1035/))

Because case insensitivity is a required part of the core DNS standard and case preservation is an optional recommendation, uniform downcasing was chosen to provide an effective standards-compliant solution. By downcasing UTF-8 encoded names before transmission, other DNS servers (which aren't UTF-8 aware) are able to receive and perform successful binary comparisons of the data and obtain the desired results.

### Considerations for interoperability with UTF-8

The DNS Server service can be set to allow or block the use of UTF-8 characters for each server. Some DNS servers that don't support UTF-8 might accept zones with UTF-8 names but could have trouble saving or reloading those names. Be careful when transferring zones with UTF-8 names to servers that don't support UTF-8.

Some protocols place restrictions on the characters allowed in a name. In addition, names that are intended to be globally visible (RFC 1958) should contain ASCII-only characters, as recommended in RFC 1123.

Using UTF-8 to transform Unicode characters is invisible to users. However, you can see UTF-8-encoded characters if you use Network Monitor or a similar tool to analyze DNS traffic.

In addition to DNS server support for the UTF-8 encoding format, the client resolver defaults to using the UTF-8 character encoding format.

Names encoded in UTF-8 format must not exceed the size limits clarified in RFC 2181, which specifies a maximum of 63 octets per label and 255 octets per name. Character count is insufficient to determine size because some UTF-8 characters exceed one octet in length.

The UTF-8 encoding protocol adapts to use with existing DNS protocol implementations that expect US-ASCII characters because representation of US-ASCII characters in UTF-8 is identical, byte for byte, to the US-ASCII representation. DNS client or server implementations that don't recognize UTF-8 characters always encode names in the US-ASCII format. The DNS Server service is able to correctly interpret those names.

The DNS service can configure name checking to allow or restrict the use of UTF-8 characters in DNS data.

By default, multibyte UTF-8 name checking is used, allowing the greatest tolerance when the DNS service processes characters. Multibyte UTF-8 name checking is the preferred name-checking method for most privately operated DNS servers that aren't providing name service for Internet hosts.
