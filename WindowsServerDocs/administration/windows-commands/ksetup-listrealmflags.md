---
title: ksetup listrealmflags
description: Reference article for the ksetup listrealmflags command, which lists the available realm flags that can be reported by ksetup.
ms.topic: reference
ms.assetid: aa96e4da-6b98-4c05-bccf-73cbf33258c2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup listrealmflags

Lists the available realm flags that can be reported by **ksetup**.

## Syntax

```
ksetup /listrealmflags
```

### Remarks

- The realm flags specify additional features of a Kerberos realm that aren't based on the Windows Server operating system. Computers that are running Windows Server, can use a Kerberos server to administer authentication in the Kerberos realm, instead of using a domain running a Windows Server operating system. This entry establishes the features of the realm, and are as follows:

| Value | Realm flag | Description |
| ----- | ---------- | ----------- |
| 0xF | All | All realm flags are set. |
| 0x00 | None | No realm flags are set, and no additional features are enabled. |
| 0x01 | sendaddress | The IP address will be included within the ticket-granting tickets. |
| 0x02 | tcpsupported | Both the Transmission Control Protocol (TCP) and the User Datagram Protocol (UDP) are supported in this realm. |
| 0x04 | delegate | Everyone in this realm is trusted for delegation. |
| 0x08 | ncsupported | This realm supports name canonicalization, which allows for DNS and Realm naming standards. |
| 0x80 | rc4 | This realm supports RC4 encryption to enable cross-realm trust, which allows for the use of TLS. |

- Realm flags are stored in the registry under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Domains\<realmname>`. This entry doesn't exist in the registry by default. You can use the [ksetup addrealmflags command](ksetup-addrealmflags.md) to populate the registry.

## Examples

To list the known realm flags on this computer, type:

```
ksetup /listrealmflags
```

To set the available realm flags that **ksetup** doesn't know, type:

```
ksetup /setrealmflags CORP.CONTOSO.COM sendaddress tcpsupported delete ncsupported
```

**-OR-**

```
ksetup /setrealmflags CORP.CONTOSO.COM 0xF
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup addrealmflags command](ksetup-addrealmflags.md)

- [ksetup setrealmflags command](ksetup-setrealmflags.md)

- [ksetup delrealmflags command](ksetup-delrealmflags.md)
