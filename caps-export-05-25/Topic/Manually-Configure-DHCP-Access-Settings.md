---
title: Manually Configure DHCP Access Settings
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3030ef03-dbf2-4e34-82d1-0f19b24f4700
---
# Manually Configure DHCP Access Settings
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md) > [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md) | **Manually Configure DHCP Access Settings**  
  
If you have chosen the manual provisioning method, you must configure access permissions and settings individually on managed servers. Two general methods for configuring these settings are available:  
  
-   **Manual application of IPAM GPOs**: With this method, IPAM GPOs are created but are not automatically applied to managed servers. Application of GPOs is done manually by adding managed servers to GPO security filtering. To use this method, first perform the steps in [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md). When you have created these GPOS, configure security filtering by performing the steps in [Configuring IPAM GPO security filtering](../Topic/Create-IPAM-Provisioning-GPOs.md#security_filtering).  
  
-   **Manual configuration of individual settings**: GPOs are not used with this method. Instead, access settings on each managed server are configured manually by an administrator. Steps to configure these access settings are provided in this topic.  
  
For more information about choosing an IPAM provisioning method, see [Choosing a provisioning method](../Topic/Getting-Started-with-IPAM.md#choose_method).  
  
Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Manually configure managed DHCP server access settings  
Use the following procedures to configure IPAM access settings on a managed DHCP server:  
  
-   [Configure Windows Firewall on a managed DHCP server](../Topic/Manually-Configure-DHCP-Access-Settings.md#WFAS)  
  
-   [Configure security groups on a managed DHCP server](../Topic/Manually-Configure-DHCP-Access-Settings.md#security_groups)  
  
-   [Configure a DHCP audit share on a managed DHCP server](../Topic/Manually-Configure-DHCP-Access-Settings.md#audit)  
  
-   [Restart the DHCP Server service](../Topic/Manually-Configure-DHCP-Access-Settings.md#restart)  
  
A summary of required settings is provided in the table below.  
  
|Setting Type|Setting Name|Function|  
|----------------|----------------|------------|  
|Inbound firewall rule|DHCP Server Management|Access configuration data|  
|Inbound firewall rule|Remote Service Management|Access configuration data|  
|Inbound firewall rule|File and Printer Sharing|Access utilization data|  
|Inbound firewall rule|Remote Event Log Management|Access server logs|  
|Security group|DHCP Users|Access configuration data|  
|Security group|Event Log Readers|Access server event logs|  
|Network share|DHCP Audit|Access utilization data|  
  
## <a name="WFAS"></a>Configure Windows Firewall on a managed DHCP server  
Use the following procedure to enable access by the IPAM server to inbound firewall ports on a managed DHCP server. If the managed DHCP server becomes unmanaged, delete these inbound firewall rules. All of the following procedures are performed on the managed DHCP server.  
  
#### To configure Windows Firewall on a managed DHCP server  
  
1.  On the Server Manager menu, click **Tools** and then click **Windows Firewall with Advanced Security**.  
  
2.  Right\-click **Inbound Rules**, and then click **New Rule**. The **New Inbound Rule Wizard** will launch.  
  
3.  In **Rule Type**, select **Predefined**, choose **DHCP Server Management** from the list, and then click **Next**.  
  
4.  In **Predefined Rules**, under **Rules**, select the checkboxes next to the following rules:  
  
    -   **DHCP Server \(RPCSS\-In\)**  
  
    -   **DHCP Server \(RPC\-In\)**  
  
5.  Click **Next**, choose **Allow the connection**, and then click **Finish**.  
  
6.  Right\-click **Inbound Rules**, and then click **New Rule**. The **New Inbound Rule Wizard** will launch.  
  
7.  In **Rule Type**, select **Predefined**, choose **File and Printer Sharing** from the list, and then click **Next**.  
  
8.  In **Predefined Rules**, under **Rules**, select the checkboxes next to the following rules:  
  
    -   **File and Printer Sharing \(NB\-Session\-In\)**  
  
    -   **File and Printer Sharing \(SMB\-In\)**  
  
9. Click **Next**, choose **Allow the connection**, and then click **Finish**.  
  
10. Right\-click **Inbound Rules**, and then click **New Rule**. The **New Inbound Rule Wizard** will launch.  
  
11. In **Rule Type**, select **Predefined**, choose **Remote Event Log Management** from the list, and then click **Next**.  
  
12. In **Predefined Rules**, under **Rules**, select the checkboxes next to the following rules:  
  
    -   **Remote Event Log Management \(RPC\)**  
  
    -   **Remote Event Log Management \(RPC\-EPMAP\)**  
  
13. Click **Next**, choose **Allow the connection**, and then click **Finish**.  
  
14. Right\-click **Inbound Rules**, and then click **New Rule**. The **New Inbound Rule Wizard** will launch.  
  
15. In **Rule Type**, select **Predefined**, choose **Remote Service Management** from the list, and then click **Next**.  
  
16. In **Predefined Rules**, under **Rules**, select the checkboxes next to the following rules:  
  
    -   **Remote Service Management \(RPC\)**  
  
    -   **Remote Service Management \(RPC\-EPMAP\)**  
  
17. Click **Next**, choose **Allow the connection**, and then click **Finish**.  
  
18. Close the Windows Firewall with Advanced Security console.  
  
## <a name="security_groups"></a>Configure security groups on a managed DHCP server  
To access configuration data and server event logs, the IPAM server must be a member of the domain IPAM Users Group \(IPAMUG\). The IPAM server must also be a member of the local DHCP Users and Event Log Readers security groups.  
  
> [!IMPORTANT]  
> It is necessary to restart the DHCP service after changing security group memberships in order for these changes to become active.  
  
After performing these procedures, refresh the server access status for the managed DHCP server in the server inventory view on the IPAM server.  
  
#### To configure the IPAMUG security group  
  
1.  On a domain controller, click **Tools** on the Server Manager menu, and then click **Active Directory Users and Computers**.  
  
2.  In the Active Directory Users and Computers console tree, right\-click the **Users** container under the managed DHCP server’s domain, point to **New**, and then click **Group**.  
  
3.  In the **New Object – Group** dialog box, under **Group name**, type **IPAMUG**.  
  
4.  Under **Group scope**, select **Universal** and under **Group type** select **Security**, and then click **OK**.  
  
    ![](../Image/IPAM_ipamug.gif)  
  
5.  Double\-click the IPAMUG group and then click the **Members** tab.  
  
6.  Click **Object Types**, select the **Computers** checkbox, and then click **OK**.  
  
7.  Under **Enter the object names to select**, type the name of the IPAM server and then click **OK**.  
  
8.  Verify that the correct IPAM server is displayed under **Name** and then click **OK**.  
  
#### To configure the DHCP Users and Event Log Readers security groups  
  
1.  On the managed DHCP server, click **Tools** on the Server Manager menu and then click **Computer Management**.  
  
2.  In the Computer Management navigation tree, click **Local Users and Groups** and then click **Groups**.  
  
3.  In the list of groups, double\-click **DHCP Users** and then click **Add**.  
  
4.  Under **Enter the object names to select**, type **IPAMUG** and then click **OK**.  
  
5.  Verify that **<domain>\\IPAMUG** is displayed under **Members** and then click **OK**.  
  
6.  In the list of groups, double\-click **Event Log Readers** and then click **Add**.  
  
7.  Under **Enter the object names to select**, type **IPAMUG** and then click **OK**.  
  
8.  Verify that **<domain>\\IPAMUG** is displayed under **Members** and then click **OK**.  
  
9. Leave the Computer Management console open for the following procedure.  
  
## <a name="audit"></a>Configure a DHCP audit share on a managed DHCP server  
To audit IP address utilization, IPAM requires access to the DHCP database file located in the **windows\\system32\\dhcp** directory. The following procedure provides access to the DHCP database by creating a network share.  
  
#### To configure a DHCP audit share on a managed DHCP server  
  
1.  In the Computer Management navigation tree, click **Shared Folders** and then click **Shares**.  
  
2.  Right\-click **Shares** and then click **New Share**.  
  
3.  In the **Create A Shared Folder Wizard**, click **Next**.  
  
4.  Next to Folder Path, type the absolute path to the DHCP audit file location and then click **Next**. By default this is the **%windir%\\system32\\dhcp** directory, for example **C:\\windows\\system32\\dhcp**.  
  
5.  Next to **Share name**, type **dhcpaudit** and then click **Next**.  
  
6.  Under **Set the kind of permissions you want for the shared folder**, choose **Customize permissions** and then click **Custom**.  
  
7.  In the **Customize Permissions** dialog box, click **Everyone**, click **Remove**, and then click **Add**.  
  
8.  Under **Enter the object names to select**, type **IPAMUG** and then click **OK**.  
  
9. Verify that **IPAMUG** is displayed under **Group or user names**, and that **Read** is allowed under **Permissions for IPAMUG**, click **OK**, and then click **Finish** twice.  
  
    ![](../Image/IPAM_share.gif)  
  
> [!NOTE]  
> If the DHCP logs are stored in a different folder than **%windir%\\system32\\dhcp**, you must modify step 4 in the previous procedure to use this location. For example, clustered DHCP can define a unique DHCPAUDIT location for these files. The folder that must be shared is the folder that contains DhcpSrv\*.txt files that are generated by the DHCP server. The location of the DHCP audit log is defined in the Windows Registry by the value of the registry key: **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\DHCPServer\\Parameters\\DhcpLogFilePath**.  
  
## <a name="restart"></a>Restart the DHCP Server service  
To activate new security group memberships on the DHCP server, you must restart the DHCP Server service.  
  
#### To restart the DHCP Server service  
  
1.  In the Server Manager navigation pane, click **DHCP**.  
  
2.  Under **SERVICES**, right\-click the name of the managed DHCP server, and then click **Restart Services**.  
  
3.  To monitor status of the DHCP service, click the Server Manager notification flag. Verify that the service stops and starts successfully.  
  
## See Also  
[Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md)  
[Manually Configure DC and NPS Access Settings](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md)  
  
