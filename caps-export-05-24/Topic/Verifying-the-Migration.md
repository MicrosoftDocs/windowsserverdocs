---
title: Verifying the Migration
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f24f5e67-da7a-43b7-bd6b-3686bfd98d0a
author: vhorne
---
# Verifying the Migration
  
## <a name="BKMK_Step6VerifyTheMigration"></a>Verify the migration  
The sixth step in the migration process is to verify that the migration was successful by testing and validating the new print server. The Printer Migration Wizard provides detailed logging of migration events in the Event Viewer.  
  
### To verify destination server configuration  
  
1.  View event log messages about the migration.  
  
    -   If you are managing [!INCLUDE[printsrv](../Token/printsrv_md.md)] migration from a remote client computer, you can view event messages in **Custom Views\/Administrative Events** in Event Viewer on the Windows\-based client computer.  
  
    -   If you are managing migration from the destination server and [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)]is not yet installed, then migration\-related events are logged in **Custom Views\/Administrative Events** in Event Viewer on the destination server.  
  
    -   If you are managing migration from the destination server and [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)] is installed, events are logged to a different location. See the events located at **Applications and Services Logs\/Microsoft\/PrintBRM\/Admin**  
  
        To view details after closing the Printer Migration Wizard, right\-click the **Start** charm, and then click **Event Viewer**. In the Event Viewer pane, under **Custom Views**, click **Server Roles**, and then click **Print and Document Services**. In the center pane, click the printer migration event to view details.  
  
2.  To verify that each printer queue was migrated to the new server:  
  
    -   Manually check the destination server for each printer migrated from the source server.  
  
    -   Verify that the printer associated with each printer queue is online.  
  
    To check each printer queue’s online status in the Print Management snap\-in, under **Print Servers**, click **Printers**. A list of all migrated printers appears in the center pane, listing the printer queue status for each printer. Clients will be unable to print to printers that were not restored successfully, and any connections to a missing printer queue will be invalidated.  
  
3.  Check the printer queue settings.  
  
    -   Confirm that a printer queue’s special settings, permissions, or drivers were preserved during the migration.  
  
    -   Check the properties for each queue on the destination server and verify that any special settings are still applicable.  
  
    -   If the driver installs any non\-standard settings that have been altered as a result of the migration, verify those as well.  
  
    > [!NOTE]  
    > The migration process only preserves printer queue permissions. Other permissions on the source server, such as system permissions \(for example, user accounts\) and custom permissions, are not migrated using this process.  
  
4.  Make any necessary changes, such as adding a port monitor or a new driver.  
  
#### Rename the destination server to the name of the source server  
Temporarily rename the destination server. For example, you can name the destination server the same as the source server with **\_NEW** appended to the source server name. After verifying that printers are restored to the destination server, rename the source server \(for example, by appending **\_OLD** to the source server name\), and then use the source server’s pre\-migration name as the new name of the destination server.  
  
> [!IMPORTANT]  
> Validating existing printer connections from client computers can only be completed after the destination server name is the same as the pre\-migration source server name. Print connections to the server in the period between renaming the source server and renaming the destination server will fail. All migration steps should be complete on the destination server before renaming to ensure that the downtime occurs only between the renaming of the source server and the final renaming of the destination server.  
  
If you are using Active Directory Domain Services \(AD DS\) to publish printers, do the following to ensure that AD DS does not contain multiple instances of the same printer.  
  
When you restore printers to the destination server, do not publish printers to AD DS. This prevents duplicate printers from being displayed by AD DS before the destination server configuration is verified.  
  
On the source server, you must unpublish printers before renaming the source server. To do this, select all printers in the Print Management snap\-in, right\-click the selected printers, and then click **Remove from Directory**. This prevents printers from being published twice to AD DS when the source server is renamed.  
  
After renaming the destination server to the source server’s original name, you can publish all printers on the destination server to AD DS. To do this, select all printers in the Print Management snap\-in, right\-click the selected printers, and then click **List in directory**.  
  
#### To verify configuration of other computers in the enterprise  
In most cases, a new print server will not affect other computers in the enterprise. Existing client connections may be corrupted if you make a change to any of the following print server properties:  
  
-   The print server name  
  
-   The printer name  
  
-   The print share name  
  
-   The share permissions  
  
-   The printer’s availability to the server  
  
Print a test page to each printer queue from a client \(or set of clients\) that had an existing connection to the source server to verify that other computers are not affected by the new print server. In a cross\-architecture environment, test each supported architecture.  
  
##### Print a test job from a client with an existing connection  
From a client computer that is configured to print to the source print server, use the existing print queue to print a page to the new server. If you cannot print a test page:  
  
-   Determine if one or more of the print server properties listed above have been changed.  
  
-   Check whether the destination server is available to the client on the network. Create a new connection to a printer on the destination server to verify that the client and server are communicating normally.  
  
## See Also  
[Migrate Print and Document Services to Windows Server 2012](../Topic/Migrate-Print-and-Document-Services-to-Windows-Server-2012.md)  
[Preparing to Migrate](../Topic/Preparing-to-Migrate.md)  
[Migrating the Print and Document Services Role](../Topic/Migrating-the-Print-and-Document-Services-Role.md)  
[Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md)  
[Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md)  
[Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
