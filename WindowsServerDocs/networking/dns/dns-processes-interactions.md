---
title: DNS processes and interactions
description: Learn about DNS processes and interactions in Windows Server 
ms.topic: conceptual
author: gswashington
ms.author: nedpyle
ms.date: 02/14/2024

---
<!-- Hi Heidi -- this one is still in progress. Give me a few minutes, thanks!
 -->
# DNS processes and interactions

>Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016

DNS processes and interactions involve the communications between DNS clients and DNS servers during the resolution of DNS queries and dynamic update, and between DNS servers during name resolution and zone administration. Secondary processes and interactions depend on the support for technologies such as Unicode and WINS.

## How DNS queries work

When a DNS client needs to look up a name used in a program, it queries DNS servers to resolve the name. Each query message the client sends contains three pieces of information, specifying a question for the server to answer:

- A specified DNS domain name, stated as a fully qualified domain name (FQDN).
- A specified query type, which can either specify a resource record (RR) by type or a specialized type of query operation.
- A specified class for the DNS domain name. For DNS servers running the Windows operating system, this should always be specified as the Internet (IN) class.

For example, the name specified could be the FQDN for a computer, such as “host-a.example.microsoft.com.”, and the query type specified to look for an address (A) RR by that name. Think of a DNS query as a client asking a server a two-part question, such as “Do you have any A resource records for a computer named ‘hostname.example.microsoft.com.’?” When the client receives an answer from the server, it reads and interprets the answered A RR, learning the IP address for the computer it asked for by name.

The following table describes common DNS query types and corresponding IDs.

| Type | ID |
| --- | --- |
| A | 1 |
| AAAA | 28 |
| SOA | 6 |
| SRV | 33 |

##

DNS queries resolve in a number of different ways. A client can sometimes answer a query locally using cached information obtained from a previous query. The DNS server can use its own cache of resource record information to answer a query. A DNS server can also query or contact other DNS servers on behalf of the requesting client to fully resolve the name, and then send an answer back to the client. This process is known as recursion.

In addition, the client itself can attempt to contact additional DNS servers to resolve a name. When a client does so, it uses separate and additional queries based on referral answers from servers. This process is known as iteration. .( 

In general, the DNS query process occurs in two parts:

- A name query begins at a client computer and is passed to a resolver, the DNS Client service, for resolution.
- When the query cannot be resolved locally, DNS servers can be queried as needed to resolve the name.

Each of these processes are explained in more detail in the following sections.

### DNS Client service resolver 

