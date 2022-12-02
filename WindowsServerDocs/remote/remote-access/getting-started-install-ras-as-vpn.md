---
title: How to install and configure Remote Access (RAS) as a VPN server
description: How to install and configure Remote Access (RAS) as a VPN server in Microsoft Windows Server
ms.topic: article
ms.author: anaharris
author: anaharris-ms
ms.date: 12/02/2022
---


# Install Remote Access as a VPN server

In this getting started guide, we'll show you how to install and configure Remote Access (RAS) as a VPN server.

## Install the Remote Access role

# [PowerShell](#tab/powershell)

**To install Remote Access role by using Windows PowerShell:**

1. Open Windows PowerShell as **Administrator**.

2. Enter and run the following cmdlet:

   ```powershell
   Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools
   ```

   After installation completes, the following message appears in Windows PowerShell.

   ```powershell
   | Success | Restart Needed | Exit Code |               Feature Result               |
   |---------|----------------|-----------|--------------------------------------------|
   |  True   |       No       |  Success  | RAS Connection Manager Administration Kit |
   ```

# [Server Manager](#tab/servermgr)

**To install Remote Access role by using Server Manager:**

1. On the Windows server, in Server Manager, select **Manage** and select **Add Roles and Features**.

   The Add Roles and Features Wizard opens.

2. On the Before you begin page, select **Next**.

3. On the Select Installation Type page, select the **Role-Based or feature-based installation** option and select **Next**.

4. On the Select destination server page, select the **Select a server from the server pool** option.

5. Under Server Pool, select the local computer and select **Next**.

6. On the Select server roles page, in **Roles**, select **Remote Access**, then **Next**.

7. On the Select features page, select **Next**.

8. On the Remote Access page, select **Next**.

9. On the Select role service page, in **Role services**, select **DirectAccess and VPN (RAS)**.

10. On the Confirm installation selections page, review your choices, then select **Install**.

11. When the installation is complete, select **Close**.

---

## Configure Remote Access as a VPN Server

In this section, we'll configure Remote Access to allow IKEv2 VPN connections and to deny connections from other VPN protocols. We'll also assign a static IP address pool for the issuance of IP addresses to connecting authorized VPN clients.

1. On the VPN server, in Server Manager, select the **Notifications** flag.

1. In the **Tasks** menu, select **Open the Getting Started Wizard**

   The Configure Remote Access wizard opens.

   >[!NOTE]
   >The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it. If not, wait for the wizard to initialize.

1. Select **Deploy VPN only**.

    The Routing and Remote Access Microsoft Management Console (MMC) opens.

1. Right-click the VPN server, then select **Configure and Enable Routing and Remote Access**.

   The Routing and Remote Access Server Setup Wizard opens.

1. In the Welcome to the Routing and Remote Access Server Setup Wizard, select **Next**.

1. In **Configuration**, select **Custom Configuration**, and then select **Next**.

1. In **Custom Configuration**, select **VPN access**, and then select **Next**.

   The Completing the Routing and Remote Access Server Setup Wizard opens.

1. Select **Finish** to close the wizard, then select **OK** to close the Routing and Remote Access dialog box.

1. Select **Start service** to start Remote Access.

1. In the Remote Access snap-in, right-click the VPN server, then select **Properties**.

1. In Properties, select the **Security** tab and do:

    a. Select **Authentication provider** and select **RADIUS Authentication**.

    b. Select **Configure** to open the RADIUS Authentication dialog box.

    c. Select **Add** to open the Add RADIUS Server dialog box.

    d. In **Server name**, enter the Fully Qualified Domain Name (FQDN) of the NPS server on your Organization/Corporate network. For example, if the NetBIOS name of your NPS server is NPS1 and your domain name is corp.contoso.com, enter **NPS1.corp.contoso.com**.

    e. In **Shared secret**, select **Change** to open the Change Secret dialog box.

    f. In **New secret**, enter a text string.

    g. In **Confirm new secret**, enter the same text string, then select **OK**.

    >[!IMPORTANT]
    >Save this text string. If you plan on you configuring the NPS Server on your Organization/Corporate network, you'll add this VPN Server as a RADIUS Client. During that configuration, you will use this same shared secret so that the NPS and VPN Servers can communicate.

1. In **Add RADIUS Server**, review the default settings for:

    - **Time-out**

    - **Initial score**

    - **Port**

1. If necessary, change the values to match the requirements for your environment and select **OK**.

1. Select **OK** to close the Radius Authentication dialog.

1. On the VPN server properties dialog, review the setting for **Accounting provider**:

    |If you want the... | Then…  |
    |-----------------------------------------------------------|--|
    | Remote Access activity logged on the Remote Access server |Make sure that **Windows Accounting** is selected.|
    | NPS to perform accounting services for VPN | Change **Accounting provider** to **RADIUS Accounting** and then configure the NPS as the accounting provider. |

1. Select the **IPv4** tab and do:

    1. Select **Static address pool**.

    2. Select **Add** to configure an IP address pool.

       The static address pool should contain addresses from the internal perimeter network. These addresses are on the internal-facing network connection on the VPN server, not the corporate network.

    3. In **Start IP address**, enter the starting IP address in the range you want to assign to VPN clients.

    4. In **End IP address**, enter the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, enter the number of the address you want to make available.

    5. Select **OK** to close the Properties dialog.

1. In the Routing and Remote Access MMC, right-click **Ports,** and then select **Properties**.

    The Ports Properties dialog box opens.

1. Select **WAN Miniport (SSTP)** and select **Configure** to open the Configure Device - WAN Miniport (SSTP) dialog box.

    1. Ensure that the **Remote access connections (inbound only)** and  **Demand-dial routing connections (inbound and outbound)** are selected.

    2. Select **OK**.

1. Select **WAN Miniport (L2TP)** and select **Configure** to open the Configure Device -  - WAN Miniport (L2TP) dialog box.

    1. Clear both  **Remote access connections (inbound only)**  and **Demand-dial routing connections (inbound and outbound)**.

    2. Select **OK**.

1. Select **WAN Miniport (PPTP)** and select **Configure** to open the Configure Device -  - WAN Miniport (PPTP) dialog box.

    1. Clear both  **Remote access connections (inbound only)**  and **Demand-dial routing connections (inbound and outbound)**.

    2. Select **OK**.

1. Select **WAN Miniport (IKEv2)** and select **Configure** to open the Configure Device - WAN Miniport (IKEv2) dialog box.

    1. Ensure that the **Remote access connections (inbound only)** and  **Demand-dial routing connections (inbound and outbound)** are selected.

    2. In **Maximum ports**, enter the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

1. If prompted, select **Yes** to confirm restarting the server and select **Close** to restart the server.

 Next steps

- [Tutorial: Deploy Always On VPN](tutorial-aovpn-deploy-setup.md)

