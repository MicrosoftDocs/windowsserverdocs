---
title: Configure VPN protocols in Routing and Remote Access on Windows Server
description: Learn how to configure VPN protocols in Routing and Remote Access on Windows Server using 
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 06/07/2024
#customer intent: As a VPN administrator, I want to configure VPN protocols in Windows Server so that I can restrict which protocol can be used for VPN connections.
---

# Configure VPN protocols

In this guide, learn how to enable and disable specific VPN protocols in Routing and Remote Access on Windows Server. You can use Routing and Remote Access to accept VPN connections based on protocols such as PPTP, L2TP, SSTP, and IKEv2. This article shows you how to configure Routing and Remote Access to enable L2TP and PPTP based VPN connections using the Routing and Remote Access Microsoft Management Console (MMC) and using the `netsh` command in Windows.

## Prerequisites

Before you can configure the Routing and Remote Access protocols, you need the following prerequisites.

- Windows Server with the DirectAccess and VPN (RAS) role service installed and configured. To learn how to configure the Routing and Remote Access Service, see [Install Remote Access as a VPN server](get-started-install-ras-as-vpn.md).

- Membership to the Administrators group, or equivalent. If the RAS server is domain joined, an account with administrative privileged to the server is required.

## Enable VPN protocols

Routing and Remote Access Services (RRAS) supports remote user or site-to-site connectivity by using virtual private network (VPN) or dial-up connections. It accepts VPN connections based on protocols such as PPTP, L2TP, SSTP, and IKEv2. These protocols are all enabled by default when the RRAS role is installed and setup with default configuration. By default an authorized client can establish a VPN connection based using any of the enabled protocols. Beginning with Windows Server 2025, new RRAS setups don't accept VPN connections based on PPTP and L2TP protocols. You can still enable these protocols if necessary. SSTP and IKEv2 based VPN connections are still accepted without any change.

Existing configurations and Windows Server releases retain their behavior. For example, if you're running Windows Server 2019 and accept PPTP and L2TP connections, when you update to Windows Server 2025 using an in-place update, L2TP and PPTP based connections are still accepted. This change doesn't affect Windows clients operating systems.

>[!NOTE]
>Instead of IKEv2, you can also choose to use SSTP. We don't recommend that you use L2TP or PPTP, due to their lack of security features.

In this section, configure Remote Access to allow L2TP VPN connections. Select the tab that corresponds to the method you want to use to configure VPN protocols.

To enable L2TP VPN connections using the Routing and Remote Access MMC, follow these steps:

1. On the VPN server, in Server Manager, select **Tools** and then select **Routing and Remote Access** to open the Routing and Remote Access Microsoft Management Console (MMC).

1. In the Routing and Remote Access MMC, expand the VPN server node, right-click **Ports,** and then select **Properties** to open the Ports Properties dialog box.

1. Select **WAN Miniport (L2TP)** and select **Configure** to open the **Configure Device - WAN Miniport (L2TP)** dialog box.

    1. Check both  **Remote access connections (inbound only)**.

    1. Enter the maximum number of ports you want to allow for L2TP connections in the **Maximum ports** field. By default, the maximum number of ports is set to 128.

    1. Select **OK** to close the **Configure Device - WAN Miniport (L2TP)** dialog.

    1. Select **No** to restart the Routing and Remote Access service later.

    1. Select **OK** again to close the **Ports Properties** dialog.

1. Optional: Repeat the previous steps for **WAN Miniport (PPTP)** to enable PPTP VPN connections.

1. To apply the changes, restart the Routing and Remote Access service. In the Routing and Remote Access MMC, right-click the VPN server and select **All Tasks** > **Restart** to restart the service.

Your VPN server is now configured to accept L2TP and if selected PPTP VPN connections.

## Related content

- [Install Remote Access as a VPN server](get-started-install-ras-as-vpn.md)

- [Tutorial: Deploy Always On VPN - Set up infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md)
