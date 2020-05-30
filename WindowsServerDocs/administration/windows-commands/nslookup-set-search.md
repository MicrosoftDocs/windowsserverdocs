---
title: nslookup set search
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 064ac660-8b04-4af9-8b2c-e4e0549771b8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# nslookup set search



Appends the Domain Name System (DNS) domain names in the DNS domain search list to the request until an answer is received. This applies when the set and the lookup request contain at least one period, but do not end with a trailing period.

## Syntax

```
set [no]search
```

### Parameters

|  Parameter   |                                                                          Description                                                                          |
|--------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **nosearch** |                            Stops appending the Domain Name System (DNS) domain names in the DNS domain search list to the request.                            |
|  **search**  | Appends the Domain Name System (DNS) domain names in the DNS domain search list to the request until an answer is received. The default syntax is **search**. |
|    {help     |                                                                              ?}                                                                               |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)