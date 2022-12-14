---
title: Installing and configure DNS Servers
description: Get started installing and configuring a DNS server on Windows Server using PowerShell or Server Manager. 
author: robinharwood
ms.author: roharwoo
ms.topic: quickstart
ms.date: 12/14/2022
ms.custom: template-quickstart
---

# Quickstart: Installing and configure DNS Servers

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This quickstart shows you how to install and configure a DNS Server on Windows Server. You'll
install a DNS server to forward DNS queries to DNS root hint name servers, or optionally to an
upstream name server.

## Prerequisites

Before you can install and configure your DNS Server, your computer must meet the following
prerequisites:

- A computer running a support version of Windows Server.
- A static IP.
- An account that is a member of the Administrators group, or equivalent.

## Installing DNS Servers

Installing a Domain Name System (DNS) server involves adding the DNS server role to an existing
Windows Server server.

> [!TIP]
> When you install Active Directory Domain Services (AD DS) with the Active Directory Domain
> Services Installation Wizard, the wizard gives you the option to automatically install and
> configure a DNS server. The resulting DNS zone is integrated with the AD DS domain namespace. To
> learn more, see
> [Understanding Active Directory Domain Services Integration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc726034(v=ws.11)).

To install the DNS Server role as a standalone server, perform the following steps:

#### [PowerShell](#tab/powershell)

Here's how to install the DNS server role using the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature?view=windowsserver2022-ps) command.

1. Run PowerShell on your computer in an elevated session.

1. To install the DNS role, run the following command.

   ```powershell
   Install-WindowsFeature -Name DNS
   ```

#### [GUI](#tab/gui)

Here's how to install the DNS server role using Server Manager from the Windows desktop.

1. From the Windows desktop, open the **Start** menu, then select the **Server Manager** tile.

1. On the menu, go to **Manage**, and then select **Add Roles and Features**.

1. On the **Before you begin** page, select **Next** to begin.

1. On the **Select installation type** page, select the **Role-based or feature-based
   installation** option, and select **Next**.

1. On the **Select destination server** page, leave the default options. Select **Next**.

1. On the **Select server roles** page, select the **DNS Server** checkbox, and then select on the
   **Next** button.

    1. You'll be prompted to add features that are required for DNS Server, if you're happy with the defaults, select **Add Features**.

1. On the **Select features** page, you can leave the default selections, and then select on the
   **Next** button.

1. On the **DNS Server** page, review the role description and things to note, select **Next** to
   continue.

1. On the **Confirm installation selections** page, review the selected roles and features, and then
   select on the **Install** button to begin the installation process.

1. Once the installation is complete, select **Close**.

---

## Configuring DNS Servers

Now you've installed the DNS server role, you can configure the server.

### Configure DNS server interface

By default a DNS server will listen for requests on all IP address interfaces. You can configure DNS
server to listen on a specify interface using the GUI or by using the `Set-DNSServerListenAddress`
PowerShell cmdlet.

### [PowerShell](#tab/powershell)

FIXME: This command doesn't exist and Set-DNSServerSetting only takes a CIMinstance, which also
doesn't work

Here's how to configure the interface used to listen for DNS requests using the
Set-DNSServerListenAddress command.

For example to configure a DNS server to listen on IP address `10.10.10.100` use the command:

1. Run PowerShell on your computer in an elevated session.

1. Find existing network adapters by running the
   [Get-NetAdapter](/powershell/module/netadapter/get-netadapter) cmdlet. Identify the interface
   alias that you want to use for your DNS server.

    ```powershell
    (Get-NetAdapter).InterfaceAlias
    ```

1. To install the DNS role, run the following command.

   ```powershell
   Set-DNSServerListenAddress -InterfaceAlias "Ethernet" -IPAddress "10.10.10.100"
   ```

#### [GUI](#tab/gui)

Here's how to configure the interface used to listen for DNS requests using the DNS Manager console.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. Select and hold (or right-click) your server, and then select **Properties**.

1. To limit the DNS server to use a specific IP address, select **Only the following IP address**,
   select the IP address you wish to use, and then select **OK**.

---

### Configure Root Hints

Root hints servers are used to help resolving DNS address information when the DNS server is
unable to resolve the query locally from a hosted zone or the DNS Server cache.

You can edit the list of root name servers on the Root Hints tab of the DNS Server properties dialog
box or by using the `dnscmd.exe` command line utility. To learn more, review the [Dnscmd](../../administration/windows-commands/dnscmd.md) command reference.

#### [dnscmd](#tab/dnscmd)

1. Run PowerShell on your computer in an elevated session.

1. To add a server to the list of root hints servers using the command below. Replace the placeholder
   `<DNS_server_name>` with the name of your DNS server. Replace the placeholder
   `<IP_address>` with the root hint server IP and `<FQDN>` the root hint server fully qualified
   domain name.

   ```powershell
   dnscmd <DNS_server_name> /addroothint <IP_address> <FQDN>
   ```

1. To verify the currently configured list of root hints servers, run the following command. Replace
   the placeholder `<DNS_server_name>` with the name of your DNS server.

   ```powershell
   dnscmd <DNS_server_name> /enumroot
   ```

#### [GUI](#tab/gui)

Here's how to root hints using the DNS Manager console.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. Select and hold (or right-click) your server, and then select **Properties**.

1. Select the **Root Hints** tab, select the item to edit, and then select **Edit**.

1. Enter the fully qualified domain name, then select **Resolve**. Verify the IP address, and if
   necessary edit the IP address.

1. Select **OK**.

1. Review the updated root hint server in the list, when you're ready select **OK**.

---

### Configure DNS Server Forwarders

You can optionally configure a forwarder to resolve DNS address information rather than forwarding
traffic to the DNS root servers. You can add forwarders using the GUI or by using the
`Set-DNSServerForwarder` PowerShell cmdlet.

> [!NOTE]
> DNS root hints not be used unless your forwarders fail to respond.

### [PowerShell](#tab/powershell)

Here's how to install the DNS server role using the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature?view=windowsserver2022-ps) command.

For example to configure a DNS server to use DNS servers as `192.168.10.10` and `192.168.10.11` as
forwarders, use the commands:

```powershell
$forwarders = "192.168.10.10","192.168.10.11"
Set-DnsServerForwarder -IPAddress $forwarders
```

#### [GUI](#tab/gui)

Here's how to configure DNS forwarders using the DNS Manager console.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. Select and hold (or right-click) your server, and then select **Properties**.

1. Select the **Forwarders** tab, then select **Edit**.

1. Enter the IP address of the DNS server to forward requests to. Repeat this step as many times as
   you need.

1. Select **OK**.

1. Review the DNS server in the list, select **OK** or **Apply** to complete your configuration.

---

## Removing the DNS Server role

To remove the DNS Server role, perform the following steps.

### [PowerShell](#tab/powershell)

Here's how to uninstall the DNS server role using the [Uninstall-WindowsFeature](/powershell/module/servermanager/uninstall-windowsfeature?view=windowsserver2022-ps) command.

1. In an elevated PowerShell prompt, run the following command:

   ```powershell
   Uninstall-WindowsFeature -Name DNS
   ```

#### [GUI](#tab/gui)

Here's how to uninstall the DNS server role using Server Manager from the Windows desktop.

1. From the Windows desktop, open the **Start** menu, then select the **Server Manager** tile.
1. On the menu, go to **Manage**, and then select **Remove Roles and Features**.
1. On the **Before you begin** page, Select **Next** to begin.
1. On the **Select destination server** page, select the server that you want to remove the DNS
   server role service from, then select **Next**.
1. From the list, clear the **DNS Server** checkbox.
      1. You'll be prompted to remove features that require DNS Server, select **Remove Features**,
         then **Next** to continue.
1. On the **Remove features** page, you can leave the default selections, and then select on the
   **Next** button.
1. On the **Confirm removal selections** page, review the selected roles and features, and then
   select on the **Remove**.
1. Once the role and feature is removed, select **Close**.

---

When removing the DNS server role service from a Windows Server computer be aware:

- For a DNS server that hosts AD DS-integrated zones, these zones are saved or deleted
  according to their storage type. The zone data isn't deleted unless the DNS server that you
  uninstall is the last DNS server hosting that zone.
- For a DNS server that hosts standard DNS zones, the zone files remain in the
  _%systemroot%\system32\Dns_ directory, but they aren't reloaded if the DNS server is reinstalled.
  If you create a new zone with the same name as an old zone, the old zone file is replaced with the
  new zone file

## Next steps

Now you've installed and configured a DNS server, here are some articles that might help you to do
more.

- [DNS Policies Overview](deploy/DNS-Policies-Overview.md)
- [Anycast DNS overview](deploy/anycast.md)
