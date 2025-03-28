---
title: Install RDS client access licenses
description: Learn how to install CALs for RD clients.
ms.topic: article
author: robinharwood
ms.author: daknappe
ms.date: 7/3/2024
manager: dongill
---
# Install RDS client access licenses on the Remote Desktop license server

Use the following information to install Remote Desktop Services client access licenses (CALs) on the license server. Once the CALs are installed, the license server will issue them to users as appropriate. Be sure to [activate your license server](./rds-activate-license-server.md) first before continuing with the following steps.

> [!NOTE]
> You need Internet connectivity on the computer running Remote Desktop Licensing Manager but not on the computer running the license server.

1. On the license server (usually the first RD Connection Broker), open the Remote Desktop Licensing Manager.

1. Right-click the license server, and then select **Install licenses**.

1. Select **Next** on the welcome page.

1. Select the program you purchased your RDS CALs from, and then select **Next**. If you are a service provider, select **Service Provider License Agreement**.

1. Enter the information for your license program. In most cases, this will be the license code or an agreement number, but this varies depending on the license program you're using.

1. Select **Next**.

1. Select the product version, license type, and number of licenses for your environment, and then select **Next**. The license manager contacts the Microsoft Clearinghouse to validate and retrieve your licenses.

1.  Select **Finish** to complete the process.
