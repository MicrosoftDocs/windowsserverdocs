---
title: DNS aging and scavenging in Windows Server
description: Learn about DNS processes, including client-server communications for query resolution, dynamic updates, and zone administration in Windows and Windows Server.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 01/31/2025

---

# DNS aging and scavenging

DNS servers running Windows Server 2008 support aging and scavenging features. These features are provided as a mechanism for performing cleanup and removal of stale resource records, which can accumulate in zone data over time.

With dynamic update, RRs are automatically added to zones when computers start on the network. However, in some cases, they aren't automatically removed when computers leave the network. For example, if a computer registers its own host (A) RR at startup and is later improperly disconnected from the network, its host (A) RR might not be deleted. If your network has mobile users and computers, this situation can occur frequently.

If left unmanaged, the presence of stale RRs in zone data might cause some problems. The following are examples:

- If a large number of stale RRs remains in server zones, they can eventually take up server disk space and cause long zone transfers.
- DNS servers loading zones with stale RRs might use outdated information to answer client queries, potentially causing the clients to experience name resolution problems on the network.
- The accumulation of stale RRs at the DNS server can degrade its performance and responsiveness.
- In some cases, the presence of a stale RR in a zone could prevent a DNS domain name from being used by another computer or host device.

To solve these problems, the DNS Server service has the following features:

- Time stamping, based on the current date and time set at the server computer, for any RRs added dynamically to primary-type zones. In addition, time stamps are recorded in standard primary zones where aging/scavenging is enabled.
- For RRs that you add manually, a time stamp value of zero is used, indicating that they aren't affected by the aging process and can remain without limitation in zone data unless you otherwise change their time stamp or delete them.
- Aging of RRs in local data, based on a specified refresh time period, for any eligible zones. Only primary type zones that are loaded by the DNS Server service are eligible to participate in this process.
- Scavenging for any RRs that persist beyond the specified refresh period. When a DNS server performs a scavenging operation, it can determine that RRs have aged to the point of becoming stale and remove them from zone data. Servers can be configured to perform recurring scavenging operations automatically, or you can initiate an immediate scavenging operation at the server.

> [!NOTE]
> Information the user should notice even if skimmingBy default, the aging and scavenging mechanism for the DNS Server service is disabled. It should only be enabled when all parameters are fully understood. Otherwise, the server could be accidentally configured to delete records that shouldn't be deleted. If a record is accidentally deleted, not only will users fail to resolve queries for that record, but any user can create the record and take ownership of it, even on zones configured for secure dynamic update.

The server uses the contents of each RR-specific time stamp, along with other aging and scavenging properties that you can adjust or configure, to determine when it scavenges records.

## Prerequisites for aging and scavenging

Before the aging and scavenging features of DNS can be used, several conditions must be met:

- Scavenging and aging must be enabled both at the DNS server and on the zone.

By default, aging and scavenging of resource records is disabled.

- Resource records must either be dynamically added to zones or manually modified to be used in aging and scavenging operations.

Typically, only those resource records added dynamically using the DNS dynamic update protocol are subject to aging and scavenging.

You can, however, enable scavenging for other resource records added through nondynamic means. For records added to zones in this way, either by loading a text-based zone file from another DNS server or by manually adding them to a zone, a time stamp of zero is set. This makes these records ineligible for use in aging and scavenging operations.

In order to change this default, you can administer these records individually, to reset and permit them to use a current (nonzero) time stamp value. This enables these records to become aged and scavenged.

> [!NOTE]
> Information the user should notice even if skimmingIn the case of changing a zone from standard primary to Active Directory–integrated, you might want to enable scavenging of all existing resource records in the zone. To enable aging for all existing resource records in a zone, you can use the **AgeAllRecords command**, which is available through the dnscmd command-line tool.

## Aging and scavenging terminology

The following list indicates new or revised terms that have been introduced to help specifically when discussing aging and scavenging.

- **Current server time** The current date and time on the DNS server. This number can be expressed as an exact numeric value at any point in time.
- **No-refresh interval** An interval of time, determined for each zone, as bounded by the following two events:
  
  - - The date and time when the record was last refreshed and its time stamp set.
  - The date and time when the record next becomes eligible to be refreshed and have its time stamp reset.

This value is needed to decrease the number of write operations to the Active Directory database. By default, this interval is set to 7 days. It shouldn't be increased to an unreasonably high level, because the benefits of the aging and scavenging feature might either be lost or diminished.

- **Record refresh** When a DNS dynamic update is processed for a resource record when only the resource record time stamp, and no other characteristics of the record, are revised. Refreshes generally occur for the following reasons:

  - When a computer is restarted on the network and, if at startup, its name and IP address information are consistent with the same name and address information it used prior to being shut down, it sends a refresh to renew its associated resource records for this information.
  - A periodic refresh is sent by the computer while it's running.
  - The Windows XP and Windows Server 2008 DNS Client service renews DNS registration of client resource records every 24 hours. When this dynamic update occurs, if the dynamic update request doesn't cause modification to the DNS database, then it's considered to be a refresh and not a resource record update.
  - Other network services make refresh attempts, such as DHCP servers, which renew client address leases; cluster servers, which register and update records for a cluster; and the Net Logon service, which can register and update resource records used by Active Directory domain controllers.

- **Record update** When a DNS dynamic update is processed for a resource record where other characteristics of the record in addition to its time stamp are revised. Updates generally occur for the following reasons:

  - When a new computer is added to the network and, at startup, it sends an update to register its resource records for the first time with its configured zone.
  - When a computer with existing records in the zone has a change in IP address, causing updates to be sent for its revised name-to-address mappings in DNS zone data.
  - When the Net Logon service registers a new Active Directory domain controller.

- **Refresh interval** An interval of time, determined for each zone, as bounded by the following two distinct events:

  - The earliest date and time when the record becomes eligible to be refreshed and have its time stamp reset.
  - The earliest date and time when the record becomes eligible to be scavenged and removed from the zone database.

This value should be large enough to allow all clients to refresh their records. By default, this interval is set to seven days. It shouldn't be increased to an unreasonably high level, because the benefits of the aging and scavenging feature might either be lost or diminished.

- **Resource record time stamp** A date and time value used by the DNS server to determine removal of the resource record when it performs aging and scavenging operations.

- **Scavenging period** When automatic scavenging is enabled at the server, this period represents the time between repetitions of the automated scavenging process. The default value for this is seven days. To prevent deterioration of DNS server performance, the minimum allowed value for this is one hour.

- **Scavenging servers** An optional advanced zone parameter that enables you to specify a restricted list of IP addresses for DNS servers that are enabled to perform scavenging of the zone. By default, if this parameter isn't specified, all DNS servers that load a directory-integrated zone (also enabled for scavenging) attempt to perform scavenging of the zone. In some cases, this parameter can be useful if it's preferable that scavenging only be performed at some servers loading the directory-integrated zone. To set this parameter, you must specify the list of IP addresses for the servers enabled to scavenge the zone in the ScavengingServers parameter for the zone. This can be done using the dnscmd command, a command-line based tool for administering Windows DNS servers.

- **Start scavenging time** A specific time, expressed as a number. This time is used by the server to determine when a zone becomes available for scavenging.

## When scavenging can start

After all prerequisites for enabling the use of scavenging are met, scavenging can start for a server zone when the current server time is greater than the value of the start scavenging time for the zone.

The server sets the time value to start scavenging on a per-zone basis whenever any one of the following events occurs:

- Dynamic updates are enabled for the zone.
- A change in the state of the **Scavenge stale resource records** check box is applied. You can use the DNS console to modify this setting at either an applicable DNS server or one of its primary zones.
- The DNS server loads a primary zone enabled to use scavenging. This can occur when the server computer is started or when the DNS Server service is started.
- When a zone resumes service after having been paused.

When any of the previous events occur, the DNS server sets the value of start scavenging time by calculating the following sum:

Current server time + Refresh interval = Start scavenging time

This value is used as a basis of comparison during scavenging operations.

## Example of the aging and scavenging process for a sample record

To understand the process of aging and scavenging at the server, consider the life span and successive stages of a single resource record, as it's added to a server and zone where this process is in effect and then aged and removed from the database. This includes the following steps:

1. A sample DNS host, “host-a.example.contoso.com”, registers its host (A) RR at the DNS server for a zone where aging/scavenging is enabled for use.
1. When registering the record, the DNS server places a time stamp on this record based on current server time.

After the record time stamp is written, the DNS server doesn't accept refreshes for this record during the zone no-refresh interval. It can, however, accept updates prior to that time. For example, if the IP address for “host-a.example.contoso.com” changes, the DNS server can accept the update. In this case, the server also updates (resets) the record time stamp.

1. Upon expiration of the no-refresh period, the server begins to accept attempts to refresh this record.

After the initial no-refresh period ends, the refresh period immediately begins for the record. During this time, the server doesn't suppress attempts to refresh the record for its remaining life span.

1. During and after the refresh period, if the server receives a refresh for the record, it processes it.

This resets the time stamp for the record based on the method described in step 2.

1. When subsequent scavenging is performed by the server for the “example.contoso.com” zone, the records (and all other zone records) are examined by the server.

Each record is compared to current server time based on the following sum to determine whether the record should be removed:

Record time stamp + **No-refresh interval** for zone + **Refresh interval** for zone

- If the value of this sum is greater than current server time, no action is taken and the record continues to age in the zone.
- If the value of this sum is less than current server time, the record is deleted both from any zone data currently loaded in server memory and also from the applicable DnsZone object store in Active Directory for the directory-integrated “example.contoso.com” zone.
