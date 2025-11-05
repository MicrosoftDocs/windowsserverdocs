---
title: ftp mdir
description: Reference article for the ftp mdir command, which displays a directory list of files and subdirectories in a remote directory.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# ftp mdir



Displays a directory list of files and subdirectories in a remote directory.

## Syntax

```
mdir <remotefile>[...] <localfile>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the directory or file for which you want to see a listing. You can specify multiple *remotefiles*. Type a hyphen (-) to use the current working directory on the remote computer. |
| `<localfile>` | Specifies a local file to store the listing. This parameter is required. Type a hyphen (-) to display the listing on the screen. |

### Examples

To display a directory listing of *dir1* and *dir2* on the screen, type:

```
mdir dir1 dir2 -
```

To save the combined directory listing of *dir1* and *dir2* in a local file called *dirlist.txt*, type:

```
mdir dir1 dir2 dirlist.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
