---
title: ksetup addkpasswd
description: Reference topic for the ksetup addkpasswd command, which adds a Kerberos password (Kpasswd) server address for a realm.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: d3196995-1b38-48ff-ba08-911cfab77317
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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
| `<realmname>` | The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or **Realm=** when **ksetup** is run. |
| `<kpasswdname>` | The KDC name that is to be used as the Kerberos password server is stated as a case insensitive fully qualified domain name, such as mitkdc.microsoft.com. If the KDC name is omitted, DNS might be used to locate KDCs. |

#### Remarks

- If the Kerberos realm that the workstation will be authenticating to supports the Kerberos change password protocol, you can configure a client computer running the Windows operating system to use a Kerberos password server.

- You can add additional KDC names one at a time.

### Examples

To configure the CORP.CONTOSO.COM realm to use the non-Windows KDC server, mitkdc.contoso.com, as the password server, type:

```
ksetup /addkpasswd CORP.CONTOSO.COM mitkdc.contoso.com
```

To verify the the KDC name is set, type `ksetup` and then view the output, looking for **kpasswd =**. If you don't see it, it means the mapping hasn't been configured.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup delkpasswd](ksetup-delkpasswd.md)
