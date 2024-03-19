---
title: Features removed or no longer developed starting with Windows Server 2025 (preview)
description: Learn about the features and functionalities removed or no longer developed starting with Windows Server 2025.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 03/14/2024
ms.service: windows-server
---

# Features removed or no longer developed starting with Windows Server 2025 (preview)

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Each release of Windows Server adds new features and functionality; we also occasionally remove features and functionality, usually because we've added a better option. Here are the details about the features and functionalities that we removed in Windows Server 2025.

> [!TIP]
>
> - You can get early access to Windows Server builds by joining the [Windows Insider Program for Business](https://insider.windows.com/for-business) - this is a great way to test feature changes.

**The list is subject to change and might not include every affected feature or functionality.**

## Features we've removed in this release

We're removing the following features and functionalities from the installed product image in Windows Server 2025. Applications or code that depend on these features won't function in this release unless you use an alternate method.

| Feature | Explanation |
|--|--|
| IIS 6 Management Console (Web-Lgcy-Mgmt-Console) | The console has been removed after being no longer developed in Windows Server 2019. You should also start migration from IIS 6.0 or earlier versions, and move to the latest version of IIS, which is always available in the most recent release of Windows Server. |
| Wordpad | WordPad has been removed from Windows Server 2025. We recommend Microsoft Word for rich text documents like `.doc` and `.rtf` and Windows Notepad for plain text documents like `.txt`. |
| SMTP Server | The SMTP Server features has been removed from Windows Server 2025. There's no replacement within the operating systems. |
| Windows PowerShell 2.0 Engine | The Windows PowerShell 2.0 Engine has been removed, applications, and components should be migrated to PowerShell 5.0+. |

## Features we're no longer developing

We're no longer actively developing these features and may remove them from a future update. Some features have been replaced with other features or functionality, while others are now available from different sources.

| Feature | Explanation |
|--|--|
| Computer Browser | The Computer Browser driver and service are deprecated. The browser (browser protocol and service) is a dated and insecure device location protocol. This protocol, service, and driver were first disabled by default in Windows 10 with the removal of the SMB1 service. For more information on Computer Browser, see [MS-BRWS Common Internet File System](/openspecs/windows_protocols/ms-brws/3cfbad92-09b3-4abc-808f-c6f6347d5677). |
| Remote Mailslots | Remote Mailslots are deprecated. The Remote Mailslot protocol, which was initially introduced in MS DOS, is a dated and simple IPC method that is both unreliable and insecure. This protocol was first disabled by default in [Windows 11 Insider Preview Build ](https://blogs.windows.com/windows-insider/2023/03/08/announcing-windows-11-insider-preview-build-25314/). For more information on Remote Mailslots, see [About Mailslots](/windows/win32/ipc/about-mailslots) and [[MS-MAIL]: Remote Mailslot Protocol](/openspecs/windows_protocols/ms-mail/8ea19aa4-6e5a-4aed-b628-0b5cd75a1ab9).|
| TLS 1.0 <br> TLS 1.1 | TLS versions 1.0 and 1.1 have been deprecated by internet standards and regulatory bodies due to various security concerns. As of the 2024 release of Windows Server Insiders Preview, these versions are disabled by default. For more information on TLS deprecation, see [TLS 1.0 and TLS 1.1 deprecation in Windows](/windows/win32/secauthn/tls-10-11-deprecation-in-windows). |
| WebDAV Redirector service | The WebDAV Redirector service is deprecated. The service isn't installed by default in Windows Server. For more information on the WebDAV Redirector service, see [WebDAV - Win32 apps](/windows/win32/webdav/webdav-portal). |
| VBScript | VBScript is deprecated. In future releases of Windows, VBScript is available as a feature on demand before its removal from the operating system. |
