---
title: DNS zones in DNS Server on Windows Server
description: Learn about the different DNS zone types and how they're stored with DNS server in Windows Server.
author: robinharwood
ms.author: wscontent
ms.topic: conceptual
ms.date: 04/26/2023
ms.custom: template-concept, team=cloud_advocates
ms.contributors: orthomas
---

# DNS zones

A DNS zone is the specific portion of a DNS namespace that's hosted on a DNS server. A DNS zone
contains resource records, and the DNS server responds to queries for records in that namespace. For
example, the DNS server that's authoritative for resolving `www.contoso.com` to an IP address would
host the `contoso.com` zone.

DNS zone content can be stored in a file or in Active Directory Domain Services (AD DS). When the
DNS server stores the zone in a file:

- That file is in a local folder on the server.
- Only one copy of the zone is writable.
- Other copies, which are read-only, are referred to as secondary zones.

DNS zones stored in AD DS are known as Active Directory-integrated zones. Active
Directory-integrated zones are available only on domain controllers with the DNS Server role
installed.

## DNS zone types

The DNS Server service supports the following types of zone:

- Primary zone.
- Secondary zone.
- Stub zone.
- Reverse lookup zone.

### Primary zones

A DNS server hosting a primary zone is the primary source for information about this zone. It stores
the zone data in a local file or in AD DS. To create, edit, or delete resource records, you must use
the primary zone. Secondary zones are read-only copies of primary zones.

You can store a standard primary zone in a local file, or you can store zone data in AD DS. When you
store zone data in AD DS other features are available, such as secure dynamic updates and the
ability for each domain controller that hosts the zone to function as a primary and be able to process 
updates to the zone. When the zone is stored in a file, by default the primary zone file is named 
`zone_name.dns`, and it's located in the `%windir%\System32\Dns` folder on the server.

When you deploy Active Directory, a DNS zone that is associated with your organization’s AD DS domain name
is automatically created. By default the AD DS DNS zone replicates to any other domain controller
configured as a DNS server in the domain. You can also configure Active Directory Integrated DNS
zones to replicate to all domain controllers within an AD DS forest, or specific domain controllers
enrolled in a particular AD DS domain partition.

### Secondary zone

A secondary zone is a read-only copy of a primary zone. When a zone that this DNS server hosts is a
secondary zone, this DNS server is a secondary source for information about this zone. The zone at
this server must be obtained from another remote DNS server computer that also hosts the zone. This
DNS server must have network access to the remote DNS server that supplies this server with updated
information about the zone. Because a secondary zone is only a copy of a primary zone that is
hosted on another server, it can't be stored in AD DS as an Active Directory Integrated zone.

In most cases, a secondary zone periodically copies resource records directly from the primary zone.
But in some complex configurations, a secondary zone can copy resource records from another
secondary zone.

### Stub zone

A stub zone only contains information about the authoritative name servers for the zone. The zone
hosted by the DNS server must obtain its information from another DNS server that hosts the zone.
This DNS server must have network access to the remote DNS server to copy the authoritative name
server information about the zone.

You can use stub zones to:

- Keep delegated zone information current. The DNS server updates the stub records for its child
  zones regularly, the DNS server that hosts both the parent zone and the stub zone maintains a
  current list of authoritative DNS servers for the child zone.
- Improve name resolution. Stub zones enable a DNS server to perform recursion using the stub zone's
  list of name servers, without having to query the Internet or an internal root server for the DNS
  namespace.
- Simplify DNS administration. By using stub zones throughout your DNS infrastructure, you can
  distribute a list of the authoritative DNS servers for a zone without using secondary zones.
  However, stub zones don't serve the same purpose as secondary zones, and they aren't an
  alternative for enhancing redundancy and load sharing.

There are two lists of DNS servers involved in the loading and maintenance of a stub zone:

- The list of name servers from which the DNS server loads and updates a stub zone. A name server
  may be a primary or secondary DNS server for the zone. In both cases, it has a complete list of
  the DNS servers for the zone.
- The list of the authoritative DNS servers for a zone. This list is contained in the stub zone
  using name server (NS) resource records.

When a DNS server loads a stub zone, such as `widgets.tailspintoys.com`, it queries the name
servers, which can be in different locations, for the necessary resource records of the
authoritative servers for the zone `widgets.tailspintoys.com`. The list of name servers may contain
a single server or multiple servers, and it can be changed anytime.

A stub zone is a copy of a zone that contains only those resource records that are necessary to
identify the authoritative Domain Name System (DNS) servers for that zone. Typically, you use a stub
zone to resolve names between separate DNS namespaces.

When working with sub zones, you should consider:

- The stub zone can't be hosted on a DNS server that is authoritative for the same zone.
- If you integrate the stub zone into AD DS, you can specify if the DNS server hosting the stub zone
  uses a local list of name servers or the list stored in AD DS. If you want to use a local name
  servers list, you must have the IP addresses for each name server.

### Reverse lookup zones

In most Domain Name System (DNS) lookups, clients typically perform a forward lookup, which is a
search that is based on the DNS name of another computer as it is stored in a host (A) resource
record. This type of query expects an IP address as the resource data for the answered response.

DNS also provides a reverse lookup process, in which clients use a known IP address and look up a
computer name based on its address. A reverse lookup takes the form of a question, such as "Can you
tell me the DNS name of the computer that uses the IP address 192.168.1.20?"

The `in-addr.arpa` domain was defined in the DNS standards and reserved in the Internet DNS
namespace to provide a practical and reliable way to perform reverse queries. To create the reverse
namespace, subdomains within the `in-addr.arpa` domain are formed, using the reverse ordering of the
numbers in the dotted-decimal notation of IP addresses.

The `in-addr.arpa` domain applies to all TCP/IP networks that are based on Internet Protocol version
4 (IPv4) addressing. The New Zone Wizard automatically assumes that you're using this domain when
you create a new reverse lookup zone.

The order of IP address octets must be reversed when the `in-addr.arpa` domain tree is built. The IP
addresses of the DNS `in-addr.arpa` tree can be delegated to organizations as they're assigned a
specific or limited set of IP addresses within the Internet-defined address classes.

## Zone transfer settings

Zone transfers allow you to control the circumstances under which a secondary zone to be replicated
from a primary zone. To improve the security of your DNS infrastructure, allow zone transfers only
for either the DNS servers in the name server (NS) resource records for a zone or for specified DNS
servers. If you allow any DNS server to perform a zone transfer, you're allowing internal network
information to be transferred to any host that can contact your DNS server.

## Zone delegation

You can divide your Domain Name System (DNS) namespace into one or more zones. You can delegate
management of part of your namespace to another location or department in your organization by
delegating the management of the corresponding zone. For example, delegating the
`australia.contoso.com` zone from the `contoso.com` zone.

When you delegate a zone, remember that for each new zone that you create, you need delegation
records in other zones that point to the authoritative DNS servers for the new zone. Delegation
records are necessary both to transfer authority and to provide correct referral to other DNS
servers and clients of the new servers that are being made authoritative for the new zone.

## Next steps

- [Manage DNS zones using DNS server](manage-dns-zones.md)
- [DNS Policies Overview](deploy/DNS-Policies-Overview.md)
- [Anycast DNS overview](deploy/anycast.md)
