---
title: Prepare the Network and Server for WSUS 3.0 SP2
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a9fe03de-3bbe-4782-a570-8c35e104fabe
author: britw
---
# Prepare the Network and Server for WSUS 3.0 SP2
Before you install [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2, you must prepare the network and the server that is to host WSUS. This topic describes the following prerequisite tasks:  
  
-   [Configure the proxy server](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#proxy)  
  
-   [Configure the firewall](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#firewall)  
  
-   [Configure Internet Information Services \(IIS\)](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#iis)  
  
-   [Disable antivirus software](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#antiv)  
  
-   [Configure SQL Server](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#sql)  
  
## <a name="proxy"></a>Configure the proxy server  
If the corporate network uses proxy servers, the proxy servers must support HTTP and SSL protocols and use basic authentication or Windows authentication. These requirements can be met by using one of the following configurations:  
  
-   A single proxy server that supports two protocol channels. In this case, set one channel to use HTTP and the other channel to use HTTPS.  
  
    > [!NOTE]  
    > You can set up one proxy server that handles both protocols for WSUS during the WSUS server software installation.  
  
-   Two proxy servers, each of which supports a single protocol. In this case, one proxy server is configured to use HTTP, and the other proxy server is configured to use HTTPS.  
  
To set up two proxy servers, each of which will handle one protocol for WSUS, use the following procedure:  
  
### <a name="procproxy"></a>To set up WSUS to use two proxy servers  
  
1.  Log on to the computer that is to be the WSUS server by using an account that is a member of the local Administrators group.  
  
2.  Install the WSUS server software. For more information, see [Install the WSUS 3.0 SP2 server software through the user interface](assetId:///3bc2933c-8d26-4594-b989-e64b406f3147) or [Install the WSUS 3.0 SP2 server software in unattended mode](assetId:///2443408e-5bd2-4b1f-b0a5-7ee1452fe5bc). During the setup process, do not specify a proxy server.  
  
3.  [!INCLUDE[cmd_admin](../Token/cmd_admin_md.md)]  
  
4.  In the Command Prompt window, go to the *<WSUSInstallDrive>***\\Program Files\\Update Services\\Tools** folder, where *<WSUSInstallDrive>* is the drive where WSUS is installed. Type the following command:  
  
    **wsusutil ConfigureSSLProxy \[<***proxy\_server proxy\_port***>\] \-enable**  
  
    where:  
  
    -   *proxy\_server* is the name of the proxy server that supports HTTPS.  
  
    -   *proxy\_port* is the proxy server port number.  
  
5.  Close the Command Prompt window.  
  
To add the proxy server that uses the HTTP protocol to the WSUS configuration, use the following procedure:  
  
#### To add a proxy server that uses the HTTP protocol  
  
1.  Open the WSUS Administration Console.  
  
2.  In the left pane, expand the server name, and then click **Options**.  
  
3.  In the **Options** pane, click **Update Source and Update Server**, and then click the **Proxy Server** tab.  
  
4.  Use the following options to modify the existing proxy server configuration.  
  
    -   To remove a proxy server from the WSUS configuration, clear the check box for **Use a proxy server when synchronizing**, and then click **OK**.  
  
    ###### To change or add a proxy server to the WSUS configuration  
  
    1.  Select the check box for **Use a proxy server when synchronizing**.  
  
    2.  In the **Proxy server name** text box, type the name of the proxy server.  
  
    3.  In the **Proxy port number** text box, type the port number of the proxy server. The default port number is 80.  
  
    4.  If the proxy server requires that you use a specific user account, select the **Use user credentials to connect to the proxy server** check box. Type the required user name, domain, and password into the corresponding text boxes.  
  
    5.  If the proxy server supports basic authentication, select the **Allow basic authentication \(password is sent in cleartext\)** check box.  
  
    6.  Click **OK**.  
  
## <a name="firewall"></a>Configure the firewall  
To synchronize with Microsoft Update, the WSUS server uses port 80 for the HTTP protocol and port 443 for the HTTPS protocol.  
  
These firewall settings are for a corporate firewall that exists between the WSUS server and the Internet. Because WSUS initiates its own network traffic, you do not have to configure Windows Firewall on the WSUS server.  
  
If your organization does not allow the required ports and protocols to be open to all Internet addresses, you can restrict access to specific domains. For more information, see the following articles in the Microsoft Knowledge Base:  
  
-   [Article 896226](http://go.microsoft.com/fwlink/?LinkID=205272)  
  
-   [Article 885819](http://go.microsoft.com/fwlink/?LinkID=205273)  
  
## <a name="iis"></a>Configure Internet Information Services  
WSUS requires that [!INCLUDE[iis_nover](../Token/iis_nover_md.md)] be installed on the same server as the WSUS server software. If you install WSUS on a server that is running at least [!INCLUDE[1st_WindowsServLonghorn](../Token/1st_WindowsServLonghorn_md.md)], IIS can be installed at the same time that you install WSUS by using Server Manager. For all other operating systems and installation methods, you must install IIS before you install WSUS. This article assumes that IIS is already installed.  
  
> [!NOTE]  
> For more information about IIS, see [The Official Microsoft IIS Site](http://go.microsoft.com/fwlink/?LinkId=160582).  
  
For WSUS, the IIS default website must be present, running, and configured to use port 80. We recommend that you configure WSUS to use port 8530. The default IIS website and the WSUS administration site must use the same IP address and the same host header.  
  
If any IIS component is installed in 32\-bit compatibility mode on a 64\-bit platform, the WSUS 3.0 SP2 installation can fail. Confirm that all IIS components are installed in native mode on a 64\-bit platform.  
  
> [!WARNING]  
> WSUS 3.0 SP2 setup restarts IIS without notification. This restart can disrupt existing websites. As a best practice, notify affected parties in advance of the WSUS installation. If IIS is not running, WSUS 3.0 SP2 setup will start IIS during setup.  
  
### Disable IIS 5.0 isolation mode  
If the server was upgraded from Windows 2000 Server to Windows Server 2003, or if it is configured in this manner for another reason, IIS 6.0 might be running in IIS 5.0 compatibility mode. This issue is not relevant for IIS 7.0 installations.  
  
You must disable IIS 5.0 isolation mode in IIS 6.0 before you install WSUS 3.0 SP2. For instructions about how to disable IIS 5.0 isolation mode, also referred to as worker process isolation mode, see the procedure “Configuring IIS for Worker Process Isolation Mode” in [Configuring Isolation Modes \(IIS 6.0\)](http://go.microsoft.com/fwlink/?LinkID=205318) on TechNet.  
  
### IIS 7.0 services  
The following IIS services must be installed and running for WSUS to work:  
  
-   HTTP Static Content  
  
-   ASP.NET  
  
-   Windows authentication  
  
-   Dynamic content compression  
  
-   IIS Metabase Compatibility  
  
To confirm that the required IIS services are installed and running in a Windows Server 2008 environment that is running IIS 7.0, you can perform the following procedure:  
  
##### To view and install IIS services  
  
1.  Click **Start**, click **All Programs**, click **Administrative Tools**, and then click **Server Manager**  
  
2.  Expand **Roles** and then click **Web Server \(IIS\)**.  
  
3.  In the Web Server \(IIS\) pane, scroll to **Role Services** and confirm that the required services are installed and running. To install a required service, click **Add Role Services** and follow the on\-screen instructions.  
  
### Anonymous access  
By default, WSUS uses the IIS default website. We recommend that you create and use a custom WSUS website that uses a custom port. The website that is used by WSUS must enable anonymous read access by the following accounts:  
  
-   Windows Server 2008 with IIS 7.0: **IUSR**  
  
-   Windows Server 2003 with IIS 6.0: **IUSR\_***servername*  
  
By default, anonymous read access is enabled for the default and all new IIS websites. Some applications, notably Windows SharePoint Services, remove anonymous access. If this has occurred, you must re\-enable the anonymous read access before you can successfully install and operate WSUS.  
  
To enable anonymous read access, follow the steps for the applicable version of IIS:  
  
-   [Enable Anonymous Authentication \(IIS 7\)](http://go.microsoft.com/fwlink/?LinkID=205316) in the IIS 7 Operations Guide.  
  
-   [Enabling Anonymous Authentication \(IIS 6.0\)](http://go.microsoft.com/fwlink/?LinkId=211391) in the IIS 6.0 Operations Guide.  
  
### Modify the IIS 7.0 configuration file  
If the server is running [!INCLUDE[iisver](../Token/iisver_md.md)], and if you have already customized the **applicationHost.config** file, use the following procedure to update the IIS configuration file before you install WSUS.  
  
##### To modify the IIS configuration file  
  
1.  Right\-click **Start**, and then click **Windows Explorer**.  
  
2.  Navigate to the `%WINDIR%\system32\inetsrv\config` folder.  
  
3.  Right\-click the **applicationHost.config** file, point to **Open with**, and select a program to change the file.  
  
    > [!TIP]  
    > You can use Notepad to change the configuration file.  
  
4.  Under `<system.Webserver>`, under `<modules>`, remove the following line:  
  
    ```  
    add name="CustomErrorModule" lockItem="true" />  
    ```  
  
5.  Under `<system.Webserver>`, under `<modules>`, add the following line:  
  
    ```  
    remove name="CustomErrorModule"   
    ```  
  
6.  Click **File** and then click **Save** to save the changes to the file.  
  
## <a name="antiv"></a>Disable antivirus software  
Before you install WSUS 3.0 SP2, we recommend that you disable antivirus software and then restart the computer to prevent files from being locked during WSUS installation. After the WSUS installation is complete, you should enable the antivirus software.  
  
## <a name="sql"></a>Configure SQL Server  
You can use WSUS with any database software that is listed in the [WSUS database options](../Topic/Design-a-WSUS-Storage-Strategy.md#wsusdb) section of [WSUS 3.0 SP2 system requirements](assetId:///e8f62aba-4c8d-410e-9012-e3c9680a929b).  
  
> [!NOTE]  
> For the latest information about all supported versions of SQL Server, see the [SQL Server TechCenter](http://go.microsoft.com/fwlink/?LinkID=108895).  
  
> [!IMPORTANT]  
> You cannot run the SQL Server service under a local non\-system account or by using SQL authentication. WSUS supports Windows authentication only. To change the SQL Server authentication mode, see [How to: Change Server Authentication Mode](http://go.microsoft.com/fwlink/?LinkID=202961).  
  
You must enable nested triggers in SQL Server before you install WSUS 3.0 SP2. For instructions about how to enable nested triggers, see [How to: Configure the nested triggers Option \(SQL Server Management Studio\)](http://go.microsoft.com/fwlink/?LinkID=202951).  
  
### Configure SQL Server for remote access by WSUS  
WSUS 3.0 SP2 supports a database that resides on a computer that is separate from the WSUS server. For remote database requirements, see [WSUS database requirements](assetId:///e8f62aba-4c8d-410e-9012-e3c9680a929b#WSUSdb).  
  
##### To configure WSUS to use a remote database  
  
1.  Install and configure at least [!INCLUDE[1st_ssVersion2005](../Token/1st_ssVersion2005_md.md)] SP3 on a back\-end server. For instructions about how to install SQL Server, see [SQL Server Installation \(SQL Server 2008 R2\)](http://go.microsoft.com/fwlink/?LinkID=202944).  
  
2.  Enable SQL Server remote connections for the database server. If you use Kerberos authentication, you must also register a service principal name \(SPN\) for the database server. These tasks are described in the following documents:  
  
    -   To enable remote connections in SQL Server, see [To configure the Database Engine to accept remote connections](http://go.microsoft.com/fwlink/?LinkID=202940) and [Surface Area Configuration for Services and Connections \(Remote Connections\) \- Database Engine](http://go.microsoft.com/fwlink/?LinkID=202939).  
  
    -   To register an SPN for the database server, see [Registering a Service Principal Name](http://go.microsoft.com/fwlink/?LinkID=202942).  
  
3.  Install WSUS on a front\-end server. During the installation, you can configure WSUS to use the remote database. The account that is used to install WSUS must be a SQL Server **sysadmin** account, or the server account must have **CREATE DATABASE** rights. The master database must be set as the SQL Server logon default database. For more information about SQL Server accounts and roles, see [Principals \(Database Engine\)](http://go.microsoft.com/fwlink/?LinkID=202963) and [Database\-Level Roles](http://go.microsoft.com/fwlink/?LinkID=202964).  
  
