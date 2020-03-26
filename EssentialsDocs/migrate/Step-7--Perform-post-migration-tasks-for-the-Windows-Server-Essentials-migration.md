---
title: "Step 7: Perform post-migration tasks for the Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d382e3fd-d393-4bd0-883f-db50104a969f
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 7: Perform post-migration tasks for the Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The following tasks help you finish setting up your Destination Server with some of the same settings that were on the Source Server. You may have disabled some of these settings on your Source Server during the migration process, so they were not migrated to the Destination Server.  
  
1.  [Delete DNS entries for the Source Server](Step-7--Perform-post-migration-tasks-for-the-Windows-Server-Essentials-migration.md#BKMK_DeleteDNSEntries)  
  
2.  [Share line-of-business and other application data folders](Step-7--Perform-post-migration-tasks-for-the-Windows-Server-Essentials-migration.md#BKMK_ShareLineOfBusinessAndOtherApplications)  
  
##  <a name="BKMK_DeleteDNSEntries"></a> Delete DNS entries for the Source Server  
 After you decommission the Source Server, the Domain Name Service (DNS) server may still contain entries that point to the Source Server. Delete these DNS entries.  
  
#### To delete DNS entries that point to the Source Server  
  
1.  On the Destination Server, open **DNS Manager**.  
  
2.  In DNS Manager, right-click the server name, click **Properties**, and then click the **Forwarders** tab.  
  
3.  Determine if there is an entry in the forwarder list that points to the Source Server. If there is, click **Edit**, and then delete that entry in the **Edit Forwarders** window.  
  
4.  In **DNS Manager**, expand the server name, and then expand **Forward Lookup Zones**.  
  
5.  For each Forward Lookup Zone, right-click the zone, click **Properties**, and then click the **Name Servers** tab.  
  
6.  Select an entry in the **Name servers** text box that points to the Source Server, click **Remove**, and then click **OK**.  
  
7.  Repeat steps 5 and 6 until all pointers to the Source Server are removed.  
  
8.  Click **OK** to close the **Properties** window.  
  
9. In **DNS Manager**, expand **Reverse Lookup Zones**.  
  
10. Repeat steps 6 through 9 to remove all Reverse Lookup Zones that point to the Source Server.  
  
##  <a name="BKMK_ShareLineOfBusinessAndOtherApplications"></a> Share line-of-business and other application data folders  
 You must set the shared folder permissions and the NTFS permissions for the line-of-business and other application data folders that you copied to the Destination Server. After you set the permissions, the shared folders are displayed in the Dashboard on the **Storage** tab.  
  
 If you are using a logon script to map drives to the shared folders, you must update the script to map to the drives on the Destination Server.  
  
## Next steps  
 You have performed the post-migration tasks for  Windows Server Essentials migration. Now go to [Step 8-- Run the Windows Server Essentials Best Practices Analyzer](Step-8--Run-the-Windows-Server-Essentials-Best-Practices-Analyzer.md).  
  

To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

