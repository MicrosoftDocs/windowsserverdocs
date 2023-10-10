---
title: ksetup delrealmflags
description: Reference article for the ksetup delrealmflags command, which removes realm flags from the specified realm.
ms.topic: reference
ms.assetid: 22053041-1eb4-47f5-bed9-3d5681bcde7d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup delrealmflags

Removes realm flags from the specified realm.

## Syntax

```
ksetup /delrealmflags <realmname> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or **Realm=** when **ksetup** is run. |

#### Remarks

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

- You can see the available and set realm flags by viewing the output of **ksetup** or `ksetup /dumpstate`.

### Examples

To list the available realm flags for the realm CONTOSO, type:

```
ksetup /listrealmflags
```

To remove two flags currently in the set, type:

```
ksetup /delrealmflags CONTOSO ncsupported delegate
```

To verify the realm flags have been removed, type `ksetup` and then view the output, looking for the text, **Realm flags =**.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup listrealmflags command](ksetup-listrealmflags.md)

- [ksetup setrealmflags command](ksetup-setrealmflags.md)

- [ksetup addrealmflags command](ksetup-addrealmflags.md)

- [ksetup dumpstate command](ksetup-dumpstate.md)
