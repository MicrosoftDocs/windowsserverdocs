---
title: mask
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf301474-d74a-44e7-9fad-c8a11e7ca3bd
---
# mask
removes hardware shadow copies that were imported by using the **import** command.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
mask <shadowSetID>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|shadowSetID|removes shadow copies that belong to the specified shadow copy Set ID.|

## remarks

-   You can use an existing alias or an environment variable in place of *shadowSetID*. Use **add** without parameters to see existing aliases.

## <a name="BKMK_examples"></a>Examples
To remove the imported shadow copy %import\_1%, type:

```
mask %import_1%
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


