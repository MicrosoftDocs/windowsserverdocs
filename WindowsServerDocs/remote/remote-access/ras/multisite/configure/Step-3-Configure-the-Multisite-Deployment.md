---
title: Step 3 Configure the Multisite Deployment
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ea7ecd52-4c12-4a49-92fd-b8c08cec42a9
ms.author: lizross
author: eross-msft
---
# Step 3 Configure the Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

After configuring the multisite infrastructure follow these steps to set up the  Remote Access multisite deployment.  
  
|Task|Description|  
|----|--------|  
|3.1. Configure Remote Access servers|Configure additional Remote Access servers by setting up IP addresses, joining them to the domain, and installing the Remote Access role.|  
|3.2. Grant administrator access|Grant privileges on the additional Remote Access servers to the DirectAccess administrator.|  
|3.3. Configure IP-HTTPS for a multisite deployment|Configure the IP-HTTPS certificate used in a multisite deployment.|  
|3.4. Configure the network location server for a multisite deployment|Configure the network location server certificate used in a multisite deployment.|  
|3.5. Configure DirectAccess clients for a multisite deployment|Remove  Windows 7  client computers from Windows 8 security groups.|  
|3.6. Enable the multisite deployment|Enable the multisite deployment on the first Remote Access server.|  
|3.7. Add entry points to the multisite deployment|Add additional entry points to the multisite deployment.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_ConfigServer"></a>3.1. Configure Remote Access servers  

  
### To install the Remote Access role  
  
1.  Make sure that each Remote Access server is configured with the proper deployment topology (Edge, behind a NAT, single network interface), and corresponding routes.  
  
2.  Configure the IP addresses on each Remote Access server according to the site topology and your organization's IP addressing scheme.  
  
3.  Join each Remote Access server to an Active Directory domain.  
  
4.  In the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
5.   Click **Next** three times to get to the server role selection screen.  
  
6.  On the **Select Server Roles** dialog, select **Remote Access**, and then click **Next**.  
  
7.  Click **Next** three times.  
  
8.  On the **Select role services** dialog, select **DirectAccess and VPN (RAS)** and then click **Add Features**.  
  
9.  Select **Routing**, select **Web Application Proxy**, click **Add Features**, and then click **Next**.  
  
10. Click **Next**, and then click **Install**.  
  
11.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
  
![Windows PowerShell](../../../../media/Step-3-Configure-the-Multisite-Deployment/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

  
Steps 1 - 3 must be performed manually, and are not accomplished using this Windows PowerShell cmdlet.  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Install-WindowsFeature RemoteAccess -IncludeManagementTools  
```  
  
## <a name="BKMK_Admin"></a>3.2. Grant administrator access  
  
#### To grant administrator permissions  
  
1.  On the Remote Access server in the additional entry point: On the **Start** screen, type **Computer Management**, and then press ENTER.  
  
2.  In the left pane, click **Local Users and Groups**.  
  
3.  Double-click **Groups**, and then double-click **Administrators**.  
  
4.  On the **Administrators Properties** dialog box, click **Add**, and on the **Select Users, Computers, Service Accounts, or Groups** dialog box, click **Locations**.  
  
5.  On the **Locations** dialog box, in the **Location** tree, click the location that contains the user account of the DirectAccess administrator, and then click **OK**.  
  
6.  In the **Enter the object names to select**, enter the user name of the DirectAccess administrator, and then click **OK** twice.  
  
7.  On the **Administrators Properties** dialog box, click **OK**.  
  
8.  Close the Computer Management window.  
  
9. Repeat this procedure on all Remote Access servers that will be part of the multisite deployment.  
  
## <a name="BKMK_IPHTTPS"></a>3.3. Configure IP-HTTPS for a multisite deployment  
On each Remote Access server that will be added to the multisite deployment, an SSL certificate is required to verify the HTTPS connection to the IP-HTTPS web server. Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.  
  
#### To obtain an IP-HTTPS certificate  
  
1.  On each Remote Access server: On the **Start** screen, type **mmc**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  Click **File**, and then click **Add/Remove Snap-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, click the Web Server certificate template, and then click **More information is required to enroll for this certificate**.  
  
    If the Web Server certificate template does not appear, ensure that the Remote Access server computer account has enroll permissions for the Web Server certificate template. For more information, see [Configure Permissions on the Web Server Certificate Template](https://technet.microsoft.com/library/ee649249(v=ws.10).aspx).  
  
8.  On the **Subject** tab of the **Certificate Properties** dialog box, in **Subject name**, for **Type**, select **Common name**.  
  
9. In **Value**, type the fully qualified domain name (FQDN) of the Internet name of the Remote Access server (for example, Europe.contoso.com), and then click **Add**.  
  
10. Click **OK**, click **Enroll**, and then click **Finish**.  
  
11. In the details pane of the Certificates snap-in, verify that a new certificate with the FQDN was enrolled with **Intended Purposes** of **Server Authentication**.  
  
12. Right-click the certificate, and then click **Properties**.  
  
13. In **Friendly Name**, type **IP-HTTPS Certificate**, and then click **OK**.  
  
    > [!TIP]  
    > Steps 12 and 13 are optional, but make it easier for you to select the certificate for IP-HTTPS when configuring Remote Access.  
  
14. Repeat this procedure on all Remote Access servers in your deployment.  
  
## <a name="BKMK_NLS"></a>3.4. Configure the network location server for a multisite deployment  
If you selected to set up the network location server website on the Remote Access server when you set up your first server, each new Remote Access server that you add needs to be configured with a Web Server certificate that has the same subject name that was selected for the network location server for the first server. Each server requires a certificate to authenticate the connection to the network location server, and client computers located in the internal network must be able to resolve the name of the website in DNS.  
  
#### To install a certificate for network location  
  
1.  On the Remote Access server: On the **Start** screen, type **mmc**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  Click **File**, and then click **Add/Remove Snap-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
    > [!NOTE]  
    > You may also import the same certificate that was used for the network location server for the first Remote Access server.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, click the Web Server certificate template, and then click **More information is required to enroll for this certificate**.  
  
    If the Web Server certificate template does not appear, ensure that the Remote Access server computer account has enroll permissions for the Web Server certificate template. For more information, see [Configure Permissions on the Web Server Certificate Template](https://technet.microsoft.com/library/ee649249(v=ws.10).aspx).  
  
8.  On the **Subject** tab of the **Certificate Properties** dialog box, in **Subject name**, for **Type**, select **Common name**.  
  
9. In **Value**, type the fully qualified domain name (FQDN) that was configured for the network location server certificate of the first Remote Access server (for example, nls.corp.contoso.com), and then click **Add**.  
  
10. Click **OK**, click **Enroll**, and then click **Finish**.  
  
11. In the details pane of the Certificates snap-in, verify that a new certificate with the FQDN was enrolled with **Intended Purposes** of **Server Authentication**.  
  
12. Right-click the certificate, and then click **Properties**.  
  
13. In **Friendly Name**, type **Network Location Certificate**, and then click **OK**.  
  
    > [!TIP]  
    > Steps 12 and 13 are optional, but make it easier for you to select the certificate for network location when configuring Remote Access.  
  
14. Repeat this procedure on all Remote Access servers in your deployment.  
  
### <a name="NLS"></a>To create the network location server DNS records  
  
1.  On the DNS server: On the **Start** screen, type **dnsmgmt.msc**, and then press ENTER.  
  
2.  In the left pane of the **DNS Manager** console, open the forward lookup zone for the internal network. Right click the relevant zone and click **New Host (A or AAAA)**.  
  
3.  On the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the name that was used for the network location server for the first Remote Access server. In the **IP address** box, enter the intranet-facing IPv4 address of the Remote Access server, and then click **Add Host**. On the **DNS** dialog box, click **OK**.  
  
4.  On the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the name that was used for the network location server for the first Remote Access server. In the **IP address** box, enter the intranet-facing IPv6 address of the Remote Access server, and then click **Add Host**. On the **DNS** dialog box, click **OK**.  
  
5.  Repeat steps 3 and 4 for every Remote Access server in your deployment.  
  
6.  Click **Done**.  
  
7.  Repeat this procedure before adding servers as additional entry points in the deployment.  
  
## <a name="BKMK_Client"></a>3.5. Configure DirectAccess clients for a multisite deployment  
DirectAccess Windows client computers must be members of security group(s) which define their DirectAccess association. Before multisite is enabled, these security group(s) can contain both Windows 8 clients and  Windows 7  clients (if the appropriate "downlevel" mode was selected). Once multisite is enabled, existing client security group(s), in single server mode, are converted to security group(s) for Windows 8 only. After multisite is enabled, DirectAccess  Windows 7  client computers must be moved to corresponding dedicated  Windows 7  client security groups (which are associated with specific entry-points), or they will not be able to connect over DirectAccess. The  Windows 7  clients must first be removed from the existing security groups which are now Windows 8 security groups. Caution:  Windows 7  client computers that are members of both  Windows 7  and Windows 8 client security groups will lose remote connectivity, and  Windows 7  clients without SP1 installed will lose corporate connectivity as well. Therefore, all  Windows 7  client computers must be removed from Windows 8 security groups.  
  
#### Remove  Windows 7  clients from Windows 8 security groups  
  
1.  On the primary domain controller, click **Start**, and then click **Active Directory Users and Computers**.  
  
2.  To remove computers from the security group, double-click the security group, and on the **<Group_Name> Properties** dialog box, click the **Members** tab.  
  
3.  Select the  Windows 7  client computer, and click **Remove**.  
  
4.  Repeat this procedure to remove the  Windows 7  client computers from the Windows 8 security groups.  
  
> [!IMPORTANT]  
> When enabling a Remote Access multisite configuration all client computers ( Windows 7  and Windows 8) will lose remote connectivity until they are able to connect to the corporate network directly or by VPN to update their group policies. This is true when enabling multisite functionality for the first time, and also when disabling multisite.  
  
## <a name="BKMK_Enable"></a>3.6. Enable the multisite deployment  
To configure a multisite deployment, enable the multisite feature on your existing Remote Access server. Before enabling multisite in your deployment, make sure you have the following information:  
  
1.  Global load balancer settings and IP addresses if you want to load balance DirectAccess client connections across all entry-points in your deployment.  
  
2.  The security group(s) containing  Windows 7  client computers for the first entry point in your deployment, if you want to enable Remote Access for  Windows 7  client computers.  
  
3.  Group Policy Object names, if you are required to use non-default Group Policy Objects, which are applied on  Windows 7  client computers for the first entry point in your deployment, if you require support for  Windows 7  client computers.  
  
### <a name="EnabledMultisite"></a>To enable a multisite configuration  
  
1.  On your existing Remote Access server: On the **Start** screen, type **RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**, and then in the **Tasks** pane, click **Enable Multisite**.  
  
3.  In the **Enable Multisite Deployment** wizard, on the **Before You Begin** page, click **Next**.  
  
4.  On the **Deployment Name** page, in **Multisite deployment name**, enter a name for your deployment. In **First entry point name**, enter a name to identify the first entry point which is the current Remote Access server, and then click **Next**.  
  
5.  On the **Entry Point Selection** page, do one of the following:  
  
    -   Click **Assign entry points automatically, and allow clients to select manually** to automatically route client computers to the most suitable entry point, while also allowing client computers to select an entry point manually. Manual entry point selection is available only for Windows 8 computers. Click **Next**.  
  
    -   Click **Assign entry points automatically** to automatically route client computers to the most suitable entry point, and then click **Next**.  
  
6.  On the **Global Load Balancing** page, do one of the following:  
  
    -   Click **No, do not use global load balancing** if you do not want to use a global load balancing, and then click **Next**.  
  
        > [!NOTE]  
        > When selecting this option client computers connect to their closest entry point automatically.  
  
    -   Click **Yes, use global load balancing** if you want to load balance the traffic globally between all entry points. In **Type the global load balancing FQDN to be used by all entry points**, enter the global load balancing FQDN, and in **Type the global load balancing IP address for this entry point** that contains the first Remote Access server, enter the global load balancing IP address for this entry point, and then click **Next**.  
  
7.  On the **Client Support** page, do one of the following:  
  
    -   To limit access to client computers running Windows 8 or later operating systems, click **Limit access to client computers running Windows 8 or a later operating system**, and then click **Next**.  
  
    -   To allow client computers running  Windows 7  to access this entry point, click **Allow client computers running Windows 7 to access this entry point**, and click **Add**. On the **Select Groups** dialog box, select the security group(s) that contains the  Windows 7  client computers, click **OK**, and then click **Next**.  
  
8.  On the **Client GPO Settings** page, accept the default GPO for  Windows 7  client computers for this entry point, type the name of the GPO that want Remote Access to create automatically, or click **Browse** to locate the GPO for  Windows 7  client computers, and then click **Next**.  
  
    > [!NOTE]  
    > -   The **Client GPO Settings** page appears only when you configure the entry point to allow  Windows 7  client computers to access the entry point.  
    > -   You can optionally click **Validate GPOs** to ensure that you have the proper permissions for the selected GPO or GPOs for this entry point. If the GPO does not exist and will be automatically created, then create and link permissions are required. In the case where the GPOs were created manually, then edit, modify security, and delete permissions are required.  
  
9. On the **Summary** page, click **Commit**.  
  
10. On the **Enabling Multisite Deployment** dialog box, click **Close** and then on the Enable Multisite Deployment wizard, click **Close**.  
  
![Windows PowerShell](../../../../media/Step-3-Configure-the-Multisite-Deployment/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To enable a multisite deployment named 'Contoso' on the first entry point named 'Edge1-US'. The deployment allows clients to manually select the entry point, and does not use a global load balancer.  
  
```  
Enable-DAMultiSite -Name 'Contoso' -EntryPointName 'Edge1-US' -ManualEntryPointSelectionAllowed 'Enabled'  
```  
  
To allow  Windows 7  client computers access through the first entry point through the security group DA_Clients_US and using the GPO DA_W7_Clients_GPO_US.  
  
```  
Add-DAClient -EntrypointName 'Edge1-US' -DownlevelSecurityGroupNameList @('corp.contoso.com\DA_Clients_US') -DownlevelGpoName @('corp.contoso.com\DA_W7_Clients_GPO_US)  
```  
  
## <a name="BKMK_EntryPoint"></a>3.7. Add entry points to the multisite deployment  
After enabling multisite in your deployment, you can add additional entry points using the Add an Entry Point wizard. Before adding entry points, make sure you have the following information:  
  
-   Global load balancer IP addresses for each new entry point if you are using global load balancing.  
  
-   The security group(s) containing  Windows 7  client computers for each entry point that will be added if you want to enable Remote Access for  Windows 7  client computers.  
  
-   Group Policy Object names, if you are required to use non-default Group Policy Objects, which are applied on  Windows 7  client computers for each entry point that will be added, if you require support for  Windows 7  client computers.  
  
-   In the case where IPv6 is deployed in the organization's network you will need to prepare the IP-HTTPS prefix for the new entry point.  
  
### <a name="AddEP"></a>To add entry-points to your multisite deployment  
  
1.  On your existing Remote Access server: On the **Start** screen, type **RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**, and then in the **Tasks** pane, click **Add an Entry Point**.  
  
3.  In the Add an Entry Point Wizard, on the **Entry Point Details** page, in **Remote Access server**, enter the fully qualified domain name (FQDN) of the server to add. In **Entry point name**, enter the name of the entry point, and then click **Next**.  
  
4.  On the **Global Load Balancing Settings** page, enter the global load balancing IP address of this entry point, and then click **Next**.  
  
    > [!NOTE]  
    > The **Global Load Balancing Settings** page appears only when the multisite configuration uses a global load balancer.  
  
5.  On the **Network Topology** page, click the topology that corresponds with the network topology of the Remote Access server that you are adding, and then click **Next**.  
  
6.  On the **Network Name or IP Address** page, in **Type in the public name or IP address used by clients to connect to the remote access server**, enter the public name or IP address used by clients to connect to the Remote Access server. The public name corresponds with the subject name of the IP-HTTPS certificate. In the case where Edge network topology was implemented, the IP address is that of the external adapter of the Remote Access server. Click **Next**.  
  
7.  On the **Network Adapters** page, do one the following:  
  
    -   If you are deploying a topology with two network adapters, in **External adapter**, select the adapter that is connected to the external network. In **Internal adapter**, select the adapter that is connected to the internal network.  
  
    -   If you are deploying a topology with one network adapter, in **Network adapter**, select the adapter that is connected to the internal network.  
  
8.  On the **Network Adapters** page, in **Select the certificate used to authenticate IP-HTTPS connections**, click **Browse** to locate and select the IP-HTTPS certificate. Click **Next**.  
  
9. If IPv6 is configured on the corporate network, on the **Prefix Configuration** page, in **IPv6 prefix assigned to client computers**, enter an IP-HTTPS prefix to assign IPv6 addresses to DirectAccess client computers, and click **Next**.  
  
10. On the **Client Support** page, do one of the following:  
  
    -   To limit access to client computers running Windows 8 or later operating systems, click **Limit access to client computers running Windows 8 or a later operating system**, and then click **Next**.  
  
    -   To allow client computers running  Windows 7  to access this entry point, click **Allow client computers running Windows 7 to access this entry point**, and click **Add**. On the **Select Groups** dialog box, select the security group(s) that contain the  Windows 7  client computers that will connect to this entry point, click **OK**, and click **Next**.  
  
11. On the **Client GPO Settings** page, accept the default GPO for  Windows 7  client computers for this entry point, type the name of the GPO that you want Remote Access to create automatically, or click **Browse** to locate the GPO for  Windows 7  client computers, and click **Next**.  
  
    > [!NOTE]  
    > -   The **Client GPO Settings** page appears only when you configure the entry point to allow  Windows 7  client computers to access the entry point.  
    > -   You can optionally click **Validate GPOs** to ensure that you have the proper permissions for the selected GPO or GPOs for this entry point. If the GPO does not exist and will be automatically created, then create and link permissions are required. In the case where the GPOs were created manually, then edit, modify security, and delete permissions are required.  
  
12. On the **Server GPO Settings** page, accept the default GPO for this Remote Access server, type the name of the GPO that you want Remote Access to create automatically, or click **Browse** to locate the GPO for this server, and then click **Next**.  
  
13. On the **Network Location Server** page, click **Browse** to select the certificate for the network location server website running on the Remote Access server, and then click **Next**.  
  
    > [!NOTE]  
    > The **Network Location Server** page appears only when the network location server website is running on the Remote Access server.  
  
14. On the **Summary** page, review the entry point settings, and then click **Commit**.  
  
15. On the **Adding Entry Point** dialog box, click **Close** and then on the Add an Entry Point Wizard, click **Close**.  
  
    > [!NOTE]  
    > If the entry point that was added is in a different forest than the existing entry points or client computers, then it is required to click **Refresh Management Servers** in the **Tasks** pane to discover the domain controllers and Configuration Manager in the new forest.  
  
16. Repeat this procedure from step 2 for every entry point that you want to add to your multisite deployment.  
  
![Windows PowerShell](../../../../media/Step-3-Configure-the-Multisite-Deployment/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To add the computer edge2 from the corp2 domain as a second entry point named Edge2-Europe. The entry point configuration is: a client IPv6 prefix '2001:db8:2:2000::/64', a connect to address (the IP-HTTPS certificate on the edge2 computer) 'edge2.contoso.com', a server GPO named "DirectAccess Server Settings - Edge2-Europe", and the internal and external interfaces named Internet and Corpnet2 respectively:  
  
```  
Add-DAEntryPoint -RemoteAccessServer 'edge2.corp2.corp.contoso.com' -Name 'Edge2-Europe' -ClientIPv6Prefix '2001:db8:2:2000::/64' -ConnectToAddress 'Europe.contoso.com' -ServerGpoName 'corp2.corp.contoso.com\DirectAccess Server Settings - Edge2-Europe' -InternetInterface 'Internet' -InternalInterface 'Corpnet2'  
```  
  
To allow  Windows 7  client computers access through the second entry point through the security group DA_Clients_Europe and using the GPO DA_W7_Clients_GPO_Europe.  
  
```  
Add-DAClient -EntrypointName 'Edge2-Europe' -DownlevelGpoName @('corp.contoso.com\ DA_W7_Clients_GPO_Europe') -DownlevelSecurityGroupNameList @('corp.contoso.com\DA_Clients_Europe')  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 2: Configure the multisite infrastructure](Step-2-Configure-the-Multisite-Infrastructure.md)
