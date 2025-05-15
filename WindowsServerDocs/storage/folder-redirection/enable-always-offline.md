---
title: Enable Always Offline mode for faster access to files in Windows and Windows Server
description: Step-by-step guide to enable Always Offline mode of Offline Files to provide faster access to cached files and redirected folders.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 05/15/2025
#customer intent: As a Windows Server administrator, I want to enable Always Offline mode for faster access to files and lower bandwidth usage, so that users can work offline efficiently even when connected to high-speed networks.
---

# Enable Always Offline mode for faster access to files

This article describes how to use the Always Offline mode of Offline Files to provide faster access to cached files and redirected folders. Offline Files is a feature of Windows that allows users to access files on a network share even when the network connection is unavailable. Offline Files caches files and folders from a network share on the local computer, allowing users to work with them as if they were stored locally. When the network connection is restored, changes made to the files are synchronized with the server copy.

## What does Always Offline do?

Always Offline mode is a specific configuration of Offline Files that allows users to work with files and folders in a redirected folder even when the network connection is unavailable or slow. This mode is useful for mobile users who might frequently switch between different networks or work in environments with unreliable connectivity. Users can switch to Offline mode using the **Work offline** button in Windows Explorer, or the system can automatically switch to Offline mode based on network availability and conditions.

Administrators can configure the experience for users of Offline Files to always work offline, even when they're connected through a high-speed network connection. With Always Offline mode, computers never transition to Online mode when the **Configure slow-link mode** Group Policy setting is configured and the **Latency** threshold parameter is set to 1 millisecond. Changes are synced in the background every 120 minutes, by default, but synchronization is configurable by using the **Configure Background Sync** Group Policy setting.

## Prerequisites

To enable Always Offline mode, your environment must meet the following prerequisites.

- An Active Directory Domain Services (AD DS) domain, with client computers joined to the domain. There are no forest or domain functional-level requirements or schema requirements.

- Permission in AD DS to create and link Group Policy Objects (GPOs) in the domain or organizational unit (OU) where the users are located.

- Client computers running Windows or Windows Server.

- A computer with the Group Policy Management Console installed.

## Enable Always Offline mode

To enable Always Offline mode, use Group Policy to enable the **Configure slow-link mode** policy setting and set the latency to **1** (millisecond). Doing so causes client computers to automatically use Always Offline mode. To enable Always Offline mode, follow these steps:

1. Select the **Start** button, type **Group Policy Management**, open **Group Policy Management** from the best match list.

1. In the console tree, expand the domain or organizational unit (OU) where you want to create or edit the GPO.

1. Perform one of the following actions:

   1. To create a new Group Policy Object (GPO) that specifies which users should perform background synchronization on metered networks, right-click the appropriate domain or organizational unit (OU), and then select **Create a GPO in this domain, and link it here**.

     OR

   1. To edit an existing GPO that specifies which users should perform background synchronization on metered networks, right-click the appropriate GPO, and then select **Edit**.

1. In the **Group Policy Management Editor** policy navigation tree, expand **Computer Configuration > Policies > Administrative Templates > Network > Offline Files**.

1. Right-click **Configure slow-link mode**, and then select **Edit**. The **Configure slow-link mode** window appears.

1. Select **Enabled**.

1. In the **Options** box under **UNC Paths**, select **Show**. The **Show Contents window** appears.

1. In the **Value name** box, specify the file share for which you want to enable Always Offline mode. For example, to enable Always Offline mode for the Server1 using the file share name Share1, enter `\\Server1\Share1`.

1. To enable Always Offline mode on all file shares, enter `*`.

1. In the **Value** box, enter `Latency=1` to set the latency threshold to 1 millisecond, and then select **OK**.

By default, when in Always Offline mode, Windows synchronizes files in the Offline Files cache in the background every two hours. To change this value, use the **Configure Background Sync** policy setting.

## Related content

- [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md)

- [Deploy Folder Redirection with Offline Files](deploy-folder-redirection.md)

- [Enable Background File Synchronization on Metered Networks in Windows and Windows Server](enable-background-synchronization.md)
