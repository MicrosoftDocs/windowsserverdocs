---
title: Get started with the Microsoft Store Client
description: Basic set up steps for the Remote Desktop client for Windows Store.
ms.topic: article
ms.assetid: 64f038e1-40ec-4c67-938b-72edea49e5d8
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 06/01/2020
ms.localizationpriority: medium
---
# Get started with the Microsoft Store Client

>Applies to: Windows 10

You can use the Remote Desktop client for Windows to work with Windows apps and desktops remotely from a different Windows device.

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.md) if you have any questions.

> [!NOTE]
> - Curious about the new releases for the Microsoft Store Client? Check out [What's new in the Microsoft Store Client](windows-whatsnew.md)
> - You can run the client on any supported version of Windows 10.

## Get the RD client and start using it

Follow these steps to get started with Remote Desktop on your Windows 10 device:

1. Download the Remote Desktop client from [Microsoft Store](https://www.microsoft.com/store/p/microsoft-remote-desktop/9wzdncrfj3ps).
2. [Set up your PC to accept remote connections](remote-desktop-allow-access.md).
3. Add a Remote Desktop connection or a remote resource. You use a connection to connect directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or virtual desktop published by your admin.
4. Pin items so you can get to Remote Desktop quickly.

### Add a Remote Desktop connection

To create a Remote Desktop connection:

1. In the Connection Center, tap **+ Add**, and then tap **Desktop**.
2. Enter the following information for the computer you want to connect to:
   - **PC name** – the name of the computer. The PC name can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, **MyDesktop:3389** or **10.0.0.1:3389**).
   - **User account** – The user account to use to access the remote PC. Tap **+** to add a new account or select an existing account. You can use the following formats for the username: *user_name*, *domain\user_name*, or <em>user_name@domain.com</em>. You can also specify whether to prompt for credentials during the connection by selecting **Ask me every time**.
3. You can also set additional options by tapping on **Show more**:
   - **Display name** – An easy-to-remember name for the PC you're connecting to. You can use any string, but if you don't specify a friendly name, the PC name is displayed.
   - **Group** – Specify a group to make it easier to find your connections later. You can add a new group by tapping **+** or select one from the list.
   - **Gateway** – The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.
   - **Connect to admin session** - Use this option to connect to a console session to administrate a Windows server.
   - **Swap mouse buttons** – Use this option to swap the left mouse button functions for the right mouse button. Swapping mouse buttons is necessary when you use a PC configured for a left-handed user but you only have a right-handed mouse.
   - **Set my remote session resolution to:** – Select the resolution you want to use in the session. **Choose for me** will set the resolution based on the size of the client.
   - **Change the size of the display:** – When selecting a high static resolution for the session, you can use this setting to make items on the screen appear larger to improve readability. This setting only applies when connecting to Windows 8.1 or later.
   - **Update the remote session resolution on resize** – When enabled, the client will dynamically update the session resolution based on the size of the client. This setting only applies when connecting to Windows 8.1 or later.
   - **Clipboard** – When enabled, allows you to copy text and images to/from the remote PC.
   - **Audio Playback** – Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote PC, or not at all.
   - **Audio Recording** – When enabled, allows you to use a local microphone with applications on the remote PC.
4. Tap **Save**.

Need to edit these settings? Tap the overflow menu (**...**) next to the name of the desktop, and then tap **Edit**.

Want to delete the connection? Again, tap the overflow menu (**...**), and then tap **Remove**.

### Add a remote resource

Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published by your admin using Remote Desktop Services.

To add a remote resource:

1. On the Connection Center screen, tap **+ Add**, and then tap **Remote resources**.
2. Enter the **Feed URL** provided by your admin and tap **Find feeds**.
3. When prompted, provide the credentials to subscribe to the feed.

The remote resources will be displayed in the Connection Center.

To delete remote resources:

1. In the Connection Center, tap the overflow menu (**...**) next to the remote resource.
2. Tap **Remove**.

### Pin a saved desktop to your Start menu

To pin a connection to your Start menu, tap the overflow menu (**...**) next to the name of the desktop, and then tap **Pin to Start**.

Now you can start the remote desktop connection directly from your Start menu by tapping it.

## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, tap **Settings**.
2. Next to Gateway, tap **+** to add a new gateway.

      >[!NOTE]
      >You can also add a gateway when you add a new connection.

3. Enter the following information:
   - **Server name** – The name of the computer you want to use as a gateway. The server name can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: **RDGateway:443** or **10.0.0.1:443**).
   - **User account** - Select or add a user account to use with the Remote Desktop Gateway you're connecting to. You can also select **Use desktop user account** to use the same credentials that you used for the remote desktop connection.
4. Tap **Save**.

## Global app settings

You can set the following global settings in your client by tapping **Settings**:

### Managed items

- **User account** - Allows you to add, edit, and delete user accounts saved in the client. You can also update the password for an account after it's changed.
- **Gateway** - Allows you to add, edit, and delete gateway servers saved in the client.
- **Group** - Allows you to add, edit, and delete groups saved in the client. You can also group connections here.

### Session settings

- **Start connections in full screen** - When enabled, anytime a connection is launched, the client will use the entire screen of the current monitor.
- **Start each connection in a new window** - When enabled, each connection is launched in a separate window, allowing you to place them on different monitors and switch between them using the taskbar.
- **When resizing the app:** - Allows you control over what happens when the client window is resized. Defaults to **Stretch the content, preserving aspect ratio**.
- **Use keyboard commands with:** - Lets you specify where keyboard commands like *WIN* or *ALT+TAB* are used. The default is to only send them to the session when the connection is in full screen.
- **Prevent the screen from timing out** - Allows you to keep the screen from timing out when a session is active. Preventing timeout is helpful when the connection doesn't need interaction for long periods of time.

### App settings

- **Show Desktop Previews** - Lets you see a preview of a desktop in the Connection Center before you connect to it. This setting is on by default.
- **Help improve Remote Desktop** - Sends anonymous data to Microsoft. We use this data to improve the client. To learn more about how we treat this anonymous and private data, see the [Microsoft Privacy Statement](https://privacy.microsoft.com/privacystatement). This setting is on by default.

### Manage your user accounts

When you connect to a desktop or remote resources, you can save the account's information to connect to it later. You can also define user accounts within the client instead of saving the user data when you connect to a desktop.

To create a new user account:

1. In the Connection Center, tap **Settings**.
2. Next to User account, tap **+** to add a new user account.
3. Enter the following information:
   - **Username** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - **Password** - The password for the user you specified. This field can be left blank to be prompted for a password during the connection.
4. Tap **Save**.

To delete a user account:

1. In the Connection Center, tap **Settings**.
2. Select the account to delete from the list under User account.
3. Next to User account, tap the edit icon.
4. Tap **Remove this account** at the bottom to delete the user account.
5. You can also edit the user account and tap **Save**.

## Navigate the Remote Desktop session

When you start a remote desktop connection, there are tools available that you can use to navigate the session.

### Start a Remote Desktop connection

1. Tap the Remote Desktop connection to start the session.
2. If you haven't saved credentials for the connection, you'll be prompted to provide a **Username** and **Password**.
3. If you're asked to verify the certificate for the remote desktop, review the information and ensure you trust this PC before tapping **Connect**. You can also select **Don't ask about this certificate again** to always accept this certificate.

### Connection bar

The connection bar gives you access to additional navigation controls. By default, the connection bar is placed in the middle at the top of the screen. Tap and drag the bar to the left or right to move it.

- **Pan Control** - The pan control enables the screen to be enlarged and moved around. Pan control is only available on touch-enabled devices and using the direct touch mode.
   - To enable or disable the pan control, tap the pan icon in the connection bar to display the pan control. The screen will zoom in while the pan control is active. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.
   - To use the pan control, tap and hold the pan control and then drag in the direction you want to move the screen.
   - To move the pan control, double-tap and hold the pan control to move the control on the screen.
- **Additional options** - Tap the additional options icon to display the session selection bar and command bar.
- **Keyboard** - Tap the keyboard icon to display or hide the on-screen keyboard. The pan control is displayed automatically when the keyboard is displayed.

### Command bar

Tap the **...** on the connection bar to display the command bar on the right side of the screen.

- **Home** - Use the Home button to return to the connection center from the command bar.
  - You can also use the back button for the same action. If you use the back button, your active session won't be disconnected, allowing you to launch additional connections.
- **Disconnect** - Use the Disconnect button to disconnect from the session. Your apps will remain active as long as the session is still active on the remote PC.
- **Full-screen** - Enters or exits full screen mode.
- **Touch or Mouse** - You can switch between the mouse modes (Direct Touch and Mouse Pointer).

### Use direct touch gestures and mouse modes in a remote session

Two mouse modes are available to interact with the session.

- **Direct touch**: Passes all of the touch contacts to the session to be interpreted remotely.
  - Used in the same way you would use Windows with a touch screen.
- **Mouse pointer**: Transforms your local touch screen into a large touchpad, letting you move a mouse pointer in the session.
  - Used in the same way you would use Windows with a touchpad.

> [!NOTE]
> In Windows 8 or later, the native touch gestures are supported in Direct Touch mode.

| Mouse mode    | Mouse operation      | Gesture                                                               |
|---------------|----------------------|-----------------------------------------------------------------------|
| Direct touch  | Left-click           | Tap with one finger                                                          |
| Direct touch  | Right-click          | Tap and hold with one finger                                                |
| Mouse pointer | Left-click           | Tap with one finger                                                          |
| Mouse pointer | Left-click and drag  | Double-tap and hold with one finger, then drag                               |
| Mouse pointer | Right-click          | Tap with two fingers                                                          |
| Mouse pointer | Right-click and drag | Double-tap and hold with two fingers, then drag                              |
| Mouse pointer | Mouse wheel          | Tap and hold with two fingers, then drag up or down                          |
| Mouse pointer | Zoom                 | With two fingers, pinch to zoom in and move fingers apart to zoom out |

> [!TIP]
> Questions and comments are always welcome. However, if you post support requests or product feedback in this article's comments section, we won't be able to respond to your feedback. If you need help or want to troubleshoot your client, we highly recommend you go to the [Remote Desktop client forum](/answers/topics/windows-remote-desktop-client.html) and start a new thread. If you have a feature suggestion, you can tell us using the [Feedback Hub](feedback-hub://?tabid=2&contextid=605).