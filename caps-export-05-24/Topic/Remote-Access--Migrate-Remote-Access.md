---
title: Remote Access: Migrate Remote Access
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb419c58-319c-4f47-8b3a-bc9904f87d45
---
# Remote Access: Migrate Remote Access
Complete the following procedures to migrate the Routing and Remote Access service from a source server to a destination server.  
  
-   [Migrating the Routing and Remote Access service from the source server](#bkmk_2)  
  
-   [Importing the settings to the destination server](#bkmk_3)  
  
-   [Completing the required manual migration steps](#bkmk_4)  
  
Membership in the local **Administrators** group or equivalent is the minimum required to complete these procedures. If User Account Control \(UAC\) is enabled, you might have to run the following steps by using the **Run as administrator** option. For more information, see [Run a program with administrative credentials](http://go.microsoft.com/fwlink/?LinkId=131210) in the Windows Server TechCenter \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131210\).  
  
## <a name="bkmk_2"></a>Migrating Remote Access from the source server  
Follow these steps to capture the configuration of Remote Access on the source server.  
  
#### To capture Remote Access configuration: Windows Server 2003, Windows Server 2008, Windows Server 2008 R2  
  
1.  On the source server, open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session.  
  
    > [!NOTE]  
    > If you opened the current [!INCLUDE[wps_2](../Token/wps_2_md.md)] session by using the [!INCLUDE[wsmt](../Token/wsmt_md.md)] shortcut on the **Start** menu, skip this step and go to the next step. You should only load the [!INCLUDE[wsmt](../Token/wsmt_md.md)] snap\-in in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that was opened by using another method, and into which the snap\-in has not already been loaded.  
  
    To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], run the following cmdlet:  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
3.  Remote Access can be running on the source server while you are capturing its configuration. However, if you made configuration changes to Remote Access that require a service restart, then you must stop Remote Access before starting the migration. Use the following PowerShell command to stop the service:  
  
    ```  
    stop-service remoteaccess -force  
    ```  
  
    > [!NOTE]  
    > You must use the `-force` parameter because Remote Access has dependent services.  
  
    To verify that the service is stopped, run the following command:  
  
    ```  
    get-service remoteaccess  
    ```  
  
4.  On the source server, from [!INCLUDE[wps_2](../Token/wps_2_md.md)], collect the settings from the source server by running the **Export\-SmigServerSetting** cmdlet as an administrator. The following is the syntax for the cmdlet:  
  
    ```  
    Export-SmigServerSetting -featureID NPAS-RRAS -User All -Group -path StorePath -verbose  
    ```  
  
    The **Export\-SmigServerSetting** cmdlet parameters can collect all Routing and Remote Access service settings on the source server in a single file \(Svrmig.mig\). Before you run this command, review the following:  
  
    -   When you run the **Export\-SmigServerSetting** command, you are prompted to provide a password to encrypt the migration store data. You must provide this same password when you later import from the migration store. Make sure you provide a strong password to encrypt the migration data and that the location of the migration data file is secure.  
  
    -   The *StorePath* variable that is provided as the value of the **path** parameter can be an empty or nonempty folder. The actual data file that is  placed in the folder \(Svrmig.mig\) is created by the **Export\-SmigServerSetting** cmdlet. Do not specify a file name. If a migration data file already exists and you want to rerun the **Export\-SmigServerSetting** cmdlet, you must first move the Svrmig.mig file from that location and store it elsewhere, rename it, or delete it.  
  
    -   If the path is not a shared location that the destination server can access, you must manually copy the migration store to the destination server or to a location that the destination server can access.  
  
    -   Migrating users and groups can be combined with the cmdlets that are used to migrate Remote Access. The **\-Users** and **\-Group** parameters can be used in the **Export\-SmigServerSetting** command to migrate the user and group accounts that are present locally on the Remote Access source server. If you are using an Active Directory domain or RADIUS for authentication, then these parameters are not needed.  
  
        The **\-Users** command supports the following parameters:  
  
        -   **All**. All user accounts on the source server are included in the migration output file.  
  
        -   **Enabled**. Only enabled user accounts on the source server are included in the migration output file.  
  
        -   **Disabled**. Only disabled user accounts on the source server are included in the migration output file.  
  
        To prevent migrating any user accounts, do not include the **\-Users** parameter in the command.  
  
        The **\-Group** command takes no additional parameters. If it is present, then all groups defined locally on the source server are included in the migration output file.  
  
    > [!NOTE]  
    > The process described in the Local User and Group Migration Guide does not migrate some settings, including those under the **Dial\-in** tab. We recommend that you thoroughly review the Local User and Group Migration Guide to understand which settings are migrated and which are not.  
  
#### To capture the Routing and Remote Access service configuration: Windows Server 2012  
  
1.  From the Start screen, click **Windows Server Migration Tools**.  
  
2.  > [!NOTE]  
    > This step is only required if Routing\/VPN is configured on the source computer.  
  
    Remote Access can be running on the source server while you are capturing its configuration. However, if you made configuration changes to Remote Access that require a service restart, then you must stop Remote Access before starting the migration. Use the following PowerShell command to stop the service:  
  
    ```  
    stop-service remoteaccess -force  
    ```  
  
    > [!NOTE]  
    > You must use the `-force` parameter because Remote Access has dependent services.  
  
    To verify that the service is stopped, run the following command:  
  
    ```  
    get-service remoteaccess  
    ```  
  
3.  Before you start to capture the configuration, you must stop the Remote Access Management service. Use the following PowerShell command to stop the service:  
  
    ```  
    stop-service Ramgmtsvc  
    ```  
  
    To verify that the service is stopped, run the following command:  
  
    ```  
    get-service Ramgmtsvc  
    ```  
  
    Once the export and migration are complete, you can restart the Remote Access Management service:  
  
    ```  
    start-service Ramgmtsvc  
    ```  
  
4.  On the source server, from [!INCLUDE[wps_2](../Token/wps_2_md.md)], collect the settings from the source server by running the **Export\-SmigServerSetting** cmdlet as an administrator. The following is the syntax for the cmdlet:  
  
    ```  
    Export-SmigServerSetting -featureID DirectAccess-VPN [-User All] -Group -path StorePath  
  
    ```  
  
    The **Export\-SmigServerSetting** cmdlet parameters can collect all Remote Access settings on the source server in a single file \(Svrmig.mig\). Before you run this command, review the following:  
  
    -   When you run the **Export\-SmigServerSetting** command, you are prompted to provide a password to encrypt the migration store data. You must provide this same password when you later import from the migration store. Make sure you provide a strong password to encrypt the migration data and that the location of the migration data file is secure.  
  
    -   The *StorePath* variable that is provided as the value of the **path** parameter can be an empty or nonempty folder. The actual data file that is  placed in the folder \(Svrmig.mig\) is created by the **Export\-SmigServerSetting** cmdlet. Do not specify a file name. If a migration data file already exists and you want to rerun the **Export\-SmigServerSetting** cmdlet, you must first move the Svrmig.mig file from that location and store it elsewhere, rename it, or delete it.  
  
    -   If the path is not a shared location that the destination server can access, you must manually copy the migration store to the destination server or to a location that the destination server can access.  
  
    -   Migrating users and groups can be combined with the cmdlets that are used to migrate Remote Access. The **\-Users** and **\-Group** parameters can be used in the **Export\-SmigServerSetting** command to migrate the user and group accounts that are present locally on the Remote Access source server. If you are using an Active Directory domain or RADIUS for authentication, then these parameters are not needed.  
  
        The **\-Users** command supports the following parameters:  
  
        -   **All**. All user accounts on the source server are included in the migration output file.  
  
        -   **Enabled**. Only enabled user accounts on the source server are included in the migration output file.  
  
        -   **Disabled**. Only disabled user accounts on the source server are included in the migration output file.  
  
        To prevent migrating any user accounts, do not include the **\-Users** parameter in the command.  
  
        The **\-Group** command takes no additional parameters. If it is present, then all groups defined locally on the source server are included in the migration output file.  
  
    > [!NOTE]  
    > The process described in the Local User and Group Migration Guide does not migrate some settings, including those under the **Dial\-in** tab. We recommend that you thoroughly review the Local User and Group Migration Guide to understand which settings are migrated and which are not.  
  
## <a name="bkmk_3"></a>Migrating Remote Access to the destination server  
Return to the destination server, and use the following procedure to complete the migration:  
  
#### To import the Routing and Remote Access service configuration to the destination server  
  
1.  Before you use the **Import\-SmigServerSetting** cmdlet to import the Routing and Remote Access service settings, be aware of the following condition:  
  
    -   If you chose to migrate the users and groups on the source computer, you need to specify the **\-User** and **\-Group** parameters in the **Import\-SmigServerSetting** cmdlet on the destination server.  
  
2.  On the destination Server that is running Windows Server 2012, from the Start screen, click **Windows Server Migration Tools**.  
  
3.  On the destination server, from [!INCLUDE[wps_2](../Token/wps_2_md.md)], run the following command, where *StorePath* is the folder that contains the Svrmig.mig file that you exported from the source server. Do not include the name of the file in the path.  
  
    ```  
    Import-SmigServerSetting -featureID DirectAccess-VPN [-User All] -Group -path StorePath –Force  
  
    ```  
  
    For more information about running the **Import\-SmigServerSetting** cmdlet, see the “Using Windows Server Migration Tools” section in the Windows Server Migration Tools [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md) guide.  
  
4.  > [!NOTE]  
    > This step is only required if Routing\/VPN is configured on the source computer.  
  
    Before starting the Remote Access service, you must manually stop the RASMAN service. Run the following command in the [!INCLUDE[wps_2](../Token/wps_2_md.md)] Command Prompt window:  
  
    ```  
    Stop-service -force rasman  
    ```  
  
5.  > [!NOTE]  
    > This step is only required if Routing\/VPN is configured on the source computer.  
  
    Then run the following command in the [!INCLUDE[wps_2](../Token/wps_2_md.md)] Command Prompt window to start the Routing and Remote Access service:  
  
    ```  
    Start-Service RemoteAccess  
    ```  
  
If a failure occurs while running the **Import\-SmigServerSetting** cmdlet, review the Setupact.log, Setuperr.log, and ServerMigration.log files under %localappdata%\\SvrMig\\Log. Information about how the Remote Access components migrated is included in the Servermigration.log file.  
  
After the script completes, review the following section and adjust any remaining settings that require manual configuration.  
  
## <a name="bkmk_4"></a>Completing the required manual migration steps  
Certain settings cannot be migrated by the Windows PowerShell scripts, and they must be configured manually on the destination server. Review the following configuration options, and apply those that are relevant to your environment.  
  
### DirectAccess  
To ensure that the destination server meets all DirectAccess requirements, run the following Windows PowerShell cmdlet: **Install\-remoteaccess –prerequisite**.  
  
### Dial\-up demand\-dial connections  
Because of the differences in modem hardware that might exist between the source and destination servers, dial\-up connections are not migrated. Use the Demand\-Dial Interface Wizard in the Remote Access MMC snap\-in.  
  
##### To create a dial\-up demand\-dial connection  
  
1.  If you are using Server Manager, in Tools click Routing and Remote Access.  
  
2.  Right\-click the server in the tree, and then click **Configure and Enable Routing and Remote Access**.  
  
3.  Follow the steps in the wizard to configure the connection.  
  
### Certificates for IKEv2, SSTP, and L2TP\/IPsec connections  
Certificates can be exported from the source server and imported to the destination server by using the Certificates MMC snap\-in.  
  
### Routing and Remote Access service policies and accounting settings  
If you are not using a local or remote server to run NPS, then default remote access policies and accounting settings are automatically created on the destination server when Remote Access is configured.  
  
To migrate NPS settings, refer to [Migrating Network Policy Server to Windows Server 2012](assetId:///a03f6f7f-7be3-4e96-8120-0fe8339fc15e).  
  
### PEAP, smart card, and other certificate settings on Network Policy Server  
If you also migrated a local or remote server running NPS to support the Remote Access server that you are migrating, we recommend that you verify that the server that is running NPS has the correct certificate configuration. Specifically, confirm that any certificates that are associated with Protected Extensible Authentication Protocol \(PEAP\) and the **Smart card or other certificate** authentication settings are set properly. You can find these settings on the server that is running NPS, in the NPS MMC snap\-in under **Connection Request Policies** or **Network Policies** \(depending on where the authentication protocols are configured\). If no certificates are present, or if the certificates are not configured correctly, perform the following steps:  
  
##### To reconfigure PEAP or smart card certificates  
  
1.  Remove the **PEAP** or **SmartCard or other certificate** methods from the list of authentication methods.  
  
2.  Add the method back to the list.  
  
3.  Reconfigure the certificate for the specified method.  
  
### Weak encryption settings  
In Windows Server 2003 weak encryption is enabled, but on later versions of Windows it is disabled by default. You can enable weak encryption only by modifying the registry. During migration from Windows Server 2003, the required registry settings are not created on the new server by the migration process, and they must manually be configured. For later versions of Windows, if these registry settings are present, they are migrated. For more information about the registry entries that Remote Access adds, see “Registry entries that Routing and Remote Access adds in Windows Server 2008”, [article 947054](http://go.microsoft.com/fwlink/?linkid=159112) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=159112\). The description of the settings for the weak encryption settings are at the end of the article, and they are named **AllowPPTPWeakCrypto** and **AllowL2TPWeakCrypto**.  
  
> [!IMPORTANT]  
> Weak encryption includes the use of 40\-bit or 56\-bit encryption in PPTP, and the use of MD5 or DES for L2TP\/IPsec. By default, these weak algorithms are disabled, and we recommend that you do not use them unless they are required.  
  
### Connection Manager profiles  
Profiles that are created by the Connection Manager Administration Kit \(CMAK\) can only be created on a computer with the same 32\-bit or 64\-bit architecture as the client computer on which they are to be run. If your source server is 64\-bit, and you have created 64\-bit profiles on that source server, you can copy them from the **%PROGRAMFILES%\\CMAK\\Profiles** folder to the appropriate folder on the destination server.  
  
If the source server is 32\-bit, you must use a computer running a 32\-bit version of Windows to create and manage the profiles. You can set up a computer running a 32\-bit version of [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or Windows 8, and then install CMAK on it to manage the profiles for your 32\-bit client computers. For more information, see [Connection Manager Administration Kit](http://go.microsoft.com/fwlink/?linkid=136440) in the Windows Server Technical Library \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=136440\).  
  
### Group forwarded fragments  
The **Group Forwarded Fragments** setting on NAT is enabled if the Remote Access server is deployed behind a NAT device that runs Windows. This is required for L2TP\/IPsec connections that are using computer certificate authentication to succeed. We recommend that you enable this setting. Group Forwarded Fragments can be enabled for IPv4 on the Windows NAT computer by running the following command at the command prompt:  
  
```  
netsh int ipv4 set global groupforwardfragments=enabled  
```  
  
### RAS administration and security DLLs  
Administration DLLs and security DLLs and their corresponding registry keys are not migrated. This is because they are available in both 32\-bit and 64\-bit versions, and they do not work in a 32\-bit to 64\-bit migration. If the source and destination computers are 64\-bit, the administration and security DLLs can be reused. For more information, refer to the following topics:  
  
[RAS Administration DLL](http://go.microsoft.com/fwlink/?linkid=163778) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=163778\)  
  
[RAS Security DLL](http://go.microsoft.com/fwlink/?linkid=163779) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=163779\)  
  
## See Also  
[Migrate Remote Access to Windows Server 2012](../Topic/Migrate-Remote-Access-to-Windows-Server-2012.md)  
[Remote Access: Prepare to Migrate](../Topic/Remote-Access--Prepare-to-Migrate.md)  
[Remote Access: Verify the Migration](../Topic/Remote-Access--Verify-the-Migration.md)  
[Remote Access: Post-migration Tasks](../Topic/Remote-Access--Post-migration-Tasks.md)  
  
