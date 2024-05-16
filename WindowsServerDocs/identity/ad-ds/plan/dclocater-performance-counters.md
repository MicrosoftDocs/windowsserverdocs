---
title: Active Directory DCLocator performance counters
description: Learn about Active Directory DCLocator performance counters
ms.topic: conceptual
author: gswashington
ms.author: wscontent
ms.date: 05/31/2024

---

# DCLocator performance counters

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

DC location refers to the algorithm by which a client machine finds a suitable domain controller. DC location is a critical baseline functionality in all enterprise environments.

DC location in Windows can operate in two basic modes:

- DNS-based discovery 
- NetBIOS-based discovery

Beginning with Windows Server 2025, Active Directory Domain Services (AD DS) and Lightweight Directory Services (LDS) feature three new domain controller locater performance counter sets:

- DC Locater (Client)
- DC Locater (DC)
- DC Locater (Netlogon)

## DC Locater (Client)

DC Locater (Client) measures per process running on the local client machine. Requests can be broken down based on what flags are being set, for example, requests per second, GC required, KDC required, and so on. Examples of available counters include Average Failure Latency (secs), Average Success Latency (secs), Failures/sec, Successes/sec, and Total Active Site Name Queries/sec.

The following table shows the client counters that can be added when running DC Locater (Client), type of counter (flag or request), and notes on output.

| Counter name | Type | Description |
|-----|-----|-----|
| DS Required (Windows Server 2000 and later) Requests/sec | Flag | Returns instances of object |
| DS Required (Windows Server 2008 and later) Requests/sec | Flag | Returns instances of object |
| DS Required (Windows Server 2012 R2 and later) Requests/sec | Flag | Returns instances of object |
| DS Required (Windows Server 2012 and later) Requests/sec | Flag | Returns instances of object |
| DS Required (Windows Server 2016 and later) Requests/sec | Flag | Returns instances of object |
| Force Rediscovery Requests/sec | Flag | Returns instances of object |
| GC Required Requests/sec | Flag | Returns instances of object |
| KDC Required Requests/sec | Flag | Returns instances of object |
| KeyList Support Required | Flag | Returns instances of object |
| PDC Required Requests/sec | Flag | Returns instances of object |
| Time Server Required Requests/sec | Flag | Returns instances of object |
| TryNextClosestSite Requests/sec | Flag | Returns instances of object |
| Writable Required Requests/sec | Flag | Returns instances of object |
| Average Failure Latency | Request | Returns instances of object |
| Average Success Latency | Request | Returns instances of object |
| Failures/sec | Request | Returns instances of object |
| Successes/sec | Request | Returns instances of object |
| Total Active Site Name Queries/sec | Request | Returns instances of object |

## DC Locater (DC) 

DC Locater (DC) counters exist only on the domain controller; these are incoming LDAP pings and mailslot pings for DC lookups.

## DC Locater (Netlogon)

Netlogon downloads and caches naming information about domains and child domains in all trusting forests. DC Locater (Netlogon) is similar to DC Locater Client counters except output is organized by name lookup. There are a few objects available that are cache-based, such as Cache: Hits/sec and Cache: Misses/sec. This allows you to see how many times a DC lookup is being resolved by the cache or has to make a call on the wire and then make the DNS quiries.

## Next steps

- [How domain controllers are located in Windows](/identity/how-domain-controllers-are-located)