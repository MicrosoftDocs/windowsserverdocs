---
title: pwlauncher
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0917bb7b-408a-40f7-a1c5-20e94c10d38b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# pwlauncher



Enables or disables the Windows To Go Startup Options (pwlauncher). The **pwlauncher** command-line tool allows you to configure the computer to boot into a Windows To Go workspace automatically (assuming one is present), without requiring you to enter your firmware or change your startup options.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
Pwlauncher {/enable | /disable}
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/enable|Enables Windows To Go startup options so that the computer will automatically boot from a USB device when present|
|/disable|Disables Windows To Go startup options so that the computer cannot be booted from a USB device unless configured manually in the firmware.|
|/?|Displays help at the command prompt.|

## Remarks

The biggest hurdle for a user wanting to use Windows To Go is getting their computer to boot from USB. This is traditionally done by entering the firmware and trying different configuration options until the computer is configured properly. This is not a simple undertaking for most users and is extremely risky because the firmware contains options that can render a system unusable if used incorrectly. To help alleviate this problem, Windows 8and later operating systems include a feature named "Windows To Go Startup Options" that allows a user to configure their computer to boot from USB from within Windows-without ever entering their firmware, as long as their firmware supports booting from USB. Enabling a system to always boot from USB first has implications that you should consider. For example, a USB device that includes malware could be booted inadvertently to compromise the system, or multiple USB drives could be plugged in to cause a boot conflict. For this reason, the default configuration has the Windows To Go Startup Options disabled by default. In addition, administrator privileges are required to configure Windows To Go Startup Options. If you enable the Windows To Go startup options using the pwlauncher command-line tool or the **Change Windows To Go Startup Options** app the computer will attempt to boot from any USB device that is inserted into the computer before it is started.

## <a name="BKMK_examples"></a>Examples

The following example shows how you can use the **pwlauncher** command to enable boot from USB:
```
Pwlauncher /enable
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)