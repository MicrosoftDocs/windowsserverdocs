---
title: fsutil volume
description: Reference article for the fsutil devdrv command, which groups lots of dev drive related functionalites.
manager: nealch
ms.author: chandkv
author: chandkv
ms.assetid: 0397c204-b3f8-4fd8-b71d-b7efb117766d
ms.topic: reference
ms.date: 08/29/2023
---

# fsutil devdrv

>Applies to: Windows 11

Dev drive or a developer volume is a volume that is tuned for performance of developer scenarios. This also lets an administrator of the device control the file system minifilters that are attached to the volume.

## Devdrv commands supported

| Command | Description |
| ------- | ----------- |
| query               | Query dev drive information. |
| enable              | Enable dev drive support on this machine. |
| disable             | Disable dev drive support on this machine. |
| trust               | Trust the given dev drive. |
| untrust             | Untrust the given dev drive. |
| setFiltersAllowed   | Set the list of allowed filters for dev drive. |
| clearFiltersAllowed | Clear the list of allowed filters for dev drive. |


## fsutil devdrv query
Query information about dev drives in general or the given dev drive.
### Syntax
```
fsutil devdrv query [<volume path>]
```
### Examples
To query information about dev drives, in general, on this system.
```
fsutil devdrv query
```
To query dev drive related information for `D:`.
```
fsutil devdrv query D:
```

## fsutil devdrv enable
Enable developer volume support on this machine.
### Syntax
```
fsutil devdrv enable [/allowAv|/disallowAv]
```
### Examples
To enable dev drive and let the system decide whether to allow antivirus filter to attach on a dev drive.
```
fsutil devdrv enable
```
To enabled dev drive while allowing antivirus filter to be attached on a dev drive.
```
fsutil devdrv enable /allowAv
```
To enabled dev drive without allowing antivirus filter to be attached on a dev drive.
```
fsutil devdrv enable /disallowAv
```

## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [fsutil](fsutil.md)
- [Dev Drive](https://learn.microsoft.com/en-us/windows/dev-drive/)
