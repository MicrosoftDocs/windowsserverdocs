---
title: ksetup addhosttorealmmap
description: Reference article for the ksetup addhosttorealmmap command, which adds a service principal name (SPN) mapping between the stated host and the realm.
ms.topic: reference
ms.assetid: 237742d5-fa68-466c-b97e-636f489248ea
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup addhosttorealmmap

Adds a service principal name (SPN) mapping between the stated host and the realm. This command also allows you to map a host or multiple hosts that are sharing the same DNS suffix to the realm.

The mapping is stored in the registry, under **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\HostToRealm**.

## Syntax

```
ksetup /addhosttorealmmap <hostname> <realmname>
```

### Parameters

| Parameter | Description |
| --------- |------------ |
| `<hostname>` | The host name is the computer name, and it can be stated as the computer's fully qualified domain name. |
| `<realmname>` | The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM. |

### Examples

To map the host computer *IPops897* to the *CONTOSO* realm, type:

```
ksetup /addhosttorealmmap IPops897 CONTOSO
```

Check the registry to make sure the mapping occurred as intended.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup delhosttorealmmap command](ksetup-delhosttorealmmap.md)
