---
title: telnet open
description: Reference article for telnet open, which connects to a telnet server.
s.topic: article
ms.assetid: e30ad68c-2366-4754-ac36-311a2392902a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# telnet: open

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Connects to a telnet server.

## Syntax
```
o[pen] <hostname> [<Port>]
```
#### Parameters

| Parameter  |                                        Description                                         |
|------------|--------------------------------------------------------------------------------------------|
| <hostname> |                         Specifies the computer name or IP address.                         |
|  [<Port>]  | Specifies the TCP port that the telnet server is listening on. The default is TCP port 23. |

## Examples
Connect to a telnet server at telnet.microsoft.com.
```
o telnet.microsoft.com
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
