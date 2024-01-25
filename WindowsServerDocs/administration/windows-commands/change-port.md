---
title: change port
description: Reference article for the change port command, which lists or changes the COM port mappings to be compatible with MS-DOS applications.
ms.topic: article
ms.assetid: 3d772c90-e849-4e74-b9ec-b6cae1159336 Lizap
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# change port

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Lists or changes the COM port mappings to be compatible with MS-DOS applications.

> [!NOTE]
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
change port [<portX>=<portY>| /d <portX> | /query]
```

### Parameters

| Parameter | Description |
|-----------------|----------------------------------------|
| `<portX>`=`<portY>` | Maps COM `<portX>` to `<portY>` |
| /d `<portX>` | Deletes the mapping for COM `<portX>` |
| /query | Displays the current port mappings. |
| /? | Displays help at the command prompt. |

#### Remarks

- Most MS-DOS applications support only COM1 through COM4 serial ports. The **change port** command maps a serial port to a different port number, allowing apps that don't support high-numbered COM ports to access the serial port. Remapping works only for the current session and is not retained if you log off from a session and then log on again.

- Use **change port** without any parameters to display the available COM ports and their current mappings.

## Examples

- To map COM12 to COM1 for use by an MS-DOS-based application, type:

  ```
  change port com12=com1
  ```

- To display the current port mappings, type:

  ```
  change port /query
  ```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [change command](change.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
