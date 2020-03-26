---
title: Step 1 Configure the Basic DirectAccess Infrastructure
description: This topic is part of the guide Deploy a Single DirectAccess Server Using the Getting Started Wizard for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ba4de2a4-f237-4b14-a8a7-0b06bfcd89ad
ms.author: lizross
author: eross-msft
---
# Step 1 Configure the Basic DirectAccess Infrastructure

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to configure the infrastructure required for a basic DirectAccess deployment using a single DirectAccess server in a mixed IPv4 and IPv6 environment. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Plan a Basic DirectAccess Deployment](../../../remote-access/directaccess/single-server-wizard/Plan-a-Basic-DirectAccess-Deployment.md).  
  
|Task|Description|  
|----|--------|  
|Configure server network settings|Configure the server network settings on the DirectAccess server.|  
|Configure routing in the corporate network|Configure routing in the corporate network to make sure traffic is appropriately routed.|  
|Configure firewalls|Configure additional firewalls, if required.|  
|Configure the DNS server|Configure DNS settings for the DirectAccess server.|  
|Configure Active Directory|Join client computers and the DirectAccess server to the Active Directory domain.|  
|Configure GPOs|Configure GPOs for the deployment, if required.|  
|Configure security groups|Configure security groups that will contain DirectAccess client computers, and any other security groups required in the deployment.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="ConfigNetworkSettings"></a>Configure server network settings  
The following network interface settings are required for a single server deployment in an environment with IPv4 and IPv6. All IP addresses are configured by using **Change adapter settings** in the **Windows Networking and Sharing Center**.  
  
-   Edge topology  
  
    -   One Internet-facing public static IPv4 or IPv6 addresses.  
  
        > [!NOTE]  
        > Two consecutive public IPv4 addresses are required for Teredo. If you are not using Teredo, you can configure a single public static IPv4 address.  
  
    -   A single internal static IPv4 or IPv6 address.  
  
-   Behind NAT device (two network adapters)  
  
    -   A single internal network-facing static IPv4 or IPv6 address.  
  
    -   A single perimeter network-facing static IPv4 or IPv6 address.  
  
-   Behind NAT device (one network adapter)  
  
    -   A single static IPv4 or IPv6 address.  
  
> [!NOTE]  
> If the DirectAccess server has two or more network adapters (one classified in the domain profile and the other in a public/private profile), but you want to use a single NIC topology, then the recommendations are:  
>   
> 1.  Ensure that the second NIC, and any additional NICs, are also classified in the domain profile.  
> 2.  If the second NIC cannot be configured for the domain profile for any reason, then the DirectAccess IPsec policy must be manually scoped to all profiles using the following Windows PowerShell commands:  
>   
>     ```  
>     $gposession = Open-NetGPO -PolicyStore <Name of the server GPO>  
>     Set-NetIPsecRule -DisplayName <Name of the IPsec policy> -GPOSession $gposession -Profile Any  
>     Save-NetGPO -GPOSession $gposession  
>     ```  
>   
>     The names of the IPsec policies are DirectAccess-DaServerToInfra and DirectAccess-DaServerToCorp.  
  
## <a name="ConfigRouting"></a>Configure routing in the corporate network  
Configure routing in the corporate network as follows:  
  
-   When native IPv6 is deployed in the organization, add a route so that the routers on the internal network route IPv6 traffic back through the Remote Access server.  
  
-   Manually configure organization IPv4 and IPv6 routes on the Remote Access servers. Add a published route so that all traffic with an organization (/48) IPv6 prefix is forwarded to the internal network. In addition, for IPv4 traffic, add explicit routes so that IPv4 traffic is forwarded to the internal network.  
  
## <a name="ConfigFirewalls"></a>Configure firewalls  
When using additional firewalls in your deployment, apply the following Internet-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv4 Internet:  
  
-   6to4 traffic -IP Protocol 41 inbound and outbound.  
  
-   IP-HTTPS -Transmission Control Protocol (TCP) destination port 443, and TCP source port 443 outbound. When the Remote Access server has a single network adapter, and the network location server is on the Remote Access server, then TCP port 62000 is also required.  
  
    > [!NOTE]  
    > This exemption has to be configured on the remote access server. All the other exemptions have to be configured on the edge firewall.  
  
> [!NOTE]  
> For Teredo and 6to4 traffic, these exceptions should be applied for both of the Internet-facing consecutive public IPv4 addresses on the Remote Access server. For IP-HTTPS the exceptions need only be applied for the address to which the external name of the server resolves.  
  
When using additional firewalls, apply the following Internet-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
When using additional firewalls, apply the following internal network firewall exceptions for Remote Access traffic:  
  
-   ISATAP -Protocol 41 inbound and outbound  
  
-   TCP/UDP for all IPv4/IPv6 traffic  
  
## <a name="ConfigDNS"></a>Configure the DNS server  
You must manually configure a DNS entry for the network location server website for the internal network in your deployment.  
  
### <a name="NLS_DNS"></a>To create the network location server and NCSI probe DNS records  
  
1.  On the internal network DNS server, run **dnsmgmt.msc** and then press ENTER.  
  
2.  In the left pane of the **DNS Manager** console, expand the forward lookup zone for your domain. Right click the domain and click **New Host (A or AAAA)**.  
  
3.  On the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the DNS name for the network location server website (this is the name the DirectAccess clients use to connect to the network location server). In the **IP address** box, enter the IPv4 address of the network location server, and then click **Add Host**. On the **DNS** dialog box, click **OK**.  
  
4.  On the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the DNS name for the web probe (the name for the default web probe is directaccess-webprobehost). In the **IP address** box, enter the IPv4 address of the web probe, and then click **Add Host**. Repeat this process for directaccess-corpconnectivityhost and any manually created connectivity verifiers. On the **DNS** dialog box, click **OK**.  
  
5.  Click **Done**.  
  
![Windows PowerShell](../../../media/Step-1-Configure-the-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Add-DnsServerResourceRecordA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv4Address <network_location_server_IPv4_address>  
Add-DnsServerResourceRecordAAAA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv6Address <network_location_server_IPv6_address>  
```  
  
You must also configure DNS entries for the following:  
  
-   **The IP-HTTPS server** -DirectAccess clients must be able to resolve the DNS name of the Remote Access server from the Internet.  
  
-   **CRL revocation checking** -DirectAccess uses certificate revocation checking for the IP-HTTPS connection between DirectAccess clients and the Remote Access server, and for the HTTPS-based connection between the DirectAccess client and the network location server. In both cases, DirectAccess clients must be able to resolve and access the CRL distribution point location.  
  
## <a name="ConfigAD"></a>Configure Active Directory  
The Remote Access server and all DirectAccess client computers must be joined to an Active Directory domain. DirectAccess client computers must be a member of one of the following domain types:  
  
-   Domains that belong to the same forest as the Remote Access server.  
  
-   Domains that belong to forests with a two-way trust with the Remote Access server forest.  
  
-   Domains that have a two-way domain trust to the Remote Access server domain.  
  
#### To join the Remote Access server to a domain  
  
1.  In Server Manager, click **Local Server**. In the details pane, click the link next to **Computer name**.  
  
2.  On the **System Properties** dialog box, click the **Computer Name** tab. On the **Computer Name** tab, click **Change**.  
  
3.  In **Computer Name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server; for example, corp.contoso.com, and then click **OK**.  
  
4.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
#### To join client computers to the domain  
  
1.  Run **explorer.exe**.  
  
2.  Right-click the Computer icon, and then click **Properties**.  
  
3.  On the **System** page, click **Advanced system settings**.  
  
4.  On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
5.  In **Computer name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server; for example, corp.contoso.com, and then click **OK**.  
  
6.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
7.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. On the **System Properties** dialog box, click Close. Click **Restart Now** when prompted.  
  
![Windows PowerShell](../../../media/Step-1-Configure-the-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
Note that you must supply domain credentials after entering the Add-Computer command below.  
  
```  
Add-Computer -DomainName <domain_name>  
Restart-Computer  
```  
  
## <a name="ConfigGPOs"></a>Configure GPOs  
To deploy Remote Access, you require a minimum of two Group policy objects: one Group policy object contains settings for the Remote Access server and one contains settings for DirectAccess client computers. When you configure Remote Access, the wizard automatically creates the required Group policy object. However, if your organization enforces a naming convention, or you do not have the required permissions to create or edit Group policy objects, they must be created prior to configuring Remote Access.  
  
To create a Group policy object, see [Create and Edit a Group Policy Object](https://technet.microsoft.com/library/cc754740.aspx).  
  
> [!IMPORTANT]  
> The administrator can manually link the DirectAccess Group policy object to an Organizational Unit using these steps:  
>   
> 1.  Before configuring DirectAccess, link the created GPOs to the respective Organizational Units.  
> 2.  Configure DirectAccess, specifying a security group for the client computers.  
> 3.  The administrator may or may not have permissions to link the Group Policy Objects to the domain. In either case, the Group Policy Objects will be configured automatically. If the GPOs are already linked to an OU, the links will not be removed. Nor will the GPOs be linked to the domain. For server GPO, the OU must contain the server computer object, else the GPO will be linked to the root of the domain.  
> 4.  If the linking to OU has not been done before running the DirectAccess wizard, after the configuration is complete, the administrator can link the DirectAccess Group Policy Objects to the required Organizational Units. The link to the domain can be removed. Steps for linking a Group policy object to an Organization Unit can be found [here](https://technet.microsoft.com/library/cc732979.aspx)  
  
> [!NOTE]  
> If a Group policy object was created manually, it is possible during the DirectAccess configuration that the Group policy object will not be available. The Group policy object may not have been replicated to the closest Domain Controller to the management computer. In this event, the administrator can wait for replication to complete, or force the replication.

> [!Warning]
> Using any means other than the DirectAccess Setup Wizard to configure DirectAccess, such as modifying DirectAccess Group Policy Objects directly or manually modifying the default policy settings on the server or client, is not supported.
  
## <a name="ConfigSGs"></a>Configure security groups  
The DirectAccess settings contained in the client computer Group policy objects are applied only to computers that are members of the security groups that you specify when configuring Remote Access.  
  
### <a name="Sec_Group"></a>To create a security group for DirectAccess clients  
  
1.  Run **dsa.msc**. In the **Active Directory Users and Computers** console, in the left pane, expand the domain that will contain the security group, right-click **Users**, point to **New**, and then click **Group**.  
  
2.  On the **New Object - Group** dialog box, under **Group name**, enter the name for the security group.  
  
3.  Under **Group scope**, click **Global**, under **Group type**, click **Security**, and then click **OK**.  
  
4.  Double-click the DirectAccess client computers security group, and on the properties dialog box, click the **Members** tab.  
  
5.  On the **Members** tab, click **Add**.  
  
6.  On the **Select Users, Contacts, Computers, or Service Accounts** dialog box, select the client computers that you want to enable for DirectAccess, and then click **OK**.  
  
![Windows PowerShell](../../../media/Step-1-Configure-the-DirectAccess-Infrastructure/PowerShellLogoSmall.gif)**Windows PowerShell equivalent commands**  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
New-ADGroup -GroupScope global -Name <DirectAccess_clients_group_name>  
Add-ADGroupMember -Identity DirectAccess_clients_group_name -Members <computer_name>  
```  
  
## <a name="BKMK_Links"></a>Next step  
  
-   [Step 2: Configure the Basic DirectAccess Server](da-basic-configure-s2-server.md)  
  


