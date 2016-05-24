---
title: Getting Started with IPAM
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 38e4074a-3caa-4eed-9b11-c4d77741bbdd
---
# Getting Started with IPAM
IPAM provides a dynamic view of your IP infrastructure, and the view is continually refreshed by periodic tasks that run on the IPAM server. IPAM also enables administrators to perform several configuration actions directly from the IPAM console.  
  
IPAM is not enabled by default and must be installed as a server feature. You can install IPAM using the **Add Roles and Features Wizard** in Server Manager, or using Windows PowerShell. For example, to install an IPAM server, type the following command at an elevated Windows PowerShell prompt and press ENTER:  
  
```  
Install-WindowsFeature IPAM -IncludeManagementTools  
```  
  
Some restrictions apply to installing IPAM. Do not attempt to install IPAM without first reviewing detailed step by step guidance in the [Deploy IPAM](../Topic/Deploy-IPAM.md).  
  
This topic summarizes how to begin using IPAM, and provides information about IPAM concepts and components.  
  
The following table summarizes steps to begin using IPAM after it has been successfully installed:  
  
|\#|Step|Summary|More Information|  
|------|--------|-----------|--------------------|  
|1.|Choose an IPAM server|Connect to an IPAM server using the IPAM client console.|[The IPAM Client](../Topic/Getting-Started-with-IPAM.md#ipam_client)|  
|2.|Specify the IPAM database|Use the IPAM provisioning wizard to specify SQL or Windows Internal Database for the IPAM database. This option is only available if the IPAM server is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or a later operating system.|[Specify the IPAM Database](../Topic/Specify-the-IPAM-Database.md)|  
|3.|Choose a provisioning method|Use the IPAM provisioning wizard to select one of two provisioning methods: GPO\-based \(automatic\) or manual.|[Provisioning IPAM](../Topic/Getting-Started-with-IPAM.md#provision)|  
|4.|Configure the scope of discovery|Choose one or more domains in the forest that contain servers you wish to manage with the selected IPAM server.|[Scope of discovery](../Topic/Getting-Started-with-IPAM.md#scope_of_discovery)|  
|5.|Start server discovery|Launch the server discovery task to retrieve a list of domain controllers, DNS servers, and DHCP servers from Active Directory.|[Discovering servers](../Topic/Getting-Started-with-IPAM.md#discoverying_servers)|  
|6.|Configure settings on managed servers|Enable IPAM access by creating and applying GPOs to configure managed server settings, or configure settings manually.|[Configuring managed server access settings](../Topic/Getting-Started-with-IPAM.md#configure_method)|  
|7.|Select manageability status on managed servers|Choose servers and role services to manage from the list of discovered servers displayed in the server inventory.|[Select managed servers](../Topic/Getting-Started-with-IPAM.md#select_managed_servers)|  
|8.|Verify IPAM access|Verify that the IPAM server has access to manage the selected services on managed servers.|[Verify managed server access](../Topic/Getting-Started-with-IPAM.md#verify_access)|  
|9.|Retrieve data from managed servers|Launch data collection tasks on the IPAM server to retrieve data from managed servers.|[Retrieve data](../Topic/Getting-Started-with-IPAM.md#retrieve)|  
|10.|Visualize data|Customize the IPAM client display to meet your needs.|[Using the IPAM Client Console](../Topic/Using-the-IPAM-Client-Console.md)|  
  
The relationship between different components of IPAM is illustrated below.  
  
![](../Image/IPAM_arch1.png)  
  
See the following topics for more information about IPAM components and processes:  
  
## <a name="ipam_client"></a>The IPAM Client  
The IPAM client console is integrated with Server Manager. IPAM Client is installed by default when you install IPAM Server on a computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. The client automatically connects to the local IPAM server after installation, but can also be used to manage a different IPAM server. You can also install IPAM Client on a computer running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)]. For more information about requirements for installing IPAM Client, see [IPAM Architecture](../Topic/IPAM-Architecture.md).  
  
After installing IPAM Client, you must add at least one IPAM server to manage using Server Manager. You can view the IPAM client console by clicking **IPAM** in the Server Manager navigation pane. An IPAM client computer can connect to any IPAM server that is available in the pool of servers managed by the Server Manager console. You cannot connect to multiple IPAM servers simultaneously. To manage an IPAM server, click **Connect to IPAM server** in the IPAM console overview pane. When a successful connection is made, the fully qualified domain name \(FQDN\) of the IPAM server with the current domain and user ID is displayed in the IPAM OVERVIEW pane.  
  
The IPAM client console provides administrators and users with multiple functions and custom views of IP address infrastructure services on the network. For more information about IPAM client console functionality, see [Using the IPAM Client Console](../Topic/Using-the-IPAM-Client-Console.md).  
  
## <a name="provision"></a>Provisioning IPAM  
In IPAM, provisioning is the process of enabling required permissions, files shares, and access settings so that the IPAM server can monitor and manage IP infrastructure servers \(called managed servers\) on the network. Provisioning has two steps:  
  
1.  Choose a provisioning method.  
  
2.  Configure managed server access settings.  
  
After choosing a provisioning method, you can begin discovering servers on the network. It is not required to configure managed server access settings prior to performing server discovery. However, you will not be able to monitor and manage servers until managed server access settings are applied. If you choose the automatic GPO\-based provisioning method, you can create these GPOs immediately. No settings are applied until a server is assigned a status of managed and Group Policy is updated.  
  
### <a name="choose_method"></a>Choosing a provisioning method  
To choose a provisioning method, click **Provision the IPAM server** in the IPAM console overview pane to launch the **Provision IPAM** wizard. The wizard allows you to choose either the manual or Group Policy based provisioning method. These provisioning methods are described below.  
  
1.  **Manual**: The manual provisioning method is typically used when the number of managed servers is small. If you choose the manual provisioning method, access settings must be configured individually on each managed server. Settings must also be removed manually if the server becomes unmanaged. You can use Group Policy to apply settings to managed servers even if the manual provisioning method is chosen, but you must apply and remove GPOs manually.  
  
    The manual provisioning method is not preferred because it is more complex and less consistent than the Group Policy based method.  
  
2.  **Group Policy Based**: The Group Policy based method is preferred because it is simpler and less prone to errors. If you choose the Group Policy based provisioning method, GPOs are applied automatically to servers when they are assigned a status of managed in the IPAM console. GPOs are also removed automatically if the status of a server changes from managed to unmanaged.  
  
    If you chose the Group Policy based method, you must also provide a GPO name prefix in the provisioning wizard. After providing a GPO name prefix, the wizard will display the GPO names that must be created in domains that will be managed by IPAM. The following role\-based GPOs are required in each domain that contains managed servers. The wizard does not create these GPOs.  
  
    -   **<GPO\-prefix>\_DHCP**: This GPO is used to apply settings that allow IPAM to monitor, manage, and collect information from managed DHCP servers on the network.  
  
    -   **<GPO\-prefix>\_DNS**: This GPO is used to apply settings that allow IPAM to monitor and collect information from managed DNS servers on the network.  
  
    -   **<GPO\-prefix>\_DC\_NPS**: This GPO is used to apply settings that allow IPAM to collect information from managed domain controllers and network policy servers \(NPS\) on the network for IP address tracking purposes.  
  
> [!IMPORTANT]  
> You cannot change the provisioning method for the current installation of IPAM Server after it has been selected. To change the provisioning method, you must uninstall and reinstall IPAM Server on the computer.  
  
The following figure illustrates choices for applying settings to managed servers.  
  
![](../Image/IPAM_provision1.png)  
  
### <a name="configure_method"></a>Configuring managed server access settings  
The next step in IPAM provisioning is to configure group memberships, file shares, service access settings, and firewall ports on managed servers.  
  
Depending on the provisioning method that was chosen, managed server access settings must either be configured individually on each managed server, or using IPAM provisioning Group Policy Objects \(GPOs\). The preferred method to create IPAM provisioning GPOs is with Windows PowerShell using the **Invoke\-IpamGpoProvisioning** cmdlet. To create IPAM provisioning GPOs, you must have permission to configure Group Policy in the domain.  
  
See the following example of how the **Invoke\-IpamGpoProvisioning** cmdlet can be used to create IPAM provisioning GPOs. In this example, three GPOs are created \(IPAM1\_DHCP, IPAM1\_DNS, IPAM1\_DC\_NPS\) and linked to the contoso.com domain. These GPOs enable access for the server **ipam1.contoso.com** using the domain administrator account **user1**. Note: In this example, the hostname of the IPAM server is used as a GPO prefix, however this is not required.  
  
```  
Invoke-IpamGpoProvisioning –Domain contoso.com –GpoPrefixName IPAM1 –IpamServerFqdn ipam1.contoso.com –DelegatedGpoUser user1  
```  
  
For more information about IPAM Server Cmdlets in Windows PowerShell, see [http:\/\/go.microsoft.com\/fwlink\/p\/?linkid\=262977](http://go.microsoft.com/fwlink/p/?linkid=262977).  
  
The following table summarizes access settings that are enabled on managed servers when you apply IPAM provisioning GPOs. These settings must be configured manually on managed servers if IPAM provisioning GPOs are not used. Servers that will not be managed by IPAM do not require any configuration changes.  
  
|Managed Server Role|IPAM Access Status|Access Settings|  
|-----------------------|----------------------|-------------------|  
|DHCP|DHCP RPC|The computer account for the IPAM server must be a member of the DHCP Users security group.<br /><br />The following firewall rules must be enabled:<br /><br />-   DHCP Server \(RPC\-In\)<br />-   DHCP Server \(RPCSS\-In\)|  
|DHCP|DHCP audit share|A network file share named **Dhcpaudit** must be created using the DHCP audit file folder, with Read access enabled for the computer account of the IPAM server.<br /><br />The following firewall rules must be enabled:<br /><br />-   File and Printer Sharing \(NB\-Session\-In\)<br />-   File and Printer Sharing \(SMB\-In\)|  
|DNS|DNS RPC|Read access for the computer account of the IPAM server must be added to DNS discretionary access control list \(DACL\).<br /><br />The following firewall rules must be enabled:<br /><br />-   DNS Service RPC<br />-   DNS Service RPC Endpoint Mapper|  
|DHCP, DNS, domain controller, NPS|Event log|The computer account of the IPAM server must be a member of the Event Log Readers security group.<br /><br />The computer account for the IPAM server must be granted read access in the ACL that is maintained by the following registry key on the DNS server: MACHINE\\System\\CurrentControlSet\\Services\\Eventlog\\DNS Server\\CustomSD. This only required on DNS servers.<br /><br />The following firewall rules must be enabled:<br /><br />-   Remote Event Log Management \(RPC\)<br />-   Remote Event Log Management \(RPC\-EPMAP\)|  
|DHCP, DNS|DHCP and DNS service monitoring|The following firewall rules must be enabled:<br /><br />-   Remote Service Management \(RPC\)<br />-   Remote Service Management \(RPC\-EPMAP\)|  
  
As previously described, IPAM GPOs are applied automatically when the Group Policy based provisioning method is chosen. However, if you have chosen the manual provisioning method, you can also create IPAM provisioning GPOs and apply these GPOs manually. This ensures that the settings applied to managed servers in the domain are consistent. To apply GPOs manually, add managed servers to security filtering for each GPO depending on the role services to be managed.  
  
After you have chosen a provisioning method, you can configure the scope of discovery and begin adding servers to manage with IPAM.  
  
## <a name="server_discovery"></a>Server discovery  
Server discovery has two steps:  
  
1.  Define the scope of discovery.  
  
2.  Discover servers on the network.  
  
### <a name="scope_of_discovery"></a>Scope of discovery  
IPAM leverages Active Directory to define the scope of servers to be managed. To begin discovering servers, click **Configure server discovery** in the IPAM client console and choose at least one domain in the forest to discover. To choose a domain, select it from the drop\-down list and then click **Add**.  
  
In each domain chosen, specify the type of servers to discover. By default, domain controllers, DHCP servers, and DNS servers are discovered. In the following example, the root domain has been chosen with all managed server roles enabled for discovery.  
  
![](../Image/IPAM_discovery_RTM.gif)  
  
When you have completed adding domains and server roles to discover, click **OK**. The number of domains selected will be displayed in the IPAM console. You can add or remove domains from the scope of discovery at any time.  
  
### <a name="discoverying_servers"></a>Discovering servers  
To discover server roles, the server must be running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or later. To begin discovering servers on the network, click **Start server discovery** to launch the IPAM **ServerDiscovery** task. You can also click **Manage** on the Server Manager menu, and then click **Start Server Discovery**. This task runs automatically at a specified interval, and can also be started on\-demand. For more information about IPAM tasks, see [Scheduled tasks](../Topic/Getting-Started-with-IPAM.md#scheduled_tasks).  
  
When the discovery task completes, click **Select or add servers to manage and verify IPAM access** to view the current list of servers in the IPAM server inventory. The following sections discuss how IPAM discovers different server roles on the network.  
  
-   [Domain controllers](../Topic/Getting-Started-with-IPAM.md#DC)  
  
-   [DHCP servers](../Topic/Getting-Started-with-IPAM.md#DHCP)  
  
-   [DNS servers](../Topic/Getting-Started-with-IPAM.md#DNS)  
  
-   [NPS servers](../Topic/Getting-Started-with-IPAM.md#NPS)  
  
#### <a name="DC"></a>Domain controllers  
Domain controllers are discovered in the domains you specify by querying Active Directory. If a domain controller is not discovered, verify that it is found in Active Directory. The following is an example query that displays a list of domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or later. Replace contoso.com with the domain that is being discovered.  
  
```  
Get-ADDomainController -Filter {OperatingSystemVersion –ge “6.0”} -Server contoso.com  
```  
  
#### <a name="DHCP"></a>DHCP servers  
IPAM discovers DHCP servers that are authorized in the Active Directory domains you specify and that respond to a **DHCPInform** message.  
  
> [!IMPORTANT]  
> If the DHCP server role is installed on the same server with IPAM, DHCP servers will not be discovered on the network.  
  
To discover DHCP servers, the IPAM server reads the DHCP server list stored in the **DHCPServers** group found in the **NetServices** container \(CN\=NetServices,CN\=Services,CN\=Configuration,DC\=domain,DC\=com\) in Active Directory. If a DHCP server is not discovered, verify that it is found in Active Directory and that the DHCP service is responding to requests. The following is an example query for DHCP servers that are authorized in Active Directory for the contoso.com domain.  
  
```  
Get-DhcpServerInDC | where-object {$_.dnsname –match “contoso.com”}  
```  
  
#### <a name="DNS"></a>DNS servers  
IPAM discovers authoritative DNS servers in the domains you specify by issuing a DNS query to the default DNS server configured on the IPAM server’s network interface. If a DNS server is not discovered, verify that it is found in DNS. The following is an example query for authoritative DNS servers in the contoso.com domain.  
  
```  
nslookup –q=ns contoso.com  
```  
  
DNS servers must be authoritative and have a name server \(NS\) record present in the domain zone. Caching\-only DNS servers are not discovered and cannot be managed with IPAM. Also note that if a DNS server is not running on a domain controller, additional procedures are required to enable monitoring and management access by the IPAM server. See [Verify managed server access](../Topic/Getting-Started-with-IPAM.md#verify_access) for more information.  
  
#### <a name="NPS"></a>NPS servers  
NPS servers are not automatically discovered by IPAM. However, you can add NPS servers to the server inventory by clicking **TASKS** and then clicking **Add Server**.   In the **Add or Edit Server** dialog box, type the fully qualified domain name next to **Server name**, click **Verify**, select **NPS server**, choose the **Manageability status** and then click **OK**.  
  
When you add a server manually to the server inventory, IPAM verifies that the server name exists in DNS, and that the IP address does not conflict with an existing server in the inventory.  
  
## <a name="select_managed_servers"></a>Select managed servers  
After auto\-discovering or manually adding servers to the server inventory, you must choose whether or not they will be managed by the IPAM server.  
  
Clicking **Select or add servers to manage and verify IPAM access** will display the current server inventory. To specify manageability status, right\-click one or more servers in the inventory and then click **Edit Server**. The **Add or Edit Server** dialog box is displayed. Press and hold SHIFT or CTRL to select multiple servers.  
  
![](../Image/IPAM_manageability.gif)  
  
You can choose the following settings next to **Manageability status**:  
  
1.  **Unspecified**. This is the default setting and is intended to be temporary. Servers that are Unspecified typically do not have access settings applied. IPAM will not attempt to collect data from these servers, but retains information about the server in its database. You can use this setting when a server is offline temporarily, such as during a maintenance cycle.  
  
2.  **Unmanaged**. Choose this setting if a server will not be monitored and managed by the current IPAM server. Servers that are Unmanaged typically do not have access settings applied. IPAM does not attempt to collect data from these servers, and data from these servers is not maintained in the IPAM database.  
  
3.  **Managed**. Choose this setting if the server will be monitored and managed by the current IPAM server. Servers that are Managed typically have access settings applied, or will have access settings applied in the future. IPAM attempts to collect data from these servers periodically based on the server roles that are selected, and maintains historical data for managed servers in the IPAM database.  
  
If you are using the manual provisioning method, permissions and settings that enable access by the IPAM server can be applied to managed servers either before or after you choose their manageability status. If you are using the automatic GPO\-based provisioning method, settings will be dynamically applied or removed depending on the manageability status you select.  
  
After you have chosen the servers that will be managed by IPAM, the next step is to verify that these managed server have the correct access settings applied to allow the IPAM server permission to monitor and manage the server roles you have selected.  
  
## <a name="verify_access"></a>Verify managed server access  
Access status is summarized in the **IPAM Access Status** column in server inventory. Possible values are:  
  
1.  **Not checked**: This status is displayed if a server is recently added or edited. This access status will be displayed until the **ServerDiscovery** task is run and the server inventory view is refreshed. To run the **ServerDiscovery** task, select one or more servers in the server inventory, right\-click, and then click **Refresh Server Access Status**.  
  
2.  **Unblocked**: In order for access status to be unblocked, access to all settings required for the all roles selected next to **Server type** must be unblocked.  
  
3.  **Blocked**: This status indicates that one or more access settings are blocked. If some, but not all, access settings are unblocked, access status will be blocked.  
  
![](../Image/IPAM_inventory.png)  
  
To view the current status of all access settings, click a server in the server inventory view and review the information on the **Details** tab.  
  
> [!TIP]  
> If access status is applied using GPOs, you might need to wait for Group Policy to be updated, or you can update Group Policy immediately using **gpupdate**. Verify that the appropriate GPOs are applied by typing **gpresult \/r** at an elevated command prompt.  
  
If managed server access settings have been recently applied, run the **ServerDiscovery** task and refresh the server inventory view. You can also wait for the view to refresh automatically.  
  
The **Details View** displays additional information about IPAM access status that specifically applies to the managed server roles that are selected, including:  
  
|Status|Possible values|  
|----------|-------------------|  
|Manageability Status|Managed, Unmanaged, Unspecified|  
|IPAM Access Status|Unblocked, Blocked, Not checked|  
|Recommended Action|IPAM Access Unblocked, Unblock IPAM Access, Set Manageability Status|  
|DHCP RPC Access Status|Unblocked, Blocked, Not applicable, Not checked|  
|DHCP Audit Share Access Status|Unblocked, Blocked, Not applicable, Not checked|  
|DNS RPC Access Status|Unblocked, Blocked, Not applicable, Not checked|  
|Event Log Access Status|Unblocked, Blocked, Not applicable, Not checked|  
  
The IPAM access status for a managed server is a summary of all the applicable role\-based access statuses displayed.  For example, if the server type is \[DNS, DHCP\], and DHCP access status is unblocked but DNS access status is blocked, then the overall IPAM access status will be blocked. To determine why the IPAM access status is blocked, it is important to review information in the details view to determine the specific type of access that is blocked.  
  
### Verifying managed DHCP servers  
DHCP service access settings require that the IPAM server is added to the DHCP Users security group. This is done automatically if you are using the Group Policy based provisioning method. However, since permissions for this group are applied when the DHCP Server service starts, you must restart the DHCP service if the server running IPAM does not already have this permission.  
  
> [!NOTE]  
> IPAM operational event logging is not supported on DHCP servers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. In the server inventory view, these servers will display a status of Blocked. However, you can still create and edit scopes and server options on DHCP servers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
### Verifying managed DNS servers  
To enable IPAM access to managed DNS servers, read access for the computer account of the IPAM server must be added to DNS discretionary access control list \(DACL\). However, the DACL is only applicable to Active Directory\-integrated DNS servers. Therefore, you cannot perform this procedure if the DNS server is not also a domain controller. In order for IPAM to manage the DNS Server service when it is not running on a domain controller, you must add the computer account of the IPAM server to the local administrators group on the DNS server. If the IPAM server is not a member of local administrators on the DNS server, then DNS RPC access will be blocked.  
  
## <a name="retrieve"></a>Retrieve data  
Data needs to be collected from managed servers before you can begin visualizing this information. Data collection tasks run automatically on the IPAM server at regular intervals. For more information about these tasks, see [IPAM Architecture](../Topic/IPAM-Architecture.md).  
  
You can also choose to run all IPAM data collection tasks on all managed servers immediately. To run these tasks, click **Retrieve data from managed servers** in the IPAM overview pane. To run all data collection tasks only on selected servers, select the servers from the server inventory view, right\-click, and then click **Retrieve All Server Data**.  
  
## See also  
[What is IPAM?](../Topic/What-is-IPAM-.md)  
  
[IPAM Terminology](../Topic/IPAM-Terminology.md)  
  
[IPAM Architecture](../Topic/IPAM-Architecture.md)  
  
[IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md)  
  
