---
title: Active Directory LDAP client performance counters in Windows Server
description: Learn about Active Directory LDAP client performance counters in Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024

---

# Active Directory LDAP client performance counters



Beginning with Windows Server 2025, you can use Active Directory Lightweight Directory Access Protocol (LDAP) client performance counters to monitor the performance of LDAP clients. These counters provide valuable insights into the performance of LDAP clients, including the number of binds, connections, and operations that are being processed.

LDAP is an integral part of Windows Server that enables querying and modification of directories. LDAP interacts with Active Directory to manage all network resources, including users, groups, permissions, and other data stored within the directory.

You can access these performance counters using Performance Monitor (`perfmon.exe`).

## LDAP client performance counters

LDAP client performance counters can be monitored per process running on the local client machine. Multiple processes can be assessed simultaneously. Examples of available counters include binds, connections, and operations.

The following table shows the counters that can be monitored when using a process that performs LDAP queries. The table shows the counter name, and type.

| Counter name | Type | Description |
|-----|-----|-----|
| `Digest Binds/sec` | Binds | The number of binds per second performed using digest authentication with LDAP and SASL. |
| `Negotiate Binds/sec` | Binds | The number of binds per second performed using negotiated authentication with LDAP and SASL. |
| `NTLM Binds/sec` | Binds | The number of binds per second performed using NTLM authentication with LDAP and SASL. |
| `Simple Binds/sec` | Binds | The number of binds per second performed using simple authentication with LDAP and SASL. |
| `Total Binds/sec` | Binds | The total number of binds per second performed with LDAP and SASL. |
| `New Connections/sec` | Connections | The number of new connections per second to the LDAP server. |
| `New TCP Connections/sec` | Connections | The number of new TCP connections per second to the LDAP server. |
| `New TLS Connections/sec` | Connections | The number of new TLS connections per second to the LDAP server. |
| `New LDP Connections/sec` | Connections | The number of new LDP connections per second to the LDAP server. |
| `Open Connections` | Connections | The total number of open connections to the LDAP server. |
| `Abandons/sec` | Operations | The number of abandoned operations per second. |
| `Adds/sec` | Operations | The number of add operations per second. |
| `Deletes/sec` | Operations | The number of LDAP delete operations per second. |
| `Modify/sec` | Operations | The number of LDAP modify operations per second. |
| `New Requests/sec` | Requests | The number of new LDAP requests per second. |
| `Request Count` | Requests | The total number of LDAP requests since monitoring began. |
| `Average Response Time` | Responses | The average response time for LDAP requests since monitoring began. |
| `Failure Polling Responses/sec` | Responses | The number of failed polling responses per second. |
| `Failure Responses/sec` | Responses | The number of failed LDAP responses per second. |
| `Pending Responses` | Responses | The number of LDAP responses pending a response. |
| `Successful Polling Responses/sec` | Responses | The number of successful LDAP polling responses per second. |
| `Successful Responses/sec` | Responses | The number of successful LDAP responses per second. |
| `Base Searches/sec` | Searches | The number of LDAP base searches per second. |
| `Subtree Searches/sec` | Searches | The number of LDAP subtree searches per second. |

## Next steps

- [LDAP considerations in ADDS performance tuning](../../administration/performance-tuning/role/active-directory-server/ldap-considerations.md)
