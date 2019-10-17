---
title: retain
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eeab0aef-2ba5-441a-a10d-bbef6f0d7e3e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# retain



Prepares an existing dynamic simple volume to be used as a boot or system volume.

## Syntax

```
retain
```

## Remarks

-   On a master boot record (MBR) dynamic disk, this command creates a partition entry in the master boot record.
-   On a GUID partition table (GPT) dynamic disk, this command creates a partition entry in the GUID partition table.

#### Additional references

