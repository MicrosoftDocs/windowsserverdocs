---
title: Get started with the iOS client
description: Learn how to set up the Remote Desktop client for iOS
ms.topic: article
ms.assetid: 03ec5a3d-d3f2-4afd-9405-ae58b6ecc91c
author: Heidilohr
manager: femila
ms.author: helohr
ms.date: 11/03/2022
---

# Get started with the iOS client

>Applies to: Windows Server 2022, Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

You can use the Remote Desktop client for iOS to work with Windows apps, resources, and desktops from your iOS device (iPhones and iPads).

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.yml) if you have any questions.

> [!TIP]
> If you want to connect to Azure Virtual Desktop instead of Remote Desktop Services or a remote PC, see [Connect to Azure Virtual Desktop with the Remote Desktop client for iOS and iPadOS](/azure/virtual-desktop/users/connect-ios-ipados).

> [!NOTE]
> - Curious about the new releases for the iOS client? Check out [What's new for Remote Desktop on iOS?](ios-whatsnew.md).
> - The iOS client supports devices running iOS 14.x and newer.

## Get the Remote Desktop client and start using it

This section will tell you how to download and set up the Remote Desktop client for iOS.

### Download the Remote Desktop client from the iOS store

First you'll need to download the client and configure your PC to connect to remote resources.

To download the client:

1. Download the Microsoft Remote Desktop client from the [iOS App Store](https://aka.ms/rdios) or [iTunes](https://itunes.apple.com/app/microsoft-remote-desktop/id714464092?mt=8).
2. [Set up your PC to accept remote connections](remote-desktop-client-faq.yml#how-do-i-set-up-a-pc-for-remote-desktop-).

### Add a PC

After you've downloaded the client and configured your PC to accept remote connections, it's time to actually add a PC.

To add a PC:

1. In the Connection Center, tap **+**, then tap **Add PC**.
2. Enter the following information:
   - **PC name** – the name of the computer. The PC name can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, **MyDesktop:3389** or **10.0.0.1:3389**).
   - **User name** – The user name you'll use to access the remote PC. You can use the following formats: *user_name*, *domain\user_name*, or `user_name@domain.com`. You can also select **Ask when required** to be prompted for a user name and password when necessary.
3. You can also set the following additional options:
   - **Friendly name (optional)** – An easy-to-remember name for the PC you're connecting to. You can use any string, but if you don't specify a friendly name, the PC name is displayed instead.
   - **Gateway (optional)** – The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.
   - **Sound** – Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote device, or not at all.
   - **Swap mouse buttons** – Whenever a mouse gesture would send a command with the left mouse button, it sends the same command with the right mouse button instead. Swapping mouse buttons is necessary if the remote PC is configured for left-handed mouse mode.
   - **Admin Mode** - Connect to an administration session on a server running Windows Server 2003 or later.
   - **Clipboard** - Choose whether to redirect text and images in your clipboard to your PC.
   - **Storage** - Choose whether to redirect storage to your PC.
4. Tap **Save**.

Need to edit these settings? Press and hold the desktop you want to edit, then tap the settings icon.

### Add a workspace

To get a list of managed resources you can access on your iOS, add a workspace by subscribing to the feed provided by your admin.

To add a workspace:

1. On the Connection Center screen, tap **+**, and then tap **Add workspace**.
2. In the Feed URL field, enter the URL for the feed you want to add. This URL can be either a URL or an email address.
   - If you use a URL, use the one your admin gave you.
   - If you use an email address, enter your email address. Entering your email address tells the client to search for a URL associated with your email address if your admin configured the server that way.
3. Tap **Next**.
4. Provide your credentials when prompted.
   - For **User name**, give the user name of an account with permission to access resources.
   - For **Password**, give the password for the account.
   - You may also be prompted to give additional information depending on the settings your admin configured authentication with.
5. Tap **Save**.

After you've finished, the Connection Center should display the remote resources.

Once subscribed to a feed, the feed content will update automatically on a regular basis. Resources may be added, changed, or removed based on changes made by your administrator.

## Manage your user accounts

When you connect to a PC or workspace, you can save the user accounts to select from again.

To create a new user account:

1. In the Connection Center, tap **Settings**, and then tap **User Accounts**.
2. Tap **Add User Account**.
3. Enter the following information:
   - **User Name** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: `user_name`, `domain\user_name`, or `user_name@domain.com`.
   - **Password** - The password for the user you specified.
4. Tap **Save**.

To delete a user account:

1. In the Connection Center, tap **Settings**, and then tap **User Accounts**.
2. Select the account you would like to delete.
3. Tap **Delete**.

## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, tap **Settings** > **Gateways**.
2. Tap **Add gateway**.
3. Enter the following information:
   - **Gateway name** – The name of the computer you want to use as a gateway. The gateway name can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example, **RDGateway:443** or **10.0.0.1:443**).
   - **User name** - The user name and password to be used for the Remote Desktop gateway you're connecting to. You can also select **Use connection credentials** to use the same user name and password that you used for the remote desktop connection.

## Navigate the Remote Desktop session

This section describes tools you can use to help navigate your Remote Desktop session.

### Start a Remote Desktop connection

1. Tap the remote desktop connection to start the remote desktop session.
2. If you're asked to verify the certificate for the remote desktop, tap **Accept**. To accept by default, set  **Don't ask me again for connections to this computer** to **On**.

### Connection bar

The connection bar gives you access to additional navigation controls.

- **Pan Control**: The pan control enables the screen to be enlarged and moved around. Pan control is only available using direct touch.
   - To enable or disable the pan control, tap the pan icon in the connection bar to display the pan control. The screen will zoom in while the pan control is active. the pan icon in the connection bar again to hide the control and return the screen to its original resolution.
   - To use the pan control, tap and hold the pan control. While holding, drag your fingers in the direction you want to move the screen.
   - To move the pan control, double-tap and hold the pan control to move the control on the screen.
- **Connection name**: The current connection name is displayed. Tap the connection name to display the session selection bar.
- **Keyboard**: Tap the keyboard icon to display or hide the keyboard. The pan control is displayed automatically when the keyboard is displayed.
- **Move the connection bar**: Tap and hold the connection bar. While holding the bar, drag it over to its new location. Let go of the bar to place it at the new location.

### Session selection

You can have multiple connections open to different PCs at the same time. Tap the connection bar to display the session selection bar on the left-hand side of the screen. The session selection bar enables you to view your open connections and switch between them.

Here's what you can do with the session selection bar:

- To switch between apps in an open remote resource session, tap the expander menu and choose an app from the list.
- Tap **Start New** to start a new session, then choose a session from the list of available sessions.
- Tap the **X** icon on the left side of the session tile to disconnect from your session.

### Command bar

The command bar replaced the Utility bar starting in version 8.0.1. You can use the command bar to switch between mouse modes and return to the connection center.

## Use touch gestures and mouse modes in a remote session

The client uses standard touch gestures. You can also use touch gestures to replicate mouse actions on the remote desktop. The mouse modes available are defined in the table below.

> [!NOTE]
> In Windows 8 or later, the native touch gestures are supported in Direct Touch mode. For more information on Windows 8 gestures, see [Touch: Swipe, tap, and beyond](https://windows.microsoft.com/windows-8/touch-swipe-tap-beyond).

| Mouse mode    | Mouse operation      | Gesture                                                    |
|:------------- |:-------------------- |:---------------------------------------------------------- |
| Direct touch  | Left-click           | Tap with one finger                                        |
| Direct touch  | Right-click          | Tap and hold with one finger                               |
| Mouse pointer | Left-click           | Tap with one finger                                        |
| Mouse pointer | Left-click and drag  | Tap and hold with one finger, then drag                    |
| Mouse pointer | Right-click          | Tap with two fingers                                       |
| Mouse pointer | Right-click and drag | Double-tap and hold with two fingers, then drag            |
| Mouse pointer | Mouse wheel          | Double-tap and hold with two fingers, then drag up or down |
| Mouse pointer | Zoom                 | With two fingers, pinch to zoom out and spread fingers apart to zoom in |

## Supported input devices

The client has [Bluetooth mouse support](https://support.apple.com/HT210546) for iOS 13 and iPadOS as an accessibility feature. You can use Swiftpoint GT or ProPoint mice for deeper mouse integration. The client also supports external keyboards that are compatible with iOS and iPadOS.

For more information about device support, see [What's new in the iOS client](ios-whatsnew.md) and the [iOS App Store](https://aka.ms/rdios).

> [!TIP]
> Swiftpoint is offering an [exclusive discount on the ProPoint mouse](https://www.swiftpoint.com/microsoft) for iOS client users.

## Use a keyboard in a remote session

You can use either an on-screen keyboard or physical keyboard in your remote session.

For on-screen keyboards, use the button on the right edge of the bar above the keyboard to switch between the standard and additional keyboard.

If Bluetooth is enabled on your iOS device, the client automatically detects the Bluetooth keyboard.

While certain key combinations might not work as expected in a remote session, many of the common Windows key combinations, such as CTRL+C, CTRL+V, and ALT+TAB will work.

> [!TIP]
> Questions and comments are always welcome. However, if you post support requests or product feedback in this article's comments section, we won't be able to respond to your feedback. If you need help or want to troubleshoot your client, we highly recommend you go to the [Remote Desktop client forum](/answers/topics/windows-remote-desktop-client.html) and start a new thread.
