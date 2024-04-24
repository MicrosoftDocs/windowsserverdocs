---
title: ksetup delkdc
description: Reference article for the ksetup delkdc command, which deletes instances of Key Distribution Center (KDC) names for the Kerberos realm.
ms.topic: reference
ms.assetid: 7d6ec389-094c-4a7b-a78b-605497ddc289
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup delkdc

Deletes instances of Key Distribution Center (KDC) names for the Kerberos realm.

The mapping is stored in the registry, under `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\Kerberos\Domains`. After running this command, we recommend making sure the KDC was removed and no longer appears in the list.

> [!NOTE]
> To remove realm configuration data from multiple computers, use the **Security Configuration Template** snap-in with policy distribution, instead of using the **ksetup** command explicitly on individual computers.

## Syntax

```
ksetup /delkdc <realmname> <KDCname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<realmname>` | Specifies the uppercase DNS name, such as CORP.CONTOSO.COM. This is the default realm that appears when you run the **ksetup** command, and it's the realm from which you want to delete the KDC. |
| `<KDCname>` | Specifies the case-sensitive, fully-qualified domain name, such as mitkdc.contoso.com. |

### Examples

To view all of the associations between the Windows realm and the non-Windows realm, and to determine which ones to remove, type:

```
ksetup
```

To remove the association, type:

```
ksetup /delkdc CORP.CONTOSO.COM mitkdc.contoso.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup addkdc command](ksetup-addkdc.md)