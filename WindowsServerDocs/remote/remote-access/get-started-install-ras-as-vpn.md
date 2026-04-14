---
title: How to install and configure Remote Access (RAS) as a VPN server
description: How to install and configure Remote Access (RAS) as a VPN server in Windows Server.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 05/06/2025
---

# Install Remote Access as a VPN server

This guide provides instructions on how to set up and configure Remote Access (RAS) as a Virtual Private Network (VPN) server on Windows Server. This process involves installing the necessary roles and features, configuring VPN protocols, and setting up IP address pools for client connections.

## Prerequisites

Membership in **Administrators** or equivalent is the minimum requirement to perform these procedures. However, if the RAS server is domain-joined, then the procedures need to be performed by a domain administrator.

## Install the Remote Access role

# [PowerShell](#tab/powershell)

**To install Remote Access role by using Windows PowerShell:**

1. Open Windows PowerShell as **Administrator**.

1. Enter and run the following cmdlet:

   ```powershell
   Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools
   ```

   After the installation completes, the following message appears in Windows PowerShell:

   ```output
   | Success | Restart Needed | Exit Code |               Feature Result               |
   |---------|----------------|-----------|--------------------------------------------|
   |  True   |       No       |  Success  | RAS Connection Manager Administration Kit |
   ```

# [Server Manager](#tab/servermgr)

**To install Remote Access role by using Server Manager:**

1. On the Windows server, in Server Manager, select **Manage** and select **Add Roles and Features** to open the Add Roles and Features Wizard.

1. On the Before you begin page, select **Next**.

1. On the Select Installation Type page, select **Role-Based or feature-based installation** and select **Next**.

1. On the Select destination server page, select **Select a server from the server pool**.

1. Under Server Pool, select the local computer and select **Next**.

1. On the Select server roles page, in **Roles**, select **Remote Access**, then **Next**.

1. On the Select features page, select **Next**.

1. On the Remote Access page, select **Next**.

1. On the Select role service page, in **Role services**, select **DirectAccess and VPN (RAS)**.

1. On the Confirm installation selections page, review your choices, then select **Install**.

1. When the installation is complete, select **Close**.

---

## Configure Remote Access as a VPN server

In this section, we'll configure Remote Access to allow IKEv2 VPN connections and to deny connections from other VPN protocols. We'll also assign a static IP address pool for the issuance of IP addresses to connecting authorized VPN clients.

Routing and Remote Access Services (RRAS) supports remote user or site-to-site connectivity by using virtual private network (VPN) or dial-up connections. It accepts VPN connections based on protocols such as PPTP, L2TP, SSTP, and IKEv2. These protocols are all enabled by default when the RRAS role is installed and setup with default configuration. By default an authorized client can establish a VPN connection based using any of the enabled protocols. Beginning with Windows Server 2025, new RRAS setups don't accept VPN connections based on PPTP and L2TP protocols. You can still enable these protocols if necessary. SSTP and IKEv2 based VPN connections are still accepted without any change.

Existing configurations and Windows Server releases retain their behavior. For example, if you're running Windows Server 2019 and accept PPTP and L2TP connections, when you update to Windows Server 2025 using an in-place update, L2TP and PPTP based connections are still accepted. This change doesn't affect Windows clients operating systems.

>[!NOTE]
>Instead of IKEv2, you can also choose to use SSTP. We don't recommend that you use PPTP, due to its lack of security features.

1. Make sure that your firewall rules allow UDP ports 500 and 4500 inbound to the external IP address applied to the public interface on the VPN server.

1. On the VPN server, in Server Manager, select the Notifications flag. You might have to wait a minute or two to see the Notifications flag.

1. In the **Tasks** menu, select **Open the Getting Started Wizard** to open the Configure Remote Access wizard.

   >[!NOTE]
   >The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it. If not, wait for the wizard to initialize.

1. Select **Deploy VPN only** to open the **Routing and Remote Access** Microsoft Management Console (MMC).

1. Right-click the VPN server, and then select **Configure and Enable Routing and Remote Access** to open the **Routing and Remote Access Server Setup Wizard**, then select **Next**.

1. In **Configuration**, select **Custom Configuration**, and then select **Next**.

1. In **Custom Configuration**, select **VPN access**, and then select **Next** to open the **Completing the Routing and Remote Access Server Setup Wizard**.

1. Select **Finish** to close the wizard, then select **OK** to close the Routing and Remote Access dialog box.

1. Once the VPN server is running, right-click the VPN server and select **Properties**.

1. Select the **IPv4** tab and perform the following steps:

    1. Select **Static address pool**.

    1. Select **Add** to configure an IP address pool.

    1. In **Start IP address**, enter the starting IP address in the range you want to assign to VPN clients.

    1. In **End IP address**, enter the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, enter the number of the address you want to make available.

1. Select **OK** to close the Properties dialog.

1. In the **Routing and Remote Access** MMC, right-click **Ports,** and then select **Properties** to open the **Ports Properties** dialog box.

1. Select **WAN Miniport (SSTP)** and select **Configure** to open the **Configure Device - WAN Miniport (SSTP)** dialog box.

    1. Clear both  **Remote access connections (inbound only)**  and **Demand-dial routing connections (inbound and outbound)**.

    1. Select **OK**.

1. Select **WAN Miniport (IKEv2)** and select **Configure** to open the **Configure Device - WAN Miniport (IKEv2)** dialog box.

    1. Ensure that the **Remote access connections (inbound only)** and  **Demand-dial routing connections (inbound and outbound)** are selected.

    1. In **Maximum ports**, enter the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

    1. Select **OK**.

1. Select **WAN Miniport (L2TP)** and select **Configure** to open the **Configure Device - WAN Miniport (L2TP)** dialog box.

    1. Clear both  **Remote access connections (inbound only)**  and **Demand-dial routing connections (inbound and outbound)**.

    1. Select **OK**.

1. Select **WAN Miniport (PPTP)** and select **Configure** to open the **Configure Device - WAN Miniport (PPTP)** dialog box.

    1. Clear both  **Remote access connections (inbound only)**  and **Demand-dial routing connections (inbound and outbound)**.

    1. Select **OK**.

## Next steps

- [Tutorial: Deploy Always On VPN](tutorial-aovpn-deploy-setup.md)

