---
title: ksetup setrealmflags
description: Reference article for the ksetup setrealmflags command, which sets realm flags for the specified realm.
ms.topic: reference
ms.assetid: bcb2824e-fba7-4ebe-be62-e62b4fae5b17
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup setrealmflags

Sets realm flags for the specified realm.

## Syntax

```
ksetup /setrealmflags <realmname> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM. |

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

- Realm flags are stored in the registry under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Domains\<realmname>`. This entry doesn't exist in the registry by default. You can use the [ksetup addrealmflags](ksetup-addrealmflags.md) command to populate the registry.

- You can see the available and set realm flags by viewing the output of **ksetup** or `ksetup /dumpstate`.

### Examples

To list the available, and to set realm flags for the realm CONTOSO, type:

```
ksetup
```

To set two flags that aren't currently set, type:

```
ksetup /setrealmflags CONTOSO ncsupported delegate
```

To verify the realm flag is set, type `ksetup` and then view the output, looking for the text, **Realm flags =**. If you don't see the text, it means that the flag hasn't been set.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup listrealmflags command](ksetup-listrealmflags.md)

- [ksetup addrealmflags command](ksetup-addrealmflags.md)

- [ksetup delrealmflags command](ksetup-delrealmflags.md)

- [ksetup dumpstate command](ksetup-dumpstate.md)
