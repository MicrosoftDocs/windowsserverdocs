---
title: Remote Desktop - compare the client apps
description: Learn how the different RD apps compare when it comes to supported features and functions.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 12efe858-6b76-4e08-9f72-b9603aceb0fc
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 05/20/2019
ms.localizationpriority: medium
---

# Compare the client apps

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

We're often asked how the different Remote Desktop client apps compare to each other. Do they all do the same thing? Here are the answers to those questions.

## Redirection support

The following tables compare support for device and other redirections on the Remote Desktop Connection app, Universal app, Android app, iOS app, macOS app and web client. These tables cover the redirections that you can access once in a remote session. 

If you remote into your personal desktop, there are additional redirections that you can configure in the **Additional Settings** for the session. If your remote desktop or apps are managed by your organization, your admin can enable or disable redirections through Group Policy settings.

### Input redirection

| Redirection | Remote Desktop<br> Connection | Universal | Android | iOS | macOS |          web client           |
|-------------|-------------------------------|-----------|---------|-----|-------|-------------------------------|
|  Keyboard   |               X               |     X     |    X    |  X  |   X   |               X               |
|    Mouse    |               X               |     X     |    X    | X\* |   X   |               X               |
|    Touch    |               X               |     X     |    X    |  X  |       | X (Edge and IE not supported) |
|    Other    |              Pen              |           |         |     |       |                               |

*View the [list of supported input devices for the Remote Desktop iOS Beta client](remote-desktop-ios.md#supported-input-devices).

### Port redirection   

| Redirection | Remote Desktop <br>Connection | Universal | Android | iOS | macOS | Web client |
|-------------|-------------------------------|-----------|---------|-----|-------|------------|
| Serial port | X                             |           |         |     |       |            |
| USB         | X                             |           |         |     |       |            |

When you enable USB port redirection, any USB devices attached to the USB port are automatically recognized in the remote session.

### Other redirection (devices, etc)



| Redirection         | Remote Desktop Connection | Universal   | Android | iOS         | macOS                                    | Web client    |
|---------------------|---------------------------|-------------|---------|-------------|------------------------------------------|---------------|
| Cameras             | X                         |             |         |             |                                          |               |
| Clipboard           | X                         | text, image | text    | text, image | X                                        | text          |
| Local drive/storage | X                         |             | X       |             | x                                        |               |
| Location            | X                         |             |         |             |                                          |               |
| Microphones         | X                         |X            |         |             | X                                        |               |
| Printers            | X                         |             |         |             | X (CUPS only)                            | PDF print     |
| Scanners            | X                         |             |         |             |                                          |               |
| Smart Cards         | X                         |             |         |             | X (Windows authentication not supported) |               |
| Speakers            | X                         | X           | X       | X           | X                                        | X (except IE) |

*For printer redirection - the macOS app supports the Publisher Imagesetter printer driver by default. They do not support redirecting native printer drivers.
