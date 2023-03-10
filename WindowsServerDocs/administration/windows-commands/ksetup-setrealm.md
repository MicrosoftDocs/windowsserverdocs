---
title: ksetup setrealm
description: Reference article for the ksetup setrealm command, which sets the name of a Kerberos realm.
ms.topic: reference
ms.assetid: ab268c40-276b-46ef-ab16-d5ce7667fbed
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup setrealm

Sets the name of a Kerberos realm.

> [!IMPORTANT]
> Setting the Kerberos realm on a domain controller isn't supported. Attempting to do so causes a warning and a command failure.

## Syntax

```
ksetup /setrealm <DNSdomainname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<DNSdomainname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM. You can use the fully-qualified domain name or a simple form of the name. If you don't use uppercase for the DNS name, you'll be asked for verification to continue. |

### Examples

To set the realm of this computer to a specific domain name, and to restrict access by a non-domain controller just to the CONTOSO Kerberos realm, type:

```
ksetup /setrealm CONTOSO
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup removerealm](ksetup-removerealm.md)
