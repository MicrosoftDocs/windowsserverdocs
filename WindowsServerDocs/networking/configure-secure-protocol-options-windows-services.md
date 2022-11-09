---
title: Configure secure protocol options for Windows HTTP Services (WinHTTP)
description: This topic provides information about how to configure secure protocol options for Windows HTTP Services (WinHTTP)
manager: eliotgra
ms.topic: article
author: anaharris-ms
ms.author: anaharris
ms.date: 11/09/2022
---
# Configure secure protocol options for Windows HTTP Services (WinHTTP)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows 11

The `DefaultSecureProtocols` registry entry allows you to specify which SSL protocols should be used when the `WINHTTP_OPTION_SECURE_PROTOCOLS` flag is used. The setting allows applications that were built to use the WinHTTP default flag to be able to use the newer TLS protocols or prevent older SSL based natively without any need for updates to the application.

This how-to guide shows you how to use the `DefaultSecureProtocols` registry entry to add secure protocols for Windows HTTP Services (WinHTTP).

## Prerequisites

- Calculate the value of `DefaultSecureProtocols` with [WINHTTP_OPTION_SECURE_PROTOCOLS](/windows/win32/winhttp/option-flags#winhttp_option_secure_protocols).

- Confirm that your account has Administrative rights to the system.

- Make sure that [Powershell is installed](/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.2).

## Configure DefaultSecureProtocols

To add and set the DefaultSecureProtocols registry entry:

1. Open an elevated Powershell prompt.

1. To create and set the `DefaultSecureProtocols` registry key, run the following command (replace `{value}` with the `DefaultSecureProtocols` value that you selected in the [Calculated the value](#prerequisites)).

# [x86-based computers](#tab/x86)

```powershell

    Get-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" | New-ItemProperty -Name "DefaultSecureProtocols" -Value "{value}"
```

# [x64-based computers](#tab/x64)

```powershell

    Get-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" | New-ItemProperty -Name "DefaultSecureProtocols" -Value "{value}"

```

---

## Next Steps

- To configure the `DefaultSecureProtocols` registry entry for multiple machines, see [Configure a Service Item](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732482(v=ws.10)).