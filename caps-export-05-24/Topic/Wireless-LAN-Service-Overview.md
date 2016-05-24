---
title: Wireless LAN Service Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5b387e2d-dddf-491d-97a0-daa107a4aa24
author: carmonmills
---
# Wireless LAN Service Overview
The Wireless LAN service is a feature in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] that you can use to enable the wireless WLAN AutoConfig service, and to configure the WLAN AutoConfig service for automatic startup. Once enabled, the WLAN AutoConfig service dynamically selects which wireless network the computer automatically connects to, and configures the necessary settings on the wireless network adapter. This includes automatically selecting and connecting to a more preferred wireless network when one becomes available.  
  
## Enabling the Wireless LAN Service  
In [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)], installing the Wireless LAN Service server feature did not require restarting the computer.  The restart was added in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to support the Windows Connection Manager service.  The Windows Connection Manager service runs in an svchost.exe process which is already running when the Wireless LAN Service feature is installed, which is why a restart is required. Additionally, to start the WAL AutoConfig service requires an additional step, which is explained in the following procedure.  
  
#### To enable the Wireless LAN Service  
  
1.  In **Server Manager Dashboard**, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.  
  
2.  Click **Next**. In **Select installation type**, select **Role\-based or feature\-based installation**, and then click **Next**.  
  
3.  In **Select destination server**, enable **Select a server from the server pool**, and in **Server Pool**, select the server for which you want to enable the Wireless LAN Service, and then click **Next**.  
  
4.  In **Select server roles**, click **Next**.  
  
5.  In **Select Server features**, in **Features**, select **Wireless LAN Service**, and then click **Next**.  
  
> [!WARNING]  
> The computer must be restarted to complete the installation of the Wireless LAN Service. Regardless of whether you select the option to automatically restart the computer after adding the Wireless LAN Service, or you manually restart the computer after adding the wireless LAN service, after the computer restarts, the Wireless LAN Service \(WLAN AutoConfig\) does not automatically start. You can verify this behavior as follows:  
>   
> 1.  In Network Connections, the Wireless Adapter \(named Wi\-Fi by default\), is disabled.  
> 2.  In the Services console \[Control Panel\\All Control Panel Items\\Administrative Tools\\Services\], the WLAN AutoConfig service startup type is Automatic, however the status does not indicate the service is running.  
> 3.  In the Notification Area, Clicking on the Network Connections icon opens a list of networks, but the heading **Wi\-Fi** is not listed, and no wireless network are detected.  
>   
> You can start the WLAN AutoConfig service, and resolve the service startup configuration in one of two ways:  
>   
> -   Manually restart the computer again.  
> -   In the Services console \[ Control Panel\\All Control Panel Items\\Administrative Tools\\Services\], double click WLAN AutoConfig, click Start, and then click OK.  
  
