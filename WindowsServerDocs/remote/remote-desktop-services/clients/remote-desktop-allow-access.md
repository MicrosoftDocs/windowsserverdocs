---
title: Remote Desktop - Allow access to your PC
description: Learn about your options for remotely accessing your PC
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f1557ed-53f7-4333-b023-c8e0f4b58bf4
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 06/05/2018
ms.localizationpriority: medium
---
# Remote Desktop - Allow access to your PC

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

You can use Remote Desktop to connect to and control your PC from a remote device by using a [Microsoft Remote Desktop client](remote-desktop-clients.md) (available for Windows, iOS, macOS and Android). When you allow remote connections to your PC, you can use another device to connect to your PC and have access to all of your apps, files, and network resources as if you were sitting at your desk.  

> [!NOTE]
> You can use Remote Desktop to connect to Windows 10 Pro and Enteprise, Windows 8.1 and 8 Enterprise and Pro, Windows 7 Professional, Enterprise, and Ultimate, and Windows Server versions newer than Windows Server 2008. You can't connect to computers running the Home edition (like Windows 10 Home). 

To connect to a remote PC, that computer must be turned on, it must have a network connection, Remote Desktop must be enabled, you must have network access to the remote computer (this could be through the Internet), and you must have permission to connect. For permission to connect, you must be on the list of users. Before you start a connection, it's a good idea to look up the name of the computer you're connecting to and to make sure Remote Desktop connections are allowed through its firewall.

## How to enable Remote Desktop

The simplest way to allow access to your PC from a remote device is using the Remote Desktop options under Settings. Since this functionality was added in the Windows 10 Fall Creators update (1709), a separate downloadable app is also available that provides similar functionality for earlier versions of Windows. You can also use the legacy way of enabling Remote Desktop, however this method provides less functionality and validation.

### Windows 10 Fall Creator Update (1709) or later

You can configure your PC for remote access with a few easy steps.
1. On the device you want to connect to, select **Start**  and the click the **Settings** icon on the left.
2. Select the **System** group followed by the [**Remote Desktop**](ms-settings:remotedesktop) item.
3. Use the slider to enable Remote Desktop.
4. It is also recommended to keep the PC awake and discoverable to facilitate connections. Click **Show settings** to enable.
5. As needed, add users who can connect remotely by clicking **Select users that can remotely access this PC**.
   1. Members of the Administrators group automatically have access.
6. Make note of the name of this PC under **How to connect to this PC**. You'll need this to configure the clients.

### Windows 7 and early version of Windows 10

To configure your PC for remote access, download and run the [Microsoft Remote Desktop Assistant](https://www.microsoft.com/download/details.aspx?id=50042). This assistant updates your system settings to enable remote access, ensures your computer is awake for connections, and checks that your firewall allows Remote Desktop connections. 

### All versions of Windows (Legacy method)

To enable Remote Desktop using the legacy system properties, follow the instructions to [Connect to another computer using Remote Desktop Connection](https://windows.microsoft.com/windows/remote-desktop-connection-faq).

## Should I enable Remote Desktop?

If you only want to access your PC when you are physically sitting in front of it, you don't need to enable Remote Desktop. Enabling Remote Desktop opens a port on your PC that is visible to your local network. You should only enable Remote Desktop in trusted networks, such as your home. You also don't want to enable Remote Desktop on any PC where access is tightly controlled.

Be aware that when you enable access to Remote Desktop, you are granting anyone in the Administrators group, as well as any additional users you select, the ability to remotely access their accounts on the computer.

You should ensure that every account that has access to your PC is configured with a strong password.

## Why allow connections only with Network Level Authentication? 

If you want to restrict who can access your PC, choose to allow access only with Network Level Authentication (NLA). When you enable this option, users have to authenticate themselves to the network before they can connect to your PC. Allowing connections only from computers running Remote Desktop with NLA is a more secure authentication method that can help protect your computer from malicious users and software. To learn more about NLA and Remote Desktop, check out [Configure NLA for RDS Connections](https://technet.microsoft.com/library/cc732713(v=ws.11).aspx).

If you're remotely connecting to a PC on your home network from outside of that network, don't select this option.
