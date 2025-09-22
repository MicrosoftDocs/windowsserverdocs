---
title: nslookup set search
description: Reference article for the nslookup set search command, which appends the Domain Name System (DNS) domain names in the DNS domain search list to the request until an answer is received.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# nslookup set search

Appends the Domain Name System (DNS) domain names in the DNS domain search list to the request until an answer is received. This applies when the set and the lookup request contain at least one period, but do not end with a trailing period.

## Syntax

```
set [no]search
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| nosearch | Stops appending the Domain Name System (DNS) domain names in the DNS domain search list for the request. |
| search | Appends the Domain Name System (DNS) domain names in the DNS domain search list for the request until an answer is received. This is the default value. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
