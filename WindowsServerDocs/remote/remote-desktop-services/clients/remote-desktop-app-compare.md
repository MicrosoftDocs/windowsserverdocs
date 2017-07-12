---
title: Remote Desktop - compare the client apps
description: Learn how the difference RD apps compare when it comes to supported features and functions.
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
ms.date: 02/21/2017
---

# Compare the client apps

>Applies To: Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2016

We're often asked how the different Remote Desktop client apps compare to each other. Do they all do the same thing? Here are the answers to those questions.

## Redirection support

The following tables compare support for device and other redirections on the Remote Desktop Connection app, Universal app (used for Windows Phone, among others), Android app, iOS app, and Mac app. These tables cover the redirections that you can access once in a remote session. 

If you remote into your personal desktop, there are additional redirections that you can configure in the **Additional Settings** for the session. If your remote desktop or apps are managed by your organization, your admin can enable or disable redirections through Group Policy settings.

Please note that we are working on a new Remote Desktop application for macOS that supports more redirection than our official app published in the Mac App Store. Test drive our [new preview Mac client](https://aka.ms/rdmac-preview). 

### Input redirection

| Redirection | Remote Desktop<br> Connection | Universal | Android | iOS | macOS |
|------------------|---------------------------|-----------|---------|-----|-----|
| Keyboard         | X                         | X         | X       | X   | X   |
| Mouse            | X                         | X         | X       |     | X   |
| Touch            | X                         | X         | X       | X   |     |
| Other            | Pen                       |           |         |     |     |

### Port redirection   

| Redirection | Remote Desktop <br>Connection | Universal | Android | iOS | macOS |
|-------------|---------------------------|-----------|---------|-----|-----|
| Serial port | X                         |           |         |     |     |
| USB         | X                         |           |         |     |     |

When you enable USB port redirection, any USB devices attached to the USB port are automatically recognized in the remote session.

### Other redirection (devices, etc)



| Redirection         | Remote Desktop Connection | Universal   | Android | iOS         | macOS                                     |
|---------------------|---------------------------|-------------|---------|-------------|------------------------------------------|
| Clipboard           | X                         | text, image | text    | text, image | text, image (full support in preview client)                             |
| Microphone          | X                         |X            |         |             | X (in preview client)                       |
| Local drive/storage | X                         |             | X       |             | x                                          |
| Printers            | X                         |             |         |             | X (CUPS only)                              |
| Smart Card          | X                         |             |         |             | X (preview client, Windows authentication not supported) |
| Speakers            | X                         | X           | X       | X           | X                                        |

*For printer redirection - the Mac applications support the Publisher Imagesetter printer driver by default. They do not support redirecting native printer drivers.
