---
title: Deploy DHCP Using Windows PowerShell
description: You can use this topic to deploy a Windows Server 2016 Internet Protocol (IP) version 4 DHCP server that provides automatic IP addresses and DHCP options to IPv4 DHCP clients connected to one or more subnets on your network.
ms.prod: windows-server
ms.technology: networking-dhcp
ms.topic: article
ms.assetid: 7110ad21-a33e-48d5-bb3c-129982913bc8
manager: brianlic
ms.author: lizross
author: eross-msft
---

# Deploy DHCP Using Windows PowerShell

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This guide provides instructions on how to use Windows PowerShell to deploy an Internet Protocol (IP) version 4 Dynamic Host Configuration Protocol \(DHCP\)  server that automatically assigns IP addresses and DHCP options to IPv4 DHCP clients that are connected to one or more subnets on your network.

> [!NOTE]
> To download this document in Word format from TechNet Gallery, see [Deploy DHCP Using Windows PowerShell in Windows Server 2016](https://gallery.technet.microsoft.com/Deploy-DHCP-Using-Windows-246dd293).

Using DHCP servers to assign IP addresses saves in administrative overhead because you do not need to manually configure the TCP/IP v4 settings for every network adapter in every computer on your network. With DHCP, TCP/IP v4 configuration is performed automatically when a computer or other DHCP client is connected to your network.

You can deploy your DHCP server in a workgroup as a standalone server, or as part of an Active Directory domain.

This guide contains the following sections.

- [DHCP Deployment Overview](#bkmk_overview)
- [Technology Overviews](#bkmk_technologies)
- [Plan DHCP Deployment](#bkmk_plan)
- [Using This Guide in a Test Lab](#bkmk_lab)
- [Deploy DHCP](#bkmk_deploy)
- [Verify Server Functionality](#bkmk_verify)
- [Windows PowerShell Commands for DHCP](#bkmk_dhcpwps)
- [List of Windows PowerShell Commands in this guide](#bkmk_list)

## <a name="bkmk_overview"></a>DHCP Deployment Overview

The following illustration depicts the scenario that you can deploy by using this guide. The scenario includes one DHCP server in an Active Directory domain. The server is configured to provide IP addresses to DHCP clients on two different subnets. The subnets are separated by a router that has DHCP Forwarding enabled.

![DHCP Network Topology Overview](../../media/Core-Network-Guide/cng16_overview.jpg)

## <a name="bkmk_technologies"></a>Technology Overviews

The following sections provide brief overviews of DHCP and TCP/IP.

### DHCP overview

DHCP is an IP standard for simplifying the management of host IP configuration. The DHCP standard provides for the use of DHCP servers as a way to manage dynamic allocation of IP addresses and other related configuration details for DHCP-enabled clients on your network.

DHCP allows you to use a DHCP server to dynamically assign an IP address to a computer or other device, such as a printer, on your local network, rather than manually configuring every device with a static IP address.

Every computer on a TCP/IP network must have a unique IP address, because the IP address and its related subnet mask identify both the host computer and the subnet to which the computer is attached. By using DHCP, you can ensure that all computers that are configured as DHCP clients receive an IP address that is appropriate for their network location and subnet, and by using DHCP options, such as default gateway and DNS servers, you can automatically provide DHCP clients with the information that they need to function correctly on your network.

For TCP/IP-based networks, DHCP reduces the complexity and amount of administrative work involved in configuring computers.

### TCP/IP overview

By default, all versions of Windows Server and Windows Client operating systems have TCP/IP settings for IP version 4 network connections configured to automatically obtain an IP address and other information, called DHCP options, from a DHCP server. Because of this, you do not need to configure TCP/IP settings manually unless the computer is a server computer or other device that requires a manually configured, static IP address. 

For example, it is recommended that you manually configure the IP address of the DHCP server, and the IP addresses of DNS servers and domain controllers that are running Active Directory Domain Services \(AD DS\).

TCP/IP in Windows Server 2016 is the following:

- Networking software based on industry-standard networking protocols.

- A routable enterprise networking protocol that supports the connection of your Windows-based computer to both local area network (LAN) and wide area network (WAN) environments.

- Core technologies and utilities for connecting your Windows-based computer with dissimilar systems for the purpose of sharing information.

- A foundation for gaining access to global Internet services, such as Web and File Transfer Protocol (FTP) servers.

- A robust, scalable, cross-platform, client/server framework.

TCP/IP provides basic TCP/IP utilities that enable Windows-based computers to connect and share information with other Microsoft and non-Microsoft systems, including:

- Windows Server 2016

- Windows 10

- Windows Server 2012 R2

- Windows 8.1

- Windows Server 2012

- Windows 8

- Windows Server 2008 R2

- Windows 7

- Windows Server 2008

- Windows Vista

- Internet hosts

- Apple Macintosh systems

- IBM mainframes

- UNIX and Linux systems

- Open VMS systems

- Network-ready printers

- Tablets and cellular telephones with wired Ethernet or wireless 802.11 technology enabled

## <a name="bkmk_plan"></a>Plan DHCP Deployment

Following are key planning steps before installing the DHCP server role.

### Planning DHCP servers and DHCP forwarding

Because DHCP messages are broadcast messages, they are not forwarded between subnets by routers. If you have multiple subnets and want to provide DHCP service for each subnet, you must do one of the following:

- Install a DHCP server on each subnet

- Configure routers to forward DHCP broadcast messages across subnets and configure multiple scopes on the DHCP server, one scope per subnet.

In most cases, configuring routers to forward DHCP broadcast messages is more cost effective than deploying a DHCP server on each physical segment of the network.

### Planning IP address ranges

Each subnet must have its own unique IP address range. These ranges are represented on a DHCP server with scopes.

A scope is an administrative grouping of IP addresses for computers on a subnet that use the DHCP service. The administrator first creates a scope for each physical subnet and then uses the scope to define the parameters used by clients.

A scope has the following properties:

- A range of IP addresses from which to include or exclude addresses used for DHCP service lease offerings.

- A subnet mask, which determines the subnet prefix for a given IP address.

- A scope name assigned when it is created.

- Lease duration values, which are assigned to DHCP clients that receive dynamically allocated IP addresses.

- Any DHCP scope options configured for assignment to DHCP clients, such as DNS server IP address and router/default gateway IP address.

- Reservations are optionally used to ensure that a DHCP client always receives the same IP address.

Before deploying your servers, list your subnets and the IP address range you want to use for each subnet.

### Planning subnet masks

Network IDs and host IDs within an IP address are distinguished by using a subnet mask. Each subnet mask is a 32-bit number that uses consecutive bit groups of all ones (1) to identify the network ID and all zeroes (0) to identify the host ID portions of an IP address.

For example, the subnet mask normally used with the IP address 131.107.16.200 is the following 32-bit binary number:

```
11111111 11111111 00000000 00000000
```

This subnet mask number is 16 one-bits followed by 16 zero-bits, indicating that the network ID and host ID sections of this IP address are both 16 bits in length. Normally, this subnet mask is displayed in dotted decimal notation as 255.255.0.0.

The following table displays subnet masks for the Internet address classes.

|Address class|Bits for subnet mask|Subnet mask|
|-----------------|------------------------|---------------|
|Class A|11111111 00000000 00000000 00000000|255.0.0.0|
|Class B|11111111 11111111 00000000 00000000|255.255.0.0|
|Class C|11111111 11111111 11111111 00000000|255.255.255.0|

When you create a scope in DHCP and you enter the IP address range for the scope, DHCP provides these default subnet mask values. Typically, default subnet mask values are acceptable for most networks with no special requirements and where each IP network segment corresponds to a single physical network.

In some cases, you can use customized subnet masks to implement IP subnetting. With IP subnetting, you can subdivide the default host ID portion of an IP address to specify subnets, which are subdivisions of the original class-based network ID.

By customizing the subnet mask length, you can reduce the number of bits that are used for the actual host ID.

To prevent addressing and routing problems, you should make sure that all TCP/IP computers on a network segment use the same subnet mask and that each computer or device has an unique IP address.

### Planning exclusion ranges

When you create a scope on a DHCP server, you specify an IP address range that includes all of the IP addresses that the DHCP server is allowed to lease to DHCP clients, such as computers and other devices. If you then go and manually configure some servers and other devices with static IP addresses from the same IP address range that the DHCP server is using, you can accidentally create an IP address conflict, where you and the DHCP server have both assigned the same IP address to different devices.

To solve this problem, you can create an exclusion range for the DHCP scope. An exclusion range is a contiguous range of IP addresses within the scope's IP address range that the DHCP server is not allowed to use. If you create an exclusion range, the DHCP server does not assign the addresses in that range, allowing you to manually assign these addresses without creating an IP address conflict.

You can exclude IP addresses from distribution by the DHCP server by creating an exclusion range for each scope. You should use exclusions for all devices that are configured with a static IP address. The excluded addresses should include all IP addresses that you assigned manually to other servers, non-DHCP clients, diskless workstations, or Routing and Remote Access and PPP clients.

It is recommended that you configure your exclusion range with extra addresses to accommodate future network growth. The following table provides an example exclusion range for a scope with an IP address range of 10.0.0.1 - 10.0.0.254 and a subnet mask of 255.255.255.0.

|Configuration items|Example values|
|-----------------------|------------------|
|Exclusion range Start IP Address|10.0.0.1|
|Exclusion range End IP Address|10.0.0.25|

### Planning TCP/IP static configuration

Certain devices, such as routers, DHCP servers, and DNS servers, must be configured with a static IP address. In addition, you might have additional devices, such as printers, that you want to ensure always have the same IP address. List the devices that you want to configure statically for each subnet, and then plan the exclusion range you want to use on the DHCP server to ensure that the DHCP server does not lease the IP address of a statically configured device. An exclusion range is a limited sequence of IP addresses within a scope, excluded from DHCP service offerings. Exclusion ranges assure that any addresses in these ranges are not offered by the server to DHCP clients on your network.

For example, if the IP address range for a subnet is 192.168.0.1 through 192.168.0.254 and you have ten devices that you want to configure with a static IP address, you can create an exclusion range for the 192.168.0.*x* scope that includes ten or more IP addresses: 192.168.0.1 through 192.168.0.15.

In this example, you use ten of the excluded IP addresses to configure servers and other devices with static IP addresses and five additional IP addresses are left available for static configuration of new devices that you might want to add in the future. With this exclusion range, the DHCP server is left with an address pool of 192.168.0.16 through 192.168.0.254.

Additional example configuration items for AD DS and DNS are provided in the following table.

|Configuration items|Example values|
|-----------------------|------------------|
|Network Connect Bindings|Ethernet|
|DNS Server Settings|DC1.corp.contoso.com|
|Preferred DNS server IP address|10.0.0.2|
|Scope values<br /><br />1.  Scope Name<br />2.  Starting IP Address<br />3.  Ending IP Address<br />4.  Subnet Mask<br />5.  Default Gateway (optional)<br />6.  Lease duration|1.  Primary Subnet<br />2.  10.0.0.1<br />3.  10.0.0.254<br />4.  255.255.255.0<br />5.  10.0.0.1<br />6.  8 days|
|IPv6 DHCP Server Operation Mode|Not enabled|

## <a name="bkmk_lab"></a>Using This Guide in a Test Lab

You can use this guide to deploy DHCP in a test lab before you deploy in a production environment. 

> [!NOTE]
> If you do not want to deploy DHCP in a test lab, you can skip to the section [Deploy DHCP](#bkmk_deploy).

The requirements for your lab differ depending on whether you are using physical servers or virtual machines \(VMs\), and whether you are using an Active Directory domain or deploying a standalone DHCP server.

You can use the following information to determine the minimum resources you need to test DHCP deployment using this guide.

### Test Lab requirements with VMs

To deploy DHCP in a test lab with VMs, you need the following resources.

For either domain deployment or standalone deployment, you need one server that is configured as a Hyper\-V host.

**Domain deployment**

This deployment requires one physical server, one virtual switch, two virtual servers, and one virtual client:

On your physical server, in Hyper-V Manager, create the following items.

1. One **Internal** virtual switch. Do not create an **External** virtual switch, because if your Hyper\-V host is on a subnet that includes a DHCP server, your test VMs will receive an IP address from your DHCP server. In addition, the test DHCP server that you deploy might assign IP addresses to other computers on the subnet where the Hyper\-V host is installed.
1. One VM running Windows Server 2016 configured as a domain controller with Active Directory Domain Services that is connected to the Internal virtual switch you created. To match this guide, this server must have a statically configured IP address of 10.0.0.2. For information on deploying AD DS, see the section **Deploying DC1** in the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide#BKMK_deployADDNS01).
1. One VM running Windows Server 2016 that you will configure as a DHCP server by using this guide and  that is connected to the Internal virtual switch you created. 
1. One VM running a Windows client operating system  that is connected to the Internal virtual switch you created and that you will use to verify that your DHCP server is dynamically allocating IP addresses and DHCP options to DHCP clients.

**Standalone DHCP server deployment**

This deployment requires one physical server, one virtual switch, one virtual server, and one virtual client:

On your physical server, in Hyper-V Manager, create the following items.

1. One **Internal** virtual switch. Do not create an **External** virtual switch, because if your Hyper\-V host is on a subnet that includes a DHCP server, your test VMs will receive an IP address from your DHCP server. In addition, the test DHCP server that you deploy might assign IP addresses to other computers on the subnet where the Hyper\-V host is installed.
2. One VM running Windows Server 2016 that you will configure as a DHCP server by using this guide and  that is connected to the Internal virtual switch you created.
3. One VM running a Windows client operating system  that is connected to the Internal virtual switch you created and that you will use to verify that your DHCP server is dynamically allocating IP addresses and DHCP options to DHCP clients.

### Test Lab requirements with physical servers

To deploy DHCP in a test lab with physical servers, you need the following resources.

**Domain deployment**

This deployment requires one hub or switch, two physical servers and one physical client:

1. One Ethernet hub or switch to which you can connect the physical computers with Ethernet cables
2. One physical computer running Windows Server 2016 configured as a domain controller with Active Directory Domain Services. To match this guide, this server must have a statically configured IP address of 10.0.0.2. For information on deploying AD DS, see the section **Deploying DC1** in the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide#BKMK_deployADDNS01).
3. One physical computer running Windows Server 2016 that you will configure as a DHCP server by using this guide.
4. One physical computer running a Windows client operating system that you will use to verify that your DHCP server is dynamically allocating IP addresses and DHCP options to DHCP clients.

> [!NOTE]
> If you do not have enough test machines for this deployment, you can use one test machine for both AD DS and DHCP - however this configuration is not recommended for a production environment.

**Standalone DHCP server deployment**

This deployment requires one hub or switch, one physical server, and one physical client:

1. One Ethernet hub or switch to which you can connect the physical computers with Ethernet cables
2. One physical computer running Windows Server 2016 that you will configure as a DHCP server by using this guide.
3. One physical computer running a Windows client operating system that you will use to verify that your DHCP server is dynamically allocating IP addresses and DHCP options to DHCP clients.


## <a name="bkmk_deploy"></a>Deploy DHCP

This section provides example Windows PowerShell commands that you can use to deploy DHCP on one server. Before you run these example commands on your server, you must modify the commands to match your network and environment. 

For example, before you run the commands, you should replace example values in the commands for the following items:

- Computer names
- IP Address range for each scope you want to configure (1 scope per subnet)
- Subnet mask for each IP address range you want to configure
- Scope name for each scope
- Exclusion range for each scope
- DHCP option values, such as default gateway, domain name, and DNS or WINS servers
- Interface names

> [!IMPORTANT]
> Examine and modify every command for your environment before you run the command.

### Where to Install DHCP - on a physical computer or a VM?

You can install the DHCP server role on a physical computer or on a virtual machine \(VM\) that is installed on a Hyper\-V host. If you are installing DHCP on a VM and you want the DHCP server to provide IP address assignments to computers on the physical network to which the Hyper-V host is connected, you must connect the VM virtual network adapter to a Hyper-V Virtual Switch that is **External**.

For more information, see the section **Create a Virtual Switch with Hyper-V Manager** in the topic [Create a virtual network](https://docs.microsoft.com/virtualization/hyper-v-on-windows/quick-start/connect-to-network).

### Run Windows PowerShell as an Administrator

You can use the following procedure to run Windows PowerShell with Administrator privileges.

1. On a computer running Windows Server 2016, click **Start**, then right-click the Windows PowerShell icon. A menu appears.

2. In the menu, click **More**, and then click **Run as administrator**. If prompted, type the credentials for an account that has Administrator privileges on the computer. If the user account with which you are logged on to the computer is an Administrator level account, you will not receive a credential prompt.

3. Windows PowerShell opens with Administrator privileges.

### Rename the DHCP server and configure a static IP address

If you have not already done so, you can use the following Windows PowerShell commands to rename the DHCP server and configure a static IP address for the server.

**Configure a static IP address**

You can use the following commands to assign a static IP address to the DHCP server, and to configure the DHCP server TCP/IP properties with the correct DNS server IP address. You must also replace interface names and IP addresses in this example with the values that you want to use to configure your computer.

```
New-NetIPAddress -IPAddress 10.0.0.3 -InterfaceAlias "Ethernet" -DefaultGateway 10.0.0.1 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 10.0.0.2
```

For more information about these commands, see the following topics.

- [New-NetIPAddress](https://docs.microsoft.com/powershell/module/nettcpip/New-NetIPAddress)
- [Set-DnsClientServerAddress](https://docs.microsoft.com/powershell/module/dnsclient/Set-DnsClientServerAddress)

**Rename the computer**

You can use the following commands to rename and then restart the computer.

```
Rename-Computer -Name DHCP1
Restart-Computer
```

For more information about these commands, see the following topics.

- [Rename-Computer](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/rename-computer)
- [Restart-Computer](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/restart-computer)

### Join the computer to the domain \(Optional\)

If you are installing your DHCP server in an Active Directory domain environment, you must join the computer to the domain. Open Windows PowerShell with Administrator privileges, and then run the following command after replacing the domain NetBios name **CORP** with a value that is appropriate for your environment.

```
Add-Computer CORP
```

When prompted, type the credentials for a domain user account that has permission to join a computer to the domain. 

```
Restart-Computer
```

For more information about the Add-Computer command, see the following topic.

- [Add-Computer](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/add-computer?view=powershell-5.1)

### Install DHCP

After the computer restarts, open Windows PowerShell with Administrator privileges, and then install DHCP by running the following command.

```
Install-WindowsFeature DHCP -IncludeManagementTools
```

For more information about this command, see the following topic.

- [Install-WindowsFeature](https://docs.microsoft.com/powershell/module/servermanager/install-windowsfeature)

### Create DHCP security groups

To create security groups, you must run a Network Shell \(netsh\) command in Windows PowerShell, and then restart the DHCP service so that the new groups become active.

When you run the following netsh command on the DHCP server, the **DHCP Administrators** and **DHCP Users** security groups are created in **Local Users and Groups** on the DHCP server.

```
netsh dhcp add securitygroups
```

The following command restarts the DHCP service on the local computer.

```
Restart-Service dhcpserver
```

For more information about these commands, see the following topics.

- [Network Shell (Netsh)](../netsh/netsh.md)
- [Restart-Service](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/restart-service)

### Authorize the DHCP server in Active Directory \(Optional\)

If you are installing DHCP in a domain environment, you must perform the following steps to authorize the DHCP server to operate in the domain.

> [!NOTE]
> Unauthorized DHCP servers that are installed in Active Directory domains cannot function properly, and do not lease IP addresses to DHCP clients. The automatic disabling of unauthorized DHCP servers is a security feature that prevents unauthorized DHCP servers from assigning incorrect IP addresses to clients on your network.

You can use the following command to add the DHCP server to the list of authorized DHCP servers in Active Directory. 

> [!NOTE]
> If you do not have a domain environment, do not run this command.

```
Add-DhcpServerInDC -DnsName DHCP1.corp.contoso.com -IPAddress 10.0.0.3
```

To verify that the DHCP server is authorized in Active Directory, you can use the following command.

```
Get-DhcpServerInDC
```

Following are example results that are displayed in Windows PowerShell.

```
IPAddress	DnsName
---------	-------
10.0.0.3 	DHCP1.corp.contoso.com
```

For more information about these commands, see the following topics.

- [Add-DhcpServerInDC](https://docs.microsoft.com/powershell/module/dhcpserver/add-dhcpserverindc)
- [Get-DhcpServerInDC](https://docs.microsoft.com/powershell/module/dhcpserver/get-dhcpserverindc)

### Notify Server Manager that post\-install DHCP configuration is complete \(Optional\)

After you have completed post\-installation tasks, such as creating security groups and authorizing the DHCP server in Active Directory, Server Manager might still display an alert in the user interface stating that post\-installation steps must be completed by using the DHCP Post Installation Configuration wizard.

You can prevent this now\-unnecessary and inaccurate message from appearing in Server Manager by configuring the following registry key using this Windows PowerShell command.

```
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2
```

For more information about this command, see the following topic.

- [Set-ItemProperty](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-itemproperty)

### Set server level DNS dynamic update configuration settings \(Optional\)

If you want the DHCP server to perform DNS dynamic updates for DHCP client computers, you can run the following command to configure this setting. This is a server level setting, not a scope level setting, so it will affect all scopes that you configure on the server. This example command also configures the DHCP server to delete DNS resource records for clients when the client least expires.

```
Set-DhcpServerv4DnsSetting -ComputerName "DHCP1.corp.contoso.com" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True
```

You can use the following command to configure the credentials that the DHCP server uses to register or unregister client records on a DNS server. This example saves a credential on a DHCP server. The first command uses **Get-Credential** to create a **PSCredential** object, and then stores the object in the **$Credential** variable. The command prompts you for user name and password, so ensure that you provide credentials for an account that has permission to update resource records on your DNS server.
 
```
$Credential = Get-Credential
Set-DhcpServerDnsCredential -Credential $Credential -ComputerName "DHCP1.corp.contoso.com"
``` 

For more information about these commands, see the following topics.

- [Set-DhcpServerv4DnsSetting](https://docs.microsoft.com/powershell/module/dhcpserver/set-dhcpserverv4dnssetting)
- [Set-DhcpServerDnsCredential](https://docs.microsoft.com/powershell/module/dhcpserver/set-dhcpserverdnscredential)

### Configure the Corpnet Scope

After DHCP installation is completed, you can use the following commands to configure and activate the Corpnet scope, create an exclusion range for the scope, and configure the DHCP options default gateway, DNS server IP address, and DNS domain name.

```
Add-DhcpServerv4Scope -name "Corpnet" -StartRange 10.0.0.1 -EndRange 10.0.0.254 -SubnetMask 255.255.255.0 -State Active    
Add-DhcpServerv4ExclusionRange -ScopeID 10.0.0.0 -StartRange 10.0.0.1 -EndRange 10.0.0.15
Set-DhcpServerv4OptionValue -OptionID 3 -Value 10.0.0.1 -ScopeID 10.0.0.0 -ComputerName DHCP1.corp.contoso.com
Set-DhcpServerv4OptionValue -DnsDomain corp.contoso.com -DnsServer 10.0.0.2
```

For more information about these commands, see the following topics.

- [Add-DhcpServerv4Scope](https://docs.microsoft.com/powershell/module/dhcpserver/Add-DhcpServerv4Scope)
- [Add-DhcpServerv4ExclusionRange](https://docs.microsoft.com/powershell/module/dhcpserver/Add-DhcpServerv4ExclusionRange)
- [Set-DhcpServerv4OptionValue](https://docs.microsoft.com/powershell/module/dhcpserver/Set-DhcpServerv4OptionValue)

### Configure the Corpnet2 Scope \(Optional\)

If you have a second subnet that is connected to the first subnet with a router where DHCP forwarding is enabled, you can use the following commands to add a second scope, named Corpnet2 for this example. This example also configures an exclusion range and the IP address for the default gateway \(the router IP address on the subnet\) of the Corpnet2 subnet.

```
Add-DhcpServerv4Scope -name "Corpnet2" -StartRange 10.0.1.1 -EndRange 10.0.1.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 10.0.1.0 -StartRange 10.0.1.1 -EndRange 10.0.1.15
Set-DhcpServerv4OptionValue -OptionID 3 -Value 10.0.1.1 -ScopeID 10.0.1.0 -ComputerName DHCP1.corp.contoso.com
```

If you have additional subnets that are serviced by this DHCP server, you can repeat these commands, using different values for all of the command parameters, to add scopes for each subnet.

> [!IMPORTANT]
> Ensure that all routers between your DHCP clients and your DHCP server are configured for DHCP message forwarding. See your router documentation for information on how to configure DHCP forwarding.

## <a name="bkmk_verify"></a>Verify Server Functionality

To verify that your DHCP server is providing dynamic allocation of IP addresses to DHCP clients, you can connect another computer to a serviced subnet. After you connect the Ethernet cable to the network adapter and power on the computer, it will request an IP address from your DHCP server. You can verify successful configuration by using the **ipconfig /all** command and reviewing the results, or by performing connectivity tests, such as attempting to access Web resources with your browser or file shares with Windows Explorer or other applications.

If the client does not receive an IP address from your DHCP server, perform the following troubleshooting steps.

1. Ensure that the Ethernet cable is plugged into both the computer and the Ethernet switch, hub,  or router.
2. If you plugged the client computer into a network segment that is separated from the DHCP server by a router, ensure that the router is configured to forward DHCP messages.
3. Ensure that the DHCP server is authorized in Active Directory by running the following command to retrieve the list of authorized DHCP servers from Active Directory. [Get-DhcpServerInDC](https://docs.microsoft.com/powershell/module/dhcpserver/Get-DhcpServerInDC).
4. Ensure that your scopes are activated by opening the DHCP console \(Server Manager, **Tools**, **DHCP**\), expanding the server tree to review scopes, then right\-clicking each scope. If the resulting menu includes the selection **Activate**, click **Activate**. \(If the scope is already activated, the menu selection reads **Deactivate**.\)

## <a name="bkmk_dhcpwps"></a>Windows PowerShell Commands for DHCP

The following reference provides command descriptions and syntax for all DHCP Server Windows PowerShell commands for Windows Server 2016. The topic lists commands in alphabetical order based on the verb at the beginning of the commands, such as **Get** or **Set**.

> [!NOTE]
> You can not use Windows Server 2016 commands in Windows Server 2012 R2.

- [DhcpServer Module](https://docs.microsoft.com/powershell/module/dhcpserver/)

The following reference provides command descriptions and syntax for all DHCP Server Windows PowerShell commands for Windows Server 2012 R2. The topic lists commands in alphabetical order based on the verb at the beginning of the commands, such as **Get** or **Set**.

> [!NOTE]
> You can use Windows Server 2012 R2 commands in Windows Server 2016.

- [DHCP Server Cmdlets in Windows PowerShell](https://docs.microsoft.com/windows-server/networking/technologies/dhcp/dhcp-deploy-wps)

## <a name="bkmk_list"></a>List of Windows PowerShell Commands in this guide

Following is a simple list of commands and example values that are used in this guide.

```
New-NetIPAddress -IPAddress 10.0.0.3 -InterfaceAlias "Ethernet" -DefaultGateway 10.0.0.1 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 10.0.0.2
Rename-Computer -Name DHCP1
Restart-Computer

Add-Computer CORP
Restart-Computer

Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups
Restart-Service dhcpserver

Add-DhcpServerInDC -DnsName DHCP1.corp.contoso.com -IPAddress 10.0.0.3
Get-DhcpServerInDC

Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

Set-DhcpServerv4DnsSetting -ComputerName "DHCP1.corp.contoso.com" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True

$Credential = Get-Credential
Set-DhcpServerDnsCredential -Credential $Credential -ComputerName "DHCP1.corp.contoso.com"

rem At prompt, supply credential in form DOMAIN\user, password

rem Configure scope Corpnet
Add-DhcpServerv4Scope -name "Corpnet" -StartRange 10.0.0.1 -EndRange 10.0.0.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 10.0.0.0 -StartRange 10.0.0.1 -EndRange 10.0.0.15
Set-DhcpServerv4OptionValue -OptionID 3 -Value 10.0.0.1 -ScopeID 10.0.0.0 -ComputerName DHCP1.corp.contoso.com
Set-DhcpServerv4OptionValue -DnsDomain corp.contoso.com -DnsServer 10.0.0.2

rem Configure scope Corpnet2
Add-DhcpServerv4Scope -name "Corpnet2" -StartRange 10.0.1.1 -EndRange 10.0.1.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 10.0.1.0 -StartRange 10.0.1.1 -EndRange 10.0.1.15
Set-DhcpServerv4OptionValue -OptionID 3 -Value 10.0.1.1 -ScopeID 10.0.1.0 -ComputerName DHCP1.corp.contoso.com
```
