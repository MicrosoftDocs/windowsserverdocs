---
title: Step 2 - Configure WSUS
description: "Windows Server Update Service (WSUS) topic - Configure WSUS is step two in a four step process for deploying WSUS"
ms.prod: windows-server
ms.reviewer: na
ms.technology: manage-wsus
ms.topic: article
ms.assetid: d4adc568-1f23-49f3-9a54-12a7bec5f27c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Step 2: Configure WSUS

>Applies To: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

After installing the WSUS server role on your server, you need to properly configure it. The following checklist summarizes the steps involved in performing the initial configuration for your WSUS server.

|Task|Description|
|----|--------|
|[2.1. Configure network connections](#21-configure-network-connections)|Configure the cluster network by using the Network Configuration Wizard.|
|[2.2. Configure WSUS by using the WSUS Configuration Wizard](#22-configure-wsus-by-using-the-wsus-configuration-wizard)|Use the WSUS Configuration wizard to perform the base WSUS configuration.|
|[2.3. Configure WSUS computer groups](#23-configure-wsus-computer-groups)|Create computer groups in the WSUS administration console to manage updates in your organization.|
|[2.4. Configure client updates](#24-configure-client-updates)|Specify how and when automatic updates are applied to client computers.|
|[2.5. Secure WSUS with the Secure Sockets Layer Protocol](#25-secure-wsus-with-the-secure-sockets-layer-protocol)|Configure Secure Sockets Layer (SSL) protocol to help protect Windows Server Update Services (WSUS).|

## 2.1. Configure network connections
Before you start the configuration process, be sure that you know the answers to the following questions:

1.  Is the server's firewall configured to allow clients to access the server?

2.  Can this computer connect to the upstream server (such as the server that is designated to download updates from Microsoft Update)?

3.  Do you have the name of the proxy server and the user credentials for the proxy server, if you need them?

By default, WSUS is configured to use Microsoft Update as the location from which to obtain updates. if you have a proxy server on the network, you can configure WSUS to use the proxy server. if there is a corporate firewall between WSUS and the Internet, you might have to configure the firewall to ensure that WSUS can obtain updates.

> [!TIP]
> Although Internet connectivity is required to download updates from Microsoft Update, WSUS offers you the ability to import updates onto networks that are not connected to the Internet.

When you have the answers for these questions, you can start configuring the following WSUS network settings:

-   **Updates** Specify the way this server will obtain updates (from Microsoft Update or from another WSUS server).

-   **Proxy** if you identified that WSUS needs to use a proxy server to have Internet access, you need to configure proxy settings in the WSUS server.

-   **Firewall** if you identified that WSUS is behind a corporate firewall, there are some additional steps that must be done at the edge device to properly allow WSUS traffic.

### 2.1.1. Connection from the WSUS server to the Internet
If there is a corporate firewall between WSUS and the Internet, you might have to configure that firewall to ensure WSUS can obtain updates. To obtain updates from Microsoft Update, the WSUS server uses port 443 for HTTPS protocol. Although most of corporate firewalls allow this type of traffic, there are some companies that restrict Internet access from the servers due the company's security policies. if your company restricts access, you need to obtain authorization to allow Internet access from WSUS to the following list of URLs:

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
> For a scenario in which WSUS is failing to obtain updates due firewall configurations, see [article 885819](https://support.microsoft.com/kb/885819) in the Microsoft Knowledge Base.

The following section describes how to configure a corporate firewall that is positioned between WSUS and the Internet. Because WSUS initiates all the network traffic, it is not necessary to configure Windows Firewall on the WSUS server. Although the connection between Microsoft Update and WSUS requires ports 80 and 443 to be open, you can configure multiple WSUS servers to synchronize with a custom port.

### 2.1.2. Connection between WSUS servers
WSUS upstream and downstream servers will synchronize on the port configured by the WSUS Administrator. By default, these ports are configured as follows:

-   On WSUS 3.2 and earlier, port 80 for HTTP and 443 for HTTPS

-   On WSUS 6.2 and later (at least  Windows Server 2012 ), port 8530 for HTTP and 8531 for HTTPS are used

The firewall on the WSUS server must be configured to allow inbound traffic on these ports.

### 2.1.3. Connection between clients (Windows Update Agent) and WSUS servers
The listening interfaces and ports are configured in the IIS site(s) for WSUS and in any Group Policy settings used to configure client PCs. The default ports are the same as those specified in the preceding section **Connection between WSUS servers**, and the firewall on the WSUS server must also be configured to allow inbound traffic on these ports.

## Configure the proxy server
If the corporate network uses proxy servers, the proxy servers must support HTTP and SSL protocols and use basic authentication or Windows authentication. These requirements can be met by using one of the following configurations:

1.  A single proxy server that supports two protocol channels. In this case, set one channel to use HTTP and the other channel to use HTTPS.

    > [!NOTE]
    > You can set up one proxy server that handles both protocols for WSUS during the WSUS server software installation.

2.  Two proxy servers, each of which supports a single protocol. In this case, one proxy server is configured to use HTTP, and the other proxy server is configured to use HTTPS.

To set up two proxy servers, each of which will handle one protocol for WSUS, use the following procedure:

#### To set up WSUS to use two proxy servers

1.  Log on to the computer that is to be the WSUS server by using an account that is a member of the local Administrators group.

2.  Install the WSUS server role. During the WSUS Configuration Wizard (discussed in the next section) do not specify a proxy server.

3.  Open a command prompt (Cmd.exe) as an administrator. To open a command prompt as an administrator, go to **Start**. In **Start Search**, type **Command prompt**. at the top of the start menu, right-click **Command prompt**, and then click **Run as administrator**. if the **User Account Control** dialog box appears, enter the appropriate credentials (if requested), confirm that the action it displays is what you want, and then click **Continue**.

4.  In the Command prompt window, go to the C:\Program Files\Update Services\Tools folder. type the following command:

    **wsusutil ConfigureSSlproxy [< proxy_server proxy_port>] -enable**, where:

    1.  proxy_server is the name of the proxy server that supports HTTPS.

    2.  proxy_port is the proxy server port number.

5.  Close the Command prompt window.

To add the proxy server that uses the HTTP protocol to the WSUS configuration, use the following procedure:

#### To add a proxy server that uses the HTTP protocol

1.  Open the WSUS Administration Console.

2.  In the left pane, expand the server name, and then click **Options**.

3.  In the **Options** pane, click **Update Source and Update Server**, and then click the **Proxy Server** tab.

4.  Use the following options to modify the existing proxy server configuration:

    ###### To change or add a proxy server to the WSUS configuration

    1.  Select the check box for **Use a proxy server when synchronizing**.

    2.  In the **Proxy server name** text box, type the name of the proxy server.

    3.  In the **Proxy port number** text box, type the port number of the proxy server. The default port number is 80.

    4.  Ff the proxy server requires that you use a specific user account, select the **Use user credentials to connect to the proxy server** check box. type the required user name, domain, and password into the corresponding text boxes.

    5.  If the proxy server supports basic authentication, select the **Allow basic authentication (password is sent in cleartext)** check box.

    6.  Click **OK**.

    ###### To remove a proxy server from the WSUS configuration

    1.  To remove a proxy server from the WSUS configuration, clear the check box for **Use a proxy server when synchronizing**.

    2.  Click **OK**.

## 2.2. Configure WSUS by using the WSUS Configuration Wizard
This procedure assumes that you are using the WSUS Configuration Wizard, which appears the first time you launch the WSUS Management Console. Later in this topic, you will learn how to perform these configurations by using the **Options** page:

#### To configure WSUS

1.  In the Server Manager navigation pane, click **Dashboard**, click **Tools**, and then click **Windows Server Update Services**.

    > [!NOTE]
    > If the **complete WSUS Installation** dialog box appears, click **Run**. In the **complete WSUS Installation** dialog box, click **Close** when the installation successfully finishes.

2.  The Windows Server Update Services Wizard opens. On the **Before you Begin** page, review the information, and then click **Next**.

3.  Read the instructions on the **Join the Microsoft Update Improvement Program** page and evaluate if you want to participate. If you want to participate in the program. retain the default selection, or clear the check box, and then click **Next**.

4.  On the **Choose Upstream Server** page, there are two options:

    1.  Synchronize the updates with Microsoft Update

    2.  Synchronize from another Windows Server Update Services server

        -   if you choose to synchronize from another WSUS server, specify the server name and the port on which this server will communicate with the upstream server.

        -   To use SSL, select the **Use SSL when synchronizing update information** check box. The servers will use port 443 for synchronization. (Make sure that this server and the upstream server support SSL).

        -   if this is a replica server, select the **This is a replica of the upstream server** check box.

5.  After selecting the proper options for your deployment, click **Next** to proceed.

6.  On the **Specify Proxy Server** page, select the **Use a proxy server when synchronizing** check box, and then type the proxy server name and port number (port 80 by default) in the corresponding boxes.

    > [!IMPORTANT]
    > You must complete this step if you identified that WSUS needs a proxy server to have Internet access.

7.  if you want to connect to the proxy server by using specific user credentials, select the **Use user credentials to connect to the proxy server** check box, and then type the user name, domain, and password of the user in the corresponding boxes. if you want to enable basic authentication for the user who is connecting to the proxy server, select the **Allow basic authentication (password is sent in cleartext)** check box.

8.  Click **Next**. On the **Connect to Upstream Server** page, click **start Connecting**.

9. When it connects, click **Next** to proceed.

10. On the **Choose Languages** page, you have the option to select the languages from which WSUS will receive updates - all languages or a subset of languages. selecting a subset of languages will save disk space, but it is IMPORTANT to choose all of the languages that are needed by all the clients of this WSUS server. if you choose to get updates only for specific languages, select **Download updates only in these languages**, and then select the languages for which you want updates; otherwise, leave the default selection.

    > [!WARNING]
    > If you select the option **Download updates only in these languages**, and this server has a downstream WSUS server connected to it, this option will force the downstream server to also use only the selected languages.

11. After selecting the appropriate language options for your deployment, click **Next** to continue.

12. The **Choose Products** page allows you specify the products for which you want updates. select product categories, such as Windows, or specific products, such as Windows Server 2008. selecting a product category selects all the products in that category.

13. select the appropriate product options for your deployment, and then click **Next**.

14. On the **Choose Classifications** page, select the update classifications that you want to obtain. Choose all the classifications or a subset of them, and then click **Next**.

15. The **Set Sync Schedule** page enables you to select whether to perform synchronization manually or automatically.

    -   if you choose **Synchronize manually**, you must start the synchronization process from the WSUS Administration Console.

    -   if you choose **Synchronize automatically**, the WSUS server will synchronize at set intervals.

    Set the time for the **First synchronization**, and then specify the number of **Synchronizations per day** that you want this server to perform. For example, if you specify that there should be four synchronizations per day, starting at 3:00 A.M., synchronizations will occur at 3:00 A.M., 9:00 A.M., 3:00 P.M., and 9:00 P.M.

16. After selecting the appropriate synchronization options for your deployment, click **Next** to continue.

17. On the **Finished** page, you have the option to start the synchronization now by selecting the **Begin initial synchronization** check box. if you do not select this option, you need to use WSUS Management Console to perform the initial synchronization. Click **Next** if you want to read more about additional settings, or you can click **Finish** to conclude this wizard and finish the initial WSUS setup.

18. After you click **Finish**, the WSUS Management Console appears.

Now that you have performed the basic WSUS configuration, read the next sections for more details about changing the settings by using WSUS Management Console.

## 2.3. Configure WSUS computer groups
computer groups are an IMPORTANT part of Windows Server Update Services (WSUS) deployments. Computer groups permit you to test and target updates to specific computers. There are two default computer groups: All computers and Unassigned computers. By default, when each client computer first contacts the WSUS server, the server adds that client computer to both of these groups.

You can create as many custom computer groups as you need to manage updates in your organization. As a best practice, create at least one computer group to test updates before you deploy them to other computers in your organization.

Use the following procedure to create a new group and assign a computer to this group:

#### To create a computer group

1.  In the WSUS Administration Console, under **Update Services**, expand the WSUS server, expand **computers**, right-click **All computers**, and then click **add computer Group**.

2.  In the **add computer Group** dialog box, in **Name**, specify the name of the new group, and click then **add**.

3.  Click **computers**, and then select the computers that you want to assign to this new group.

4.  Right-click the computer names that you selected in the previous step, and then click **change Membership**.

5.  In the **Set computer Group Membership** dialog box, select the test group that you created, and then click **OK**.

## 2.4. Configure client updates
WSUS Setup automatically configures IIS to distribute the latest version of Automatic Updates to each client computer that contacts the WSUS server. The best way to configure Automatic Updates depends on the network environment.

-   In an environment that uses active directory directory service, you can use an existing domain-based Group Policy Object (GPO) or create a new GPO.

-   In an environment without active directory, use the Local Group Policy editor to configure Automatic Updates, and then point the client computers to the WSUS server.

> [!IMPORTANT]
> The following procedures assume that your network runs active directory. These procedures also assume that you are familiar with Group Policy and you use it to manage the network.

Use the following procedures to configure Automatic Updates for client computers:

-   [Step 4: Configure Group Policy Settings for Automatic Updates](4-configure-group-policy-settings-for-automatic-updates.md)

-   [2.3. Configure computer groups](#23-configure-wsus-computer-groups) in this topic

### Configure Automatic Updates in Group Policy

If you have set up active directory in your network, you can configure one or multiple computers simultaneously by including them in a Group Policy Object (GPO), and then configuring that GPO with WSUS settings. We recommend that you create a new GPO that contains only WSUS settings.

Link this WSUS GPO to an active directory container that is appropriate for your environment. In a simple environment, you might link a single WSUS GPO to the domain. In a more complex environment, you might link multiple WSUS GPOs to several organizational units (OUs), which will enable you to apply different WSUS policy settings to different types of computers.

##### To enable WSUS through a domain GPO

1.  In the Group Policy Management Console (GPMC), browse to the GPO on which you want to configure WSUS, and then click **edit**.

2.  In the GPMC, expand **computer Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Windows components**, and then click **Windows Update**.

3.  In the details pane, double-click **Configure Automatic Updates**. The **Configure Automatic Updates** policy opens.

4.  Click **Enabled**, and then select one of the following options under the **Configure automatic updating** setting:

    -   **Notify for download and notify for install**. This option notifies a logged-on administrative user before you download and install the updates.

    -   **Auto download and notify for install**. This option automatically begins downloading updates and then notifies a logged-on administrative user before installing the updates. By default, this option is selected.

    -   **Auto download and schedule the install**. This option automatically begins downloading updates and then installs the updates on the day and time that you specify.

    -   **Allow local admin to choose setting**. This option lets local administrators to use Automatic Updates in Control Panel to select a configuration option. For example, they can choose a scheduled installation time. Local administrators cannot disable Automatic Updates.

5.  select **Enable client-side targeting**, select **Enabled**, and then type the name of the WSUS computer group to which you want to add this computer in the **Target group name for this computer** box.

    > [!NOTE]
    > **Enable client-side targeting** enables client computers to add themselves to target computer groups on the WSUS server, when Automatic Updates is redirected to a WSUS server. if the status is set to Enabled, this computer will identify itself as a member of a particular computer group when it sends information to the WSUS server, which uses it to determine which updates are deployed to this computer. This setting indicates to the WSUS server which group the client computer will use. You must create the group on the WSUS server, and add domain-member computers to that group.

6.  Click **OK** to close the **Enable client-side targeting** policy and return to the Windows Update details pane.

7.  Click **OK** to close the **Configure Automatic Updates** policy and return to the Windows Update details pane.

8.  In the **Windows Update** details pane, double-click **Specify intranet Microsoft update service location**.

9. Click **Enabled**, and then, server in the **Set the intranet update service for detecting updates** and **Set the intranet statistics server** text boxes, type the same URL of the WSUS server. For example, type *http://servername* in both boxes (where *servername* is the name of the WSUS server).

    > [!WARNING]
    > When you type the intranet address of your WSUS server make sure to specify which port is going to be used. By default WSUS will use port 8530 for HTTP and 8531 for HTTPS. For example, if you are using HTTP, you should type **http://servername:8530**.

10. Click **OK**.

After you set up a client computer, it will take several minutes before the computer appears on the **computers** page in the WSUS Administration Console. For client computers that are configured with a domain-based Group Policy Object, it can take about 20 minutes for Group Policy to apply the new policy settings to the client computer. By default, Group Policy updates in the background every 90 minutes, with a random offset of 0-30 minutes. if you want to update Group Policy sooner, you can open a Command prompt window on the client computer and type gpupdate /force.

for client computers that are configured by using the Local Group Policy editor, the GPO is applied immediately, and the update takes about 20 minutes. if you begin detection manually, you do not have to wait 20 minutes for the client computer to contact WSUS.

Because waiting for detection to start can be a time-consuming process, you can use the following procedure to initiate detection immediately.

##### To initiate WSUS detection

1.  On the client computer, open a Command prompt window with elevated privileges.

2.  type wuauclt.exe /detectnow, and then press ENTER.

## 2.5. Secure WSUS with the Secure Sockets Layer Protocol

You can use the Secure Sockets Layer (SSL) protocol to help secure the WSUS deployment. WSUS uses SSL to authenticate client computers and downstream WSUS servers to the WSUS server. WSUS also uses SSL to encrypt update metadata.

> [!IMPORTANT]
> Clients and downstream servers that are configured to use Transport Layer Security (TLS) or HTTPS must also be configured to use a fully qualified domain name (FQDN) for their upstream WSUS server.

WSUS uses SSL for metadata only, not for update files. This is the same way that Microsoft Update distributes updates. Microsoft reduces the risk of sending update files over an unencrypted channel by signing each update. In addition, a hash is computed and sent together with the metadata for each update. When an update is downloaded, WSUS checks the digital signature and hash. If the update has been changed, it is not installed.

### Limitations of WSUS SSL deployments
You must consider the following limitations when you use SSL to secure a WSUS deployment:

1.  Using SSL increases the server workload. You should expect a 10 percent loss of performance because of the cost of encrypting all the metadata that is sent over the network.

2.  If you use WSUS with a remote SQL Server database, the connection between the WSUS server and the database server is not secured by SSL. If the database connection must be secured, consider the following recommendations:

-   move the WSUS database to the WSUS server.

-   move the remote database server and the WSUS server to a private network.

-   deploy Internet Protocol security (IPsec) to help secure network traffic. For more information about IPsec, see [Creating and Using IPsec Policies](https://go.microsoft.com/fwlink/?LinkID=203841).

### Configure SSL on the WSUS server
WSUS requires two ports for SSL: one port that uses HTTPS to send encrypted metadata, and one port that uses HTTP to send updates. When you configure WSUS to use SSL, consider the following:

-   You cannot configure the whole WSUS website to require SSL because all traffic to the WSUS site would have to be encrypted. WSUS encrypts update metadata only. if a computer attempts to retrieve update files on the HTTPS port, the transfer will fail.

    You should require SSL for the following virtual roots only:

    -   **SimpleAuthWebService**

    -   **DSSAuthWebService**

    -   **ServerSyncWebService**

    -   **APIremoting30**

    -   **ClientWebService**

    You should not require SSL for the following virtual roots:

    -   **Content**

    -   **Inventory**

    -   **ReportingWebService**

    -   **SelfUpdate**

-   The certificate of the certification authority (CA) must be imported into the local computer Trusted Root CA store, or the Windows Server Update Service Trusted Root CA store on downstream WSUS servers. if the certificate is only imported to the Local User Trusted Root CA store, the downstream WSUS server will not be authenticated on the upstream server.

    for more information about how to use SSL certificates in IIS, see [Require Secure Sockets Layer (IIS 7)](https://go.microsoft.com/fwlink/?LinkID=203846).

-   You must import the certificate to all computers that will communicate with the WSUS server. This includes all client computers, downstream servers, and computers that run the WSUS Administration Console. The certificate should be imported into the local computer Trusted Root CA store or into the Windows Server Update Service Trusted Root CA store.

-   You can use any port for SSL. However, the port that you set up for SSL also determines the port that WSUS uses to send clear HTTP traffic. Consider the following examples:

    -   if you use the industry standard port of 443 for HTTPS traffic, WSUS uses the industry standard port 80 for clear HTTP traffic.

    -   if you use any port other than 443 for HTTPS traffic, WSUS will send clear HTTP traffic over the port that numerically comes before the port for HTTPS. For example, if you use port 8531 for HTTPS, WSUS will use port 8530 for HTTP.

-   You must re-initialize *ClientServicingProxy* if the server name, SSL configuration, or port number are changed.

##### To configure SSL on the WSUS root server

1.  Log on to the WSUS server by using an account that is a member of the WSUS Administrators group or the local Administrators group.

2.  Go to **start**, type **CMD**, right-click **Command prompt**, and then click **Run as administrator**.

3.  Navigate to the _%ProgramFiles%_**\\Update Services\\Tools\\** folder.

4.  In the Command prompt window, type the following command:

    **Wsusutil configuressl**_certificateName_

    where:

    *certificateName* is the DNS name of the WSUS server.

### Configure SSL on client computers
When you configure SSL on client computers, you should consider the following issues:

-   You must include a URL for a secure port on the WSUS server. Because you cannot require SSL on the server, the only way to make sure that client computers can use a security channel is by using a URL that specifies HTTPS. if you use any port other than 443 for SSL, you must include that port in the URL also.

-   The certificate on a client computer must be imported into the Local computer Trusted Root CA store or Automatic Update Service Trusted Root CA store. if the certificate is imported to the Local User's Trusted Root CA store only, Automatic Updates will fail server authentication.

-   The client computers must trust the certificate that you bind to the WSUS server. Depending on the type of certificate that is used, you might have to set up a service to enable the client computers to trust the certificate that is bound to the WSUS server.

### Configure SSL for downstream WSUS servers
The following instructions configure a downstream server to synchronize to an upstream server that uses SSL.

##### To synchronize a downstream server to an upstream server that uses SSL

1.  Log on to the computer by using a user account that is a member of the local Administrators group or the WSUS Administrators group.

2.  Click **start**, click **All Programs**, click **Administrative Tools**, and then click **Windows Server Update Service**.

3.  In the right pane, expand the server name.

4.  Click **Options**, and then click **Update Source and Proxy Server**.

5.  On the **Update Source** page, select **Synchronize from another Windows Server Update Services server**.

6.  type the name of the upstream server into the **Server name** text box. type the port number that the server uses for SSL connections into the **Port number** text box.

7.  select the **Use SSL when synchronizing update information** check box, and then click **OK**.

### additional SSL resources
The steps that are required to set up a certification authority, bind the certificate to the WSUS website, and establish a trust between the client computers and the certificate are beyond the scope of this guide. For more information and for instructions about how to install certificates and set up this environment, see the following topics:

-   [Suite B PKI Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkID=203858)

-   [Implementing and Administering Certificate Templates](https://go.microsoft.com/fwlink/?LinkID=203859)

-   [active directory Certificate Services Upgrade and Migration Guide](https://go.microsoft.com/fwlink/?LinkID=203860)

-   [Configure Certificate Autoenrollment](https://go.microsoft.com/fwlink/?LinkID=203861)

### 2.6. Complete IIS Configuration
By default, anonymous read access is enabled for the default and all new IIS websites. Some applications, notably Windows SharePoint Services, may remove anonymous access. if this has occurred, you must re-enable the anonymous read access before you can successfully install and operate WSUS.

To enable anonymous read access, follow the steps for the applicable version of IIS:

1.  [Enable Anonymous Authentication (IIS 7)](https://go.microsoft.com/fwlink/?LinkID=205316), as documented in the IIS 7 Operations Guide.

2.  [Enabling Anonymous Authentication (IIS 6.0)](https://go.microsoft.com/fwlink/?LinkId=211391), as documented in the IIS 6.0 Operations Guide.

### 2.7. Configure a Signing Certificate
WSUS has the ability to publish custom update packages to update Microsoft and non-Microsoft products. WSUS can automatically sign these custom update packages for you with an Authenticode certificate. To enable custom update signing, you must install a package signing certificate on your WSUS server. There are several considerations associated with custom update signing.

1.  **Certificate Distribution**. The private key must be installed on the WSUS server, and the public key must be explicitly installed in the trusted certificate store on all client PCs and servers which are to receive custom-signed updates.

2.  **Expiration**. When the self-signed certificate expires or nears expiration, WSUS will log events in the event log.

3.  **Certificate Updates/Revocation**. if you wanted to update or revoke a certificate (i.e. after discovering that it expired), WSUS offered no functionality to enable this. Accomplishing this turned into a manual task that was very hard to either do by hand or automate successfully.


