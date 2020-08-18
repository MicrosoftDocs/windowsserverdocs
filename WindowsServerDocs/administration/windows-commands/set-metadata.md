---
title: Set metadata
description: Reference article for set metadata, which sets the name and location of the shadow creation metadata file used to transfer shadow copies from one computer to another.
ms.topic: reference
ms.assetid: 67e6f60a-b42a-451a-95cf-b22ace7d50c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Set metadata

Sets the name and location of the shadow creation metadata file used to transfer shadow copies from one computer to another. If used without parameters, **set metadata** displays help at the command prompt.

## Syntax

```
set metadata [<Drive>:][<Path>]<MetaData.cab>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|[\<Drive>:][<Path>]|Specifies the location to create the metadata file.|
|\<MetaData.cab>|Specifies the name of the cab file to store shadow creation metadata.|

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)