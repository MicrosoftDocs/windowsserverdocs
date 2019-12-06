---
title: Remote Desktop Services - Secure data storage
description: Planning information for securely storing data by using user profile disks (UPDs) in RDS.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37b7f68e-7c3a-4190-a52f-99ae96885fae
author: lizap
ms.author: elizapo
ms.date: 11/21/2016
manager: dongill
---
# Remote Desktop Services - Secure data storage with UPDs

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Store business resources, user personalization data, and settings securely on-premises or in Azure. RD Session Hosts use AD authentication and empower users with the resources they need in a personalized environment, securely. 

Ensuring users have a consistent experience, regardless of the endpoint from which they access their remote resources, is an important aspect of managing an RDS deployment. User Profile Disks (UPDs) allow user data, customizations, and application settings to follow a user within a single collection. A UPD is a per-user, per-collection VHD file saved in a central share that is mounted to a user's session when they sign in - the UPD is treated as a local drive for the duration of that session. 

From the user's perspective, the UPD provides a famililar experience - they save their documents to their Documents folder (on what appears to be a local drive), change their app settings as usual, and make any customizations to their Windows environment. All this data, including the registry hive, is stored on the UPD and persists in a central network share. UPDs are only available to the user when the user is actively connected to a desktop or RemoteApp. UPDs can only roam within a collection because the user's entire `C:\Users\<username\>` directory (including AppData\Local) is stored on the UPD.

You can use [PowerShell cmdlets](https://technet.microsoft.com/library/jj215443.aspx) to designate the path to the central share, the size of each UPD, and which folders should be included or excluded from the user profile saved to the UPD. Alternatively, you can enable UPDs through Server Manager by going to **Remote Desktop Services** > **Collections** > **Desktop Collection** > **Desktop Collection Properties** > **User Profile Disks**. Note that you enable or disable UPDs for all users of an entire collection, not for specific users in that collection. UPDs must be stored on a central file share where the servers in the collection have full control permissions. 

You can achieve high availability for your UPDs by storing them in Azure with [Storage Spaces Direct](rds-storage-spaces-direct-deployment.md). 