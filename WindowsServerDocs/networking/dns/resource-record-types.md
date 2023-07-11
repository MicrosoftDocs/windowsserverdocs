---
description: Learn more about DNS resource records using DNS Server on Windows Server.
title: DNS resource records using DNS server on Windows Server
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.topic: article
ms.date: 07/10/2023
---
# DNS resource records

DNS resource records contain the information that a zone maintains about the resources (such as
hosts) that the zone contains. A typical resource record consists of the:

- Name (host) of the resource record.
- Information about how long the resource record can remain in the cache.
- Resource record type, such as a host (A) resource record.
- Data that's specific to the record type, such as the host's IPv4 address.

You can add resource records directly, or they can be added automatically when Windows-based,
Dynamic Host Configuration Protocol (DHCP) enabled clients join a network using
dynamic update.

## Types of resource records

Common resource records include:

| Resource record type | Description |
| -- | -- |
| Host (A, AAAA) records | Maps a hostname to an IP address. |
| Alias (CNAME) records | Forward an alias domain name or subdomain to another primary or canonical name. Alias (CNAME) resource records are also termed canonical name resource records. With these records, you can use more than one DNS name to point to a single host. |
| Mail exchanger (MX) records | Specifies the name of a computer that exchanges or forwards mail. E-mail applications use the mail exchanger (MX) resource record to locate a mail server based on a DNS domain name in the destination address for the e-mail recipient of a message. If multiple mail exchanger (MX) resource records exist, the DNS Client service attempts to contact mail servers in the order of preference from lowest value (highest priority) to highest value (lowest priority). |
| Pointer (PTR) records | Used by reverse DNS lookups to map an IP address to domain. Pointer (PTR) resource records support the reverse lookup process, based on zones that are created and rooted in the `in-addr.arpa` domain. You need to have the appropriate reverse lookup zone present on your DNS server to create a PTR record that maps an IP address to a specific hostname. |
| Service location (SRV) records | Specifies the host, port and protocol for a service. Service location (SRV) resource records are required when clients use DNS to locate location services such as Active Directory domain controllers. |
| Name server (NS) records | Specifies the authoritative name servers for a domain. |
| Text (TXT) record | Enables the publication of text in a DNS record. Text records let you add text information that can be returned by querying DNS. TXT records are often used to authenticate ownership of DNS zones. |
| Delegation name (DNAME) record | Provides an alias for a domain, like a CNAME record, but includes all subdomains. |
| Start of authority (SOA) record | Provides authoritative information about a DNS zone. The SOA record includes primary name server, contact of DNZ zone administrator, refresh information, and other information. |

## Working with resource records and zones

Resource records can be added to an existing zone using the
[Add-DNSServerResourceRecord](/powershell/module/dnsserver/add-dnsserverresourcerecord) PowerShell
command. Some common resource record types have other PowerShell commands where you don't need to
specify the resource record type. You can also add resource records using the DNS Manager console.
See [Managing DNS resource records](manage-resource-records.md) for guidance on
working with resource records, including creating and modifying existing resource records of all
types.

## Next steps

- [Managing DNS resource records](manage-resource-records.md)
