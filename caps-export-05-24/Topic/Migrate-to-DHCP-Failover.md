---
title: Migrate to DHCP Failover
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e6df7624-0a01-4ed5-8244-2db2c37ce7a9
---
# Migrate to DHCP Failover
Use the procedures in this topic to migrate from split\-scope or clustered DHCP to DHCP failover. When you have completed the procedures in this topic, return to the parent checklist: [Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md). To migrate an existing DHCP failover deployment on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [Migrate Failover on Windows Server 2012 to 2012 R2](../Topic/Migrate-Failover-on-Windows-Server-2012-to-2012-R2.md).  
  
The following table lists example DHCP server host names used in the procedures described in this topic:  
  
|Host name|Information|  
|-------------|---------------|  
|**DHCP2012\-1**|The DHCP server that will be used to initially configure DHCP failover.|  
|**DHCP2012\-2**|The DHCP failover partner server for DHCP2012\-1.|  
|**DHCP2008\-1**|The currently active DHCP server, providing 80% of the leases from a DHCP split\-scope, or serving as the active node in a clustered DHCP deployment. DHCP2008\-1 might also be the only DHCP server if no DHCP high availability configuration is currently deployed.|  
|**DHCP2008\-2**|The current DHCP server providing 20% of the leases from a DHCP split\-scope with DHCP2008\-1, or serving as the backup node for DHCP2008\-1 in a clustered DHCP deployment.|  
  
## <a name="cluster"></a>Migrate to DHCP failover  
Migration consists of the following steps:  
  
1.  [Install the DHCP Server role on DHCP2012\-1 and DHCP2012\-2](../Topic/Migrate-to-DHCP-Failover.md#install)  
  
2.  [Export DHCP settings and leases from DHCP2008\-1 and DHCP2008\-2](../Topic/Migrate-to-DHCP-Failover.md#export)  
  
3.  [Import DHCP settings and leases to DHCP2012\-1](../Topic/Migrate-to-DHCP-Failover.md#import1)  
  
4.  [Import server level settings to DHCP2012\-2](../Topic/Migrate-to-DHCP-Failover.md#import2)  
  
5.  [Configure DHCP failover on DHCP2012\-1](../Topic/Migrate-to-DHCP-Failover.md#configure)  
  
6.  [Update DHCP relay agents and complete migration](../Topic/Migrate-to-DHCP-Failover.md#relay)  
  
### <a name="install"></a>Install the DHCP Server role on DHCP2012\-1 and DHCP2012\-2  
You can install the DHCP server role using the command line or with the DHCP console.  
  
1.  [To install the DHCP server role using the command line](../Topic/Migrate-to-DHCP-Failover.md#role_cmd)  
  
2.  [To install the DHCP server role using the DHCP console](../Topic/Migrate-to-DHCP-Failover.md#role_ui)  
  
#### <a name="role_cmd"></a>To install the DHCP server role using the command line  
  
1.  At an elevated Windows PowerShell prompt, type the following command, and press ENTER:  
  
    ```  
    Add-WindowsFeature –IncludeManagementTools Dhcp  
    ```  
  
2.  Verify that **True** is displayed under **Success**.  
  
3.  Type the following command and then press ENTER:  
  
    ```  
    Netsh dhcp add securitygroups  
    ```  
  
    Verify that **Command completed successfully** is displayed.  
  
4.  Type the following command and then press ENTER:  
  
    ```  
    Add-DhcpServerInDC dhcp2012-1 192.168.0.5  
    ```  
  
5.  At this point, you can launch the DHCP console and see that the DHCP server is authorized in Active Directory. However, Server Manager might still contain an alert that post\-deployment configuration is required. To remove this alert from Server Manager, you can click **Complete  DHCP configuration** and follow the steps in the DHCP Post\-Install configuration wizard, or you can type the following command and press ENTER:  
  
    ```  
    Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2  
    ```  
  
6.  Refresh the view in Server Manager and verify that the DHCP post\-deployment configuration alert is no longer displayed.  
  
#### <a name="role_ui"></a>To install the DHCP server role using the DHCP console  
  
1.  In Server Manager, click **Add roles and features**.  
  
2.  Click **Next** three times, and then on the **Select server roles** page, select the **DHCP Server** checkbox.  
  
3.  Click **Add Features** in the popup that appears.  
  
4.  Click **Next** three times, and then on the **Confirm installation selections** page, click **Install**.  
  
5.  Confirm that **Installation succeeded…** is displayed and then click **Close**.  
  
6.  Click the alert flag in Server Manager and then click **Complete DHCP configuration**.  
  
7.  Click **Next**, provide credentials to authorize the server in Active Directory, and then click **Commit**.  
  
8.  Verify that authorization was successful and then click **Close**.  
  
### <a name="export"></a>Export DHCP settings and leases from DHCP2008\-1 and DHCP2008\-2  
If you are using clustered DHCP, you only need to export DHCP settings from DHCP2008\-1. Perform the following procedure for both DHCP2008\-1 and DHCP2008\-2 only if you are using a split\-scope design and need to replicate DHCP leases from both DHCP servers.  
  
> [!IMPORTANT]  
> You cannot import DHCP leases for the same scope from two different DHCP servers without first consolidating the exported files into a single file. You can also configure DHCP2008\-1 to issue 100% of the leases for a split\-scope and allow leases on DHCP2008\-2 to expire before performing the next procedure.  
>   
> Also see [Migrate split scope DHCP deployment to Windows Server 2012 DHCP Failover](http://gallery.technet.microsoft.com/scriptcenter/Migrate-Split-Scope-to-9791ddcd) in the Microsoft TechNet Script Center. This script automates procedures in this topic, including export and import of leases from your existing DHCP servers, and creation of a DHCP failover relationship on the new DHCP servers. The script does not handle all error conditions or perform automatic rollback if an error is encountered. This script is provided to demonstrate automation with Windows PowerShell for migration to DHCP failover in a test environment. It is not recommended for use in a production environment.  
  
##### To export DHCP settings and leases  
  
1.  On DHCP2012\-1, open an elevated Windows PowerShell prompt, type the following commands, and then press ENTER:  
  
    ```  
    mkdir C:\export  
    mkdir C:\backup  
    Export-DhcpServer –ComputerName DHCP2008-1 –Leases –File C:\export\DHCP2008-1exp.xml -Verbose  
    ```  
  
    Note that DHCP configuration settings and the lease database is being exported from a remote DHCP server to a file on the local server. Alternatively, you can export to a file on DHCP2008\-1 and then import settings over the network to DHCP2012\-1.  
  
2.  If needed, perform the export step again specifying a **Computername** of DHCP2008\-2 and exporting to the file **DHCP2008\-2exp.xml**. When you are finished, you should have one XML file for every DHCP server that has leases you wish to import to DHCP2012\-1.  
  
3.  If you have multiple files that contain leases for the same scope ID, these files must be consolidated before importing data to DHCP2012\-1.  
  
    ###### To consolidate the lease database  
  
    1.  At an elevated Windows PowerShell prompt, type the following commands and press ENTER:  
  
        ```  
        notepad C:\export\DHCP2008-1exp.xml  
        notepad C:\export\DHCP2008-2exp.xml  
        ```  
  
    2.  Determine which file will be the primary file to use for import. Copy information from the secondary file and paste this information into the primary file.  
  
    3.  Click the secondary file’s notepad window and type CTRL\-F to bring up the **Find** dialog box.  
  
    4.  Next to **Find what**, type **<Leases>** and then highlight all text that is between **<Leases>** and **<\/Leases>**. See the following example.  
  
        ![](../Image/DHCP_xml.gif)  
  
    5.  Type CTRL\-C to copy all the text from this file, or click **Edit** on the menu and then click **Copy**.  
  
    6.  Click the primary file’s notepad window and locate the Leases section by searching for **<Leases>**.  
  
    7.  Place the mouse cursor after the last <\/Lease> and before the <\/Leases> tag in this file and then type CTRL\-V or click **Edit** on the menu and then click **Paste**.  
  
    8.  Save the primary file by typing CTRL\-S or clicking **File** on the menu and then clicking **Save**.  
  
    When you have completed this procedure, all active leases will be consolidated in the **DHCP2008\-1exp.xml** file in preparation for import to DHCP2012\-1.  
  
### <a name="import1"></a>Import DHCP settings and leases to DHCP2012\-1  
Before you perform this procedure, verify that you have consolidated and saved leases and settings from your current DHCP servers in a file on the new DHCP server. The following procedure assumes DHCP settings and leases are saved in the **C:\\export\\DHCP2008\-1exp.xml** file on a DHCP server with a host name of **DHCP2012\-1**.  
  
##### To import DHCP settings and leases to DHCP2012\-1  
  
1.  At an elevated Windows PowerShell prompt, type the following commands and press ENTER:  
  
    ```  
    Import-DhcpServer –ComputerName DHCP2012-1 -Leases –File C:\export\DHCP2008-1exp.xml -BackupPath C:\backup\ -Verbose -Force  
    ```  
  
    > [!NOTE]  
    > The **–BackupPath** parameter is used to specify a path where the current DHCP server’s database is backed up prior to making any configuration changes as part of the import operation. To roll back the import operation, use the **Restore\-DhcpServer** cmdlet and specify **C:\\backup** for the value of the **\-Path** parameter. For more information, see [Restore\-DHCPServer](http://technet.microsoft.com/library/jj553822.aspx).  
  
In addition to leases, this command imports the server\-level configuration of DHCP2008\-1 to DHCP2012\-1. Server\-level settings include the following:  
  
-   Custom vendor classes and user classes  
  
-   Custom option definitions  
  
-   Server\-level option values  
  
-   Server\-level policies  
  
-   MAC address filters  
  
-   Custom conflict detection settings  
  
By default, all scopes will be imported. If a scope already exists on the destination server it will not be imported. To specify only some scopes for import, use the **–ScopeId** parameter. For example:  
  
```  
Import-DhcpServer –ComputerName DHCP2012-1 -Leases –File C:\export\DHCP2008-1exp.xml -BackupPath C:\backup\ -Verbose –ScopeId 10.1.1.0, 10.1.2.0 -Force  
```  
  
These server\-level settings must also be imported to the new DHCP failover partner server \(DHCP2012\-2\) with the following procedure.  
  
> [!IMPORTANT]  
> Verify that options and settings on DHCP2012\-1 are correct before proceeding. Options such as DNS servers, reservations, or filters also might need to be updated on DHCP2012\-1.  
  
### <a name="import2"></a>Import server level settings to DHCP2012\-2  
Use the following procedure to import server\-level settings from DHCP2008\-1 to the failover partner server DHCP2012\-2.  
  
##### To import server level settings to DHCP2012\-2  
  
1.  At an elevated Windows PowerShell prompt on DHCP2012\-2, type the following commands and press ENTER:  
  
    ```  
    mkdir C:\backup  
    Import-DhcpServer –ComputerName DHCP2012-2 –File C:\export\DHCP2008-1exp.xml -BackupPath C:\backup\ -Verbose -Force  
    ```  
  
The DHCP server’s database is backed up locally on the same server where the DHCP Server service is running even if you run the Import\-DhcpServer cmdlet remotely.  
  
### <a name="configure"></a>Configure DHCP failover on DHCP2012\-1  
Next, configure DHCP failover for some or all scopes on DHCP2012\-1, specifying DHCP2012\-2 as the failover partner server. For procedures to configure DHCP failover, see [Configure DHCP Failover using the Command Line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md) or [Configure DHCP Failover using the DHCP Console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md).  
  
> [!NOTE]  
> Links to the procedures for configuring DHCP failover are provided in this section instead of steps so that these same steps are not duplicated in multiple topics.  
  
### <a name="relay"></a>Update DHCP relay agents and complete migration  
Finally, update DHCP relay agents to use the new DHCP servers and complete DHCP migration. For more information about relay agents and DHCP failover, see [DHCP Failover Architecture](../Topic/DHCP-Failover-Architecture.md).  
  
After leases and settings have been imported to DHCP2012\-1 and DHCP2012\-2, settings are verified, and DHCP relays are updated, you can stop the DHCP Server service on DHCP2008\-1 and DHCP2008\-2 so that new DHCP leases are only issued from DHCP2012\-1 or DHCP2012\-2.  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
[DHCP Failover Requirements](../Topic/DHCP-Failover-Requirements.md)  
  
