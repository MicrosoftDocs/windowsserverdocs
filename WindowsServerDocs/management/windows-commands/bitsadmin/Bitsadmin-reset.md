---
title: Bitsadmin reset
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e4f9d1d-072c-493f-8d7a-f6d713c3ef29
---
# Bitsadmin reset
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
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


