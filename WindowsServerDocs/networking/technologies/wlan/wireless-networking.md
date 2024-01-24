---
title: Wireless LAN overview in Windows Server
description: The WLAN service allows for wireless configuration, discovery, and connectivity using a wireless adapter in Windows devices.
ms.topic: how-to
ms.author: wscontent
author: xelu86
ms.date: 01/23/2024

---

# Wireless LAN overview

The Wireless LAN (WLAN) service is a feature in Windows Server that allows you to configure, discover, and connect to wireless networks. Once enabled, the WLAN AutoConfig service dynamically scans and selects which wireless network your device can automatically connect to using a wireless network adapter. The AutoConfig service automatically connects to a more preferred wireless network when one becomes available.

WLAN also offers various security measures to safeguard data transmission over wireless networks using authentication and encryption protocols. To learn more, see [Extensible Authentication Protocol (EAP) for network access](../extensible-authentication-protocol/network-access.md).

## Prerequisites

- A Windows Server 2012 operating system or later.
- Drivers for supported wireless adapters.

### Install WLAN for Windows Server

The WLAN feature isn't installed in Windows Server by default. To install the WLAN and related service, follow these steps:

1. Open **Server Manager**, select **Add Roles and Features**, select **Next**, then select **Next** again.
1. In the **Select server roles** page, select **Next**, select **Wireless LAN Service**, then select **Next**.
1. In the **Confirm installations selections** page, select **Install**, then select **Close**.
1. Restart your device for these changes to apply.

Alternatively, the WLAN feature can also be installed in PowerShell by running:

```powershell
Install-WindowsFeature -Name Wireless-Networking
```

> [!NOTE]
> In Windows Server Insiders Preview, the WLAN feature is installed by default and you're required to enable this service to utilize wireless capabilities.

### Enable WLAN service

After your device is restarted, the **wlansvc** service needs to be enabled in the **Services** app by following these steps:

1. Select **Start** > type **services.msc** > select **Services**.
1. In the right pane, scroll to the bottom until you see **WLAN AutoConfig**.
1. Right-click on **WLAN AutoConfig** and select **Start**.

Alternatively, the WLAN service can be started using the Command Prompt or PowerShell by running:

```cmd
net start wlansvc
```

```powershell
Start-Service -Name wlansvc
```

### Install WLAN for Windows client

This service is already installed and enabled by default in Windows client devices.

## See also

- [NCSI overview](../../ncsi/ncsi-overview.md)
- [Wireless access deployment overview](../../core-network-guide/cncg/wireless/b-wireless-access-deploy-overview.md)
- [Wireless technology troubleshooting guidance](/troubleshoot/windows-server/networking/troubleshoot-wireless-technologies)
