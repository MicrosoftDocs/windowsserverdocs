---
description: Learn more about DNS resource records in Windows Server
title: DNS resource records 
author: orrinthomas
ms.author: orrinthomas
ms.topic: article
ms.date: 06/01/2023
---
# DNS resource records

Applies to: Windows Server: (All supported versions)

DNS resource records contain the information that a zone maintains about the resources (such as hosts) that the zone contains. A typical resource record consists of the name (host) of the resource record owner, information about how long the resource record can remain in the cache, the resource record type (such as a host (A) resource record), and data that is specific to the record type (such as the host's address). You can add resource records directly, or they can be added automatically when Windows-based, Dynamic Host Configuration Protocol (DHCP)–enabled clients join a network—a process that is known as dynamic update.

## Types of resource records

The most common resource records include the following:

- Host (A) resource records: for mapping a Domain Name System (DNS) domain name to an IP address that is used by a computer.
- Alias (CNAME) resource records: for mapping an alias DNS domain name to another primary or canonical name.
- Mail exchanger (MX) resource records: for mapping a DNS domain name to the name of a computer that exchanges or forwards mail.
- Pointer (PTR) resource records: for mapping a reverse DNS domain name that is based on the IP address of a computer that points to the forward DNS domain name of that computer.
- Service location (SRV) resource records: for mapping a DNS domain name to a specified list of DNS host computers that offer a specific type of service, such as Active Directory domain controllers.
- Name server (NS) resource records: for specifying the authoritative name servers for a delegated DNS zone.
- Text (TXT) record. Allows for publication of text in a DNS record.
- Delegation name (DNAME) resource record: Alias for a name and all subnames.
- Start of authority (SOA) resource record. Provides authoritative information about a DNS zone. This includes primary name server, contact of DNZ zone administrator, refresh information and other information.

## Working with resource records and zones

Resource records can be added to an existing zone using the Add-DNSServerResourceRecord PowerShell cmdlet. Some common resource record types have additional PowerShell cmdlets where you do not need to specify the resource record type. You can also add some resource records using the DNS Manager console by right clicking on the DNS zone you wish to add the resource record to and selecting from one of the following options and completing the entries in the dialog box:

- New Host (A or AAAA)
- New Alias (CNAME)
- New Mail Exchanger (MX)
- New Domain
- New Delegation
- Other New Records

## Related links

- [Managing DNS resource records](managing-resource-records-how-to-powershell.md)