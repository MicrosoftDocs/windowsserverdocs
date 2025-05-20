---
title: Enable Remote Desktop on your PC
description: Learn how to use Remote Desktop to connect to and control your PC from a remote device.
ms.topic: how-to
ms.assetid: 0f1557ed-53f7-4333-b023-c8e0f4b58bf4
author: xelu86
ms.author: alalve
ms.date: 08/19/2024
---

# Enable Remote Desktop on your PC

You can use Remote Desktop to connect to and control your PC from a remote device by using Windows App or the Microsoft Remote Desktop client. When you allow remote connections to your PC, you can use another device to connect to your PC and have access to all of your apps, files, and network resources as if you were sitting at your desk.

> [!NOTE]
> You can use Remote Desktop to connect to Professional and Enterprise SKUs of Windows. You can't connect to computers running a Home edition, such as Windows 10 Home.

To connect to a remote PC, that computer must be turned on, it must have a network connection, Remote Desktop must be enabled, you must have network access to the remote computer (this could be through the Internet), and you must have permission to connect. For permission to connect, you must be on the list of users. Before you start a connection, it's a good idea to look up the name of the computer you're connecting to and to make sure Remote Desktop connections are allowed through its firewall.

If you need to connect to your PC from outside of the network your PC is running on, you can use port forwarding or set up a VPN. For more information, see [Allow access to your PC from outside your PC's network](remote-desktop-allow-outside-access.md).

## How to enable Remote Desktop

The simplest way to allow access to your PC from a remote device is by using the Remote Desktop options under Settings. Since this functionality was added in the Windows 10 Fall Creators update (1709), a separate downloadable app is also available that provides similar functionality for earlier versions of Windows.

### Windows 11 and Windows 10 Fall Creator Update (1709) or later

You can configure your PC for remote access with a few easy steps.

1. On the device you want to connect to, select **Start**  and then choose the **Settings** icon on the left.
2. Select the **System** group followed by the [**Remote Desktop**](ms-settings:remotedesktop) item.
3. Use the slider to enable Remote Desktop.
4. It's also recommended to keep the PC awake and discoverable to facilitate connections. Select **Show settings** to enable.
5. As needed, add users who can connect remotely by clicking **Select users that can remotely access this PC**. Members of the Administrators group automatically have access.
6. Make note of the name of this PC under **How to connect to this PC**. You'll need this to configure the clients.

## Connect from a client device

To use Remote Desktop to connect to the remote PC you set up, type *Remote Desktop Connection* on your local PC, and then select **Remote Desktop Connection**. Enter the name of the remote PC, then select **Connect**.

On your Mac, iOS, or Android device, open the Remote Desktop app (available for free from the app stores). Add the name of the remote PC, and then wait for the connection to complete.

## Should I enable Remote Desktop?

If you only want to access your PC when you are physically using it, you don't need to enable Remote Desktop. Enabling Remote Desktop opens a port on your PC that is visible to your local network. You should only enable Remote Desktop in trusted networks, such as your home. You also don't want to enable Remote Desktop on any PC where access is tightly controlled.

Be aware that when you enable access to Remote Desktop, you're granting anyone in the Administrators group, as well as any additional users you select, the ability to remotely access their accounts on the computer.

You should ensure that every account that has access to your PC is configured with a strong password.

## Why allow connections only with Network Level Authentication?

If you want to restrict who can access your PC, choose to allow access only with Network Level Authentication (NLA). When you enable this option, users have to authenticate themselves to the network before they can connect to your PC. Allowing connections only from computers running Remote Desktop with NLA is a more secure authentication method that can help protect your computer from malicious users and software. To learn more about NLA and Remote Desktop, check out [Configure NLA for RDS Connections](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732713(v=ws.11)).

If you're remotely connecting to a PC on your home network from outside of that network, don't select this option.
