---
title: Step 1 Configure Advanced DirectAccess Infrastructure
description: This topic is part of the guide Deploy a Single DirectAccess Server with Advanced Settings for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 43abc30a-300d-4752-b845-10a6b9f32244
ms.author: pashort
author: shortpatti
---
# Step 1 Configure Advanced DirectAccess Infrastructure

>Applies To: Windows Server 2012 R2, Windows Server 2012

This topic describes how to configure the infrastructure that is required for an advanced Remote Access deployment that uses a single DirectAccess server in a mixed IPv4 and IPv6 environment. Before you begin the deployment steps, ensure that you have completed the planning steps that are described in [Plan an Advanced DirectAccess Deployment](../../../remote-access/directaccess/single-server-advanced/Plan-an-Advanced-DirectAccess-Deployment.md).  
  
|Task|Description|  
|----|--------|  
|1.1 Configure server network settings|Configure the server network settings on the DirectAccess server.|  
|1.2 Configure force tunneling|Configure force tunneling.|  
|1.3 Configure routing in the corporate network|Configure routing in the corporate network.|  
|1.4 Configure firewalls|Configure additional firewalls, if required.|  
|1.5 Configure CAs and certificates|Configure a certification authority (CA), if required, and any other certificate templates that are required in the deployment.|  
|1.6 Configure the DNS server|Configure the Domain Name System (DNS) settings for the DirectAccess server.|  
|1.7 Configure Active Directory|Join client computers and the DirectAccess server to the Active Directory domain.|  
|1.8 Configure GPOs|Configure GPOs for the deployment, if required.|  
|1.9 Configure security groups|Configure security groups that will contain DirectAccess client computers, and any other security groups that are required in the deployment.|  
|1.10 Configure the network location server|Configure the network location server, including installing the network location server website certificate.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="ConfigNetworkSettings"></a>1.1 Configure server network settings  
The following network interface settings are required for a single server deployment in an environment that is using IPv4 and IPv6. All IP addresses are configured by using **Change adapter settings** in the **Windows Networking and Sharing Center**.  
  
**Edge topology**  
  
-   Two Internet-facing consecutive public static IPv4 or IPv6 addresses  
  
    > [!NOTE]  
    > Two public addresses are required for Teredo. If you are not using Teredo, you can configure a single public static IPv4 address.  
  
-   A single internal static IPv4 or IPv6 address  
  
**Behind NAT device (with two network adapters)**  
  
-   A single Internet-facing static IPv4 or IPv6 address  
  
-   A single internal network-facing static IPv4 or IPv6 address  
  
**Behind NAT device (with one network adapter)**  
  
-   A single internal network-facing static IPv4 or IPv6 address  
  
> [!NOTE]  
> If a DirectAccess server with two or more network adapters (one classified in the domain profile and the other in a public or private profile) is configured with a single network adapter topology, we recommend the following:  
>   
> -   Ensure that the second network adapter and any additional network adapters are classified in the domain profile.  
> -   If the second network adapter cannot be configured for the domain profile, the DirectAccess IPsec policy must be manually scoped to all profiles by using the following Windows PowerShell command after DirectAccess is configured:  
>   
>     ```  
>     $gposession = Open-NetGPO "PolicyStore <Name of the server GPO>  
>     Set-NetIPsecRule "DisplayName <Name of the IPsec policy> "GPOSession $gposession "Profile Any  
>     Save-NetGPO "GPOSession $gposession  
>     ```  
  
## <a name="BKMK_forcetunnel"></a>1.2 Configure force tunneling  
Force tunneling can be configured through the Remote Access Setup Wizard. It is presented as a check box in the Configure Remote Clients Wizard. This setting only affects DirectAccess clients. If VPN is enabled, VPN clients will by default use force tunneling. Administrators can change the setting for VPN clients from the client profile.  
  
Selecting the check box for force tunneling does the following:  
  
-   Enables force tunneling on DirectAccess clients  
  
-   Adds an **Any** entry in the Name Resolution Policy Table (NRPT) for DirectAccess clients, which means that all DNS traffic will go to the internal network DNS servers  
  
-   Configures DirectAccess clients to always use the IP-HTTPS transition technology  
  
To make Internet resources available to DirectAccess clients that use force tunneling, you can use a proxy server, which can receive IPv6-based requests for Internet resources and translate them to requests for IPv4-based Internet resources. To configure a proxy server for Internet resources, you need to modify the default entry in NRPT to add the proxy server. You can accomplish this by using the Remote Access PowerShell cmdlets or the DNS PowerShell cmdlets. For example, use the Remote Access PowerShell cmdlet as follows:  
  
```  
Set-DAClientDNSConfiguration "DNSSuffix "." "ProxyServer <Name of the proxy server:port>  
```  
  
> [!NOTE]  
> If DirectAccess and VPN are enabled on the same server, and VPN is in force-tunnel mode, and the server is deployed in an edge topology or a behind NAT topology (with two network adapters, one connected to the domain and one to a private network), VPN Internet traffic cannot be forwarded through the external interface of the DirectAccess server. To enable this scenario, organizations must deploy Remote Access on the server behind a firewall in single network adapter topology. Alternatively, organizations can use a separate proxy server in the internal network to forward the Internet traffic from VPN clients.  
  
> [!NOTE]  
> If an organization is using a web proxy for DirectAccess clients to access Internet resources, and the corporate proxy is not capable of handling internal network resources, DirectAccess clients will not be able to access internal resources if they are outside the intranet. In such a scenario, to enable DirectAccess clients to access internal resources, manually create NRPT entries for the internal network suffixes by using the DNS page of the infrastructure wizard. Do not apply proxy settings on these NRPT suffixes. The suffixes should be populated with default DNS server entries.  
  
## <a name="ConfigRouting"></a>1.3 Configure routing in the corporate network  
Configure routing in the corporate network as follows:  
  
-   When native IPv6 is deployed in the organization, add a route so that the routers on the internal network route IPv6 traffic back through the DirectAccess server.  
  
-   Manually configure the organization"s IPv4 and IPv6 routes on the DirectAccess servers. Add a published route so that all traffic with an organization (/48) IPv6 prefix is forwarded to the internal network. For IPv4 traffic, add explicit routes so that IPv4 traffic is forwarded to the internal network.  
  
## <a name="ConfigFirewalls"></a>1.4 Configure firewalls  
When using additional firewalls in your deployment, apply the following Internet-facing firewall exceptions for Remote Access traffic when the DirectAccess server is on the IPv4 Internet:  
  
-   Teredo traffic"User Datagram Protocol (UDP) destination port 3544 inbound, and UDP source port 3544 outbound.  
  
-   6to4 traffic"IP Protocol 41 inbound and outbound.  
  
-   IP-HTTPS"Transmission Control Protocol (TCP) destination port 443, and TCP source port 443 outbound. When the DirectAccess server has a single network adapter, and the network location server is on the DirectAccess server, then TCP port 62000 is also required.  
  
    > [!NOTE]  
    > This exemption must be configured on the DirectAccess server, while all the other exemptions have to be configured on the edge firewall.  
  
> [!NOTE]  
> For Teredo and 6to4 traffic, these exceptions should be applied for both of the Internet-facing consecutive public IPv4 addresses on the DirectAccess server. For IP-HTTPS the exceptions need only be applied to the address where the public name of the server resolves.  
  
When using additional firewalls, apply the following Internet-facing firewall exceptions for Remote Access traffic when the DirectAccess server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
-   Internet Control Message Protocol for IPv6 (ICMPv6) traffic inbound and outbound " for Teredo implementations only.  
  
When using additional firewalls, apply the following internal network firewall exceptions for Remote Access traffic:  
  
-   ISATAP"Protocol 41 inbound and outbound  
  
-   TCP/UDP for all IPv4/IPv6 traffic  
  
-   ICMP for all IPv4/IPv6 traffic  
  
## <a name="ConfigCAs"></a>1.5 Configure CAs and certificates  
Remote Access in  Windows Server 2012  allows you to choose between using certificates for computer authentication or using a built in Kerberos proxy that authenticates using user names and passwords. You must also configure an IP-HTTPS certificate on the DirectAccess server.  
  
For more information, see [Active Directory Certificate Services](https://technet.microsoft.com/library/cc770357.aspx).  
  
### 1.5.1 Configure IPsec authentication  
A computer certificate is required on the DirectAccess server and on all DirectAccess clients to use IPsec authentication. The certificate must be issued by an internal certification authority (CA), and DirectAccess servers and DirectAccess clients must trust the CA chain that issues root and intermediate certificates.  
  
##### To configure IPsec authentication  
  
1.  In the internal CA, decide if you will use the **Computer** certificate template, or if you will create a new certificate template as described in [Creating Certificate Templates](https://technet.microsoft.com/library/cc731705.aspx).  
  
    > [!NOTE]  
    > If you create a new template, it must be configured for Client Authentication.  
  
2.  Deploy the certificate template, if required. For more information, see [Deploying Certificate Templates](https://technet.microsoft.com/library/cc770794.aspx).  
  
3.  Configure the certificate template for autoenrollment, if required. For more information, see [Configure Certificate Autoenrollment](https://technet.microsoft.com/library/cc731522.aspx).  
  
### <a name="ConfigCertTemp"></a>1.5.2 Configure certificate templates  
When you use an internal CA to issue certificates, you must configure a certificate template for the IP-HTTPS certificate and the network location server website certificate.  
  
##### To configure a certificate template  
  
1.  In the internal CA, create a certificate template as described in [Creating Certificate Templates](https://technet.microsoft.com/library/cc731705.aspx).  
  
2.  Deploy the certificate template as described in [Deploying Certificate Templates](https://technet.microsoft.com/library/cc770794.aspx).  
  
### 1.5.3 Configure the IP-HTTPS certificate  
Remote Access requires an IP-HTTPS certificate to authenticate IP-HTTPS connections to the DirectAccess server. There are three certificate options that are available for IP-HTTPS authentication:  
  
**Public certificate**  
  
A public certificate is supplied by a third party. If the certificate subject name does not contain wildcard characters, it must be the externally resolvable fully qualified domain name (FQDN) URL that is used only for the DirectAccess server IP-HTTPS connections.  
  
**Private certificate**  
  
If you use a private certificate, the following are required, if they do not already exist:  
  
-   A website certificate that is used for IP-HTTPS authentication. The certificate subject should be an externally resolvable FQDN that is reachable from the Internet. The certificate is based on the certificate template that you created by following the instructions in 1.5.2 Configure certificate templates.  
  
-   A certificate revocation list (CRL) distribution point that is reachable from a publicly resolvable FQDN.  
  
**Self-signed certificate**  
  
If you use a self-signed certificate, the following are required, if they do not already exist:  
  
-   A website certificate that is used for IP-HTTPS authentication. The certificate subject should be an externally resolvable FQDN that is reachable from the Internet.  
  
-   A CRL distribution point that is reachable from a publicly resolvable FQDN.  
  
> [!NOTE]  
> Self-signed certificates cannot be used in multisite deployments.  
  
Make sure that the website certificate that is used for IP-HTTPS authentication meets the following requirements:  
  
-   The common name of the certificate should match the name of the IP-HTTPS site.  
  
-   In the **Subject** field, specify  the FQDN of the IP-HTTPS URL.  
  
-   For the **Enhanced Key Usage** field, use the server authentication object identifier (OID).  
  
-   For the **CRL Distribution Points** field, specify a CRL distribution point that is accessible by DirectAccess clients that are connected to the Internet.  
  
-   The IP-HTTPS certificate must have a private key.  
  
-   The IP-HTTPS certificate must be imported directly into the personal store.  
  
-   IP-HTTPS certificates can have wildcard characters in the name.  
  
##### To install the IP-HTTPS certificate from an internal CA  
  
1.  On the DirectAccess server: On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  In the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, select the check box for the certificate template that you previously created (for more information, see 1.5.2 Configure certificate templates). If required, click **More information is required to enroll for this certificate**.  
  
8.  In the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common Name**.  
  
9. In **Value**, specify the IPv4 address of the external facing adapter of the DirectAccess server or the FQDN of the IP-HTTPS URL, and then click **Add**.  
  
10. In the **Alternative name** area, in **Type**, select **DNS**.  
  
11. In **Value**, specify the IPv4 address of the external facing adapter of the DirectAccess server or the FQDN of the IP-HTTPS URL, and then click **Add**.  
  
12. On the **General** tab, in **Friendly name**, you can enter a name that will help you identify the certificate.  
  
13. On the **Extensions** tab, click the arrow next to **Extended Key Usage**, and make sure that **Server Authentication** appears in the **Selected options** list.  
  
14. Click **OK**, click **Enroll**, and then click **Finish**.  
  
15. In the details pane of the Certificates snap-in, verify that the new certificate was enrolled with Intended Purposes of Server Authentication.  
  
## <a name="ConfigDNS"></a>1.6 Configure the DNS server  
You must manually configure a DNS entry for the network location server website for the internal network in your deployment.  
  
### <a name="NLS_DNS"></a>To create the network location server  
  
1.  On the internal network DNS server: On the **Start** screen, type**dnsmgmt.msc**, and then press ENTER.  
  
2.  In the left pane of the **DNS Manager** console, expand the forward lookup zone for your domain. Right click the domain, and click **New Host (A or AAAA)**.  
  
3.  In the **New Host** dialog box, In the **IP address** box:  
  
    -   In the **Name (uses parent domain name if blank)** box, enter the DNS name for the network location server website (this is the name that the DirectAccess clients use to connect to the network location server).  
  
    -   Enter the IPv4 or IPv6 address of the network location server, and then click **Add Host**, and then click **OK**.  
  
4.  In the **New Host** dialog box:  
  
    -   In the **Name (uses parent domain name if blank)** box, enter the DNS name for the web probe (the name for the default web probe is **directaccess-webprobehost**).  
  
    -   In the **IP address** box, enter the IPv4 or IPv6 address of the web probe, and then click **Add Host**.  
  
    -   Repeat this process for **directaccess-corpconnectivityhost** and any manually created connectivity verifiers.  
  
5.  In the **DNS** dialog box, click **OK**, and then click **Done**.  
  
![Windows PowerShell](../../../media/Step-1-Configuring-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Add-DnsServerResourceRecordA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv4Address <network_location_server_IPv4_address>  
Add-DnsServerResourceRecordAAAA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv6Address <network_location_server_IPv6_address>  
```  
  
You must also configure DNS entries for the following:  
  
-   **The IP-HTTPS server**  
  
    DirectAccess clients must be able to resolve the DNS name of the DirectAccess server from the Internet.  
  
-   **CRL revocation checking**  
  
    DirectAccess uses certificate revocation checking for the IP-HTTPS connection between DirectAccess clients and the DirectAccess server, and for the HTTPS-based connection between the DirectAccess client and the network location server. In both cases, DirectAccess clients must be able to resolve and access the CRL distribution point location.  
  
-   **ISATAP**  
  
    Intrasite Automatic Tunnel Addressing Protocol (ISATAP) uses tunneling to enable DirectAccess clients to connect to the DirectAccess server over the IPv4 Internet, encapsulating IPv6 packets within an IPv4 header. It is used by Remote Access to provide IPv6 connectivity to ISATAP hosts across an intranet. In a non-native IPv6 network environment, the DirectAccess server configures itself automatically as an ISATAP router. Resolution support for the ISATAP name is required.  
  
## <a name="ConfigAD"></a>1.7 Configure Active Directory  
The DirectAccess server and all DirectAccess client computers must be joined to an Active Directory domain. DirectAccess client computers must be a member of one of the following domain types:  
  
-   Domains that belong in the same forest as the DirectAccess server.  
  
-   Domains that belong to forests with a two-way trust with the DirectAccess server forest.  
  
-   Domains that have a two-way domain trust to the DirectAccess server domain.  
  
#### To join the DirectAccess server to a domain  
  
1.  In Server Manager, click **Local Server**. In the details pane, click the link next to **Computer name**.  
  
2.  In the **System Properties** dialog box, click the **Computer Name** tab, and then click **Change**.  
  
3.  In **Computer Name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server (for example, corp.contoso.com), and then click **OK**.  
  
4.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
5.  When you see a dialog box that welcomes you to the domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  In the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
#### To join client computers to the domain  
  
1.  On the **Start** screen, type**explorer.exe**, and then press ENTER.  
  
2.  Right-click the Computer icon, and then click **Properties**.  
  
3.  On the **System** page, click **Advanced system settings**.  
  
4.  In the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
5.  In **Computer name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server (for example, corp.contoso.com), and then click **OK**.  
  
6.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
7.  When you see a dialog box that welcomes you to the domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. In the **System Properties** dialog box, click **Close**.  
  
10. When you are prompted to restart the computer, click **Restart Now**.  
  
![Windows PowerShell](../../../media/Step-1-Configuring-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
> [!NOTE]  
> You must supply domain credentials when you enter the following **Add-Computer** command.  
  
```  
Add-Computer -DomainName <domain_name>  
Restart-Computer  
```  
  
## <a name="ConfigGPOs"></a>1.8 Configure GPOs  
A minimum of two Group Policy Objects are required to deploy Remote Access:  
  
-   One contains settings for the DirectAccess server  
  
-   One contains settings for DirectAccess client computers  
  
When you configure Remote Access, the wizard automatically creates the required Group Policy Objects. However, if your organization enforces a naming convention, you can type a name in the GPO dialog box in the Remote Access Management console. For more information, see 2.7. Configuration summary and alternate GPOs. If you have created permissions, the GPO will be created. If you do not have the required permissions to create GPOs, they must be created prior to configuring Remote Access.  
  
To create Group Policy Objects, see [Create and Edit a Group Policy Object](https://technet.microsoft.com/library/cc754740.aspx).  
  
> [!IMPORTANT]  
> Administrators can manually link the DirectAccess Group Policy Objects to an organizational unit (OU) by following these steps:  
>   
> 1.  Before you configure DirectAccess, link the created GPOs to the respective OUs.  
> 2.  When you configure DirectAccess, specify a security group for the client computers.  
> 3.  The Remote Access administrator may or may not have permissions to link the Group Policy Objects to the domain. In either case, the Group Policy Objects will be configured automatically. If the GPOs are already linked to an OU, the links will not be removed, and the GPOs will not be linked to the domain. For a server GPO, the OU must contain the server computer object, or the GPO will be linked to the root of the domain.  
> 4.  If you did not link to the OU before running the DirectAccess Wizard, after the configuration is complete, the domain administrator can link the DirectAccess Group Policy Objects to the required OUs. The link to the domain can be removed. For more information, see [Link a Group Policy Object](https://technet.microsoft.com/library/cc732979.aspx).  
  
> [!NOTE]  
> If a Group Policy Object was created manually, it is possible that the Group Policy Object will not be available during the DirectAccess configuration. The Group Policy Object may not have been replicated to the closest domain controller to the management computer. In this event, the administrator can wait for replication to complete, or force the replication.  
  
### 1.8.1 Configure Remote Access GPOs with limited permissions  
In a deployment that uses staging and production GPOs, the domain administrator should do the following:  
  
1.  Obtain the list of required GPOs for the Remote Access deployment from the Remote Access administrator. For more information, see 1.8 Plan Group Policy Objects.  
  
2.  For each GPO that is requested by the Remote Access administrator, create a pair of GPOs with different names. The first will be used as the staging GPO, and the second as the production GPO.  
  
    To create Group Policy Objects, see [Create and Edit a Group Policy Object](https://technet.microsoft.com/library/cc754740.aspx).  
  
3.  To link the production GPOs, see [Link a Group Policy Object](https://technet.microsoft.com/library/cc732979).  
  
4.  Grant the Remote Access administrator **Edit settings, delete and modify security** permissions on all of the staging GPOs. For more informantion, see [Delegate Permissions for a Group or User on a Group Policy Object](https://technet.microsoft.com/library/cc754542).  
  
5.  Deny the Remote Access administrator permissions to link GPOs in all domains (or verify that the Remote Access administrator doesn"t have such permissions). For more information, see [Delegate Permissions to Link Group Policy Objects](https://technet.microsoft.com/library/cc755086).  
  
When Remote Access administrators configure Remote Access, they should always specify only the staging GPOs (not the production GPOs). This is true in the initial configuration of Remote Access and when performing additional configuration operations where additional GPOs are required; for example, when adding entry points in a multisite deployment or enabling client computers in additional domains.  
  
After the Remote Access administrator completes any changes to the Remote Access configuration, the domain administrator should review the settings in the staging GPOs, and use the following procedure to copy the settings to the production GPOs.  
  
> [!TIP]  
> Perform the following procedure after each change of the Remote Access configuration.  
  
##### To copy settings to the production GPOs  
  
1.  Verify that all of the staging GPOs in the Remote Access deployment have been replicated to all of the domain controllers in the domain. This is required to ensure the most up-to-date configuration is imported to the production GPOs. For more information, see Check Group Policy Infrastructure Status.  
  
2.  Export the settings by backing up all of the staging GPOs in the Remote Access deployment. For more information, see Back Up a Group Policy Object.  
  
3.  For each production GPO, change the security filters to match the security filters of the corresponding staging GPO. For more information, see Filter Using Security Groups.  
  
    > [!NOTE]  
    > This is required because **Import Settings** does not copy the security filter of the source GPO.  
  
4.  For each production GPO, import the settings from the backup of the corresponding staging GPO as follows:  
  
    1.  In the Group Policy Management Console (GPMC), expand the Group Policy Objects node in the forest and domain that contains the production Group Policy Object into which the settings will be imported.  
  
    2.  Right-click the GPO, and click **Import Settings**.  
  
    3.  In the **Import Settings Wizard**, on the **Welcome** page, click **Next**.  
  
    4.  On the **Backup GPO** page, click **Backup**.  
  
    5.  In the **Back up Group Policy Object** dialog box, in the **Location** box, enter the path for the location where you want to store the GPO backups, or click **Browse** to locate the folder.  
  
    6.  In the **Description** box, type a description for the production GPO, and then click **Back Up**.  
  
    7.  When the backup completes, click **OK**, and then on the **Backup GPO** page, click **Next**.  
  
    8.  On the **Backup location** page, in the **Backup folder** box, enter the path for the location in which the backup of the corresponding staging GPO was stored in Step 2, or click **Browse** to locate the folder, and then click **Next**.  
  
    9. On the **Source GPO** page, select the **Show only the latest version of each GPO** check box to hide older backups, and select the corresponding staging GPO. Click **View Settings** to review the Remote Access settings before applying them to the production GPO, and then click **Next**.  
  
    10. On the **Scanning Backup** page, click **Next**, and then click **Finish**.  
  
![Windows PowerShell](../../../media/Step-1-Configuring-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
-   To back up the staging client GPO "DirectAccess Client Settings - Staging" in domain "corp.contoso.com" to the backup folder "C:\Backups\":  
  
    ```  
    $backup = Backup-GPO "Name 'DirectAccess Client Settings - Staging' "Domain 'corp.contoso.com' "Path 'C:\Backups\'  
    ```  
  
-   To see the security filtering of the staging client GPO "DirectAccess Client Settings - Staging" in domain "corp.contoso.com":  
  
    ```  
    Get-GPPermission "Name 'DirectAccess Client Settings - Staging' "Domain 'corp.contoso.com' "All | ?{ $_.Permission "eq 'GpoApply'}  
    ```  
  
-   To add the security group "corp.contoso.com\DirectAccess clients" to the security filter of the production client GPO "DirectAccess Client Settings " Production" in domain "corp.contoso.com":  
  
    ```  
    Set-GPPermission "Name 'DirectAccess Client Settings - Production' "Domain 'corp.contoso.com' "PermissionLevel GpoApply "TargetName 'corp.contoso.com\DirectAccess clients' "TargetType Group  
    ```  
  
-   To import settings from the backup to the production client GPO "DirectAccess Client Settings " Production" in domain "corp.contoso.com":  
  
    ```  
    Import-GPO "BackupId $backup.Id "Path $backup.BackupDirectory "TargetName 'DirectAccess Client Settings - Production' "Domain 'corp.contoso.com'  
    ```  
  
## <a name="ConfigSGs"></a>1.9 Configure security groups  
The DirectAccess settings that are contained in the client computer Group Policy Object are applied only to computers that are members of the security groups that you specify when you configure Remote Access. In addition, if you are using security groups to manage your application servers, create a security group for these servers.  
  
### <a name="Sec_Group"></a>To create a security group for DirectAccess clients  
  
1.  On the **Start** screen, type**dsa.msc**, and then press ENTER. In the **Active Directory Users and Computers** console, in the left pane, expand the domain that will contain the security group, right-click **Users**, point to **New**, and then click **Group**.  
  
2.  In the **New Object - Group** dialog box, under **Group name**, enter the name for the security group.  
  
3.  Under **Group scope**, click **Global**, and under **Group type**, click **Security**, and then click **OK**.  
  
4.  Double-click the DirectAccess client computers security group, and in the properties dialog box, click the **Members** tab.  
  
5.  On the **Members** tab, click **Add**.  
  
6.  In the **Select Users, Contacts, Computers, or Service Accounts** dialog box, select the client computers that you want to enable for DirectAccess, and then click **OK**.  
  
![Windows PowerShell](../../../media/Step-1-Configuring-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)**Windows PowerShell equivalent commands**  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
New-ADGroup -GroupScope global -Name <DirectAccess_clients_group_name>  
Add-ADGroupMember -Identity DirectAccess_clients_group_name -Members <computer_name>  
```  
  
## <a name="ConfigNLS"></a>1.10 Configure the network location server  
The network location server should be a server with high availability, and it should have a valid SSL certificate that is trusted by the DirectAccess clients. There are two certificate options for the network location server certificate:  
  
-   **Private certificate**  
  
    This certificate is based on the certificate template that you created by following the instructions in [1.5.2 Configure certificate templates](#ConfigCertTemp).  
  
-   **Self-signed certificate**  
  
    > [!NOTE]  
    > Self-signed certificates cannot be used in multisite deployments.  
  
The following are required for either type of certificate, if they do not already exist:  
  
-   A website certificate that is used for the network location server. The certificate subject should be the URL of the network location server.  
  
-   A CRL distribution point that has high availability from the internal network.  
  
> [!NOTE]  
> If the network location server website is located on the DirectAccess server, a website is created automatically when you configure Remote Access. This site is bound to the server certificate that you provide.  
  
#### To install the network location server certificate from an internal CA  
  
1.  On the server that will host the network location server website: On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  In the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, select the check box for the certificate template that you created by following the instructions in 1.5.2 Configure certificate templates. If required, click **More information is required to enroll for this certificate**.  
  
8.  In the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common Name**.  
  
9. In **Value**, enter the FQDN of the network location server website, and then click **Add**.  
  
10. In the **Alternative name** area, in **Type**, select **DNS**.  
  
11. In **Value**, enter the FQDN of the network location server website, and then click **Add**.  
  
12. On the **General** tab, in **Friendly name**, you can enter a name that will help you identify the certificate.  
  
13. Click **OK**, click **Enroll**, and then click **Finish**.  
  
14. In the details pane of the Certificates snap-in, verify that new certificate was enrolled with Intended Purposes of Server Authentication.  
  
#### To configure the network location server  
  
1.  Set up a website on a high availability server. The website does not require any content, but when you test it, you might define a default page that provides a message when clients connect.  
  
    > [!NOTE]  
    > This step is not required if the network location server website is hosted on the DirectAccess server.  
  
2.  Bind an HTTPS server certificate to the website. The common name of the certificate should match the name of the network location server site. Ensure that DirectAccess clients trust the issuing CA.  
  
    > [!NOTE]  
    > This step is not required if the network location server website is hosted on the DirectAccess server.  
  
3.  Set up a CRL site that has high availability from the internal network.  
  
    CRL distribution points can be accessed through:  
  
    -   Web servers by using an HTTP-based URL, such as: https://crl.corp.contoso.com/crld/corp-APP1-CA.crl  
  
    -   File servers that are accessed through a universal naming convention (UNC) path, such as \\\crl.corp.contoso.com\crld\corp-APP1-CA.crl  
  
    If the internal CRL distribution point is reachable only over IPv6, you must configure a Windows Firewall with Advanced Security connection security rule to exempt IPsec protection from the IPv6 address of your intranet to the IPv6 addresses of your CRL distribution points.  
  
4.  Ensure that DirectAccess clients on the internal network can resolve the name of the network location server. Ensure that the name is not resolvable by DirectAccess clients on the Internet.  
  
## <a name="BKMK_Links"></a>Next step  
  
-   [Step 2: Configure Advanced DirectAccess Servers](da-adv-configure-s2-servers.md)  
  


