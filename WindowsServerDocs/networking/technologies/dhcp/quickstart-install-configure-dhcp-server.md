---
title: Install and configure DHCP Server on Windows Server
description: Get started installing a Windows Server DHCP server to automatically provide IP addresses and DHCP options to clients connected to one or more subnets on your network.
ms.topic: quickstart
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.date: 06/27/2023
---

# Quickstart: Install and configure DHCP Server

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This quickstart shows you how to install a Dynamic Host Configuration Protocol (DHCP) server on
Windows Server. You'll install the DHCP Server role, authorize the server in your Active Director
domain, and configure a scope to automatically assign DHCP IP addresses and options to IPv4 DHCP
clients.

## Prerequisites

Before you can install your DHCP server, you must meet the following prerequisites:

- A computer running a supported version of Windows Server.
- A static IP.
- An IP address range for your DHCP scope.
- An account that's a member of the Administrators group, or equivalent.

## Install DHCP Server

Installing the DHCP Server involves adding the DNS Server role to an existing Windows Server server.

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

    1. You're prompted to add features that are required for DHCP Server, if you're happy with the
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

After you have successfully installed the DHCP Server role, you need to authorize and configure your
DHCP server.

### Authorize the DHCP server in Active Directory

If you're installing DHCP in a domain environment, you must perform the following steps to
authorize the DHCP server to operate in the domain.

> [!NOTE]
> Unauthorized DHCP servers that are installed in Active Directory domains can't function properly
> and don't lease IP addresses to DHCP clients. The automatic disabling of unauthorized DHCP servers
> is a security feature that prevents unauthorized DHCP servers from assigning incorrect IP
> addresses to clients on your network.

Follow these steps to authorize your DHCP server in a domain environment.

#### [PowerShell](#tab/powershell)

You can use the following command to add the DHCP server to the list of authorized DHCP servers in
Active Directory.

> [!NOTE]
> If you don't have a domain environment, don't run this command.

```powershell
Add-DhcpServerInDC -DnsName DHCP1.corp.contoso.com -IPAddress 10.0.0.3
```

To verify that the DHCP server is authorized in Active Directory, you can use the following command.

```powershell
Get-DhcpServerInDC
```

The following example shows the output displayed in Windows PowerShell.

```powershell
IPAddress	DnsName
---------	-------
10.0.0.3 	DHCP1.corp.contoso.com
```

For more information about these commands, see the following articles.

- [Add-DhcpServerInDC](/powershell/module/dhcpserver/add-dhcpserverindc)
- [Get-DhcpServerInDC](/powershell/module/dhcpserver/get-dhcpserverindc)

#### [GUI](#tab/gui)

To authorize the DHCP server using Active Directory:

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DHCP**.
1. Expand your DHCP server name and right-click, then select **Authorize**.
1. Authorization can take a few seconds to resolve. Refresh the server list to confirm that the DHCP
   Server is now authorized (green icon appears in each scope.)

---

### Configure an IPv4 scope

After you have successfully authorized your DHCP Server, you can proceed to create a new DHCP scope.
Scopes are used to indicate the range of IP addresses for your DHCP server and its clients. To learn
more about planning your scope ranges, see
[Planning DHCP networks](/previous-versions/windows/it-pro/windows-server-2003/cc786002(v=ws.10))
for guidance.

To create a new IPv4 DHCP scope, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create a new scope using the
[Add-DhcpServerv4Scope](/powershell/module/dhcpserver/add-dhcpserverv4scope) PowerShell command.

1. Run PowerShell on your computer in an elevated session.

1. To configure a new DHCP scope named `Contoso network` with a range from `10.10.10.100` to
   `10.10.10.200` and a subnet mask of `255.255.255.0`, run the following command.

   ```powershell
   Add-DhcpServerv4Scope -Name "Contoso network" -StartRange 10.10.10.100 -EndRange 10.10.10.200 -SubnetMask 255.255.255.0
   ```

#### [GUI](#tab/gui)

Here's how to create a new DHCP scope using the DHCP console.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools >
   DHCP**.

1. Expand the name of the DHCP Server, right-select **IPv4**, and then select **New Scope**.

1. On the **New Scope Wizard** welcome page, select **Next**.

1. On the **Scope Name** page, in the Name field, type the name of your new scope and select
   **Next**.

1. On the **IP Address Range page**, specify the range of IP addresses for your DHCP clients and
   specify the subnet mask, using your preferred method, select **Next**

1. On the **Add Exclusions and Delay** page, specify any addresses or range of addresses that you
   don't want the server to distribute, select **Next**.

1. On the **Lease Duration** page, specify the lifespan for the IP addresses assigned to each DHCP
   client, select **Next**.

1. On the **Configure DHCP Options** page, select **Yes, I want to configure these options now** and
   then select **Next**.

   > [!TIP]
   > The **Configure DHCP Options** page lets you configure common DHCP options including IP
   > addresses of routers (default gateways), DNS servers, and WIN settings for your new scope. At
   > minimum, you must configure routers and DNS servers before proceeding.

1. On the **Router (Default Gateway)** page, enter the IP address of the Gateway that DHCP clients
   will use and then select **Add**.

1. On the **Domain Name and DNS Servers** page, specify the domain name that clients use for DNS
   name resolution. Specify the DNS servers by typing the hostname or the IP address in the correct
   field. Select **Next**.

1. On the **WINS Servers** page, enter the names and IP addresses of any WINS servers that you use
   in your deployment. If WINS servers aren't present in your deployment, you can select **Next** to
   skip this step.

1. Use the **Activate Scope** page to activate the DHCP scope. Select **Yes, I want to activate this
   scope** to enable your DHCP Server to immediately begin assigning IP addresses to clients. You
   can also activate your new scope at a later time by selecting **No, I will activate this scope
   later**.

1. Select **Finish** to exit the **New Scope Wizard**.

---

## Next steps

- [DHCP Basics](../../../troubleshoot/dynamic-host-configuration-protocol-basics.md)
- [DHCP Subnet selection options](dhcp-subnet-options.md)
