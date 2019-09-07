---
title: Get started with the Windows Desktop client
description: Basic set up steps for the Remote Desktop client for Windows Desktop.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 09/10/2019
ms.localizationpriority: medium
---
# Get started with the Windows Desktop client

>Applies to: Windows 10 and Windows 7

You can use the Remote Desktop client for Windows Desktop to access Windows apps and desktops remotely from a different Windows device.

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.md) if you have any questions.

> [!NOTE]
> - This client currently only supports accessing remote apps and desktops from [Windows Virtual Desktop](https://aka.ms/wvd).
> - Curious about the new releases for the Windows Desktop client? Check out [What's new in the Windows Desktop client](windowsdesktop-whatsnew.md)

## Install the Windows Desktop client

You can install the client from the following locations:
[Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2068602)
Windows 32-bit (Coming soon)
Windows on ARM (Coming soon)

The client can be installed for the current user which does not require administrative right or can be installed by an administrator so all users on the device can access it.

Once installed, the client can be launched from the Start menu by searching for **Remote Desktop**.

## Workspaces

Workspaces contain a set of remote resources (RemoteApp programs, session-based desktops, and virtual desktops) published to you by an admin. The Windows Desktop client currently supports Workspaces published from a **Windows Virtual Desktop** deployments. You should normally receive some information from your admin before getting started.

### Add a Workspace

1. From the main page of the client (Connection Center), tap **Subscribe**.
2. When prompted, provide the credentials to use to access the Workspace.
3. The resources will appear in the Connection Center grouped by Workspace.

Once added, you can launch resources by one of two methods.

- From the Connection Center, double-click a resource to launch it.
- Launch a resource as you normally would other apps from the Start Menu. They can be found in a folder with the Workspace name.
  - You can also search for the apps in the search bar.

### Workspace details

The Workspace details allows you to view additional information like the username used to access the resources, the last time the Workspace was updated and to manually update the Workspace if needed.

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Tap **Details**.

### Updating a Workspace

While Workspaces are updated automatically, then can also be updated manually when needed.

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Tap **Details**.
3. You can review the last update time and if the last update was successful.
4. Tap **Update now** to start the update process.

### Remove a Workspace

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Tap **Unsubscribe**.

## Desktop settings

## Global app settings

You can set the following global settings in your client by tapping **Settings**:

MANAGED ITEMS

- **User account** - Allows you to Add, edit and delete user accounts saved in the client. This is a good way to update the password for an account after it has changed.
- **Gateway** - Allows you to Add, edit and delete gateway servers saved in the client.
- **Group** - Allows you to Add, edit and delete groups saved in the client. These allow you to easily group connections.

SESSION SETTINGS

- **Start connections in full screen** - When enabled, anytime a connection is launched, the client will use the entire screen of the current monitor.
- **Start each connection in a new window** - When enabled, each connection is launched in a separate window, allowing you to place them on different monitors and switch between them using the taskbar.
- **When resizing the app:** - Allows you control over what happens when the client window is resized. Defaults to **Stretch the content, preserving aspect ratio**.
- **Use keyboard commands with:** - Let's you specify where keyboard commands like *WIN* or *ALT+TAB* are used. The default is to only send them to the session when the connection is in full screen.
- **Prevent the screen from timing out** - Allows you to keep the screen from timing out when a session is active. This is helpful when the connection does not require any interaction for long periods of time.

APP SETTINGS

- **Show Desktop Previews** - Lets you see a preview of a desktop in the Connection Center before you connect to it. By default, this is set to **on**.
- **Help improve Remote Desktop** - Sends anonymous data to Microsoft. We use this data to improve the client. To learn more about how we treat this anonymous, private data, see the [Microsoft Privacy Statement](https://privacy.microsoft.com/en-us/privacystatement). By default, this setting is **on**.

## Other options

### About

### Feedback

### Help

> [!TIP]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Have a feature suggestion or want to report an issue? Tell us using the [Feedback Hub](feedback-hub://?tabid=2&contextid=883).
