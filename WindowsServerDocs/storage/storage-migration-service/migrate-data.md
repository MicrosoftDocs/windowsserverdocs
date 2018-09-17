---
title: Migrate a file server by using Storage Migration Service
description: Brief description of topic for search engine results
author: jasongerend
ms.author: jgerend
manager: elizapo
ms.date: 09/24/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Migrate a file server by using Storage Migration Service

Storage Migration Service is a technology included with Windows Server that enables you to migrate servers and data without apps or users having to change anything.

This topic discusses how to migrate files and configuration from one server to another by using Storage Migration Service and Windows Admin Center.

## Install Storage Migration Service

1. Check the [Storage Migration Service requirements](overview.md#requirements) and install [Windows Admin Center](../../manage/windows-admin-center/understand/windows-admin-center.md) on your PC or a management server if you haven't already.
2. In Windows Admin Center, navigate to the orchestrator server (or the destination server if that's what you're using to manage the migration) > **Server Manager** > **Storage Migration Service**.
1. Select **Install** to install Storage Migration Service and its required components.
1. Install the Storage Migration Service proxy on any destination servers running Windows Server 2019. This doubles the transfer speed and opens all the necessary firewall ports for you. <br>To do so, navigate to the destination server > **Server Manager** > **Roles and features**, select **Storage Migration Service Proxy**, and then select **Install**.
1. 
1. 
1. **If you're using destination servers running Windows Server 2016 or Windows Server 2012 R2, open the following firewall ports on them:**

## Step 1: Inventory the source servers to figure out what to migrate

This is when you specify what servers you want to migrate from and scan them to collect info on their files and configurations.

1. Select **New job**, name the job, and then select **OK**.
1. On the **Enter credentials** page, type admin credentials that work on the servers you want to migrate from, and then select **Next**.
1. Select **Add a device**, type a source server name, and then select **OK**. <br>Repeat this for any other servers you want to inventory.
1. Select **Start scan**.<br>The page updates to shows when the scan is complete.
1. Select each server to review the shares, configuration, network adapters, and volumes that were inventoried. 
1. Select **Next** to move on to transferring data.

## Step 2: Transfer files from the sources to the destination servers



 1. On the **Enter credentials** page, type admin credentials that work on the destination servers you want to migrate to, and then select **Next**.
 1. On the **Add a destination device and mappings** page, the first source device is listed. Type the name of the server you want to migrate this server to and then select **Scan device**.
 1. Map the source volumes to destination volumes, clear the **Include** checkbox for any shares you don't want to transfer, and then select **Next**.
 1. Add a destination device and mappings for any more source servers, and then select **Next**.
 1. Optionally adjust the transfer settings, and then select **Next**.
 1. Select **Validate** and then select **Next**.
 1. Select **Start transfer** to start transferring data.

## Step 3: Cutover from the source to the destination server


## See also

