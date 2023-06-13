---
description: Learn more about DNS resource records in Windows Server
title: DNS resource records 
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.topic: article
ms.date: 06/01/2023
---
# DNS resource records

DNS resource records contain the information that a zone maintains about the resources (such as
hosts) that the zone contains. A typical resource record consists of the:

- Name (host) of the resource record.
- Information about how long the resource record can remain in the cache.
- Resource record type, such as a host (A) resource record.
- Data that's specific to the record type, such as the host's address.

You can add resource records directly, or they can be added automatically when Windows-based,
Dynamic Host Configuration Protocol (DHCP)–enabled clients join a network—a process that's known as
dynamic update.

## Types of resource records

The most common resource records include:

- **Host (A, AAAA) records**: Maps a hostname to an IP address.
- **Alias (CNAME) records**: Forward an alias domain name or subdomain to another primary or
  canonical name.
- **Mail exchanger (MX) records**: Specifies the name of a computer that exchanges or forwards mail.
- **Pointer (PTR) records**: Used by reverse DNS lookups to map an IP address to domain.
- **Service location (SRV) records**: Specifies the host, port and protocol for a service, such as
  Active Directory domain controllers.
- **Name server (NS) records**: Specifies the authoritative name servers for a domain.
- **Text (TXT) record**. Enables the publication of text in a DNS record.
- **Delegation name (DNAME) record**: Provides an alias for a domain, like a CNAME record, but
  includes all subdomains.
- **Start of authority (SOA) record**. Provides authoritative information about a DNS zone. The SOA
  record includes primary name server, contact of DNZ zone administrator, refresh information, and
  other information.

## Working with resource records and zones

Resource records can be added to an existing zone using the
[Add-DNSServerResourceRecord](/powershell/module/dnsserver/add-dnsserverresourcerecord) PowerShell
command. Some common resource record types have other PowerShell commands where you don't need to
specify the resource record type. You can also add resource records using the DNS Manager console.
See [Managing DNS resource records](managing-resource-records-how-to-powershell.md) for guidance on
working with resource records, including creating and modifying existing resource records of all
types.

## Related links

- [Managing DNS resource records](managing-resource-records-how-to-powershell.md)