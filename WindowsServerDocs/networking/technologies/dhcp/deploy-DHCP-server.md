---
title: Deploy DHCP Server
description: You can use this topic to deploy a Windows Server Internet Protocol (IP) version 4 DHCP server that provides automatic IP addresses and DHCP options to IPv4 DHCP clients connected to one or more subnets on your network.
ms.topic: quickstart
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.date: 06/01/2023
---
Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This quickstart shows you how to deploy an Internet Protocol (IP) version 4 Dynamic Host Configuration Protocol \(DHCP\) server that automatically assigns IP addresses and DHCP options to IPv4 DHCP clients that are connected to one or more subnets on your network.

## Prerequisites

Before you can deploy your IPv4 DHCP server, you must meet the following
prerequisites:

- A computer running a supported version of Windows Server.
- A static IP.
- An account that is a member of the Administrators group, or equivalent.

## Deploy DHCP Using Server Manager

Deploying DHCP involves adding the DNS Server role to an existing
Windows Server server.

To install the DNS Server role as a standalone server, perform the following steps:

<!-- DNS Server installation steps using Server Manager are almost identical to those for deploying DHCP; need to adjust the below accordingly  -->

Here's how to install the DNS Server role using Server Manager from the Windows desktop.

1. From the Windows desktop, open the **Start** menu, then select the **Server Manager** tile.

1. On the menu, go to **Manage**, and then select **Add Roles and Features**.

1. On the **Before you begin** page, select **Next** to begin.

1. On the **Select installation type** page, select the **Role-based or feature-based
   installation** option, and select **Next**.

1. On the **Select destination server** page, leave the default options. Select **Next**.

1. On the **Select server roles** page, select the **DNS Server** checkbox, and then select on the
   **Next** button.

    1. You'll be prompted to add features that are required for DNS Server, if you're happy with the
       defaults, select **Add Features**.

1. On the **Select features** page, you can leave the default selections, and then select on the
   **Next** button.

1. On the **DNS Server** page, review the role description and things to note, select **Next** to
   continue.

1. On the **Confirm installation selections** page, review the selected roles and features, and then
   select on the **Install** button to begin the installation process.

1. Once the installation is complete, select **Close**. The installation doesn't require a reboot.

## Deploy DHCP using Power Shell

To deploy DHCP using PowerShell:

#### [PowerShell](#tab/powershell)

Here's how to deploy DHCP using the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature) command.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command. The installation doesn't require a reboot.

   ```powershell
   Install-WindowsFeature DHCP -IncludeManagementTools
   ```

#### [GUI](#tab/gui)

## Authorize the DHCP server in Active Directory \(Optional\)

> [!TIP]
> When you install Active Directory Domain Services (AD DS) with the Active Directory Domain
> Services Installation Wizard, the wizard gives you the option to authorize DHCP. The resulting DNS > zone is integrated with the AD DS domain namespace. To
> learn more, see
> [Understanding Active Directory Domain Services Integration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc726034(v=ws.11)). 

## Configure IPv4 DHCP server

After you have successfully installed your IPv4 DHCP server there are several configuration steps to perform, including planning IP address ranges by setting up multiple scopes on the DHCP server, one scope per subnet. Prior to setting up scopes you also must authorize your DHCP server in DNS. 

### Authorizing DHCP server in DNS

Follow these steps to authorize your DHCP server in a domain environment. 

#### [PowerShell](#tab/powershell)

<!-- (powershell version) -->

#### [GUI](#tab/gui)

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

- [Add-DhcpServerInDC](/powershell/module/dhcpserver/add-dhcpserverindc)
- [Get-DhcpServerInDC](/powershell/module/dhcpserver/get-dhcpserverindc)

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

For more information about these commands, see the following topics see [Set-DhcpServerv4DnsSetting](/powershell/module/dhcpserver/set-dhcpserverv4dnssetting) and [Set-DhcpServerDnsCredential](/powershell/module/dhcpserver/set-dhcpserverdnscredential)

### Plan IP address ranges using multiple scopes on the DHCP server

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

For more information on scopes and configuring your DHCP server, see [Plan DHCP deployment](/networking/technologies/dhcp/dhcp-deploy-wps#bkmk_plan)

## Related links

- 