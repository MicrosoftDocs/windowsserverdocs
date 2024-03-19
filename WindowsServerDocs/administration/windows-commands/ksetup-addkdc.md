---
title: ksetup addkdc
description: Reference article for the ksetup addkdc command, which ads a Key Distribution Center (KDC) address for the given Kerberos realm.
ms.topic: reference
ms.assetid: 98bfc23a-14c4-401c-bcb3-9903c5cdde64
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup addkdc

Adds a Key Distribution Center (KDC) address for the given Kerberos realm

The mapping is stored in the registry, under **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\Kerberos\Domains** and the computer must be restarted before the new realm setting will be used.

> [!NOTE]
> To deploy Kerberos realm configuration data to multiple computers, you must use the **Security Configuration Template** snap-in and policy distribution, explicitly on individual computers. You can't use this command.

## Syntax

```
ksetup /addkdc <realmname> [<KDCname>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM. This value also appears as the default realm when **ksetup** is run, and is the realm to which you want to add the other KDC. |
| `<KDCname>` | Specifies the case-insensitive, fully-qualified domain name, such as mitkdc.contoso.com. If the KDC name is omitted, DNS will locate KDCs. |

### Examples

To configure a non-Windows KDC server and the realm that the workstation should use, type:

```
ksetup /addkdc CORP.CONTOSO.COM mitkdc.contoso.com
```

To set the local computer account password to p@sswrd1% on the same computer as in the previous example, and then to restart the computer, type:

```
ksetup /setcomputerpassword p@sswrd1%
```

To verify the default realm name for the computer or to verify that this command worked as intended, type:

```
ksetup
```
Check the registry to make sure the mapping occurred as intended.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup setcomputerpassword command](ksetup-setcomputerpassword.md)
