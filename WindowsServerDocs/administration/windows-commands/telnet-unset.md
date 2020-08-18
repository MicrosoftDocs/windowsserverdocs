---
title: telnet unset
description: Reference article for telnet unset, which turns off previously set options.
ms.topic: reference
ms.assetid: da9a0d99-1930-4858-93c7-0e9c3797ee09
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# telnet: unset

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Turns off previously set options.

## Syntax
```
u[nset] {bsasdel | crlf | delasbs | escape | localecho | logging | ntlm} [?]
```
#### Parameters
|Parameter|Description|
|-------|--------|
|bsasdel|Sends **Backspace** as a **Backspace**.|
|crlf|Sends the **Enter** key as a CR. Also known as line feed mode.|
|delasbs|Sends **delete** as **delete**.|
|escape|removes the escape character setting.|
|localecho|Turns off localecho.|
|logging|Turns off logging.|
|ntlm|Turns off NTLM authentication.|
|?|Displays help for this command.|
## Examples
Turn off logging.
```
u logging
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
