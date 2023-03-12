---
title: bitsadmin reset
description: "Windows Commands topic for **bitsadmin reset** - Cancels all jobs in the transfer queue that the current user owns."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e4f9d1d-072c-493f-8d7a-f6d713c3ef29
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin reset

Cancels all jobs in the transfer queue that the current user owns.

**BITSAdmin 1.5 and earlier**: If you have administrator privileges, **Reset** cancels all jobs in the queue. The /AllUsers option is not supported.

## Syntax

```
bitsadmin /Reset [/AllUsers]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|AllUsers|Optional— cancels all jobs in the queue.|

## Remarks

You must have administrator privileges to use the **AllUsers** parameter.

> [!NOTE]
> Administrators cannot reset jobs created by Local System. Use the task scheduler to schedule this command as a task using the Local System credentials.

## <a name="BKMK_examples"></a>Examples

The following example cancels all the jobs in the transfer queue for the current user.
```
C:\>bitsadmin /Reset
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)