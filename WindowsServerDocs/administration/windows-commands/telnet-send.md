---
title: telnet send
description: Reference article for telnet send, which sends telnet commands to the telnet server.
ms.topic: reference
ms.assetid: 7c217abc-1182-466e-914c-1ff16755021b
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# telnet: send

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends telnet commands to the telnet server.

## Syntax
```
sen[d] {ao | ayt | brk | esc | ip | synch | <string>} [?]
```
#### Parameters

| Parameter |                     Description                      |
|-----------|------------------------------------------------------|
|    ao     |       Sends the telnet command  Abort Output.        |
|    ayt    |       Sends the telnet command  Are You There.       |
|    brk    |            Sends the telnet command  brk.            |
|    esc    |      Sends the current telnet escape character.      |
|    ip     |     Sends the telnet command  Interrupt Process.     |
|   synch   |           Sends the telnet command  synch.           |
| <string>  | Sends whatever string you type to the telnet server. |
|     ?     |     Displays help associated with this command.      |

## Examples
Send  Are you there to the telnet server.
```
sen ayt
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
