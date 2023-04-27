---
title: pwlauncher
description: Reference article for the pwlauncher command, which enables or disables the Windows To Go Startup Options (pwlauncher).
ms.topic: reference
ms.assetid: 0917bb7b-408a-40f7-a1c5-20e94c10d38b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# pwlauncher

Enables or disables the Windows To Go Startup Options (pwlauncher). The **pwlauncher** command-line tool allows you to configure the computer to boot into a Windows To Go workspace automatically (assuming one is present), without requiring you to enter your firmware or change your startup options.

Windows To Go Startup Options allow a user to configure their computer to boot from USB from within Windows-without ever entering their firmware, as long as their firmware supports booting from USB. Enabling a system to always boot from USB first has implications that you should consider. For example, a USB device that includes malware could be booted inadvertently to compromise the system, or multiple USB drives could be plugged in to cause a boot conflict. For this reason, the default configuration has the Windows To Go Startup Options disabled by default. In addition, administrator privileges are required to configure Windows To Go Startup Options. If you enable the Windows To Go startup options using the pwlauncher command-line tool or the **Change Windows To Go Startup Options** app the computer will attempt to boot from any USB device that is inserted into the computer before it is started.

## Syntax

```
pwlauncher {/enable | /disable}
```

### Parameters

| Parameter | Description |
|--|--|
| /enable | Enables Windows To Go startup options, so the computer will automatically boot from a USB device when present. |
| /disable | Disables Windows To Go startup options, so the computer can't be booted from a USB device unless configured manually in the firmware. |
| /? | Displays help at the command prompt. |

### Examples

To enable boot from USB:

```
pwlauncher /enable
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
