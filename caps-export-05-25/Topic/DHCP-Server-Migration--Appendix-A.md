---
title: DHCP Server Migration: Appendix A
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb0b8211-2446-4d5f-a962-04aca8d3328a
---
# DHCP Server Migration: Appendix A
  
## Migration tools  
Migration tools are provided in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]. The tools for earlier versions of the Windows operating system are also available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Follow these steps to access the tools on the destination server:  
  
1.  Open Server Manager.  
  
2.  Click **Action**, and then select **Add Features**. The Add Features Wizard opens.  
  
3.  On the **Select Features** page, from the **Features** list, select **Windows Server Migration Tools**, and then click **Next**.  
  
4.  Complete the steps in the wizard, and then click **Close**.  
  
The previous steps do not work for Server Core installations. To install the migration tools on a Server Core installation, see the Install Windows Server Migration Tools topic in [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
### Installing and using Windows PowerShell with migration cmdlets  
To access, download, and install migration tools \(the migration toolkit\), any role\-specific tools, and Windows PowerShell, see [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
### Known issues  
If the DHCP installation on the source server has a database path that varies from the default, before you perform the import, provide the destination server with a volume with the same drive letter on which the DHCP server database exists on the source server. For example, if the DHCP server database on the source server is located on D:\\, then the destination server should have a volume with the driver letter D.  
  
If you cannot match the volume on the destination server that has the same driver letter as that shown for the source DHCP server database, then the DHCP database path on the source server must be changed back to the default path \(%systemroot%\\system32\\dhcp\) before you start the migration.  
  
## See also  
[Migrate DHCP Server to Windows Server 2012 R2](../Topic/Migrate-DHCP-Server-to-Windows-Server-2012-R2.md)  
  
[DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md)  
  
[DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md)  
  
[DHCP Server Migration: Verifying the Migration](../Topic/DHCP-Server-Migration--Verifying-the-Migration.md)  
  
[DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md)  
  
