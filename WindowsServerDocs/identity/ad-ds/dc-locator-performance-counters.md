---
title: Active Directory DC Locator performance counters in Windows Server
description: Learn about Active Directory DC Locator performance counters in Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024

---

# DC Locator performance counters



Beginning with Windows Server 2025, you can use Active Directory Domain Service Domain Controller (DC) Locator performance counters to monitor the performance of DC locator clients. These counters provide insights into the performance of DC locator requests per second by type, average success and failure latency, and other metrics.

DC location refers to the algorithm the client machine uses to find a suitable domain controller (DC). DC location is a critical baseline functionality in all enterprise environments. To learn more about the DC location process, see [Active Directory DC locator changes](manage/dc-locator-changes.md).

There are the following domain controller locator performance counter sets:

- DC Locator (Client)
- DC Locator (DC)
- DC Locator (Netlogon)

You can access these performance counters using Performance Monitor (`perfmon.exe`).

## DC Locator (Client)

DC Locator (Client) performance counters measure per process running on the local client machine. You can break down requests based on which flags are used, such as the number of requests per second with the GC flag required, KDC flag required, and so on. Examples of available counters include Average Failure Latency (secs), Average Success Latency (secs), Failures/sec, Successes/sec, and Total Active Site Name Queries/sec.

The following table shows the client counters that can be added when using the DC Locator (Client) performance counter set.

| Counter name                                   | Description                                                                                                 |
|------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| `Flags: DS Required (W2K+) Requests/sec`       | The number of requests per second that have the Windows 2000 and later Directory Service flag set           |
| `Flags: DS Required (WS2008+) Requests/sec`    | The number of requests per second that have the Windows Server 2008 and later Directory Service flag set    |
| `Flags: DS Required (WS2012 R2+) Requests/sec` | The number of requests per second that have the Windows Server 2012 R2 and later Directory Service flag set |
| `Flags: DS Required (WS2012+) Requests/sec`    | The number of requests per second that have the Windows Server 2012 and later Directory Service flag set    |
| `Flags: DS Required (WS2016+) Requests/sec`    | The number of requests per second that have the Windows Server 2016 and later Directory Service flag set    |
| `Flags: Force Rediscovery Requests/sec`        | The number of requests per second that have the force rediscovery flag set                                  |
| `Flags: GC Required Requests/sec`              | Number of requests per second that have the Global Catalog flag set                                         |
| `Flags: KDC Required Requests/sec`             | Number of requests per second that have the Key Distribution Center flag set                                |
| `Flags: KeyList Support Required Requests/sec` | Number of requests per second that have the KeyList support flag set                                        |
| `Flags: PDC Required Requests/sec`             | Requests per second that have the Primary Domain Controller flag set                                        |
| `Flags: Time Server Required Requests/sec`     | Requests per second that have the Time Server flag set                                                      |
| `Flags: TryNextClosestSite Requests/sec`       | Requests per second that have the `TryNextClosestSite` flag set                                             |
| `Flags: Writable Required Requests/sec`        | Requests per second that have the Writable flag set                                                          |
| `Requests: Average Failure Latency (secs)`     | The average latency of failed requests in seconds                                                           |
| `Requests: Average Success Latency (secs)`     | The average latency of successful requests in seconds                                                       |
| `Requests: Failures/sec`                       | Number of failed requests per second                                                                        |
| `Requests: Successes/sec`                      | Number of successful requests per second                                                                    |
| `Requests: Total Active`                       | The total number of active requests per second                                                              |
| `Site Name Queries/sec`                        | Number of site name queries per second                                                                      |

## DC Locator (DC)

DC Locator (DC) counters exist only on the domain controller. The DC Locator (DC) counters measured the number of incoming LDAP and mailslot pings and requests received for locating domain controllers.

The following table shows the server-side counters that can be added when using the DC Locator (DC) performance counter set.

| Counter name                                | Description                                               |
|---------------------------------------------|-----------------------------------------------------------|
| `Pings: Active Mailslot Pings`                | Returns the number of active Mailslot pings               |
| `Pings: Active UDP LDAP Pings`                | Returns the number of active UDP LDAP pings               |
| `Pings: Average Mailslot Ping Latency (secs)` | Returns the average latency of Mailslot pings in seconds  |
| `Pings: Average UDP LDAP Ping Latency (secs)` | Returns the average latency of IJDP LDAP pings in seconds |
| `Pings: Mailslot Pings Received/sec`          | Returns the number of Mailslot pings received per second  |
| `Pings: UDP LDAP Pings Received/sec`          | Returns the number of UDP LDAP pings received per second  |

## DC Locator (Netlogon)

The Netlogon service downloads and caches naming information about domains and child domains in all trusting forests. The DC Locator (Netlogon) performance counters are similar to DC Locator (Client) counters except the counter instances are organized by name lookup. There are also a few more cache-based counters available, such as Cache: Hits/sec and Cache: Misses/sec. You can use these objects to see how many times a lookup is resolved from the cache or over the wire.

The following table shows the counters that can be added when using the DC Locator (Netlogon) performance counter set.

| Counter name                                   | Description                                                                                                 |
|------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| `Cache: Hits/sec`                              | Returns the number of cache hits per second                                                                 |
| `Cache: Misses/sec`                            | Returns the number of cache misses per second                                                               |
| `DNS Query Failures/sec`                       | Returns the number of DNS query failures per second                                                         |
| `Flags: DS Required (W2K+) Requests/sec`       | The number of requests per second that have the Windows 2000 and later Directory Service flag set           |
| `Flags: DS Required (WS2008+) Requests/sec`    | The number of requests per second that have the Windows Server 2008 and later Directory Service flag set    |
| `Flags: DS Required (WS2012 R2+) Requests/sec` | The number of requests per second that have the Windows Server 2012 R2 and later Directory Service flag set |
| `Flags: DS Required (WS2012+) Requests/sec`    | The number of requests per second that have the Windows Server 2012 and later Directory Service flag set    |
| `Flags: DS Required (WS2016+) Requests/sec`    | The number of requests per second that have the Windows Server 2016 and later Directory Service flag set    |
| `Flags: Force Rediscovery Requests/sec`        | The number of requests per second that have the force rediscovery flag set                                  |
| `Flags: GC Required Requests/sec`              | Number of requests per second that have the Global Catalog flag set                                         |
| `Flags: KDC Required Requests/sec`             | Number of requests per second that have the Key Distribution Center flag set                                |
| `Flags: KeyList Support Required`              | Number of requests per second that have the KeyList support flag set                                        |
| `Flags: PDC Required Requests/sec`             | Requests per second that have the Primary Domain Controller flag set                                        |
| `Flags: Time Server Required Requests/sec`     | Requests per second that have the Time Server flag set                                                      |
| `Flags: TryNextClosestSite Requests/sec`       | Requests per second that have the `TryNextClosestSite` flag set                                             |
| `Flags: Writable Required Requests/sec`        | Requests per second that have the Writable flag set                                                         |
| `Pings: Mailslot Pings Sent/sec`               | Returns the number of Mailslot pings sent per second                                                        |
| `Pings: UDP Pings Sent/sec`                    | Returns the number of UDP pings sent per second                                                             |
| `Requests: Average Failure Latency (secs)`     | Returns the average latency of failed requests in seconds                                                   |
| `Requests: Average Success Latency (secs)`     | Returns the average latency of successful requests in seconds                                               |
| `Requests: Failures/sec`                       | Returns the number of failed requests per second                                                            |
| `Requests: Rejected/sec`                       | Returns the number of rejected requests per second                                                          |
| `Requests: Successes/sec`                      | Returns the number of successful requests per second                                                        |
| `Requests: Total Active`                       | Returns the total number of active requests                                                                 |
| `UDP Ports Opened`                             | Returns the number of UDP ports opened                                                                      |

## Next steps

- [How domain controllers are located in Windows](/troubleshoot/windows-server/active-directory/how-domain-controllers-are-located)

- [Active Directory DC locator changes](manage/dc-locator-changes.md)
