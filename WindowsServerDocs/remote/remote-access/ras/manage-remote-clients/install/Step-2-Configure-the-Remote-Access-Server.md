---
title: Step 2 Configure the Remote Access Server
description: This topic is part of the guide Manage DirectAccess Clients Remotely in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0257b98-5633-4264-9df6-b6ffae80592c
ms.author: lizross
author: eross-msft
---
# Step 2 Configure the Remote Access Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to configure the client and server settings that are required for remote management of DirectAccess clients. Before you begin the deployment steps, ensure that you have completed the planning steps that are described in [Step 2 Plan the Remote Access Deployment](../plan/Step-2-Plan-the-Remote-Access-Deployment.md).  
  
|Task|Description|  
|----|--------|  
|Install the Remote Access role|Install the Remote Access role.|  
|Configure the deployment type|Configure the deployment type as DirectAccess and VPN, DirectAccess only, or VPN only.|  
|Configure DirectAccess clients|Configure the Remote Access server with the security groups that contain DirectAccess clients.|  
|Configure the Remote Access server|Configure the Remote Access server settings.|  
|Configure the infrastructure servers|Configure the infrastructure servers that are used in the organization.|  
|Configure application servers|Configure the application servers to require authentication and encryption.|  
|Configuration summary and alternate GPOs|View the Remote Access configuration summary, and modify the GPOs if desired.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_Role"></a>Install the Remote Access role  
You must install the Remote Access role on a server in your organization that will act as the Remote Access server.  
  
#### To install the Remote Access role  
  
### To install the Remote Access role on DirectAccess servers  
  
1.  On the DirectAccess server, in the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select Server Roles** dialog, select **Remote Access**, and then click **Next**.  
  
4.  Click **Next** three times.  
  
5.  On the **Select role services** dialog, select **DirectAccess and VPN (RAS)** and then click **Add Features**.  
  
6.  Select **Routing**, select **Web Application Proxy**, click **Add Features**, and then click **Next**.  
  
7. Click **Next**, and then click **Install**.  
  
8.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
![Windows PowerShell](../../../../media/Step-2-Configure-the-Remote-Access-Server/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Install-WindowsFeature RemoteAccess -IncludeManagementTools  
```  
  
## <a name="BKMK_Deploy"></a>Configure the deployment type  
There are three options that you can use to deploy Remote Access from the Remote Access Management console:  
  
-   DirectAccess and VPN  
  
-   DirectAccess only  
  
-   VPN only  
  
> [!NOTE]  
> This guide uses the DirectAccess only method of deployment in the example procedures.  
  
#### To configure the deployment type  
  
1.  On the Remote Access server, open the Remote Access Management console: On the **Start** screen, type, type **Remote Access Management Console**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, in the middle pane, click **Run the Remote Access Setup Wizard**.  
  
3.  In the **Configure Remote Access** dialog box, select DirectAccess and VPN, DirectAccess only, or VPN only.  
  
## <a name="BKMK_Clients"></a>Configure DirectAccess clients  
For a client computer to be provisioned to use DirectAccess, it must belong to the selected security group. After DirectAccess is configured, client computers in the security group are provisioned to receive the DirectAccess Group Policy Objects (GPOs) for remote management.  
  
#### To configure DirectAccess clients  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 1 Remote Clients** area, click **Configure**.  
  
2.  In the DirectAccess Client Setup Wizard, on the **Deployment Scenario** page, click **Deploy DirectAccess for remote management only**, and then click **Next**.  
  
3.  On the **Select Groups** page, click **Add**.  
  
4.  In the **Select Groups** dialog box, select the security groups that contain the DirectAccess client computers, and then click **Next**.  
  
5.  On the **Network Connectivity Assistant** page:  
  
    -   In the table, add the resources that will be used to determine connectivity to the internal network. A default web probe is created automatically if no other resources are configured. When configuring the web probe locations for determining connectivity to the enterprise network, ensure that you have at least one HTTP based probe configured. Configuring only a ping probe is not sufficient, and it could lead to an inaccurate determination of connectivity status. This is because ping is exempted from IPsec. As a result, ping does not ensure that the IPsec tunnels are properly established.  
  
    -   Add a Help Desk email address to allow users to send information if they experience connectivity issues.  
  
    -   Provide a friendly name for the DirectAccess connection.  
  
    -   Select the **Allow DirectAccess clients to use local name resolution** check box, if required.  
  
        > [!NOTE]  
        > When local name resolution is enabled, users who are running the NCA can resolve names by using DNS servers that are configured on the DirectAccess client computer.  
  
6.  Click **Finish**.  
  
## <a name="BKMK_Server"></a>Configure the Remote Access server  
To deploy Remote Access, you need to configure the server that will act as the Remote Access server with the following:  
  
1.  Correct network adapters  
  
2.  A public URL for the Remote Access server to which client computers can connect (the ConnectTo address)  
  
3.  An IP-HTTPS certificate with a subject that matches the ConnectTo address  
  
4.  IPv6 settings  
  
5.  Client computer authentication  
  
#### To configure the Remote Access server  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 2 Remote Access Server** area, click **Configure**.  
  
2.  In the Remote Access Server Setup Wizard, on the **Network Topology** page, click the deployment topology that will be used in your organization. In **Type the public name or IPv4 address used by clients to connect to the Remote Access server**, enter the public name for the deployment (this name matches the subject name of the IP-HTTPS certificate, for example, edge1.contoso.com), and then click **Next**.  
  
3.  On the **Network Adapters** page, the wizard automatically detects:  
  
    -   Network adapters for the networks in your deployment. If the wizard does not detect the correct network adapters, manually select the correct adapters.  
  
    -   IP-HTTPS certificate. This is based on the public name for the deployment that you set during the previous step of the wizard. If the wizard does not detect the correct IP-HTTPS certificate, click **Browse** to manually select the correct certificate.  
  
4.  Click **Next**.  
  
5.  On the **Prefix Configuration** page (this page is only visible if IPv6 is detected in the internal network), the wizard automatically detects the IPv6 settings that are used on the internal network. If your deployment requires additional prefixes, configure the IPv6 prefixes for the internal network, an IPv6 prefix to assign to DirectAccess client computers, and an IPv6 prefix to assign to VPN client computers.  
  
6.  On the **Authentication** page:  
  
    -   For multisite and two-factor authentication deployments, you must use computer certificate authentication. Select the **Use computer certificates** check box to use computer certificate authentication and select the IPsec root certificate.  
  
    -   To enable client computers running  Windows 7  to connect via DirectAccess, select the **Enable Windows 7 client computers to connect via DirectAccess** check box. You must also use computer certificate authentication in this type of deployment.  
  
7.  Click **Finish**.  
  
## <a name="BKMK_Infra"></a>Configure the infrastructure servers  
To configure the infrastructure servers in a Remote Access deployment, you must configure the following:  
  
-   Network location server  
  
-   DNS settings, including the DNS suffix search list  
  
-   Any management servers that are not automatically detected by Remote Access  
  
#### To configure the infrastructure servers  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 3 Infrastructure Servers** area, click **Configure**.  
  
2.  In the Infrastructure Server Setup Wizard, on the **Network Location Server** page, click the option that corresponds to the location of the network location server in your deployment.  
  
    -   If the network location server is on a remote web server, enter the URL, and then click **Validate** before you continue.  
  
    -   If the network location server is on the Remote Access server, click **Browse** to locate the relevant certificate, and then click **Next**.  
  
3.  On the **DNS** page, in the table, enter additional name suffixes that will be applied as Name Resolution Policy Table (NRPT) exemptions. Select a local name resolution option, and then click **Next**.  
  
4.  On the **DNS Suffix Search List** page, the Remote Access server automatically detects domain suffixes in the deployment. Use the **Add** and **Remove** buttons to create the list of domain suffixes that you want to use. To add a new domain suffix, in **New Suffix**, enter the suffix, and then click **Add**. Click **Next**.  
  
5.  On the **Management** page, add management servers that are not detected automatically, and then click **Next**. Remote Access automatically adds domain controllers and Configuration Manager servers.  
  
6.  Click **Finish**.  
  
## <a name="BKMK_App"></a>Configure application servers  
In a full Remote Access deployment, configuring application servers is an optional task. In this scenario for remote management of DirectAccess clients, application servers are not utilized and this step is greyed out to indicate that it is not active. Click **Finish** to apply the configuration.  
  
## <a name="BKMK_GPO"></a>Configuration summary and alternate GPOs  
When the Remote Access configuration is complete, the **Remote Access Review** is displayed. You can review all of the settings that you previously selected, including:  
  
-   **GPO Settings**  
  
    The DirectAccess server GPO name and Client GPO name are listed. You can click the **Change** link next to the **GPO Settings** heading to modify the GPO settings.  
  
-   **Remote Clients**  
  
    The DirectAccess client configuration is displayed, including the security group, connectivity verifiers, and DirectAccess connection name.  
  
-   **Remote Access Server**  
  
    The DirectAccess configuration is displayed, including the public name and address, network adapter configuration, and certificate information.  
  
-   **Infrastructure Servers**  
  
    This list includes the network location server URL, DNS suffixes that are used by DirectAccess clients, and management server information.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Verify the Deployment](Step-3-Verify-the-Deployment_2.md)  
  
  


