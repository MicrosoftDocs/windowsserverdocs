---
title: The verbose Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcf30ae7-818f-4e7e-a083-a1812682032b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# The verbose Command

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays verbose output for a specified command. You can use **/verbose** with any other wdsutil commands that you run. Note that you must specify **/verbose** and **/progress** directly after **wdsutil**.
## Syntax
```
wdsutil /verbose <commands>
```
## Examples
To delete approved computers from the Auto-add database and show verbose output, type:
```
wdsutil /verbose /progress /delete-AutoaddDevices /Server:MyWDSServer /Devicetype:ApprovedDevices
```
