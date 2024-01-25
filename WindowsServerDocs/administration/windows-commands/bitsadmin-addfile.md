---
title: bitsadmin addfile
description: Reference article for the bitsadmin addfile command, which adds a file to the specified job.
ms.topic: reference
ms.assetid: 1b31aa93-0364-465b-af36-754968825989
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin addfile

Adds a file to the specified job.

## Syntax

```
bitsadmin /addfile <job> <remoteURL> <localname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| remoteURL | The URL of the file on the server. |
| localname | The name of the file on the local computer. *Localname* must contain an absolute path to the file. |

## Examples

To add a file to the job:

```
bitsadmin /addfile myDownloadJob http://downloadsrv/10mb.zip c:\10mb.zip
```

Repeat this call for each file to add. If multiple jobs use *myDownloadJob* as their name, you must replace *myDownloadJob* with the job's GUID to uniquely identify the job.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
