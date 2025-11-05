---
title: Enable Remote Desktop on your PC
description: Learn how to use Remote Desktop to connect to and control your PC from a remote device.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 06/18/2025
---

# Enable Remote Desktop on your PC

You can use Remote Desktop to connect to and control your PC from a remote device by using Windows App or the Microsoft Remote Desktop client. When you allow remote connections to your PC, you can use another device to connect to your PC and have access to all of your apps, files, and network resources as if you were sitting at your desk. If you only need to use your PC locally, there's no need to enable Remote Desktop. Enabling Remote Desktop opens a port on your PC, making it accessible to devices on your local network. Only enable Remote Desktop on trusted networks, such as your home network, and avoid enabling it on devices that require strict access controls. When Remote Desktop is enabled, members of the Administrators group and any users you specify can connect remotely. Make sure all accounts with remote access have strong, unique passwords to help protect your PC.

> [!NOTE]
> You can use Remote Desktop to connect to computers running Windows Professional, Enterprise, Education editions, and Windows Server editions. These editions can act as hosts for incoming Remote Desktop connections. However, Windows Home editions can't serve as Remote Desktop hosts, though they can be used as clients to connect to other systems that support Remote Desktop hosting.

If you need to connect to your PC from outside of the network your PC is running on, you can use port forwarding or set up a VPN. To learn more, see [Allow access to your PC from outside your PC's network](remote-desktop-allow-outside-access.md).

## Prerequisites

You must be a member of the **Administrators** group or have administrative privileges to change this system setting.

To connect to a remote PC, ensure the following requirements are met:

- The remote PC is powered on and connected to the network.
- Remote Desktop is enabled on the remote PC.
- You have network access to the remote PC (locally or via the Internet).
- Your user account is permitted to connect (the account is in the list of allowed users).
- Remote Desktop connections are allowed through the remote PC’s firewall.

## Enable Remote Desktop

You can configure your PC for remote access with a few easy steps.

1. Select **Start**, select **Settings**, then select **System**.
1. Select **Remote Desktop**, toggle the option **Enable Remote Desktop** to **On**.
1. Select **Confirm** on the pop-up dialog box to enable Remote Desktop.

By default, the **Make my PC discoverable on private networks to enable automatic connection from a remote device** checkbox is checked.

You can also configure other user accounts to have remote access to your device by following these steps:

1. While in the Remote Desktop settings, select **Select users that can remotely access this PC**.

   In later releases of Windows and Windows Server, select **Remote Desktop users**.

1. Select **Add**, type the username, then select **OK**. More than one account can be added at a time.

## Remote connect to a device

To open the **Remote Desktop Connection** app, follow these steps:

1. On your local PC, select **Start**, type **Remote Desktop Connection** and open the app.
1. In the **Remote Desktop Connection** window, enter the computer name or IP address of the remote PC you want to connect to.
1. Select **Connect**, provide the credentials, then select **OK**.

You can also connect to a device using the Windows App. To learn more, see [Get started with Windows App to connect to devices and apps](/windows-app/get-started-connect-devices-desktops-apps).

## Why allow connections only with Network Level Authentication?

Network Level Authentication (NLA) adds an extra layer of security to Remote Desktop connections. With NLA enabled, users must authenticate themselves before a remote session is established, reducing the risk of unauthorized access and helping to protect your PC from malicious users and software. Enabling NLA is recommended for most environments, as it ensures only trusted users and devices can connect. However, if you need to connect from older devices or clients that don't support NLA, you might need to disable this option temporarily. For best security, keep NLA enabled whenever possible.

To learn more, see [Configure NLA for RDS Connections](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732713(v=ws.11)).

## See also

- [Remote Desktop Services overview in Windows Server](/windows-server/remote/remote-desktop-services/remote-desktop-services-overview)

- [Troubleshoot Remote Desktop connections to an Azure virtual machine](/troubleshoot/azure/virtual-machines/windows/troubleshoot-rdp-connection)

- [Troubleshoot authentication errors when you use RDP to connect to Azure VM](/troubleshoot/azure/virtual-machines/windows/cannot-connect-rdp-azure-vm)

