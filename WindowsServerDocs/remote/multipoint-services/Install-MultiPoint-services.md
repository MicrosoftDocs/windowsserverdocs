---
title: Install MultiPoint Services
description: Learn how to install and configure MultiPoint Services in Windows Server 2016
ms.topic: article
author: evaseydl
ms.author: evas
ms.date: 04/01/2023
---
# Install MultiPoint Services

Applies to: Windows Server 2016 and later

Follow these instructions to install MultiPoint Services when you're installing a new server.

Finish installing Windows Server 2016 and then sign in as Administrator. Use Server Manager to enable MultiPoint Services. Server Manager opens automatically at start-up. On the Dashboard, select **Add roles and features** to enable MultiPoint Services and follow the instructions in the wizard.

In the section, for the installation type select either:

- Role-based or feature-based installation, or
- Remote Desktop Services installation

For standard MultiPoint Services deployments, select the Remote Desktop Services installation. The Remote Desktop Services role allows you to conveniently select the MultiPoint Services role under Deployment type. For the role-based installation, select **MultiPoint Services** from the list of roles. The server will restart after successful installation.

## Configure your primary station

1. On the **Create a MultiPoint Server Station** page, type the specified letter from the keyboard for that monitor. The correct key entry associates the keyboard and mouse for that station.
1. Sign in as Administrator.
