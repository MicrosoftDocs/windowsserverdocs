---
title: Deploy Remote Desktop Gateway role for Remote Desktop Services
description: How to deploy the Remote Desktop Gateway role for Remote Desktop Services.
author: Heidilohr
ms.topic: how-to
ms.date: 7/3/2024
ms.author: helohr
manager: femila
---

# Deploy the Remote Desktop Gateway role

This article will tell you how to use the Remote Desktop Gateway (RD Gateway) role to deploy Remote Desktop Gateway servers in your Remote Desktop environment. You can install the server roles on physical machines or virtual machines depending on whether you are creating an on-premises, cloud-based, or hybrid environment.

## Install the RD Gateway role

1. Sign into the target server with administrative credentials.

2. In **Server Manager**, select **Manage**, then select **Add Roles and Features**. The **Add Roles and Features** installer will open.

3. In **Before You Begin**, select **Next**.

4. In **Select Installation Type**, select **Role-Based or feature-based installation**, then select **Next**.

5. For **Select destination server**, select **Select a server from the server pool**. For **Server Pool**, select the name of your local computer. When you're done, select **Next**.

6. In **Select Server Roles** > **Roles**, select **Remote Desktop Services**. When you're done, select **Next**.

7. In **Remote Desktop Services**, select **Next.**

8. For **Select role services**, select only **Remote Desktop Gateway** When you're prompted to add required features, select **Add Features**. When you're done, select **Next**.

9. For **Network Policy and Access Services**, select **Next**.

10. For **Web Server Role (IIS)**, select **Next**.

11. For **Select role services**, select **Next**.

12. For **Confirm installation selections**, select **Install**. Don't close the installer while the installation process is happening.

## Configure the RD Gateway role

Once the RD Gateway role is installed, you'll need to configure it.

To configure the RD Gateway role:

1. Open the **Server Manager**, then select **Remote Desktop Services**.

2. Go to **Servers**, right-click the name of your server, then select **RD Gateway Manager**.

3. In the RD Gateway Manager, right-click the name of your gateway, then select **Properties**.

4. Open the **SSL Certificate** tab, select the **Import a certificate into the RD Gateway** bubble, then select **Browse and Import Certificate…**.

5. Select the name of your PFX file, then select **Open**.

6. Enter the password for the PFX file when prompted.

7. After you've imported the certificate and its private key, the display should show the certificate’s key attributes.

>[!NOTE]
>Because the RD Gateway role is supposed to be public, we recommend you use a publicly issued certificate. If you use a privately issued certificate, you'll need to make sure to configure all clients with the certificate's trust chain beforehand.

## Next steps

If you want to add high availability to your RD Gateway role, see [Add high availability to the RD Web and Gateway web front](rds-rdweb-gateway-ha.md).
