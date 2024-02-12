---
title: ksetup addkpasswd
description: Reference article for the ksetup addkpasswd command, which adds a Kerberos password (kpasswd) server address for a realm.
ms.topic: reference
ms.assetid: d3196995-1b38-48ff-ba08-911cfab77317
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup addkpasswd

Adds a Kerberos password (kpasswd) server address for a realm.

## Syntax

```
ksetup /addkpasswd <realmname> [<kpasswdname>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or **Realm=** when **ksetup** is run. |
| `<kpasswdname>` | Specifies the Kerberos password server. It's stated as a case-insensitive, fully-qualified domain name, such as mitkdc.contoso.com. If the KDC name is omitted, DNS might be used to locate KDCs. |

#### Remarks

- If the Kerberos realm that the workstation will be authenticating to supports the Kerberos change password protocol, you can configure a client computer running the Windows operating system to use a Kerberos password server.

- You can add additional KDC names one at a time.

### Examples

To configure the CORP.CONTOSO.COM realm to use the non-Windows KDC server, mitkdc.contoso.com, as the password server, type:

```
ksetup /addkpasswd CORP.CONTOSO.COM mitkdc.contoso.com
```

To verify the KDC name is set, type `ksetup` and then view the output, looking for the text, **kpasswd =**. If you don't see the text, it means the mapping hasn't been configured.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup delkpasswd command](ksetup-delkpasswd.md)
