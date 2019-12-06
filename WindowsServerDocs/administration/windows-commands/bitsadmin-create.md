---
title: bitsadmin create
description: "Windows Commands topic for **bitsadmin create** - creates a transfer job with the given display name."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a8c53af-900b-4c24-9265-5b8b08213fac
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin create

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a transfer job with the given display name. Download jobs transfer data from a server to a local file. Upload jobs transfer data from a local file to a server. Upload-reply jobs transfer data from a local file to a server, and receive a reply file from the server.

Use the [bitsadmin resume](bitsadmin-resume.md) switch to activate the job in the transfer queue.

## Syntax

```
bitsadmin /create [type] DisplayName
```

## Parameters

|Parameter|Description|
|-------|--------|
|type|-   **/Download** transfers data from a server to a local file.<br />-   **/Upload** transfers data from a local file to a server.<br />-   **/Upload-Reply** transfers data from a local file to a server and receives a reply file from the server.<br />-   This parameter defaults to **/Download** when not specified on the command line.|
|DisplayName|The display name assigned to the newly created job.|

**BITS 1.2 and earlier**: The /Upload and /Upload-Reply types are not available.

## <a name="BKMK_examples"></a>Examples

Creates a download job named *myDownloadJob*.

```
C:\>bitsadmin /create myDownloadJob
```

## additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
