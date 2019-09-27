---
title: bitsadmin removeclientcertificate
description: "Windows Commands topic for **bitsadmin removeclientcertificate** - removes the client certificate from the job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b417c3e5-aadd-4fcc-968f-45d8b67ca516
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin removeclientcertificate



Removes the client certificate from the job.

## Syntax

```
bitsadmin /RemoveClientCertificate <Job> 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example removes the client certificate from the job named *myJob*.
```
C:\>Bitsadmin /RemoveClientCertificate myJob 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)