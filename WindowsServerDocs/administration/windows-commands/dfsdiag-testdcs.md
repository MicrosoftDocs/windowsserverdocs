---
title: dfsdiag testdcs
description: Reference article for the dfsdiag testdcs command, which checks the configuration of domain controllers in the specified domain.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# dfsdiag testdcs



Checks the configuration of domain controllers by performing the following tests on each domain controller in the specified domain:

- Verifies that the Distributed File System (DFS) Namespace service is running and that its startup type is set to **Automatic**.

- Checks for the support of site-costed referrals for NETLOGON and SYSvol.

- Verifies the consistency of the site association by hostname and IP address.

## Syntax

```
dfsdiag /testdcs [/domain:<domain_name>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /domain:`<domain_name>` | Name of the domain to check. This parameter is optional. The default value is the local domain to which the local host is joined. |

## Examples

To verify the configuration of domain controllers in the *contoso.com* domain, type:

```
dfsdiag /testdcs /domain:contoso.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [dfsdiag command](dfsdiag.md)
