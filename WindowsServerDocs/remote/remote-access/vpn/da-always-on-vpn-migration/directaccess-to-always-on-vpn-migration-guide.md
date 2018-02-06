---
title: Microsoft DirectAccess-to-Always On VPN Migration Guide
description: You can use this guide to migrate domain-joined machines from DirectAccess to Always On VPN while maintaining client connectivity throughout the migration process.
manager: brianlic
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: pashort
author: shortpatti
---

# Microsoft DirectAccess–to–Always On VPN Migration Guide

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

In the past, remote connectivity to the corporate network was primarily limited to domain-joined machines in which DirectAccess provides a clear value proposition in this use case. However, today, more and more devices remotely connected to the organization are not domain joined or even company owned. Instead, these devices are personal devices employees use for work, which presents unique access and authentication scenarios that require a more flexible remote access solution. Always On VPN provides a flexible remote access solution that makes it a viable replacement for DirectAccess, especially for the changing connected-device landscape.

Use this guide to migrate domain-joined machines from DirectAccess to Always On VPN while maintaining client connectivity throughout the migration process. The DirectAccess–to–Always On VPN migration process consists of three primary components:

- **Planning.** Planning for Always On VPN includes user phase separation as well as infrastructure and functionality planning.
- **Migration.** Following a specific process to migrate clients helps minimize race conditions that arise from performing migration steps out of order.
- **Removal and decommission.** Properly decommission the environment after you have migrated everyone off DirectAccess.

>[!IMPORTANT]
> This guide is not a deployment guide for Always On VPN. If you currently have no VPN technology or are simply looking at implementing Always On VPN in your environment, see [Remote Access Always On VPN Deployment Guide for Windows Server and Windows 10](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy). 
> 
> In addition to this topic, the following VPN documentation is available.
>
>- [Always On VPN and DirectAccess Features Comparison](vpn-map-da.md)
>- [Configure VPN Device Tunnels in Windows 10](vpn-device-tunnel-config.md)
>- Windows 10 [VPN technical guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide)