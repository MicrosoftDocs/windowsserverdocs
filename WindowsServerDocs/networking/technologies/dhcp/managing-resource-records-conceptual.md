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

Applies to: Windows Server: (All supported versions)

DNS resource records contain the information that a zone maintains about the resources (such as hosts) that the zone contains. A typical resource record consists of the name (host) of the resource record owner, information about how long the resource record can remain in the cache, the resource record type (such as a host (A) resource record), and data that's specific to the record type (such as the host's address). You can add resource records directly, or they can be added automatically when Windows-based, Dynamic Host Configuration Protocol (DHCP)–enabled clients join a network—a process that's known as dynamic update.

## Types of resource records

The most common resource records include the following:

- Host (A) resource records: For mapping a Domain Name System (DNS) domain name to an IP address that's used by a computer.
- Alias (CNAME) resource records: For mapping an alias DNS domain name to another primary or canonical name.
- Mail exchanger (MX) resource records: For mapping a DNS domain name to the name of a computer that exchanges or forwards mail.
- Pointer (PTR) resource records: For mapping a reverse DNS domain name that's based on the IP address of a computer that points to the forward DNS domain name of that computer.
- Service location (SRV) resource records: For mapping a DNS domain name to a specified list of DNS host computers that offer a specific type of service, such as Active Directory domain controllers.
- Name server (NS) resource records: For specifying the authoritative name servers for a delegated DNS zone.
- Text (TXT) record. Enables publication of text in a DNS record.
- Delegation name (DNAME) resource record: Alias for a name and all subnames.
- Start of authority (SOA) resource record. Provides authoritative information about a DNS zone. This includes primary name server, contact of DNZ zone administrator, refresh information, and other information.

## Working with resource records and zones

Resource records can be added to an existing zone using the Add-DNSServerResourceRecord PowerShell cmdlet. Some common resource record types have additional PowerShell cmdlets where you don't need to specify the resource record type. You can also add some resource records using the DNS Manager console by right-selecting on the DNS zone you want to add the resource record to and selecting from one of the following options and completing the entries in the dialog box. See [Managing DNS resource records](managing-resource-records-how-to-powershell.md) for detailed guidance on working with resource records, including procedures on creating and modifying existing resource records.

## Related links

- [Managing DNS resource records](managing-resource-records-how-to-powershell.md)