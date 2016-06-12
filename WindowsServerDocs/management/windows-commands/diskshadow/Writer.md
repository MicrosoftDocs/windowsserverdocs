---
title: writer
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7cf98295-411d-4705-8573-f898ff45c140
---
# writer
verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure. if used without parameters, **writer** displays help at the command prompt.

## Syntax

```
writer verify [<writer> | <component>]
writer exclude [<writer> | <component>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|verify|verifies that the specified writer or component is included in the backup or restore procedure. The backup or restore procedure will fail if the writer or component is not included.|
|exclude|Excludes the specified writer or component from the backup or restore procedure.|
|\[<writer> &#124; <component>\]|Specifies the writer or component to verify or exclude. writers are specified by writer GUID or by the writer name, for example "System writer."|

## <a name="BKMK_examples"></a>Examples
To verify a writer by specifying its GUID \(for this example, 4dc3bdd4\-ab48\-4d07\-adb0\-3bee2926fd7f\), type:

```
writer verify {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f}
```

To exclude a writer with the name “System writer,” type:

```
writer exclude "System writer"
```

### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


