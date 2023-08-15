---
title: Install and configure DHCP Server on Windows Server
description: Get started installing a Windows Server DHCP server to automatically provide IP addresses and DHCP options to clients connected to one or more subnets on your network.
ms.topic: quickstart
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.date: 08/11/2023
---

# Quickstart: Install and configure DHCP Server

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This quickstart shows you how to install a Dynamic Host Configuration Protocol (DHCP) server on
Windows Server. You'll install the DHCP Server role, authorize the server in your Active Directory
domain, and configure a scope to automatically assign DHCP IP addresses and options to IPv4 DHCP
clients.

## Prerequisites

Before you can install your DHCP server, you must meet the following prerequisites:

- A computer running a supported version of Windows Server.
- A static IPv4 address.
- An IP address range for your DHCP scope.
- An account that's a member of the Administrators group, or equivalent.

## Install the DHCP Server

Installing the DHCP Server involves adding the DHCP Server role to an existing Windows Server server.

To install the DHCP Server role as a standalone server, perform the following steps:

#### [PowerShell](#tab/powershell)

Here's how to install DHCP using the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature) command.

1. Run PowerShell on your computer in an elevated session.

1. Run the following command:

   ```powershell
   Install-WindowsFeature DHCP -IncludeManagementTools
   ```

  The installation doesn't require a reboot.

#### [GUI](#tab/gui)

Here's how to install the DHCP Server role using Server Manager from the Windows desktop:

1. From the Windows desktop, open the **Start** menu, then select **Server Manager**.

1. On the menu, go to **Manage**, then select **Add Roles and Features**.

1. On the **Before you begin** page, select **Next**.

1. On the **Select installation type** page, select the **Role-based or feature-based installation** option, then select **Next**.

1. On the **Select destination server** page, leave the default options, then select **Next**.

1. On the **Select server roles** page, select the **DHCP Server** checkbox, and then select **Next**.

    1. You're prompted to add features that are required for DHCP Server. If you're happy with the default settings, select **Add Features**.

1. On the **Select features** page, leave the default selections as-is, then select **Next**.

1. On the **DHCP Server** page, review the role description and things to note. When you're finished, select **Next**.

1. On the **Confirm installation selections** page, review the selected roles and features. When you're finished, select **Install** to begin the installation process.

1. Once the installation is complete, select **Close**. The installation doesn't require a reboot.

---

## Configure DHCP server

After you have successfully installed the DHCP Server role, you need to authorize and configure your DHCP server.

### Authorize the DHCP server in Active Directory

If you're installing DHCP in a domain environment, you must perform the following steps to authorize the DHCP server to operate in the domain.

> [!NOTE]
> Unauthorized DHCP servers that are installed in Active Directory domains can't function properly and don't lease IP addresses to DHCP clients. The automatic disabling of unauthorized DHCP servers is a security feature that prevents unauthorized DHCP servers from assigning incorrect IP addresses to clients on your network.

To authorize your DHCP server in a domain environment:

#### [PowerShell](#tab/powershell)

1. Run the following command to add the DHCP server to the list of authorized DHCP servers in Active Directory.

   > [!NOTE]
   > If you don't have a domain environment, don't run this command.

   ```powershell
   Add-DhcpServerInDC -DnsName DHCP1.corp.contoso.com -IPAddress 10.0.0.3
   ```

1. To verify that the DHCP server is authorized in Active Directory, run the following command:

   ```powershell
   Get-DhcpServerInDC
   ```

   The following example shows the output you should see in Windows PowerShell.

   ```powershell
   IPAddress     DnsName
   ---------     -------
   10.0.0.3      DHCP1.corp.contoso.com
   ```

For more information about these commands, see the following articles:

- [Add-DhcpServerInDC](/powershell/module/dhcpserver/add-dhcpserverindc)
- [Get-DhcpServerInDC](/powershell/module/dhcpserver/get-dhcpserverindc)

#### [GUI](#tab/gui)

To authorize the DHCP server using Active Directory:

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools** > **DHCP**.
1. Expand your DHCP server name, right-click, then select **Authorize**.
1. Authorization can take a few seconds to resolve. Refresh the server list to confirm that the DHCP Server is now authorized. If authorized, a green icon should appear in each scope.

---

### Configure an IPv4 scope

After you have successfully authorized your DHCP Server, you can proceed to create a new DHCP scope.
Scopes are used to indicate the range of IP addresses for your DHCP server and its clients. To learn
more about planning your scope ranges, see [DHCP scopes](dhcp-scopes.md)for guidance.

To create a new IPv4 DHCP scope, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create a new scope using the [Add-DhcpServerv4Scope](/powershell/module/dhcpserver/add-dhcpserverv4scope) PowerShell command.

1. Run PowerShell on your computer in an elevated session.

1. To configure a new DHCP scope named `Contoso network` with a range from `10.10.10.100` to `10.10.10.200` and a subnet mask of `255.255.255.0`, run the following command.

   ```powershell
   Add-DhcpServerv4Scope -Name "Contoso network" -StartRange 10.10.10.100 -EndRange 10.10.10.200 -SubnetMask 255.255.255.0
   ```

#### [GUI](#tab/gui)

Here's how to create a new DHCP scope using the DHCP console.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools** > **DHCP**.

1. Expand the name of the DHCP Server, right-select **IPv4**, and then select **New Scope**.

1. On the **New Scope Wizard** welcome page, select **Next**.

1. On the **Scope Name** page, in the Name field, type the name of your new scope and select **Next**.

1. On the **IP Address Range page**, specify the range of IP addresses for your DHCP clients and specify the subnet mask, using your preferred method, select **Next**.

1. On the **Add Exclusions and Delay** page, specify any addresses or range of addresses that you don't want the server to distribute, select **Next**.

1. On the **Lease Duration** page, specify the lifespan for the IP addresses assigned to each DHCP client, select **Next**.

1. On the **Configure DHCP Options** page, select **Yes, I want to configure these options now** and then select **Next**.

   > [!TIP]
   > The **Configure DHCP Options** page lets you configure common DHCP options including IP addresses of routers (default gateways), DNS servers, and WIN settings for your new scope. At minimum, you must configure routers and DNS servers before proceeding.

1. On the **Router (Default Gateway)** page, enter the IP address of the Gateway that DHCP clients should use, then select **Add**.

1. On the **Domain Name and DNS Servers** page, specify the domain name that clients use for DNS name resolution. Specify the DNS servers by typing the hostname or the IP address in the correct field. Select **Next**.

1. On the **WINS Servers** page, enter the names and IP addresses of any WINS servers that you use in your deployment. If WINS servers aren't present in your deployment, you can select **Next** to skip this step.

1. Use the **Activate Scope** page to activate the DHCP scope. Select **Yes, I want to activate this scope** to enable your DHCP Server to immediately begin assigning IP addresses to clients. You can also activate your new scope at a later time by selecting **No, I will activate this scope later**.

1. Select **Finish** to exit the **New Scope Wizard**.

---

### Managing scope options

After configuring your new scope, you can manage scope options using either the DHCP console or PowerShell.

#### [PowerShell](#tab/powershell)

You can modify DHCP scope options using PowerShell with the **Set-DhcpServerv4OptionValue** cmdlet. For example, to set the DNS server option for the scope `192.168.15.0` and set the DNS servers to `192.168.15.10` and `192.168.15.11`, run the following command:

```powershell
Set-DhcpServerv4OptionValue -ScopeId 192.168.15.0 -OptionId 6 -Value "192.168.15.10", "192.168.15.11"
```

#### [GUI](#tab/gui)

To modify scope options in the DHCP console:

1. In the DHCP console when connected to the DHCP server you wish to manage, expand the IPv4 node, then expand the scope with the options you wish to modify.

1. Select the **Scope Options** node.

1. Right-click on **Scope Options**, then select **Configure Options**.

1. Select the option you want to configure from the list of options.

   - To enable or disable a setting, select the checkbox and configure the option.
   - To configure the properties of an existing option, right-click on the option, then select **Properties**.

---

### Managing reservations

With client reservations, you can reserve an IP address for permanent use by a DHCP client. Reservations are stored using a network interface card's (NIC) MAC address and ensure that the DHCP server exclusively leases a specific IP address to a specific MAC address.

#### [PowerShell](#tab/powershell)

You can create reservations using the **Add-DhcpServerv4Reservation** PowerShell cmdlet. For example, to add a reservation to a DHCP scope with a scope ID of `192.168.15.0`, an IP address of `192.168.15.100`, and the MAC address `00-11-22-33-44-55`, run the following PowerShell command:

```powershell
Add-DhcpServerv4Reservation -ScopeId 192.168.15.0 -IPAddress 192.168.15.100 -ClientId "00-11-22-33-44-55" 
```

#### [GUI](#tab/gui)

To convert an existing DHCP lease to a reservation using the DHCP console, right-click the lease in the **Address Leases** node of a specific Scope and then select **Add to Reservation**.

To create a new reservation for a specific scope, right-click the **Reservations** node of a scope, then select **New Reservation**. You then need to provide a name for the reservation, IP address, and the MAC address associated with the host's NIC.

---

### Managing exclusions

Here's how to manage exclusion ranges in DHCP server.

#### [PowerShell](#tab/powershell)

You can run the **Add-DhcpServerv4ExclusionRange** cmdlet to add an exclusion range to a DHCP scope using PowerShell. For example, to add the exclusion range `192.168.15.1` to `192.168.15.10` to the scope `192.168.15.0`, run the following command:

```powershell
Add-DhcpServerv4ExclusionRange -ScopeId 192.168.15.0 -StartRange 192.168.15.1 -EndRange 192.168.15.10
```

#### [GUI](#tab/gui)

To manage exclusions using the DHCP console:

1. Open the DHCP console.
1. In the console tree, select **Address Pool**.
1. On the **Action** menu, select **New Exclusion Range**.
1. In the Add Exclusion dialog box, in **Start IP address**, enter the first address in the range you want to exclude from this scope.
1. To exclude a range of more than one IP address, enter last address in the range in **End IP address**.
1. Select **Add**.

---

## Next steps

- [DHCP Basics](../../../troubleshoot/dynamic-host-configuration-protocol-basics.md)
- [DHCP Subnet selection options](dhcp-subnet-options.md)
