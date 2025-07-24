---
title: Connect to Remote Desktop Services in Windows Server
description: Learn how you can connect to a remote session from Remote Desktop Services in Windows Server using Windows App or the Remote Desktop client.
ms.topic: concept-article
author: dknappettmsft
ms.author: daknappe
ms.date: 05/19/2025
---

# Connect to Remote Desktop Services in Windows Server

You can connect to remote desktops and apps running in Remote Desktop Services using Windows App or the Remote Desktop client.

Windows App and the Remote Desktop client are available on many different types of devices on different platforms and form factors, such as desktops and laptops, tablets, smartphones, through a web browser, and virtual reality headsets. This choice provides flexibility and convenience to access desktops and apps from anywhere.

Here's an introductory video for Windows App showing connecting to remote desktops and apps. It combines resources from Remote Desktop Services, remote PC connections, Azure Virtual Desktop, Windows 365, and Microsoft Dev Box.<br /><br />

> [!VIDEO https://www.youtube.com/embed/j0XU59VbKOc]

There are many features you can use to enhance your remote experience, such as:

- Multiple monitor support, with custom and dynamic display resolutions and scaling.
- Microsoft Teams optimizations.
- Device redirection, such as webcams, audio, storage devices, and printers.
- Single sign-on to eliminate the need to enter credentials multiple times.
- Sign in with multiple accounts and easily switch between them.

## How can I connect to Remote Desktop Services?

First, you need to decide whether to use Windows App or the Remote Desktop client to connect to Remote Desktop Services. Windows App replaces the Remote Desktop client and it's available for all platforms, but you can't currently connect to Remote Desktop Services using Windows App from all platforms, so you might still need to use the Remote Desktop client.

Here's what platforms you can use to connect to Remote Desktop Services from Windows App and the Remote Desktop client:

| Platform | Windows App | Remote Desktop client |
|-|:-:|:-:|
| Windows | ❌ | ✅ |
| macOS | ✅ | ✅ |
| iOS/iPadOS | ✅ | ✅ |
| Android | ✅ | ✅ |
| Web browser | ❌ | ✅ |

Once you choose which app to use, download an install it on your device. If you want to connect from a web browser, contact your administrator for their specific link to the Remote Desktop Web client.

In the following articles, you can find download links for Windows App and the Remote Desktop client, and detailed guidance on how to connect to Remote Desktop Services for each supported platform. You need your user account for Remote Desktop Services to sign in, which is provided by your administrator.

- **Windows App**:
  - [macOS](/windows-app/get-started-connect-devices-desktops-apps?pivots=remote-desktop-services&tabs=macos-rds)
  - [iOS/iPadOS](/windows-app/get-started-connect-devices-desktops-apps?pivots=remote-desktop-services&tabs=ios-ipados-rds)
  - [Android](/windows-app/get-started-connect-devices-desktops-apps?pivots=remote-desktop-services&tabs=android-rds)

- **Remote Desktop client**:
  - [Windows](/previous-versions/remote-desktop-client/remote-desktop-windows-urdc)
  - [macOS](/previous-versions/remote-desktop-client/remote-desktop-macos)
  - [iOS/iPadOS](/previous-versions/remote-desktop-client/remote-desktop-ios-ipados)
  - [Android](/previous-versions/remote-desktop-client/remote-desktop-android)
  - [Web browser](remote-desktop-web-client.md)

> [!TIP]
> You should use Windows App to connect to Remote Desktop Services where possible as it replaces the Remote Desktop client.

## Related content

- [Windows App documentation](/windows-app/)
- [Remote Desktop client documentation](/previous-versions/remote-desktop-client/)
