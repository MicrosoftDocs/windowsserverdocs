---
title: Getting started with the Remote Desktop web client
description: Describes Remote Desktop web client and how to set it up.
ms.prod: remote-desktop-modern-infrastructure
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 2/16/2018
ms.topic: article
author: Heidilohr
---
# Getting started with the Remote Desktop web client

* For the web client, you'll need a client desktop machine running Windows, Mac, or Linux.
* Mobile devices are not supported at this time.
* The client currently supports Edge, IE 11, Google Chrome, and Safari. Firefox support is still in progress.

## Get the RD client and start using it

Follow these steps to get started with Remote Desktop web client:

1. Download the Remote Desktop client.
2. [Set up your PC to accept remote connections](remote-desktop-allow-access.md).
3. Add a Remote Desktop connection or a remote resource. You use a connection to connect directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or virtual desktop published on-premises.
4. Create a widget so you can get to Remote Desktop quickly.

### Add a Remote Desktop connection

To create a Remote Desktop connection:

1. In the Connection Center, select **+**, then select **Desktop**.
2. Enter the following information for the computer you want to connect to:
    * **PC name**—The name of the computer. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, **MyDesktop:3389** or **10.0.0.1:3389**).
    * **User name**—The user name to use to access the remote PC. You can use the following formats: **user_name**, **domain\user_name**, or **user_name@domain.com**. You can also specify whether to prompt for a user name and password.
3. You can also set the following additional options:
    * **Friendly name**—An easy-to-remember name for the PC you are connecting to. You can use any string, but if you do not specify a friendly name, the PC name is displayed.
    * **Gateway**—The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.
    * **Sound**—Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote device, or not at all.
    * **Customize display resolution**—Set a custom resolution for a connection by enabling this setting. When turned off, the resolution which you have defined in the global settings of the app will be applied.
    * **Swap mouse buttons**—Use this option to swap the left mouse button functions for the right mouse button. (This is especially useful if the remote PC is configured for a left-handed user but you use a right-handed mouse.)
    * **Connect to admin session**—Use this option to connect to a console session to administrate a Windows server.
    * **Redirect to local storage**—Mounts your local storage as a remote file system on the remote PC.
4. Select **Save**.

Need to edit these settings? Select the overflow menu (**...**) next to the name of the desktop, then select **edit**.

Want to delete the connection? Again, select the overflow menu (**...**), and then select **remove**.

### Add a remote resource

Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.

To add a remote resource:

1. On the Connection Center screen, select **+**, and then select **Remote Resources Feed**.
2. Enter information for the Remote Resource:
   * **Email or URL**—The URL of the RD Web Access server. You can also enter your corporate email account in this field—this tells the client to search for the RD Web Access Server associated with your email address.
   * **User name**—The user name to use for the RD Web Access server you are connecting to.
   * **Password**—The password to use for the RD Web Access server you are connecting to.
3. Select **Save**.

The remote resources will be displayed in the Connection Center.

To delete remote resources:

1. In the Connection Center, select the overflow menu (**...**) next to the remote resource.
2. Select **Remove**.
3. Confirm the deletion.

