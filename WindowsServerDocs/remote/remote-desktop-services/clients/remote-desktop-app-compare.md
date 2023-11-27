---
title: Remote Desktop - compare the client apps redirections
description: Learn how the different Remote Desktop apps compare when it comes to redirections.
ms.topic: article
ms.assetid: 12efe858-6b76-4e08-9f72-b9603aceb0fc
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 10/24/2023
---

# Compare the clients: redirections

>Applies to: Windows Server 2022, Windows 10, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

We're often asked how the different Remote Desktop clients compare to each other when connecting to Remote Desktop Services or remote PCs. Here's the answer to these questions.

## Redirection support

The following tables compare support for device and other redirections across the different clients. These tables cover the redirections that you can access once in a remote session.

If you remote into your personal desktop, there are other redirections that you can configure in the **Additional Settings** for the session. If your remote desktop or apps are managed by your organization, your admin can enable or disable redirections through Group Policy settings or RDP properties.

>[!IMPORTANT]
>You can only enable redirections with binary settings that apply to both to and from the remote machine. The service doesn't currently support one-way blocking of redirections from only one side of the connection.

### Input redirection

| Redirection | Windows</br>(MSTSC) | Remote Desktop app | Android | iOS | macOS | Web client    |
|-------------|---------------------------|---------------|---------|-----|-------|---------------|
| Keyboard    | X                         | X             | X       | X   | X     | X             |
| Mouse       | X                         | X             | X       | X\* | X     | X             |
| Touch       | X                         | X             | X       | X   |       | X (except IE) |
| Pen         | X                         |               | X       | X \*\* | | |

\* View the [list of supported input devices for the Remote Desktop iOS client](remote-desktop-ios.md#supported-input-devices).

\*\* Pen input redirection is not supported when connecting to Windows Server 2012, or Windows Server 2012 R2.

### Port redirection

| Redirection | Windows</br>(MSTSC) | Remote Desktop app | Android | iOS | macOS | Web client |
|-------------|---------------------------|---------------|---------|-----|-------|------------|
| Serial port | X                         |               |         |     |       |            |
| USB         | X                         |               |         |     |       |            |

When you enable USB port redirection, all USB devices attached to USB ports are automatically recognized in the remote session. For the devices to work as expected, you must make sure to install their required drivers on both the endpoint and host. Also, make sure the drivers are certified to run in remote scenarios. If you need more information about using your USB device in remote scenarios, talk to the device manufacturer.

### Other redirection (devices, etc.)

| Redirection         | Windows</br>(MSTSC) | Remote Desktop app | Android | iOS         | macOS                           | Web client    |
|---------------------|---------------------------|---------------|---------|--------------|---------------------------------|---------------|
| Cameras             | X                         |               |  X       |   X          | X                               | X              |
| Clipboard           | X                         | X             | Text    | Text, images | X                               | Text          |
| Local drive/storage | X                         |               | X       | X            | X                               |  X\*             |
| Location            | X                         |  X             |         |              |                                 |               |
| Microphones         | X                         | X             | X       |  X           | X                               | X             |
| Printers            | X                         |               |         |              | X\*\* (CUPS only)                   | PDF print     |
| Scanners            | X                         |               |         |              |                                 |               |
| Smart cards         | X                         |               |         |              | X (Windows sign-in not supported) |               |
| Speakers            | X                         | X             | X       | X            | X                               | X (except IE) |
| Third-party virtual channel plugins | X         |               |         |              |                                 |               |
| WebAuthn            | X                         |               |         |              |                                 |               |

\* Limited to uploading and downloading files through the Remote Desktop Web client.

\*\* For printer redirection, the macOS app supports the Publisher Imagesetter printer driver by default. The app doesn't support the native printer drivers.

## Other resources

If you're looking for feature comparisons, check out [Compare the clients: features](remote-desktop-features.md).
