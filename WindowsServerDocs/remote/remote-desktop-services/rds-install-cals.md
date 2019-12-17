---
title: Install RDS client access licenses
description: Learn how to install CALs for RD clients.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
ms.author: elizapo
ms.date: 09/20/2016
manager: dongill
---
# Install RDS client access licenses on the Remote Desktop license server

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Use the following information to install Remote Desktop Services client access licenses (CALs) on the license server. Once the CALs are installed, the license server will issue them to users as appropriate.

Note you need Internet connectivity on the computer running Remote Desktop Licensing Manager but not on the computer running the license server.

1. On the license server (usually the first RD Connection Broker), open the Remote Desktop Licensing Manager.
2. Right-click the license server, and then click **Install licenses**.
3. Click **Next** on the welcome page.
4. Select the program you purchased your RDS CALs from, and then click **Next**. If you are a service provider, select **Service Provider License Agreement**.
5. Enter the information for your license program. In most cases, this will be the license code or an agreement number, but this varies depending on the license program you're using.
6. Click **Next**.
7. Select the product version, license type, and number of licenses for your environment, and then click **Next**. The license manager contacts the Microsoft Clearinghouse to validate and retrieve your licenses.
8.  Click **Finish** to complete the process.