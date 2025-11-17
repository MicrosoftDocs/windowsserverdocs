---
title: DNS Forwarding in Windows Server
description: Learn about DNS forwarding, including delegation, conditional forwarders, and intranet name resolution in Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 02/13/2025
ai-usage: ai-assisted # Used for image alt text
---

# DNS Forwarding

A forwarder is a DNS server on a network used to forward DNS queries for external DNS names to DNS servers outside of that network. You can also forward queries according to specific domain names using conditional forwarders. In this article learn about DNS forwarding, including delegation, conditional forwarders, and intranet name resolution in Windows Server.

## Forwarding

A DNS server on a network is designated as a forwarder by having the other DNS servers answer queries they can't resolve locally to that DNS server. By using a forwarder, you can manage name resolution for names outside of your network, such as names on the Internet, and improve the efficiency of name resolution for the computers in your network.

The following figure illustrates how external name queries are directed using forwarders.

:::image type="content" source="../media/forwarding/dns-forwarding.png" alt-text="A diagram showing the flow of DNS queries from internal DNS servers to external DNS servers through a forwarder.":::

If you don't set a specific DNS server as a forwarder, DNS servers use root hints to send queries outside the network. This configuration can expose internal DNS information to the Internet, leading to security and privacy risks. It can also create lots of external traffic, which is inefficient for networks with slow Internet connections or expensive for companies with high Internet costs.

When you designate a DNS server as a forwarder, you make that forwarder responsible for handling external traffic, limiting DNS server exposure to the Internet. A forwarder builds up a large cache of external DNS information because all of the external DNS queries in the network are resolved through it. In a short amount of time, a forwarder resolves most external DNS queries using cached data. Meaning a decrease in Internet traffic over the network and the response time for DNS clients.

### Behavior

A DNS server configured to use a forwarder behaves differently from a DNS server that isn't configured to use a forwarder. A DNS server configured to use a forwarder behaves as follows:

1. When the DNS server receives a query, it attempts to resolve this query using the primary and secondary zones that it hosts and its cache.

1. If the query can't be resolved using this local data, then it forwards the query to the DNS server designated as a forwarder.

1. The DNS server waits briefly for an answer from the forwarder before attempting to contact the DNS servers specified in its root hints.

When a DNS server forwards a query to a forwarder, it sends a recursive query to the forwarder. This type of query is different from the iterative query that a DNS server sends to another DNS server during standard name resolution. Meaning, name resolution that doesn't involve a forwarder.

### Forwarding sequence

A DNS server uses forwarders based on the order in which the IP addresses are listed on the DNS server. After the DNS server forwards the query to the forwarder with the first IP address, it waits a short period for an answer from that forwarder (according to the DNS server’s time-out setting) before resuming the forwarding operation with the next IP address. It continues this process until it receives an affirmative answer from a forwarder.

The forwarder a DNS Server uses depends on the server’s configuration. By default, _Dynamic Forwarder Reordering_ is enabled, if the default is kept, the DNS server uses following the forwarders list:

1. The DNS Server allows administrators to create forwarders in a preferred order.

1. A dynamic list of forwarders is maintained. The dynamic list gets reordered based on the response times. But the list also gets reset to the configured order approximately every 15 minutes.

1. For each query, forwarders are picked as they appear in the dynamic list.

1. If the response time is greater than 1 second, it's considered a slow response. Each forwarder is allowed two consecutive slow responses, on the third slow response it's moved to the end of the dynamic list.

1. If all the servers in the list go don't respond, then DNS has no way to know if the server is offline or slow. Monitoring the availability of each DNS server would need to be done outside the system.

> [!TIP]
> Beginning with Windows Server 2022, if no forwarder responds from the list of forwarders, the DNS server uses only the first one on the dynamic list until the DNS server service restarts.

## Forwarders and delegation

A DNS server configured with a forwarder and hosting a parent zone uses its delegation information before forwarding queries. If no delegation record exists for the DNS name in the query, then the DNS server uses its forwarders to resolve the query.

## Forwarders and root servers

In order for the DNS server to do recursion properly, it first needs some helpful contact information about other DNS servers in the DNS domain namespace. This information is provided in the form of root hints. Root hints are a list of preliminary resource records that the DNS service uses to locate other DNS servers that are authoritative for the root of the DNS domain namespace tree. Root servers are authoritative for the domain root and top-level domains in the DNS domain namespace tree.

By using root hints to find root servers, a DNS server is able to complete the use of recursion. In theory, this process enables any DNS server to locate the servers that are authoritative for any other DNS domain name used at any level in the namespace tree.

Root servers can't be configured with standard forwarding. If a root server is queried about any domain name, it responds in one of two ways. It either refers to a DNS server that can answer the question (from its local zones, cache), or it responds with a failure. A failure response is shown with a `NXDOMAIN` answer. It  can't be configured to forward to specific servers. A common error when configuring forwarding is to attempt to configure forwarding on the root servers of a private DNS namespace.

A root server can be configured with a conditional forwarder. Conditional forwarding can be used to forward queries between root servers in separate DNS namespaces, although the DNS servers for the top-level domains in the namespace are better suited for this method of resolution.

## Conditional forwarders

A conditional forwarder is a DNS server on a network that is used to forward DNS queries according to the DNS domain name in the query. For example, a DNS server can be configured to forward all the queries it receives for names ending with `north.contoso.com` to the IP address of a DNS server or to the IP addresses of multiple DNS servers.

### Intranet name resolution

A conditional forwarder can be used to improve name resolution for domains within your intranet. Intranet name resolution can be improved by configuring DNS servers with forwarders for specific internal domain names. For example, all DNS servers in the domain `north.contoso.com` could be configured to forward queries for names that end with `south.contoso.com` to the authoritative DNS servers for `south.contoso.com`, removing the step of querying the root servers of `.contoso.com`, or removing the step of configuring DNS servers in the `north.contoso.com` zone with secondary zones for `south.contoso.com`.

### Internet name resolution

DNS servers can use conditional forwarders to resolve queries between the DNS domain names of companies that share information. For example, two companies, Contoso and Tailspin Toys, want to improve how the DNS clients of Contoso resolve the names of Tailspin Toys' servers. The administrators from Tailspin Toys inform the administrators of Contoso about the set of DNS servers in the Tailspin Toys network where Contoso can send queries for the domain `outdoor.tailspintoys.com`. The DNS servers within the Contoso network are configured to forward all queries for names ending with `outdoor.tailspintoys.com` to the designated DNS servers in the network for Tailspin Toys. So, the DNS servers in the Contoso network don't need to query their internal root servers, or the Internet root servers to resolve queries for names ending with `outdoor.tailspintoys.com`.
