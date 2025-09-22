---
title: telnet unset
description: Reference article for the telnet unset command, which turns off previously set options.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# telnet: unset



Turns off previously set options.

## Syntax

```
u {bsasdel | crlf | delasbs | escape | localecho | logging | ntlm} [?]
```

### Parameters

| Parameter | Description |
|--|--|
| bsasdel | Sends **backspace** as a **backspace**. |
| crlf | Sends the **Enter** key as a CR. Also known as line feed mode. |
| delasbs | Sends **delete** as **delete**. |
| escape | Removes the escape character setting. |
| localecho | Turns off localecho. |
| logging | Turns off logging. |
| ntlm | Turns off NTLM authentication. |
| ? | Displays help for this command. |

## Example

Turn off logging.

```
u logging
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
