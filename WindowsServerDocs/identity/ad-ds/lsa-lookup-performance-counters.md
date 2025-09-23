---
title: LSA Lookup performance counters in Windows and Windows Server
description: Learn about Local Security Authority (LSA) Lookups performance counters
ms.topic: concept-article
author: lindakup
ms.author: roharwoo
ms.date: 10/25/2024

---

# LSA Lookup performance counters



Excessive Local Security Authority (LSA) Account Name and Account security identifiers (SID) lookups can contribute to Active Directory performance degradation. Active Directory performance problems can result in a wide variety of symptoms. Symptoms such as user authentication prompts, Outlook, or Exchange problems, slow sign in, Lightweight Directory Access Protocol (LDAP) application timeouts and more.

The Local Security Authority (LSA), which resides within the Local Security Authority Security Service (LSASS) process, validates users for local and remote sign-ins and enforces local security policies. LSA performs SID and Name translation or lookups as well as the other functions such as handling user logins, authentication, and authorization processes. LSA verifies credentials when users attempt to access the system based on configured policies. LSA is also used to manage password changes and create access tokens that define permissions for available resources and operations.

The top causes of excessive LSA Name or SID Lookups usually include:

- The client LSA Name or SID Lookup Cache is too small, causing many name lookups to be sent to the domain controller repeatedly.
- An application sending repeated lookup requests that don’t resolve, causing them to be sent to the domain controller repeatedly.
- Isolated names that don't contain a domain name portion and need to be sent to a remote domain controller across every trust resulting in delays.
- Remote lookups taking a long time when a domain controller has to request a lookup from cross-forest. Remote lookups might contribute to the domain controller running out of RPC threads or building a queue at RPC level. Long running lookups can result in failures, timeouts, and problems in client applications such as Exchange outages.

Therefore, it's important to monitor performance of LSA Name/SID lookups and adjust applications and configuration accordingly.

Beginning with Windows Server 2025, you can use Local Security Authority (LSA) performance counters to monitor the performance of LSA lookups. The LSA Lookups performance counter set consists of counters that measure performance of LSA Account name and Account SID lookups. These performance counters are available for both Windows client and Windows Server. For more information about the algorithm used when a name/SID needs to be translated, see [LsaLookupNames function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupnames) and [LsaLookupSids function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupsids).

This article also discusses LSA Lookup Caches, including LSA Name cache, for successfully translated names; and Negative Isolated name cache, for unresolved names.

LSA Lookups performance counters are accessed using Performance Monitor (`perfmon.exe`).

## Performance counters

LSA Lookups performance counters measure the performance of the LSA lookup process running on the client or server machine.

There are three categories of LSA Lookups performance counters:

- Name lookups, which are name counters you can use to measure Name translation using the LsaLookupNames and LsaLookupNames2 functions. For more information about name translation, see [LsaLookupNames function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupnames) and [LsaLookupNames2 function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupnames2).
- The SID/Name pair Cache, which you can use to measure the efficiency and size of the name/SID pair cache. Domain controllers don't maintain a name/SID cache. These counters are valid on only a member server or workstation.
- SID lookups, which include SID counters you can use to measure SID translation using the LsaLookupSids and LsaLookupSids2 functions. For more information about SID lookup, see [LsaLookupSids function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupsids) and [LsaLookupSids2 function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupsids2).

The following table shows the counters that can be added from the LSA Lookups performance counter set and their description. The table also including whether each counter relates to domain controller (DC), non-DC, or both. Non-DC signifies a member server or member workstation.

| Counter name | Description | DC | Non-DC |
|--|--|--|--|
| `Isolated Names Inbound Requests/sec` | The number of name lookup requests per second that don't include the domain name and are received from another remote machine. | X | X |
| `Isolated Names Outbound Requests/sec` | The number of name lookup requests per second that don't include the domain name and are sent to another remote machine. For example, requests forwarded to the primary domain controller. | X | X |
| `Name/SID cache entries added/sec` | The number of name/SID cache entries added per second. The local LSA keeps a cache of the SID-name pair. The cache is used to speed up the lookup process and reduce the number of requests to the remote machine. Measuring the growth of the cache and the number of requests can help with understanding the performance of the LSA lookup process and if the cache needs to be resized. |  | X |
| `Name/SID cache entries purged/sec` | The number of name/SID cache entries purged per second. The local LSA keeps a cache of the SID-name pair. The cache is used to speed up the lookup process and reduce the number of requests to the remote machine. Measuring the growth of the cache and the number of requests can help with understanding the performance of the LSA lookup process and if the cache needs to be resized. |  | X |
| `Name/SID Cache Size (Max Entries)` | The maximum number of entries that the name/SID cache can hold. |  | X |
| `Names/Cache % Full` | The percentage of the name cache that is full. |  | X |
| `Names/Cache % Hit` | The percentage of name lookups that are resolved from the cache. |  | X |
| `Names Completion Time` | Measures the average time in seconds to complete a name lookup request. | X | X |
| `Names Errors/sec` | The number of errors per second that occur during name lookup requests. For example, if a server is busy, it might not be able to respond to a name lookup request. | X | X |
| `Names Inbound Requests/sec` | The number of all name lookup requests per second that are received from another remote machine. Received from another remote machine or a process running on this machine. | X | X |
| `Names Outbound Requests/sec` | The number of all name lookup requests per second that are sent to another remote machine. | X | X |
| `Names Primary Domain Requests/sec` | The number of name lookup requests per second that are sent to the primary domain. The primary domain is the domain your machine is a member of. This counter is a subset of the Names Outbound Requests/sec counter.|  | X |
| `Names Primary Domain Time` | Measures the average time in seconds to complete a name lookup request that is sent to a domain controller in the primary domain. The primary domain is the domain your machine is a member of. |  | X |
| `Names Remote Request Time` | Measures the average time in seconds to complete a name lookup request that is received from another remote machine. | X | X |
| `Names Trusted Domain Request Time` | Measures the average time in seconds to complete a name lookup request that is sent to a trusted domain. This counter is a subset of the Names Remote Request time counter | X |  |
| `Names Trusted Domain Requests/sec` | The number of name lookup requests per second that are sent to a trusted domain. This counter is a subset of the Names Outbound Requests/sec counter| X |  |
| `Names Unresolved/sec` | The number of unresolved name lookup requests per second. For example, when a name lookup can't be found. | X | X |
| `Names Xforest Requests/sec` | The number of name lookup requests per second that are sent to another forest. | X |  |
| `Names Xforest Time` | Measures the average time in seconds to complete a name lookup request that is sent to another forest. | X |  |
| `SIDs Cache % Full` | The percentage of the SID-name pair cache in use during a SID lookup. |  | X |
| `SIDs Cache % Hit` | The percentage of SID lookups that are resolved from the cache. If this counter is low and the cache is full, consider increasing the cache size. |  | X |
| `SIDs Completion Time` | Measures how long it takes to complete a SID lookup request. | X | X |
| `SIDs Errors/sec` | The number of errors per second that occur during SID lookup requests. For example, if a server is busy, it might not be able to respond to a SID lookup request. | X | X |
| `SIDs Inbound Requests/sec` | The number of all SID lookup requests per second that are received from another remote machine or a process running on this machine.| X | X |
| `SIDs Outbound Requests/sec` | The number of all SID lookup requests per second that are sent to another remote machine. | X | X |
| `SIDs Primary Domain Request Time` | Measures the average time in seconds to complete a SID lookup request that is sent to the primary domain. The primary domain is the domain your machine is a member of. Counter is a subset of SIDs Outbound Requests/sec |  | X |
| `SIDs Primary Domain Requests/sec` | The number of SID lookup requests per second that are sent to the primary domain. The primary domain is the domain your machine is a member of. Counter is a subset of SIDs Outbound Requests/sec |  | X |
| `SIDs Remote Request Time` | Measures the average time in seconds to complete a SID lookup request that is received from another remote machine. | X | X |
| `SIDs Trusted Domain Request Time` | Measures the average time in seconds to complete a SID lookup request that is sent to a trusted domain. Counter is a subset of SIDs Outbound Requests/sec | X |  |
| `SIDs Trusted Domain Requests/sec` | The number of SID lookup requests per second that are sent to a trusted domain. | X |  |
| `SIDs Unresolved/sec` | The number of unresolved SID lookup requests per second. For example, when a SID lookup couldn't be found. | X | X |
| `SIDs Xforest Request Time` | Measures the average time in seconds to complete a SID lookup request that is sent to another forest. | X |  |
| `SIDs Xforest Requests/sec` | The number of SID lookup requests per second that are sent to another forest. | X |  |

## LSA Lookup debug log

For troubleshooting, you can collect the LSP debug log to track the processes and client details performing SID or name lookups.

### Log file

The debug log files are `%systemroot%\debug\lsp.log` and `lsp.bak`.

The default log file size is 10 MB.

### Enable

To enable the LSA Lookup debug log, run the following commands:

```powershell

Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa -Name LspDbgInfoLevel -Value 0x800 -Type dword -Force

Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa -Name LspDbgTraceOptions -Value 0x1 -Type dword -Force

```

No reboot is necessary.

### Disable

To disable LSA Lookup debug log, run the following commands:

```powershell

Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa -Name LspDbgInfoLevel -Value 0x0 -Type dword -Force

Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa -Name LspDbgTraceOptions -Value 0x0 -Type dword -Force

```

No reboot is necessary.

> [!NOTE]
> You may need a larger log size in a busier environment. You can specify log size using the last 4 bits of the DWORD in LsapDbgTraceOptions. The value should be specified in MBs in hexadecimal. For example, to set the log file size to 50MB, set LspDbgTraceOptions to 0x00320001. Setting the file size to a very large value might make it impossible to open and read using some text editors.

## LSA Lookups caches

The LSA maintains several caches, two of which are discussed here: LSA Name cache, for successfully translated names; and Negative Isolated name cache, for unresolved names.

### LSA Name cache

Member workstations and member servers maintain a local in-memory cache of successfully translated name/SID pairs. This cache reduces round trips to the domain controller and improves performance and efficiency.

Domain Controllers don't maintain a cache; they store the information about domain objects locally. Domain controllers that are Global Catalogs store information about the entire forest. Domain controllers that aren't Global Catalogs forward requests to a Global Catalog if necessary. 

A cache entry can be in one of three states: Valid, Stale, or Expired.

- Default cache entry expiry time is 7 days.
- Default cache size is 4,096 entries beginning in Windows Server 2019 and 128 entries in previous versions.
- Default values suffice in most environments. Although this cache has a very small memory footprint, changing the cache size should be done only if necessary. For example, you can use LSA Lookups performance counters to see if the cache %full is at 100, and whether there's a high Cache %hit rate and many outbound requests/sec to the Domain Controller. High %full and %hit rate counts mean that the cache might be too small.

The LSA name cache can be tuned using the following settings under `HKLM:\SYSTEM\CurrentControlSet\Control\Lsa`  

- LsaLookupCacheMaxSize (DWORD): The maximum number of entries in the cache. Setting to 0 disables the cache.
- LsaLookupCacheExpireTime (DWORD). The maximum duration of an entry in the cache in minutes. The default is 10080 (7 days).
- LsaLookupCacheRefreshTime (DWORD): The extension of the TTL in minutes in case the entry is fetched from the cache. The default is 10.  

### Negative Isolated name cache

Member workstations and member servers maintain local in-memory cache of isolated names that haven't and can't be resolved. For more information about Isolated names, see [LsaLookupNames2 function (ntsecapi.h)](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupnames2).

Negative Isolated name cache isn't configurable. The maximum size is 8,000 entries with a maximum duration of 2 hours each. Resolved names are automatically removed from the cache. A background task cleans up stale entries.

## Next steps

- [Configure added LSA protection](../../security/credentials-protection-and-management/configuring-additional-lsa-protection.md)
- [Windows Logon and Authentication Technical Overview](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dn169029(v=ws.10))
- [Security identifiers](manage/understand-security-identifiers.md)
