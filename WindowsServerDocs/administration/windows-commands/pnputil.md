---
title: pnputil
description: Reference article for the pnputil command, which adds driver packages, removes driver packages, and lists driver packages that are in the driver store, using the pnputil.exe utility.
ms.topic: reference
ms.assetid: fab686b8-09d3-4f6c-afa2-630e6036f44c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# pnputil

Pnputil.exe is a command line utility that you can use to manage the driver store. You can use this command to add driver packages, remove driver packages, and list driver packages that are in the store.

## Syntax

```
pnputil.exe [-f | -i] [ -? | -a | -d | -e ] <INF name>
```

### Parameters

| Parameter | Description |
|--|--|
| -a | Specifies to add the identified INF file. |
| -d | Specifies to delete the identified INF file. |
| -e | Specifies to enumerate all third-party INF files. |
| -f | Specifies to force the deletion of the identified INF file. Can't be used in conjunction with the **–i** parameter. |
| -i | Specifies to install the identified INF file. Can't be used in conjunction with  the **-f** parameter. |
| /? | Displays help at the command prompt. |

### Examples

To add an INF file, named USBCAM.INF, type:

```
pnputil.exe -a a:\usbcam\USBCAM.INF
```

To add all INF files, located in c:\drivers, type:

```
pnputil.exe -a c:\drivers\*.inf
```

To add and install the USBCAM.INF driver, type:

```
pnputil.exe -i -a a:\usbcam\USBCAM.INF
```

To enumerate all third-party drivers, type:

```
pnputil.exe –e
```

To delete the INF file and driver named oem0.inf, type:

```
pnputil.exe -d oem0.inf
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [popd command](popd.md)
