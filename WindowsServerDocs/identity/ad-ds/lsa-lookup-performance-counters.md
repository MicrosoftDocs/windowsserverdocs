---
title: Active Directory LSA Lookup performance counters
description: Learn about Active Directory LSA Lookup performance counters
ms.topic: conceptual
author: gswashington
ms.author: wscontent
ms.date: 05/31/2024

---

# Active Directory LSA Lookup performance counters

Applies to: Windows Server 2025 (preview)

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Beginning with Windows Server 2025, you can use Local Security Authority (LSA) performance counters to monitor the performance of LSA lookups. These counters provide insights into the performance of name and SID lookups through the `LsaLookupNames`, `LsaLookupSids`, and equivalent APIs. These performances counters are available for both Windows client and Windows Server.

LSA enforces security policies, handling user logins, authentication, and authorization processes. LSA verifies credentials when users attempt to access the system based on configured policies. LSA is also used to manage password changes and create access tokens that define permissions for available resources and operations.

LSA Lookup performance counters are accessed using Performance Monitor (`perfmon.exe`).

## LSA Lookup performance counters

LSA Lookup performance counters measure the performance of the LSA lookup process running on the client or server machine.

The following table shows the counters that can be added from the LSA Lookup performance counter set and their description.

| Counter name | Description |
|--|--|
| `Isolated Names Inbound Requests/sec` | The number of name lookup requests per second that are received from another remote machine that don't include the domain name. |
| `Isolated Names Outbound Requests/sec` | The number of name lookup requests per second that are sent to another remote machine that don't include the domain name. For example, requests forwarded to the primary domain controller. |
| `Name/SID cache entries added/sec` | The number of name/SID cache entries added per second. The local LSA keeps a cache of the SID-name pair. The cache is used to speed up the lookup process and reduce the number of requests to the remote machine. Measuring the growth of the cache and the number of requests can help with understanding the performance of the LSA lookup process and if the cache needs to be resized. |
| `Name/SID cache entries purged/sec` | The number of name/SID cache entries purged per second. The local LSA keeps a cache of the SID-name pair. The cache is used to speed up the lookup process and reduce the number of requests to the remote machine. Measuring the growth of the cache and the number of requests can help with understanding the performance of the LSA lookup process and if the cache needs to be resized. |
| `Name/SID Cache Size (Max Entries)` | The maximum number of entries that the name/SID cache can hold. |
| `Names/Cache % Full` | The percentage of the name cache that is full. |
| `Names/Cache %` | The percentage of name lookups that are resolved from the cache. |
| `Names Completion Time` | Measures how long it takes to complete a name lookup request. |
| `Names Errors/sec` | The number of errors per second that occur during name lookup requests. For example, if a server is busy, it might not be able to respond to a name lookup request. |
| `Names Inbound Requests/sec` | The number of all name lookup requests per second that are received from another remote machine. |
| `Names Outbound Requests/sec` | The number of all name lookup requests per second that are sent to another remote machine. |
| `Names Primary Domain Requests/sec` | The number of name lookup requests per second that are sent to the primary domain. The primary domain is the domain your machine is a member of. |
| `Names Primary Domain Time` | Measures the time it takes to complete a name lookup request that is sent to the primary domain. The primary domain is the domain your machine is a member of. |
| `Names Remote Request Time` | Measures the time it takes to complete a name lookup request that is received from another remote machine. |
| `Names Trusted Domain Request Time` | Measures the time it takes to complete a name lookup request that is sent to a trusted domain. |
| `Names Trusted Domain Requests/sec` | The number of name lookup requests per second that are sent to a trusted domain. |
| `Names Unresolved/sec` | The number of unresolved name lookup requests per second. For example, when a name lookup couldn't be found. |
| `Names Xforest Requests/sec` | The number of name lookup requests per second that are sent to another forest. |
| `Names Xforest Time` | Measures the time it takes to complete a name lookup request that is sent to another forest. |
| `SIDs Cache % Full` | The percentage of the SID cache that is full. |
| `SIDs Cache % Hit` | The percentage of SID lookups that are resolved from the cache. |
| `SIDs Completion Time` | Measures how long it takes to complete a SID lookup request. |
| `SIDs Errors/sec` | The number of errors per second that occur during SID lookup requests. For example, if a server is busy, it might not be able to respond to a SID lookup request. |
| `SIDs Inbound Requests/sec` | The number of all SID lookup requests per second that are received from another remote machine. |
| `SIDS Outbound Requests/sec` | The number of all SID lookup requests per second that are sent to another remote machine. |
| `SIDS Primary Domain Request Time` | Measures the time it takes to complete a SID lookup request that is sent to the primary domain. The primary domain is the domain your machine is a member of. |
| `SIDS Primary Domain Requests/sec` | The number of SID lookup requests per second that are sent to the primary domain. The primary domain is the domain your machine is a member of. |
| `SIDS Remote Request Time` | Measures the time it takes to complete a SID lookup request that is received from another remote machine. |
| `SIDS Trusted Domain Request Time` | Measures the time it takes to complete a SID lookup request that is sent to a trusted domain. |
| `SIDS Trusted Domain Requests/sec` | The number of SID lookup requests per second that are sent to a trusted domain. |
| `SIDS Unresolved/sec` | The number of unresolved SID lookup requests per second. For example, when a SID lookup couldn't be found. |
| `SIDS Xforest Request Time` | Measures the time it takes to complete a SID lookup request that is sent to another forest. |
| `SIDS Xforest Requests/sec` | The number of SID lookup requests per second that are sent to another forest. |

## Next steps

- [Configure added LSA protection](../../security/credentials-protection-and-management/configuring-additional-lsa-protection.md)
