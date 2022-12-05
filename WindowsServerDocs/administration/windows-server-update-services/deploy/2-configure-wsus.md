---
title: Step 2 - Configure WSUS
description: Windows Server Update Services (WSUS) topic - Configure WSUS is step two in a four-step process for deploying WSUS.
ms.topic: article
ms.assetid: d4adc568-1f23-49f3-9a54-12a7bec5f27c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 9/18/2020
---

# Step 2: Configure WSUS

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

After you install the Windows Server Update Services (WSUS) server role on your server, you need to properly configure it. You also need to configure your client computers to receive their updates from the WSUS server.

This article walks you through the following procedures:

|Task|Description|
|----|--------|
|[2.1. Configure network connections](#21-configure-network-connections)|Configure your firewall and proxy settings to allow the server to make the connections that it needs.|
|[2.2. Configure WSUS by using the WSUS Configuration Wizard](#22-configure-wsus-by-using-the-wsus-configuration-wizard)|Use the WSUS Configuration Wizard to perform the base WSUS configuration.|
|[2.3. Secure WSUS with the Secure Sockets Layer protocol](#23-secure-wsus-with-the-secure-sockets-layer-protocol)|Configure the Secure Sockets Layer (SSL) protocol to help protect WSUS.|
|[2.4. Configure WSUS computer groups](#24-configure-wsus-computer-groups)|Create computer groups in the WSUS Administration Console to manage updates in your organization.|
|[2.5. Configure client computers to establish SSL connections with the WSUS server](#25-configure-client-computers-to-establish-ssl-connections-with-the-wsus-server)|Set up the client computers to establish secure connections to the WSUS server.|
|[2.6. Configure client computers to receive updates from the WSUS server](#26-configure-client-computers-to-receive-updates-from-the-wsus-server)|Set up the client computers to receive their updates from the WSUS server.|

## 2.1. Configure network connections

Before you start the configuration process, be sure that you know the answers to the following questions:

- Is the server's firewall configured to allow clients to access the server?

- Can this computer connect to the upstream server (such as the server that's designated to download updates from Microsoft Update)?

- Do you have the name of the proxy server and the user credentials for the proxy server, if you need them?

You can then start configuring the following WSUS network settings:

- **Updates**: Specify the way this server will get updates (from Microsoft Update or from another WSUS server).

- **Proxy**: If you identified that WSUS needs to use a proxy server to have internet access, you need to configure proxy settings in the WSUS server.

- **Firewall**: If you identified that WSUS is behind a corporate firewall, you'll have to take additional steps at the edge device to allow WSUS traffic.

> [!IMPORTANT]
> If you only have one WSUS server, it must have internet access, because it needs to download updates from Microsoft. If you have multiple WSUS servers, only one server needs internet access. The others only need network access to the internet-connected WSUS server. Your client computers don't need internet access; they only need network access to a WSUS server.

> [!TIP]
> If your network is "air gapped"--if it does not have access to the internet at all--you can still use WSUS to provide updates to client computers on the network. This approach requires two WSUS servers. One WSUS server with internet access collects the updates from Microsoft. A second WSUS server on the protected network serves the updates to the client computers. Updates are exported from the first server onto removable media, carried across the air gap, and imported onto the second server. This is an advanced configuration that's beyond the scope of this article.

### 2.1.1. Configure your firewall to allow your first WSUS server to connect to Microsoft domains on the internet

If a corporate firewall is between WSUS and the internet, you might have to configure that firewall to ensure that WSUS can get updates. To get updates from Microsoft Update, the WSUS server uses ports 80 and 443 for the HTTP and HTTPS protocols. Although most corporate firewalls allow this type of traffic, some companies restrict internet access from the servers because of security policies. If your company restricts access, you'll need to configure your firewall to allow your WSUS server to access Microsoft domains.

Your first WSUS server must have outbound access to ports 80 and 443 on the following domains:

- http\://windowsupdate.microsoft.com

- http\://\*.windowsupdate.microsoft.com

- https\://\*.windowsupdate.microsoft.com

- http\://\*.update.microsoft.com

- https\://\*.update.microsoft.com

- http\://\*.windowsupdate.com

- http\://download.windowsupdate.com

- https\://download.microsoft.com

- http\://\*.download.windowsupdate.com

- http\://wustat.windows.com

- http\://ntservicepack.microsoft.com

- http\://go.microsoft.com

- http\://dl.delivery.mp.microsoft.com

- https\://dl.delivery.mp.microsoft.com

- http\://*.delivery.mp.microsoft.com

- https\://*.delivery.mp.microsoft.com

> [!IMPORTANT]
> You must configure your firewall to allow the first WSUS server to access any URL within these domains. The IP addresses associated with these domains are constantly changing, so don't try to use IP address ranges instead.

For a scenario in which WSUS is failing to get updates because of firewall configurations, see [article 885819](https://support.microsoft.com/kb/885819) in the Microsoft Knowledge Base.

### 2.1.2. Configure the firewall to allow your other WSUS servers to connect to the first server 

If you have multiple WSUS servers, you should configure the other WSUS servers to access the first ("topmost") server. Your other WSUS servers will receive all their update information from the topmost server. This configuration allows you to manage your entire network by using the WSUS Administration Console on the topmost server. 

Your other WSUS servers must have outbound access to the topmost server through two ports. By default, these are ports 8530 and 8531. You can change these ports, as described later in this article.

> [!NOTE]
> If the network connection between the WSUS servers is slow or expensive, you can configure one or more of the other WSUS servers to receive update payloads directly from Microsoft. In this case, only a small amount of data will be sent from those WSUS servers to the topmost server. For this configuration to work, the other WSUS servers must have access to the same internet domains as the topmost server.

> [!NOTE]
> If you have a large organization, you can use chains of connected WSUS servers, rather than having all your other WSUS servers connect directly to the topmost server. For example, you can have a second WSUS server that connects to the topmost server, and then have other WSUS servers connect to the second WSUS server.

### 2.1.3. Configure your WSUS servers to use a proxy server, if needed

If the corporate network uses proxy servers, the proxy servers must support HTTP and HTTPS protocols. They also must use basic authentication or Windows authentication. You can meet these requirements by using one of the following configurations:

- A single proxy server that supports two protocol channels. In this case, set one channel to use HTTP and the other channel to use HTTPS.

  > [!NOTE]
  > You can set up one proxy server that handles both protocols for WSUS during the installation of WSUS server software.

- Two proxy servers, each of which supports a single protocol. In this case, one proxy server is configured to use HTTP, and the other proxy server is configured to use HTTPS.

#### To set up WSUS to use two proxy servers

1. Log on to the computer that will be the WSUS server by using an account that's a member of the Local Administrators group.

2. Install the WSUS server role. During the WSUS Configuration Wizard, don't specify a proxy server.

3. Open a command prompt (*Cmd.exe*) as an administrator:

   1. Go to **Start**. 
   1. In **Start Search**, type **Command prompt**. 
   1. At the top of the start menu, right-click **Command prompt**, and then select **Run as administrator**. 
   1. If the **User Account Control** dialog box appears, enter the appropriate credentials (if requested), confirm that the action that it displays is what you want, and then select **Continue**.

4. In the command prompt window, go to the *C:\Program Files\Update Services\Tools* folder. Enter the following command:

    `wsusutil ConfigureSSLproxy [<proxy_server proxy_port>] -enable`
    
    In that command:

    - *proxy_server* is the name of the proxy server that supports HTTPS.

    - *proxy_port* is the port number of the proxy server.

5. Close the command prompt window.

#### To add a proxy server to the WSUS configuration

1. Open the WSUS Administration Console.

2. On the left pane, expand the server name, and then select **Options**.

3. On the **Options** pane, select **Update Source and Update Server**, and then select the **Proxy Server** tab.

4. Select the **Use a proxy server when synchronizing** checkbox.

5. In the **Proxy server name** text box, enter the name of the proxy server.

6. In the **Proxy port number** text box, enter the port number of the proxy server. The default port number is 80.

7. If the proxy server requires that you use a specific user account, select the **Use user credentials to connect to the proxy server** checkbox. Enter the required user name, domain, and password into the corresponding text boxes.

8. If the proxy server supports basic authentication, select the **Allow basic authentication (password is sent in cleartext)** checkbox.

9. Select **OK**.

#### To remove a proxy server from the WSUS configuration

1. Clear the **Use a proxy server when synchronizing** checkbox.

2. Select **OK**.

### 2.1.4. Configure your firewall to allow client computers to access a WSUS server

Your client computers will all connect to one of your WSUS servers. The client computer must have outbound access to two ports on the WSUS server. By default, these are ports 8530 and 8531.

## 2.2. Configure WSUS by using the WSUS Configuration Wizard

This procedure assumes that you're using the WSUS Configuration Wizard, which appears the first time you start the WSUS Management Console. Later in this topic, you'll learn how to perform these configurations by using the **Options** page.

#### To configure WSUS

1. On the left pane of Server Manager, select **Dashboard** > **Tools** > **Windows Server Update Services**.

    > [!NOTE]
    > If the **Complete WSUS Installation** dialog box appears, select **Run**. In the **Complete WSUS Installation** dialog box, select **Close** when the installation successfully finishes.

2. The WSUS Configuration Wizard opens. On the **Before you Begin** page, review the information, and then select **Next**.

3. Read the instructions on the **Join the Microsoft Update Improvement Program** page. Keep the default selection if you want to participate in the program, or clear the checkbox if you don't. Then select **Next**.

4. On the **Choose Upstream Server** page, select one of the two options: **Synchronize the updates with Microsoft Update** or **Synchronize from another Windows Server Update Services server**.

    If you choose to synchronize from another WSUS server:
    
    - Specify the server name and the port on which this server will communicate with the upstream server.

    - To use SSL, select the **Use SSL when synchronizing update information** checkbox. The servers will use port 443 for synchronization. (Make sure that this server and the upstream server support SSL.)

    - If this is a replica server, select the **This is a replica of the upstream server** checkbox.

5. After you select the options for your deployment, select **Next**.

6. On the **Specify Proxy Server** page, select the **Use a proxy server when synchronizing** checkbox. Then enter the proxy server name and port number (port 80 by default) in the corresponding boxes.

    > [!IMPORTANT]
    > You must complete this step if you identified that WSUS needs a proxy server to have internet access.

7. If you want to connect to the proxy server by using specific user credentials, select the **Use user credentials to connect to the proxy server** checkbox. Then enter the user name, domain, and password of the user in the corresponding boxes. 

   If you want to enable basic authentication for the user who is connecting to the proxy server, select the **Allow basic authentication (password is sent in cleartext)** checkbox.

8. Select **Next**. 

8. On the **Connect to Upstream Server** page, select **start Connecting**.

9. When WSUS connects to the server, select **Next**.

10. On the **Choose Languages** page, you have the option to select the languages from which WSUS will receive updates: all languages or a subset of languages. Selecting a subset of languages will save disk space, but it's important to choose all the languages that all the clients of this WSUS server need. 

    If you choose to get updates only for specific languages, select **Download updates only in these languages**, and then select the languages for which you want updates. Otherwise, leave the default selection.

    > [!WARNING]
    > If you select the option **Download updates only in these languages**, and this server has a downstream WSUS server connected to it, this option will force the downstream server to also use only the selected languages.

11. After you select the language options for your deployment, select **Next**.

12. The **Choose Products** page allows you to specify the products for which you want updates. Select product categories, such as Windows, or specific products, such as Windows Server 2012. Selecting a product category selects all the products in that category.

13. After you select the product options for your deployment, select **Next**.

14. On the **Choose Classifications** page, select the update classifications that you want to get. Choose all the classifications or a subset of them, and then select **Next**.

15. The **Set Sync Schedule** page enables you to select whether to perform synchronization manually or automatically.

    - If you select **Synchronize manually**, you must start the synchronization process from the WSUS Administration Console.

    - If you select **Synchronize automatically**, the WSUS server will synchronize at set intervals.

    Set the time for **First synchronization**, and then specify the number of synchronizations per day that you want this server to perform. For example, if you specify four synchronizations per day, starting at 3:00 AM, synchronizations will occur at 3:00 AM, 9:00 AM, 3:00 PM, and 9:00 PM.

16. After you select the synchronization options for your deployment, select **Next**.

17. On the **Finished** page, you have the option to start the synchronization now by selecting the **Begin initial synchronization** checkbox. 

    If you don't select this option, you need to use the WSUS Management Console to perform the initial synchronization. Select **Next** if you want to read more about additional settings, or select **Finish** to conclude this wizard and finish the initial WSUS setup.

18. After you select **Finish**, the WSUS Administration Console appears. You'll use this console to manage your WSUS network, as described later on.

## 2.3. Secure WSUS with the Secure Sockets Layer protocol

You should use the SSL protocol to help secure your WSUS network. WSUS can use SSL to authenticate connections and to encrypt and protect update information.

> [!WARNING]
> Securing WSUS by using the SSL protocol is important for the security of your network. If your WSUS server does not properly use SSL to secure its connections, an attacker might be able to modify crucial update information as it's sent from one WSUS server to another, or from the WSUS server to the client computers. *This will allow the attacker to install malicious software on client computers.*

> [!IMPORTANT]
> Clients and downstream servers that are configured to use Transport Layer Security (TLS) or HTTPS must also be configured to use a fully qualified domain name (FQDN) for their upstream WSUS server.

### 2.3.1. Enable SSL/HTTPS on the WSUS server's IIS service to use SSL/HTTPS

To begin the process, you must enable SSL support on the WSUS server's IIS service. This effort involves creating an SSL certificate for the server.

The steps that are required to get an SSL certificate for the server are beyond the scope of this article and will depend on your network configuration. For more information and for instructions about how to install certificates and set up this environment, we suggest the following articles:

- [Suite B PKI step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ff829847(v=ws.10))

- [Implementing and administering certificate templates](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731256(v=ws.10))

- [Active Directory Certificate Services upgrade and migration guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc742515(v=ws.10))

- [Configure certificate autoenrollment](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731522(v=ws.11))

### 2.3.2. Configure the WSUS server's IIS web server to use SSL for some connections

WSUS requires two ports for connections to other WSUS servers and to client computers. One port uses SSL/HTTPS to send update *metadata* (crucial information about the updates). By default, this is port 8531. A second port uses HTTP to send update payloads. By default, this is port 8530.

> [!IMPORTANT]
> You can't configure the entire WSUS website to require SSL. WSUS is designed to encrypt update metadata only. This is the same way that Windows Update distributes updates. 
>
> To guard against an attacker tampering with the update payloads, all update payloads are signed through a specific set of trusted signing certificates. In addition, a cryptographic hash is computed for each update payload. The hash is sent to the client computer over the secure HTTPS metadata connection, along with the other metadata for the update. When an update is downloaded, the client software verifies the payload's digital signature and hash. If the update has been changed, it's not installed.

You should require SSL only for these IIS virtual roots:

- **SimpleAuthWebService**

- **DSSAuthWebService**

- **ServerSyncWebService**

- **APIremoting30**

- **ClientWebService**

You should not require SSL for these virtual roots:

- **Content**

- **Inventory**

- **ReportingWebService**

- **SelfUpdate**

The certificate of the certification authority (CA) must be imported into each WSUS server's Trusted Root CA store for the local computer, or the Trusted Root CA store for WSUS if it exists. 

For more information about how to use SSL certificates in IIS, see [Require Secure Sockets Layer (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732367(v=ws.10)).

> [!IMPORTANT]
> You must use the certificate store for the local computer. You can't use a user's certificate store.

Normally, you should configure IIS to use port 8531 for HTTPS connections and port 8530 for HTTP connections. If you change these ports, you must use two adjacent port numbers. The port number used for HTTP connections must be exactly 1 less than the port number used for HTTPS connections.

You must reinitialize *ClientServicingProxy* if the server name, SSL configuration, or port number has changed.

### 2.3.3. Configure WSUS to use the SSL signing certificate for its client connections

1. Log on to the WSUS server by using an account that's a member of the WSUS Administrators group or the Local Administrators group.

2. Go to **Start**, type **CMD**, right-click **Command prompt**, and then select **Run as administrator**.

3. Go to the *%ProgramFiles%\\Update Services\\Tools\\* folder.

4. In the command prompt window, enter the following command:

    `wsusutil configuressl _certificateName_`

    In that command, *certificateName* is the DNS name of the WSUS server.

### 2.3.4. Secure the SQL Server connection, if needed

If you use WSUS with a remote SQL Server database, the connection between the WSUS server and the database server is not secured through SSL. This creates a potential attack vector. To help protect this connection, consider the following recommendations:

- Move the WSUS database to the WSUS server.

- Move the remote database server and the WSUS server to a private network.

- Deploy Internet Protocol security (IPsec) to help secure network traffic. For more information about IPsec, see [Creating and using IPsec policies](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730656(v=ws.10)).

### 2.3.5. Create a code-signing certificate for local publishing, if needed

In addition to distributing updates that Microsoft provides, WSUS supports local publishing. Local publishing allows you to create and distribute updates that you design yourself, with your own payloads and behaviors.

Enabling and configuring local publishing is beyond the scope of this article. For full details, see [Local publishing](/previous-versions/windows/desktop/bb902470(v=vs.85)).

> [!IMPORTANT]
> Local publishing is a complicated process and is often not needed. Before you decide to enable local publishing, you should carefully review the documentation and consider whether and how you'll use this functionality.

## 2.4. Configure WSUS computer groups

Computer groups are an important part of using WSUS effectively. Computer groups permit you to test and target updates to specific computers. There are two default computer groups: All Computers and Unassigned Computers. By default, when each client computer first contacts the WSUS server, the server adds that client computer to both of these groups.

You can create as many custom computer groups as you need to manage updates in your organization. As a best practice, create at least one computer group to test updates before you deploy them to other computers in your organization.

### 2.4.1. Choose an approach for assigning client computers to computer groups

There are two approaches to assigning client computers to computer groups. The right approach for your organization will depend on how you typically manage your client computers.

- **Server-side targeting**: This is the default approach. In this approach, you assign client computers to computer groups by using the WSUS Administration Console. 

  This approach gives you the flexibility to quickly move client computers from one group to another as circumstances change. But it means that new client computers must manually be moved from the Unassigned Computers group to the appropriate computer group.
- **Client-side targeting**: In this approach, you assign each client computer to computer groups by using policy settings set on the client computer itself. 

  This approach makes it easier to assign new client computers to the appropriate groups. You do so as part of configuring the client computer to receive updates from the WSUS server. But it means that client computers can't be assigned to computer groups, or moved from one computer group to another, through the WSUS Administration Console. Instead, the client computers' policies must be modified.

### 2.4.2. Enable client-side targeting, if appropriate

> [!IMPORTANT]
> Skip this step if you'll use server-side targeting.

1. In the WSUS Administration Console, under **Update Services**, expand the WSUS server, and then select **options**.

2. On the **General** tab on the **Options** pane, select **Use Group Policy or registry settings on computers**.

### 2.4.3. Create the desired computer groups

> [!NOTE]
> You must create computer groups by using the WSUS Administration Console, whether you use server-side targeting or client-side targeting to add client computers to the computer groups.

1. In the WSUS Administration Console, under **Update Services**, expand the WSUS server, expand **Computers**, right-click **All computers**, and then select **Add Computer Group**.

2. In the **Add Computer Group** dialog, for **Name**, specify the name of the new group. Then select **Add**.

## 2.5. Configure client computers to establish SSL connections with the WSUS server

Assuming that you've configured the WSUS server to help protect the client computers' connections by using SSL, you must configure the client computers to trust those SSL connections.

The WSUS server's SSL certificate must be imported into the client computers' Trusted Root CA store, or into the client computers' Automatic Update Service Trusted Root CA store if it exists.

> [!IMPORTANT]
> You must use the certificate store for the local computer. You can't use a user's certificate store.

The client computers must trust the certificate that you bind to the WSUS server. Depending on the type of certificate that's used, you might have to set up a service to enable the client computers to trust the certificate that's bound to the WSUS server.

If you're using local publishing, you should also configure the client computers to trust the WSUS server's code-signing certificate. For instructions, see [Local publishing](/previous-versions/windows/desktop/bb902470(v=vs.85)).

## 2.6. Configure client computers to receive updates from the WSUS server

By default, your client computers receive updates from Windows Update. They must be configured to receive updates from the WSUS server instead.

> [!IMPORTANT]
> This article presents one set of steps for configuring client computers by using Group Policy. These steps are appropriate in many situations. But many other options are available for configuring update behavior on client computers, including using mobile device management. These options are documented in [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings). 

### 2.6.1. Choose the correct set of policies to edit

If you've set up Active Directory in your network, you can configure one or multiple computers simultaneously by including them in a Group Policy Object (GPO), and then configuring that GPO with WSUS settings. 

We recommend that you create a new GPO that contains only WSUS settings. Link this WSUS GPO to an Active Directory container that's appropriate for your environment. 

In a simple environment, you might link a single WSUS GPO to the domain. In a more complex environment, you might link multiple WSUS GPOs to several organizational units (OUs). Linking GPOs to OUs will enable you to apply WSUS policy settings to different types of computers.

If you don't use Active Directory in your network, you'll configure each computer by using the Local Group Policy Editor.

### 2.6.2. Edit policies to configure the client computers

> [!NOTE]
> These instructions assume that you're using the most recent versions of the policy editing tools. On older versions of the tools, the policies might be arranged differently.

1. Open the appropriate policy object:

    - If you're using Active Directory, open the Group Policy Management Console, browse to the GPO on which you want to configure WSUS, and select **Edit**. Then expand **Computer Configuration** and expand **Policies**.
    - If you're not using Active Directory, open the Local Group Policy Editor. The local computer policy appears. Expand **Computer Configuration**.

2. In the object that you expanded in the previous step, expand **Administrative Templates**, expand **Windows components**, expand **Windows Update**, and select **Manage end user experience**.

3. On the details pane, double-click **Configure Automatic Updates**. The **Configure Automatic Updates** policy opens.

4. Select **Enabled**, and then select the desired option under the **Configure automatic updating** setting to manage how Automatic Updates will download and install approved updates.
   
    We recommend using the **Auto download and schedule the install** setting. It ensures that the updates you approve in WSUS will be downloaded and installed in a timely fashion, without the need for user intervention.

5. If desired, edit other parts of the policy, as documented in [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings). 

    >[!NOTE]
    >The **Install updates from other Microsoft products** checkbox has no effect on client computers receiving updates from WSUS. The client computers will receive all updates approved for them on the WSUS server.

6. Select **OK** to close the **Configure Automatic Updates** policy.

7. Back in the **Windows Update** node of the tree, select **Manage updates offered from Windows Server Update Service**.

8. On the **Manage updates offered from Windows Server Update Service** details pane, double-click **Specify intranet Microsoft update service location**. The **Specify intranet Microsoft update service location** policy opens.

9. Select **Enabled**, and then enter the URL of the WSUS server in both the **Set the intranet update service for detecting updates** and **Set the intranet statistics server** text boxes.

    > [!WARNING]
    > Make sure to include the correct port in the URL. Assuming that you configured the server to use SSL as recommended, you should specify the port that's configured for HTTPS. For example, if you chose to use port 8531 for HTTPS, and the server's domain name is wsus.contoso.com, you should enter **https://wsus.contoso.com:8531** in both text boxes.

10. Select **OK** to close the **Specify intranet Microsoft update service location** policy.

#### Configure client-side targeting, if appropriate

If you've chosen to use client-side targeting, you should now specify the appropriate computer group for the client computers you're configuring.

> [!NOTE]
> These steps assume that you've just completed the steps for editing policies to configure the client computers.

1. On the **Manage updates offered from Windows Server Update Service** details pane, double-click **Enable client-side targeting**. The **Enable client-side targeting** policy opens.

2. Select **Enabled**, and then enter the name of the WSUS computer group to which you want to add the client computers in the **Target group name for this computer** box.

    If you're running a current version of WSUS, you can add the client computers to multiple computer groups by entering the group names, separated by semicolons. For example, you can enter **Accounting;Executive** to add the client computers to both the Accounting and Executive computer groups.

3. Select **OK** to close the **Enable client-side targeting** policy.

### 2.6.3. Let the client computer connect to the WSUS server

Client computers will not appear in the WSUS Administration Console until they connect to the WSUS server for the first time.

1. Wait for the policy changes to take effect on the client computer.

   If you used an Active Directory-based GPO to configure the client computers, it will take some time for the Group Policy Update mechanism to deliver the changes to a client computer. If you want to speed this up, you can open a command prompt window with elevated privileges and then enter the command **gpupdate /force**.
   
   If you used the Local Group Policy Editor to configure an individual client computer, the changes take effect immediately.

2. Restart the client computer. This step makes sure that the Windows Update software on the computer detects the policy changes.

3. Let the client computer scan for updates. This scan normally takes some time.
  
    You can speed up the process by using one of these options:
    
    - On Windows 10 or 11, use the **Settings** app's Windows Update page to manually check for updates.
    - On versions of Windows before Windows 10, use the **Windows Update** icon in Control Panel to manually check for updates. 
    - On versions of Windows before Windows 10, open a command prompt window with elevated privileges and enter the command **wuauclt /detectnow**.

### 2.6.4 Verify the client computer's successful connection to the WSUS server

If you've performed all the previous steps successfully, you'll see the following results:

- The client computer successfully scans for updates. (It might or might not find any applicable updates to download and install.)

- Within about 20 minutes, the client computer appears in the list of computers displayed in the WSUS Administration Console, based on the type of targeting:

  - If you're using server-side targeting, the client computer appears in the All Computers and Unassigned Computers computer groups.
  
  - If you're using client-side targeting, the client computer appears in the All Computers computer group and in the computer group that you selected while configuring the client computer.

### 2.6.5. Set up the client computer's server-side targeting, if appropriate

If you're using server-side targeting, you should now add the new client computer to the appropriate computer groups.

1. In the WSUS Administration Console, find the new client computer. It should appear in the All Computers and Unassigned Computers computer groups in the WSUS server's list of computers.

2. Right-click the client computer and select **Change membership**.

3. In the dialog, select the appropriate computer groups, and then select **OK**.
