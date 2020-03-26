---
title: Remote Desktop - Compare the clients
description: Learn how the different RD clients compare when it comes to supported features and functions.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 12efe858-6b76-4e08-9f72-b9603aceb0fc
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 03/28/2020
ms.localizationpriority: medium
---

# Compare the clients

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

We're often asked how the different Remote Desktop clients compare to each other. Do they all do the same thing? Here are the answers to those questions.

## Redirection support

The following tables compare support for device and other redirections across the different clients. These tables cover the redirections that you can access once in a remote session.

If you remote into your personal desktop, there are additional redirections that you can configure in the **Additional Settings** for the session. If your remote desktop or apps are managed by your organization, your admin can enable or disable redirections through Group Policy settings or RDP properties.

### Input redirection

| Redirection | Windows Inbox</br>(MSTSC) | Windows Desktop</br>(MSRDC) | Windows Store | Android | iOS | macOS | Web client    |
|-------------|---------------------------|-----------------------------|---------------|---------|-----|-------|---------------|
| Keyboard    | X                         | X                           | X             | X       | X   | X     | X             |
| Mouse       | X                         | X                           | X             | X       | X\* | X     | X             |
| Touch       | X                         | X                           | X             | X       | X   |       | X (except IE) |
| Pen         | X                         | X                           |               |         |     |       |               |

*View the [list of supported input devices for the Remote Desktop iOS client](remote-desktop-ios.md#supported-input-devices).

### Port redirection

| Redirection | Windows Inbox</br>(MSTSC) | Windows Desktop</br>(MSRDC) | Windows Store | Android | iOS | macOS | Web client |
|-------------|---------------------------|-----------------------------|---------------|---------|-----|-------|------------|
| Serial port | X                         | X                           |               |         |     |       |            |
| USB         | X                         | X                           |               |         |     |       |            |

When you enable USB port redirection, any USB devices attached to the USB port are automatically recognized in the remote session.

### Other redirection (devices, etc)

| Redirection         | Windows Inbox</br>(MSTSC) | Windows Desktop</br>(MSRDC) | Windows Store | Android | iOS         | macOS                           | Web client    |
|---------------------|---------------------------|-----------------------------|---------------|---------|-------------|---------------------------------|---------------|
| Cameras             | X                         | X                           |               |         |             | X                               |               |
| Clipboard           | X                         | X                           | X             | text    | text, image | X                               | text          |
| Local drive/storage | X                         | X                           |               | X       |             | X                               |               |
| Location            | X                         | X                           |               |         |             |                                 |               |
| Microphones         | X                         | X                           | X             |         |             | X                               |               |
| Printers            | X                         | X                           |               |         |             | X (CUPS only)                   | PDF print     |
| Scanners            | X                         | X                           |               |         |             |                                 |               |
| Smart Cards         | X                         | X                           |               |         |             | X (Windows logon not supported) |               |
| Speakers            | X                         | X                           | X             | X       | X           | X                               | X (except IE) |

*For printer redirection - the macOS app supports the Publisher Imagesetter printer driver by default. They do not support redirecting native printer drivers.
