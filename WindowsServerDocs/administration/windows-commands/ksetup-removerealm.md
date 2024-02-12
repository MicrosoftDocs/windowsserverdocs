---
title: ksetup removerealm
description: Reference article for the ksetup removerealm command, which deletes all information for the specified realm from the registry.
ms.topic: reference
ms.assetid: 39f0c6f0-4c50-4781-941e-0893495405e8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup removerealm

Deletes all information for the specified realm from the registry.

The realm name is stored in the registry under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos` and `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Lsa\Kerberos`. This entry doesn't exist in the registry by default. You can use the [ksetup addrealmflags](ksetup-addrealmflags.md) command to populate the registry.

> [!IMPORTANT]
> You can't remove the default realm name from the domain controller because this resets its DNS information, and removing it might make the domain controller unusable.

## Syntax

```
ksetup /removerealm <realmname>
```
### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or **Realm=** when **ksetup** is run. |

### Examples

To remove an erroneous realm name (.CON instead of .COM) from the local computer, type:
```
ksetup /removerealm CORP.CONTOSO.CON
```

To verify the removal, you can run the **ksetup** command and review the output.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup setrealm command](ksetup-setrealm.md)
