---
title: wdsutil progress
description: Reference article for wdsutil progress, which displays progress while a command is running.
ms.topic: reference
ms.assetid: 8ce5e77b-e13f-4ac3-948d-31770a6c7e25
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil /progress

Displays progress while a command is running. You can use **/progress** with any other wdsutil commands that you run. If you want to turn on verbose logging for this command, you must specify **/verbose** and **/progress** directly after **wdsutil**.

## Syntax

```
wdsutil /progress <commands>
```

## Examples

To initialize the server and display progress, type:

```
wdsutil /verbose /progress /Initialize-Server /Server:MyWDSServer /RemInst:C:\RemoteInstall
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)