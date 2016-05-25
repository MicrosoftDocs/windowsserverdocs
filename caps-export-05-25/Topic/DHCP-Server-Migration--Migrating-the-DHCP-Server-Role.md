---
title: DHCP Server Migration: Migrating the DHCP Server Role
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e3f55246-141c-45da-9a85-a49a2942d6ae
---
# DHCP Server Migration: Migrating the DHCP Server Role
Complete the following procedures to migrate a DHCP Server.  
  
-   [Migrating DHCP Server to the destination server](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md#BKMK_Sourcemachinemigrationsteps)  
  
-   [Migrating DHCP Server from the source server](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md#BKMK_Migratingsource)  
  
-   [Destination server final migration steps](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md#BKMK_Destinationfinal)  
  
## <a name="BKMK_Sourcemachinemigrationsteps"></a>Migrating DHCP Server to the destination server  
Membership in **Domain Administrators** or equivalent is the minimum required to complete these procedures. Review details about how to use the appropriate accounts and group memberships at [Run a program with administrative credentials](http://go.microsoft.com/fwlink/?LinkId=131210) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131210\).  
  
#### To migrate DHCP Server to the destination server  
  
1.  If it is not already installed, install DHCP Server on the destination server, as previously described in the “Prepare the destination server” section in [DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md).  
  
2.  If it is running, stop the DHCP Server service by running the following command:  
  
    ```  
    Stop-Service DHCPserver  
    ```  
  
    If you are unsure whether the service is running, you can check its state by running the following command:  
  
    ```  
    Get-Service DHCPServer  
    ```  
  
## <a name="BKMK_Migratingsource"></a>Migrating DHCP Server from the source server  
Follow these steps to migrate DHCP Server from the source server.  
  
#### To migrate DHCP Server from the source server  
  
1.  Open a Windows PowerShell session with elevated user rights. To do this, click **Start**, click **All Programs**, click **Accessories**, open the **Windows PowerShell** folder, right\-click **Windows PowerShell,** and then click **Run as administrator**.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your session.  
  
    If you opened the current session by using the [!INCLUDE[wsmt](../Token/wsmt_md.md)] shortcut on the **Start** menu, skip this step, and go to step 3. Only load the [!INCLUDE[wsmt](../Token/wsmt_md.md)] snap\-in in a session that was opened by using some other method, and into which the snap\-in has not already been loaded. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
3.  Collect data from the source server by running the **Export\-SmigServerSetting** cmdlet as an administrator. The **Export\-SmigServerSetting** cmdlet parameters can collect all source DHCP server data in a single file \(Svrmig.mig\). Or, the **Export\-SmigServerSetting** cmdlet can be run multiple times, with each iteration using one or more parameters to collect and store data in multiple Svrmig.mig files. For more information, see [DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md). Before you run this command, review the following:  
  
    -   When you run the command in step 4, you are prompted to provide a password to encrypt the migration store data. You must provide this same password to import from the migration store.  
  
    -   The **path** parameter can be an empty or nonempty directory. The actual data file in the directory \(Svrmig.mig\) is created by the **Export\-SmigServerSetting** cmdlet. Therefore, the user does not have to specify a file name.  
  
    -   If the path is not a shared location that the destination server can read from, you must manually copy the migration store to the destination server or a location that the destination server can access.  
  
    -   If a migration store location already exists and you want to rerun the **Export\-SmigServerSetting** cmdlet, you must move the Svrmig.mig file from that location and store it elsewhere, rename or first delete the migration store.  
  
    -   You can perform both IP and DHCP Server migration at the same time from a Windows PowerShell prompt by using the **Export\-SmigServerSetting** cmdlet combined with the **IPConfig** switch, on a single command line.  
  
    -   Additional command line parameter information:  
  
        -   **\-Users** and **\-Group** parameters  
  
            The **\-Users** parameter must be specified only if the DHCP Administrators group includes local users. Otherwise, you can use the **\-Group** parameter and all members of DHCP administrators will be migrated. Administrator group members can include domain users.  
  
            > [!IMPORTANT]  
            > If the source server is a domain controller, but the destination server is not, Domain Local groups are migrated as local groups, and domain users are migrated as local users.  
  
        -   The **\-IPConfig** parameter collects IP information when it is used with the **Export\-SmigServerSetting** cmdlet on the source server; the **\-IPConfig** parameter applies settings when the **Import\-SmigServerSetting** cmdlet is used on the destination server.  
  
            If the source DHCP Server has multiple network adapters and the DHCP server service is bound to more than one network adapter and serving IP addresses on different subnets, the destination DHCP Server must also have multiple network adapters so that it can serve the same subnets as the source DHCP Server. For more information, see [Migrate IP Configuration to Windows Server 2012](assetId:///60d15eb2-1b7c-4ad8-a03b-3f6e972b6235). Because IP configuration details will be used later when importing IP configuration settings to the destination server, it is a best practice to save the IP configuration settings by using the following command:  
  
            ```  
            IPConfig /all > IPSettings.txt  
            ```  
  
            The **Import\-SmigServerSetting** cmdlet requires you to map the source physical address to the destination physical address.  
  
        > [!NOTE]  
        > The destination server can be assigned the same static IP address as the source server, unless other roles on the source server must continue to run on it. In that case, the static IP address of the destination server can be any unallocated static IP address in the same subnet as the source server.  
  
4.  On the source server, run the **Export\-SmigServerSetting** cmdlet, where *<storepath>* is the path that will contain the Svrmig.mig file after this step is completed. An example of the path is \\\\fileserver\\users\\username\\dhcpstore.  
  
    ```  
    Export-SmigServerSetting -featureID DHCP -User All -Group -IPConfig -path <storepath> -Verbose  
    ```  
  
    For more information about how to export IP configuration settings, see [Migrate IP Configuration to Windows Server 2012](assetId:///60d15eb2-1b7c-4ad8-a03b-3f6e972b6235).  
  
5.  On the source server, delete the DHCP authorization for the source DHCP server by running the following command, where *Server FQDN* is the fully qualified domain name \(FQDN\) of the DHCP server and *Server IPAddress* is the IP address of the server. The command parameters are case\-sensitive and must appear exactly as shown.  
  
    ```  
    Netsh DHCP delete server <Server FQDN> <Server IPAddress>  
    ```  
  
## <a name="BKMK_Destinationfinal"></a>Destination server final migration steps  
Return to the destination server and follow these steps to complete the migration.  
  
1.  Before you use the **Import\-SmigServerSetting** cmdlet to import the DHCP server settings, be aware of the following conditions:  
  
    -   You can either use a single command line with all the parameters to import DHCP settings \(as when you export data from the source server\) or you can use the **Import** cmdlet multiple times to import data one parameter at a time.  
  
    -   If you decide to run the **Import\-SmigServerSetting** cmdlet separately to import the IP settings, see [Migrate IP Configuration to Windows Server 2012](assetId:///60d15eb2-1b7c-4ad8-a03b-3f6e972b6235). Use the source IPSettings.txt file, referred to in step 3 of the previous procedure. You will map the source physical addresses to the destination physical addresses in step 3 of this procedure.  
  
        > [!IMPORTANT]  
        > If you will be importing role and IP settings separately, you should import IP settings first to avoid any IP conflicts. You can then import the DHCP role.  
  
    -   If the DHCP Administrators group includes local users, then use the **\-Users** parameter combined with the **\-Group** parameter to import local users into the DHCP Administrators group. If it only contains domain users, then use only the **\-Group** parameter.  
  
        > [!IMPORTANT]  
        > If the source server is a domain member server, but the destination server is a domain controller, imported local users are elevated to domain users, and imported local groups become Domain Local groups on the destination server.  
  
    -   If the DHCP Server role that you are migrating has not yet been installed on the destination server, the **Import\-SmigServerSetting** cmdlet will install that DHCP Server role and its dependencies, described in the next step.  you might have to restart the destination computer to complete the installation after the DHCP Server role is installed by the cmdlet. Then, to complete the import operation after you restart the computer you must run the **Import\-SmigServerSetting** cmdlet again along with the **\-Force** parameter..  
  
2.  On the destination server, run the following command, where *<storepath>* is the available path that contains the Svrmig.mig file, *<SourcePhysicalAddress\-1>* and *<SourcePhysicalAddress\-2>* are comma\-separated lists of the physical addresses of the source network adapter, and *<TargetPhysicalAddress\-1>* and *<TargetPhysicalAddress\-2>* are comma\-separated lists of the physical addresses of the destination network adapter:  
  
    ```  
    Import-SmigServerSetting -featureid DHCP -User All -Group -IPConfig <All | Global | NIC>   
    -SourcePhysicalAddress <SourcePhysicalAddress-1>,<SourcePhysicalAddress-2>   
    -TargetPhysicalAddress <TargetPhysicalAddress-1>,<TargetPhysicalAddress-2>   
    -Force -path <storepath> -Verbose  
    ```  
  
    The **\-IPConfig** switch should be used with the value **All** in case the user wants to import all source settings. For more information, see [Migrate IP Configuration to Windows Server 2012](assetId:///60d15eb2-1b7c-4ad8-a03b-3f6e972b6235).  
  
    > [!IMPORTANT]  
    > If you import the source server IP address to the target server together with the DHCP role without disconnecting or changing the IP address of the source server, an IP address conflict will occur.  
  
3.  Run the following command to start the DHCP service:  
  
    ```  
    Start-Service DHCPServer  
    ```  
  
4.  Authorize the destination server. Command parameters are case\-sensitive and must appear exactly as shown. On the destination server, run the following command where *Server FQDN* is the FQDN of the DHCP Server and *Server IPAddress* is the IP address of the server:  
  
    ```  
    netsh DHCP add server <Server FQDN> <Server IPAddress>  
    ```  
  
> [!NOTE]  
> After authorization, the Server Manager event log might show event ID 1046. This is a known issue and is expected to occur only once. The event can be safely ignored.  
  
When this migration is finished, client computers on the network server are served by the new x64\-based destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The migration is complete when the destination server is ready to serve IP addresses to the network.  
  
## See also  
[Migrate DHCP Server to Windows Server 2012 R2](../Topic/Migrate-DHCP-Server-to-Windows-Server-2012-R2.md)  
  
[DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md)  
  
[DHCP Server Migration: Verifying the Migration](../Topic/DHCP-Server-Migration--Verifying-the-Migration.md)  
  
[DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md)  
  
[DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md)  
  
