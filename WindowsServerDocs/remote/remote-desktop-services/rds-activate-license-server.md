---
title: Activate the Remote Desktop Services license server
description: Install and activate the RD license server
ms.topic: article
ms.assetid: eb24ddd2-0361-41fe-bd6b-c7c63427cb71
author: lizap
ms.author: elizapo
ms.date: 09/09/2023
manager: dongill
---
# Activate the Remote Desktop Services license server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

The Remote Desktop Services license server issues client access licenses (CALs) to users and devices when they access the RD Session Host. You can activate the license server by using the Remote Desktop Licensing Manager.

## Install the RD licensing role

1. Sign into the server you want to use as the license server using an administrator account.
1. In Server Manager, select **Manage** > **Add Roles and Features**.
1. On the **Select installation type** page, select **Role-based or feature-based installation**.
1. Specify the server on which you'll install the licensing role.
1. On the **Server Roles** page, check the box for **Remote Desktop Services**, then select **Next** until you see the **Remote Desktop Services** page.
1. Select the roles you want to install. Make sure you include the **Remote Desktop Licensing** role.
1. In the **Add Roles and Features Wizard** dialog box, select **Add Features**.
1. Select **Next** until you see the **Confirmation** page, then select **Install**.

For detailed information and other installation options, see [Install or uninstall roles, role services, or features](../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md)

## Activate the license server

1. In Server Manager, select **Remote Desktop Services** > **Servers**. Right-click the server where you installed the Remote Desktop Licensing role and select **RD Licensing Manager**.
1. In the **RD Licensing Manager**, select the server, and then select **Action** > **Activate Server**.
1. Accept the remaining default values in the Activate Server Wizard until you see the **Company information** page, then enter your company information.
1. Accept the defaults for the remaining pages until the final page. Clear **Start Install Licenses Wizard now**, and then select **Finish**.
1. Select **Action** > **Review Configuration** > **Add to Group** > **OK** and enter credentials for a user in the AAD DC Administrators group, and register as SCP. This step might not work if you are using Azure AD Domain Services, but you can ignore any warnings or errors.
