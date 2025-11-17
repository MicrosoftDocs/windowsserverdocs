---
title: Enable Background File Synchronization on Metered Networks in Windows and Windows Server
description: Step-by-step guide to configured file synchronization on costed networks and optimize synchronization while roaming or near bandwidth limits.
ms.date: 05/15/2025
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
#customer intent: As a IT administrator, I want to enable background file synchronization on metered networks, so that users can access files seamlessly while managing data usage effectively.
---

# Enable Background File Synchronization on Metered Networks in Windows and Windows Server

In this article, learn how to configure background file synchronization for Offline Files on costed (metered) networks. Windows and Windows Server support background file synchronization by automatically tracking roaming and bandwidth usage limits while on metered connections. Users can still manually initiate synchronization, and administrators can optimize synchronization settings for users who rely on metered connections or frequently roam between networks.

By default, Windows disables background synchronization and switches to Offline mode in the following situations:

- The user is connected to a metered network, such as a 4G mobile connection.
- The user is near or over their bandwidth limit.
- The user is roaming on another provider’s network.

 Metered network connections usually have round-trip network latencies that are slower than the default 35-millisecond latency value for transitioning to Offline (Slow Connection) mode in Windows, and Windows Server. Therefore, these connections usually transition to Offline (Slow Connection) mode automatically.

## Prerequisites

To enable background file synchronization of Offline Files for users on metered networks, ensure your environment meets the following requirements:

- An Active Directory Domain Services (AD DS) domain, with client computers joined to the domain. There are no forest or domain functional-level requirements or schema requirements.

- Permission in AD DS to create and link Group Policy Objects (GPOs) in the domain or organizational unit (OU) where the users are located.

- Client computers running Windows or Windows Server.

- A computer with the Group Policy Management Console installed.

## Enable background file synchronization of Offline Files on costed networks

In Windows and Windows Server, you can enable background file synchronization of Offline Files on costed networks by using the **Enable file synchronization on costed networks** Group Policy setting. This policy setting allows users to synchronize files in the background when they're connected to a metered network.

Follow these steps to configure the **Enable file synchronization on costed networks** policy setting using Group Policy:

1. Select the **Start** button, type **Group Policy Management**, open **Group Policy Management** from the best match list.

1. In the console tree, expand the domain or organizational unit (OU) where you want to create or edit the GPO.

1. Perform one of the following actions:

   1. To create a new Group Policy Object (GPO) that specifies which users should perform background synchronization on metered networks, right-click the appropriate domain or organizational unit (OU), and then select **Create a GPO in this domain, and link it here**.

     OR

   1. To edit an existing GPO that specifies which users should perform background synchronization on metered networks, right-click the appropriate GPO, and then select **Edit**.

1. In the **Group Policy Management Editor** policy navigation tree, expand **Computer Configuration > Policies > Administrative Templates > Network > Offline Files**.

1. Right-click **Enable file synchronization on costed networks**, and then select **Edit**. The **Enable file synchronization on costed networks** window appears.

1. select **Enabled**, and then select **OK**.

To ensure client computers that are using metered network connections properly transition to the Offline (Slow Connection) mode instead of the more bandwidth-intensive Online mode, test the latencies of your metered network connections. To adjust the threshold by using the **Configure slow-link mode** Group Policy setting for your file server, or you can enable the Always Offline mode. To learn more about the Always Offline mode, see [Enable Always Offline mode for faster access to files](enable-always-offline.md).

## Related content

- [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md)

- [Enable Always Offline mode for faster access to files](enable-always-offline.md)

- [Deploy primary computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md)
