---
title: Activate the Remote Desktop Services license server
description: Install and activate the RD license server
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 02/14/2025
---
# Activate the Remote Desktop Services license server

The Remote Desktop Services license server issues client access licenses (CALs) to users and devices when they access the RD Session Host. You can activate the license server by using the Remote Desktop Licensing Manager.

## Prerequisites

Before you can activate your Remote Desktop Services license server, ensure that you have:

- A Windows Server with the Remote Desktop Services licensing role service installed, including the Remote Desktop Licensing Tools feature.

- Administrative privileges on the server.

- A basic understanding of Remote Desktop licensing.

- You need to have you company information ready to enter during the activation process.

## Install the Remote Desktop Licensing role

1. Sign into the server you want to use as the license server using an administrator account.

1. In Server Manager, select **Manage** > **Add Roles and Features**.

1. On the **Select installation type** page, select **Role-based or feature-based installation**.

1. Specify the server on which you install the licensing role.

1. On the **Server Roles** page, check the box for **Remote Desktop Services**, then select **Next** until you see the **Remote Desktop Services** page.

1. Select the roles you want to install. Make sure you include the **Remote Desktop Licensing** role.

1. In the **Add Roles and Features Wizard** dialog box, select **Add Features**.

1. Select **Next** until you see the **Confirmation** page, then select **Install**.

For detailed information and other installation options, see [Install or uninstall roles, role services, or features](../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md)

## Activate the license server

1. In Server Manager, select **Tools** > **Remote Desktop Services** > **Remote Desktop Licensing Manager**.

1. In the **RD Licensing Manager**, select the server, and then select **Action** > **Activate Server**.

1. Confirm your preferred Connection method for license server activation and select **Next**. The three options available are:
    - **Automatic connection (recommended)**: This recommended method communicates via internet directly to the Microsoft Clearinghouse outbound over TCP port 443.

    - **Web Browser**: This method requires the administrator to connect to the Microsoft Clearinghouse web site. Use this method if the license server doesn't have internet access, but you have internet access through another computer.

    - **Telephone**: This method allows the administrator to complete the migration process over the phone with a Microsoft Clearinghouse operator. Use this method if you don't have internet access.

### Activate with automatic connection

1. Enter your required **Company information** including First name, Family name, Company, and Country or Region. Select **Next**.

1. Then enter your optional company information. Select **Next** until you complete the Activate Server Wizard.

1. Accept the defaults for the remaining pages until the final page. Clear **Start Install Licenses Wizard now**, and then select **Finish**.

1. Select **Action** > **Install Licenses**. Enter your license code ready to enter when prompted.

### Activate using a web browser

1. On the **License Server Activation** page, copy the URL for the Remote Desktop Licensing Web Site. Then open a web browser and navigate to the site.

1. Complete the steps on the Remote Desktop Licensing Web Site.

1. Return to the **License Server Activation** page and enter in the **license server ID**. Select **Next**.

### Activate by telephone

1. Select your Country or Region. Then select **Next**.

1. On the **License Server Activation** page, call Microsoft at the number displayed. The representative provides you with a license server ID to enter. Select **Next**.
