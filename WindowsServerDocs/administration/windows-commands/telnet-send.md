---
title: telnet send
description: Reference article for the telnet send command, which sends telnet commands to the telnet server.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# telnet: send



Sends telnet commands to the telnet server.

## Syntax

```
sen {ao | ayt | brk | esc | ip | synch | <string>} [?]
```

### Parameters

| Parameter | Description |
|--|--|
| ao | Sends the telnet command **Abort Output**. |
| ayt | Sends the telnet command **Are You There?** |
| brk | Sends the telnet command **brk**. |
| esc | Sends the current telnet escape character. |
| ip | Sends the telnet command **Interrupt Process**. |
| synch | Sends the telnet command synch. |
| `<string>` | Sends whatever string you type to the telnet server. |
| ? | Displays help associated with this command. |

## Example

To send the **Are you there?** command to the telnet server, type:

```
sen ayt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
