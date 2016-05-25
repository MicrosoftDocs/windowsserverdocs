---
title: Walkthrough Guide: Connect to Applications and Services from Anywhere with Web Application Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b2e77ff3-b1f2-4bb0-be5d-51495d3fec5b
author: kgremban
---
# Walkthrough Guide: Connect to Applications and Services from Anywhere with Web Application Proxy
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This walkthrough provides instructions for connecting to applications and services from anywhere with [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]. For more information about connecting to applications and services from anywhere with [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], see [Connect to Applications and Services from Anywhere with Web Application Proxy](../Topic/Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md) and the video for [Installing the Web Application Proxy](http://go.microsoft.com/fwlink/?LinkID=386488&clcid=0x409).  
  
Before you perform this walkthrough, make sure you have completed the lab setup guide, see [Set up the lab environment for AD FS in Windows Server 2012 R2](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md). Also make sure you have completed the following planning steps that are required in order to deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and publish applications through it using [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] for authentication and authorization, including workplace join, multifactor authentication \(MFA\), and multifactor access control.  
  
-   Plan the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] infrastructure—Before you deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you must plan the infrastructure. For this walkthrough, this includes:  
  
    -   The [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server should be located between the corporate network and the Internet; in this walkthrough, this is achieved by configuring two network adapters on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
    -   For clients to reach a published web application they must be able to resolve the external address of the application that is published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]. In this walkthrough, this is achieved through the hosts file on the client.  
  
-   Plan the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server  
  
    -   It is recommended to join the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to the [!INCLUDE[ad_adds_3](../Token/ad_adds_3_md.md)] domain. Joining the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to the domain allows you to expand this walkthrough to demonstrate publishing applications that use Integrated Windows authentication.  
  
    -   Make sure that the server time of the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers are synchronized.  
  
    -   To install the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service, you must have local administrator permissions on the server.  
  
    -   To configure the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to connect to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], you are required to enter the credentials of the local administrator on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server.  
  
    -   Make sure that there is a certificate in the Personal certificates store on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that covers the federation service name. This certificate is required for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality.  
  
        To locate the federation service name value, open the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console, click **Service**, in the **Actions** pane, click **Edit Federation Service Properties**, and then find the value in the **Federation Service name** text box.  
  
    -   Make sure that there is a certificate in the Personal certificates store on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that covers the external address of the sample web application; that is, the address that you will configure when you publish the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]. In this walkthrough, you can use a self\-signed certificate, or a certificate from an Enterprise certification authority \(CA\).  
  
    > [!NOTE]  
    > In a production environment, it is recommended to use certificates from a public CA on your [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
|Task|Description|  
|--------|---------------|  
|[Step 1: Attempt to access the web application from an Internet client](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_1.1)|Configure an edge server and demonstrate that before configuring [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and publishing the application, the web application server is protected from the Internet, and clients are unable to access the application.|  
|[Step 2: Configure the Web Application Proxy server and publish the application](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_1.2)|Configure the edge server as a [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, publish the web application, and demonstrate that with the default [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] authentication scheme, a client device can access the published application from the Internet.|  
|[Step 3: Configure and test accessing a website using Integrated Windows authentication](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_3)|Configure an additional website on WebServ1 to use Integrated Windows authentication, configure Kerberos constrained delegation in the lab, publish the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], and demonstrate accessing this application from the Internet.|  
|[Step 4: Demonstrate accessing an application using Workplace Join, MFA, and multifactor access control](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_4)|Configure Workplace Join, multifactor authentication \(MFA\), and multifactor access control, and demonstrate how these additional authentication factors change the user experience when client devices attempt to access the published web application.|  
  
## <a name="BKMK_1.1"></a>Step 1: Attempt to access the web application from an Internet client  
In this step, you will configure an edge server and attempt to access the sample application. This step does not install the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service on the server. After configuring the edge server you will modify the hosts file on the client computer and attempt to connect to the sample web application through the edge server.  
  
#### To install the edge server  
  
1.  Create a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] server with two network adapters, one connected to the corporate network, one connected to the simulated Internet.  
  
2.  Configure the static IP addresses on the server. For example, the network adapter on the corporate network should have an IP address of 10.0.0.2, the network adapter on the simulated Internet should have an IP address of 131.107.0.2.  
  
3.  Join the server to the [!INCLUDE[ad_adds_3](../Token/ad_adds_3_md.md)] domain.  
  
#### To access the application  
  
1.  In your lab environment, connect the client computer to the simulated Internet network and assign a static IP address; for example 131.107.0.10.  
  
2.  On the client computer, open Notepad as the administrator.  
  
3.  In the Notepad window, open the hosts file located at %windir%\\System32\\Drivers\\etc.  
  
4.  Add two new lines to the file; for example:  
  
    ```  
    131.107.0.2       webserv1.contoso.com  
    131.107.0.2       adfs1.contoso.com  
    131.107.0.2       enterpriseregistration.contoso.com  
    ```  
  
    -   The first line contains the IP address of the Internet adapter of the edge server and the external address of the sample application that you will configure when you publish the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)].  
  
    -   The second line contains the same IP address and the address of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
    -   The third line contains the same IP address and the address required for Workplace Join.  
  
5.  Open an Internet explorer window and go to the sample web application; for example, https:\/\/webserv1.contoso.com\/claimapp\/.  
  
    The edge server is not providing proxy or publishing functionality; therefore, you will not be able to access the application.  
  
## <a name="BKMK_1.2"></a>Step 2: Configure the Web Application Proxy server and publish the application  
In this step you will:  
  
-   Configure the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
-   Connect the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server using the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard.  
  
-   Publish the sample application.  
  
-   Attempt to connect to the sample application using the default [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] authentication scheme.  
  
Before you can publish the application, make sure you have done the following:  
  
-   Create a relying party trust for the sample application in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console. If you did not do this when setting up your environment, see [Create a relying party trust on your federation server](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_11).  
  
-   Verify that a certificate on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server is suitable for the sample application you want to publish.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To install the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service  
  
1.  On the edge server, open Server Manager. To do this, click **Server Manager** on the **Start** screen, or **Server Manager** in the taskbar on the desktop.  
  
2.  In the **Quick Start** tab of the **Welcome** tile on the **Dashboard** page, click **Add roles and features**. Alternatively, you can click **Add Roles and Features** on the **Manage** menu.  
  
3.  In the **Add Roles and Features Wizard**, click **Next** three times to get to the server role selection screen.  
  
4.  On the **Select server roles** dialog, select **Remote Access**, and then click **Next**.  
  
5.  Click **Next** twice.  
  
6.  On the **Select role services** dialog, select **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**, click **Add Features**, and then click **Next**.  
  
7.  On the **Confirm installation selections** dialog, click **Install**.  
  
8.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Install-WindowsFeature Web-Application-Proxy -IncludeManagementTools  
```  
  
#### To configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open the Remote Access Management console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**RAMgmtUI.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the Remote Access Management console, in the navigation pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**.  
  
3.  In the middle pane, click **Run the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard**.  
  
4.  In the **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard**, on the **Welcome** dialog, click **Next**.  
  
5.  On the **Federation Server** dialog, do the following, and then click **Next**:  
  
    -   In the **Federation service name** box, enter the fully qualified domain name \(FQDN\) of the federation service; for example, adfs1.contoso.com.  
  
        To locate this value, open the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console, click **Service**, in the **Actions** pane, click **Edit Federation Service Properties**, and then find the value in the **Federation Service name** text box.  
  
    -   In the **User name** and **Password** boxes, enter the credentials of a local administrator account on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
6.  On the **AD FS Proxy Certificate** dialog, in the list of certificates currently installed on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, select a certificate to be used by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality, and then click **Next**.  
  
7.  On the **Confirmation** dialog, review the settings. If required, you can copy the PowerShell cmdlet to automate additional installations. Click **Configure**.  
  
8.  On the **Results** dialog, verify that the configuration was successful, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following command will prompt you to enter credentials of a local administrator account on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
```  
Install-WebApplicationProxy –CertificateThumprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b' -FederationServiceName adfs1.contoso.com  
```  
  
#### To publish the sample claims\-based application  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, in the Remote Access Management console, in the **Navigation** pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **[!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)]**, and then click **Next**.  
  
4.  On the **Relying Party** page, in the list of relying parties select the relying party for the sample application, and then click **Next**.  
  
5.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https:\/\/webserv1.contoso.com\/claimapp\/.  
  
    -   In the **External certificate** list, select a certificate whose subject name covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL.  
  
6.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command set up additional published applications.  
  
7.  On the **Results** page, make sure that application published successfully, and then click **Close**.  
  
    Publishing the application may take a couple of minutes.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://webserv1.contoso.com/claimapp/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://webserv1.contoso.com/claimapp/'  
    -Name 'Claims App'  
    -ExternalPreAuthentication ADFS  
    -ADFSRelyingPartyName 'App_Relying_Party'  
```  
  
#### To access the application  
  
1.  On the client computer, open an Internet explorer window and go to the sample web application; for example, https:\/\/webserv1.contoso.com\/claimapp\/.  
  
2.  On the sign in page, enter the credentials of the test user that you created when you set up the environment.  
  
3.  The application appears in the web browser.  
  
## <a name="BKMK_3"></a>Step 3: Configure and test accessing a website using Integrated Windows authentication  
In this step you will configure a website on WebServ1 to use Integrated Windows authentication. You can publish this website as an additional application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to demonstrate how [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] uses Kerberos constrained delegation to authenticate users to non\-claims\-based applications.  
  
> [!IMPORTANT]  
> You must join the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to the [!INCLUDE[ad_adds_1](../Token/ad_adds_1_md.md)] domain before you can publish applications that use Integrated Windows authentication.  
  
### <a name="InstallWindowsAuth"></a>Install Windows Authentication on WebServ1  
When you install the Web Server \(IIS\) role, by default, it does not install the option to use Integrated Windows authentication \(referred to by IIS as Windows Authentication\). This procedure installs Windows Authentication.  
  
##### To install Windows Authentication on WebServ1  
  
1.  On the edge server, open [!INCLUDE[sm](../Token/sm_md.md)]. To do this, click **[!INCLUDE[sm](../Token/sm_md.md)]** on the **Start** screen, or **[!INCLUDE[sm](../Token/sm_md.md)]** in the taskbar on the desktop.  
  
2.  In the **Quick Start** tab of the **Welcome** tile on the **Dashboard** page, click **Add roles and features**. Alternatively, you can click **Add Roles and Features** on the **Manage** menu.  
  
3.  In the **Add Roles and Features Wizard**, click **Next** three times to get to the server role selection screen.  
  
4.  On the **Select server roles** dialog, expand **Web Server \(IIS\)**, expand **Web Server**, expand **Security**, select **Windows Authentication**, and then click **Next**.  
  
5.  On the **Select features** dialog, click **Next**.  
  
6.  On the **Confirm installation selections** dialog, click **Install**.  
  
7.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
### <a name="NewSite"></a>Create a new website using IIS  
The WebServ1 server already hosts a website that uses claims\-based authentication. This procedure creates a new website that uses Integrated Windows authentication.  
  
##### To create a new website  
  
1.  Open an Explorer window and go to C:\\inetpub\\.  
  
2.  Create a new folder called NonClaims.  
  
3.  Open C:\\inetpub\\wwwroot\\ and copy the contents to the new folder C:\\inetpub\\NonClaims\\.  
  
    > [!IMPORTANT]  
    > Do not copy the web.config file.  
  
4.  [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**inetmgr.exe**, and then press ENTER.  
  
5.  In the IIS console, in the **Connections** pane, expand **WebServ1**, expand **Sites**, right\-click **Default Web Site**, and then click **Add Virtual Directory**.  
  
6.  On the **Add Virtual Directory** dialog box, in the **Alias** box, type **NonClaims**.  
  
7.  Next to the **Physical Path** box, type **C:\\inetpub\\NonClaims**, and then click **OK**.  
  
8.  In the **Connections** pane, click the **NonClaims** virtual directory.  
  
9. In the middle pane, in the **IIS** section, double\-click **Authentication**.  
  
10. In the **Authentication** pane, right\-click **Anonymous Authentication**, and then click **Disable**. Right\-click **Windows Authentication**, and then click **Enable**.  
  
### <a name="RP"></a>Create a non\-claims\-aware relying party trust  
To publish the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you must first create a non\-claims\-aware relying party trust on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server.  
  
##### To create a non\-claims\-aware relying party trust  
  
1.  On the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server, in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console, in the left pane, click **Trust Relationships**.  
  
2.  In the **Actions** pane, click **Add Non\-Claims\-Aware Relying Party Trust**.  
  
3.  In the **Add Non\-Claims\-Aware Relying Party Trust Wizard**, on the **Welcome** page, click **Start**.  
  
4.  On the **Specify Display Name** page, in **Display name**, enter a name for this trust; for example, **Non\-Claims Application**, and then click **Next**.  
  
5.  On the **Configure Identifiers** page, in **Non\-claims\-aware relying party trust identifier**, enter an arbitrary URL as an identifier for this trust, click **Add**, and then click **Next**.  
  
6.  Click **Next** twice.  
  
7.  On the **Finish** page, click **Close**.  
  
    The **Edit Claim Rules for <relying party>** dialog box opens.  
  
8.  On the **Edit Claim Rules for <relying party>**, click **Add Rule**.  
  
9. In the **Add Issuance Authorization Claim Rule Wizard**, on the **Select Rule Template** page, in the **Claim rule template** list, select **Permit All Users**, and then click **Next**.  
  
10. On the **Configure Rule** page, click **Finish**, and then on the **Edit Claim Rules for <relying party>** dialog box, click **OK**.  
  
### <a name="Kerberos"></a>Configure Kerberos constrained delegation  
To allow users to access applications that use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server must be able to provide impersonation for users to the published application.  
  
> [!TIP]  
> This procedure assumes that the Web Application Proxy server is named EDGE1.  
  
##### To configure Kerberos constrained delegation  
  
1.  On the domain controller, open [!INCLUDE[sm](../Token/sm_md.md)]. To do this, click **[!INCLUDE[sm](../Token/sm_md.md)]** on the **Start** screen, or **[!INCLUDE[sm](../Token/sm_md.md)]** in the taskbar on the desktop.  
  
2.  Click **Tools**, and then click **ADSI Edit**.  
  
3.  On the **Action** menu, click **Connect To**, and then on the **Connection Settings** dialog box, accept the default settings to connect to the default naming context, and then click **OK**.  
  
4.  In the left pane, expand **Default naming context**, expand **DC\=contoso,DC\=com**, expand **CN\=Computers**, right\-click **CN\=EDGE1**, and then click **Properties**.  
  
5.  On the **CN\=EDGE1 Properties** dialog box, on the **Attribute Editor** tab, in the **Attributes** list, select **servicePrincipalName**, and then click **Edit**.  
  
6.  On the **Multi\-valued String Editor** dialog box, in **Value to add**, enter **HTTP\/EDGE1.contoso.com** and click **Add**. Then enter **HTTP\/EDGE1** and click **Add**.  
  
    The **Values** list now contains two new entries; for example, **HTTP\/EDGE1.contoso.com** and **HTTP\/EDGE1**.  
  
7.  On the **Multi\-valued String Editor** dialog box, click **OK**.  
  
8.  On the **CN\=EDGE1 Properties** dialog box, click **OK**.  
  
9. In [!INCLUDE[sm](../Token/sm_md.md)], click **Tools**, and then click **Active Directory Users and Computers**.  
  
10. In the navigation pane, under **contoso.com**, click **Computers**. In the details pane, right\-click the edge server, and then click **Properties**.  
  
11. On the **EDGE1 Properties** dialog box, on the **Delegation** tab, click **Trust this computer for delegation to specified services only**, and then click **Use any authentication protocol**.  
  
12. Click **Add**, and on the **Add Services** dialog box, click **Users or Computers**.  
  
13. On the **Select Users or Computers** dialog box, in **Enter the object names to select**, enter the name of the web server; for example, WebServ1, and then click **OK**.  
  
14. On the **Add Services** dialog box, in the **Available services** list, select the **http** service type, and then click **OK**.  
  
15. On the **EDGE1 Properties** dialog box, click **OK**.  
  
### <a name="InternalAccess"></a>Test accessing the application internally  
To make sure that the application is working correctly, you should test accessing the application from the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server before continuing.  
  
##### To access the application internally  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, make sure that IE Enhanced Security Configuration is turned off.  
  
2.  Open an Internet explorer window and go to the non\-claims\-based web application; for example, https:\/\/webserv1.contoso.com\/nonclaims\/.  
  
3.  On the sign in page, enter the credentials of the test user that you created when you set up the environment.  
  
    The default IIS website appears.  
  
### <a name="PublishApp"></a>Publish the application  
You must publish the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to make it available to external users.  
  
##### To publish the non\-claims\-based application  
  
1.  On the Edge server, open the Remote Access Management console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**RAMgmtUI.exe**, and then press ENTER.  
  
2.  In the navigation pane, under **Configuration**, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**.  
  
3.  In the **Tasks** pane, click **Publish**.  
  
4.  In the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
5.  On the **Preauthentication** page, make sure that [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] is selected, and then click **Next**.  
  
6.  On the **Relying Party** page, select the non\-claims application relying party, and then click **Next**.  
  
7.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application to identify it in the list of published applications; for example, **Non\-Claims Application**.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, **https:\/\/WebServ1.contoso.com\/NonClaims\/**.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external address.  
  
    -   In the **Backend server URL** box, the value is entered automatically and is the same as the external URL.  
  
    -   In the **Backend server SPN** box, enter the service principal name for this application; for example, **HTTP\/WEBSERV1.contoso.com**.  
  
8.  On the **Confirmation** page, click **Publish**.  
  
9. On the **Results** page, click **Close**.  
  
### <a name="TestApp"></a>Test accessing the application  
After publishing the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you can test accessing the application from the simulated Internet.  
  
##### To test accessing the application  
  
1.  Connect the client computer to the simulated Internet network and assign a static IP address; for example 131.107.0.10.  
  
2.  Open an Internet explorer window and go to the non\-claims\-based web application; for example, https:\/\/webserv1.contoso.com\/nonclaims\/.  
  
3.  On the sign in page, enter the credentials of the test user that you created when you set up the environment.  
  
    The default IIS website appears.  
  
## <a name="BKMK_4"></a>Step 4: Demonstrate accessing an application using Workplace Join, MFA, and multifactor access control  
In this step you will join the client device to the workplace, and configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to enforce MFA, and multifactor access control when publishing the sample application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], and demonstrate that MFA and multifactor access control are working.  
  
> [!IMPORTANT]  
> For Workplace Join to succeed, the client computer \(Client1\) must trust the SSL certificate that was used to configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in [Step 2: Configure the Federation Server with Device Registration Service \(ADFS1\)](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_4). It must also be able to validate revocation information for the certificate. If you have any issues with Workplace Join, you can view the event log on Client1.  
>   
> To see the event log, open Event Viewer, expand **Applications and Services Logs**, expand **Microsoft** , expand **Windows** and click **Workplace Join**.  
  
#### To Workplace Join your device and access the application  
  
1.  On the client computer, on the **Start** screen, open the **Charms** bar and then select the **Settings** charm. Click **Change PC Settings**.  
  
2.  On the **PC Settings** page, click **Network**, and then click **Workplace**.  
  
3.  In the **Enter your UserID to get workplace access or turn on device management** box, type **RobertH@contoso.com** and then click **Join**.  
  
4.  When prompted for credentials, type **roberth@contoso.com**, and enter the password. Click **OK**.  
  
5.  You should now see the message: This device has joined your workplace network.  
  
6.  Open an Internet explorer window and go to the sample web application; for example, https:\/\/webserv1.contoso.com\/claimapp\/.  
  
7.  On the sign in page, enter the credentials of the test user \(RobertH\) that you created when you set up the environment.  
  
8.  The application appears in the web browser showing the claims in your security token. Notice that the token contains both user and device claims.  
  
#### To configure authentication options and attempt to access the application  
  
1.  Configure advanced authentication options such as MFA and user certificate as described in [Step 3: Configure MFA on your federation server](../Topic/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_3).  
  
2.  In your lab environment, connect the client computer to the simulated Internet network and assign a static IP address; for example 131.107.0.10.  
  
3.  Open an Internet explorer window and go to the sample web application; for example, https:\/\/webserv1.contoso.com\/claimapp\/.  
  
4.  On the sign in page, enter the credentials of the test user that you created when you set up the environment.  
  
    At this point, because of the MFA policy that you configured, the user will be prompted to undergo additional authentication.  
  
    This demonstrates that the additional authentication factor that you configured is now required to access the application.  
  
> [!TIP]  
> In this walkthrough, it is necessary to disable MFA before configuring multifactor access control.  
  
#### To configure multifactor access control and attempt to access the application  
  
1.  Configure multifactor access control as described in [Step 3: Configure multi\-factor access control policy based on user data](../Topic/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md#BKMK_3).  
  
2.  Disable MFA as follows:  
  
    1.  On the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server, in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console, navigate to **Authentication Policies\/Per Relying Party Trust**, and select the relying party trust that represents your sample application.  
  
    2.  In the **Actions** pane, click **Edit Custom Multi\-factor Authentication**.  
  
    3.  In the **Edit Relying Party Trust for <relying\_party\_trust\_name>** dialog box, in the **Users\/Groups** list, select the test group that you previously added, click **Remove**, and then click **OK**.  
  
3.  On the client computer, open an Internet explorer window and go to the sample web application; for example, https:\/\/webserv1.contoso.com\/claimapp\/.  
  
4.  On the sign in page, enter the credentials of the test user that you created when you set up the environment.  
  
    At this point, because of the access control policy that you set up in the previous steps, an ‘access denied’ message is displayed for this user, demonstrating that the access control rule is in effect.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Set up the lab environment for AD FS in Windows Server 2012 R2](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)  
  
-   [Connect to Applications and Services from Anywhere with Web Application Proxy](../Topic/Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md)  
  
