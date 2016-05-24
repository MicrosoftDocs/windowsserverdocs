---
title: Side-by-Side Migration Steps
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8b59934b-8c24-45ec-bf9a-dce5ae894baa
---
# Side-by-Side Migration Steps
This topic describes the steps required to perform a side\-by\-side migration from Forefront UAG SP1 DirectAccess to DirectAccess in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
|Task|Description|  
|--------|---------------|  
|[Step 1: Configure ISATAP](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step1a)|ISATAP is not recommended for use as the IPv6 to IPv4 transition technology in DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. If ISATAP is enabled in the Forefront UAG DirectAccess deployment, disable it before exporting the configuration settings.<br /><br />If manage out capability is also required for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can configure the Forefront UAG and the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] servers as ISATAP routers.|  
|[Step 2: Export the Forefront UAG DirectAccess configuration settings](#BKMK_Step1)|Export DirectAccess settings using the Forefront UAG export feature.|  
|[Step 3: Collect DirectAccess GPO settings](assetId:///edd2fd90-5a7e-4ed4-8897-3298af1d3119#BKMK_1.2)|Note the names of GPOs used by Forefront UAG DirectAccess.|  
|[Step 4: Install the Remote Access role](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step3)|Set up the computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as a Remote Access server.|  
|[Step 5: Configure server and infrastructure settings](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step4)|Configure infrastructure and server settings before configuring DirectAccess on the Remote Access server.|  
|[Step 6: Obtain an IP\-HTTPS certificate](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step5)|DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides two options for the IP\-HTTPS certificate. You can obtain a certificate from a CA, in a similar way to Forefront UAG DirectAccess, or you can configure [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess to automatically issue a self\-signed certificate for IP\-HTTPS authentication.|  
|[Step 7: Create a security group for DirectAccess clients](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step6)|Create an Active Directory security group that contains managed computers that will be configured as DirectAccess clients.|  
|[Step 8: Prepare GPOs](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step7)|Prepare GPOs in all relevant domains.|  
|[Step 9: Configure DirectAccess](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step8)|Configure DirectAccess settings on the Remote Access server.|  
  
## <a name="BKMK_Step1a"></a>Step 1: Configure ISATAP  
It is recommended that you do not use ISATAP in a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess deployment. You should disable ISATAP and use NAT64 instead.  
  
#### To disable ISATAP  
  
1.  Remove the ISATAP entry from DNS.  
  
2.  Wait for replication to complete on all domain controllers.  
  
3.  Wait an additional 24 hours for all computers to lose their ISATAP addresses.  
  
Note that before configuring Remote Access on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer, ensure that the computer does not have any ISATAP addresses.  
  
If manage out capability is required only for Forefront UAG run the following command before you configure the Remote Access role on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server:  
  
```  
Set-NetIsatapConfiguration -State Disabled  
```  
  
If manage out capability is also required for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], we recommend that you enable native IPv6 in your network, at least for those hosts that need to manage DirectAccess clients. If deploying native IPv6 is not an option and managing DirectAccess clients from within the internal network is required, perform the following procedure:  
  
This procedure configures both the Forefront UAG and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] servers as ISATAP routers, each handling only traffic to its own IP\-HTTPS and Teredo clients.  
  
> [!NOTE]  
> To allow DNS to propagate, this procedure includes a waiting period of 24 hours.  
  
> [!NOTE]  
> 6to4 clients will no longer be able to connect to Forefront UAG.  
  
#### To configure Forefront UAG and Windows Server 2012 as ISATAP routers  
  
1.  On the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] server, obtain, and then write down the Forefront UAG ISATAP prefix by running the following command:  
  
    ```  
    Get-NetRoute | ?{ $_.DestinationPrefix -match ":8000::/64" } | Select-Object -ExpandProperty DestinationPrefix  
    ```  
  
2.  Prior to configuring the Remote Access role on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server, run the following command to prevent the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server from becoming an ISATAP host \(and later enable it to become an ISATAP router\)  
  
    ```  
    Set-NetIsatapConfiguration -State Disabled  
    ```  
  
3.  Install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and add the Remote Access role. See [Step 4: Install the Remote Access role](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step3).  
  
4.  Configure DirectAccess according to the instructions in this guide.  
  
5.  Enable multisite on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server to enable symmetric routing and the removal, at a later stage, of the Forefront UAG server in an ISATAP scenario by following the instructions at [3.6. Enable the multisite deployment](../Topic/Step-3--Configure-the-Multisite-Deployment.md#BKMK_Enable).  
  
    > [!NOTE]  
    > It is necessary to enable multisite for the deployment to enable the changing of the ISATAP prefix, which is not possible in a single site deployment.  
  
6.  Change the ISATAP prefix of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server to be the same as the Forefront UAG ISATAP prefix by typing the following command  
  
    ```  
    Set-DAServer -InternalIPv6Prefix <UAG ISATAP Prefix>  
    ```  
  
    Where *UAG ISATAP Prefix* is the prefix obtained in step 1.  
  
    Although this cmdlet changes the DNS64 address on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server to use the Forefront UAG prefix, it doesn’t update the address on the firewall rule to allow DNS queries to reach DNS64.  
  
    To complete this step run the following commands on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server:  
  
    ```  
    $dns64Address = (Get-DAClientDnsConfiguration).NrptEntry | ?{ $_.DirectAccessDnsServers -match ':3333::1' } | Select-Object -First 1 -ExpandProperty DirectAccessDnsServers  
  
    $serverGpoName = (Get-RemoteAccess).ServerGpoName  
  
    $serverGpoDc = (Get-DAEntryPointDC).DomainControllerName  
  
    $gpoSession = Open-NetGPO -PolicyStore $serverGpoName -DomainController $serverGpoDc  
  
    Get-NetFirewallRule -GPOSession $gpoSession | ? {$_.Name -in @('0FDEEC95-1EA6-4042-8BA6-6EF5336DE91A', '24FD98AA-178E-4B01-9220-D0DADA9C8503')} | Set-NetFirewallRule -LocalAddress $dns64Address  
  
    Save-NetGPO -GPOSession $gpoSession  
  
    gpupdate /force  
    ```  
  
7.  On the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server run the following commands to obtain, and then write down, the IPv6 prefix of the Forefront UAG server’s Teredo clients:  
  
    ```  
    $UAGIPv4Address="<UAG's first external IPv4 address>"  
  
    [Byte[]] $TeredoServerAddressBytes = `  
        [System.Net.IPAddress]::Parse("2001::").GetAddressBytes()[0..3] + `  
        [System.Net.IPAddress]::Parse($UAGIPv4Address).GetAddressBytes() + `  
        [System.Net.IPAddress]::Parse("::").GetAddressBytes()[0..7]  
  
    Write-Host "The UAG's Teredo prefix is $([System.Net.IPAddress]$TeredoServerAddressBytes)/64"  
    ```  
  
8.  On the Forefront UAG server, run the following command to obtain the Teredo interface's index:  
  
    ```  
    Netsh int ipv6 show route  
    ```  
  
    Find the interface with a prefix of 2001::\/32 and write down its interface index from the Idx column.  
  
9. On the Forefront UAG server run the following command to enable Forefront UAG to publish its Teredo client prefix to the ISATAP subnet:  
  
    ```  
    Netsh int ipv6 add route prefix=<teredo prefix>  interface=<teredo interface index> publish=yes  
    ```  
  
    Where *teredo prefix* was obtained in step 7 and *teredo interface index* was obtained in step 8.  
  
10. Since 6to4 clients will no longer be able to successfully connect to via Forefront UAG to the backend servers, you should disable 6to4 on all clients using a GPO:  
  
    Create a GPO to set the *Computer Configuration\/Policies\/Administrative Templates\/Network\/TCP\/IP Settings\/IPv6 Transition Technologies\/6to4 State* setting to Disabled State and apply it to all Forefront UAG client machines. Alternatively you can accomplish this by blocking IP Protocol 41 inbound through your edge firewalls.  
  
    In addition, if the IPv4 address of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server’s internal network adapter is public, you must disable forwarding on the 6to4 interface of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server so that ISATAP forwarding will work properly.  
  
    > [!NOTE]  
    > Running the following command causes an error to be constantly displayed in the Operations Status \(health monitor\) for 6to4. You can ignore this error.  
  
    ```  
    Set-NetIPInterface -InterfaceAlias '6TO4 Adapter' -Forwarding Disabled  
    ```  
  
11. Create an ISATAP DNS record for the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server to publish it as an ISATAP router alongside Forefront UAG.  
  
    On the DNS server, run dnscmd \/recordadd command. For example:  
  
    ```  
    dnscmd dnssvr1.contoso.com /recordadd contoso.com isatap A 10.0.0.5   
    ```  
  
    Where *dnssvr1.contoso.com* is the name of your DNS server, *contoso.com* is the DNS zone \(domain name\) and *10.0.0.5* is the internal IPv4 address of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server.  
  
    > [!NOTE]  
    > You must perform this command for each domain in which ISATAP records already exist.  
  
12. At this stage client connectivity through the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server is working over NAT64, but manage out still does not work.  
  
13. Wait 24 hours for the DNS to propagate before adding any client machines to the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server.  
  
14. On the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server enable AAAA name resolution by running the following command:  
  
    ```  
    Set-NetDnsTransitionConfiguration -OnlySendAQuery $false  
    ```  
  
15. At this stage manage out functionality also works.  
  
16. When all clients are migrated from Forefront UAG to the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server, you can remove the Forefront UAG ISATAP DNS records from the DNS server.  
  
## <a name="BKMK_Step1"></a>Step 2: Export the Forefront UAG DirectAccess settings  
Export the settings using the following procedure.  
  
#### To export settings  
  
1.  Click **Start**, click **All Programs**, click **Microsoft Forefront UAG**, and then click **Forefront UAG Management** to open the console.  
  
2.  Click **DirectAccess** in the left\-hand node of the console.  
  
3.  Click **Export Policy** in the details pane. If there have been changes in corporate infrastructure servers since the last time Forefront UAG was configured, you might be prompted to refresh the management server list. To ensure settings are up to date, do this before exporting your settings.  
  
4.  Click **Print Preview**.  
  
5.  In the **Select Printer** list, select **Microsoft XPS Document Printer**, and click **Print**.  
  
6.  Specify a path and file name to save the configuration, and click **Save**.  
  
7.  Click **Cancel** to close the review page.  
  
8.  Copy the exported file to a location from which it can easily be retrieved, preferably on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] server that will be configured for DirectAccess.  
  
## <a name="BKMK_Step2"></a>Step 3: Collect Forefront UAG DirectAccess GPO settings  
Collect GPO settings using the following procedure.  
  
#### To collect GPO settings  
  
1.  In the Forefront UAG Management console, click **Edit** in **Step 1 Clients and GPOs**.  
  
2.  In the Policy Management page, note the names of the GPOs. Then click **Cancel**.  
  
    Note that during a side\-by\-side migration, the GPOs used on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] server must have different names from those used on the Forefront UAG DirectAccess server.  
  
## <a name="BKMK_Step3"></a>Step 4: Install the Remote Access role  
Install the role using the following procedure.  
  
#### To install the role  
  
1.  In the dashboard of the Server Manager console click **Add roles**.  
  
2.  Click **Next** until you reach the **Select Server Roles** dialog.  
  
3.  On the **Select Server Roles** dialog, select **Remote Access**. Click **Add Required Features**, and then click **Next**.  
  
4.  On the **Select features** dialog, expand **Remote Server Administration Tools**. Expand **Role Administration Tools**, and then select **Remote Access Management Tools**. Click **Next** until you reach the **Confirm installation selections** dialog.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
7.  In addition, turn on the XPS Viewer feature.  
  
## <a name="BKMK_Step4"></a>Step 5: Configure server and infrastructure settings  
Configure server and infrastructure using the following procedure.  
  
#### To configure server and infrastructure settings  
  
1.  Determine the public host name of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Remote Access server. This should be different from the host name of the Forefront UAG server. To determine the public name of the Forefront UAG server, view the value The certificate that the DirectAccess server uses for HTTPS is in the **DirectAccess Server Settings** section of the exported Forefront UAG configuration settings file.  
  
2.  Create a public DNS record for this public host FQDN. The record should resolve to the first of the two IPv4 public consecutive addresses on the external adapter of the Remote Access server.  
  
## <a name="BKMK_Step5"></a>Step 6: Obtain an IP\-HTTPS certificate  
If you want to use a certificate issued by a CA for IP\-HTTPS authentication, obtain a web server certificate with a subject name that matches the FQDN of the Windows 8 server. Optionally, using DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] you can select to create a self\-signed certificate for IP\-HTTPS during DirectAccess configuration.  
  
## <a name="BKMK_Step6"></a>Step 7: Create a security group for DirectAccess clients  
Create a new Active Directory security group that contains client computers running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] or Windows 7 that will be enabled as DirectAccess clients. Use separate security groups for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and Windows 7 computers.  
  
## <a name="BKMK_Step7"></a>Step 8: Prepare GPOs  
Prepare GPOs in all relevant domains for the Remote Access server, DirectAccess clients, and application servers \(if needed\), and link them to the root of the respective domain. DirectAccess administrators should have the \(Edit settings, delete, modify security\) permissions to modify the GPOs.  
  
## <a name="BKMK_Step8"></a>Step 9: Configure DirectAccess  
On the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] configure DirectAccess using the following procedure.  
  
#### To configure DirectAccess  
  
1.  Before beginning to configure Remote Access, ensure that ISATAP is not enabled on the Windows 8 server. If it is, disable it as follows:  
  
    1.  Remove the ISATAP entry from DNS  
  
    2.  Wait for replication to complete on all domain controllers  
  
    3.  Wait and additional 24 hours for all computers to lose their ISATAP addresses  
  
2.  To begin DirectAccess deployment, in the Remote Access Management console, select **Run the Remote Access Setup Wizard**.  
  
3.  In the first page of the wizard, select **Deploy DirectAccess only**.  
  
4.  Click Step 1: Remote Clients, click **Edit**. Note that if you are logged on as a user that is not a member of the domain administrators security group you will get a warning message stating that you do not have permissions to create the WMI filter. This can be ignored. Click **Next**.  
  
5.  On the Deployment Scenario page, select **Deploy full DirectAccess for client access and remote management**. Then click **Next**. This setting allows DirectAccess client computers to access the internal network, and allows DirectAccess administrators to remotely manage DirectAccess client computers located on the Internet.  
  
6.  In the Select Groups page, click **Add**. Specify the security groups containing DirectAccess clients. The groups must not currently be used in the Forefront UAG deployment. Click **OK**. Then click **Next**.  
  
7.  If Forefront UAG is configured to use force tunneling for DirectAccess clients, select **Use force tunneling**.  
  
    > [!NOTE]  
    > If you are using these instructions to perform an offline migration, specify the security groups that are defined for DirectAccess clients in Forefront UAG.  
  
8.  In the Network Connectivity Assistant page, configure settings for the Network Connectivity Assistant \(NCA\). NCA replaces the DirectAccess Connectivity Assistant \(DCA\) used in Forefront UAG. Note that NCA is supported only for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] computers and cannot be used by client computers running Windows 7. The DCA settings used in Forefront UAG can be verified in the DirectAccess Client Settings section of the exported Forefront UAG configuration settings. Note that NCA supports the use of HTTP and PING probes only. File and HTTPS probes used in DCA are not supported. In addition, administrator scripts and help portal settings are not supported.  
  
9. To add a probe, double\-click in the resources list. Specify the first HTTP probe that appears in the Forefront UAG configuration. Then click **OK**.  
  
10. Repeat the last step to add all of the HTTP probes.  
  
11. If **Allow local name resolution** is enabled in the exported Forefront UAG configuration settings, select **Allow DirectAccess clients to use local name resolution**. If the value is disabled, the checkbox should not be enabled.  
  
12. Copy the value specified in **Send log file to email** in the exported Forefront UAG configuration settings file to the **Helpdesk email address** field.  
  
13. Click **Finish** to complete the wizard.  
  
14. In Step 2 Remote Access server, click **Edit**.  
  
15. In the Network Topology page, select **Edge**.  
  
16. In **Type the public name or IPv4 address**, specify the FQDN that clients will use to access the Windows 8 Remote Access server. Ensure that the FQDN is not the same as the FQDN specified for the Forefront UAG IP\-HTTPS certificate. Note that the FQDN should be resolvable by a public DNS server, to the public IPv4 address of the Remote Access server. A server certificate is required for the FQDN in order to authenticate the IP\-HTTPS connection.  
  
    > [!NOTE]  
    > If you are using these instructions to configure an offline migration, use the public host name specified for the IP\-HTTPS certificate configured in the Forefront UAG deployment.  
  
17. In the Network Adapters page ensure that IP addresses are correct. Verify that the addresses are different than those that appear in the **DirectAccess Server Settings** section of the exported Forefront UAG configuration settings file.  
  
    > [!NOTE]  
    > If you are using these instructions to configure an offline migration, verify that the addresses are the same as those specified in the **DirectAccess Server Settings** section of the exported Forefront UAG configuration settings file.  
  
18. Click **Browse** to select an IP\-HTTPS certificate. You can either purchase a certificate from a commercial CA, or configure [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess to issue a self\-signed certificate.  
  
    > [!NOTE]  
    > If you are using these instructions to configure an offline migration, you can purchase a certificate from a commercial CA, configure [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess to issue a self\-signed certificate, or use the exported certificate from the Forefront UAG server.  
  
19. On the Prefix Configuration page, verify settings are correct.  
  
20. On the Authentication page, if standard client authentication is used, select **Active Directory credentials**  
  
21. If Forefront UAG is configured to use smart card authentication, select **Two\-factor authentication**.  
  
22. If Forefront UAG is configured to use one\-time password \(OTP\) authentication, note the following:  
  
    1.  Little OTP information can be shared between the Forefront UAG and the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] deployments. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess can only perform OTP authentication over RADIUS. If the Forefront UAG deployment uses RSA SecurID without RADIUS, either the RSA SecurID server must be configured to support RADIUS, or a different server must be used for OTP authentication.  
  
    2.  To identify OTP servers used by the Forefront UAG, click Admin. Then select Authentication and Authorization Servers.  
  
    To configure OTP in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] deployment using the same settings, select **Two\-factor authentication**. Then select **Use OTP**.  
  
23. Select **Use computer certificates**.  
  
24. Click **Browse** button to select a certificate. Ensure that you use the root certificate that is used in Forefront UAG. To verify Forefront UAG settings verify the value in **root certificate to which remote clients chain** in the **DirectAccess Server Settings** section of the exported Forefront UAG configuration settings file.  
  
25. Select **Enable Windows 7 Clients to connect via DirectAccess**.  
  
26. To use NAP enforcement for the IPsec connection select **Enforce corporate compliance for DirectAccess clients with Network Access Protection \(NAP\)**. Note the following:  
  
    1.  When creating the health policy in NPS, set **Type of network access server** in the **Network Connection Method** section of the **Overview** tab to **Health Registration Authority**.  
  
    2.  NAP GPOs must be configured for DirectAccess clients running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. Ensure that these GPOs are applied only to the DirectAccess clients using the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] server.  
  
27. If you are not using OTP authentication, click **Finish**. If you have enabled OTP, do the following:  
  
    1.  In OTP RADIUS Servers page, specify the name of the OTP RADIUS server, the shared secret, and the port number.  
  
    2.  On the OTP CA Servers page, select the OTP CA servers used to issue certificates for OTP authentication. Note that CA servers are detected automatically.  
  
    3.  On the OTP Certificate Template page, select a certificate template.  
  
    4.  On the OTP Exemptions page, optionally select a security group containing client computers exempt from two\-factor authentication.  
  
28. In Step 3 Infrastructure Servers, click **Edit**.  
  
29. On the Network Location Server page, select **The Network Location Server is deployed on a remote web server**. To verify settings in Forefront UAG, check the value **The HTTPS URL that provides clients with location information** in the **Infrastructure Servers \(DNS, DC, Management\)** section of the exported Forefront UAG configuration settings file. Click **Validate** to ensure it works, and then click **Next**.  
  
30. On the DNS page, specify the settings that are in the section **Infrastructure Servers \(DNS, DC, Management\)** of the exported Forefront UAG configuration settings file. Copy any entries that are specified for Forefront UAG that do not appear in the table. In the IP address of DNS server column, fill in one of the following, depending on the type of entry: for exclusion entries the column should remain blank. For DNS64 entries, copy the address that appears in the first row \(<Any Suffix>\). For internal DNS servers, enter the IPv4 address of the DNS server. In addition, select the local name resolution option to match that specified in the value Local name resolution option in Forefront UAG.  
  
31. On the Management page, specify the management server settings to match the settings in the **Infrastructure Servers \(DNS, DC, Management\)** section in the exported Forefront UAG configuration settings file.  Copy any entry not in the Domain Controllers section, that does not appear in the table. If NAP is enabled, ensure that the HRA server is added to the management servers list. HRA servers are not discovered automatically, so they must be added manually each time a change is made in HRA server deployment settings.  
  
32. Then click **Finish**.  
  
33. In Step 4: Application Servers, click **Edit**.  
  
34. Click **Finish** to keep the default settings.  
  
35. In the details pane of the management console, click **Finish**.  
  
36. On the Review page, in the **GPO Information** section, click **Change**.  
  
37. In **DirectAccess client GPO** click **Browse**.  
  
38. Select the GPO prepared for Windows 8 DirectAccess clients and click Select. Then click OK.  
  
39. Repeat the previous two steps for **DirectAccess server GPO**.  
  
40. In the details pane, click **Apply** to apply the configuration.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Side-by-Side Migration of Forefront UAG DirectAccess](../Topic/Side-by-Side-Migration-of-Forefront-UAG-DirectAccess.md)  
  
