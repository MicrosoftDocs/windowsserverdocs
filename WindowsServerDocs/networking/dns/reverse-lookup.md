---
title: DNS Reverse Lookups in Windows and Windows Server
description: Learn about DNS reverse lookups in Windows Server and how reverse lookup works with the in-addr.arpa domain.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 02/13/2025
---

# Reverse lookup

In most DNS lookups, clients typically perform a forward lookup, which is a search based on the DNS name of another computer as stored in an address (A) RR. This type of query expects an IP address as the resource data for the answered response.

DNS also provides a reverse lookup process, enabling clients to use a known IP address during a name query and to look up a computer name based on its address. A reverse lookup takes the form of a question, such as “Can you tell me the DNS name of the computer that uses the IP address 192.168.1.20?”

## How reverse lookup works

A special domain called the `in-addr.arpa` domain was defined in the DNS standards. This domain is reserved in the Internet DNS namespace to provide a practical and reliable way to perform reverse queries.  To create the reverse namespace, subdomains within the `in-addr.arpa` domain are formed using the reverse ordering of the numbers in the dotted-decimal notation of IP addresses.

When IP addresses are read from left to right, they're interpreted in the opposite manner compared to DNS names. This reversed ordering of the domains for each octet value is necessary. When reading an IP address from left to right, it starts with the network address and ends with the host address. 
For this reason, the order of IP address octets must be reversed when building the `in-addr.arpa` domain tree. The IP addresses of the DNS `in-addr.arpa` tree can be delegated to companies as they're assigned a specific or limited set of IP addresses within the Internet-defined address classes.

Finally, the in-addr.arpa domain tree, as built into DNS, requires that another RR type, the pointer (PTR) RR, be defined. This RR is used to create a mapping in the reverse lookup zone that typically corresponds to a host (A) named RR for the DNS computer name of a host in its forward lookup zone.

The in-addr.arpa domain applies for use in all TCP/IP networks that are based on Internet Protocol version 4 (IPv4) addressing. The New Zone Wizard automatically assumes that you're using this domain when creating a new reverse lookup zone.

If you're configuring reverse lookup zones for an Internet Protocol version 6 (IPv6) network, you can specify an exact name using the New Zone Wizard. This permits you to create reverse lookup zones in the DNS console that can be used to support IPv6 networks. IPv6 zones use a different special domain name, the `ip6.arpa` domain.

For information about IPv6 and DNS, including examples of how to create and use `ip6.arpa` domain names as described in RFC 1886 (“DNS Extensions to support IP version 6”), see [DNS Reference Information](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd197499(v=ws.10)).

> [!NOTE]
> The configuration of PTR RRs and reverse lookup zones for identifying hosts by reverse query is strictly an optional part of the DNS standard implementation. You aren't required to use reverse lookup zones, although for some networked applications, they're used to perform security checks.

### Example: IPv4 Reverse query

The following figure shows an example of a reverse query initiated by a DNS client (host-b) to learn the name of another host (host-a) based on its IP address, 192.168.1.20.

:::image type="content" source="../media/reverse-lookup/reverse-query.png" alt-text="Diagram that shows a reverse query initiated by a DNS client to learn the name of another host based on its IP address.":::

The reverse query process as shown in this figure occurs in the following steps:

1. The client, `host-b`, queries the DNS server for a pointer (PTR) RR that maps to the IP address of 192.168.1.20 for `host-a`.

   Because the query is for PTR records, the resolver reverses the address and appends the `in-addr.arpa` domain to the end of the reverse address. This query forms the fully qualified domain name (`20.1.168.192.in-addr.arpa.`) to be searched in a reverse lookup zone.

1. After the record is located, the authoritative DNS server for `20.1.168.192.in-addr.arpa` can respond with the PTR record information. This response includes the DNS domain name for `host-a`, completing the reverse lookup.

   If the queried reverse name isn't answerable from the DNS server, normal DNS resolution (either recursion or iteration) can be used to locate a DNS server that is authoritative for the reverse lookup zone and that contains the queried name. In this sense, the name resolution process used in a reverse lookup is identical to that of a forward lookup.
