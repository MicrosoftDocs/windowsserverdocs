---
title: Use the Remote Desktop Connection app to connect to a remote PC using single sign-on with Microsoft Entra authentication
description: Learn how to connect to a remote PC using Microsoft Entra authentication for single sign-on with the Remote Desktop Connection client (MSTSC)
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 10/04/2023
---

# Use the Remote Desktop Connection app to connect to a remote PC using single sign-on with Microsoft Entra authentication

You can use the Remote Desktop Connection app (MSTSC) in Windows to connect to a remote PC using single sign-on with Microsoft Entra authentication. When you're signed-in to your local device with your Microsoft Entra account and you connect to a remote PC, your credentials pass through and automatically sign you in.

## Prerequisites

To connect to a remote PC using single sign-on with Microsoft Entra authentication, you need:

- The remote PC and your local device must be running one of the following operating systems:

  - Windows 11 with [2022-10 Cumulative Updates for Windows 11 (KB5018418)](https://support.microsoft.com/kb/KB5018418) or later installed.
  - Windows 10, version 20H2 or later with [2022-10 Cumulative Updates for Windows 10 (KB5018410)](https://support.microsoft.com/kb/KB5018410) or later installed.
  - Windows Server 2022 with [2022-10 Cumulative Update for Microsoft server operating system (KB5018421)](https://support.microsoft.com/kb/KB5018421) or later installed.

- Remote Desktop needs to be enabled in your remote PC. You can follow the steps in [Enable Remote Desktop on your PC](remote-desktop-allow-access.md) to enable Remote Desktop.

- The remote PC must be Microsoft Entra joined or Microsoft Entra hybrid joined. There's no requirement for the local device to be joined to a domain or Microsoft Entra. As a result, this method allows you to connect to the remote PC from:
   - Microsoft Entra joined or Microsoft Entra Hybrid joined devices.
   - Active Directory domain joined devices.
   - Workgroup devices.

- If you're accessing an Azure VM, ensure the Microsoft Entra account has been assigned the **Virtual Machine Administrator Login** or **Virtual Machine User Login** role. For more information, see [Steps to assign an Azure role](/azure/role-based-access-control/role-assignments-steps).

- If your organization has configured and is using [Microsoft Entra Conditional Access](/azure/active-directory/conditional-access/overview), your local device must satisfy the Conditional Access requirements to allow connection to the remote computer. Conditional Access policies may be applied to the application **Microsoft Remote Desktop** with ID **a4a365df-50f1-4397-bc59-1a1564b8bb9c** to control access to the remote PC when single sign-on is enabled.

   > [!NOTE]
   > We recommend that you [enforce multi-factor authentication Conditional Access](/azure/active-directory/conditional-access/howto-conditional-access-policy-all-users-mfa) and configure a periodic reauthentication policy using [Sign-in frequency control](/azure/active-directory/conditional-access/howto-conditional-access-session-lifetime) for added security.

## Connect to a remote PC using single sign-on with Microsoft Entra authentication

Here's how to connect to a remote PC using single sign-on with Microsoft Entra authentication

1. Launch the Remote Desktop Connection app on your local device from [Windows Search](https://support.microsoft.com/windows/search-for-anything-anywhere-b14cc5bf-c92a-1e73-ea18-2845891e6cc8), or by running `mstsc.exe` from a command prompt.

1. Select **Show Options** to expand the Remote Desktop Connection client, then select the **Advanced** tab.

1. Check the box **Use a web account to sign in to the remote computer**. This option is equivalent to the `enablerdsaadauth` RDP property. For more information, see [Supported RDP properties with Remote Desktop Services](/windows-server/remote/remote-desktop-services/clients/rdp-files).

1. Select the **General** tab and enter the NetBIOS domain name or fully qualified domain name (FQDN) of the remote PC in the **Computer** field. The name must match the hostname of the remote PC in Microsoft Entra ID and be network addressable, resolving to the IP address of the remote PC. You can't use an IP address.

1. Select **Connect**.

1. If prompted for credentials, your user account in Microsoft Entra ID may be automatically selected. If your account is not automatically selected, specify the user name for your account in the format `user@domain.com` (the User Principal Name (UPN)).

1. Select **OK** to connect. You're prompted to allow the remote desktop connection when connecting to a new remote PC. Microsoft Entra ID remembers up to 15 hosts for 30 days before prompting again. If you see this dialogue, select **Yes** to connect.

### Disconnection when the session is locked

The Windows lock screen in the remote session doesn't support Microsoft Entra authentication tokens or passwordless authentication methods like FIDO keys. The lack of support for these authentication methods means that users can't unlock their screens in a remote session. When you try to lock a remote session, either through user action or system policy, the session is instead disconnected and the service sends a message to the user explaining they've been disconnected.

Disconnecting the session also ensures that when the connection is relaunched after a period of inactivity, Microsoft Entra ID reevaluates the applicable conditional access policies.

## Next steps

- Learn about [how client features compare to each other](remote-desktop-features.md) when connecting to remote PCs.
