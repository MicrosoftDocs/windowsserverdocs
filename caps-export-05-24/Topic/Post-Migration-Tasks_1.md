---
title: Post-Migration Tasks_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 78e08e27-5ab6-4149-b3d8-7d525042ed43
author: vhorne
---
# Post-Migration Tasks_1
  
## <a name="BKMK_Step7PostMigration"></a>Post\-migration  
The final step in the migration process is determined by whether the migration was successful or unsuccessful.  
  
No post\-migration tasks are necessary beyond the standard migration process. If the server state \(new settings, drivers, queues, and so on\) changed, create and archive a new backup of the server state for recovery purposes.  
  
### Success  
The next section provides tasks that should be completed after you have successfully migrated the source printer server.  
  
#### Retire the source server  
After taking the source server offline while backing it up, users are unable to print until the migration to the destination server is complete. To minimize the impact, leave the source server in service while you complete the migration and testing of the destination server. By leaving it in service, you can also add both the source and destination servers to the Print Management snap\-in to simplify verifying the restoration.  
  
Once you have validated the installation, rename the source and destination servers and take the source server offline.  
  
1.  On the source server, restart the print spooler for all printers so it can finish spooling delayed print jobs. When it finishes, verify that there are no new print jobs.  
  
2.  Rename source and destination servers as directed in [Verifying the Migration](../Topic/Verifying-the-Migration.md).  
  
3.  Follow your enterprise’s normal policy for server decommissioning and retirement until retirement of the source server is complete.  
  
> [!NOTE]  
> If the destination server has already been published in Active Directory Domain Services \(AD DS\), then the source server must be unpublished.  
  
### Failure  
The next section provides tasks that should be completed if your migration of the source printer server did not succeede.  
  
#### Restoring the role in the event of migration failure  
Restoring the source server lets you deploy the settings to a new system or use the source server while determining the cause of the failure.  
  
#### Rollback requirements  
  
> [!WARNING]  
> Rollback can only be completed if retirement of the source server has not been started. After you start retiring a source server—that is, you delete any print queues, close any print connections, reformat any drivers, or remove any hardware from the source server—you cannot roll back migration. After you start retiring the source server, the only method of rolling back migration is to restart the Print Services migration process from the beginning.  
  
#### Estimated time to complete rollback  
Rolling back migration involves renaming the source server to its pre\-migration name, and renaming the destination server to either its original name, or another name that is not the same as the pre\-migration name of the source server. Renaming the source and destination servers can be completed in a few minutes.  
  
#### <a name="BKMK_RollBackMigrationOnSourceServer"></a>Roll back migration on the source server  
Rename the source server to its original, pre\-migration name. You might have to rename the destination server to a temporary name first.  
  
### Roll back migration on the destination server  
Rename the destination server, either to its original name, or to another name that is not the same as the original name of the source server.  
  
## Troubleshooting  
The following sections can help you troubleshoot any migration issues.  
  
### Log file locations  
Printer migration events are included in the Application log, which is located at %*SystemRoot*%\\System32\\Winevt\\Logs\\Application.evtx and can be viewed using Event Viewer. A custom view for Printer Migration Events is available in Event Viewer.  
  
> [!NOTE]  
> If the Printer Migration Wizard fails, you are directed to Event Viewer to view error messages. If you cannot find an error that explains the failure in Event Viewer, restore the backup by using the Printbrm.exe command\-line tool. Error reporting from Printbrm.exe can often provide more detail than what is available in the event log.  
  
### Migrating cross\-platform driver language monitors  
When a cross\-architecture migration includes the migration of printer language monitors, an error will occur during the process of restoring the printers to the destination server using the Backup Restore Migration \(Printbrm.exe\) command\-line tool. The reason for the error is that language monitor driver architecture must always be the same as the source server architecture. Therefore, when migrating from x86\-based architecture to x64\-based platforms, language monitor migration cannot be successful. An error posted to the event log will state that the source architecture is not the same as that of the destination server.  
  
You can recover from the printer restore error on the destination server by manually installing \(or reinstalling\) the appropriate standard driver for the migrated printer\(s\) running on that architecture.  
  
### Mitigating a failure in the Print Spooler service  
If you encounter a failure in the Print Spooler service during print server migration, you can work around the failure. Using policy settings, you can isolate print drivers in separate processes so that print driver failures will not cause the Print Spooler service to fail—which allows the restoration to continue.  
  
##### To turn on print driver isolation using Group Policy  
  
1.  Open the Group Policy Management Console. Right\-click a [!INCLUDE[gpo](../Token/gpo_md.md)] with the necessary scope, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration**, expand the **Administrative Templates** folder, and then expand the **Printers** folder.  
  
3.  Double\-click **Execute print drivers in isolated processes**.  
  
4.  Click **Enabled**, and then click **OK**.  
  
5.  Double\-click **Override print driver execution compatibility setting reported by print driver**.  
  
6.  Click **Enabled**, and then click **OK**.  
  
7.  At a command prompt, type **gpupdate \/force** to reapply Group Policy settings.  
  
## Additional references  
  
-   [Install, Deploy, and Migrate to Windows Server 2012](http://technet.microsoft.com/library/hh831620.aspx)  
  
-   [Windows PowerShell Blog](http://go.microsoft.com/fwlink/?LinkId=128557) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128557\)  
  
## See Also  
[Migrate Print and Document Services to Windows Server 2012](../Topic/Migrate-Print-and-Document-Services-to-Windows-Server-2012.md)  
[Preparing to Migrate](../Topic/Preparing-to-Migrate.md)  
[Migrating the Print and Document Services Role](../Topic/Migrating-the-Print-and-Document-Services-Role.md)  
[Verifying the Migration](../Topic/Verifying-the-Migration.md)  
[Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md)  
[Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
