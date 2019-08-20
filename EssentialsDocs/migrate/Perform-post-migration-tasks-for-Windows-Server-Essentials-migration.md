---
title: "Perform post-migration tasks for Windows Server Essentials migration1"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2d236a4-0d62-4961-9d1f-332054e06f6d
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Perform post-migration tasks for Windows Server Essentials migration1

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The following tasks help you finish setting up your Destination Server with some of the same settings that were on the Source Server. You may have disabled some of these settings on your Source Server during the migration process, so they were not migrated to the Destination Server. Or they are optional configuration steps that you may want to perform.  
  

-   [Delete DNS entries of the Source Server](Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_DeleteDNSEntries)  
  
-   [Share line-of-business and other application data folders](Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_ShareLineOfBusinessAndOtherApplications)  
  
-   [Fix client computer issues after migrating](Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_FixClientComputerIssuesAfterMigrating)  
  
-   [Give the built-in Administrators group the right to log on as a batch job](Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_AdminGroup)  

-   [Delete DNS entries of the Source Server](../migrate/Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_DeleteDNSEntries)  
  
-   [Share line-of-business and other application data folders](../migrate/Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_ShareLineOfBusinessAndOtherApplications)  
  
-   [Fix client computer issues after migrating](../migrate/Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_FixClientComputerIssuesAfterMigrating)  
  
-   [Give the built-in Administrators group the right to log on as a batch job](../migrate/Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md#BKMK_AdminGroup)  

  
##  <a name="BKMK_DeleteDNSEntries"></a> Delete DNS entries of the Source Server  
 After you decommission the Source Server, the Domain Name Service (DNS) server may still contain entries that point to the Source Server. Delete these DNS entries.  
  
#### To delete DNS entries that point to the Source Server  
  
1.  On the Destination Server, open **DNS Manager**.  
  
2.  In DNS Manager, right-click the server name, click **Properties**, and then click the **Forwarders** tab.  
  
3.  Determine if there is an entry in the forwarder list that points to the Source Server. If there is, click **Edit**, and then delete that entry in the **Edit Forwarders** window.  
  
4.  In **DNS Manager**, expand the server name, and then expand **Forward Lookup Zones**.  
  
5.  For each Forward Lookup Zone, right-click the zone, click **Properties**, and then click the **Name Servers** tab.  
  
6.  Click an entry in the **Name servers** box that points to the Source Server, click **Remove**, and then click **OK**.  
  
7.  Repeat steps 5 and 6 until all pointers to the Source Server are removed.  
  
8.  Click **OK** to close the **Properties** window.  
  
9. In the **DNS Manager** console, expand **Reverse Lookup Zones**.  
  
10. Repeat steps 6 through 9 to remove all Reverse Lookup Zones that point to the Source Server.  
  
##  <a name="BKMK_ShareLineOfBusinessAndOtherApplications"></a> Share line-of-business and other application data folders  
 You must set the shared folder permissions and the NTFS permissions for the line-of-business and other application data folders that you copied to the Destination Server. After you set the permissions, the shared folders are displayed in the  Windows Server Essentials Dashboard in the **Storage** section.  
  
 If you are using a logon script to map drives to the shared folders, you must update the script to map to the drives on the Destination Server.  
  
##  <a name="BKMK_FixClientComputerIssuesAfterMigrating"></a> Fix client computer issues after migrating  
 If you migrate to  Windows Server Essentials from Windows Small Business Server 2003 Premium Edition with Microsoft Internet Security and Acceleration (ISA) Server installed, client computers on the network still have the Microsoft Firewall Client and Internet Explorer configured to use a proxy server.  
  
 This causes connectivity issues on the client computers, because the proxy server no longer exists. If there is a different proxy server configured, the client computers continue to use the server running Windows SBS 2003 for the proxy server. To fix this issue, you must reconfigure Internet Explorer to not use a proxy server or to use the new proxy server.  
  
#### To reconfigure Internet Explorer  
  
1.  In Internet Explorer, click **Tools**, and then click **Internet Options**.  
  
2.  Click the **Connections** tab, click **LAN Settings**, and then do one of the following:  
  
    -   If you are not using a proxy server on your network, clear all the check boxes in the **Local Area Network (LAN) Settings** dialog box.  
  
    -   If you want to use a new proxy server on your network:  
  
        1.  In the **Local Area Network (LAN) Settings** dialog box, clear the check boxes in the **Automatic configuration** section.  
  
        2.  In the **Proxy server** section, verify that both check boxes are selected.  
  
        3.  In the **Address** box, type the fully qualified domain name (FQDN) of the proxy server.  
  
        4.  In the **Port** box, type **80**.  
  
3.  Click **OK** twice.  
  
4.  Browse to a website to ensure that the connection settings are correct.  
  
##  <a name="BKMK_AdminGroup"></a> Give the built-in Administrators group the right to log on as a batch job  
 After you migrate an existing Windows Small Business Server 2003 domain to  Windows Server Essentials, you should give the built-in Administrators group the right to log on as a batch job. Verify that the built-in Administrators group still has the right to log on as a batch job to the Destination Server. Administrators need this right to run an alert on the Destination Server without logging on.  
  
#### To give the built-in Administrators group the right to log on as a batch job  
  
1. On the Destination Server, open the **Group Policy Management** administrative tool.  
  
2. In the **Group Policy Management** Console tree, expand **Forest:** *<ServerName\>*, expand Domains, and then expand your server.  
  
3. Expand **Domain Controllers**, right-click **Default Domain Controllers Policy**, and then click **Edit**.  
  
4. In **Group Policy Management Editor**, click **Default Domain Controllers Policy**<em><ServerName\></em>**Policy**, and then expand **Computer Configuration**.  
  
5. Expand **Policies**, expand **Windows Settings**, and then expand **Security Settings**.  
  
6. In the **Security Settings** tree, expand **Local Policies**, and then click **User Rights Assignment**.  
  
7. In the results pane, right-click **Log on as a batch job**, and then click Properties.  
  
8. In the **Log on as a batch job Properties** page, click **Add User or Group**.  
  
9. In the **Add User or Group** dialog box, click **Browse**.  
  
10. In the **Select Users, Computers, or Groups** dialog box, type **Administrators**.  
  
11. Click **Check Names** to verify that the built-in Administrators group appears, and then click **OK** three times to save the setting.  
  
## See also  
  

-   [Migrate from Windows SBS 2003](Migrate-Windows-Small-Business-Server-2003-to-Windows-Server-Essentials.md)  
  
-   [Migrate Server Data to Windows Server Essentials](Migrate-Server-Data-to-Windows-Server-Essentials.md)

-   [Migrate from Windows SBS 2003](../migrate/Migrate-Windows-Small-Business-Server-2003-to-Windows-Server-Essentials.md)  
  
-   [Migrate Server Data to Windows Server Essentials](../migrate/Migrate-Server-Data-to-Windows-Server-Essentials.md)

