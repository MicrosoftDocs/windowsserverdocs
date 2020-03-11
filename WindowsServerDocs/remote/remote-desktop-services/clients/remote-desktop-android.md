---
title: Get started with the Android client
description: General information about the Android client.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64f038e1-40ec-4c67-938b-72edea49e5d8
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 03/12/2020
ms.localizationpriority: medium
---
# Get started with the Android client

>Applies to: Android 4.1 and later

You can use the Remote Desktop client for Android to work with Windows apps and desktops directly from your Android device or a Chromebook that supports the Google Play Store.

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.md) if you have any questions.

> [!NOTE]
> - Curious about the new releases for the Android client? Check out [What's new for the Android client](android-whatsnew.md).
> - The Android client supports devices running Android 4.1 and later, as well as Chromebooks with ChromeOS 53 and later. Learn more about Android applications on Chrome [here](https://sites.google.com/a/chromium.org/dev/chromium-os/chrome-os-systems-supporting-android-apps).

## Set up the Remote Desktop client for Android

### Download the Remote Desktop client from the Google Play store

Here's how to set up the Remote Desktop client on your Android device:

1. Download the Microsoft Remote Desktop client from [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.rdc.android).
2. Launch **RD client** from your list of apps.
3. Add a [Remote Desktop connection](#add-a-remote-desktop-connection) or [remote resources](#add-remote-resources). You use a connection to connect directly to a Windows PC and remote resources to access apps and desktops published to you by an admin.

> [!NOTE]
> If you want to test new features before they're released, we recommend downloading our [Microsoft Remote Desktop Beta](https://play.google.com/store/apps/details?id=com.microsoft.rdc.android.beta) client from the Google Play store.

### Add a Remote Desktop connection

If you haven't done so already, [set up your PC to accept remote connections](remote-desktop-allow-access.md).

To create a Remote Desktop connection:

1. In the Connection Center, tap **+**, and then tap **Desktop**.
2. Enter the name of the remote PC into **PC name**. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, MyDesktop:3389 or 10.0.0.1:3389). This is the only required field.
3. Select the **User name** you use to access the Remote PC.
   - Select **Enter every time** for the client to ask for your credentials every time you connect to the remote PC.
   - Select **Add user account** to save an account that you use frequently so you don't have to enter credentials every time you sign in. See [manage your user accounts](#manage-your-user-accounts) for more details.
4. You can also tap on **Show additional options** to set the following optional parameters:
   - In **Friendly name**, you can enter an easy-to-remember name for the PC you're connecting to. If you don't specify a friendly name, the PC name is displayed instead.
   - The **Gateway** is the Remote Desktop gateway you'll use to connect to a computer from an external network. Contact your system administrator for more information.
   - **Sound** selects the device your remote session uses for audio. You can choose to play sound on your local device, the remote device, or not at all.
   - **Customize display resolution** sets the resolution for the remote session. When turned off, the resolution specified in global settings is used.
   - **Swap mouse buttons** switches the commands sent by right and left mouse gestures. Ideal for left-handed users.
   - **Connect to admin session** lets you connect to an admin session on the remote PC.
   - **Redirect local storage** enables local storage redirection. This setting is disabled by default.
5. When you're done, tap **Save**.

Need to edit these settings? Tap the **More options** menu (**...**) next to the name of the desktop, and then tap **Edit**.

Want to remove the connection? Again, tap the **More options** menu (**...**), and then tap **Remove**.

>[!TIP]
> If you get error 0xf07 about a bad password ("We couldn't connect to the remote PC because the password associated with the user account has expired"), change your password and try again.

### Add remote resources

Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published by your admin. The Android client supports resources published from **Remote Desktop Services** and **Windows Virtual Desktop** deployments. To add remote resources:

1. In the Connection Center, tap **+**, and then tap **Remote Resource Feed**.
2. Enter the **Feed URL**. This can be a URL or email address:
   - The **URL** is the RD Web Access server provided to you by your admin. If accessing resources from Windows Virtual Desktop, you can use `https://rdweb.wvd.microsoft.com`.
   - If you plan to use **Email**, enter your email address in this field. This tells the client to search for an RD Web Access server associated with your email address if it was configured by your admin.
3. Tap **Next**.
4. Provide your sign in information when prompted. This can vary based on the deployment and can include:
   - The **User name** that has permission to access the resources.
   - The **Password** associated with the user name.
   - **Additional factor**, which you may be prompted for a if authentication was configured that way by your admin.
5. When you're done, tap **Save**.

The remote resources will be displayed in the Connection Center.

To remove remote resources:

1. In the Connection Center, tap the overflow menu (**...**) next to the remote resource.
2. Tap **Remove**.
3. Confirm the removal.

### Use a widget to pin a saved desktop to your home screen

The Remote Desktop client supports pinning connections to your home screen by using the Android widget feature. The way that you add a widget depends on the type of Android device you are using and its operating system. Here is the most common way to add a widget:

1. Tap **Apps** to launch the apps menu.
2. Tap **Widgets**.
3. Swipe through the widgets and look for the Remote Desktop icon with the description: "Pin Remote Desktop."
4. Tap and hold that Remote Desktop widget and move it to the home screen.
5. When you release the icon, you'll see the saved remote desktops. Choose the connection that you want to save to your home screen.

Now you can start the remote desktop connection directly from your home screen by tapping it.

> [!NOTE]
> If you rename the desktop connection in the Remote Desktop client, its pinned label won't update.

## Manage general app settings

To change the general app settings, go to the Connection Center, tap **Settings**, and then tap **General**.

You can set the following general settings:

- **Show desktop previews** lets you see a preview of a desktop in the Connection Center before you connect to it. This setting is enabled by default.
- **Pinch to zoom remote session** lets you use pinch-to-zoom gestures. If the app you're using through Remote Desktop supports multi-touch (introduced in Windows 8), disable this feature.
- Enable **Use scancode input when available** if your remote app doesn't respond properly to keyboard input sent as scancode. Input is sent as unicode when disabled.
- **Help improve Remote Desktop** sends anonymous data about how you use Remote Desktop for Android to Microsoft. We use this data to improve the client. To learn more about our privacy policy and what kinds of data we collect, see the [Microsoft Privacy Statement](https://privacy.microsoft.com/privacystatement). This setting is enabled by default.

## Manage display settings

To change the display settings tap **Settings**, and then tap **Display** from the Connection Center.

You can set the following display settings:

- **Orientation** sets the preferred orientation (landscape or portrait) for your session.
  
  >[!NOTE]
  > If you connect to a PC running Windows 8 or earlier, the session won't scale correctly if the orientation of the device changes. To make the client scale correctly, disconnect from the PC, then reconnect in the orientation you want to use. You can also ensure correct scaling by using a PC with Windows 10 instead.

- **Resolution** sets the remote resolution you want to use for desktop connections globally. If you have already set a custom resolution for an individual connection, this setting won't change that.
  
  >[!NOTE]
  >When you change the display settings, the changes only apply to new connections you make after the you changed the setting. To apply your changes to the session you're currently connected to, refresh your session by disconnecting and reconnecting.

## Manage your RD Gateways

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a private network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new RD Gateway:

1. In the Connection Center, tap **Settings**, and then tap **Gateways**.
2. Tap **+** to add a new gateway.
3. Enter the following information:
   - Enter the name of the computer you want to use as a gateway into **Server name**. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: RDGateway:443 or 10.0.0.1:443).
   - Select the **User account** you'll use to access the RD Gateway.
     - Select **Use desktop user account** to use the same credentials that you specified for the remote PC.
     - Select **Add user account** to save an account that you use frequently so you don't have to enter credentials every time you sign in. For more information, see [Manage your user accounts](#manage-your-user-accounts).

To delete an RD Gateway:

1. In the Connection Center, tap **Settings**, and then tap **Gateways**.
2. Tap and hold a gateway in the list to select it. You can select multiple gateways at once.
3. Tap the trash can to delete the selected gateway.

## Manage your user accounts

You can save user accounts to use whenever you connect to a remote desktop or remote resources.

To save a user account:

1. In the Connection Center, tap **Settings**, and then tap **User accounts**.
2. Tap **+** to add a new user account.
3. Enter the following information:
   - The **User Name** to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - The **Password** for the user you specified. Every user account that you want to save to use for remote connections needs to have a password associated with it.
4. When you're done, tap **Save**.

To delete a saved user account:

1. In the Connection Center, tap **Settings**, and then tap **User accounts**.
2. Tap and hold a user account in the list to select it. You can select multiple users at the same time.
3. Tap the trash can to delete the selected user.

## Navigate the Remote Desktop session

Here's a brief introduction to how to open and navigate your Remote Desktop session.

### Start a Remote Desktop connection

1. Tap **the name of your Remote Desktop connection** to start the session.
2. If you're asked to verify the certificate for the remote desktop, tap **Connect**. You can also select **Don't ask me again for connections to this computer** to always accept the certificate by default.

### Connection bar

The connection bar gives you access to additional navigation controls. By default, the connection bar is placed in the middle at the top of the screen. Drag the bar to the left or right to move it.

- **Pan Control**: The pan control enables the screen to be enlarged and moved around. Pan control is only available for direct touch.
  - To show the pan control, tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon again to hide the control and return the screen to its original size.
  - To use the pan control, tap and hold it, then drag it in the direction you want to move the screen.
  - To move the pan control, double-tap and hold it to move the control around on the screen.
- **Additional options**: Tap the additional options icon to display the session selection bar and command bar.
- **Keyboard**: Tap the keyboard icon to display or hide the keyboard. The pan control is displayed automatically when the keyboard is displayed.

### Session selection bar

You can have multiple connections open to different PCs at the same time. Tap the connection bar to display the session selection bar on the left-hand side of the screen. The session selection bar lets you view your open connections and switch between them.

When you're connected to remote resources, you can switch between apps within that session by tapping the expander menu ( **>** ) and choosing from the list of available items.

To start a new session within your current connection, tap **Start New**, then choose from the list of available items.

To disconnect a session, tap **X** in the left-hand side of the session tile.

### Command bar

Tap the connection bar to display the command bar on the right-hand side of the screen. On the command bar, you can switch between mouse modes (direct touch and mouse pointer) or tap the Home button to return to the Connection Center. You can also tap the Back button to return to the Connection Center. Returning to the Connection Center won't disconnect your active session.

### Use touch gestures and mouse modes in a remote session

The client uses standard touch gestures. You can also use touch gestures to replicate mouse actions on the remote desktop. The following table explains which gestures match which mouse actions in each mouse mode.

> [!NOTE]
> Native touch gestures are supported in Direct Touch mode in Windows 8 or later.

| Mouse mode    | Mouse action         | Gesture                                                                 |
|---------------|----------------------|-------------------------------------------------------------------------|
| Direct touch  | Left-click           | Tap with one finger                                                     |
| Direct touch  | Right-click          | Tap with one finger and hold, then release                              |
| Mouse pointer | Zoom                 | Use two fingers and pinch to zoom out or move fingers apart to zoom in. |
| Mouse pointer | Left-click           | Tap with one finger                                                     |
| Mouse pointer | Left-click and drag  | Double-tap and hold with one finger, then drag                          |
| Mouse pointer | Right-click          | Tap with two fingers                                                    |
| Mouse pointer | Right-click and drag | Double-tap and hold with two fingers, then drag                         |
| Mouse pointer | Mouse wheel          | Tap and hold with two fingers, then drag up or down                     |

## Join the Beta channel

If you want access to the latest features before anyone else, or want to help identify issues before new versions are released, then the Beta channel is for you! The Beta channel is also a great way for enterprise admins to validate new versions of the Android client for users in their environment.

To join the Beta, simply provide consent to access preview versions and download the client. You'll receive preview versions directly through the Google Play Store.

[Join the Beta](https://play.google.com/apps/testing/com.microsoft.rdc.androidx)