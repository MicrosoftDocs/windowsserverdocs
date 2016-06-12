---
title: bitsadmin create
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a8c53af-900b-4c24-9265-5b8b08213fac
---
# bitsadmin create
creates a transfer job with the given display name.

## Syntax

```
bitsadmin /create [type] DisplayName
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|type|-   **\/Download**—transfers data from a server to a local file.<br />-   **\/Upload**—transfers data from a local file to a server.<br />-   **\/Upload\-Reply**—transfers data from a local file to a server and receives a reply file from the server.<br />-   This parameter defaults to **\/Download** when not specified on the command line.|
|DisplayName|The display name assigned to the newly created job.|

Use the [bitsadmin resume](bitsadmin-resume.md) switch to activate the job in the transfer queue.

## <a name="BKMK_examples"></a>Examples
creates a download job named *myDownloadJob*.

```
C:\>bitsadmin /create myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


