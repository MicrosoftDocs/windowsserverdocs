---
title: bitsadmin peercaching and setconfigurationflags
description: Windows Commands topic for **bitsadmin peercaching** and **setconfigurationflags**, which sets the configuration flags that determine if the computer can serve content to peers and if it can download content from peers.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: ff0a2b49-66e3-4d40-824c-6a3816055d2e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin peercaching and setconfigurationflags

Sets the configuration flags that determine if the computer can serve content to peers and if it can download content from peers.

## Syntax

```
bitsadmin /peercaching /setconfigurationflags <job> <value>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| value | An unsigned integer with the following interpretation for the bits in the binary representation:<ul><li> To allow the job's data to be downloaded from a peer, set the least significant bit.</li><li>To allow the job's data to be served to peers, set the second bit from the right.</li></ul>|

## <a name=BKMK_examples></a>Examples

The following example specifies the job's data to be downloaded from peers for the job named *myDownloadJob*.

```
C:\> bitsadmin /peercaching /setconfigurationflags myDownloadJob 1
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)