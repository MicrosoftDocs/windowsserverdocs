---
title: nslookup set srchlist
description: Reference article for the nslookup set srchlist command, which changes the default Domain Name System (DNS) domain name and search list.
ms.topic: reference
ms.assetid: 8486266d-22ac-4ce5-aad6-1cd0c08110a2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup set srchlist

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the default Domain Name System (DNS) domain name and search list. This command overrides the default DNS domain name and search list of the [nslookup set domain](nslookup-set-domain.md) command.

## Syntax

```
set srchlist=<domainname>[/...]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<domainname>` | Specifies new names for the default DNS domain and search list. The default domain name value is based on the host name. You can specify a maximum of six names separated by slashes (/). |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

#### Remarks

- Use the [nslookup set all](nslookup-set-all.md) command to display the list.

### Examples

To set the DNS domain to *mfg.widgets.com* and the search list to the three names:

```
set srchlist=mfg.widgets.com/mrp2.widgets.com/widgets.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup set domain](nslookup-set-domain.md)

- [nslookup set all](nslookup-set-all.md)
