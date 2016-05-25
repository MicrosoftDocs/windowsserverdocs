---
title: Getting Started with Remote Desktop Client on Mac
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b6e6ca2a-329f-4f0f-9f08-d9b00d606e25
author: lizap
---
# Getting Started with Remote Desktop Client on Mac
Devices running OS 10.7 and newer are supported.  
  
## Help contents for the Microsoft Remote Desktop Client on Mac  
Microsoft Remote Desktop Client gives you the ability to get work done from almost anywhere by providing an easy way to use your Mac to:  
  
-   Connect to a remote PC to access all of your apps, files, and network resources  
  
-   Access published Windows apps hosted on Microsoft Azure  
  
> [!NOTE]  
> The information in this article applies primarily to the full version of the Mac client \- the version available in the Mac AppStore. The latest Mac client beta does not yet have support for all of the features described below. For more information about the beta and what is available in that client, check out the [beta client release notes](http://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409).  
  
## Here's how to get started with the Remote Desktop Client:  
Follow these steps to get started with Remote Desktop Client on your Mac.  
  
1.  Download the Remote Desktop Client from the [Mac App Store](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12&ls=1).  
  
2.  [Set up your remote PC to allow remote connections](https://social.technet.microsoft.com/Forums/en-US/169da213-5173-4552-9005-c7a355c0d12a/connect-to-your-pc-using-microsoft-rdp-apps?forum=winRDc).  
  
3.  [Create \/ Edit Remote Desktops](#BKMK_CEP), or add [Remote Resources](#bkmk-RemRes1) using the Remote Desktop client.  
  
A remote desktop connection summarizes all the settings for the remote desktop you want to connect to.  
  
Remote Resources enables access to programs, session\-based desktops, and virtual desktops published using on\-premises RemoteApp and Desktop Connections. This feature is typically available in corporate environments.  
  
RemoteApp is also available as a cloud\-based service that provides access to published applications on Microsoft Azure. For more information, visit the Azure RemoteApp [landing page](http://go.microsoft.com/fwlink/p/?LinkId=396715).  
  
> [!WARNING]  
> For a list of supported Windows versions, see [Remote Desktop Client on Mac: FAQ](../Topic/Remote-Desktop-Client-on-Mac--FAQ.md)  
  
## What about the Mac beta client?  
We're currently testing a new beta client for Mac. Want to check it out? Go [here](http://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409) and click **Download**. You don't need to create an account or sign into HockeyApp to download the beta client.  
  
If you already have the client, you can check for updates to ensure you have the latest version. In the beta client, click **Microsoft Remote Desktop Beta** at the top, and then click **Check for updates**.  
  
## <a name="BKMK_GTK"></a>Getting to know the Connection Center  
After the Remote Desktop Client for Mac is installed, start the app, and the Connection Center will open. You can use the Connection Center to:  
  
-   Connect to a Windows PC or server  
  
-   Access on\-premises work resources published using RemoteApp and Desktop Connections  
  
-   Access apps in the cloud through Microsoft Azure RemoteApp  
  
-   Manage remote desktops  
  
-   Modify settings  
  
## <a name="BKMK_CEP"></a>Create \/ Edit Remote Desktops  
A remote desktop summarizes all the settings for the remote desktop connection.  
  
**Create a Remote Desktop**  
  
1.  On the Connection Center screen, click **New**.  
  
2.  In the **Edit Remote Desktops** window, enter information for the remote desktop connection:  
  
    -   General  
  
        -   Connection name \(Optional\): The name of the remote desktop in the connection center. This can be any string. If this is field is empty, the PC name will be displayed.  
  
        -   PC name: The name of the PC you want to connect to. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the PC name, for example: MyDesktop:3389 or 10.0.0.1:3389.  
  
        -   Gateway: The Remote Desktop Gateway enables authorized users to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network from any Internet\-connected device. You can either select a gateway that is already configured, or add a new one. No gateway configured is displayed if no Gateway is selected. How to configure a gateway is explained in the section on the Remote Desktop Gateway. Ask your network administrator for the name of your Remote Desktop Gateway.  
  
        -   Credentials: The user name and password to be used for the remote PC you are connecting to. If no credentials are displayed, the log on screen will be displayed after clicking the remote desktop. The user name can be entered in the following formats: user\_name, domain\\user\_name, and user\_name@domain.com.  
  
        -   Resolution: Select the display resolution for the remote session.  
  
        -   Colors: Select the color depth for the remote session.  
  
        -   Full screen mode: Choose between the OS X native full screen feature \(Mac OS X 10.7\+\) or the custom full screen mode which enables the multi\-monitor feature to provide a better experience for users of Mac OS X versions 10.7 and 10.8..  
  
        -   Start session in full screen: The remote session will start using the full screen. Disable this option if you prefer to start a remote desktop connection in windowed mode.  
  
        -   Scale content: Enable the aspect ratio to be fixed for the session content.  
  
        -   Use all monitors: Enable use of all monitors for the remote session.  
  
    -   Session  
  
        -   Sound: Select the device to play audio during the remote session. You can configure sound to be played on the local device, the remote PC, or not at all.  
  
        -   Connect to admin session: Connect to an administration session on a server running Windows Server 2003 and newer.  
  
        -   Forward printing devices: Locally installed printers are available during the remote session.  
  
        -   Swap mouse buttons: Whenever a mouse gesture would send a command with the left mouse button, it sends the same command with the right mouse button instead. This is necessary if the remote PC is configured for left\-handed mouse mode.  
  
    -   Redirection  
  
        Folder redirection enables access to local folders during the remote session. Click the \+ button at the bottom of the dialog and choose a folder you want to have redirected.  
  
        **Configure Folder Redirection**  
  
        1.  Click the **\+** button.  
  
        2.  In the Add Local Folder window, enter the following information:  
  
            -   Name: Set a name for the folder to be available during the remote session.  
  
            -   Path: Select the path to the folder to be available during the remote session.  
  
3.  Click the close button to save the remote desktop.  
  
**Edit Remote Desktop Settings**  
  
To change the settings of a specific remote desktop, right\-click the remote desktop and then click edit. When adding or modifying a remote desktop, the following tabs are available:  
  
-   General  
  
-   Session  
  
-   Redirection  
  
**Delete a Remote Desktop**  
  
1.  On the Connection Center screen, tap the right\-click the remote desktop to delete.  
  
2.  Click **Delete**, and then click **Yes**.  
  
**Copy a Remote Desktop**  
  
1.  On the Connection Center screen, tap the right\-click the remote desktop to copy.  
  
2.  Click **Duplicate** to copy the remote desktop.  
  
## Export Remote Desktops  
Remote desktops can be exported. Remote desktops are saved in separate files with an RDP extension.  
  
**Export a Remote Desktop**  
  
1.  On the Connection Center screen, tap the right\-click the remote desktop to export.  
  
2.  Click **Export**.  
  
3.  In the **Export Options** window, click **Browse** to select a path for the file.  
  
4.  Click **OK** to export the remote desktop.  
  
## Import Remote Desktops  
Exported remote desktop files can be imported.  
  
**Import a Remote Desktop**  
  
1.  On the menu bar click **File**, and then click **Import**.  
  
2.  In the **Import Bookmarks** window, browse and select the remote desktop file.  
  
3.  Click **Open** to import the remote desktop connection.  
  
## Search Remote Desktops  
Search can be a useful tool when you have to manage many remote desktops.  
  
**Search for a Remote Desktop**  
  
1.  On the Connection Center screen, tap the search text box.  
  
2.  Enter text included in the PC name or the connection name of the remote desktop to filter remote desktops list.  
  
## Rearrange Remote Desktops  
Depending on your environment, the list of remote desktops can get quite long. The remote desktops in this list can be rearranged to bring frequently used remote desktops to the top of the list and remote desktops that are used less frequently can be moved towards the bottom of the list.  
  
**Rearrange Remote Desktop in Connection Center**  
  
1.  Click and hold a remote desktop.  
  
2.  Drag and drop the remote desktop to a new position in the list.  
  
## Manage Preferences  
These settings apply for all connections and session preferences:  
  
**Update Preferences:** In the Connection Center, click **Preferences**.  
  
-   Gateway: Display the list of available Remote Desktop Gateways. Select, configure, or add an RD Gateway.  
  
-   Resolution: Select the display resolution for remote desktop sessions.  
  
## Remote Desktop Gateway  
A Remote Desktop Gateway \(RD Gateway\) enables authorized users to connect to a remote computer on a corporate network from anywhere on the Internet. The Remote Desktop Client for Mac supports RD Gateway. You can create and manage your gateways using the Remote Desktop Client.  
  
**Set up a New Gateway**  
  
1.  On the Connection Center screen, click **Preferences**.  
  
2.  In the **Preferences** window, click **Gateway**. Enter information for the Remote Desktop Gateway:  
  
    -   Gateway name: The name of the gateway to be displayed. This can be any string. If this is field is empty, the server will be displayed.  
  
    -   Server: The name of the computer you want to use as gateway. This can be a Windows computer name, an Internet domain name or an IP address.  You can optionally append port information to the server name, for example: RDGateway:443 or 10.0.0.1:443.  
  
    -   User name: The user name to be used for the RD Gateway you are connecting to. If a user name and password are not entered, the credentials for the remote desktop connection will be used.  
  
    -   Password: The password to be used for the RD Gateway you are connecting to.  
  
3.  Click **\+** to add the RD Gateway, and then click close.  
  
**Delete a Gateway**  
  
1.  On the Connection Center screen, click **Preferences**.  
  
2.  In the **Preferences** window, click **Gateway**.  
  
3.  Select the RD Gateway to delete, click **\-**, and then click close.  
  
## Resolution  
The resolution setting allows you to select the display resolution for the remote desktop session.  
  
**Add a Resolution**  
  
1.  On the Connection Center screen, click **Preferences**.  
  
2.  In the **Preferences** window, click **Resolution**.  
  
3.  Click **\+**.  
  
4.  In the **Add Resolution** window, enter a resolution width and height and then click **OK**.  
  
**Delete a Resolution**  
  
1.  On the Connection Center screen, click **Preferences**.  
  
2.  In the **Preferences** window, click **Resolution**.  
  
3.  Select the resolution to delete, click **\-**, and then click close.  
  
**Displays have separate Spaces**  
  
Mac OS X 10.9 users who have disabled **Displays have separate Spaces** in Mavericks \(System Preferences \-> Mission Control\) need to configure this setting in the Microsoft Remote Desktop client using the same option.  
  
## <a name="bkmk-RemRes1"></a>Remote Resources  
Remote Resources enables access to RemoteApp programs, session\-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.  
  
-   The URL displays the link to the RD Web Access server enabling access to RemoteApp and Desktop Connections.  
  
-   The configured RemoteApp and Desktop Connections are listed.  
  
**Add Remote Resources**  
  
1.  On the Connection Center screen, tap **Remote Resources**.  
  
2.  Enter information for the Remote Resource:  
  
    -   URL: The URL of the RD Web Access server.  
  
    -   User name: The user name to be used for the RD Web Access server you are connecting to.  
  
    -   Password: The password to be used for the RD Web Access server you are connecting to.  
  
3.  Click **Refresh** and then click close.  
  
**Refresh Remote Resources**  
  
1.  On the Connection Center screen, tap **Remote Resources**.  
  
2.  Click **Refresh** and then click close.  
  
**Delete Remote Resources**  
  
1.  On the Connection Center screen, tap **Remote Resources**.  
  
2.  Delete the URL.  
  
3.  Click **Refresh** and then click close.  
  
**Drive Redirection for Remote Resources**  
  
Drive redirection is supported for remote resources, so that you can save files created with a remote application locally to your Mac. The redirected folder is always your home directory displayed as a network drive in the remote session.  
  
> [!NOTE]  
> In order to use this feature, the administrator needs to set the appropriate settings on the server.  
  
## Navigating the Remote Desktop Session  
Once you start a remote desktop connection there are tools available that you can use to navigate the session.  
  
**Start a Remote Desktop Connection**: Double\-click the remote desktop connection.  
  
If you are in full screen mode, the menu bar at the top of the screen will be hidden. This remote connection menu bar includes tools you can use to navigate the session.  
  
**Remote Desktop Menu Bar**  
  
-   Microsoft Remote Desktop: This menu enables you to manage the remote desktop session.  
  
-   Window: Enables you to manage the windows.  
  
-   Help: View web\-based help.  
  
**Start a Remote Resource**: Double\-click the remote application.  
  
**Remote Resource Menu Bar**  
  
-   Microsoft Remote Desktop: This menu enables you to manage the remote desktop session.  
  
-   Remote Desktop Client: Right\-click the remote desktop client icon in the menu bar to switch between active applications. You can also right\-click the Remote Desktop Client icon in the dock to switch between applications.  
  
**Mac and Windows Keyboard Layouts**  
  
Mac keyboard layouts differ from the Windows keyboard layouts. The OS keyboard locale is suggested to the remote PC. If the OS keyboard locale is not used, we recommend checking the keyboard setting on the remote PC and changing the setting manually.  
  
-   The Command key on the Mac keyboard equals the Windows key.  
  
-   To perform actions that use the Command button on the Mac, you will need to use the control button in Windows \(e.g.: Copy \= Ctrl \+ C\).  
  
-   The function keys can be activated in the session by pressing additionally the FN key \(e.g.: FN \+ F1\).  
  
-   The Alt key to the right of the space bar on the Mac keyboard equals the Alt Gr\/right Alt key in Windows.  
  
## Support for Remote Desktop Gateway pluggable authentication and authorization  
Windows Server 2012 R2 introduced support for a new authentication method, Remote Desktop Gateway pluggable authentication and authorization, which provides more flexibility for custom authentication routines. You can now use this authentication model with the Mac client. To learn more about this feature, check out [http:\/\/aka.ms\/paa\-sample](http://aka.ms/paa-sample).  
  
> [!IMPORTANT]  
> Custom authentication and authorization models before Windows 8.1 are not supported, although the article above discusses them.  
  
## <a name="BKMK_LINKS"></a>See also  
The following list provides additional resources for using Remote Desktop mobile clients.  
  
-   **Android:** [Remote Desktop Client on Android: FAQ](assetId:///71de3651-276b-4f90-b025-3b0ad5bf9f62)  
  
-   **iPad or iOS:** [Remote Desktop Client on iOS: FAQ](assetId:///ac7f2646-695d-48c6-8892-479c1f824225)  
  
-   **Mac:** [Remote Desktop Client on Mac: FAQ](../Topic/Remote-Desktop-Client-on-Mac--FAQ.md)  
  
-   **Windows 8:** [Remote Desktop Connection: FAQ](http://windows.microsoft.com/windows-8/remote-desktop-connection-frequently-asked-questions)  
  
