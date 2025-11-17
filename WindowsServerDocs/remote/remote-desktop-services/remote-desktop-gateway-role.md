---
title: Deploy Remote Desktop Gateway role for Remote Desktop Services
description: Learn how to deploy the Remote Desktop Gateway role for Remote Desktop Services.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 06/24/2025
---

# Deploy the Remote Desktop Gateway role

The Remote Desktop Gateway (RD Gateway) role enables secure, encrypted connections to Remote Desktop Services (RDS) resources over the internet. With RD Gateway, users can access internal network resources from remote locations without the need for a VPN. You can deploy RD Gateway servers on either physical or virtual machines, supporting on-premises, cloud, or hybrid environments. This article guides you through installing and configuring the RD Gateway role to enhance the security and accessibility of your Remote Desktop environment.

## Prerequisites

Your device must have the **Remote Desktop Services** role installed. To learn more, see [Add or remove roles and features in Windows Server](/windows-server/administration/server-manager/add-remove-roles-features).

- During the installation process, select the **Remote Desktop Gateway** Role service, and proceed with installation.

> [!NOTE]
> For this article, we're using default settings for installing the RD Gateway, progressing through without additional changes. Based on your own organizational needs, during the Role service selection for the Web Server Role (IIS), select the additional services necessary for your environment.

You must be a part of the **Administrators** group or have equivalent permissions.

## Configure the RD Gateway role

Once the RD Gateway role is installed, it needs to be configured. To configure the RD Gateway role, follow these steps:

1. In **Server Manager**, select **Remote Desktop Services**, then select **Servers**

1. Right-click the name of your server, then select **RD Gateway Manager**.

1. In the **RD Gateway Manager** on the left pane, right-click the name of your gateway, then select **Properties**.

1. Select the **SSL Certificate** tab, select the **Import a certificate into the RD Gateway** radio button, then select **Browse and Import Certificate**.

1. Locate and select your PFX file, then select **Open**.

1. Enter the password for the PFX file when prompted.

After you've imported the certificate and its private key, the display should show the certificate’s key attributes.

> [!NOTE]
> Because the RD Gateway role is supposed to be public, we recommend you use a publicly issued certificate. If you use a privately issued certificate, you'll need to make sure to configure all clients with the certificate's trust chain beforehand.

## Next steps

If you want to add high availability to your RD Gateway role, see [Add high availability to the RD Web and Gateway web front](rds-rdweb-gateway-ha.md).

