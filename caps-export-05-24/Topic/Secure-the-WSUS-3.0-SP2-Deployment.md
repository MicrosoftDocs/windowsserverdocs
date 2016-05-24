---
title: Secure the WSUS 3.0 SP2 Deployment
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c494e41-05d1-4403-ae7b-4fbca2e56cd7
author: britw
---
# Secure the WSUS 3.0 SP2 Deployment
This topic describes several ways that you can improve the security of a WSUS deployment.  
  
In this topic:  
  
-   [Best practices for security](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#BKMK_securitybp)  
  
-   [Create WSUS administrators](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#admins)  
  
-   [Secure the WSUS server components](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#harden)  
  
-   [Add authentication for connected WSUS servers in an Active Directory environment](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#authad)  
  
-   [Secure WSUS with the Secure Sockets Layer Protocol](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#ssl)  
  
## <a name="BKMK_securitybp"></a>Best practices for security  
The following practices can help you secure your WSUS network.  
  
-   **Secure Sockets Layer \(SSL\)**  
    Use the Secure Sockets Layer \(SSL\) for WSUS connections \(server\-to\-server or server\-to\-client computer\) on all computers that download updates through the Internet. For more information about configuring SSL, see [Secure WSUS with the Secure Sockets Layer Protocol](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#ssl).  
  
-   **Internet Protocol security \(IPsec\)**  
    If you do not want to use SSL, you can deploy Internet Protocol security \(IPsec\) on your network to secure network traffic. [Overview of IPsec Deployment](http://go.microsoft.com/fwlink/?LinkId=45154) offers guidance about how to deploy IPsec in your environment.  
  
-   **Firewall**  
    Make sure that the WSUS server that downloads updates from Microsoft Update is secured behind a firewall, and that it allows access only to the domains needed by WSUS.  
  
-   **Signed Windows Installer \(.MSI file\)**  
    A WSUS update publisher can specify a remote UNC path for an executable file \(specified as OriginURI\). This OriginURI is used by the Windows Installer \(.MSI file\) as a repair path, but may point to a Windows Installer that is unsigned. Because the integrity of the file is not protected with signing, the file is vulnerable to malicious code that can be executed remotely.  
  
-   **Permissions**  
    Make sure that WSUS servers have only the file and folder permissions that are needed by WSUS.  
  
-   **Remote SQL Server**  
    If a WSUS server is Internet\-facing, its database should be located on a different computer that is not reachable from the Internet.  
  
-   **Security groups**  
    There are two security groups that are set up for WSUS: WSUS Administrators and WSUS Reporters. WSUS Administrators can perform any WSUS task, and WSUS Reporters have read\-only access. Add only people who need to perform administrative tasks to the WSUS Administrators group.  
  
## <a name="admins"></a>Create WSUS administrators  
During installation, WSUS Setup creates two security groups called *WSUS Administrators* and *WSUS Reporters*. You can add users to these groups to delegate WSUS management tasks. By adding WSUS Administrators, you avoid the security risk of requiring administrators to be members of the local Administrators group on the WSUS server.  
  
Members of the WSUS Administrators group can use all features of the WSUS Administration Console. Members of the WSUS Reporters group have read\-only access to the WSUS Administration Console, and read\-only access to WSUS data.  
  
For instructions about how to add members to these groups, see [Add a member to a local group](http://go.microsoft.com/fwlink/?LinkID=203887).  
  
## <a name="harden"></a>Secure the WSUS server components  
We recommend that you apply the recommended settings that are described in the [WSUS 3.0 SP2 Security Settings](../Topic/WSUS-3.0-SP2-Security-Settings.md) section of the [Windows Server Update Services 3.0 SP2 Technical Reference](../Topic/Windows-Server-Update-Services-3.0-SP2-Technical-Reference.md) to help secure the WSUS server, Internet Information Services \(IIS\), and SQL Server.  
  
> [!WARNING]  
> The WSUS Administration Console cannot be safely used over HTTP, although HTTP is the default option when connecting to a server. HTTP traffic may still be insecure even when Internet Protocol Security \(IPsec\) is deployed.  
>   
> -   You should use HTTPS to connect to any remote WSUS server. If administrators want to connect insecurely, they should have other, physical protections for the connection such as immediate physical proximity, or connecting via cross over cable.  
> -   Consider implementing a mechanism to allow the use of simple, self\-signed certificates for WSUS, where initial connections require accepting the self\-signed certificate and must be done on a physically secured connection, but subsequent connections validate that the Transport Layer Security \(TLS\) certificate has not changed. If the TLS certificate has changed, block the connection and require user intervention.  
  
## <a name="authad"></a>Add authentication for connected WSUS servers in an Active Directory environment  
You can add authentication for server\-to\-server synchronization in an Active Directory environment. If the WSUS servers are located in different forests, a trust between the forests must exist for this authentication method to succeed.  
  
To enable server\-to\-server synchronization, follow these steps:  
  
1.  [Create and add a list of approved WSUS servers to the Web.config file](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#createlist)  
  
2.  [Disable anonymous access to the WSUS server](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#disanon)  
  
### <a name="createlist"></a>Create and add a list of approved WSUS servers to the Web.config file  
To create a list of downstream WSUS servers that can authenticate with the root WSUS server, you need to modify the Web.config file. The Web.config file is an XML file that is created by the WSUS Setup program. The Web.config file is located on the WSUS server in the: *%ProgramFiles%***\\Update Services\\WebServices\\serversyncwebservice\\** folder.  
  
##### To modify the Web.config file  
  
1.  Right\-click **Start**, and then click **Windows Explorer**.  
  
2.  Navigate to the *%ProgramFiles%***\\Update Services\\WebServices\\serversyncwebservice\\** folder.  
  
3.  Right\-click the **Web.config** file, point to **Open with**, and then select a program to change the file.  
  
    > [!TIP]  
    > You can use Notepad to change the Web.config file.  
  
4.  Add the `<authorization>` element under the `<configuration>` and `<system.web>` elements.  
  
5.  Between the opening and closing `<authorization>` tags, add the list of WSUS servers that are authorized to use IIS. You must enter these computer names in the form of `domain\computer_name`. You can separate computer names by using a comma. You can also specify an explicit list of computers to which access to the WSUS website is denied.  
  
    The following snippet is an example of an entry in the Web.config file:  
  
    ```  
    configuration>  
        <system.web>  
            <authorization>  
               <allow users="domain\computer_name,domain\computer_name" />  
               <deny users="domain\computer_name,domain\computer_name" />  
            </authorization>  
         </system.web>  
    </configuration>  
    ```  
  
    > [!IMPORTANT]  
    > Order in this list is important, because the evaluation stops with the first item that applies to the user. If the `<allow users>` element is absent or empty, all servers are allowed access.  
  
6.  Click **File**, and then click **Save**to save the changes to the file.  
  
To view the XML schema for this element, see [authorization Element \(ASP.NET Settings Schema\)](http://go.microsoft.com/fwlink/?LinkID=203818).  
  
### <a name="disanon"></a>Disable anonymous access to the WSUS server  
After you modify the Web.config file to include only authorized WSUS servers, you must configure IIS in the following ways:  
  
-   Disable anonymous access to the **ServerSyncWebService** virtual directory.  
  
-   Enable Integrated Windows authentication.  
  
##### To configure IIS  
  
1.  On the **Start** menu, click **Programs**, click **Administrative Tools**, and then click **Internet Information Services \(IIS\) Manager**.  
  
2.  In the Connections pane, expand the server name, expand **Sites**, expand **Default Web Site**, and then click **ServerSyncWebService**.  
  
    In the ServerSyncWebService Home pane, under **Security**, right\-click **Authentication**.  
  
3.  Right\-click the row that contains **Anonymous Access**, and then click **Disable**.  
  
4.  Right\-click the row that contains **Windows Authentication**, and then click **Enable**.  
  
5.  Click **OK** twice.  
  
## <a name="ssl"></a>Secure WSUS with the Secure Sockets Layer Protocol  
You can use the Secure Sockets Layer \(SSL\) protocol to help secure the WSUS deployment. WSUS uses SSL to authenticate client computers and downstream WSUS servers to the WSUS server. WSUS also uses SSL to encrypt update metadata.  
  
> [!IMPORTANT]  
> Clients and downstream servers that are configured to use Transport Layer Security \(TLS\) or HTTPS must also be configured to use a fully qualified domain name \(FQDN\) for their upstream WSUS server.  
  
WSUS uses SSL for metadata only, not for update files. This is the same way that Microsoft Update distributes updates. Microsoft reduces the risk of sending update files over an unencrypted channel by signing each update. In addition, a hash is computed and sent together with the metadata for each update. When an update is downloaded, WSUS checks the digital signature and hash. If the update has been changed, it is not installed.  
  
### <a name="ssllmits"></a>Limitations of WSUS SSL deployments  
You must consider the following limitations when you use SSL to secure a WSUS deployment:  
  
1.  Using SSL increases the server workload. You should expect a 10 percent loss of performance because of the cost of encrypting all the metadata that is sent over the network.  
  
2.  If you use WSUS with a remote SQL Server database, the connection between the WSUS server and the database server is not secured by SSL. If the database connection must be secured, consider the following recommendations:  
  
-   Move the WSUS database to the WSUS server.  
  
-   Move the remote database server and the WSUS server to a private network.  
  
-   Deploy Internet Protocol security \(IPsec\) to help secure network traffic. For more information about IPsec, see [Creating and Using IPsec Policies](http://go.microsoft.com/fwlink/?LinkID=203841).  
  
### <a name="consswsus"></a>Configure SSL on the WSUS server  
WSUS requires two ports for SSL: one port that uses HTTPS to send encrypted metadata, and one port that uses HTTP to send updates. When you configure WSUS to use SSL, consider the following:  
  
-   You cannot configure the whole WSUS website to require SSL because all traffic to the WSUS site would have to be encrypted. WSUS encrypts update metadata only. If a computer attempts to retrieve update files on the HTTPS port, the transfer will fail.  
  
    You should require SSL for the following virtual roots only:  
  
    -   **SimpleAuthWebService**  
  
    -   **DSSAuthWebService**  
  
    -   **ServerSyncWebService**  
  
    -   **APIRemoting30**  
  
    -   **ClientWebService**  
  
    You should not require SSL for the following virtual roots:  
  
    -   **Content**  
  
    -   **Inventory**  
  
    -   **ReportingWebService**  
  
    -   **SelfUpdate**  
  
-   The certificate of the certification authority \(CA\) must be imported into the local computer Trusted Root CA store, or the Windows Server Update Service Trusted Root CA store on downstream WSUS servers. If the certificate is only imported to the Local User Trusted Root CA store, the downstream WSUS server will not be authenticated on the upstream server.  
  
    For more information about how to use SSL certificates in IIS, see [Require Secure Sockets Layer \(IIS 7\)](http://go.microsoft.com/fwlink/?LinkID=203846).  
  
-   You must import the certificate to all computers that will communicate with the WSUS server. This includes all client computers, downstream servers, and computers that run the WSUS Administration Console. The certificate should be imported into the local computer Trusted Root CA store or into the Windows Server Update Service Trusted Root CA store.  
  
-   You can use any port for SSL. However, the port that you set up for SSL also determines the port that WSUS uses to send clear HTTP traffic. Consider the following examples:  
  
    -   If you use the industry standard port of 443 for HTTPS traffic, WSUS uses the industry standard port 80 for clear HTTP traffic.  
  
    -   If you use any port other than 443 for HTTPS traffic, WSUS will send clear HTTP traffic over the port that numerically comes before the port for HTTPS. For example, if you use port 8531 for HTTPS, WSUS will use port 8530 for HTTP.  
  
-   You must re\-initialize *ClientServicingProxy* if the server name, SSL configuration, or port number are changed.  
  
##### To configure SSL on the WSUS root server  
  
1.  Log on to the WSUS server by using an account that is a member of the WSUS Administrators group or the local Administrators group.  
  
2.  [!INCLUDE[cmd_admin](../Token/cmd_admin_md.md)]  
  
3.  Navigate to the *%ProgramFiles%***\\Update Services\\Tools\\** folder.  
  
4.  In the Command Prompt window, type the following command:  
  
    **Wsusutil configuressl** *certificateName*  
  
    where:  
  
    *certificateName* is the DNS name of the WSUS server.  
  
### <a name="consslclient"></a>Configure SSL on client computers  
When you configure SSL on client computers, you should consider the following issues:  
  
-   You must include a URL for a secure port on the WSUS server. Because you cannot require SSL on the server, the only way to make sure that client computers can use a security channel is by using a URL that specifies HTTPS. If you use any port other than 443 for SSL, you must include that port in the URL also.  
  
    For example, `https://<ssl-servername>` specifies a WSUS server that uses port 443 for HTTPS. `https://<ssl-servername>:3051` specifies a WSUS server that uses a custom SSL port of3051.  
  
    For instructions about how to direct client computers to a WSUS server to configure Automatic Updates by using Group Policy, see [Specify internal WSUS server for updates](../Topic/Configure-Automatic-Updates-using-Group-Policy.md#specserver). If you do not use Group Policy to manage computers on the network, see Configure Automatic Updates by using the Registry Editor .  
  
-   The certificate on a client computer must be imported into the Local Computer Trusted Root CA store or Automatic Update Service Trusted Root CA store. If the certificate is imported to the Local User's Trusted Root CA store only, Automatic Updates will fail server authentication.  
  
-   The client computers must trust the certificate that you bind to the WSUS server. Depending on the type of certificate that is used, you might have to set up a service to enable the client computers to trust the certificate that is bound to the WSUS server. For more information about certificates, see [Additional SSL resources](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#addlsl).  
  
### <a name="consslds"></a>Configure SSL for downstream WSUS servers  
The following instructions configure a downstream server to synchronize to an upstream server that uses SSL.  
  
##### To synchronize a downstream server to an upstream server that uses SSL  
  
1.  Log on to the computer by using a user account that is a member of the local Administrators group or the WSUS Administrators group.  
  
2.  Click **Start**, click **All Programs**, click **Administrative Tools**, and then click **Windows Server Update Service**.  
  
3.  In the right pane, expand the server name.  
  
4.  Click **Options**, and then click **Update Source and Proxy Server**.  
  
5.  On the **Update Source** page, select **Synchronize from another Windows Server Update Services server**.  
  
6.  Type the name of the upstream server into the **Server name** text box. Type the port number that the server uses for SSL connections into the **Port number** text box.  
  
7.  Select the **Use SSL when synchronizing update information** check box, and then click **OK**.  
  
### <a name="addlsl"></a>Additional SSL resources  
The steps that are required to set up a certification authority, bind the certificate to the WSUS website, and establish a trust between the client computers and the certificate are beyond the scope of this guide. For more information and for instructions about how to install certificates and set up this environment, see the following topics:  
  
-   [Suite B PKI Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkID=203858)  
  
-   [Implementing and Administering Certificate Templates](http://go.microsoft.com/fwlink/?LinkID=203859)  
  
-   [Active Directory Certificate Services Upgrade and Migration Guide](http://go.microsoft.com/fwlink/?LinkID=203860)  
  
-   [Configure Certificate Autoenrollment](http://go.microsoft.com/fwlink/?LinkID=203861)  
  
