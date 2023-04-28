---
title: dfsdiag testreferral
description: Reference article for the dfsdiag testreferral command, which checks Distributed File System (DFS) referrals.
ms.topic: reference
ms.assetid: 877c60dc-e993-4bd5-87dd-e892e3f98a1a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# dfsdiag testreferral

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks Distributed File System (DFS) referrals by performing the following tests:

- If you use the **DFSpath*** parameter without arguments, the command validates that the referral list includes all trusted domains.

- If you specify a domain, the command performs a health check of domain controllers (`dfsdiag /testdcs`) and tests the site associations and domain cache of the local host.

- If you specify a domain and \SYSvol or \NETLOGON, the command performs the same domain controller health checks, along with checking that the time **To Live (TTL)** of SYSvol or NETLOGON referrals matches the default value of 900 seconds.

- If you specify a namespace root, the command performs the same domain controller health checks, along with performing a DFS configuration check (`dfsdiag /testdfsconfig`) and a namespace integrity check (`dfsdiag /testdfsintegrity`).

- If you specify a DFS folder (link), the command performs the same namespace root health checks, along with validating the site configuration for folder targets (dfsdiag /testsites) and validating the site association of the local host.

## Syntax

```
dfsdiag /testreferral /DFSpath:<DFS path to get referrals> [/full]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /DFSpath:`<path to get referrals>` | Can be one of the following:<ul><li>**Blank:** Tests only trusted domains.</li><li>`\\Domain:` Tests only domain controller referrals.</li><li>`\\Domain\SYSvol:` Tests only SYSvol referrals.</li><li>`\\Domain\NETLOGON:` Tests only NETLOGON referrals.</li><li>`\\<domain or server>\<namespace root>:` Tests only namespace root referrals.</li><li>`\\<domain or server>\<namespace root>\<DFS folder>:` Tests only the DFS folder (link) referrals.</li></ul> |
| /full | Applies only to Domain and Root referrals. Verifies the consistency of site association information between the registry and active directory Domain Services (AD DS). |

## Examples

To check the Distributed File System (DFS) referrals in *contoso.com\MyNamespace*, type:

```
dfsdiag /testreferral /DFSpath:\\contoso.com\MyNamespace
```

To check the Distributed File System (DFS) referrals in all trusted domains, type:

```
dfsdiag /testreferral /DFSpath:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [dfsdiag command](dfsdiag.md)
