---
title: Step 2 - Configure WSUS
description: See how to configure a Windows Server Update Services (WSUS) server and how to configure client computers to receive updates from the WSUS server.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 5/02/2025
# customer intent: As an administrator, I want to see how to configure Windows Server Update Services (WSUS) so that I can deploy the latest Microsoft product updates to computers in my network.
# freshness notes: Other than specific feedback, this article should be evergreen as of 5/02/2025 until the next version released or the end of support. The content is still relevant and accurate, and the links are still valid. The article is not time-sensitive and does not require any updates or changes at this time.
---

# Step 2: Configure WSUS

After you install the Windows Server Update Services (WSUS) server role on your server, you need to properly configure it. You also need to configure your client computers to receive their updates from the WSUS server.

## 2.1. Configure network connections

Before you start the configuration process, be sure that you know the answers to the following questions:

- Is the server's firewall configured to allow clients to access the server?

- Can this computer connect to the upstream server (the server that's designated to download updates from Microsoft Update)?

- Do you have the name of the proxy server and the user credentials for the proxy server, if you need them?

You can then start configuring the following WSUS network settings:

- **Updates**: Specify the way this server should get updates (from Microsoft Update or from another WSUS server).

- **Proxy**: If you identify that WSUS needs to use a proxy server to have internet access, configure proxy settings in the WSUS server.

- **Firewall**: If you identify that WSUS is behind a corporate firewall, take extra steps at the edge device to allow WSUS traffic.

> [!IMPORTANT]
> If you have only one WSUS server, it must have internet access, because it needs to download updates from Microsoft. If you have multiple WSUS servers, only one server needs internet access. The others only need network access to the internet-connected WSUS server. Your client computers don't need internet access. They only need network access to a WSUS server.

> [!TIP]
> If your network is *air gapped*—if it doesn't have access to the internet at all—you can still use WSUS to provide updates to client computers on the network. This approach requires two WSUS servers. One WSUS server with internet access collects the updates from Microsoft. A second WSUS server on the protected network serves the updates to the client computers. Updates are exported from the first server onto removable media, carried across the air gap, and imported into the second server. This configuration is advanced and is beyond the scope of this article.

### 2.1.1. Configure your firewall to allow your first WSUS server to connect to Microsoft domains on the internet

If a corporate firewall is between WSUS and the internet, you might have to configure that firewall to ensure that WSUS can get updates. To get updates from Microsoft Update, the WSUS server uses ports 80 and 443 for the HTTP and HTTPS protocols. Although most corporate firewalls allow this type of traffic, some companies restrict internet access from the servers because of security policies. If your company restricts access, you need to configure your firewall to allow your WSUS server to access Microsoft domains.

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

- http\://ntservicepack.microsoft.com

- http\://go.microsoft.com

- http\://dl.delivery.mp.microsoft.com

- https\://dl.delivery.mp.microsoft.com

- http\://*.delivery.mp.microsoft.com

- https\://*.delivery.mp.microsoft.com

If you're managing Microsoft 365 updates, which requires Microsoft Configuration Manager, see [Manage updates to Microsoft 365 Apps with Microsoft Configuration Manager](/microsoft-365-apps/updates/manage-microsoft-365-apps-updates-configuration-manager) for more information about the domains that you need to allow.

> [!IMPORTANT]
> You must configure your firewall to allow the first WSUS server to access any URL within these domains. The IP addresses associated with these domains are constantly changing, so don't try to use IP address ranges instead.

### 2.1.2. Configure the firewall to allow your other WSUS servers to connect to the first server

If you have multiple WSUS servers, you should configure the other WSUS servers to access the first (*topmost*) server. Your other WSUS servers then receive all their update information from the topmost server. This configuration allows you to manage your entire network by using the WSUS Administration Console on the topmost server.

Your other WSUS servers must have outbound access to the topmost server through two ports. By default, these ports are 8530 and 8531. You can change these ports, as described in [Configure the WSUS server's IIS web server to use TLS for some connections](#232-configure-the-wsus-servers-iis-web-server-to-use-tls-for-some-connections) later in this article.

> [!NOTE]
> If the network connection between the WSUS servers is slow or expensive, you can configure one or more of the other WSUS servers to receive update payloads directly from Microsoft. In this case, only a small amount of data is sent from those WSUS servers to the topmost server. For this configuration to work, the other WSUS servers must have access to the same internet domains as the topmost server.

> [!NOTE]
> If you have a large organization, you can use chains of connected WSUS servers, rather than having all your other WSUS servers connect directly to the topmost server. For example, you can have a second WSUS server that connects to the topmost server, and then have other WSUS servers connect to the second WSUS server.

### 2.1.3. Configure your WSUS servers to use a proxy server, if needed

If the corporate network uses proxy servers, the proxy servers must support the HTTP and HTTPS protocols. They also must use basic authentication or Windows authentication. You can meet these requirements by using one of the following configurations:

- A single proxy server that supports two protocol channels. In this case, set one channel to use HTTP and the other channel to use HTTPS.

  > [!NOTE]
  > You can set up one proxy server that handles both protocols for WSUS during the installation of WSUS server software.

- Two proxy servers, each of which supports a single protocol. In this case, configure one proxy server to use HTTP, and the other proxy server to use HTTPS.

#### To set up WSUS to use two proxy servers

1. Sign in to the computer that you plan to use as the WSUS server by using an account that's a member of the Local Administrators group.

1. Install the WSUS server role. When you use the WSUS Configuration Wizard, as explained in [Configure WSUS by using the WSUS Configuration Wizard](#22-configure-wsus-by-using-the-wsus-configuration-wizard), don't specify a proxy server.

1. Open Command Prompt (*Cmd.exe*) as an administrator:
   1. On the **Start** menu, search for **Command Prompt**.
   1. Right-click **Command Prompt**, and then select **Run as administrator**.
   1. If the **User Account Control** dialog appears, enter the appropriate credentials (if requested), confirm that the action that it displays is what you want, and then select **Continue**.

1. In Command Prompt, go to the *C:\Program Files\Update Services\Tools* folder. Enter the following command:

   `wsusutil ConfigureSSLproxy [<proxy-server proxy-port>] -enable`

   In that command:

   - *proxy_server* is the name of the proxy server that supports HTTPS.

   - *proxy_port* is the port number of the proxy server.

1. Close Command Prompt.

#### To add a proxy server to the WSUS configuration

1. Open the WSUS Administration Console.

1. Under **Update Services**, expand the server name, and then select **Options**.

1. On the **Options** pane, select **Update Source and Proxy Server**, and then go to the **Proxy Server** tab.

1. Select **Use a proxy server when synchronizing**, and then enter the name and the port number of the proxy server in the corresponding boxes. The default port number is 80.

1. If the proxy server requires that you use a specific user account, select **Use user credentials to connect to the proxy server**. Enter the required user name, domain, and password into the corresponding boxes.

1. If the proxy server supports basic authentication, select **Allow basic authentication (password is sent in cleartext)**.

1. Select **OK**.

#### To remove a proxy server from the WSUS configuration

1. In the WSUS Administration Console, under **Update Services**, expand the server name, and then select **Options**.

1. On the **Options** pane, select **Update Source and Proxy Server**, and then go to the **Proxy Server** tab.

1. Clear the **Use a proxy server when synchronizing** checkbox.

1. Select **OK**.

### 2.1.4. Configure your firewall to allow client computers to access a WSUS server

Your client computers all need to connect to one of your WSUS servers. Each client computer must have outbound access to two ports on the WSUS server. By default, these ports are 8530 and 8531.

## 2.2. Configure WSUS by using the WSUS Configuration Wizard

The procedures in the following sections use the WSUS Configuration Wizard to configure WSUS settings. The WSUS Configuration Wizard appears the first time you start the WSUS Management Console. You can also use the **Options** pane in the WSUS Administration Console to configure WSUS settings. For more information about using the **Options** pane, see the following procedures in other sections of this article:

- [Add a proxy server to the WSUS configuration](#to-add-a-proxy-server-to-the-wsus-configuration)
- [Enable client-side targeting](#242-enable-client-side-targeting-if-appropriate)

### Start the wizard and configure initial settings

1. In the Server Manager dashboard, select **Tools** > **Windows Server Update Services**.

   > [!NOTE]
   > If the **Complete WSUS Installation** dialog appears, select **Run**. In the **Complete WSUS Installation** dialog, select **Close** when the installation successfully finishes.

   The WSUS Configuration Wizard opens.

1. On the **Before you Begin** page, review the information, and then select **Next**.

1. On the **Join the Microsoft Update Improvement Program** page, read the instructions. Keep the default selection if you want to participate in the program, or clear the checkbox if you don't. Then select **Next**.

### Configure upstream and proxy server settings

1. On the **Choose Upstream Server** page, select one of the following options:

   - **Synchronize from Microsoft Update**

   - **Synchronize from another Windows Server Update Services server**

   If you choose to synchronize from another WSUS server, take the following steps:

   1. Specify the server name and the port on which this server should communicate with the upstream server.

   1. To use TLS, select **Use SSL when synchronizing update information**. The servers use port 443 for synchronization. (Make sure that this server and the upstream server support TLS.)

   1. If this server is a replica server, select **This is a replica of the upstream server**.

1. After you select the options for your deployment, select **Next**.

1. If WSUS needs a proxy server to access the internet, configure the following proxy settings. Otherwise, skip this step.

   1. On the **Specify Proxy Server** page, select **Use a proxy server when synchronizing**. Then enter the proxy server name and port number (port 80 by default) in the corresponding boxes.

   1. If you want to connect to the proxy server by using specific user credentials, select **Use user credentials to connect to the proxy server**. Then enter the user name, domain, and password of the user in the corresponding boxes.

      If you want to enable basic authentication for the user who's connecting to the proxy server, select **Allow basic authentication (password is sent in cleartext)**.

1. Select **Next**.

1. On the **Connect to Upstream Server** page, select **Start Connecting**.

1. When WSUS connects to the server, select **Next**.

### Select languages, products, and classifications

1. On the **Choose Languages** page, you can select the languages from which WSUS receives updates: all languages or a subset of languages. Selecting a subset of languages saves disk space, but it's important to select all the languages that all the clients of this WSUS server need.

   If you choose to get updates only for specific languages, select **Download updates only in these languages**, and then select the languages for which you want updates. Otherwise, leave the default selection.

   > [!WARNING]
   > If you select the **Download updates only in these languages** option, and this server has a downstream WSUS server connected to it, this option forces the downstream server to also use only the selected languages.

1. Select **Next**.

1. On the **Choose Products** page, specify the products for which you want updates. Select product categories, such as Windows, or specific products, such as Windows Server 2019. Selecting a product category selects all the products in that category.

1. Select **Next**.

1. On the **Choose Classifications** page, select the update classifications that you want to get. Select all the classifications or a subset of them, and then select **Next**.

### Configure the sync schedule

1. On the **Set Sync Schedule** page, select whether to perform synchronization manually or automatically.

   - If you select **Synchronize manually**, you must start the synchronization process from the WSUS Administration Console.

   - If you select **Synchronize automatically**, the WSUS server synchronizes at set intervals.

     For **First synchronization**, set the time, and then specify the number of synchronizations per day that you want this server to perform. For example, if you specify four synchronizations per day, starting at 3:00 AM, synchronizations occur at 3:00 AM, 9:00 AM, 3:00 PM, and 9:00 PM.

1. Select **Next**.

### Complete the wizard

1. On the **Finished** page, if you want to start the synchronization right away, select **Begin initial synchronization**. If you don't select this option, you need to use the WSUS Management Console to perform the initial synchronization.

1. If you want to read more about other settings, select **Next**. Otherwise, select **Finish** to conclude the wizard and finish the initial WSUS setup.

After you select **Finish**, the WSUS Administration Console appears. You use this console to manage your WSUS network, as described in later sections in this article.

## 2.3. Secure WSUS with the TLS protocol

You should use the TLS protocol to help secure your WSUS network. WSUS can use TLS to authenticate connections and to encrypt and protect update information.

> [!WARNING]
> Securing WSUS by using the TLS protocol is important for the security of your network. If your WSUS server doesn't properly use TLS to secure its connections, an attacker might modify crucial update information when it's sent from one WSUS server to another, or from the WSUS server to the client computers. *In this situation, the attacker can install malicious software on client computers.*

> [!IMPORTANT]
> Clients and downstream servers that are configured to use TLS or HTTPS must also be configured to use a fully qualified domain name (FQDN) for their upstream WSUS server.

### 2.3.1. Enable TLS/HTTPS on the WSUS server's IIS service to use TLS/HTTPS

To begin the process of using TLS/HTTPS, you must enable TLS support on the WSUS server's Internet Information Services (IIS) service. This effort involves creating a TLS/Secure Sockets Layer (SSL) certificate for the server.

The steps that are required to get a TLS/SSL certificate for the server are beyond the scope of this article and depend on your network configuration. For more information and for instructions about how to install certificates and set up this environment, see the documentation for [Active Directory Certificate Services](../../../identity/ad-cs/index.yml).

### 2.3.2. Configure the WSUS server's IIS web server to use TLS for some connections

WSUS requires two ports for connections to other WSUS servers and to client computers. One port uses TLS/HTTPS to send update *metadata* (crucial information about the updates). By default, port 8531 is used for this purpose. A second port uses HTTP to send update payloads. By default, port 8530 is used for this purpose.

> [!IMPORTANT]
> You can't configure the entire WSUS website to require TLS. WSUS is designed to encrypt update metadata only. Windows Update distributes updates in the same way.
>
> To guard against an attacker tampering with the update payloads, all update payloads are signed through a specific set of trusted signing certificates. Also, a cryptographic hash is computed for each update payload. The hash is sent to the client computer over the secure HTTPS metadata connection, along with the other metadata for the update. When an update is downloaded, the client software verifies the payload's digital signature and hash. If the update has been changed, it's not installed.

You should require TLS only for the following IIS virtual roots:

- **SimpleAuthWebService**

- **DSSAuthWebService**

- **ServerSyncWebService**

- **APIremoting30**

- **ClientWebService**

You shouldn't require TLS for the following virtual roots:

- **Content**

- **Inventory**

- **ReportingWebService**

- **SelfUpdate**

The certificate of the certification authority (CA) must be imported into each WSUS server's Trusted Root CA store for the local computer, or the Trusted Root CA store for WSUS if it exists.

For more information about how to use TLS/SSL certificates in IIS, see [How to Set Up SSL on IIS 7 or later](/iis/manage/configuring-security/how-to-set-up-ssl-on-iis).

> [!IMPORTANT]
> You must use the certificate store for the local computer. You can't use a user's certificate store.

Normally, you should configure IIS to use port 8531 for HTTPS connections and port 8530 for HTTP connections. If you change these ports, you must use two adjacent port numbers. The port number used for HTTP connections must be exactly 1 less than the port number used for HTTPS connections.

You must reinitialize the `ClientServicingProxy` client proxy if the server name, TLS configuration, or port number changes.

### 2.3.3. Configure WSUS to use the TLS/SSL signing certificate for its client connections

1. Sign in to the WSUS server by using an account that's a member of the WSUS Administrators group or the Local Administrators group.

1. On the **Start** menu, enter **CMD**, right-click **Command Prompt**, and then select **Run as administrator**.

1. Go to the *C:\Program Files\Update Services\Tools* folder.

1. In Command Prompt, enter the following command:

   `wsusutil configuressl <certificate-name>`

   In that command, *certificate-name* is the Domain Name System (DNS) name of the WSUS server.

### 2.3.4. Secure the SQL Server connection, if needed

If you use WSUS with a remote SQL Server database, the connection between the WSUS server and the database server isn't secured through TLS. This situation creates a potential attack vector. To help protect this connection, consider the following recommendations:

- Move the WSUS database to the WSUS server.

- Move the remote database server and the WSUS server to a private network.

- Deploy Internet Protocol security (IPsec) to help secure network traffic. For more information about IPsec, see [Creating and using IPsec policies](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730656(v=ws.10)).

### 2.3.5. Create a code-signing certificate for local publishing, if needed

Besides distributing updates that Microsoft provides, WSUS supports local publishing. You can use local publishing to create and distribute updates that you design yourself, with your own payloads and behaviors.

Enabling and configuring local publishing is beyond the scope of this article. For full details, see [Local publishing](/previous-versions/windows/desktop/bb902470(v=vs.85)).

> [!IMPORTANT]
> Local publishing is a complicated process and is often not needed. Before you decide to enable local publishing, you should carefully review the documentation and consider whether you want to use this functionality and how you might use it.

## 2.4. Configure WSUS computer groups

Computer groups are an important part of using WSUS effectively. You can use computer groups to test and target updates to specific computers. There are two default computer groups: All Computers and Unassigned Computers. By default, when each client computer first contacts the WSUS server, the server adds that client computer to both of these groups.

You can create as many custom computer groups as you need to manage updates in your organization. As a best practice, create at least one computer group to test updates before you deploy them to other computers in your organization.

### 2.4.1. Choose an approach for assigning client computers to computer groups

There are two approaches to assigning client computers to computer groups. The right approach for your organization depends on how you typically manage your client computers.

- **Server-side targeting**: This approach is the default one. In this approach, you assign client computers to computer groups by using the WSUS Administration Console.

  This approach gives you the flexibility to quickly move client computers from one group to another as circumstances change. But as a result, you must manually move new client computers from the Unassigned Computers group to the appropriate computer group.

- **Client-side targeting**: In this approach, you assign each client computer to computer groups by using policy settings set on the client computer itself.

  This approach makes it easier to assign new client computers to the appropriate groups. You do so as part of configuring the client computer to receive updates from the WSUS server. But as a result, you can't assign client computers to computer groups, or move them from one computer group to another, through the WSUS Administration Console. Instead, you must modify the client computers' policies.

### 2.4.2. Enable client-side targeting, if appropriate

> [!IMPORTANT]
> Skip the steps in this section if you plan to use server-side targeting.

1. In the WSUS Administration Console, under **Update Services**, expand the WSUS server, and then select **Options**.

1. On the **Options** pane, select **Computers**. Go to the **General** tab, and then select **Use Group Policy or registry settings on computers**.

### 2.4.3. Create the desired computer groups

> [!NOTE]
> You must create computer groups by using the WSUS Administration Console, whether you use server-side targeting or client-side targeting to add client computers to the computer groups.

1. In the WSUS Administration Console, under **Update Services**, expand the WSUS server, expand **Computers**, right-click **All computers**, and then select **Add Computer Group**.

1. In the **Add Computer Group** dialog, for **Name**, specify the name of the new group. Then select **Add**.

## 2.5. Configure client computers to establish TLS connections with the WSUS server

Assuming that you configure the WSUS server to help protect the client computers' connections by using TLS, you must configure the client computers to trust those TLS connections.

The WSUS server's TLS/SSL certificate must be imported into the client computers' Trusted Root CA store, or into the client computers' Automatic Update Service Trusted Root CA store if it exists.

> [!IMPORTANT]
> You must use the certificate store for the local computer. You can't use a user's certificate store.

The client computers must trust the certificate that you bind to the WSUS server. Depending on the type of certificate that's used, you might have to set up a service to enable the client computers to trust the certificate that's bound to the WSUS server.

If you're using local publishing, you should also configure the client computers to trust the WSUS server's code-signing certificate. For instructions, see [Local publishing](/previous-versions/windows/desktop/bb902470(v=vs.85)).

## 2.6. Configure client computers to receive updates from the WSUS server

By default, your client computers receive updates from Windows Update. They must be configured to receive updates from the WSUS server instead.

> [!IMPORTANT]
> This article presents one set of steps for configuring client computers by using Group Policy. These steps are appropriate in many situations. But many other options are available for configuring update behavior on client computers, including using mobile device management. For documentation on these options, see [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings).

### 2.6.1. Choose the correct set of policies to edit

If Active Directory is set up in your network, you can configure one or multiple computers simultaneously by including them in a Group Policy Object (GPO), and then configuring that GPO with WSUS settings.

We recommend that you create a new GPO that contains only WSUS settings. Link this WSUS GPO to an Active Directory container that's appropriate for your environment.

In a simple environment, you might link a single WSUS GPO to the domain. In a more complex environment, you might link multiple WSUS GPOs to several organizational units (OUs). When you link GPOs to OUs, you can apply WSUS policy settings to different types of computers.

If you don't use Active Directory in your network, you need to configure each computer by using the Local Group Policy Editor.

### 2.6.2. Edit policies to configure the client computers

Take the steps in the following sections to configure the client computers by using policy settings.

> [!NOTE]
> These instructions assume that you're using the most recent versions of the policy editing tools. On older versions of the tools, the policies might be arranged differently.

#### Open the policy editor and go to the Windows Update item

1. Open the appropriate policy object:

   - If you're using Active Directory, open the Group Policy Management Console, go to the GPO on which you want to configure WSUS, and select **Edit**. Then expand **Computer Configuration**, and expand **Policies**.
   - If you're not using Active Directory, open the Local Group Policy Editor. The local computer policy appears. Expand **Computer Configuration**.

1. In the object that you expanded in the previous step, expand **Administrative Templates** > **Windows components** > **Windows Update**. If your operating system is Windows 10 or Windows 11, also select **Manage end user experience**.

#### Edit the setting for automatic updates

1. On the details pane, double-click **Configure Automatic Updates**. The **Configure Automatic Updates** policy opens.

1. Select **Enabled**, and then select the desired option under the **Configure automatic updating** setting to manage how the automatic updates feature should download and install approved updates.

   We recommend using the **Auto download and schedule the install** setting. It ensures that the updates you approve in WSUS are downloaded and installed in a timely fashion, without the need for user intervention.

1. If desired, edit other parts of the policy. For more information, see [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings).

   >[!NOTE]
   >The **Install updates from other Microsoft products** setting has no effect on client computers receiving updates from WSUS. The client computers receive all updates approved for them on the WSUS server.

1. Select **OK** to close the **Configure Automatic Updates** policy.

#### Edit the setting for specifying an intranet server to host updates

1. On the details pane, double-click **Specify intranet Microsoft update service location**. If your operating system is Windows 10 or Windows 11, first go back to the **Windows Update** node of the tree, and then select **Manage updates offered from Windows Server Update Service**.

   The **Specify intranet Microsoft update service location** policy opens.

1. Select **Enabled**, and then enter the URL of the WSUS server in both the **Set the intranet update service for detecting updates** and **Set the intranet statistics server** boxes.

    > [!WARNING]
    > Make sure to include the correct port in the URL. Assuming that you configure the server to use TLS as recommended, you should specify the port that's configured for HTTPS. For example, if you choose to use port 8531 for HTTPS, and the server's domain name is wsus.contoso.com, you should enter `https://wsus.contoso.com:8531` in both boxes.

1. Select **OK** to close the **Specify intranet Microsoft update service location** policy.

#### Configure client-side targeting, if appropriate

If you choose to use client-side targeting, take the steps in this section to specify the appropriate computer group for the client computers you're configuring.

> [!NOTE]
> These steps assume that you just completed the steps for editing policies to configure the client computers.

1. In the policy editor, go to the **Windows Update** item. If your operating system is Windows 10 or Windows 11, also select **Manage updates offered from Windows Server Update Service**.

1. On the details pane, double-click **Enable client-side targeting**. The **Enable client-side targeting** policy opens.

1. Select **Enabled**. Under **Target group name for this computer**, enter the name of the WSUS computer group to which you want to add the client computers.

   If you're running a current version of WSUS, you can add the client computers to multiple computer groups by entering the group names, separated by semicolons. For example, you can enter **Accounting;Executive** to add the client computers to both the Accounting and Executive computer groups.

1. Select **OK** to close the **Enable client-side targeting** policy.

### 2.6.3. Let the client computer connect to the WSUS server

Client computers don't appear in the WSUS Administration Console until they connect to the WSUS server for the first time.

1. Wait for the policy changes to take effect on the client computer.

   If you use an Active Directory-based GPO to configure the client computers, it takes some time for the Group Policy Update mechanism to deliver the changes to a client computer. If you want to speed up this process, you can open Command Prompt with elevated privileges and then enter the command **gpupdate /force**.

   If you use the Local Group Policy Editor to configure an individual client computer, the changes take effect immediately.

1. Restart the client computer. This step makes sure that the Windows Update software on the computer detects the policy changes.

1. Let the client computer scan for updates. This scan normally takes some time.
  
   You can speed up the process by using one of these options:

   - On Windows 10 or 11, use the Settings app **Windows Update** page to manually check for updates.
   - On versions of Windows before Windows 10, use the **Windows Update** icon in Control Panel to manually check for updates.
   - On versions of Windows before Windows 10, open Command Prompt with elevated privileges, and enter the command **wuauclt /detectnow**.

### 2.6.4 Verify the client computer's successful connection to the WSUS server

If you perform all the previous steps successfully, you see the following results:

- The client computer successfully scans for updates. (It might or might not find any applicable updates to download and install.)

- Within about 20 minutes, the client computer appears in the list of computers displayed in the WSUS Administration Console, based on the type of targeting:

  - If you're using server-side targeting, the client computer appears in the All Computers and Unassigned Computers computer groups.
  
  - If you're using client-side targeting, the client computer appears in the All Computers computer group and in the computer group that you select while configuring the client computer.

### 2.6.5. Set up the client computer's server-side targeting, if appropriate

If you're using server-side targeting, you should now add the new client computer to the appropriate computer groups.

1. In the WSUS Administration Console, find the new client computer. It should appear in the All Computers and Unassigned Computers computer groups in the WSUS server's list of computers.

1. Right-click the client computer and select **Change membership**.

1. In the dialog, select the appropriate computer groups, and then select **OK**.

## Next step

> [!div class="nextstepaction"]
> [Step 3: Approve and Deploy Updates](3-approve-and-deploy-updates-in-wsus.md)
