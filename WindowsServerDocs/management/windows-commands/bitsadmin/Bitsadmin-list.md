---
title: bitsadmin list
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1416965e-e0e6-49cf-b1d4-b286d3cf8716
---
# bitsadmin list
lists the transfer jobs owned by the current user.

## Syntax

```
bitsadmin /list [/allusers][/verbose]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/Allusers|Optional—lists jobs for all users|
|\/verbose|Optional—provides detail information for each job.|

## remarks
You must have administrator privileges to use the \/allusers parameter

## <a name="BKMK_examples"></a>Examples
The following example retrieves information about jobs owned by the current user.

```
C:\>bitsadmin /list 
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


