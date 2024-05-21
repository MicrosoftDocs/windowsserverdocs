---
title: Active Directory LDAP client performance counters
description: Learn about Active Directory LDAP client performance counters
ms.topic: conceptual
author: gswashington
ms.author: wscontent
ms.date: 05/31/2024

---

# Active Directory LDAP client performance counters

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

The latest enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) in Windows Server 2025 introduce new functionalities for domain management, including client performance counters for Lightweight Directory Access Protocol (LDAP). 

LDAP is an integral part of Windows Server that enables querying and modification of directories. LDAP interacts with Active Directory to manage all network resources, including users, groups, permissions, and other data stored within the directory.

<!-- Need to verify lines 23-26 are accurate  -->
LDAP performance counters in Windows Server operates in two basic modes:

- DNS-based discovery
- NetBIOS-based discovery

You can access these performance counters at Performance Monitor.

## LDAP client performance counters

LDAP client performance counters measure per process running on the local client machine. Multiple processes can be asessed simultaneously.Examples of available counters include binds, connections, and operations.

The following table shows the client counters that can be added when running LDAP performance counters, their counter types, and descriptions of what object data they generate.

| Counter name | Type | Description |
|-----|-----|-----|
| Digest Binds/sec | Binds | Outputs instances of object |
| Negotiate Binds/sec | Binds | Outputs instances of object |
| NTLM Binds/sec | Binds | Outputs instances of object |
| Simple Binds/sec | Binds | Outputs instances of object |
| Total Binds/sec | Binds | Outputs instances of object |
| New Connections/sec | Connections | Outputs instances of object |
| New TCP Connections/sec | Connections | Outputs instances of object |
| New TLS Connections/sec | Connections | Outputs instances of object |
| New LDP Connections/sec | Connections | Outputs instances of object |
| Open Connections | Connections | Outputs instances of object |
| Abandons/sec | Operations | Outputs instances of object |
| Adds/sec | Operations | Outputs instances of object |
| Deletes/sec | Operations | Outputs instances of object |
| Modify/sec | Operations | Outputs instances of object |
| New Requests/sec | Requests | Outputs instances of object |
| Request Count | Requests | Outputs instances of object |
| Average Response Time | Responses | Outputs instances of object |
| Failure Polling Responses/sec | Responses | Outputs instances of object |
| Failure Responses/sec | Responses | Outputs instances of object |
| Pending Responses | Responses | Outputs instances of object |
| Successful Polling Responses/sec | Responses | Outputs instances of object |
| Successful Responses/sec | Responses | Outputs instances of object |
| Base Searches/sec | Searches | Outputs instances of object |
| Subtree Searches/sec | Searches | Outputs instances of object |

## Next steps

- [How LDAP server cookies are handled](/identity/ad-ds/manage/how-ldap-server-cookies-are-handled)

- [Step by Step Guide to Setup LDAPS on Windows Server](https://techcommunity.microsoft.com/t5/sql-server-blog/step-by-step-guide-to-setup-ldaps-on-windows-server/ba-p/385362)