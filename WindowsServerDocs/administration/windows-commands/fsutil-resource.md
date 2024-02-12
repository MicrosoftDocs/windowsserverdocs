---
title: fsutil resource
description: Reference article for the fsutil resource command, which manages a Transactional Resource Manager and its behavior.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: b198d8ca-a5b7-430f-8911-5cbb9f50484c
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil resource

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Creates a Secondary Transactional Resource Manager, starts or stops a Transactional Resource Manager, or displays information about a Transactional Resource Manager, and modifies the following behavior:

- Whether a default Transactional Resource Manager cleans its transactional metadata at the next mount.

- The specified Transactional Resource Manager to prefer consistency over availability.

- The specified Transaction Resource Manager to prefer availability over consistency.

- The characteristics of a running Transactional Resource Manager.

## Syntax

```
fsutil resource [create] <rmrootpathname>
fsutil resource [info] <rmrootpathname>
fsutil resource [setautoreset] {true|false} <Defaultrmrootpathname>
fsutil resource [setavailable] <rmrootpathname>
fsutil resource [setconsistent] <rmrootpathname>
fsutil resource [setlog] [growth {<containers> containers|<percent> percent} <rmrootpathname>] [maxextents <containers> <rmrootpathname>] [minextents <containers> <rmrootpathname>] [mode {full|undo} <rmrootpathname>] [rename <rmrootpathname>] [shrink <percent> <rmrootpathname>] [size <containers> <rmrootpathname>]
fsutil resource [start] <rmrootpathname> [<rmlogpathname> <tmlogpathname>
fsutil resource [stop] <rmrootpathname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| create | Creates a secondary Transactional Resource Manager. |
| `<rmrootpathname>` | Specifies the full path to a Transactional Resource Manager root directory. |
| info | Displays the specified Transactional Resource Manager's information. |
| setautoreset | Specifies whether a default Transactional Resource Manager will clean the transactional metadata on the next mount.<ul><li>**true** - Specifies that the Transaction Resource Manager will clean the transactional metadata on the next mount, by default.</li><li>**false** - Specifies that the Transaction Resource Manager will not clean the transactional metadata on the next mount, by default. |
| `<defaultrmrootpathname>` | Specifies the drive name followed by a colon. |
| setavailable | Specifies that a Transactional Resource Manager will prefer availability over consistency. |
| setconsistent | Specifies that a Transactional Resource Manager will prefer consistency over availability. |
| setlog | Changes the characteristics of a Transactional Resource Manager that is already running. |
| growth | Specifies the amount by which the Transactional Resource Manager log can grow.<p>The growth parameter can be specified as follows:<ul><li>Number of containers, using the format: `<containers> containers`</li><li>Percentage, using the format: `<percent> percent`</li></ul> |
| `<containers>` | Specifies the data objects that are used by the Transactional Resource Manager. |
| maxextent | Specifies the maximum number of containers for the specified Transactional Resource Manager. |
| minextent | Specifies the minimum number of containers for the specified Transactional Resource Manager. |
| mode `{full|undo}` | Specifies whether all transactions are logged ( **full**) or only rolled back events are logged (**undo**). |
| rename | Changes the GUID for the Transactional Resource Manager. |
| shrink | Specifies percentage by which the Transactional Resource Manager log can automatically decrease. |
| size | Specifies the size of the Transactional Resource Manager as a specified number of *containers*. |
| start | Starts the specified Transactional Resource Manager. |
| stop | Stops the specified Transactional Resource Manager. |

### Examples

To set the log for the Transactional Resource Manager that is specified by *c:\test*, to have an automatic growth of five containers, type:

```
fsutil resource setlog growth 5 containers c:test
```

To set the log for the Transactional Resource Manager that is specified by *c:\test*, to have an automatic growth of two percent, type:

```
fsutil resource setlog growth 2 percent c:test
```

To specify that the default Transactional Resource Manager will clean the transactional metadata on the next mount on drive C, type:

```
fsutil resource setautoreset true c:\
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)

- [Transactional NTFS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc730726(v=ws.10))
