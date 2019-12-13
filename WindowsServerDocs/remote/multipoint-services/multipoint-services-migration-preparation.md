---
title: Prepare to migrate to MultiPoint Services
description: Describes information to gather before you migrate to MultiPoint Services in Windows Server 2016
ms.custom: na
ms.date: 07/29/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3060c531-98a2-4957-a02c-be273f25f493
author: lizap
manager: dongill
ms.author: elizapo
---
# Prepare to migrate to MultiPoint Services in Windows Server 2016

>Applies To: Windows Server 2016

Use the following information to gather the information you need to migrate the MultiPoint Services role service from a source server running an earlier release of Windows Server 2016 to a destination server running Windows Server 2016 RTM.

At a minimum, you must be a member of the Administrators group on the source server and the destination server to install, remove, or set up MultiPoint Services.

>[!NOTE]
> The steps here do not provide guidance for migrating data saved to user folder or shared folders. Ensure that users back up their data before you begin the migration.

Use MultiPoint Manager to retrieve the information needed for migration. You will need server administrator permission to use MultiPoint Manager.

Record the MultiPoint server, user, and environment settings in the [migration data collection worksheet](multipoint-services-migration-worksheet.md). Use the following steps to gather that information.

## MultiPoint Server settings for the local server
1. Start MultiPoint Manager.
2. On the **Home** tab, select the local server, and then click **Edit server settings.**
3. Record the settings in the data worksheet.
4. Close the settings window.

## Managed servers and computers

You can find the names of the managed servers and computers on the **Home** tab in MultiPoint Manager.

## Station settings
If auto-logon or display orientation are configured for the station, use the following steps to retrieve that information. Otherwise you can skip this step.

To retrieve the station settings:

1. Go to the **Stations** tab in MultiPoint Manager.
2. Find a station that has "yes" in the **Auto-logon** column.
3. Select that station, and then click **Configure station**.
4. Record the user that is used for auto-logon.

To retrieve the display orientation settings, view the **station settings** for each station.

## List of users
1. Click the **Users** tab in MultiPoint Manager.
2. Record the **Administrator** and **MultiPoint Dashboard User** accoutns.
3. Record the standard users.

## VDI template location
 If you previously enabled the VDI template feature, record the location of the VDI template. As long as the source and destination servers are on the same network, you can import the template by using MultiPoint Manager.
 
## Next step
You're now ready to [migrate to MultiPoint Services](multipoint-services-migration-steps.md) in the RTM release of Windows Server 2016.