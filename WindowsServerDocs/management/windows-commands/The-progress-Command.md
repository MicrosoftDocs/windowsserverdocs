---
title: The progress Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ce5e77b-e13f-4ac3-948d-31770a6c7e25author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# The progress Command
Displays progress while a command is being executed. You can use **/progress** with any other WDSUTIL commands that you run. Note that you must specify **/verbose** and **/progress** directly after **WDSUTIL**.
## Syntax
```
WDSUTIL /progress <commands>
```
## Examples
To initialize the server and display progress, type:
```
WDSUTIL /Verbose /Progress /Initialize-Server /Server:MyWDSServer /RemInst:"C:\RemoteInstall"
```
