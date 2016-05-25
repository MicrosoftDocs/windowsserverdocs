---
title: Migrate from Windows Internal Database to SQL Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d149b9a2-8aca-48f7-8387-bf9ee8383f73
author: britw
---
# Migrate from Windows Internal Database to SQL Server
This topic explains how to migrate the Windows Server Update Services \(WSUS\) database from a [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] instance \(installed by default during WSUS setup\) to a full version of Microsoft SQL Server.  
  
If you chose to use [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] as the WSUS database when you set up your WSUS server, you may want to upgrade the database to a full installation of SQL Server. SQL Server lets you administer the WSUS database through the SQL Server Management Studio.  
  
See the [WSUS database requirements](assetId:///e8f62aba-4c8d-410e-9012-e3c9680a929b#WSUSdb) section of the WSUS Deployment Guide for the complete list of requirements.  
  
> [!NOTE]  
> You cannot use SQL authentication. WSUS supports Windows authentication only.  
  
## Scenarios  
This topic presents two scenarios for migrating the [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] database to an instance of SQL Server:  
  
-   [Migrating the WSUS database if it is running on the WSUS server](../Topic/Migrate-from-Windows-Internal-Database-to-SQL-Server.md#bkmk_sqlonwsussvr)  
  
-   [Migrating the WSUS database and moving it to a remote SQL Server](../Topic/Migrate-from-Windows-Internal-Database-to-SQL-Server.md#bkmk_remoteserver)  
  
> [!WARNING]  
> The procedures in this document use Registry Editor. Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. We cannot guarantee that these problems can be resolved, so modify the registry at your own risk.  
  
> [!TIP]  
> Before you edit the registry, export the keys in the registry that you plan to edit, or back up the whole registry. If a problem occurs, you can then restore the registry to its previous state.  
  
### <a name="bkmk_sqlonwsussvr"></a>Migrating the WSUS database if it is running on the WSUS server  
Use the following steps to migrate the WSUS database from a [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] instance to an instance of SQL Server running on the WSUS server.  
  
##### To migrate the WSUS database  
  
1.  Install SQL Server by using the **Server and Client Tools** option on your WSUS server.  
  
2.  Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Services**.  
  
3.  Right\-click **IIS Admin Service**, and then click **Stop**.  
  
4.  Right\-click **Update Services**, and then click **Stop**.  
  
5.  Run the following SQL command to detach the WSUS database \(SUSDB\) from the [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] instance by using the **sqlcmd** utility. For more information about the **sqlcmd** utility, see [sqlcmd Utility](http://go.microsoft.com/fwlink/?LinkId=81183).  
  
    ```  
    sqlcmd -S np:\\.\pipe\MSSQL$MICROSOFT##SSEE\sql\query  
    use master  
    alter database SUSDB set single_user with rollback immediate  
    go  
    sp_detach_db SUSDB  
    go  
    ```  
  
6.  In [!INCLUDE[1st_ssMgmtStudio](../Token/1st_ssMgmtStudio_md.md)], under the **Instance**  node, right\-click **Databases**, select **Properties**, and then click **Attach**.  
  
7.  In this step, you will verify that NT AUTHORITY\\NETWORK SERVICE has login permissions to the instance of SQL Server and to the WSUS database. If it does not, you will have to add it to both locations. This account should also be a member of the **webService** role on the WSUS database.  
  
    -   To verify permissions on the instance of SQL Server, in [!INCLUDE[1st_ssMgmtStudio](../Token/1st_ssMgmtStudio_md.md)], open the instance, click **Security**, and then click **Logins**. The NT AUTHORITY\\NETWORK SERVICE account should be listed. If it is not, you need to add it.  
  
    -   To verify permissions on the database, right\-click the database, select **Properties**, and then click **Permissions**. The NT AUTHORITY\\NETWORK SERVICE account should be listed. If it is not, you need to add it.  
  
    -   To verify members of the webService role, under the WSUS database, click **Roles**, right\-click **webService**, and then click **Properties**. The NT AUTHORITY\\NETWORK SERVICE account should be listed as a member of this role. If it is not, you need to add it.  
  
8.  In the **Attach Databases** box, under **Databases to attach**, locate the susdb.mdf file \(by default, this is **C:\\WSUS\\UpdateServicesDbFiles** if you installed [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)]\), and then click **OK**.  
  
9. In this step, you will edit the registry to point WSUS to the instance of SQL Server that now holds the WSUS database and to recognize the new database for future WSUS updates. If you have not already done so, export the keys in the registry that you plan to edit or back up the whole registry.  
  
    1.  Click **Start**, click **Run**, type **regedit**, and then click **OK**.  
  
    2.  Locate the following key: **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\UpdateServices\\Server\\Setup\\SqlServerName**, in the **Value** text box, type **\[ServerName\]\\\[InstanceName\]**, and then click **OK**. If the instance name is the default instance, type **\[ServerName\]**.  
  
    3.  Find the following key: **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Update Services\\Server\\Setup\\wYukonInstalled**. In the **Value** text box, type **0**, and then click **OK**.  
  
10. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Services**.  
  
11. Right\-click **IIS Admin Service**, and then click **Start**.  
  
12. Right\-click **Update Services**, and then click **Start**.  
  
13. Verify that the database migration was successful by opening the WSUS administrative console. \(Click **Start**, click **Administrative Tools**, and then click **Microsoft Windows Server Update Services 3.0**.\)  
  
    > [!NOTE]  
    > You might have to restart the server for these settings to take effect.  
  
### <a name="bkmk_remoteserver"></a>Migrating the WSUS database to a remote SQL Server  
The goal of this scenario is to move and upgrade the WSUS database that is running in a [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] instance on the WSUS server to an instance of SQL Server that is running on a remote server.  
  
See the [Remote SQL Server installation](assetId:///e8f62aba-4c8d-410e-9012-e3c9680a929b#remoteSQLinstall) section of the Windows Server Update Services 3.0 SP2 Deployment Guide for more information about remote SQL Server installation, requirements, and limitations. Each step, where appropriate, indicates the server on which you perform the procedure.  
  
#### Prerequisites  
WSUS server starting configuration:  
  
-   [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)]  
  
Database server starting configuration:  
  
-   SQL Server  
  
##### To migrate the WSUS database to [!INCLUDE[sql2000](../Token/sql2000_md.md)] or [!INCLUDE[2nd_ssVersion2005](../Token/2nd_ssVersion2005_md.md)] with SP2 on a remote server  
  
1.  On the WSUS server: Install SQL Server by using the **Server and Client Tools** option. This step will enable you to use the SQL Server Enterprise Manager on the WSUS server.  
  
2.  On the WSUS server:  
  
    1.  Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Services**.  
  
    2.  Right\-click **IIS Admin Service**, and then click **Stop**.  
  
    3.  Right\-click **Update Services**, and then click **Stop**.  
  
3.  On the WSUS server: Run the following SQL command to detach the WSUS database by using the **sqlcmd** utility. For more information about the **sqlcmd** utility, see [sqlcmd Utility](http://go.microsoft.com/fwlink/?LinkId=81183).  
  
    ```  
    sqlcmd -S np:\\.\pipe\MSSQL$MICROSOFT##SSEE\sql\query   
    use master  
    alter database SUSDB set single_user with rollback immediate  
    go  
    sp_detach_db ‘SUSDB’  
    go  
    ```  
  
4.  On the WSUS server: Copy the **SUSDB.mdf** and **SUSDB\_log.ldf** files from the front\-end server to the back\-end server.  
  
5.  On the database server:  
  
    1.  To attach **SUSDB** to the destination instance of SQL server, under the **Instance** node, right\-click **Databases**, select **Properties**, and then click **Attach**.  
  
    2.  In the **Attach Databases** box, under **Databases to attach**, locate the **SUSDB.mdf** file \(by default this is **C:\\WSUS\\UpdateServicesDbFiles** if you installed [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)]\), and then click **OK**.  
  
6.  On the database server:  
  
    -   To verify permissions on the instance of SQL Server, in [!INCLUDE[1st_ssMgmtStudio](../Token/1st_ssMgmtStudio_md.md)], open the instance, click **Security**, and then click **Logins**. The WSUS server account should be listed. If it is not, you need to add it.  
  
    -   To verify permissions on the database, right\-click the database, select **Properties**, and then click **Permissions**. The WSUS server account should be listed. If the server account is not listed, you need to add it.  
  
    -   To verify members of the webService role, under the WSUS database, click **Roles**, right\-click **webService**, and then click **Properties**. The front\-end server account should be listed as a member of this role. If the server account is not listed, you need to add it.  
  
7.  On the WSUS server: In this step, you will edit the registry to point WSUS to the destination instance of SQL and to recognize the new database for future WSUS updates. If you have not already done so, export the keys in the registry that you plan to edit or back up the whole registry.  
  
    1.  Click **Start**, click **Run**, type **regedit**, and then click **OK**.  
  
    2.  Locate the following key: **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\UpdateServices\\Server\\Setup\\SqlServerName**. In the **Value** text box, type **\[BEName\]\\\[InstanceName\]**, and then click **OK**. If the instance name is the default instance, type **\[BEName\]**.  
  
        > [!NOTE]  
        > When typing \[BEName\], do not add the domain name before the name.  
  
    3.  Locate the following key: **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Update Services\\Server\\Setup\\wYukonInstalled**. In the **Value** text box, type **0**, and then click **OK**. This indicates that Windows Internal Database is not used.  
  
    4.  Locate the following key: **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\UpdateServices\\Server\\Setup\\SqlInstanceIsRemote**. In the **Value** text box, change the value to **1**, and then click **OK**.  
  
8.  On the WSUS server:  
  
    1.  Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Services**.  
  
    2.  Right\-click **IIS Admin Service**, and then click **Start**.  
  
    3.  Right\-click **Update Services**, and then click **Start**.  
  
9. On the WSUS server: Verify that the database migration was successful by opening the WSUS administrative console. \(Click **Start**, click **Administrative Tools**, and then click **Microsoft Windows Server Update Services 3.0**\).  
  
    > [!NOTE]  
    > You might have to restart the WSUS server for these settings to take effect.  
  
