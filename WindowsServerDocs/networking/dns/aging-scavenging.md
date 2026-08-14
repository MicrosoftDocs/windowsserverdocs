---
title: DNS aging and scavenging in Windows Server
description: Learn how DNS aging and scavenging in Windows Server find and remove stale resource records, including terminology, intervals, and the record lifecycle.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 08/14/2026
ai-usage: ai-assisted
# Customer intent: As a DNS or AD DS administrator, I want to understand how aging and scavenging decide when a record is stale, so that I can enable them safely without deleting valid records.
---

# DNS aging and scavenging

DNS aging and scavenging are two DNS Server features in Windows Server that work together to find and remove stale dynamic resource records from zone data over time. A stale record is one that a client registered automatically but that stays in the zone after the client is gone.

With dynamic update, resource records are added to zones automatically, for example when computers join the network. But only an administrator or the aging and scavenging process removes these records. Without cleanup, stale records accumulate and cause name resolution problems.

Aging and scavenging apply to Active Directory–integrated zones too. Active Directory Domain Services (AD DS) uses multi-master replication to propagate record additions, timestamp updates, and scavenged deletions to the DNS servers that host the zone within its replication scope. Replication itself doesn't remove stale records, so you still need aging and scavenging to identify and remove them.

This article explains the terminology, intervals, and record lifecycle that aging and scavenging use to decide when a record is stale. Understanding these mechanics helps you enable the features with confidence, without deleting records that are still in use.

## Why stale records are a problem

With dynamic update, resource records are automatically added to zones when computers start on the network, but they aren't always removed when computers leave. For example, if a computer registers its host (A) resource record at startup and is later improperly disconnected from the network, its host (A) resource record might not be deleted. On networks with mobile users and computers, this situation can occur frequently.

If left unmanaged, stale resource records in zone data can cause the following problems:

- DNS servers with stale resource records might use outdated information to answer client queries, which causes clients to experience name resolution problems on the network.
- Many stale resource records can take up server disk space and cause long zone transfers.
- The accumulation of stale resource records can degrade the DNS server's performance and responsiveness.

> [!WARNING]
> By default, aging and scavenging are disabled for the DNS Server service. Enable them only after you fully understand all the parameters. Accidental misconfiguration can delete legitimate records, leaving users unable to resolve those DNS records.

## Aging and scavenging are independent mechanisms

Aging and scavenging are two independent but complementary mechanisms. You must enable both for automatic cleanup of stale records to occur.

### What aging does

Aging determines whether an incoming dynamic update can refresh the timestamp of a DNS record. Aging uses the no-refresh interval to decide whether a timestamp update is eligible. If a dynamic refresh arrives earlier than the record timestamp plus the no-refresh interval, the server discards it.

The DNS server distinguishes two kinds of records by their timestamp:

- **Dynamic records (timestamp isn't zero)**: Records added through dynamic update. The timestamp represents the date and hour of the last allowed refresh or update.
- **Static records (timestamp is zero)**: Records added manually or from a text-based zone file. The server assigns these records a timestamp of zero, so they aren't eligible for scavenging unless you later allow dynamic updates for the record, at which point the server can assign a timestamp during a subsequent update.

### What scavenging does

Scavenging deletes stale records. It considers only records that have a nonzero timestamp, so it can scavenge only dynamic records. Scavenging is optional, but when you enable it, it runs automatically and periodically.

Scavenging examines resource records and deletes the records that it identifies as stale. It determines the stale condition from the age that the aging process assigns to each record.

### Conditions for scavenging a record

Scavenging removes a record only when it meets all four of the following conditions:

- Scavenging is enabled on the DNS server (a server-level setting).
- Aging is enabled on the DNS zone where the record exists.
- The resource record is eligible (it has a nonzero timestamp).
- The record timestamp plus the no-refresh interval plus the refresh interval is earlier than the current server time.

Aging alone never deletes records; it only tracks timestamps. Scavenging runs automatically as scheduled even when aging is disabled, but it skips any zone that has aging disabled and takes no action on records in those zones, even records whose timestamps would otherwise mark them as stale. You must enable both aging and scavenging to clean up stale records automatically on a given zone.

## Terminology and intervals

The following terms apply when you discuss aging and scavenging.

| Term | Definition |
|---|---|
| Current server time | The current date and time on the DNS server. It serves as the reference point for all aging calculations. |
| No-refresh interval | The period after the server sets a record's timestamp, during which the server doesn't accept a timestamp refresh. This period reduces unnecessary replication traffic. The server acknowledges a same-data refresh as successful, but no database write occurs and the timestamp doesn't change. The server still writes updates that change record data. The default is 7 days. |
| Refresh interval | The period after the no-refresh interval during which the server accepts a refresh. If the record isn't refreshed before this period ends, it becomes stale. The default is 7 days. |
| Record refresh | A dynamic update that leaves the host name and IP address unchanged and revises only the timestamp. The server blocks refreshes during the no-refresh interval. |
| Record update | A dynamic update in which the record data changes, such as a new IP address. The server always accepts updates, even during the no-refresh interval, and they reset the timestamp. |
| Scavenging period | The interval between automatic scavenging operations on a DNS server. The default is 7 days and the minimum is 1 hour. It resets whenever the DNS service restarts. |
| Start scavenging time | A per-zone value that indicates when the zone first becomes eligible for scavenging. For the formula, see [When scavenging can start](#when-scavenging-can-start). |
| Resource record timestamp | The date and time value stamped on a record, to the nearest hour, by the aging process or manually by an administrator. Scavenging uses it to determine whether the record is stale. |
| Scavenging servers | An optional advanced zone parameter that configures which DNS server IP addresses can scavenge the zone. By default, every DNS server that hosts the zone can scavenge it. |
| dnsNode | An Active Directory object that represents a DNS name within an Active Directory–integrated zone. A `dnsNode` can contain one or more DNS records for the same host name. For example, a `dnsNode` object represents a host named `server1.contoso.com` and can contain A, AAAA, or other record types. |
| dnsRecord | The DNS record data stored within a `dnsNode` object, such as A, AAAA, CNAME, MX, and PTR records. Active Directory–integrated zones store record data, timestamps, and aging information as attributes of the `dnsNode` object. |
| dnsTombstoned | An Active Directory attribute that marks a `dnsNode` as logically deleted after scavenging, an administrator, or an authorized dynamic update removes its last record. The DNS Server service sets the attribute, and then AD DS replicates the tombstoned object before permanently removing it. |
| Active Directory replication scope | The setting that defines which DNS servers receive an Active Directory–integrated zone through AD DS replication. The zone can replicate to all DNS servers running on domain controllers in the domain or forest, or to all domain controllers in the domain for Windows 2000 compatibility. |
| Directory polling interval | The interval at which the DNS Server service polls Active Directory for changes that other domain controllers make. Polling lets the DNS server detect and load updates that replicated through Active Directory. |

### Stale record calculation

A record is stale and eligible for deletion by scavenging when the following condition is true:

*Record timestamp + no-refresh interval + refresh interval < current server time*

With default settings (7 days plus 7 days), a record that isn't refreshed within 14 days becomes stale. The actual deletion depends on when the next scavenging cycle runs, so a stale record can persist for up to the no-refresh interval plus the refresh interval plus the scavenging period, which is up to 21 days with all defaults.

## How aging and scavenging work

To understand the process, consider the life span and stages of a single resource record on a server and zone where aging and scavenging are enabled.

### Record lifecycle

The following steps describe the complete life of a dynamically registered record on a DNS server and zone where aging and scavenging are enabled:

1. **The record is created.** A host, such as `host-a.example.contoso.com`, registers its host (A) resource record with the DNS server. The server stamps the record with the current server time, to the nearest hour.

1. **The record lives without updates.** Immediately after registration, the no-refresh interval starts. During this interval, the server suppresses refresh attempts for the record, which reduces Active Directory replication traffic. The server still accepts updates that change record data, such as a new IP address, and each update resets the record timestamp.

1. **The refresh window opens.** After the no-refresh interval expires, the refresh interval begins and the server accepts refreshes. When the server processes a refresh, it resets the timestamp and the no-refresh interval starts again.

1. **The record becomes stale.** If the record isn't refreshed during the refresh interval, it becomes stale. The record remains in the zone until the next scavenging cycle runs.

1. **The record is scavenged.** During scavenging, the server examines every record in the zone. For each record, the server compares the current server time to the following sum:

   *Record timestamp + no-refresh interval + refresh interval*

   - If the sum is greater than the current server time, the server takes no action and the record keeps aging in the zone.
   - If the sum is less than the current server time, the server removes the record from the zone data in server memory. For a directory-integrated zone, the server writes the deletion to AD DS, which replicates it to the other DNS servers that host the zone so they remove their copies of the record.

The following diagram shows the lifecycle of a resource record through the no-refresh interval, refresh interval, stale state, and scavenging.

:::image type="content" source="../media/aging-scavenging/aging-scavenging-process.png" alt-text="Timeline diagram tracing a DNS record from registration through the no-refresh and refresh intervals to the stale state and scavenging deletion.":::

### When scavenging can start

Scavenging can start for a zone when the current server time is greater than the zone's start scavenging time. The server sets the start scavenging time for each zone whenever any of the following events occur:

- You enable dynamic updates for the zone.
- The **Scavenge stale resource records** checkbox state changes.
- The DNS Server service starts and loads a scavenging-enabled primary zone.
- A zone resumes service after a pause.

After you enable aging on a zone, the zone gets one refresh interval of scavenging protection before it becomes eligible for scavenging.

The server calculates the start scavenging time as:

*Current server time (rounded down to the nearest hour) + refresh interval*

### Behavior in Active Directory–integrated zones

In an Active Directory–integrated zone, the server stores zone data in AD DS and replicates it through Active Directory rather than in a local text-based zone file. AD DS stores all resource records for the same name, such as the A and AAAA records for `host.contoso.com`, in a single `dnsNode` object as values of its multi-valued `dnsRecord` attribute.

Scavenging and tombstoning are distinct operations:

- **Scavenging** removes stale `dnsRecord` values. When the server scavenges a stale record, it removes the corresponding `dnsRecord` value. If other records remain for that name, the `dnsNode` object remains.
- **Tombstoning** is the Active Directory deletion state for the `dnsNode` object after its last record is gone. When the server removes the final record, the DNS Server service sets `dnsTombstoned` to `TRUE`, AD DS replicates the logical deletion so that other DNS servers hosting the zone stop loading the node, and normal directory cleanup removes the object later.

The server uses standard zone transfers (AXFR or IXFR) only when you configure an Active Directory–integrated zone to serve a conventional, non-integrated secondary DNS server. Otherwise, zone data propagates only through Active Directory replication.

### Why we recommend one scavenging server per zone

Enable server-level scavenging on only one DNS server per zone. Don't configure multiple scavenging servers per zone because:

- Scavenging events and audit data spread across multiple servers.
- Different scavenging schedules make deletions harder to predict and trace.
- Replication or configuration issues become more difficult to troubleshoot.

Use the `ScavengingServers` zone parameter to restrict which DNS server IP addresses can scavenge the zone. You can configure multiple servers for redundancy, but they're generally unnecessary.

## Related content

- [Configure DNS aging and scavenging](configure-aging-scavenging.md)
