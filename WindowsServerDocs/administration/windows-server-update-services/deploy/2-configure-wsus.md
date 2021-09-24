---
title: Step 2 - Configure WSUS
description: Windows Server Update Service (WSUS) topic - Configure WSUS is step two in a four step process for deploying WSUS
ms.topic: article
ms.assetid: d4adc568-1f23-49f3-9a54-12a7bec5f27c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 9/18/2020
---

# Step 2: Configure WSUS

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

After installing the WSUS server role on your server, you need to properly configure it. You will also need to configure your client computers to receive their updates from the WSUS server.

|Task|Description|
|----|--------|
|[2.1. Configure network connections](#21-configure-network-connections)|Configure the WSUS server's network connections by using the Network Configuration Wizard.|
|[2.2. Configure WSUS by using the WSUS Configuration Wizard](#22-configure-wsus-by-using-the-wsus-configuration-wizard)|Use the WSUS Configuration wizard to perform the base WSUS configuration.|
|[2.3. Secure WSUS with the Secure Sockets Layer Protocol](#23-secure-wsus-with-the-secure-sockets-layer-protocol)|Configure Secure Sockets Layer (SSL) protocol to help protect Windows Server Update Services (WSUS).|
|[2.4. Configure WSUS computer groups](#24-configure-wsus-computer-groups)|Create computer groups in the WSUS administration console to manage updates in your organization.|
|[2.5. Configure client computers to establish SSL connections with the WSUS server](#25-configure-client-computers-to-establish-ssl-connections-with-the-wsus-server)|Set up the client computers to establish secure connections to the WSUS server.|
|[2.6. Configure client computers to receive updates from the WSUS server](#26-configure-client-computers-to-receive-updates-from-the-wsus-server)|Set up the client computers to receive their updates from the WSUS server.|

## 2.1. Configure network connections

Before you start the configuration process, be sure that you know the answers to the following questions:

1. Is the server's firewall configured to allow clients to access the server?

2. Can this computer connect to the upstream server (such as the server that is designated to download updates from Microsoft Update)?

3. Do you have the name of the proxy server and the user credentials for the proxy server, if you need them?

When you have the answers for these questions, you can start configuring the following WSUS network settings:

- **Updates** Specify the way this server will obtain updates (from Microsoft Update or from another WSUS server).

- **Proxy** If you identified that WSUS needs to use a proxy server to have Internet access, you need to configure proxy settings in the WSUS server.

- **Firewall** If you identified that WSUS is behind a corporate firewall, there are some additional steps that must be done at the edge device to properly allow WSUS traffic.

> [!IMPORTANT]
> If you only have one WSUS server, then it must have Internet access, since it needs to download updates from Microsoft. If you have multiple WSUS servers, then only one server needs Internet access; the others only need network access to the Internet-connected WSUS server. And your client computers do not need Internet access; they only need network access to a WSUS server.

> [!TIP]
> If your network is "air gapped" -- if it does not have access to the Internet at all -- then you can still use WSUS to provide updates to client computers on the network. This requires two WSUS servers. One WSUS server with Internet access collects the updates from Microsoft. A second WSUS server on the protected network serves the updates to the client computers. Updates are exported from the first server onto removable media, carried across the air gap, and imported onto the second server. This is an advanced configuration that is beyond the scope of this document.

### 2.1.1. Configure your firewall to allow your first WSUS server to connect to Microsoft domains on the Internet

If there is a corporate firewall between WSUS and the Internet, you might have to configure that firewall to ensure WSUS can obtain updates. To obtain updates from Microsoft Update, the WSUS server uses port 443 for HTTPS protocol. Although most of corporate firewalls allow this type of traffic, there are some companies that restrict Internet access from the servers due the company's security policies. If so, then you will need to configure your firewall to allow your WSUS server to access Microsoft domains.

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

> [!IMPORTANT]
> You must configure your firewall to allow the first WSUS server to access any URL within these domains. The IP addresses associated with these domains are constantly changing, so do not try to use IP address ranges instead.

> [!IMPORTANT]
> For a scenario in which WSUS is failing to obtain updates due to firewall configurations, see [article 885819](https://support.microsoft.com/kb/885819) in the Microsoft Knowledge Base.

### 2.1.2. Configure the firewall to allow other your other WSUS servers to connect to the first server 

If you have multiple WSUS servers, then you should configure the other WSUS servers to access the first ("topmost") server. Your other WSUS servers will receive all their update information from the topmost server. This allows you to manage your entire network using the WSUS Administration Console on the topmost server. 

Your other WSUS servers must have outbound access to the topmost server using two ports. By default, these are ports 8530 and 8531. You can change these ports as described later in this document.

> [!NOTE]
> If the network connection between the WSUS servers is slow or expensive, then you can configure one or more of the other WSUS servers to receive update payloads directly from Microsoft. In this case, only a small amount of data will be sent from those WSUS servers to the topmost server. Note that for this configuration to work, the other WSUS servers must have access to the same Internet domains as the topmost server.

> [!NOTE]
> If you have a large organization, you can use chains of connected WSUS servers, rather than having all your other WSUS servers connect directly to the topmost server. For example, you can have a second WSUS server that connects to the topmost server, then have other WSUS servers connect to the second WSUS server.

### 2.1.3. Configure your WSUS servers to use a proxy server, if needed

If the corporate network uses proxy servers, the proxy servers must support HTTP and SSL protocols and use basic authentication or Windows authentication. These requirements can be met by using one of the following configurations:

1. A single proxy server that supports two protocol channels. In this case, set one channel to use HTTP and the other channel to use HTTPS.

    > [!NOTE]
    > You can set up one proxy server that handles both protocols for WSUS during the WSUS server software installation.

2. Two proxy servers, each of which supports a single protocol. In this case, one proxy server is configured to use HTTP, and the other proxy server is configured to use HTTPS.

To set up two proxy servers, each of which will handle one protocol for WSUS, use the following procedure:

#### To set up WSUS to use two proxy servers

1. Log on to the computer that is to be the WSUS server by using an account that is a member of the local Administrators group.

2. Install the WSUS server role. During the WSUS Configuration Wizard (discussed in the next section) do not specify a proxy server.

3. Open a command prompt (Cmd.exe) as an administrator. To open a command prompt as an administrator, go to **Start**. In **Start Search**, type **Command prompt**. At the top of the start menu, right-click **Command prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, enter the appropriate credentials (if requested), confirm that the action it displays is what you want, and then click **Continue**.

4. In the Command prompt window, go to the C:\Program Files\Update Services\Tools folder. Type the following command:

    **wsusutil ConfigureSSLproxy [< proxy_server proxy_port>] -enable**, where:

    1. proxy_server is the name of the proxy server that supports HTTPS.

    2. proxy_port is the proxy server port number.

5. Close the Command prompt window.

To add the proxy server that uses the HTTP protocol to the WSUS configuration, use the following procedure:

#### To add a proxy server that uses the HTTP protocol

1. Open the WSUS Administration Console.

2. In the left pane, expand the server name, and then click **Options**.

3. In the **Options** pane, click **Update Source and Update Server**, and then click the **Proxy Server** tab.

4. Use the following options to modify the existing proxy server configuration:

#### To change or add a proxy server to the WSUS configuration

1. Select the check box for **Use a proxy server when synchronizing**.

2. In the **Proxy server name** text box, type the name of the proxy server.

3. In the **Proxy port number** text box, type the port number of the proxy server. The default port number is 80.

4. If the proxy server requires that you use a specific user account, select the **Use user credentials to connect to the proxy server** check box. Type the required user name, domain, and password into the corresponding text boxes.

5. If the proxy server supports basic authentication, select the **Allow basic authentication (password is sent in cleartext)** check box.

6. Click **OK**.

#### To remove a proxy server from the WSUS configuration

1. Clear the check box for **Use a proxy server when synchronizing**.

2. Click **OK**.

### 2.1.4. Configure your firewall to allow client computers to access a WSUS server

Your client computers will all connect to one of your WSUS servers. The client computer must have outbound access to two ports on the WSUS server. By default, these are ports 8530 and 8531.

## 2.2. Configure WSUS by using the WSUS Configuration Wizard

This procedure assumes that you are using the WSUS Configuration Wizard, which appears the first time you launch the WSUS Management Console. Later in this topic, you will learn how to perform these configurations by using the **Options** page:

#### To configure WSUS

1. In the Server Manager navigation pane, click **Dashboard**, click **Tools**, and then click **Windows Server Update Services**.

    > [!NOTE]
    > If the **complete WSUS Installation** dialog box appears, click **Run**. In the **complete WSUS Installation** dialog box, click **Close** when the installation successfully finishes.

2. The Windows Server Update Services Wizard opens. On the **Before you Begin** page, review the information, and then click **Next**.

3. Read the instructions on the **Join the Microsoft Update Improvement Program** page and evaluate if you want to participate. If you want to participate in the program. Retain the default selection, or clear the check box, and then click **Next**.

4. On the **Choose Upstream Server** page, there are two options:

    1. Synchronize the updates with Microsoft Update

    2. Synchronize from another Windows Server Update Services server

        - if you choose to synchronize from another WSUS server, specify the server name and the port on which this server will communicate with the upstream server.

        - To use SSL, select the **Use SSL when synchronizing update information** check box. The servers will use port 443 for synchronization. (Make sure that this server and the upstream server support SSL.)

        - if this is a replica server, select the **This is a replica of the upstream server** check box.

5. After selecting the proper options for your deployment, click **Next** to proceed.

6. On the **Specify Proxy Server** page, select the **Use a proxy server when synchronizing** check box, and then type the proxy server name and port number (port 80 by default) in the corresponding boxes.

    > [!IMPORTANT]
    > You must complete this step if you identified that WSUS needs a proxy server to have Internet access.

7. If you want to connect to the proxy server by using specific user credentials, select the **Use user credentials to connect to the proxy server** check box, and then type the user name, domain, and password of the user in the corresponding boxes. If you want to enable basic authentication for the user who is connecting to the proxy server, select the **Allow basic authentication (password is sent in cleartext)** check box.

8. Click **Next**. On the **Connect to Upstream Server** page, click **start Connecting**.

9. When it connects, click **Next** to proceed.

10. On the **Choose Languages** page, you have the option to select the languages from which WSUS will receive updates - all languages or a subset of languages. Selecting a subset of languages will save disk space, but it is IMPORTANT to choose all of the languages that are needed by all the clients of this WSUS server. If you choose to get updates only for specific languages, select **Download updates only in these languages**, and then select the languages for which you want updates; otherwise, leave the default selection.

    > [!WARNING]
    > If you select the option **Download updates only in these languages**, and this server has a downstream WSUS server connected to it, this option will force the downstream server to also use only the selected languages.

11. After selecting the appropriate language options for your deployment, click **Next** to continue.

12. The **Choose Products** page allows you specify the products for which you want updates. Select product categories, such as Windows, or specific products, such as Windows Server 2012. Selecting a product category selects all the products in that category.

13. Select the appropriate product options for your deployment, and then click **Next**.

14. On the **Choose Classifications** page, select the update classifications that you want to obtain. Choose all the classifications or a subset of them, and then click **Next**.

15. The **Set Sync Schedule** page enables you to select whether to perform synchronization manually or automatically.

    - if you choose **Synchronize manually**, you must start the synchronization process from the WSUS Administration Console.

    - if you choose **Synchronize automatically**, the WSUS server will synchronize at set intervals.

    Set the time for the **First synchronization**, and then specify the number of **Synchronizations per day** that you want this server to perform. For example, if you specify that there should be four synchronizations per day, starting at 3:00 A.M., synchronizations will occur at 3:00 A.M., 9:00 A.M., 3:00 P.M., and 9:00 P.M.

16. After selecting the appropriate synchronization options for your deployment, click **Next** to continue.

17. On the **Finished** page, you have the option to start the synchronization now by selecting the **Begin initial synchronization** check box. If you do not select this option, you need to use WSUS Management Console to perform the initial synchronization. Click **Next** if you want to read more about additional settings, or you can click **Finish** to conclude this wizard and finish the initial WSUS setup.

18. After you click **Finish**, the WSUS Administration Console appears. You will use this console to manage your WSUS network, as described later on.

## 2.3. Secure WSUS with the Secure Sockets Layer Protocol

You should use the Secure Sockets Layer (SSL) protocol to help secure your WSUS network. WSUS can use SSL to authenticate connections and to encrypt and protect update information.

> [!WARNING]
> Securing WSUS using the SSL protocol is very important for the security of your network. If your WSUS server does not properly use SSL to secure its connections, then an attacker may be able to modify crucial update information as it's sent from one WSUS server to another, or from the WSUS server to the client computers. **This will allow the attacker to install malicious software on client computers.**

> [!IMPORTANT]
> Clients and downstream servers that are configured to use Transport Layer Security (TLS) or HTTPS must also be configured to use a fully qualified domain name (FQDN) for their upstream WSUS server.

### 2.3.1. Enable SSL/HTTPS on the WSUS server's IIS service to use SSL/HTTPS

To begin the process, you must enable SSL support on the WSUS server's IIS service. This involves creating an SSL certificate for the server.

The steps that are required to obtain an SSL certificate for the server are beyond the scope of this document, and will depend on your network configuration. For more information and for instructions about how to install certificates and set up this environment, we suggest the following documents:

- [Suite B PKI Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff829847(v=ws.10))

- [Implementing and Administering Certificate Templates](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731256(v=ws.10))

- [Active Directory Certificate Services Upgrade and Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc742515(v=ws.10))

- [Configure Certificate Autoenrollment](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731522(v=ws.11))

### 2.3.2. Configure the WSUS server's IIS web server to use SSL for some connections

WSUS requires two ports for connections to other WSUS servers and to client computers. One port uses HTTPS SSL to send update "metadata" (crucial information about the updates). By default, this is port 8531. A second port uses HTTP to send update payloads. By default, this is port 8530.

> [!IMPORTANT]
> You cannot configure the entire WSUS website to require SSL. WSUS is designed to encrypt update metadata only. This is the same way that Windows Update distributes updates. To guard against an attacker tampering with the update payloads, all update payloads are signed using a specific set of trusted signing certificates. In addition, a cryptographic has is computed for each update payload, and sent to the client computer using the secure HTTPS metadata connection, along with the other metadata for the update. When an update is downloaded, the client software verifies the payload's digital signature and hash. If the update has been changed, it is not installed.

You should require SSL only for these IIS virtual roots:

- **SimpleAuthWebService**

- **DSSAuthWebService**

- **ServerSyncWebService**

- **APIremoting30**

- **ClientWebService**

You should not require SSL for these following virtual roots:

- **Content**

- **Inventory**

- **ReportingWebService**

- **SelfUpdate**

The certificate of the certification authority (CA) must be imported into the each WSUS server's local computer Trusted Root CA store, or the Windows Server Update Service Trusted Root CA store if it exists. 

-  For more information about how to use SSL certificates in IIS, see [Require Secure Sockets Layer (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732367(v=ws.10)).

  > [!IMPORTANT]
  > You must use the Local Computer certificate store. You cannot use a user's certificate store.

Normally, you should configure IIS to use port 8531 for HTTPS connections, and port 8530 for HTTP connections. If you change these ports, note that you must use two adjacent port numbers; the port number used for HTTP connections must be exactly 1 less than the port number used for HTTPS connections.

- You must re-initialize *ClientServicingProxy* if the server name, SSL configuration, or port number has changed.

### 2.3.3. Configure WSUS to use the SSL signing certificate for its client connections

1. Log on to the WSUS server by using an account that is a member of the WSUS Administrators group or the local Administrators group.

2. Go to **start**, type **CMD**, right-click **Command prompt**, and then click **Run as administrator**.

3. Navigate to the _%ProgramFiles%_**\\Update Services\\Tools\\** folder.

4. In the Command prompt window, type the following command:

    **Wsusutil configuressl** _certificateName_

    where:

    *certificateName* is the DNS name of the WSUS server.

### 2.3.4. Secure the SQL Server connection, if needed

If you use WSUS with a remote SQL Server database, the connection between the WSUS server and the database server is not secured by SSL. This creates a potential attack vector. To protect this connection, consider the following recommendations:

   - Move the WSUS database to the WSUS server.

   - Move the remote database server and the WSUS server to a private network.

   - Deploy Internet Protocol security (IPsec) to help secure network traffic. For more information about IPsec, see [Creating and Using IPsec Policies](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730656(v=ws.10)).

### 2.3.5. Create a codesigning certificate for local publishing, if needed

In addition to distributing updates provided by Microsoft, WSUS also supports local publishing. Local publishing allows you to create and distribute updates that you design yourself, with your own payloads and behaviors.

Properly enabling and configuring local publishing is beyond the scope of this document. For full details on local publishing, including how to configure and use it within your organization, see [Local publishing](/previous-versions/windows/desktop/bb902470(v=vs.85)).

> [!IMPORTANT]
> Local publishing is a very complicated process, and is very often not needed. Before deciding to enable local publishing, you should carefully review the documentation, and consider whether and how you will use this functionality.

## 2.4. Configure WSUS computer groups

Computer groups are an important part of using WSUS effectively. Computer groups permit you to test and target updates to specific computers. There are two default computer groups: All computers and Unassigned computers. By default, when each client computer first contacts the WSUS server, the server adds that client computer to both of these groups.

You can create as many custom computer groups as you need to manage updates in your organization. As a best practice, create at least one computer group to test updates before you deploy them to other computers in your organization.

### 2.4.1. Choose an approach for assigning client computers to computer groups

There are two approaches to assigning client computers to computer groups. The right approach for your organization will depend on how you typically manage your client computers.

- Server-side targeting: This is the default approach. In this approach, you assign client computers to computer groups using the WSUS Administration Console. This approach gives you the flexibility to quickly move client computers from one group to another as circumstancesx change. But it means that new client computers must manually be moved from the Unassigned computers group to the appropriate computer group.
- Client-side targeting: In this approach, you assign each client computer to computer groups using policy settings set on the client computer itself. This approach makes it easier to assign new client computers to the appropriate groups; you will do so as part of configuring the client computer to receive updates from the WSUS server. But it means that client computers cannot be assigned to computer groups, or moved from one computer group to another, using the WSUS Administration Console. Instead, the client computers' policies must be modified.

### 2.4.2. Enable client-side targeting, if appropriate

> [!IMPORTANT]
> Skip this step if you will use server-side targeting.

1. In the WSUS Administration Console, under **Update Services**, expand the WSUS server, then click **options**.

2. In the **General** tab on the **Options** pane, choose **Use Group Policy or registry settings on computers**.

### 2.4.3. Create the desired computer groups

> [!NOTE]
> You must create computer groups using the WSUS Administration Console, whether you use server-side targeting or client-side targeting to add client computers to the computer groups.

1. In the WSUS Administration Console, under **Update Services**, expand the WSUS server, expand **computers**, right-click **All computers**, and then click **add computer Group**.

2. In the **add computer Group** dialog box, in **Name**, specify the name of the new group, and then click **add**.

## 2.5. Configure client computers to establish SSL connections with the WSUS server

Assuming that you have configured the WSUS server to protect the client computers' connections by using SSL, you must configure the client computers to trust those SSL connections.

- The WSUS server's SSL certificate must be imported into the client computers' Trusted Root Certificate Authority store, or into the client computers' Automatic Update Service Trusted Root Certificate Authority store if it exists.

> [!IMPORTANT]
> You must use the Local Computer certificate store. You cannot use a user's certificate store.

- The client computers must trust the certificate that you bind to the WSUS server. Depending on the type of certificate that is used, you might have to set up a service to enable the client computers to trust the certificate that is bound to the WSUS server.

- If you are using local publishing, you should also configure the client computers to trust the WSUS server's codesigning certificate. See [Local publishing|previous-versions/windows/desktop/bb902470(v=vs.85)] for instructions.

## 2.6. Configure client computers to receive updates from the WSUS server

By default, your client computers would normally receive updates from Windows Update. They must be configured to receive updates from the WSUS server instead.

> [!IMPORTANT]
> This document presents one set of steps for configuring client computers using Group Policy. These steps are appropriate in many situations. But there are many other options available for configuring update behavior on client computers, including using Mobile Device Management (MDM) rather than Group Policy. These options are documented in [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings). 

### 2.6.1. Choose the correct set of policies to edit

- If you have set up active directory in your network, you can configure one or multiple computers simultaneously by including them in a Group Policy Object (GPO), and then configuring that GPO with WSUS settings. 
  - We recommend that you create a new GPO that contains only WSUS settings.
  - Link this WSUS GPO to an active directory container that is appropriate for your environment. In a simple environment, you might link a single WSUS GPO to the domain. In a more complex environment, you might link multiple WSUS GPOs to several organizational units (OUs), which will enable you to apply different WSUS policy settings to different types of computers.

- If you do not use active directory in your network, you will configure each computer using the Local Group Policy editor.

### 2.6.2. Edit policies to configure the client computers 

> [!NOTE]
> These instructions assume that you are using the most recent versions of the policy editing tools mentioned. On older versions of the policy tools, the policies may be arranged differently.

1. Open the appropriate policy object.

    - If you are using active directory, then open the Group Policy Management Console (GPMC), browse to the GPO on which you want to configure WSUS, and click **edit**. Then expand **computer Configuration** and expand **Policies**.
    - If you are not using active directory, then open the Local Group Policy Editor. The local computer policy will be displayed. Expand **computer Configuration**.

2. In the object you expanded in the previous step, expand **Administrative Templates**, expand **Windows components**, expand **Windows Update**, and click **Manage end user experience** .

3. In the details pane, double-click **Configure Automatic Updates**. The **Configure Automatic Updates** policy opens.

4. Click **Enabled**, and then select the desired option under the **Configure automatic updating** setting to manage how Automatic Updates will download and install approved updates.
    - We recommend using the **Auto download and schedule the install** setting. This insures that the updates you approve in WSUS will be downloaded and installed in a timely fashion, without the need for user intervention.

5. If desired, edit other parts of the policy, as documented in [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings). 

>[!NOTE]
>The **Install updates from other Microsoft products** checkbox has no effect on client computers receiving updates from WSUS. The client computers will receive all updates approved for them on the WSUS server.

6. Click **OK** to close the **Configure Automatic Updates** policy.

7. Back in the **Windows Update** node of the tree, click **Manage updates offered from Windows Server Update Service**.

8. In the **Manage updates offered from Windows Server Update Service** details pane, double-click **Specify intranet Microsoft update service location**. The **Specify intranet Microsoft update service location** policy opens.

9. Click **Enabled**, then, enter the URL of the WSUS server in both the **Set the intranet update service for detecting updates** and **Set the intranet statistics server** text boxes.

> [!WARNING]
> Make sure to include the correct port in the URL. Assuming that you configured the server to use SSL as recommended, you should specify the port that is configured for HTTPS. For example, if you chose to use port 8531 for HTTPS, and the server's domain name is wsus.contoso.com, then you should type **https://wsus.contoso.com:8531** in both text boxes.

10. Click **OK** to close the **Specify intranet Microsoft update service location** policy.

#### Configure client-side targeting, if appropriate

If you have chosen to use client-side targeting, you should now specify the appropriate computer group for the client computer(s) you are configuring.

> [!NOTE]
> These steps assume that you have just completed the other steps described above.

11. In the **Manage updates offered from Windows Server Update Service** details pane, double-click **Enable client-side targeting**. The **Enable client-side targeting** policy opens.

12. Select **Enabled**, then type the name of the WSUS computer group to which you want to add the client computer(s) in the **Target group name for this computer** box.

  - If you are running a current version of WSUS, you may add the client computer(s) to multiple computer groups, by entering multiple computer group names separated by semicolons. For example, you may enter "Accounting;Executive" to add the client computer(s) to both the Accounting and the Executive computer group.

13. Click **OK** to close the **Enable client-side targeting** policy.

### 2.6.3. Let the client computer connect to the WSUS server

Client computers will not appear in the WSUS Administration Console until they connect to the WSUS server for the first time.

1. Wait for the policy changes to take effect on the client computer.

  - If you used an active directory-based Group Policy Object to configure the client computers, it will take some time for the Group Policy Update mechanism to deliver the changes to a client computer. If you want to speed this up, you can open a Command Prompt window with elevated privileges, then enter the command "gpupdate /force".
  - If you used the Local Group Policy editor to configure an individual client computer, the changes take effect immediately.

2. Restart the client computer. This makes sure that the Windows Update software on the computer detects the policy changes.

3. Let the client computer scan for updates. This will normally take some time.
  -  You can speed up the process by using the Settings app's Windows Update page on Windows 10 or 11, or the Control Panel's Windows Update icon in prior versions of Windows, to manually check for updates.
  -  On versions of Windows prior to Windows 10, you can instead open a Command Prompt window with elevated privileges, and enter the command "wuauclt /detectnow".

### 2.6.4 Verify the client computer's successful connection to the WSUS server

If all the steps above have been performed successfully, you will see the following results:

- The client computer will successfully scan for updates. (It may or may not find any applicable updates to download and install.)

- Within approximately 20 minutes, the client computer will appear in the list of computers displayed in the WSUS Administration Console.

  - If you are using server-side targeting, the client computer will appear in the All Computers and Unassigned Computers computer groups.
  
  - If you are using client-side targeting, the client computer will appear in the All Computers computer group, and in the computer group you selected while configuring the client computer.

### 2.6.5. Set up the client computer's server-side targeting, if appropriate

If you are using server-side targeting, you should now add the new client computer to the appropriate computer group(s).

1. In the WSUS Administration Console, find the new client computer. It should appear in the All Computers and Unassigned Computers computer groups in the WSUS server's Computers list.

2. Right-click the client computer and click **Change membership**.

3. In the dialog box, select the appropriate computer group(s), then click **OK**.
