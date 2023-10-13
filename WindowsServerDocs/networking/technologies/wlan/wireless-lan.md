---
title: Wireless LAN Service Overview
description: WLAN service allows for wireless configuration, discovery, and connectivity using a wireless adapter in Windows Server and Windows client.
ms.topic: article
ms.author: wscontent
author: xelu86
ms.date: 10/13/2023

---

# Wireless LAN service overview

The Wireless LAN (WLAN) service is a feature in Windows Server that allows you to configure, discover, and connect to wireless networks. Once enabled, the WLAN AutoConfig service dynamically scans and selects which wireless network your device can automatically connect to using a wireless network adapter. The AutoConfig service automatically connects to a more preferred wireless network when one becomes available.

WLAN also offers various security measures to safeguard data transmission over wireless networks using authentication and encryption protocols. To learn more, see [Extensible Authentication Protocol (EAP) for network access](../extensible-authentication-protocol/network-access.md).

## Enable WLAN for Windows Server

WLAN service isn't installed in Windows Server by default. To install the WLAN service, follow these steps:

1. Open **Server Manager**, select **Add Roles and Features**, select **Next**, then select **Next** again.
1. In the **Select server roles** page, select **Next**, select **Wireless LAN Service**, then select **Next**.
1. In the **Confirm installations selections** page, select **Install**, then select **Close**.

Alternatively, WLAN can also be installed in PowerShell by running:

```powershell
Install-WindowsFeature -Name Wireless-Networking
```

> [!NOTE]
> Installing the WLAN service requires you to reboot your device for these changes to apply.

## Enable WLAN for Windows client

This service is enabled by default in Windows client devices.

## See also

- [Wireless access deployment overview](../core-network-guide/cncg/wireless/b-wireless-access-deploy-overview.md)
- [Wireless technology troubleshooting guidance](https://learn.microsoft.com/troubleshoot/windows-server/networking/troubleshoot-wireless-technologies)
