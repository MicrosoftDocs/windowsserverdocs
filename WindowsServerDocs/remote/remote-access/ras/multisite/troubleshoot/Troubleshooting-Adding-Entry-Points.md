---
title: Troubleshooting Adding Entry Points
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dcc1037f-1a65-4497-99e6-0df9aef748a8
ms.author: lizross
author: eross-msft
---
# Troubleshooting Adding Entry Points

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic contains troubleshooting information for issues related to the `Add-DAEntryPoint` command. To confirm that the error you received is related to adding an entry point, check in the Windows Event log for the event ID 10067.  
  
## Missing RemoteAccessServer parameter  
**Error received**. You must supply a value for the parameter RemoteAccessServer.  
  
**Cause**  
  
When adding a new entry point to a multisite deployment, you must specify the parameter *RemoteAccessServer*, which is the name of the server which you want to add as the new entry point.  
  
**Solution**  
  
Run the command and make sure to specify the *RemoteAccessServer* parameter with the name of the server to be added as an entry point.  
  
## Remote Access is not configured  
**Error received**. Remote Access is not configured on <server_name>. Specify the name of a server that belongs to a multisite deployment.  
  
**Cause**  
  
Remote Access is not configured on the computer specified by the *ComputerName* parameter, or on the computer on which you run the command.  
  
When adding a new entry point to a multisite deployment, you must specify two parameters: *ComputerName* and *RemoteAccessServer*. The *ComputerName* is the name of a server which is already part of the multisite deployment, the *RemoteAccessServer* is the name of the server which you want to add as the new entry point. If you run from a computer that is part of the multisite deployment, the ComputerName parameter is not required.  
  
**Solution**  
  
Run the command and make sure to specify the *ComputerName* parameter with the name of the server that is already configured as part of the multisite deployment, or run the command from a computer that is part of the multisite deployment.  
  
## Multisite not enabled  
**Error received**. You must enable a multisite deployment before performing this operation. Use the `Enable-DAMultiSite` cmdlet to do this.  
  
**Cause**  
  
Multisite is not enabled on the server specified by the *ComputerName* parameter. To add a new entry point to a Remote Access deployment, you must first enable multisite.  
  
**Solution**  
  
Enable multisite using the `Enable-DaMultiSite` cmdlet. For more information, see [Deploy multisite Remote Access](https://technet.microsoft.com/library/hh831664.aspx).  
  
## IPv6 prefix issues  
  
-   **Issue 1**  
  
    **Error received**. IPv6 is deployed in the internal network, but you have not specified a client IPv6 prefix.  
  
    **Cause**  
  
    IPv6 is deployed on the corporate network, and an IP-HTTPS prefix is required. However, a prefix was not specified in the *ClientIPv6Prefix* parameter for the new entry point.  
  
    **Solution**  
  
    1.  Assign a unique IP-HTTPS prefix to the new entry point and ensure that packets targeted to an IP address under this prefix will be routed to the server you are adding.  
  
    2.  Run the `Add-DAEntryPoint` cmdlet and specify the IP-HTTPS prefix in the *ClientIPv6Prefix* parameter.  
  
-   **Issue 2**  
  
    **Error received**. The client IPv6 prefix is already in use by another entry point. Specify an alternate value.  
  
    **Cause**  
  
    The IP-HTTPS prefix specified in the *ClientIPv6Prefix* parameter is already used by a different entry point  
  
    **Solution**  
  
    1.  Assign a unique IP-HTTPS prefix to the new entry point and ensure that packets targeted to an IP address under this prefix will be routed to the server you are adding.  
  
    2.  Run the `Add-DAEntryPoint` cmdlet and specify the IP-HTTPS prefix in the *ClientIPv6Prefix* parameter.  
  
## ConnectTo address  
**Error received**. The address (<connect_to_address>) to which DirectAccess clients connect on the RemoteAccess server is the same as the network location server address. Specify an alternate value.  
  
**Cause**  
  
The ConnectTo address and the network location server address are the same.  
  
**Solution**  
  
The ConnectTo address should be resolvable over the Internet to allow client machines to connect over IP-HTTPS. The network location server address should be resolvable over the corporate network but should not be resolvable over the Internet. Make sure that the network location server and the ConnectTo addresses are not the same. Select different addresses and try again.  
  
## DirectAccess or VPN already installed  
**Error received**. A VPN installation was detected on the server <server_name>. Specify an alternate server that does not have Remote Access installed, or remove the VPN configuration from the server.  
  
Or  
  
Remote Access is already installed on server <server_name>. Specify an alternate server not running DirectAccess, or remove the existing DirectAccess configuration from the server.  
  
**Cause**  
  
DirectAccess or VPN is already configured on the new entry point. You cannot add a configured entry point to a multisite deployment.  
  
**Solution**  
  
To add a server to a multisite deployment, you must install the Remote Access role on the server but DirectAccess and VPN should not be configured.  
  
Run the command and make sure that the server you specify in the *RemoteAccessServer* parameter does not have DirectAccess or VPN configured.  
  
## IPsec root certificate  
**Error received**. The configured IPsec root certificate cannot be located on server <server_name>.  
  
**Cause**  
  
The certificate of the root or intermediate certification authority (CA) that issues computer certificates could not be found on the server you are trying to add to the deployment.  
  
**Solution**  
  
In the Remote Access Management console, in **Step 2 Remote Access Server**, click **Edit**, and on the **Authentication** page, under **Use computer certificates**, make sure that the certificate selected is valid. If the certificate is valid, make sure that it is located under the trusted root CA on the server you want to add and try again.  
  
> [!NOTE]  
> The certificate must be the same certificate with the same Thumbprint.  
  
If the certificate is not valid, select a valid certificate which is configured as the trusted root CA on all the Remote Access servers.  
  
## Mixing IPv6 and IPv4 entry points  
When DirectAccess is installed for the first time, the internal network adapter is inspected to determine if the network contains IPv4 addresses only (IPv4-only network), IPv6 and IPv4 addresses, or IPv6 addresses only (IPv6-only network). The information is used to determine the deployment type (IPv4 only, IPv6+IPv4, or IPv6 only).  
  
-   **Issue 1**  
  
    **Warning received**. The Remote Access server being added is configured with both IPv4 and IPv6 addresses. This is an IPv4 only deployment, and Remote Access will ignore the IPv6 addresses.  
  
    **Cause**  
  
    When this deployment was first installed, the internal network was detected as an IPv4 only network. In a multisite deployment, different entry points are assumed to be located in different subnets with different characteristics. Therefore, although the deployment is configured as an IPv4 only deployment, it can contain an entry point located in an IPv6+IPv4 subnet. However, although the entry point will be added to the deployment, DirectAccess will ignore the IPv6 addresses configured on the new entry point's internal interface.  
  
    **Solution**  
  
    If the entire internal network is configured with IPv6 and IPv4 addresses, consider moving to an IPv6+IPv4 deployment to benefit from IPv6 technologies. See "Transitioning from a pure IPv4 to an IPv6+IPv4 corporate network" in [Step 3: Plan the multisite deployment](assetId:///19d49dbf-1786-47bb-ab97-f0458c53d91d).  
  
-   **Issue 2**  
  
    **Error received**. The internal network adapters of the Remote Accces servers in this multisite deployment are configured with IPv4 addresses. The entry point you are adding must also be configured with an IPv4 address on the internal network adapter.  
  
    **Cause**  
  
    When this deployment was first installed, the internal network was detected as an IPv4 only network. Remote Access detected that the entry point that you are trying to add is configured with only IPv6 addresses on its internal network. This is not allowed in an IPv4 only deployment.  
  
    **Solution**  
  
    If the entire network is already configured with IPv6 addresses, you should move to an IPv6+IPv4 or IPv6-only deployment. See "Plan the transition to IPv6 when multisite Remote Access is deployed".  
  
-   **Issue 3**  
  
    **Error received**. This entry point is located in an IPv4 network, but previous entry points are located in an IPv6 network. Connect this entry point to the IPv6 network before adding it to the same multisite deployment.  
  
    **Cause**  
  
    When this deployment was first installed, it was detected that the internal network is IPv6+IPv4 or IPv6-only. It was detected that only IPv4 addresses are configured on the internal network on the new entry point you are trying to add. This is not allowed in IPv6+IPv4, or IPv6-only deployments.  
  
    **Solution**  
  
    Configure the new entry point with IPv6 addresses and then add the entry point to the multisite deployment.  
  
-   **Issue 4**  
  
    **Warning received**. The internal network adapter on the Remote Access server is not configured with an IPv4 address. DNS64 and NAT64 will not be configured on this server. DirectAccess clients can access IPv6 internal servers only.  
  
    **Cause**  
  
    When this deployment was first installed, it was detected that the internal network is IPv6+IPv4. In this deployment mode, DNS64 and NAT64 are enabled to allow client computers to access machines on the internal network that are configured with only IPv4 addresses.  
  
    When adding the new entry point, Remote Access detected that the internal interface on the new computer has only IPv6 addresses. To configure DNS64 and NAT64, an IPv4 address is required in order to route packets from the Remote Access server to the IPv4 only computer. Since no such IP exists on the new computer, NAT64 and DNS64 won't be configured on the Remote Access server. Therefore, client machines accessing the corporate network over DirectAccess using this entry point won't be able to access IPv4 only servers on the internal network. For information on how to transition to an IPv6+IPv4 network, or an IPv6-only network, see "Plan the transition to IPv6 when multisite Remote Access is deployed".  
  
    **Solution**  
  
    Add an IPv4 address to the new Remote Access server to ensure that DNS64 and NAT64 work correctly.  
  
## Domain issues with the ServerGpoName  
  
-   **Issue 1**  
  
    **Error received**. The domain specified in the ServerGpoName parameter <server_GPO> does not exist. Specify the domain <domain_name> instead.  
  
    **Cause**  
  
    The domain name part of the server GPO name which was sent by the administrator was not found.  
  
    **Solution**  
  
    Make sure that you typed the domain name correctly. If the domain name is spelled correctly, try again using the fully qualified domain name (FQDN).  
  
-   **Issue 2**  
  
    **Error received**. The server GPO must be located in the Remote Access server domain. Specify the domain <domain_name> in the ServerGpoName parameter.  
  
    **Cause**  
  
    The domain of the server GPO is not the same as the one to which the Remote Access server belongs.  
  
    **Solution**  
  
    The server GPO should be located in the same domain as the Remote Access server. Use the server's domain name for the server GPO and try again.  
  
## Split-brain DNS  
**Warning received**. The NRPT entry for the DNS suffix <DNS_suffix> contains the public name used by client computers to connect to the Remote Access server. Add the name <connect_to_address> as an exemption in the NRPT.  
  
**Cause**  
  
You are using split brain DNS. To allow clients to connect using IP-HTTPS, you should make sure that the ConnectTo address selected is exempt in the NRPT rules.  
  
**Solution**  
  
If you have a multisite deployment, make sure that all connect to addresses of the different entry points are exempt from the NRPT rules.  
  
To exempt an address in the NRPT rules:  
  
1.  In the Remote Access Management console, under **Step 3 Infrastructure Servers**, click **Edit**.  
  
2.  In the **Infrastructure Server Setup** wizard, on the **DNS** page, double-click the table to enter a new name suffix.  
  
3.  On the **DNS Server Addresses** dialog box, in DNS suffix, enter the ConnectTo address of the entry point, and then click **Apply**.  
  
When you add name suffixes without specifying a server address, the suffix is treated as an NRPT exemption.  
  
## Saving server GPO settings  
**Error received**. An error occurred while saving Remote Access settings to GPO <GPO_name>.  
  
To troubleshoot this error, see Saving server GPO settings in [Troubleshooting Enabling Multisite](https://technet.microsoft.com/library/jj591658.aspx).  
  
## GPO updates cannot be applied  
**Warning received**. GPO updates cannot be applied on <server_name>. Changes will not take effect until the next policy refresh.  
  
**Cause**  
  
An error occurred while trying to refresh policies on the specified computer. Therefore, changes made will not take effect until the next policy refresh.  
  
**Solution**  
  
To force a policy refresh, run `gpupdate /force` on the specified computer.  
  


