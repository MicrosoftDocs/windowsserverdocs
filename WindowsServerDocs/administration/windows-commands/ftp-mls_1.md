---
title: ftp mls
description: Reference article for the ftp mls command, which displays an abbreviated list of files and subdirectories in a remote directory.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# ftp mls



Displays an abbreviated list of files and subdirectories in a remote directory.

## Syntax

```
mls <remotefile>[ ] <localfile>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the file for which you want to see a listing. When specifying *remotefiles*, use a hyphen to represent the current working directory on the remote computer. |
| `<localfile>` | Specifies a local file in which to store the listing. When specifying *localfile*, use a hyphen to display the listing on the screen. |

### Examples

To display an abbreviated list of files and subdirectories for *dir1* and *dir2*, type:

```
mls dir1 dir2 -
```

To save an abbreviated list of files and subdirectories for *dir1* and *dir2* in the local file *dirlist.txt*, type:

```
mls dir1 dir2 dirlist.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
