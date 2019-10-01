---
title: list shadows
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe568423-00ae-4ede-a1e7-07977cb50ad1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# list shadows



Lists persistent and existing non-persistent shadow copies that are on the system.

## Syntax

```
list shadows {all | set <SetID> | id <ShadowID>}
```

## Parameters

|Parameter|Description|
|---------|-----------|
|all|Lists all shadow copies.|
|set \<SetID>|Lists shadow copies that belong to the specified Shadow Copy Set ID.|
|id \<ShadowID>|Lists any shadow copy with the specified shadow copy ID.|

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)