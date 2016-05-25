---
title: Getting Started with Remote Desktop Client on iOS
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cd61dc7f-0b48-45cc-a4ab-db93a1091797
author: lizap
---
# Getting Started with Remote Desktop Client on iOS
Devices running iOS 6.X or newer are supported.  
  
> [!TIP]  
> Remote Desktop Client on iOS is enhanced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Download the free [Windows Server 2012 R2 trial](http://www.microsoft.com/click/services/Redirect2.ashx?CR_CC=200357983), learn about the [benefits of Windows Server 2012 R2](http://www.microsoft.com/server-cloud/products/windows-server-2012-r2/default.aspx#fbid=FmmGaZKPvKd), and get free [Windows Server online technical training](http://www.microsoft.com/click/services/Redirect2.ashx?CR_CC=200357978).  
  
## Help contents for the Microsoft Remote Desktop Client on iOS  
Microsoft Remote Desktop Client gives you the ability to get work done from almost anywhere by providing an easy way to use your mobile device to:  
  
-   Connect to a remote PC to access all of your apps, files, and network resources  
  
-   Access published Windows apps hosted on Microsoft Azure  
  
## Here's how to get started with the Remote Desktop Client:  
Follow these steps to get started with Remote Desktop Client on your iOS device:  
  
1.  Download the Microsoft Remote Desktop Client from [iTunes](https://itunes.apple.com/us/app/microsoft-remote-desktop/id714464092?mt=8).  
  
2.  Set up your remote PC to allow remote connections.  
  
    -   Set up your computer running [Windows Vista](http://windows.microsoft.com/windows/connect-using-remote-desktop-connection#connect-using-remote-desktop-connection=windows-vista).  
  
    -   Set up your computer running [Windows 7](http://windows.microsoft.com/windows/connect-using-remote-desktop-connection#connect-using-remote-desktop-connection=windows-7).  
  
    -   Set up your computer running [Windows 8](http://windows.microsoft.com/windows-8/remote-desktop-app-faq).  
  
3.  [Create a Remote Desktop](#BKMK_CEB), or add a [Remote Resource](#bkmk-RemRes1) using the Remote Desktop Client.  
  
A remote desktop connection summarizes all the settings for the remote desktop you want to connect to.  
  
Remote Resources enables access to RemoteApp programs, session\-based desktops, and virtual desktops published on\-premises using RemoteApp and Desktop Connections. This feature is typically available in corporate environments.  
  
RemoteApp is also available as a cloud\-based service that provides access to published applications on Microsoft Azure. For more information, visit the Azure RemoteApp [landing page](http://go.microsoft.com/fwlink/p/?LinkId=396715).  
  
> [!IMPORTANT]  
> For a list of supported Windows versions, see [Remote Desktop Client on iOS: FAQ](assetId:///ac7f2646-695d-48c6-8892-479c1f824225)  
  
## <a name="BKMK_GTK"></a>Getting to know the Connection Center  
After the Remote Desktop Client is installed, start the app, and the connection center will open. You can use the connection center to:  
  
-   Connect to a Windows PC or server  
  
-   Access on\-premises work resources published using RemoteApp and Desktop Connections  
  
-   Access apps in the cloud through RemoteApp on Microsoft Azure  
  
-   Manage remote desktops  
  
-   Modify settings  
  
### <a name="BKMK_CEB"></a>Create \/ Edit Remote Desktops  
A remote desktop summarizes all the settings for the remote desktop connection.  
  
**Create a Remote Desktop**  
  
1.  On the Connection Center screen, tap the plus sign \(\+\) in the upper right corner and tap **Add PC or Server**.  
  
2.  In the **Create Connection** window, enter information for the remote desktop connection:  
  
    -   **PC name**: The name of the PC you want to connect to. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name, for example: MyDesktop:3389 or 10.0.0.1:3389.  
  
    -   **User name**: The user name to be used for the remote PC. The user name can be entered in the following formats: user\_name, domain\\user\_name, and  HYPERLINK "mailto:user\_name@domain.com" user\_name@domain.com. You can also specify whether to prompt for user name and password.  
  
    -   SETTINGS  
  
        -   **Friendly name \(Optional\)** : The name of the remote desktop in the connection center. This can be any string. If this field is empty, the PC name is used instead.  
  
        -   **Gateway \(Optional\)**: The Remote Desktop gateway enables authorized users to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network from any Internet\-connected device. How to configure a gateway is explained in the section on the Remote Desktop gateway. Ask your network administrator for the name of your Remote Desktop gateway.  
  
        -   **Sound**: Select the device to play audio during the remote session. You can configure sound to be played on the local device, the remote PC or not at all.  
  
        -   **Swap mouse buttons**: Whenever a mouse gesture would send a command with the left mouse button, it sends the same command with the right mouse button instead. This is necessary if the remote PC is configured for left\-handed mouse mode.  
  
        -   **Admin Mode**: Connect to an administration session on a server running Windows Server 2003 or later.  
  
3.  Tap **Save**.  
  
**Edit Remote Desktop Settings**  
  
To change the settings of a specific remote desktop press and hold the desktop you want to edit, and then tap the settings icon. When adding or modifying a remote desktop you can manage the following categories:  
  
-   Remote PC  
  
-   Settings  
  
**Delete a Remote Desktop**  
  
1.  On the Connection Center screen, press and hold the desktop you want to delete.  
  
2.  Tap the **Delete** icon to delete the remote desktop.  
  
## Gateway  
A Remote Desktop gateway \(RD Gateway\) enables authorized users to connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop Client.  
  
**Set up a New Gateway**  
  
1.  On the Connection Center screen, tap the settings icon, and then tap **Gateways**.  
  
2.  In the **Gateways** window tap **Add Remote Desktop gateway**.  
  
3.  In the **Add Remote Desktop Gateway** window, enter information for the Remote Desktop Gateway:  
  
    -   **Server Name**: The name of the computer you want to use as the gateway. This can be a Windows computer name, an Internet domain name or an IP address. You can also add port information to the server name, for example: RDGateway:443 or 10.0.0.1:443.  
  
    -   **User Name**: The user name and password to be used for the Remote Desktop Gateway you are connecting to. You can also select **Use connection credentials** to use the same user name and password as the remote desktop connection.  
  
4.  In the **Add Remote Desktop Gateway** window tap **Save**, and then tap **Settings** to return to the Settings window.  
  
5.  In the **Settings** window tap **Done** to save the new configuration.  
  
**Delete a Gateway**  
  
1.  On the Connection Center screen,  tap **Settings**, and then tap **Gateways**.  
  
2.  In the **Gateway** window, swipe a row from right to left to delete the RD Gateway.  
  
3.  Tap **Delete** to delete the gateway.  
  
You can also select the gateway, and then tap **Delete** at the bottom of the window.  
  
## User Management  
When you connect to a desktop or remote resources, you can save user accounts to select from again. You can manage your user accounts by using the Remote Desktop Client.  
  
**Create a new user account**  
  
1.  On the Connection Center screen, tap the settings icon, and then tap **User Names**.  
  
2.  Tap **Add User Account**.  
  
3.  Enter information for the user:  
  
    -   **User Name**: The user name to save for remote connections. The user name can be entered in the following formats: user\_name, domain\\user\_name, and  HYPERLINK "mailto:user\_name@domain.com" user\_name@domain.com.  
  
    -   **Password**: The password to save for remote connections. Every user account that you want to use to connect to a desktop or remote resource must have a password associated with it.  
  
4.  Tap **Save**, and then tap **Settings** to return to the Settings window.  
  
5.  Tap **Done** to save the new configuration.  
  
**Delete a User Account**  
  
1.  On the Connection Center screen, tap **Settings**, and then tap **User Names**.  
  
2.  Swipe a row from right to left to delete the user.  
  
3.  Tap **Delete** to delete the user account.  
  
## <a name="bkmk-RemRes1"></a>Remote Resources  
Remote Resources enables access to RemoteApp programs, session\-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.  
  
-   The URL displays the link to the RD Web Access server enabling access to RemoteApp and Desktop Connections.  
  
-   The configured RemoteApp and Desktop Connections are listed.  
  
**Add Remote Resources**  
  
1.  On the Connection Center screen, tap the plus sign \(\+\), and then tap **Add Remote Resources**.  
  
2.  In the **Create Connection** window, enter information for the remote resource:  
  
    -   **Feed URL**: The URL of the RD Web Access server. You can also enter your corporate email account in this field – this will search for you the RD Web Access Server linked to your email address.  
  
    -   User name: The user name and password to be used for the RD Web Access server you are connecting to.  
  
3.  Tap **Save**. The remote resources will be displayed in the connection center.  
  
**Delete Remote Resources**  
  
1.  On the Connection Center screen, press and hold any of the applications or desktops in the remote resources or the name of the application feed.  
  
2.  Tap **Settings** on the URL name.  
  
3.  Tap **Delete** at the bottom of the window.  
  
4.  Confirm the deletion by clicking **Delete** again.  
  
## Navigating the Remote Desktop Session  
Once you start a remote desktop connection there are tools available that you can use to navigate the session.  
  
**Start a Remote Desktop Connection**  
  
1.  Tap the remote desktop connection to start the remote desktop session.  
  
2.  If you are asked to verify the certificate for the remote PC,  tap **Accept** to connect. You can choose to always accept by sliding the **Don’t ask me again for connections to this computer** toggle to **On**.  
  
**Connection Bar**  
  
-   Pan Control: The pan control enables the screen to be enlarged and moved around.  
  
    > [!NOTE]  
    > The pan control is available using direct touch only.  
  
    -   Enable \/ Disable the pan control: Tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.  
  
    -   Use the pan control: Tap and hold the pan control and then drag in the direction you want to move the screen.  
  
    -   Move the pan control: Double tap and hold the pan control to move the control on the screen.  
  
-   Connection name: The current connection name is displayed. Tap the connection name to display the utility bar.  
  
-   Keyboard: The keyboard can be displayed, or hidden by tapping the keyboard icon. The pan control is displayed automatically when the keyboard is displayed.  
  
-   Move the connection bar: Tap and hold the connection bar, and then drag and drop to a new location at the top of the screen.  
  
**Session Selection bar**  
  
A new feature in 8.1.0 is the ability to have multiple connections open to different PCs at the same time. Tap the connection bar to display the session selection bar on the left\-hand side of the screen. The session selection bar enables you to view your open connections and swap between them. There is an additional option to launch new sessions or apps from your connection center.  
  
-   Switch between apps in an open remote resource session  
  
    When you are connected to remote resources, you can swap between open applications within that session by tapping the expander menu and viewing the list of available items.  
  
-   Start a new session  
  
    You can start new applications or desktop sessions from within your current connection by tapping **Start New** and then choosing the session from the list of available items.  
  
**Command Bar**  
  
The command bar replaces the Utility Bar for versions before 8.1.0. You can switch between the mouse modes and return to the connection center from the command bar.  
  
**Direct touch gestures and mouse modes**  
  
Standard touch gestures are available when using the client. Touch gestures can also be used to replicate mouse actions on the remote desktop. The mouse modes available are defined in the table below.  
  
> [!NOTE]  
> When interacting with Windows 8 or newer, the native touch gestures are supported in Direct Touch mode. For more information on Windows 8 gestures see [Touch: Swipe, tap, and beyond](http://windows.microsoft.com/windows-8/touch-swipe-tap-beyond).  
  
|Mouse mode|Mouse operation|Gesture||  
|--------------|-------------------|-----------|-|  
|Direct touch|Left click|1 finger tap||  
|Direct touch|Right click|1 finger tap and hold||  
|Mouse pointer|Left click|1 finger tap||  
|Mouse pointer|Left click and drag|1 finger double tap and hold, then drag||  
|Mouse pointer|Right click|2 finger tap||  
|Mouse pointer|Right click and drag|2 finger double tap and hold, then drag||  
|Mouse pointer|Mouse wheel|2 finger tap and hold, then drag up\/down||  
|Mouse pointer|Zoom|Pinch two fingers to zoom in or spread two fingers to zoom out||  
  
**On\-screen Keyboards**  
  
On the iPad and iPhone you can use the button on the right edge of the bar above the keyboard to switch between the standard and additional keyboard.  
  
**Bluetooth Keyboard**  
  
If Bluetooth is enabled, a Bluetooth keyboard should be automatically detected.  
  
Due to limitations on the OS, special keys such as Ctrl, Option, and Function will not work as expected. The following keys currently work:  
  
-   Alphanumeric keys  
  
-   Cursor keys  
  
-   Tab: Tab works, but Shift\+Tab does not work  
  
-   Home \/ Pos1: Alt\+Left \= Home  
  
-   End: Alt\+Right \= End  
  
-   Page Up: Alt\+Up \= Page Up  
  
-   Page Down: Alt\+Down \= Page Down  
  
-   Select All: Command\+A \= Ctrl\+A \(Select all in most programs\)  
  
-   Cut: Command\+X \= Ctrl\+X \(Cut in most programs\)  
  
-   Copy: Command\+C \= Ctrl\+C \(Copy in most programs\)  
  
-   Paste: Command\+V \= Ctrl\+V \(Paste in most programs\)  
  
-   Symbols: Alt\+Alphanumeric keys will produce different symbols depending on the language configured  
  
## <a name="BKMK_LINKS"></a>See also  
The following list provides additional resources for using Remote Desktop Clients.  
  
-   **Android:** [Remote Desktop Client on Android: FAQ](assetId:///71de3651-276b-4f90-b025-3b0ad5bf9f62)  
  
-   **iPad or iOS:** [Remote Desktop Client on iOS: FAQ](assetId:///ac7f2646-695d-48c6-8892-479c1f824225)  
  
-   **Mac:** [Remote Desktop Client on Mac: FAQ](../Topic/Remote-Desktop-Client-on-Mac--FAQ.md)  
  
-   **Windows 8:** [Remote Desktop Connection: FAQ](http://windows.microsoft.com/windows-8/remote-desktop-connection-frequently-asked-questions)  
  
