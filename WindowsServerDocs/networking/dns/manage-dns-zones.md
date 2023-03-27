---
title: Manage DNS zones using DNS server in Windows Server
description: Learn how to create DNS zones and manage them with DNS server in Windows Server using PowerShell and the DNS Manager console.
author: robinharwood
ms.author: wscontent
ms.topic: how-to 
ms.date: 03/23/2023
ms.custom: template-how-to #Required; leave this attribute/value as-is.
# Customer intent: As a DNS administrator, I want create DNS zones, so that my systems
# can perform name resolution.
---

# Manage DNS zones using DNS server in Windows Server

In this article you will see how to create primary, secondary, stub, and reverse DNS zones using the
DNS server role in Windows Server. The article also shows you how to configure zone transfer
settings and perform zone delegation.

## Prerequisites

Before you can manage DNS zone in Windows Server, you'll need to complete the following
prerequisites:

- A Windows Server with the DNS Server role installed and configured. See
  [Quickstart: Installing and configure DNS Server](quickstart-install-configure-dns-server.md) to
  found out how to get stared.
- Determine the type of zone you want to create, see [DNS zones](zone-types.md) to learn more.
- An account that is a member of the Administrators group, or equivalent.
- You'll need the fully qualified domain name (FQDN) of the zone you want to create.
- If you want to create a secondary or stub zone, you'll need the IP address of the DNS server(s)
  hosting the primary zone.

### Create a primary zone

#### Create an Active Directory integrated primary zone

To create an Active Directory integrated primary zone, select the relevant method and follow the
steps.

#### [PowerShell](#tab/powershell)

Here's how to create an Active Directory Integrated DNS zone with the replication scope set to all
DNS servers hosted on AD DS domain controllers in the forest using the
[Add-DnsServerPrimaryZone](/powershell/module/dnsserver/add-dnsserverprimaryzone) PowerShell
command.

```powershell
Add-DnsServerPrimaryZone -Name "west.contoso.com" -ReplicationScope "Forest" -PassThru
```

#### [GUI](#tab/gui)

Here's how to create a forward look up zone using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, expand a DNS server then right-click, then select **New Zone**.

1. On the New Zone Wizard page, select **Next**.

1. On the Zone Type page, select **Primary zone** and ensure **Store the zone in Active Directory**
   is checked. This option will only be available of the DNS server is also an AD DS domain
   controller.

1. On the Active Directory Zone Replication Scope page, choose one of the following options:

      - All DNS servers running on AD DS domain controllers in the forest.
      - All DNS servers running on AD DS domain in the domain.
      - All domain controllers in this domain (for Windows 2000 compatibility).
      - All domain controllers enrolled in a specific directory partition.

1. On the Forward or Reverse Lookup Zone page, select **Forward lookup zone**.

1. On the zone name page, specify the name of the DNS zone. For example `west.contoso.com`

1. On the Dynamic Update page, choose one of the following options:

      - Allow only secure dynamic updates (recommended for Active Directory).
      - Allow both nonsecure and secure dynamic updates.
      - Do not allow dynamic updates.

1. Select **Finish** to complete the New Zone Wizard.

#### Create a file based primary zone

To create an file based primary zone, select the relevant method and follow the
steps.

#### [PowerShell](#tab/powershell)

Here's how to create an file based DNS zone using the
[Add-DnsServerPrimaryZone](/powershell/module/dnsserver/add-dnsserverprimaryzone) PowerShell
command.

To add the file based DNS zone `west02.contoso.com` using the file `west02.contoso.com.dns`, run the
following command on a computer with the DNS server role installed:

```powershell
Add-DnsServerPrimaryZone -Name "west02.contoso.com" -ZoneFile "west02.contoso.com.dns"
```

#### [GUI](#tab/gui)

To create a primary zone:

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, right-click a DNS server, and then click New Zone to open the New Zone
   Wizard.

1. On the Zone Type page, select Primary zone and ensure Store the zone in Active Directory is not
   selected. This option will only be available of the DNS server is also an AD DS domain
   controller.

1. On the Forward or Reverse Lookup Zone page, select Forward lookup zone.

1. On the zone name page, specify the name of the DNS zone. For example east.contoso.com

1. On the Zone File page you will be provided with the option to specify a new file name, with the
   default being the zone name with the .dns extension. For example east.contoso.com.dns. You can
   also use an existing zone file that has been copied to the `%SystemRoot%\system32\dns` folder on
   the DNS server.

1. On the Dynamic Update page select whether to allow nonsecure and secure dynamic updates, or to
   not allow dynamic updates. The default is to not allow dynamic updates.

1. Click Finish to complete the New Zone Wizard.

---

### Create a secondary zone

To create a secondary zone, perform the following steps:

#### [PowerShell](#tab/powershell)

To add the secondary zone western.contoso.com using the zone file name `western.contoso.dns` and
using the primary zone server at IP address `172.23.90.124` use the following command:

```powershell
Add-DnsServerSecondaryZone -Name "western.contoso.com" -ZoneFile "western.contoso.com.dns" -MasterServers 172.23.90.124
```

#### [GUI](#tab/gui)

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, right-click a DNS server, and then click New Zone to open the New Zone
   Wizard.

1. On the Zone Type page, select Secondary zone.

1. On the Forward or Reverse Lookup Zone page, select Forward lookup zone.

1. On the Zone Name page, specify the name of the secondary zone. This must match the name of the
   primary zone you will replicate from.

1. On the Master DNS Servers page, specify the IP addresses of one or more DNS servers that host
   copies of the primary zone. You will need to ensure that the primary zone allows transfers to the
   DNS server that will host the secondary zone.

1. Click Finish on the Completing the New Zone Wizard.

---

### Create a stub zone

To create a stub zone, perform the following steps:

#### [PowerShell](#tab/powershell)

You add a stub zone using the Add-DnsServerStubZone PowerShell cmdlet. For example, to add a stub
zone for the `east02.contoso.com` zone using the authoritative DNS server `172.23.90.124`, run the
following command:

```powershell
Add-DnsServerStubZone -Name "east02.contoso.com" -MasterServers "172.23.90.124" -PassThru -ZoneFile "east02_contoso.dns"
```

#### [GUI](#tab/gui)

DNS Console:

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, right-click a DNS server, and then click New Zone to open the New Zone
   Wizard.

1. On the Zone Type page, select Stub zone. If the DNS server is also an AD DS domain controller,
   you will have the option to store the in Active Directory is selected.

1. If you have chosen to store the zone data in AD DS, you will be able to choose whether to
   replicate to all DNS servers running on AD DS domain controllers in the forest, all AD DS servers
   running on domain controllers in the domain, or the Windows 2000 compatibility replication scope.
   The default is to replicate to all DNS servers running on AD DS domain controllers in the domain.

1. Specify the zone name. This is the name of the remote zone that you which hosts the authoritative
   name servers you wish to store on your local DNS server.

1. On the Master DNS Servers provide the IP address of a DNS server that is authoritative for the
   target zone.

1. Click Finish on the Completing the New Zone Wizard.

---

### Create a reverse lookup zone

To create a reverse lookup zone, perform the following steps:

#### [PowerShell](#tab/powershell)

Add a reverse lookup zone using the Add-DnsServerPrimaryZone PowerShell cmdlet you specify the IP
address range using CIDR notation. For example, to add the reverse lookup zone for the `10.1.0.0/24`
IPv4 address range, run the following command:

```powershell
Add-DnsServerPrimaryZone -NetworkID "10.1.0.0/24" -ReplicationScope "Forest"
```

WAC:

#### [GUI](#tab/gui)

DNS Console:

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, right-click a Domain Name System (DNS) server, and then click New Zone to
   open the New Zone Wizard.

1. On the Zone Type page, select Primary zone and ensure Store the zone in Active Directory is
   selected. This option will only be available of the DNS server is also an AD DS domain
   controller.

1. On the Active Directory Zone Replication Scope page, choose between replicating between all DNS
   servers running on AD DS domain controllers in the forest, all DNS servers running on AD DS
   domain in the domain, all domain controllers in this domain (for Windows 2000 compatibility) or
   all domain controllers enrolled in a specific directory partition. The default is to all DNS
   servers running on domain controllers in the domain that the AD DS domain controller is a member
   of.

1. On the Forward or Reverse Lookup Zone page, select Reverse lookup zone.

1. On the Reverse Lookup Zone Name page, select IPv4 Reverse Lookup Zone.

1. On the Network ID page, enter the network ID in the normal (not the reversed) order. For example
   for network `192.168.220.0/24` enter the network ID as `192.168.220`, The in-addr.arpa will
   automatically be appended to the zone name by the DNS server service.

1. On the Dynamic Update page, select whether to allow only secure dynamic updates, nonsecure and
   secure dynamic updates, or to not allow dynamic updates. The default is only to allow secure
   dynamic updates.

1. Click Finish to complete the New Zone Wizard.

---

## Configure zone transfer settings

#### [PowerShell](#tab/powershell)

```powershell

```

#### [GUI](#tab/gui)

You can use the following procedure to control whether a zone will be transferred to other servers
and which servers can receive the zone transfer.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. Right-click a DNS zone, and then click Properties.

1. On the Zone Transfers tab, do one of the following:

   1. To disable zone transfers, clear the Allow zone transfers check box.

   1. To allow zone transfers, select the Allow zone transfers check box.

1. If you allowed zone transfers, do one of the following:

   1. To allow zone transfers to any server, click To any server.

   1. To allow zone transfers only to the DNS servers that are listed on the Name Servers tab, click
      Only to servers listed on the Name Servers tab.

   1. To allow zone transfers only to specific DNS servers, click Only to the following servers, and
      then add the IP address of one or more DNS servers.

---

## Perform zone delegation

To create a zone delegation using PowerShell perform the following steps:

#### [PowerShell](#tab/powershell)

```powershell

```

#### [GUI](#tab/gui)

To create a zone delegation using the Windows interface use the following steps:

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, right-click the applicable subdomain, and then click New Delegation.

1. Follow the instructions in the New Delegation Wizard to finish creating the new delegated domain.

All domains (or subdomains) that appear as part of the applicable zone delegation must be created in
the current zone before delegation is performed as described here. As necessary, use DNS Manager to
first add domains to the zone before you complete this procedure.

---

## Next steps
<!-- Add a context sentence for the following links -->
- [Write how-to guides](contribute-how-to-write-howto.md)
- [Links](links-how-to.md)
