---
title: DHCP Server Migration: Preparing to Migrate
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6e052060-f473-481c-9ef3-e4fca899420e
---
# DHCP Server Migration: Preparing to Migrate
Complete the following procedures before you migrate a DHCP Server from an x86\-based or x64\-based server to an x64\-based server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   [Migration planning](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md#BKMK_Migrationprerequisites)  
  
-   [Install migration tools](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md#BKMK_Install)  
  
-   [Prepare the destination server](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md#BKMK_Preparingthedestinationserver)  
  
-   [Prepare the source server](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md#BKMK_Preparingthesourceserver)  
  
## <a name="BKMK_Migrationprerequisites"></a>Migration planning  
Membership in **Domain Administrators**, or equivalent, is the minimum required to complete these procedures. Review details about how to use the appropriate accounts and group memberships at [Run a program with administrative credentials](http://go.microsoft.com/fwlink/?LinkId=131210) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131210\).  
  
##### To prepare for migration  
  
-   Identify your DHCP Server source and destination servers.  
  
-   Determine the domain, server name, and passwords on the source server. To identify the domain of the original server, click **Start**, right\-click **Computer**, and then click **Properties**.  
  
-   If you have not already done so, install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the destination and source servers as instructed in [Install migration tools](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md#BKMK_Install).  
  
-   Before migration, install all critical updates and service packs on the source server that were released before [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It is a recommended best practice that all current critical updates and service packs are installed on both the source and the destination servers.  
  
-   Count the number of network adapters in the source and destination servers and make sure that they are equal in number. If the source server that is running DHCP Server has multiple network adapters and the DHCP Server service is bound to all and serving IP addresses on different subnets, the destination server that is running DHCP Server must also have multiple network adapters so that it can serve the same subnets as on the source server.  
  
-   Prepare a migration store file location. The store location must be accessible from the source server during the export and from the destination server during the import. Use a common drive that can contain all DHCP Server–related information from the source server. The storage location should be similar to the following: \\\\fileserver\\users\\username\\.  
  
> [!IMPORTANT]  
> Before you run the **Import\-SmigServerSetting**, **Export\-SmigServerSetting**, or **Get\-SmigServerFeature** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with domain users or groups who are members of local groups on the source server.  
>   
> Before you run the **Send\-SmigServerData** or **Receive\-SmigServerData** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with those domain users who own files or shares that are being migrated.  
  
## <a name="BKMK_Install"></a>Install migration tools  
Install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the destination and source servers. For more information, see [Install, Use, and Remove Windows Server Migration Tools](http://technet.microsoft.com/library/jj134202.aspx) \(http:\/\/technet.microsoft.com\/library\/jj134202.aspx\).  
  
## Working with Windows PowerShell cmdlets  
Cmdlets \(pronounced *command\-lets*\) are built\-in commands, installed by default when you install role services and features in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Throughout this guide, there are several PowerShell cmdlets that you will have to run to carry out some of the migration steps. For more information about Windows PowerShell, see [Windows PowerShell Support for Windows Server](http://technet.microsoft.com/library/hh801904.aspx) on the Microsoft Web site \(http:\/\/technet.microsoft.com\/library\/hh801904.aspx\).  
  
Except where specifically noted, cmdlets are not case\-sensitive.  
  
You can obtain detailed Help about specific syntax, parameters, and usage guidelines for any installed cmdlet by typing **Get\-Help** <cmdlet name> **\-full** in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, in which *cmdlet name* represents the name of the cmdlet for which you want help. Add the **\-Verbose** parameter to a cmdlet to display detailed information about the operation in the Windows PowerShell session.  
  
Although most commands for DHCP Server migration are cmdlets, you can run executable files in a session by adding an ampersand \(&\) before the executable file name. The ampersand is the call operator.  
  
If the executable file is not in the current directory, add the fully qualified path, as shown in the following examples. If an executable file name contains spaces enclose the file name in quotation marks. If you are running the executable file from the current directory, precede the file name with **.\\**.  
  
-   Executable file that is not in the current directory: `PS C:\> & C:\Windows\System32\notepad.exe`  
  
-   Executable file that is in the current directory: `PS C:\Windows\System32> & .\notepad.exe`  
  
-   Executable file name that contains a space and is in the current directory: `PS C:\Windows\System32> & ".\executable test.exe"`  
  
The commands in this document are provided in Windows PowerShell format. For more information, see [DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md). You can run Command Prompt commands in a Windows PowerShell session by adding **cmd \/C** before the command, as shown in the following example. The example shows the use of the **dir** command in [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
```  
cmd /C dir c:\*  
```  
  
## <a name="BKMK_Preparingthedestinationserver"></a>Prepare the destination server  
To install DHCP Server on the destination server, complete the menu\-driven installation process. Complete the following procedure to prepare the destination server.  
  
#### <a name="BKMK_prepdest"></a>To prepare the destination server  
  
1.  Install [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and configure the destination server.  
  
2.  Make sure that there is sufficient disk space to store the DHCP Server database. The disk space needed varies with each installation and should be equal to or greater than the space for the DHCP Server database.  
  
3.  Add the destination server as a member server in the domain of the source server that is being replaced.  
  
4.  Verify that the destination server can resolve the names of domain users who are members of the local group during the import operation. If source and destination servers are in different domains, the destination server must be able to contact a global catalog server for the forest in which the source domain user accounts are located.  
  
5.  On a computer that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights. To do this, click **Start**, click **All Programs**, click **Accessories**, open the **Windows PowerShell** folder, right\-click **Windows PowerShell**, and then click **Run as administrator**.  
  
6.  Load the [!INCLUDE[rmt](../Token/rmt_md.md)] module into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load the [!INCLUDE[rmt](../Token/rmt_md.md)] module, type the following, and then press **Enter**.  
  
    ```  
    Import-Module ServerManager  
    ```  
  
    > [!NOTE]  
    > It is not mandatory that DHCP Server is installed on the destination server before you import the settings. If the role is not installed on the destination server, it will be installed automatically during the import process. However, because installation of the role during import might extend downtime, we recommend that you install DHCP Server by using the [!INCLUDE[rmt](../Token/rmt_md.md)] console on the destination server as part of your preparation for the migration.  
  
7.  On the destination server, run the following command to install DHCP Server:  
  
    ```  
    Add-WindowsFeature DHCP  
    ```  
  
    You can also install DHCP Server manually by using [!INCLUDE[rmt](../Token/rmt_md.md)]. For more information, see [Install Dynamic Host Configuration Protocol \(DHCP\)](http://go.microsoft.com/fwlink/?LinkId=128465) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128465\).  
  
    > [!NOTE]  
    > If you use the Add Roles Wizard in [!INCLUDE[rmt](../Token/rmt_md.md)] to install DHCP Server on the destination server, you do not have to answer every question in the wizard. You can leave settings empty \(the default\) and then click **Next** through each wizard page. If you do not want to use the wizard, you can install DHCP Server by using the **Add\-WindowsFeature** cmdlet, as described in this step.  
  
8.  By the end of the migration process, the destination server should have a static IP address. Although you will not change the destination server IP address now, consider the following scenarios in preparation for changing it when migration is complete.  
  
    -   If your migration scenario requires that you decommission and disconnect the source server from the network, only then can you make the IP address on the destination server the same as the IP address on the source server. The source server must be disconnected from the network or shut down so that there is no IP address conflict between the source server and destination server. However, the destination server can still serve clients that are searching for the legacy \(source\) server that was running DHCP Server.  
  
    -   If your migration scenario calls for continuing to run the source server on the network for other, non\-DHCP purposes, you have to assign the destination server an unallocated IP address in the same subnet as the source server to avoid IP conflicts.  
  
    -   DHCP Server clients that attempt to renew an IP address lease send the renew request to the previous IP address of the DHCP server. If the source server has been decommissioned and then disconnected from the network and the new DHCP destination server is operating with a different IP address, this request initially fails because of the changed IP address. However, clients try to rediscover the IP address of the DHCP server on the network and therefore recover from this transient failure.  
  
        > [!WARNING]  
        > If the source server is running multiple roles, renaming the source server or changing its IP address can cause other roles that are running on the source server to fail.  
  
9. If the DHCP Server database path does not match the default path, you must ensure that the destination server has a disk with the same drive letter as seen in source server’s DHCP Server database path. For more information, see the “Known issues” section of [DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md).  
  
The destination server is now prepared for migration.  
  
## <a name="BKMK_Preparingthesourceserver"></a>Prepare the source server  
Follow these steps to prepare the source server for migration.  
  
##### To prepare the source server  
  
1.  Back up the source server. The backup should be a DHCP Server\-specific backup, not a Windows backup. \(A Windows backup backs up the complete operating system.\) You can create the DHCP Server\-specific backup by using the **Netsh** command\-line tool or Microsoft Management Console \(MMC\).  
  
    -   In the DHCP MMC tree, right\-click the server node to open DHCP backup options.  
  
    -   Create the backup by using the **Netsh** command\-line tool. For more information, see [Netsh Commands for Dynamic Host Configuration Protocol server](http://go.microsoft.com/fwlink/?LinkId=128496) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128496\).  
  
    > [!NOTE]  
    > The Windows Server 2003 operating system does not support **Netsh**\-based backup.  
  
2.  If it is running, stop the DHCP Server service. In a session that was opened as described in step 5 of [To prepare the destination server](#BKMK_prepdest), type the following, and then press **Enter**.  
  
    ```  
    Stop-Service DHCPserver  
    ```  
  
3.  If the DHCP Server database path does not match the default path, make sure that the destination server has a disk with the same drive letter as in source server’s DHCP Server database path. For more information, see the “Known issues” section of [DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md).  
  
You are now ready to begin DHCP Server migration, as described in [DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md).  
  
## See also  
[Migrate DHCP Server to Windows Server 2012 R2](../Topic/Migrate-DHCP-Server-to-Windows-Server-2012-R2.md)  
  
[DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md)  
  
[DHCP Server Migration: Verifying the Migration](../Topic/DHCP-Server-Migration--Verifying-the-Migration.md)  
  
[DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md)  
  
[DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md)  
  
