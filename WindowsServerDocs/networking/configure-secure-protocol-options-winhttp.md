---
title: Configure secure protocol options for Windows HTTP Services (WinHTTP)
description: This article provides information about how to configure secure protocol options for Windows HTTP Services (WinHTTP).
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 03/27/2024
---
# Configure secure protocol options for WinHTTP

This how-to guide shows you how to use the `DefaultSecureProtocols` registry entry to choose which protocols for the Windows HTTP Services (WinHTTP).

The `DefaultSecureProtocols` registry entry allows you to specify which SSL protocols should be used when the `WINHTTP_OPTION_SECURE_PROTOCOLS` flag is used. The setting allows applications that were built to use the WinHTTP default flag to be able to use the newer TLS protocols or prevent older SSL based natively without any need for updates to the application.

## Prerequisites

- Calculate the value of `DefaultSecureProtocols` with [WINHTTP_OPTION_SECURE_PROTOCOLS](/windows/win32/winhttp/option-flags#winhttp_option_secure_protocols).

- Confirm that your account has Administrative rights to the system.

- Make sure that [PowerShell is installed](/powershell/scripting/install/installing-powershell-on-windows).

## Configure DefaultSecureProtocols

Select which architecture type to add and set the `DefaultSecureProtocols` registry entry:

# [x86](#tab/x86)

1. Open an elevated PowerShell prompt.

1. To create and set the `DefaultSecureProtocols` registry key, run the following command and replace `{value}` with the `DefaultSecureProtocols` value that you selected from [Calculate the value](#prerequisites).

    ```powershell
    Get-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" | New-ItemProperty -Name "DefaultSecureProtocols" -Value "{value}"
    ```

1. Either reboot the machine or restart whichever services are using WinHTTP.

# [x64](#tab/x64)

1. Open an elevated PowerShell prompt.

1. To create and set the `DefaultSecureProtocols` registry key, run the following commands and replace `{value}` with the `DefaultSecureProtocols` value that you selected from [Calculate the value](#prerequisites).

    ```powershell
    # Addresses 64-bit applications
    Get-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" | New-ItemProperty -Name "DefaultSecureProtocols" -Value "{value}"

    # Addresses 32-bit applications
    Get-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" | New-ItemProperty -Name "DefaultSecureProtocols" -Value "{value}"
    ```

1. Either reboot the machine or restart whichever services are using WinHTTP.

> [!NOTE]
> On x64 based systems, having both registry keys present simultaneously is required to ensure proper addressing for both types of applications.

---

## Next steps

- To configure the `DefaultSecureProtocols` registry entry for multiple machines, see [Configure a Service Item](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732482(v=ws.10)).
