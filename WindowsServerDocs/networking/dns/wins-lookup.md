---
title: DNS WINS Lookup Integration in Windows Server
description: Learn about DNS WINS lookup integration, WINS resource records, how WINS lookup works, and how WINS reverse lookup works in Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 02/13/2025
ai-usage: ai-assisted # Used for image alt text
---

# DNS WINS lookup integration

Windows Internet Name Service (WINS) is a legacy computer name registration and resolution service that maps computer NetBIOS names to IP addresses. Support for using Windows Internet Name Service (WINS) is provided to look up DNS names that the DNS domain namespace can't resolve. To accomplish WINS lookup using the DNS server role on Windows Server, two specific resource record types are used to and can be enabled for any zones loaded by the DNS service:

- The WINS resource record, which can be enabled to integrate WINS lookup into forward lookup zones

- The WINS-R resource record, which can be enabled to integrate node adapter status request for reverse lookup zones

> [!TIP]
> If you have already deployed WINS on your network, it is recommended that you completely migrate your network to use DNS exclusively.

## WINS resource record

The WINS and DNS services are used to provide name resolution for the NetBIOS namespace and the DNS domain namespace, respectively. Although both DNS and WINS can provide a separate and useful name service to clients, WINS is needed to provide support for older clients and programs that require support for NetBIOS naming.

However, the DNS service can work with WINS to provide combined name searches in both namespaces when resolving a DNS domain name not found in zone information. To provide this interoperability, a new record (the WINS record) is defined as part of the zone database file.

The presence of a WINS resource record can instruct the DNS service to use WINS to look up any forward queries for host names or names that aren't found in the zone database. This functionality is useful for name resolution required by clients that aren't WINS-aware. For example, the names of computers not registered with DNS, such as UNIX or legacy Windows clients.

## Lookups

The following diagram is an example of a DNS client querying its DNS server in an attempt to look up the address for another computer.

:::image type="content" source="../media/wins-lookup/lookup-process-using-wins.png" alt-text="Diagram that shows the DNS resolution process with a preferred DNS server, other DNS servers, and a WINS server.":::

In step 1, the client queries its preferred DNS server. In steps 2 through 8, the normal process of recursion proceeds as the preferred DNS server queries other DNS servers in succession on behalf of the client. This process concludes at step 8, when the DNS server for the `example.contoso.com` zone is located through the previous chain of referral answers.

When the DNS server for the `example.contoso.com` zone receives the query for the host, it looks in its configured zone to see if a matching address (A) resource record can be found. If no A record is found and the zone is enabled to use WINS lookup, the  DNS server separates the host part of the name from the fully qualified domain name contained in the DNS query.

The host part of the name is the first label in the queried DNS domain name before a period is used in the name.

- The server then sends a NetBIOS name request to the WINS server using the host name.

- If the WINS server can resolve the name, it returns the IP address to the DNS server.

- The DNS server then compiles an A resource record using the IP address resolved through the WINS server. It returns this record to the original preferred DNS server that the client queried.

- The preferred DNS server then passes the query answer back to the requesting client.

## Reverse lookups

A WINS-R record or WINS reverse lookup entry can be enabled and added to reverse lookup zones. However, because the WINS database isn't indexed using IP address, the DNS service can't send a reverse name lookup to WINS to get the name of a computer given its IP address.

Because WINS doesn't provide reverse lookup capability, the DNS service instead sends a node adapter status request directly to the IP address implied in the DNS reverse query. When the DNS server gets the NetBIOS name from the node status response, it appends the DNS domain name back onto the NetBIOS name provided in the node status response and forwards the result to the requesting client.

> [!NOTE]
> WINS and WINS-R resource records are proprietary to the DNS Server service provided by Windows. You can prevent these resource records from being included in zone transfers to other DNS server implementations.
