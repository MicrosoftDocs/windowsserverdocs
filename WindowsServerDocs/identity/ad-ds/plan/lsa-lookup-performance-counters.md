---
title: Active Directory LSA Lookup performance counters
description: Learn about Active Directory LSA Lookup performance counters
ms.topic: conceptual
author: gswashington
ms.author: wscontent
ms.date: 05/31/2024

---

# Active Directory LSA Lookup performance counters

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Windows Server 2025 (preview) introduces enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS). These enhancements include added features for domain management, including client performance counters for Local Security Authority (LSA) Lookup.

LSA enforces security policies, handling user logins, authentication, and authorization processes. LSA verifies credentials when users attempt to access the system based on configured policies. LSA is also used to manage password changes and create access tokens that define permissions for available resources and operations.

LSA Lookup performance counters help you troubleshoot and monitor performance of Name and SID Lookups through the LsaLookupNames and LSALookupSids and equivalent APIs. LSA Lookup performance counterrs are available for both client and server. LSA Lookup performance counters are accessed via Performance Monitor.

## LSA Lookup performance counters

LSA Lookup performance counters measure per process running on the client or server machine. Multiple processes can be asessed simultaneously. 

The following table shows the counters that can be added when running LSA Lookup performance counters, type of counter (requests, connections, queries and so on) and notes on object data generated.

| Counter name | Type | Description |
|-----|-----|-----|
| Isolated Names Inbound Requests/sec | Requests | Outputs instances of object |
| Isolated Names Outbound Requests/sec | Requests | Outputs instances of object |
| Name/SID cache entries added/sec | Additions | Outputs instances of object |
| Name/SID cache entries purged/sec | Deletions | Outputs instances of object |
| Name/SID Cache Size (Max Entries) | Entries | Outputs instances of object |
| Names/Cache % Full | Connections | Outputs instances of object |
| Names/Cache % | Connections | Outputs instances of object |
| New TLS Connections/sec | Connections | Outputs instances of object |
| New LDP Connections/sec | Connections | Outputs instances of object |
| Open Connections | Connections | Outputs instances of object |
| Abandons/sec | Connections | Outputs instances of object |
| Adds/sec | Connections | Outputs instances of object |
| Deletes/sec | Connections | Outputs instances of object |
| Modify/sec | Connections | Outputs instances of object |
| New Requests/sec | Connections | Outputs instances of object |
| Request Count | Connections | Outputs instances of object |
| Average Response Time | Requests | Outputs instances of object |
| Failure Polling Responses/sec | Requests | Outputs instances of object |
| Failure Responses/sec | Requests | Outputs instances of object |
| Pending Responses | Requests | Outputs instances of object |
| Successful Polling Responses/sec | Requests | Outputs instances of object |
| Successful Responses/sec | Requests | Outputs instances of object |
| Base Searches/sec | Queries | Outputs instances of object |
| Subtree Searches/sec | Queries | Outputs instances of object |

## Next steps

- [Configure added LSA protection](/security/credentials-protection-and-management/configuring-additional-lsa-protection)