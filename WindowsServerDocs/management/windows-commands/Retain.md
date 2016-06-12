---
title: retain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eeab0aef-2ba5-441a-a10d-bbef6f0d7e3e
---
# retain
Prepares an existing dynamic simple volume to be used as a boot or system volume.

## Syntax

```
retain
```

## remarks

-   On a master boot record \(MBR\) dynamic disk, this command creates a partition entry in the master boot record.

-   On a GUID partition table \(gpt\) dynamic disk, this command creates a partition entry in the GUID partition table.

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)


