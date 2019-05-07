---
title: tpmtool
description: "Windows Commands topic for tpmtool - gets information about the Trusted Platform Module."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
author: ashleytqy
ms.author: ashleytqy
manager: ronaldai
ms.date: 05/07/2019
---
# tpmtool

This utility can be used to get information about the [Trusted Platform Module (TPM)](https://docs.microsoft.com/windows/security/information-protection/tpm/trusted-platform-module-overview).

For examples of how to use this command, see [Examples](#tpmtool_examples).

## Syntax

```
tpmtool /parameter [<arguments>]
```
## Parameters

|Parameter|Description|
|---------|-----------|
|getdeviceinformation|Displays the basic information of the TPM.|
|gatherlogs [output directory path]|Collects TPM logs and places them in the specified directory. If path is not specified, will default to current directory.|
|/?|Displays help at the command prompt.|

## <a name="tpmtool_examples"></a>Examples

To display the basic information of the TPM, type:
```
tpmtool getdeviceinformation
```
To collects TPM logs and place them in the current directory, type:
```
tpmtool gatherlogs
```
To collects TPM logs and place them in `C:\Users\Public`, type:
```
tpmtool gatherlogs C:\Users\Public
```
