---
title: Step 2 Configure Advanced DirectAccess Servers
description: This topic is part of the guide Deploy a Single DirectAccess Server with Advanced Settings for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 35afec8e-39a4-463b-839a-3c300ab01174
ms.author: lizross
author: eross-msft
---
# Step 2 Configure Advanced DirectAccess Servers

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to configure the client and server settings that are required for an advanced Remote Access deployment that uses a single Remote Access server in a mixed IPv4 and IPv6 environment. Before you begin the deployment steps, ensure that you have completed the planning steps that are described in [Plan an Advanced DirectAccess Deployment](Plan-an-Advanced-DirectAccess-Deployment.md).  
  
|Task|Description|  
|----|--------|  
|2.1. Install the Remote Access role|Install the Remote Access role.|  
|2.2. Configure the deployment type|Configure the deployment type as DirectAccess and VPN, DirectAccess only, or VPN only.|  
|[Plan an Advanced DirectAccess Deployment](Plan-an-Advanced-DirectAccess-Deployment.md)|Configure the Remote Access server with the security groups that contain DirectAccess clients.|  
|2.4. Configure the Remote Access server|Configure Remote Access server settings.|  
|2.5. Configure the infrastructure servers|Configure the infrastructure servers that are used in the organization.|  
|2.6. Configure application servers|Configure application servers so that they require authentication and encryption.|  
|2.7. Configuration summary and alternate GPOs|View the Remote Access configuration summary, and modify the GPOs if desired.|  
|2.8. How to configure the Remote Access server using Windows PowerShell|Configure Remote Access by using Windows PowerShell.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_Role"></a>2.1. Install the Remote Access role  
To deploy Remote Access, you must install the Remote Access role on a server in your organization that will act as the Remote Access server.  
  
#### To install the Remote Access role  
  
1.  On the Remote Access server, in the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the **Select server roles** screen.  
  
3.  On the **Select server roles** page, select **Remote Access**, click **Add Features**, and then click **Next**.  
  
4.  Click **Next** five times.  
  
5.  On the **Confirm installation selections** page, click **Install**.  
  
6.  On the **Installation progress** page, verify that the installation was successful, and then click **Close**.  
  
![Installation progress success](../../../media/Step-2-Configuring-DirectAccess-Servers/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Install-WindowsFeature RemoteAccess -IncludeManagementTools  
```  
  
## <a name="BKMK_Deploy"></a>2.2. Configure the deployment type  
Remote Access can be deployed by using the Remote Access Management console in three ways:  
  
-   DirectAccess and VPN  
  
-   DirectAccess only  
  
-   VPN only  
  
This guide uses a DirectAccess-only deployment in the example procedures.  
  
#### To configure the deployment type  
  
1.  On the Remote Access server, open the Remote Access Management console: On the **Start** screen, type**RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, in the middle pane, click **Run the Remote Access Setup Wizard**.  
  
3.  In the **Configure Remote Access** dialog box, click the whether to deploy DirectAccess and VPN, DirectAccess only, or VPN only.  
  
## <a name="BKMK_Clients"></a>2.3. Configure DirectAccess clients  
For a client computer to be provisioned to use DirectAccess, it must belong to the selected security group. After DirectAccess is configured, client computers in the security group are provisioned to receive the DirectAccess Group Policy Object (GPO). You can also configure the deployment scenario, which allows you to configure DirectAccess for client access and remote management, or for remote management only.  
  
#### To configure DirectAccess clients  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 1 Remote Clients** area, click **Configure**.  
  
2.  In the DirectAccess Client Setup Wizard, on the **Deployment Scenario** page, click the deployment scenario that you want to use in your organization (**Full DirectAccess** or **Remote management only**) , and then click **Next**.  
  
3.  On the **Select Groups** page, click **Add**.  
  
4.  In the **Select Groups** dialog box, select the security groups that contain your DirectAccess client computers.  
  
    > [!NOTE]  
    > If the security group is located in a different forest than the Remote Access server, after you complete the Remote Access Setup Wizard, click **Refresh Management Servers** in the **Tasks** pane to discover the domain controllers and Configuration Manager servers in the new forest.  
  
5.  Select the **Enable DirectAccess for mobile computers only** check box to allow only mobile computers to access the internal network, if required.  
  
6.  Select the **Use force tunneling** check box to route all client traffic (to the internal network and to the Internet) through the Remote Access server, if required.  
  
7.  Click **Next**.  
  
8.  On the **Network Connectivity Assistant** page:  
  
    -   In the table, add resources that will be used to determine connectivity to the internal network. A default web probe is created automatically if no other resources are configured.  
  
        > [!CAUTION]  
        > When you configure the web probe locations for determining connectivity to the Enterprise network, ensure that you have at least one HTTP-based probe configured. Configuring a **ping** probe only is not sufficient, and this could lead to inaccurate determination of connectivity status. This is because **ping** is exempt from IPsec, and as a result, it does not ensure that the IPsec tunnels are properly established.  
  
    -   Add a Help Desk email address to allow users to send information if they experience connectivity issues.  
  
    -   Provide a friendly name for the DirectAccess connection. This name appears in the network list when users click the network icon in the notification area.  
  
    -   Select the **Allow DirectAccess clients to use local name resolution** check box, if required.  
  
        > [!NOTE]  
        > When local name resolution is enabled, users who run the Network Connectivity Assistant can select to resolve names by using DNS servers that are configured on the DirectAccess client computer.  
  
9. Click **Finish**.  
  
## <a name="BKMK_Server"></a>2.4. Configure the Remote Access server  
To deploy Remote Access, you need to configure the Remote Access server with the correct network adapters, a public URL for the Remote Access server to which client computers can connect (the ConnectTo address), an IP-HTTPS certificate with a subject that matches the ConnectTo address, IPv6 settings, and client computer authentication.  
  
#### To configure the Remote Access server  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 2 Remote Access Server** area, click **Configure**.  
  
2.  In the Remote Access Server Setup Wizard, on the **Network Topology** page, click the deployment topology that will be used in your organization. In **Type the public name or IPv4 address used by clients to connect to the Remote Access server**, enter the public name for the deployment (this name matches the subject name of the IP-HTTPS certificate, for example, edge1.contoso.com), and then click **Next**.  
  
3.  On the **Network Adapters** page, the wizard automatically detects the network adapters for the networks in your deployment. If the wizard does not detect the correct network adapters, manually select the correct adapters. The wizard also automatically detects the IP-HTTPS certificate, based on the public name for the deployment set in the previous step of the wizard. If the wizard does not detect the correct IP-HTTPS certificate, click **Browse** to manually select the correct certificate, and then click **Next**.  
  
4.  On the **Prefix Configuration** page (this appears only if IPv6 is deployed in the internal network), the wizard automatically detects the IPv6 settings that are used in the internal network. If your deployment requires additional prefixes, configure the IPv6 prefixes for the internal network, an IPv6 prefix to assign to DirectAccess client computers, and an IPv6 prefix to assign to VPN client computers.  
  
    > [!NOTE]  
    > You can specify multiple internal IPv6 prefixes by using a semicolon delimited list, for example, 2001:db8:1::/48;2001:db8:2::/48.  
  
5.  On the **Authentication** page:  
  
    -   In **User Authentication**, click **Active Directory credentials**. To configure a deployment by using two-factor authentication, click **Two-factor authentication**. For more information, see [Deploy Remote Access with OTP authentication](https://technet.microsoft.com/library/hh831379.aspx).  
  
    -   For multisite and two-factor authentication deployments, you must use computer certificate authentication. Select the **Use computer certificates** check box to use computer certificate authentication, and select the IPsec root certificate.  
  
    -   To enable Windows 7 client computers to connect through DirectAccess, select the **Enable Windows 7 client computers to connect via DirectAccess** check box.  
  
        > [!NOTE]  
        > You must also use computer certificate authentication in this type of deployment.  
  
6.  Click **Finish**.  
  
## <a name="BKMK_Infra"></a>2.5. Configure the infrastructure servers  
To configure the infrastructure servers in a Remote Access deployment, you must configure the network location server, DNS settings (including the DNS suffix search list), and management servers that are not automatically detected by Remote Access.  
  
#### To configure the infrastructure servers  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 3 Infrastructure Servers** area, click **Configure**.  
  
2.  In the Infrastructure Server Setup Wizard, on the **Network Location Server** page, click the option that corresponds to the location of the network location server in your deployment. If the network location server is on a remote web server, enter the URL and click **Validate** before you continue. If the network location server is on the Remote Access server, click **Browse** to locate the relevant certificate, and then click **Next**.  
  
3.  On the **DNS** page, in the table, enter any additional name suffixes that will be applied as Name Resolution Policy Table (NRPT) exemptions. Select a local name resolution option, and then click **Next**.  
  
4.  On the **DNS Suffix Search List** page, the Remote Access server automatically detects any domain suffixes in the deployment. Use the **Add** and **Remove** buttons to add and remove domain suffixes from the list of domain suffixes to use. To add a new domain suffix, in **New Suffix**, enter the suffix, and then click **Add**. Click **Next**.  
  
5.  On the **Management** page, add any management servers that are not detected automatically, and then click **Next**. Remote Access automatically adds domain controllers and Configuration Manager servers.  
  
    > [!NOTE]  
    > Although the servers are added automatically, they don't appear in the list. After you apply the configuration the first time, the Configuration Manager servers appear in the list.  
  
6.  Click **Finish**.  
  
## <a name="BKMK_App"></a>2.6. Configure application servers  
In a Remote Access deployment, configuring application servers is an optional task. Remote Access enables you to require authentication for selected application servers, which is determined by their inclusion in an application servers security group. By default, traffic to application servers that require authentication is also encrypted; however, you can choose to not encrypt traffic to application servers and use authentication only.  
  
> [!NOTE]  
> Authentication without encryption is supported only on application servers running  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2 .  
  
#### To configure application servers  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 4 Application Servers** area, click **Configure**.  
  
2.  In the DirectAccess Application Server Setup Wizard, to require authentication to selected application servers, click **Extend authentication to selected application servers**. Click **Add** to select the application server security group.  
  
3.  To limit access to only the servers in the application server security group, select the **Allow access only to servers included in the security groups** check box.  
  
4.  To use authentication without encryption, select the **Do not encrypt traffic. Use authentication only** check box.  
  
5.  Click **Finish**.  
  
## <a name="BKMK_GPO"></a>2.7. Configuration summary and alternate GPOs  
When the Remote Access configuration is complete, the **Remote Access Review** is displayed. You can review all of the settings that you previously selected, including:  
  
1.  **GPO Settings**: The DirectAccess server GPO name and client GPO name are listed. Additionally, you can click the **Change** link next to the **GPO Settings** heading to modify the GPO settings.  
  
2.  **Remote Clients**: The DirectAccess client configuration is displayed, including the security group, force tunneling status, connectivity verifiers, and DirectAccess connection name.  
  
3.  **Remote Access Server**: The DirectAccess configuration is displayed including the public name/address, network adapter configuration, certificate information, and OTP information if configured.  
  
4.  **Infrastructure Servers**: This list includes the network location server URL, DNS suffixes that are used by DirectAccess clients, and management server information.  
  
5.  **Application Servers**: The DirectAccess remote management status is displayed, in addition to the status of the end-to-end authentication to specific application servers.  
  
## <a name="BKMK_PS"></a>2.8. How to configure the Remote Access server by using Windows PowerShell  
![Windows PowerShell](../../../media/Step-2-Configuring-DirectAccess-Servers/PowerShellLogoSmall.gif)**Windows PowerShell equivalent commands**  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To perform a full installation in an edge topology of Remote Access for DirectAccess only in a domain with the root **corp.contoso.com** and using the following parameters: server GPO: **DirectAccess Server Settings**, client GPO: DirectAccess Client Settings, internal network adapter: **Corpnet**, external network adapter: **Internet**, ConnectTto address: **edge1.contoso.com**, and network location server: **nls.corp.contoso.com**:  
  
```  
Install-RemoteAccess -Force -PassThru -ServerGpoName 'corp.contoso.com\DirectAccess Server Settings' -ClientGpoName 'corp.contoso.com\DirectAccess Client Settings' -DAInstallType 'FullInstall' -InternetInterface 'Internet' -InternalInterface 'Corpnet' -ConnectToAddress 'edge1.contoso.com' -NlsUrl 'https://nls.corp.contoso.com/'  
```  
  
To configure the Remote Access server to use computer certificate authentication, with an IPsec root certificate that is issued by the certification authority named CORP-APP1-CA:  
  
```  
$certs = Get-ChildItem Cert:\LocalMachine\Root  
$IPsecRootCert = $certs | Where-Object {$_.Subject -Match "corp-APP1-CA"}  
Set-DAServer -IPsecRootCertificate $IPsecRootCert  
```  
  
To add the security group that contains DirectAccess clients named **DirectAccessClients**, and to remove the default Domain Computers security group:  
  
```  
Add-DAClient -SecurityGroupNameList @('corp.contoso.com\DirectAccessClients')  
Remove-DAClient -SecurityGroupNameList @('corp.contoso.com\Domain Computers')  
```  
  
To enable Remote Access for all computers (not only notebooks and laptops), and to enable Remote Access for  Windows 7  clients:  
  
```  
Set-DAClient -OnlyRemoteComputers 'Disabled' -Downlevel 'Enabled'  
```  
  
To configure the DirectAccess client experience, including the friendly connection name and the web probe URL:  
  
```  
Set-DAClientExperienceConfiguration -FriendlyName 'Contoso DirectAccess Connection' -PreferLocalNamesAllowed $False -PolicyStore 'corp.contoso.com\DirectAccess Client Settings' -CorporateResources @('HTTP:https://directaccess-WebProbeHost.corp.contoso.com')  
```  
  
## <a name="BKMK_Links"></a>Previous step  
  
-   [Step 1: Configure Advanced DirectAccess Infrastructure](da-adv-configure-s1-infrastructure.md)  
  
## Next step  
  
-   [Step 3: Verify the Deployment](Step-3-Verify-the-Deployment.md)  
  


