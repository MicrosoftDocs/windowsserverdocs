---
title: Migrate Failover on Windows Server 2012 to 2012 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ee23575d-c3b0-4c90-84ca-5efa61ad7946
---
# Migrate Failover on Windows Server 2012 to 2012 R2
Use the following procedures to migrate an existing DHCP failover deployment on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. When you have completed the procedures in this topic, return to the parent checklist: [Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md).  
  
> [!NOTE]  
> Use the following procedures to migrate an existing DHCP failover deployment on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to use two new DHCP servers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The following procedures do not describe an in\-place upgrade of the DHCP server’s operating system.  
  
The following table lists example DHCP server host names used in the procedures described in this topic:  
  
|Host name|Information|  
|-------------|---------------|  
|**DHCP2012\-1**|The DHCP server that will initially remain online with active scopes while a new DHCP failover partner server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is made available.|  
|**DHCP2012\-2**|The initial DHCP failover partner server for DHCP2012\-1. DHCP2012\-2 is removed from the DHCP failover relationship at the beginning of the procedure and taken offline.|  
|**DHCP2012R2\-1**|The DHCP server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that will replace DHCP2012\-1.|  
|**DHCP2012R2\-2**|The DHCP server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that will replace DHCP2012\-2.|  
  
## <a name="cluster"></a>Migrate an existing DHCP failover deployment  
Migration of a DHCP failover deployment on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] consists of the following steps:  
  
1.  [Install the DHCP Server role on DHCP2012R2\-2 and DHCP2012R2\-1](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#install)  
  
2.  [Delete the failover relationship between DHCP2012\-1 and DHCP2012\-2](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#del_1)  
  
3.  [Export DHCP settings from DHCP2012\-1](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#export)  
  
4.  [Import DHCP settings to DHCP2012R2\-1 and DHCP2012R2\-2](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#import1)  
  
5.  [Configure DHCP failover between DHCP2012\-1 and DHCP2012R2\-1](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#configure)  
  
6.  [Delete the DHCP failover relationship on DHCP2012R2\-1](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#configure2)  
  
7.  [Configure DHCP failover between DHCP2012R2\-1 and DHCP2012R2\-2](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#configure2a)  
  
8.  [Update DHCP relay agents and complete migration](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#relay)  
  
### <a name="install"></a>Install the DHCP Server role on DHCP2012R2\-1 and DHCP2012R2\-1  
You can install the DHCP server role using the command line or with the DHCP console.  
  
1.  [To install the DHCP server role using the command line](../Topic/Migrate-to-DHCP-Failover.md#role_cmd)  
  
2.  [To install the DHCP server role using the DHCP console](../Topic/Migrate-to-DHCP-Failover.md#role_ui)  
  
#### <a name="role_cmd"></a>To install the DHCP server role using the command line  
  
1.  At an elevated Windows PowerShell prompt on DHCP2012R2\-1 and DHCP2012R2\-2, type the following command, and press ENTER:  
  
    ```  
    Add-WindowsFeature –IncludeManagementTools Dhcp  
    ```  
  
2.  Verify that **True** is displayed under **Success**.  
  
3.  Type the following command and then press ENTER:  
  
    ```  
    Add-DhcpServerSecurityGroup  
    ```  
  
4.  Type the following command and then press ENTER:  
  
    ```  
    Add-DhcpServerInDC DHCP2012R2-1 192.168.0.5  
    ```  
  
5.  At this point, you can launch the DHCP console and see that the DHCP server is authorized in Active Directory. However, Server Manager might still contain an alert that post\-deployment configuration is required. To remove this alert from Server Manager, you can click **Complete  DHCP configuration** and follow the steps in the DHCP Post\-Install configuration wizard, or you can type the following command and press ENTER:  
  
    ```  
    Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2  
    ```  
  
6.  Refresh the view in Server Manager and verify that the DHCP post\-deployment configuration alert is no longer displayed.  
  
#### <a name="role_ui"></a>To install the DHCP server role using the DHCP console  
  
1.  In Server Manager on DHCP2012R2\-1, click **Add roles and features**.  
  
2.  Click **Next** three times, and then on the **Select server roles** page, select the **DHCP Server** checkbox.  
  
3.  Click **Add Features** in the popup that appears.  
  
4.  Click **Next** three times, and then on the **Confirm installation selections** page, click **Install**.  
  
5.  Confirm that **Installation succeeded…** is displayed and then click **Close**.  
  
6.  Click the alert flag in Server Manager and then click **Complete DHCP configuration**.  
  
7.  Click **Next**, provide credentials to authorize the server in Active Directory, and then click **Commit**.  
  
8.  Verify that authorization was successful and then click **Close**.  
  
### <a name="del_1"></a>Delete the failover relationship between DHCP2012\-1 and DHCP2012\-2  
You can delete the failover relationship using the command line or with the DHCP console.  
  
> [!WARNING]  
> Deleting a failover relationship will remove all scopes that are members of the failover relationship from the partner DHCP server.  
  
1.  [To delete the failover relationship using the command line](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#role_cmd2)  
  
2.  [To delete the failover relationship using the DHCP console](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#role_ui2)  
  
#### <a name="role_cmd2"></a>To delete the failover relationship using the command line  
  
1.  At an elevated Windows PowerShell prompt on DHCP2012\-1, type the following command, and press ENTER:  
  
    ```  
    Remove-DhcpServerv4Failover –Name DHCP2012-1-DHCP2012-2  
    ```  
  
    In the previous procedure, replace *DHCP2012\-1\-DHCP2012\-2* with the name of the DHCP failover relationship you wish to delete.  
  
2.  Type the following command and then press ENTER:  
  
    ```  
    Get-DhcpServerv4Failover  
    ```  
  
    Verify that the DHCP failover relationship name is not displayed in the command output, indicating that it has been successfully deleted.  
  
Note: DHCP scopes that were added to the failover relationship will be removed from the partner DHCP server. Scopes will remain on the server where you entered the Remove\-DhcpServerv4Failover command \(DHCP2012\-1 in this procedure\).  
  
#### <a name="role_ui2"></a>To delete the failover relationship using the DHCP console  
  
1.  In the DHCP console on DHCP2012\-1, right\-click **IPv4** and then click the **Failover** tab.  
  
2.  Click **DHCP2012\-1\-DHCP2012\-2** and then click **Delete**.  
  
3.  In the Delete Failover Relationship dialog box, click **OK**, confirm that deletion was successful, and then click **Close**.  
  
4.  Click **OK** to close the IPv4 properties window.  
  
Note: DHCP scopes that were added to the failover relationship will be removed from the partner DHCP server. Scopes will remain on the server used to delete the failover relationship \(DHCP2012\-1 in this procedure\).  
  
### <a name="export"></a>Export DHCP settings from DHCP2012\-1  
Use the following procedure to export server level settings from the DHCP server that has scopes you wish to enable for DHCP failover \(DHCP2012\-1 in this procedure\) in preparation for import to your new DHCP servers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] \(DHCP2012R2\-2 and DHCP2012R2\-1\).  Only the DHCP server level configuration will be exported and imported because the lease database will be replicated from DHCP2012\-1 to DHCP2012R2\-2 when the failover relationship is established.  
  
> [!NOTE]  
> If you are using clustered DHCP, you only need to export DHCP settings from the active node.  
  
##### To export DHCP settings from DHCP2012\-1  
  
1.  On DHCP2012R2\-2 and DHCP2012R2\-1, open an elevated Windows PowerShell prompt, type the following commands, and then press ENTER:  
  
    ```  
    mkdir C:\export  
    mkdir C:\backup  
    Export-DhcpServer –ComputerName DHCP2012-1 –File C:\export\DHCP2012-1exp.xml -Verbose  
    ```  
  
    > [!IMPORTANT]  
    > Note that DHCP configuration settings are being exported from a remote DHCP server \(DHCP2012\-1\) to a file on the local server \(DHCP2012R2\-1 and DHCP2012R2\-1\). Alternatively, you can export to a file on DHCP2012\-1 and then copy the settings file over the network to DHCP2012R2\-2 and DHCP2012R2\-1.  
  
### <a name="import1"></a>Import DHCP settings to DHCP2012R2\-1 and DHCP2012R2\-2  
The following procedure assumes DHCP settings are saved in the **C:\\export\\DHCP2012\-1exp.xml** file on a DHCP server with a host name of **DHCP2012R2\-1**. Replace the file and host names with names used in your environment. Do not repeat this procedure on DHCP2012R2\-2.  
  
##### To import DHCP settings and leases to DHCP2012R2\-1  
  
1.  At an elevated Windows PowerShell prompt, type the following commands and press ENTER:  
  
    ```  
    Import-DhcpServer –ComputerName DHCP2012R2-1 –File C:\export\DHCP2012-1exp.xml -BackupPath C:\backup\ -ServerConfigOnly -Verbose -Force  
    ```  
  
    > [!NOTE]  
    > The **–BackupPath** parameter is used to specify a path where the current DHCP server’s database is backed up prior to making any configuration changes as part of the import operation. To roll back the import operation, use the **Restore\-DhcpServer** cmdlet and specify **C:\\backup** for the value of the **\-Path** parameter. For more information, see [Restore\-DHCPServer](http://technet.microsoft.com/library/jj553822.aspx).  
  
This command imports only the server\-level configuration of DHCP2012\-1 to DHCP2012R2\-1. Server\-level settings include the following:  
  
-   Custom vendor classes and user classes  
  
-   Custom option definitions  
  
-   Server\-level option values  
  
-   Server\-level policies  
  
-   MAC address filters  
  
-   Custom conflict detection settings  
  
These server\-level settings must also be imported to the new DHCP failover partner server \(DHCP2012R2\-2\) with the same procedure, also provided below.  
  
> [!IMPORTANT]  
> Verify that options and settings on DHCP2012R2\-1 are correct before proceeding.  
  
##### To import DHCP settings to DHCP2012R2\-2  
  
1.  At an elevated Windows PowerShell prompt, type the following commands and press ENTER:  
  
    ```  
    Import-DhcpServer –ComputerName DHCP2012R2-2 –File C:\export\DHCP2012-1exp.xml -BackupPath C:\backup\ -ServerConfigOnly -Verbose -Force  
    ```  
  
### <a name="configure"></a>Configure DHCP failover between DHCP2012\-1 and DHCP2012R2\-1  
Next, configure DHCP failover for all desired scopes on DHCP2012\-1, specifying DHCP2012R2\-1 as the failover partner server. For procedures to configure DHCP failover, see [Configure DHCP Failover using the Command Line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md) or [Configure DHCP Failover using the DHCP Console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md). This will replicate scopes and leases to DHCP2012R2\-1 in preparation for taking DHCP2012\-1 offline.  
  
> [!NOTE]  
> Links to the procedures for configuring DHCP failover are provided in this section instead of steps so that these same steps are not duplicated in multiple topics. Procedures are provided to configure DHCP failover in hot standby or load balance mode using Windows PowerShell or the DHCP console.  
  
### <a name="configure2"></a>Delete the DHCP failover relationship on DHCP2012R2\-1  
Next, delete the DHCP failover relationship on DHCP2012R2\-1.  
  
1.  [To delete the failover relationship using the command line](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#role_cmd1)  
  
2.  [To delete the failover relationship using the DHCP console](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md#role_ui22)  
  
#### <a name="role_cmd1"></a>To delete the failover relationship using the command line  
  
1.  At an elevated Windows PowerShell prompt on DHCP2012R2\-1, type the following command, and press ENTER:  
  
    ```  
    Remove-DhcpServerv4Failover –Name DHCP2012-1-DHCP2012R2-1  
    ```  
  
    In the previous procedure, replace *DHCP2012\-1\-DHCP2012R2\-1* with the name of the DHCP failover relationship you created in the previous procedure.  
  
2.  Type the following command and then press ENTER:  
  
    ```  
    Get-DhcpServerv4Failover  
    ```  
  
    Verify that the DHCP failover relationship name is not displayed in the command output, indicating that it has been successfully deleted.  
  
Note: DHCP scopes that were added to the failover relationship will be removed from the partner DHCP server. Scopes will remain on the server where you entered the Remove\-DhcpServerv4Failover command \(DHCP2012R2\-1 in this procedure\).  
  
#### <a name="role_ui22"></a>To delete the failover relationship using the DHCP console  
  
1.  In the DHCP console on DHCP2012R2\-1, right\-click **IPv4** and then click the **Failover** tab.  
  
2.  Click **DHCP2012\-1\-DHCP2012R2\-1** and then click **Delete**.  
  
3.  In the Delete Failover Relationship dialog box, click **OK**, confirm that deletion was successful, and then click **Close**.  
  
4.  Click **OK** to close the IPv4 properties window.  
  
Note: DHCP scopes that were added to the failover relationship will be removed from the partner DHCP server. Scopes will remain on the server used to delete the failover relationship \(DHCP2012R2\-1 in this procedure\).  
  
### <a name="configure2a"></a>Configure DHCP failover between DHCP2012R2\-1 and DHCP2012R2\-2  
Next, configure DHCP failover for all desired scopes on DHCP2012R2\-1, specifying DHCP2012R2\-2 as the failover partner server. For procedures to configure DHCP failover, see [Configure DHCP Failover using the Command Line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md) or [Configure DHCP Failover using the DHCP Console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md). This will replicate scopes and leases to DHCP2012R2\-2.  
  
> [!NOTE]  
> Links to the procedures for configuring DHCP failover are provided in this section instead of steps so that these same steps are not duplicated in multiple topics. Procedures are provided to configure DHCP failover in hot standby or load balance mode using Windows PowerShell or the DHCP console.  
  
### <a name="relay"></a>Update DHCP relay agents and complete migration  
Finally, update DHCP relay agents to use the new DHCP servers and complete DHCP migration. For more information about relay agents and DHCP failover, see [DHCP Failover Architecture](../Topic/DHCP-Failover-Architecture.md).  
  
After leases and settings have been replicated to DHCP2012R2\-1 and DHCP2012R2\-2, settings are verified, and DHCP relays are updated, you can stop the DHCP Server service on DHCP2012\-1 and DHCP2012\-2 so that new DHCP leases are only issued from DHCP2012R2\-1 or DHCP2012R2\-2.  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
[DHCP Failover Requirements](../Topic/DHCP-Failover-Requirements.md)  
  
