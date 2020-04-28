---
title: Configure NPS UDP Port Information
description: You can use this topic to configure the ports that Network Policy Server (NPS) uses for Remote Authentication Dial-In User Service (RADIUS) authentication and accounting traffic in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 70569958-d7a7-474e-a817-6b7b5134784a
ms.author: lizross 
author: eross-msft
---

# Configure NPS UDP Port Information

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use the following procedure to configure the ports that Network Policy Server (NPS) uses for Remote Authentication Dial-In User Service \(RADIUS\) authentication and accounting traffic.

By default, NPS listens for RADIUS traffic on ports 1812, 1813, 1645, and 1646 for both Internet Protocol version 6 \(IPv6\) and IPv4 for all installed network adapters.

>[!NOTE]
>If you uninstall either IPv4 or IPv6 on a network adapter, NPS does not monitor RADIUS traffic for the uninstalled protocol.

The port values of 1812 for authentication and 1813 for accounting are RADIUS standard ports defined by the Internet Engineering Task Force \(IETF\) in RFCs 2865 and 2866. However, by default, many access servers use ports 1645 for authentication requests and 1646 for accounting requests. No matter which port numbers you decide to use, make sure that NPS and your access server are configured to use the same ones.

>[IMPORTANT]
>If you do not use the RADIUS default port numbers, you must configure exceptions on the firewall for the local computer to allow RADIUS traffic on the new ports. For more information, see [Configure Firewalls for RADIUS Traffic](nps-firewalls-configure.md).

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

## To configure NPS UDP port information 

1. Open the NPS console.
2. Right-click **Network Policy Server**, and then click **Properties**.
3. Click the **Ports** tab, and then examine the settings for ports. If your RADIUS authentication and RADIUS accounting UDP ports vary from the default values provided (1812 and 1645 for authentication, and 1813 and 1646 for accounting), type your port settings in **Authentication** and **Accounting**.
4. To use multiple port settings for authentication or accounting requests, separate the port numbers with commas.

For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
