---
title: bitsadmin util and repairservice
description: "Windows Commands topic for **bitsadmin util and repairservice** - Commmand used to fix known issues with various versions of BITS service."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ac7baeb-4340-4186-bfcb-66478195378d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# bitsadmin util and repairservice

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Commmand used to fix known issues with various versions of BITS service.

## Syntax

```
bitsadmin /Util /RepairService [/Force]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Force|Optional—deletes and recreates the service.|

## Remarks

This command resolves errors related to incorrect service configuration and dependencies on Windows services and the network directory. This command generates output that indicates if the issues that were resolved.

> [!NOTE]
> that if BITS recreates the service, the service description string may be set to English in a localized system.

> [!IMPORTANT]
> This command is not supported on Windows Vista.

## <a name="BKMK_examples"></a>Examples

The following example repairs the BITS Service configuration.
```
C:\>bitsadmin /Util /RepairService
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)