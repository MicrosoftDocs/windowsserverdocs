---
title: nfsstat
description: Reference article for the nfsstat command, which displays statistical info about the Network File System (NFS) and Remote Procedure Call (RPC) calls.
ms.topic: reference
ms.assetid: da7a9768-44bd-404b-97ee-c388d00dc395
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nfsstat

A command-line utility that displays statistical info about the Network File System (NFS) and Remote Procedure Call (RPC) calls. Used without parameters, this command displays all of the statistical data without resetting anything.

## Syntax

```
nfsstat [-c][-s][-n][-r][-z][-m]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -c | Displays only the client-side NFS and RPC and NFS calls sent and rejected by the client. To display NFS or RPC information only, combine this flag with the **-n** or **-r** parameter. |
| -s | Displays only the server-side NFS and RPC and NFS calls sent and rejected by the server. To display NFS or RPC information only, combine this flag with the **-n** or **-r** parameter. |
| -m | Displays information about mount flags set by mount options, mount flags internal to the system, and other mount information. |
| -n | Displays NFS information for both the client and server. To display only the NFS client or server information, combine this flag with the **-c** or **-s** parameter. |
| -r | Displays RPC information for both the client and server. To display only the RPC client or server information, combine this flag with the **-c** or **-s** parameter. |
| -z | Resets the call statistics. This flag is only available to the root user and can be combined with any of the other parameters to reset particular sets of statistics after displaying them. |

### Examples

To display information about the number of RPC and NFS calls sent and rejected by the client, type:

```
nfsstat -c
```

To display and print the client NFS call-related information, type:

```
nfsstat -cn
```

To display RPC call-related information for both the client and server, type:

```
nfsstat -r
```

To display information about the number of RPC and NFS calls received and rejected by the server, type:

```
nfsstat -s
```

To reset all call-related information to zero on the client and server, type:

```
nfsstat -z
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Services for Network File System Command Reference](services-for-network-file-system-command-reference.md)

- [NFS cmdlets reference](/powershell/module/nfs)
