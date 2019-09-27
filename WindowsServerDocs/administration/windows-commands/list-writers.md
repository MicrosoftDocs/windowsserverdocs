---
title: list writers
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1c30cbc4-f568-4fa7-b564-66c41d3ca82d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# list writers



Lists writers that are on the system. If used without parameters, **list** displays the output for **list metadata** by default.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
list writers [metadata | detailed | status]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|metadata|Lists the identity and status of writers, and displays metadata such as component details and excluded files. This is the default parameter.|
|detailed|Lists the same information as **metadata**, but **detailed** includes the full file list for all components.|
|status|Lists only the identity and status of registered writers.|

## <a name="BKMK_examples"></a>Examples

To list only the identity and status of writers, type:
```
list writers status
```
Output that is similar to the following displays:
```
Listing writer status ...
* WRITER "System Writer"
        - Status: 5 (VSS_WS_WAITING_FOR_BACKUP_COMPLETE)
        - Writer Failure code: 0x00000000 (S_OK)
        - Writer ID: {e8132975-6f93-4464-a53e-1050253ae220}
        - Instance ID: {7e631031-c695-4229-9da1-a7de057e64cb}
* WRITER "Shadow Copy Optimization Writer"
        - Status: 1 (VSS_WS_STABLE)
        - Writer Failure code: 0x00000000 (S_OK)
        - Writer ID: {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f}
        - Instance ID: {9e362607-9794-4dd4-a7cd-b3d5de0aad20}
...
...
...
* WRITER "Registry Writer"
        - Status: 1 (VSS_WS_STABLE)
        - Writer Failure code: 0x00000000 (S_OK)
        - Writer ID: {afbab4a2-367d-4d15-a586-71dbb18f8485}
        - Instance ID: {e87ba7e3-f8d8-42d8-b2ee-c76ae26b98e8}
8 writers listed. 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)