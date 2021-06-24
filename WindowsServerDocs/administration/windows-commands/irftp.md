---
title: irftp
description: Reference article for the irftp command, which sends files over an infrared link.
ms.topic: reference
ms.assetid: e15c60a7-546d-4e9f-9871-43aaa1b569d6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# irftp

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends files over an infrared link.

> [!IMPORTANT]
> Make sure the devices intended to communicate over an infrared link have infrared functionality enabled and are working correctly. Also make sure an infrared link is established between the devices.

## Syntax

```
irftp [<drive>:\] [[<path>] <filename>] [/h][/s]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>:\` | Specifies the drive that contains the files that you want to send over an infrared link. |
| `[path]<filename>` | Specifies the location and name of the file or set of files that you want to send over an infrared link. If you specify a set of files, you must specify the full path for each file. |
| /h | Specifies hidden mode. When hidden mode is used, the files are sent without displaying the Wireless Link dialog box. |
| /s | Opens the **Wireless Link** dialog box, so that you can select the file or set of files that you want to send without using the command line to specify the drive, path, and file names. The **Wireless Link** dialog box also opens if you use this command without any parameters. |

### Examples

To send *c:\example.txt* over the infrared link, type:

```
irftp c:\example.txt
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
