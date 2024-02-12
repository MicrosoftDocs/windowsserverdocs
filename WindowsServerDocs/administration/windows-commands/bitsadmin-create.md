---
title: bitsadmin create
description: Reference article for the bitsadmin create command, which creates a transfer job with the given display name.
ms.topic: reference
ms.assetid: 9a8c53af-900b-4c24-9265-5b8b08213fac
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin create

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a transfer job with the given display name.

> [!NOTE]
> The **/Upload** and **/Upload-Reply** parameter types aren't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /create [type] displayname
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| type | There are three types of jobs:<ul><li>**/Download.** Transfers data from a server to a local file.</li><li>**/Upload.** Transfers data from a local file to a server.</li><li>**/Upload-Reply.** Transfers data from a local file to a server and receives a reply file from the server.</li></ul>This parameter defaults to **/Download** if it's not specified. |
| displayname | The display name assigned to the newly created job. |

## Examples

To create a download job named *myDownloadJob*:

```
bitsadmin /create myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin resume command](bitsadmin-resume.md)

- [bitsadmin command](bitsadmin.md)
