---
title: Virtual Private Networking (VPN)
description: You can use this topic to learn about Windows Server 2016 and Windows 10 VPN features and functionality.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: cd4908f0-0d6f-4c02-8f98-4dc88c3dcb65
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Virtual Private Networking \(VPN\)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10



## RAS Gateway as a Single Tenant VPN Server

In Windows Server 2016, the Remote Access server role is a logical grouping of the following related network access technologies.

- Remote Access Service (RAS)
- Routing
- Web Application Proxy

These technologies are the role services of the Remote Access server role. 

When you install the Remote Access server role with the Add Roles and Features Wizard or Windows PowerShell, you can install one or more of these three role services.

When you install the **DirectAccess and VPN \(RAS\)** role service, you are deploying the Remote Access Service Gateway \(**RAS Gateway**\). You can deploy RAS Gateway as a single tenant RAS Gateway virtual private network \(VPN\) server that provides many advanced features and enhanced functionality.

>[!NOTE]
>You can also deploy RAS Gateway as a Multitenant VPN server for use with Software Defined Networking \(SDN\), or as a DirectAccess server. For more information, see [RAS Gateway](https://docs.microsoft.com/windows-server/remote/remote-access/ras-gateway/ras-gateway), [Software Defined Networking (SDN)](https://docs.microsoft.com/windows-server/networking/sdn/software-defined-networking), and [DirectAccess](https://docs.microsoft.com/windows-server/remote/remote-access/directaccess/directaccess).

## Related topics

>[!NOTE]
>In addition to this topic, the following VPN documentation is available.
>
>- [Always On VPN and DirectAccess Features Comparison](vpn-map-da.md)
>- [Configure VPN Device Tunnels in Windows 10](vpn-device-tunnel-config.md)
>- [Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10](always-on-vpn/deploy/always-on-vpn-deploy.md)
>- Windows 10 [VPN technical guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide)
