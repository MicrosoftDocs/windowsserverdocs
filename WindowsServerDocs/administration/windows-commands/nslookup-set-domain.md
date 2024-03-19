---
title: nslookup set domain
description: Reference article for the nslookup set domain command, which changes the default Domain Name System (DNS) domain name to the specified name.
ms.topic: reference
ms.assetid: 9d4d28e8-6e88-42cc-801f-94e9d8e051f4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup set domain

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the default Domain Name System (DNS) domain name to the specified name.

## Syntax

```
set domain=<domainname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<domainname>` | Specifies a new name for the default DNS domain name. The default value is the name of the host. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

#### Remarks

- The default DNS domain name is appended to a lookup request depending on the state of the **defname** and **search** options.

- The DNS domain search list contains the parents of the default DNS domain if it has at least two components in its name. For example, if the default DNS domain is mfg.widgets.com, the search list is named both mfg.widgets.com and widgets.com.

- Use the [nslookup set srchlist](nslookup-set-srchlist.md) command to specify a different list and the [nslookup set all](nslookup-set-all.md) command to display the list.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup set srchlist](nslookup-set-srchlist.md)

- [nslookup set all](nslookup-set-all.md)
