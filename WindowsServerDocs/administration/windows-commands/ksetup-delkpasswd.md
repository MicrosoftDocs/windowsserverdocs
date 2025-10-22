---
title: ksetup delkpasswd
description: Reference article for the ksetup delkpasswd command, which removes a Kerberos password server (kpasswd) for a realm.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# ksetup delkpasswd



Removes a Kerberos password server (kpasswd) for a realm.

## Syntax

```
ksetup /delkpasswd <realmname> <kpasswdname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` |  Specifies the uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or **Realm=** when **ksetup** is run. |
| `<kpasswdname>` | Specifies the Kerberos password server. It's stated as a case-insensitive, fully-qualified domain name, such as mitkdc.contoso.com. If the KDC name is omitted, DNS might be used to locate KDCs. |

### Examples

To make sure the realm CORP.CONTOSO.COM uses the non-Windows KDC server mitkdc.contoso.com as the password server, type:

```
ksetup /delkpasswd CORP.CONTOSO.COM mitkdc.contoso.com
```

To make sure the realm CORP.CONTOSO.COM is not mapped to a Kerberos password server (the KDC name), type `ksetup` on the Windows computer and then view the output.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup delkpasswd command](ksetup-delkpasswd.md)
