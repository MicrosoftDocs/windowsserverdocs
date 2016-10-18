---
title: Bitsadmin reset
description: "Windows Commands topic for **Bitsadmin reset** -- Cancels all jobs in the transfer queue that the current user owns."
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
ms.date: 10/12/2016
---

# Bitsadmin reset

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Cancels all jobs in the transfer queue that the current user owns.
## Syntax
```
bitsadmin /Reset [/AllUsers]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|AllUsers|Optional— cancels all jobs in the queue.|
## Remarks
You must have administrator privileges to use the **AllUsers** parameter.
> [!NOTE]
> Administrators cannot reset jobs created by Local System. Use the task scheduler to schedule this command as task using the Local System credentials.
## <a name="BKMK_examples"></a>Examples
The following example cancels all the jobs in the transfer queue for the current user.
```
C:\>bitsadmin /Reset
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
