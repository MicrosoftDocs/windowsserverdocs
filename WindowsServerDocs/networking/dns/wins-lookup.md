---
title: DNS WINS lookup integration in Windows Server
description: Learn about DNS processes, including client-server communications for query resolution, dynamic updates, and zone administration in Windows and Windows Server.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 01/29/2025

---

# DNS WINS lookup integration

Support for using Windows Internet Name Service (WINS) is provided to look up DNS names that can't be resolved by querying the DNS domain namespace. To accomplish WINS lookup, two specific resource record types are used to and can be enabled for any zones loaded by the DNS service:

- The WINS RR, which can be enabled to integrate WINS lookup into forward lookup zones
- The WINS-R RR, which can be enabled to integrate node adapter status request for reverse lookup zones

## WINS resource record

The WINS and DNS services are used to provide name resolution for the NetBIOS namespace and the DNS domain namespace, respectively. Although both DNS and WINS can provide a separate and useful name service to clients, WINS is needed to provide support for older clients and programs that require support for NetBIOS naming.

However, the DNS service can work with WINS to provide combined name searches in both namespaces when resolving a DNS domain name not found in zone information. To provide this interoperability, a new record (the WINS record) was defined as part of the zone database file.

The presence of a WINS RR can instruct the DNS service to use WINS to look up any forward queries for host names or names that aren't found in the zone database. This functionality is useful for name resolution required by clients that aren't WINS-aware (for example, UNIX) for the names of computers not registered with DNS, such as Windows 95 or Windows 98 computers.

## How WINS lookup works

The following is an example of a DNS client (host-b) querying its DNS server in an attempt to look up the address for another computer named “host-a.example.contoso.com.”

:::image type="content" source="../media/dns-processes-interactions/dns-processes-interactions-8.png" alt-text="Diagram showing overview of complete DNS query process.":::

In step 1, the client queries its preferred DNS server. In steps 2 through 8, the normal process of recursion proceeds as the preferred DNS server queries other DNS servers in succession on behalf of the client. This process concludes at step 8, when the DNS server for the example.contoso.com zone is located through the previous chain of referral answers.

When the DNS server for the example.contoso.com zone receives the query for host-a, it looks in its configured zone to see if a matching address (A) RR can be found. If no A record is found and the zone is enabled to use WINS lookup, the server does the following:

- The DNS server separates the host part of the name (host-a) from the fully qualified domain name contained in the DNS query.

The host part of the name is the first label in the queried DNS domain name before a period is used in the name.

- The server then sends a NetBIOS name request to the WINS server using the host name, host-a.
- If the WINS server can resolve the name, it returns the IP address to the DNS server.
- The DNS server then compiles an A RR using the IP address resolved through the WINS server and returns this record to the original preferred DNS server that was queried by the requesting client, host-b.
- The preferred DNS server then passes the query answer back to the requesting client.

## How WINS reverse lookup works

There is also a WINS-R record or WINS reverse lookup entry that can be enabled and added to reverse lookup zones. However, because the WINS database isn't indexed by IP address, the DNS service can't send a reverse name lookup to WINS to get the name of a computer given its IP address.

Because WINS doesn't provide reverse lookup capability, the DNS service instead sends a node adapter status request directly to the IP address implied in the DNS reverse query. When the DNS server gets the NetBIOS name from the node status response, it appends the DNS domain name back onto the NetBIOS name provided in the node status response and forwards the result to the requesting client.

> [!NOTE]
> Information the user should notice even if skimmingWINS and WINS-R RRs are proprietary to the DNS Server service provided by Windows. You can prevent these resource records from being included in zone transfers to other DNS server implementations.
