---
title: ksetup addrealmflags
description: Reference article for the ksetup addrealmflags command that adds other realm flags to a specified realm.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---

# ksetup addrealmflags

Applies to Windows Server (All supported versions)

The ksetup addrealmflags command adds other realm flags to a specified realm.

## Syntax

```
ksetup /addrealmflags <realmname> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as `CORP.CONTOSO.COM`. |

## Remarks

- Realm flags are stored in the registry under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Domains\<realmname>`. This entry doesn't exist in the registry by default. You can use the [ksetup addrealmflags](ksetup-addrealmflags.md) command to populate the registry.

- The realm flags specify other features of a Kerberos realm that aren't based on the Windows Server operating system. Computers running Windows Server can use a Kerberos server to administer authentication in the Kerberos realm instead of using a domain running a Windows Server operating system. This registry entry establishes the features of the realm and is as follows:

| Value | Realm flag | Description |
| ----- | ---------- | ----------- |
| `0xF` | `All` | All realm flags are set. |
| `0x00` | `None` | No realm flags are set and no other features are enabled. |
| `0x01` | `sendaddress` | The IP address is included within the ticket-granting tickets. |
| `0x02` | `tcpsupported` | Both the Transmission Control Protocol (TCP) and the User Datagram Protocol (UDP) are supported in this realm. |
| `0x04` | `delegate` | Everyone in this realm is trusted for delegation. |
| `0x08` | `ncsupported` | This realm supports name canonicalization, which allows for DNS and Realm naming standards. |
| `0x80` | `rc4` | This realm supports RC4 encryption to enable cross-realm trust, which allows for the use of TLS. |

- You can see the available and set realm flags by viewing the output of **ksetup** or `ksetup /dumpstate`.

## Examples

To list the available realm flags for the realm CONTOSO, type:

```
ksetup /listrealmflags
```

To set two flags to the CONTOSO realm, type:

```
ksetup /setrealmflags CONTOSO ncsupported delegate
```

To add one more flag that isn't currently in the set, type:

```
ksetup /addrealmflags CONTOSO SendAddress
```

To verify the realm flag is set, type `ksetup` and then view the output, looking for the text, **Realm flags =**. If you don't see the text, it means that the flag hasn't been set.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup listrealmflags command](ksetup-listrealmflags.md)

- [ksetup setrealmflags command](ksetup-setrealmflags.md)

- [ksetup delrealmflags command](ksetup-delrealmflags.md)

- [ksetup dumpstate command](ksetup-dumpstate.md)
