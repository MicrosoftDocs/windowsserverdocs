---
title: Using the verbose command
description: Reference article for verbose, which displays verbose output for a specified command.
ms.topic: reference
ms.assetid: fcf30ae7-818f-4e7e-a083-a1812682032b
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# Using the verbose command

Displays verbose output for a specified command. You can use **/verbose** with any other WDSUTIL commands that you run. Note that you must specify **/verbose** and **/progress** directly after **WDSUTIL**.

## Syntax

```
WDSUTIL /verbose <commands>
```

## Examples

To delete approved computers from the Auto-Add database and show verbose output, type:

```
WDSUTIL /Verbose /progress /Delete-AutoAddDevices /Server:MyWDSServer /DeviceType:ApprovedDevices
```