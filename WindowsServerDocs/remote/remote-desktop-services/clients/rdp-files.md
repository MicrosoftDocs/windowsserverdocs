---
title: Supported Remote Desktop RDP file settings
description: Learn about the RDP file settings for Remote Desktop
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: btaintor
manager: dongill
ms.author: helohr
ms.date: 05/20/2019
ms.localizationpriority: medium
---
# Supported Remote desktop RDP file settings

The following table includes list of supported RDP file settings that you can use with the Windows and HTML clients. An “x” in the platform column indicates that the setting is supported. However, this list is not a complete list of supported settings for the Windows and HTML5 clients. We'll continue to update this table to include more supported RDP settings for the Windows and HTML5 clients as well as the macOS, iOS, and Android clients.

Please refer to [this documentation](https://go.microsoft.com/fwlink/?linkid=2098243&clcid=0x409) detailing how to use PowerShell to customize RDP properties for a host pool.

| RDP setting                        | Description            | Values                 | Default value          | Windows Virtual Desktop | Windows | HTML5   |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|:-------:|:-------:|
| alternate full address:s:value | Specifies an alternate name or IP address of the remote computer. | Any valid name or IP address of the remote computer, such as "10.10.15.15" | | x | x | x |
| alternate shell:s:value        | Determines whether a program starts automatically when you connect with RDP. To specify an alternate shell, enter a valid path to an executable file for the value, such as "C:\ProgramFiles\Office\word.exe". This setting also determines which path or alias of the Remote Application to be started at connection time if RemoteApplicationMode is enabled. | "C:\ProgramFiles\Office\word.exe" || x | x | x |
| audiocapturemode:i:value | Indicates whether audio input/output redirection is enabled. | - 0: Disable audio capture from the local device<br>- 1: Enable audio capture from the local device and redirection to an audio application in the remote session | 0 | x | x | |
| audiomode:i:value | Determines whether the local or remote machine plays audio. | - 0: Play sounds on local computer (Play on this computer)<br>- 1: Play sounds on remote computer (Play on remote computer)<br>- 2: Do not play sounds (Do not play) | 0 | x | x | x |
| authentication level:i:value | Defines the server authentication level settings. | - 0: If server authentication fails, connect to the computer without warning (Connect and don't warn me)<br>- 1: If server authentication fails, don't establish a connection (Don't connect)<br>- 2: If server authentication fails, show a warning and allow me to connect or refuse the connection (Warn me)<br>- 3: No authentication requirement specified. | 3 | x | x ||
| autoreconnection enabled:i:value | Determines whether the client computer will automatically try to reconnect to the remote computer if the connection is dropped, such as when there's a network connectivity interruption. | - 0: Client computer does not automatically try to reconnect<br>- 1: Client computer automatically tries to reconnect| 1 | x | x | x |
| bandwidthautodetect:i:value | Determines whether automatic network type detection is enabled | - 0: Disable automatic network type detection<br>- 1: Enable automatic network type detection | 1 | x | x | x |
| camerastoredirect:s:value | Configures which cameras to redirect. This setting uses a semicolon-delimited list of KSCATEGORY_VIDEO_CAMERA interfaces of cameras enabled for redirection. | - * : Redirect all cameras<br> - One can exclude a specific camera by prepending the symbolic link string with "-", such as camerastoredirect:s:\\?\usb#vid_0bda&pid_58b0&mi | | x | x | |
| compression:i:value | Determines whether bulk compression is enabled when it is transmitted by RDP to the local computer.|- 0: Disable RDP bulk compression<br>- 1: Enable RDP bulk compression | 1 | x | x | x |
| desktop size id:i:value | Specifies dimensions of the remote session desktop from a set of pre-defined options. This setting is overridden if either desktopheight or desktopwidth are specified.| -0: 640×480<br>- 1: 800×600<br>- 2: 1024×768<br>- 3: 1280×1024<br>- 4: 1600×1200 | 0 | x | x | x |
| desktopheight:i:value | Determines the resolution height (in pixels) on the remote computer when you connect by using Remote Desktop Connection. This setting corresponds to the selection in the Display configuration slider on the Display tab under Options in RDC. | Numerical value between 200 and 2048 | The default value is set to the resolution on the local computer | x | x | x |
| desktopwidth:i:value | Determines the resolution width (in pixels) on the remote computer when you connect by using Remote Desktop Connection. This setting corresponds to the selection in the Display configuration slider on the Display tab under Options in RDC. | Numerical value between 200 and 4096 | The default value is set to the resolution on the local computer | x | x | x |
| devicestoredirect:s:value | Determines which devices on the client computer will be redirected and available in the remote session. | - *: Redirect all supported devices, including ones that are connected later<br> - Valid hardware ID for one or more devices | | x | x | x |
| disableconnectionsharing:i:value | Determines whether the remote desktop client reconnects to any existing open connections or initiate a new connection when a RemoteApp or desktop is launched | - 0: Reconnect to any existing session<br>- 1: Initiate new connection | 0 | x | x | x |
| domain:s:value | Specifies the name of the domain in which the user account that will be used to log on to the remote computer is located. | A valid domain name, such as "CONTOSO" | No Default Value | x | x | x |
| drivestoredirect:s:value | Determines which local disk drives on the client computer will be redirected and available in the remote session. | - No value specified: don't redirect any drives<br>- * : Redirect all disk drives, including drives that are connected later<br>- DynamicDrives: redirect any drives that are connected later<br>- The drive and labels for one or more drives, such as "drivestoredirect:s:C:;E:;": redirect the specified drive(s)| No value specified: don't redirect any drives | x | x	| |
| enablecredsspsupport:i:value | Determines whether RDP will use the Credential Security Support Provider (CredSSP) for authentication if it is available. | - 0: RDP will not use CredSSP, even if the operating system supports CredSSP<br>- 1: RDP will use CredSSP if the operating system support CredSSP | 1 | x | x | |
| encode redirected video capture:i:value | Enables or disables encoding of redirected video. | - 0: Disable encoding of redirected video<br>- 1: Enable encoding of redirected video | 1 | x | x | x |
| full address:s:value | This setting specifies the name or IP address of the remote computer that you want to connect to | A valid computer name, IPv4 address, or IPv6 address. | | x | x | x |
| gatewaycredentialssource:i:value | Specifies or retrieves the RD Gateway authentication method. | - 0: Ask for password (NTLM)<br>- 1: Use smart card<br>- 4: Allow user to select later | 0 | x | x | x |
| gatewayhostname:s:value | Specifies the RD Gateway host name. | Valid gateway server address. ||x|x|x|
| gatewayprofileusagemethod:i:value | Specifies whether to use default RD Gateway settings | - 0: Use the default profile mode, as specified by the administrator<br>- 1: Use explicit settings, as specified by the user | 0 | x | x | x |
| gatewayusagemethod:i:value | Specifies when to use the RD Gateway server | - 0: Don't use an RD Gateway server<br>- 1: Always use an RD Gateway server<br>- 2: Use an RD Gateway server if a direct connection cannot be made to the RD Session Host<br>- 3: Use the default RD Gateway server settings<br>- 4: Don't use an RD Gateway, bypass server for local addresses<br>Setting this property value to 0 or 4 are is effectively equivalent, but setting this property to 4 enables the option to bypass local addresses. | | x | x | x |
| networkautodetect:i:value | Determines whether or not to use automatic network bandwidth detection. Requires the option bandwidthautodetect to be set and correlates with connection type 7. | - 0: Don't use automatic network bandwidth detection<br> - 1: Use automatic network bandwidth detection | 1 | x ||x|
| promptcredentialonce:i:value | Determines whether a user's credentials are saved and used for both the RD Gateway and the remote computer.|- 0: Remote session will not use the same credentials<br>- 1: Remote session will use the same credentials|1|x|x||
| redirectclipboard:i:value | Determines whether clipboard redirection is enabled. | - 0: Clipboard on local computer isn't available in remote session<br>- 1: Clipboard on local computer is available in remote session|1|x|x|x|
| redirected video capture encoding quality:i:value | Controls the quality of encoded video. | - 0: High compression video. Quality may suffer when there is a lot of motion <br>- 1: Medium compression<br>- 2: Low compression video with high picture quality | 0 | x | x | x |
| redirectprinters:i:value | Determines whether printers configured on the client computer will be redirected and available in the remote session when you connect to a remote computer by using Remote Desktop Connection. | - 0: The printers on the local computer are not available in the remote session<br>- 1: The printers on the local computer are available in the remote session|1|x|x|x|
| redirectsmartcards:i:value | Determines whether smart card devices on the client computer will be redirected and available in the remote session when you connect to a remote computer. |- 0: The smart card device on the local computer is not available in the remote session<br>- 1: The smart card device on the local computer is available in the remote session|1|x|x||
| remoteapplicationcmdline:s:value | Optional command-line parameters for the RemoteApp.||x|x|x|
| remoteapplicationexpandcmdline:i:value| Determines whether environment variables contained in the RemoteApp command line parameter should be expanded locally or remotely.|- 0: Environment variables should be expanded to the values of the local computer<br>- 1: Environment variables should be expanded on the remote computer to the values of the remote computer||x|x|x|
| remoteapplicationexpandworkingdir | Determines whether environment variables contained in the RemoteApp working directory parameter should be expanded locally or remotely. | - 0: Environment variables should be expanded to the values of the local computer<br> - 1: Environment variables should be expanded on the remote computer to the values of the remote computer.<br>The RemoteApp working directory is specified through the shell working directory parameter.||x|x|x|
|remoteapplicationfile:s:value | Specifies a file to be opened on the remote computer by the RemoteApp.<br>For local files to be opened, you must also enable drive redirection for the source drive.||x|x|x|
|remoteapplicationicon:s:value | Specifies the icon file to be displayed in the client UI while launching a RemoteApp. If no file name is specified, the client will use the standard Remote Desktop icon. Only ".ico" files are supported.||x|x|x|
|remoteapplicationmode:i:value | Determines whether a RemoteApp connection is launched as a RemoteApp session.| - 0: Don't launch a RemoteApp session<br>- 1: Launch a RemoteApp session|1|x|x|x|
|remoteapplicationname:s:value | Specifies the name of the RemoteApp in the client interface while starting the RemoteApp.| For example, "Excel 2016."|x|x|x|
|remoteapplicationprogram:s:value | Specifies the alias or executable name of the RemoteApp. | For example, "EXCEL." |x|x|x|
|screen mode id:i:value | Determines whether the remote session window appears full screen when you connect to the remote computer by using Remote Desktop Connection. |- 1: The remote session will appear in a window<br>- 2: The remote session will appear full screen|2|x|x|x|
|smart sizing:i:value | Determines whether or not the client computer can scale the content on the remote computer to fit the window size of the client computer.|- 0: The client window display won't scale when resized<br>- 1: The client window display will scale when resized|0|x|x||
| use multimon:i:value | Configures multiple monitor support when you connect to the remote computer by using Remote Desktop Connection.|- 0: Don't enable multiple monitor support<br>- 1: Enable multiple monitor support|0|x|x||
| username:s:value | Specifies the name of the user account that will be used to log on to the remote computer. | Any valid username. ||x|x|x|
| videoplaybackmode:i:value| Determines if Remote Desktop Connection will use RDP-efficient multimedia streaming for video playback.|- 0: Don't use RDP efficient multimedia streaming for video playback<br>- 1: Use RDP-efficient multimedia streaming for video playback when possible|1|x|x||
| workspaceid:s:value | Defines the RemoteApp and Desktop ID associated with the RDP file that contains this setting. | A valid RemoteApp and Desktop Connection ID|x|x||
