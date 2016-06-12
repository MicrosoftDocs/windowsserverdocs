---
title: serverweroptin
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3c0b0af-cafb-4f09-8b36-5a357ddf392d
---
# serverweroptin
Allows you to enable error reporting.

## Syntax

```
serverweroptin [/query] [/detailed] [/summary]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/query|verifies the current setting.|
|\/detailed|Sends detailed reports automatically.|
|\/summary|Sends summary reports automatically.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To verify the current setting, type:

```
serverweroptin /query
```

To automatically send detailed reports, type:

```
serverweroptin /detailed
```

To automatically send summary reports, type

```
serverweroptin /summary
```

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)

-   [Command-Line Reference_1](Command-Line-Reference_1.md)


