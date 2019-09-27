---
title: bitsadmin list
description: "Windows Commands topic for **bitsadmin list** - lists the transfer jobs owned by the current user."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1416965e-e0e6-49cf-b1d4-b286d3cf8716
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin list



Lists the transfer jobs owned by the current user.

## Syntax

```
bitsadmin /List [/allusers][/verbose]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/Allusers|Optional—lists jobs for all users|
|/Verbose|Optional—provides detailed information for each job.|

## Remarks

You must have administrator privileges to use the /allusers parameter

## <a name="BKMK_examples"></a>Examples

The following example retrieves information about jobs owned by the current user.
```
C:\>bitsadmin /List 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)