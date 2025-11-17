---
title: Install Remote Desktop Services client access licenses
description: Learn how to install Remote Desktop Services client access licenses (CALs), ready to license your session hosts.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 05/29/2025
---

# Install Remote Desktop Services client access licenses

Remote Desktop Services (RDS) client access licenses (CALs) are required for users to connect to your Remote Desktop environment and in compliance with licensing requirements. This article provides instructions for installing RDS CALs on your license server. Once the CALs are installed and you configure your RDS deployment to use the license server, licenses are issued to users as appropriate.

## Prerequisites

Before you begin, ensure you meet the following prerequisites:

- A Remote Desktop license server installed and activated. For activation instructions, see [Activate the Remote Desktop Services license server](./rds-activate-license-server.md).

- Internet connectivity on a computer running Remote Desktop Licensing Manager to activate the licenses. The license server itself doesn't require internet connectivity.

- A user account that's an administrator on the Remote Desktop license server to install licenses.

- The license code or agreement number provided when you purchased your Remote Desktop Services CALs.

## Install the client access licenses

1. Open the Remote Desktop Licensing Manager.

1. Right-click the name of the license server, then select **Install licenses**.

1. On the welcome page, select **Next** .

1. Select the program you purchased your RDS CALs from, then select **Next**. If you're a service provider, select **Service Provider License Agreement**.

1. Enter the information for your license program. In most cases, you need to enter the license code or an agreement number, but it can vary depending on the license program you're using.

1. Select **Next**.

1. Select the product version, license type, and number of licenses for your environment, then select **Next**. The license manager contacts the Microsoft Clearinghouse to validate and retrieve your licenses.

1. Select **Finish** to complete the process.

## Next step

After you install the RDS CALs, you need to configure your RDS deployment to use the license server. For more information, see [License Remote Desktop session hosts](rds-license-session-hosts.md).
