---
title: Get started with the web client for Remote Desktop Services
description: Describes how to sign in to the Remote Desktop web client.
ms.author: helohr
ms.date: 12/16/2022
ms.topic: article
author: Heidilohr
---
# Get started with the web client

The Remote Desktop web client lets you use a compatible web browser to access your organization's remote resources (apps and desktops) published to you by your admin. You'll be able to interact with the remote apps and desktops like you would with a local PC no matter where you are, without having to switch to a different desktop PC. Once your admin sets up your remote resources, all you need are your domain, user name, password, the URL your admin sent you, and a supported web browser, and you're good to go.

> [!TIP]
> If you want to connect to Azure Virtual Desktop instead of Remote Desktop Services, see [Connect to Azure Virtual Desktop with the Remote Desktop Web client](/azure/virtual-desktop/users/connect-web).

## What you'll need to use the web client

* For the web client, you'll need a PC running Windows, macOS, ChromeOS, or Linux. Mobile devices aren't supported at this time.
* A modern browser like Microsoft Edge, Google Chrome, Apple Safari, or Mozilla Firefox (v55.0 and later).
* The URL your admin sent you.

## Start using the Remote Desktop client

To sign in to the client, go to the URL your admin sent you. At the sign-in page, enter your domain and user name in the format ```DOMAIN\username```, enter your password, and then select **Sign in**.

>[!NOTE]
>By signing in to the web client, you agree that your PC complies with your organization's security policy.

After you sign in, the client will take you to the **All Resources** tab, which contains all items published to you under one or more collapsible groups, such as the "Work Resources" group. You'll see several icons representing the apps, desktops, or folders containing more apps or desktops that the admin has made available to the work group. You can come back to this tab at any time to launch additional resources.

To start using an app or desktop, select the item you want to use, enter the same user name and password you used to sign in to the web client if prompted, and then select **Submit**. You might also be shown a consent dialog to access local resources, like clipboard and printer. You can choose to not redirect either of these, or select **Allow** to use the default settings. Wait for the web client to establish the connection, and then start using the resource as you would normally.

When you're finished, you can end your session by either selecting the **Sign Out** button in the toolbar at the top of your screen or closing the browser window.

## Web client keyboard shortcuts

The following table describes alternate key combinations to inject standard Windows shortcut keys in the remote session.

|Shortcut key |Description |
|-------------|------------|
|(Windows) Ctrl+Alt+End</br>(MacOS) fn+control+option+delete|Inject Ctrl+Alt+Del in the remote session.|
|Alt+F3       |Injects Windows key in the remote session.|
|Alt+Page up|Switches between programs from left to right in the remote session. (Windows shortcut is Alt+Tab.)|
|Alt+Page down|Switches between programs from right to left in the remote session. (Windows shortcut is Alt+Shift+Tab.) |

## Printing from the Remote Desktop web client

Follow these steps to print from the web client:

1. Start the printing process as you would normally for the app you want to print from.
2. When prompted to choose a printer, select **Remote Desktop Virtual Printer**.
3. After choosing your preferences, select **Print**.
4. Your browser will generate a PDF file of your print job.
5. You can choose to either open the PDF and print its contents to your local printer or save it to your PC for later use.

## Transfer files with the web client

To learn how to enable web client file transfer, check out [Configure device redirections](/azure/virtual-desktop/configure-device-redirections#local-drive-redirection).

Follow these steps to transfer files from your local computer to the remote session:

1. Connect to the remote session.
2. Select the file upload icon in the web client menu.
3. When prompted, select the files you want to upload using the local file explorer.
4. Open the file explorer in your remote session. Your files will be uploaded to **Remote Desktop Virtual Drive** > **Uploads**.

To download files from the remote session to your local computer:

1. Connect to the remote session.
2. Open the file explorer in your remote session.
3. Copy the file or files you want to download to **Remote Desktop Virtual Drive** > **Downloads**. There is a file size limit of 255MB.
4. A prompt will ask if you want to download the file or files you selected. At this point, you can confirm the download by selecting **Confirm** or cancel it by selecting **Cancel**. If you don't want to see this prompt every time you download files from the current browser, select the check box labeled **Don’t ask me again on this browser** before confirming.
5. Your files will be downloaded to your local default downloads folder.

## Copy and paste from the Remote Desktop web client

The web client currently supports copying and pasting text only. Files can't be copied or pasted to and from the web client. Additionally, you can only use **Ctrl+C** and **Ctrl+V** to copy and paste text.

## Keyboard settings in the remote session 

The web client supports using an Input Method Editor (IME) in the remote session in version 1.0.21.16 or later. Before you can use the IME, you must install the language pack for the keyboard you want to use in the remote session on the host virtual machine. To learn more about setting up language packs in the remote session, see [Add language packs to a Windows 10 multi-session image](/azure/virtual-desktop/language-packs).

To select alternative keyboard layout or language:

1. Before you connect to the remote session, go to the web client **Settings** panel.
2. In **Select Remote Keyboard Layout** section, expand the drop-down menu and select the keyboard you want to use in the remote session. 
   Azure Virtual Desktop web client settings options:
    * Auto: This configuration will send KeyCodes on key press, which means the local key is directly sent to the remote machine. For this option, the local machine keyboard layout is important and should match the layout on all the hops taken to the remote machine.
    * Remote: This configuration will send Scan Codes to the remote machine. For this option, the local machine keyboard layout is not as important, but the keyboard layout on all other hops taken to the remote machine should match the selected layout.
    * Language specific: If you select a specific language and the language pack is installed on the remote machine, that language will automatically be selected on new Windows sessions only. For example, if you use English UK, you can select it from the drop down. Make sure to sign out of ALL the Windows user sessions you're trying to connect to. When opening a new session, all the hops should automatically default to using the English UK layout.

      Note: There's a known issue when using KeyCodes for PowerShell. By selecting a mode on AVD Web Client that uses scancode (either Remote or English UK for example), PowerShell should work as expected.
4. If you are using either an IME-based keyboard or a keyboard with alternate layout, select either **Remote** OR pick any of the languages from the list. 
5. Connect to the remote session.

The web client will suppress the local IME window when you're focused on the remote session. If you change the IME settings after you've already connected to the remote session, the setting changes won't have any effect. The web client doesn't support IME input while using a private browsing window. Additionally, IMEs do not work with the Auto setting.



>[!NOTE]
>If the language pack isn't installed on the host virtual machine, the remote session will default to the English (United States) keyboard.

## Enable native display resolution in remote sessions

The web client supports using native display resolution during remote sessions. In sessions running on a high-DPI display, native resolution can provide higher-fidelity graphics and improved text clarity.

>[!NOTE]
>Enabling native display resolution with a high-DPI display may cause increased CPU or network usage.

Native resolution is set to off by default. To turn native resolution on:

1. In your session, go to the upper-right corner of the taskbar and select **Settings**.
2. Set **Enable native display resolution** to **On**.

## Open resources in your installed Azure Virtual Desktop client

The web client supports opening resources in your installed Azure Virtual Desktop client instead of the browser by downloading the Remote Desktop Protocol (RDP) file. To learn how to install a Remote Desktop client, check out [Remote Desktop clients](remote-desktop-clients.md).

>[!NOTE]
>RDP files have a limited lifespan. We recommend you download the RDP file every time you need to use a resource

To download the RDP file:

1. In the web client, go to the upper-right corner of the taskbar and select **the settings (gear) icon**.
2. Under **Resource Launch method**, select **Download the RDP file**.
3. Select the resource you want to open (for example, Excel) to download the RDP file.
4. Once the download is finished, select the downloaded RDP file to open the resource.

## Get help with the web client

If you've encountered an issue that can't be solved by the information in this article, you can get help with the web client by raising feedback on the web client's Feedback page.
