---
title: Install DHCP Server
description: You can use this topic to install a Windows Server Internet Protocol (IP) version 4 DHCP server that provides automatic IP addresses and DHCP options to IPv4 DHCP clients connected to one or more subnets on your network.
ms.topic: quickstart
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.date: 06/01/2023
---
Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This quickstart shows you how to install an Internet Protocol (IP) version 4 Dynamic Host Configuration Protocol \(DHCP\) server that automatically assigns IP addresses and DHCP options to IPv4 DHCP clients that are connected to one or more subnets on your network.

## Prerequisites

Before you can install your IPv4 DHCP server, you must meet the following prerequisites:

- A computer running a supported version of Windows Server.
- A static IP.
- An account that's a member of the Administrators group, or equivalent.

## Install DHCP Server

Installing DHCP involves adding the DNS Server role to an existing Windows Server server.

To install the DNS Server role as a standalone server, perform the following steps:

#### [PowerShell](#tab/powershell)

Here's how to install DHCP using the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature) command.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command. The installation doesn't require a reboot.

   ```powershell
   Install-WindowsFeature DHCP -IncludeManagementTools
   ```

#### [GUI](#tab/gui)

Here's how to install the DHCP Server role using Server Manager from the Windows desktop.

1. From the Windows desktop, open the **Start** menu, then select the **Server Manager** tile.

1. On the menu, go to **Manage**, and then select **Add Roles and Features**.

1. On the **Before you begin** page, select **Next** to begin.

1. On the **Select installation type** page, select the **Role-based or feature-based
   installation** option, and select **Next**.

1. On the **Select destination server** page, leave the default options. Select **Next**.

1. On the **Select server roles** page, select the **DHCP Server** checkbox, and then select on the
   **Next** button.

    1. You'll be prompted to add features that are required for DHCP Server, if you're happy with the
       defaults, select **Add Features**.

1. On the **Select features** page, you can leave the default selections, and then select on the
   **Next** button.

1. On the **DHCP Server** page, review the role description and things to note, select **Next** to
   continue.

1. On the **Confirm installation selections** page, review the selected roles and features, and then
   select on the **Install** button to begin the installation process.

1. Once the installation is complete, select **Close**. The installation doesn't require a reboot.

---

## Configure DHCP server

After you have successfully installed and authorized your IPv4 DHCP server and even set server level DNS dynamic update configuration settings, there are several configuration steps to perform, including setting up multiple scopes on the DHCP server, one scope per subnet. Note that your IP address ranges should already be planned prior to setting up scopes. See [Planning IP addresses across multiple scopes on DHCP IPv4 server]() for guidance.

### Authorize the DHCP server in Active Directory \(Optional\)

If you are installing DHCP in a domain environment, you must perform the following steps to authorize the DHCP server to operate in the domain.

> [!NOTE]
> Unauthorized DHCP servers that are installed in Active Directory domains can't function properly and don't lease IP addresses to DHCP clients. The automatic disabling of unauthorized DHCP servers is a security feature that prevents unauthorized DHCP servers from assigning incorrect IP addresses to clients on your network.

> [!TIP]
> When you install Active Directory Domain Services (AD DS) with the Active Directory Domain Services Installation Wizard, the wizard gives you the option to authorize DHCP. The resulting DNS > zone is integrated with the AD DS domain namespace. To learn more, see [Understanding Active Directory Domain Services Integration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc726034(v=ws.11)).

Follow these steps to authorize your DHCP server in a domain environment.

#### [PowerShell](#tab/powershell)

You can use the following command to add the DHCP server to the list of authorized DHCP servers in Active Directory.

> [!NOTE]
> If you don't have a domain environment, don't run this command.

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

#### [GUI](#tab/gui)

To authorize the DHCP server using Active Directory:

1. In Server Manager, open a DHCP administration window.
1. Right-select the IPv4 DHCP server name in the list and select Authorize.
1. Authorization can take a few seconds to resolve. Refresh the server list to confirm that the DHCP Server is now authorized (green icon appears in each scope.)'

For more information about these commands, see the following topics.

- [Add-DhcpServerInDC](/powershell/module/dhcpserver/add-dhcpserverindc)
- [Get-DhcpServerInDC](/powershell/module/dhcpserver/get-dhcpserverindc) 

### Configure new scope in IPv4 server

After you suceessfullly have installed and authorized your IPv4 DHCP Server, you can proceed to create a new DHCP scope. Scopes are used to indicate the range of IP addresses for your DHCP server and its clients. Note that IP address ranges must be planned prior to setting up scopes. See [Planning IP addresses across multiple scopes on DHCP IPv4 server]() for guidance. 

To create a new DHCP scope using PowerShell, open a PowerShell window on the DHCP server.

#### [PowerShell](#tab/powershell)

Here's how to create a new scope using the Add-DhcpServerv4Scope command.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command.

```
Add-DhcpServerv4Scope -Name "Lab-4 Network" -StartRange 10.10.10.1 -EndRange 10.10.10.254 -SubnetMask 255.255.255.0
```

This example adds a new scope for 10.10.10.0/24 subnet on the DHCP server service that runs on the local computer.

#### [GUI](#tab/gui)

#### Create new scope using Active Directory

Here's how to create a new DHCP scope using Server Manager from the Windows desktop.

1. In Server Manager, open DHCP Management Console.

1. Expand the name of the DHCP Server, right-select **IPv4**, and then select **New Scope**.

1. On the **New Scope Wizard** welcome page, select **Next**.

1. On the **Scope Name** page, in the Name field, type the name of your new scope and select **Next**.

1. On the **IP Address Range page**, specify the range of IP addresses for your DHCP clients and specify the subnet mask, using your preferred method. Select **Next**

1. On the **Add Exclusions and Delay** page, specify any addresses or range of addresses that you do not want the server to distribute. Select **Next**.

1. On the **Lease Duration** page, specify the lifespan for the IP addresses assigned to each DHCP client. Select **Next**.

Use the **Configure DHCP Options** page to configure common DHCP options including IP addresses of routers (default gateways), DNS servers, and WIN settings for your new scope.

---

## Related links

- [DHCP Basics](../troubleshoot/dynamic-host-configuration-protocol-basics)
- [DHCP Subnet selection options](/dhcp-subnet-options)
