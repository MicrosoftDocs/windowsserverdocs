---
title: The verbose Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcf30ae7-818f-4e7e-a083-a1812682032b
---
# The verbose Command
Displays verbose output for a specified command. You can use **\/verbose** with any other wdsutil commands that you run. Note that you must specify **\/verbose** and **\/progress** directly after **wdsutil**.

## Syntax

```
wdsutil /verbose <commands>
```

## Examples
To delete approved computers from the Auto\-add database and show verbose output, type:

```
wdsutil /verbose /progress /delete-AutoaddDevices /Server:MyWDSServer /Devicetype:ApprovedDevices
```


