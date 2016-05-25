---
title: Enable Background File Synchronization on Metered Networks
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c6fae246-0555-41d8-9865-41dedb876824
author: JasonGerend
---
# Enable Background File Synchronization on Metered Networks
This document describes how to enable background file synchronization of Offline Files while using metered connections that have usage limits, and while roaming on another provider’s network.  
  
[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], Windows 8, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and Windows Server 2012 support cost\-aware synchronization by automatically tracking roaming and bandwidth usage limits while on metered connections. By default, when the user is using a metered connection \(such as a 4G mobile network\) and is near or over their bandwidth limit or roaming on another provider’s network, Windows switches to Offline mode and disables background synchronization. Users can still manually initiate synchronization, and administrators can override cost\-aware synchronization for specific users, such as executives.  
  
**In this document**  
  
-   [Prerequisites](#BKMK_Prereqs)  
  
-   [Enable background file synchronization of Offline Files on metered networks](#BKMK_Step1)  
  
## Prerequisites  
To enable the background file synchronization of Offline Files for groups of users when they are using metered connections, your environment must meet the following prerequisites.  
  
-   An Active Directory Domain Services \(AD DS\) domain, with client computers joined to the domain. There are no forest or domain functional\-level requirements or schema requirements.  
  
-   Client computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   A computer with Group Policy Management installed.  
  
> [!TIP]  
> To ensure client computers that are using metered network connections properly transition to the Offline \(Slow Connection\) mode instead of the more bandwidth\-intensive Online mode, test the latencies of your metered network connections. Metered network connections typically have a round\-trip network latency of 50 milliseconds or more. However, if the latency is less \(faster\) than 35 milliseconds on computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can adjust the threshold by using the **Configure slow\-link mode** Group Policy setting, or you can enable the Always Offline mode.  
  
## <a name="BKMK_Step1"></a>Enable background file synchronization of Offline Files on metered networks  
To enable background file synchronization of Offline Files for a group of users while using metered connections, use Group Policy to enable the **Enable file synchronization on costed networks** policy setting for the appropriate Group Policy Object \(GPO\).  
  
#### To enable background file synchronization of Offline Files on metered networks  
  
1.  Open **Group Policy Management**.  
  
2.  To optionally create a new Group Policy Object \(GPO\) that specifies which users should perform background synchronization on metered networks, right\-click the appropriate domain or organizational unit, and then click **Create a GPO in this domain, and link it here**.  
  
3.  In the console tree, right\-click the GPO for which you want to configure the Offline Files settings, and then click **Edit**. The **Group Policy Management Editor** appears.  
  
4.  In the console tree, under **Computer Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Network**, and expand **Offline Files**.  
  
5.  Right\-click **Enable file synchronization on costed networks**, and then click **Edit**. The **Enable file synchronization on costed networks** window appears.  
  
6.  Click **Enabled**, and then click **OK**.  
  
## See Also  
[Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md)  
[Enable the Always Offline Mode to Provide Faster Access to Files](../Topic/Enable-the-Always-Offline-Mode-to-Provide-Faster-Access-to-Files.md)  
[Deploy Folder Redirection with Offline Files](../Topic/Deploy-Folder-Redirection-with-Offline-Files.md)  
  
