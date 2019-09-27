---
title: Set metadata
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
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

## Parameters

|Parameter|Description|
|---------|-----------|
|[\<Drive>:][<Path>]|Specifies the location to create the metadata file.|
|\<MetaData.cab>|Specifies the name of the cab file to store shadow creation metadata.|

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)