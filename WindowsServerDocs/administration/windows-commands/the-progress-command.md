---
title: Using the progress command
description: Reference article for progress, which displays progress while a command is running.
ms.topic: reference
ms.assetid: 8ce5e77b-e13f-4ac3-948d-31770a6c7e25
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Using the progress command

Displays progress while a command is running. You can use **/progress** with any other WDSUTIL commands that you run. Note that you must specify **/verbose** and **/progress** directly after **WDSUTIL**.

## Syntax

```
WDSUTIL /progress <commands>
```

## Examples

To initialize the server and display progress, type:
```
WDSUTIL /Verbose /Progress /Initialize-Server /Server:MyWDSServer /RemInst:C:\RemoteInstall
```