---
title: Use the Remote Desktop Connection app to connect to an Azure virtual machine using single sign-on with Azure Active Directory credentials - Azure Virtual Desktop
description: Learn how to connect to an Azure virtual machine with Azure Active Directory using single sign-on and the Remote Desktop Connection client (MSTSC)
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 08/21/2023
---

# Use the Remote Desktop Connection app to connect to an Azure virtual machine using single sign-on with Azure Active Directory credentials

You can use the Remote Desktop Connection app (MSTSC) in Windows to connect to an Azure virtual machine (VM) using single sign-on with Azure Active Directory (Azure AD) credentials. When you're signed-in to your local device with your Azure AD credentials and you connect to an Azure VM, your credentials pass through and automatically sign you in.

You can sign in over RDP using one of two methods:

1. Passwordless using any of the supported Azure AD credentials (recommended)
1. Password/limited passwordless using Windows Hello for Business deployed using certificate trust model

## Prerequisites

To connect to an Azure VM with Azure AD using single sign-on, you need the following:

- An Azure VM and your local device running one of the following operating systems:

  - Windows 11 with [2022-10 Cumulative Updates for Windows 11 (KB5018418)](https://support.microsoft.com/kb/KB5018418) or later installed.
  - Windows 10, version 20H2 or later with [2022-10 Cumulative Updates for Windows 10 (KB5018410)](https://support.microsoft.com/kb/KB5018410) or later installed.
  - Windows Server 2022 with [2022-10 Cumulative Update for Microsoft server operating system (KB5018421)](https://support.microsoft.com/kb/KB5018421) or later installed.

- Remote Desktop needs to be enabled in your Azure VM. This is enabled by default in Azure. You can follow the steps in [Reset the Remote Desktop Services configuration](/troubleshoot/azure/virtual-machines/reset-rdp#reset-the-remote-desktop-services-configuration) to enable Remote Desktop service in the VM.

- A user account in Azure AD that has been assigned the **Virtual Machine Administrator Login** or **Virtual Machine User Login** role. For more information, see [Steps to assign an Azure role](/azure/role-based-access-control/role-assignments-steps).

- If your organization has configured and is using [Azure AD Conditional Access](/azure/active-directory/conditional-access/overview), your local device must satisfy the Conditional Access requirements to allow connection to the remote computer. Conditional Access policies may be applied to the application **Microsoft Remote Desktop** with ID **a4a365df-50f1-4397-bc59-1a1564b8bb9c** for controlled access.

- TODO: What else?

## Connect to an Azure VM with Azure AD using single sign-on

Here's how to connect to an Azure VM with Azure AD using single sign-on:

1. Launch the Remote Desktop Connection app on your local device from [Windows Search](https://support.microsoft.com/windows/search-for-anything-anywhere-b14cc5bf-c92a-1e73-ea18-2845891e6cc8), or by running `mstsc.exe` from a command prompt.

1. Select **Show Options** to expand the Remote Desktop Connection client, then select the **Advanced** tab.

1. Check the box **Use a web account to sign in to the remote computer**. This option is equivalent to the `enablerdsaadauth` RDP property. For more information, see [Supported RDP properties with Remote Desktop Services](/windows-server/remote/remote-desktop-services/clients/rdp-files).

1. Select the **General** tab and enter the NetBIOS domain name or fully qualified domain name (FQDN) of the Azure VM in the **Computer** field. The name must match the hostname of the Azure VM in Azure AD. You can't use an IP address.

1. Select **Connect**.

1. When prompted for credentials, your user account in Azure AD is automatically selected. Select **OK** to connect.

### Disconnection when the session is locked

The Windows lock screen in the remote session doesn't support Azure AD authentication tokens or passwordless authentication methods like FIDO keys. The lack of support for these authentication methods means that users can't unlock their screens in a remote session. When you try to lock a remote session, either through user action or system policy, the session is instead disconnected and the service sends a message to the user explaining they've been disconnected.

Disconnecting the session also ensures that when the connection is relaunched after a period of inactivity, Azure AD reevaluates the applicable conditional access policies.

## Next steps

- Learn about [how client features compare to each other](remote-desktop-features.md) when connecting to remote PCs.
