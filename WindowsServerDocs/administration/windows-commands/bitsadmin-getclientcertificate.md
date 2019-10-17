---
title: bitsadmin getclientcertificate
description: "Windows Commands topic for **bitsadmin getclientcertificate** - Retrieves the client certificate from the job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fc8f408-085e-43a0-9fa8-3d798ef107b1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getclientcertificate



Retrieves the client certificate from the job.

## Syntax

```
bitsadmin /GetClientCertificate <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the client certificate for the job named *myDownloadJob*.
```
C:\>bitsadmin / GetClientCertificate myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)