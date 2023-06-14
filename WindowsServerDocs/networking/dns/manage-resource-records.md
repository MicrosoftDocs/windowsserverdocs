---
description: Learn more about how to manage DNS resource records on Windows Server.
title: Manage DNS resource records using DNS server on Windows Server
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.topic: quickstart
ms.date: 06/14/2023
---
# Manage DNS resource records

Create, modify, and delete DNS resource records using the DNS server role in Windows Server. You can
add resource records using DNS manager, using Windows PowerShell, or automatically when
Windows-based, Dynamic Host Configuration Protocol (DHCP) enabled clients join a network using
dynamic update.

Resource records contain the information that a zone maintains about the resources (such as hosts).
Resource record information includes record type, owner name, host address and other information.

## Prerequisites

Before you can manage DNS resource records in Windows Server, you need to complete the following
prerequisites:

- A Windows Server with the DNS Server role installed and configured. See
  [Quickstart: Installing and configure DNS Server](quickstart-install-configure-dns-server.md) for
  more information on how to get stared.
- Determine the type of record you want to create, see
[DNS resource records](resource-record-types.md).
- An account that is a member of the Administrators group, or equivalent.
- You need the fully qualified domain name (FQDN) and the IP address of the resource record you want
  to create.

## Create resource records

You can add resource records to an existing zone using the
[DnsServer](/powershell/module/dnsserver) PowerShell module. Some common resource record types have
other PowerShell commands where you don't need to specify the resource record type. You can
also add the following types of resource records using the DNS Manager console.

The following sections contain steps for creating the following types of resource records:

- Host (A or AAAA)
- Alias (CNAME)
- Mail Exchanger (MX)
- Pointer (PTR)
- Service Locator (SRV)
- Text (TXT)

### Create a host record

To create an IPv4 host (A) record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create an IPv4 host (A) using the
[Add-DnsServerResourceRecord](/powershell/module/dnsserver/Add-DnsServerResourceRecord) PowerShell
command.

To create a host resource record for `Host34` mapped to the IP address `10.17.1.34` for the zone
`contoso.com`, run the following command.

```powershell
Add-DnsServerResourceRecordA -Name "Host34" -ZoneName "Contoso.com" -IPv4Address "10.17.1.34" -TimeToLive 01:00:00
```

You can also add an IPv4 host (A) record using the
[Add-DnsServerResourceRecord](/powershell/module/dnsserver/Add-DnsServerResourceRecord).

#### [GUI](#tab/gui)

Here's how to create an IPv4 host (A) record for `Host32` mapped to the IP address `10.17.1.32` for
the zone `contoso.com` using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, right-click, then select **New Host (A or AAAA)**.

1. On the **New Host** screen, specify the name and IP address of the host record. For example,
   `Host32` and `10.17.1.32`.

1. Select **Add Host** to create the record.

---

### AAAA resource record

To create an IPv6 host (AAAA) record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create an IPv6 host (AAAA) using the
[Add-DnsServerResourceRecordAAAA](/powershell/module/dnsserver/Add-DnsServerResourceRecordAAAA)
PowerShell command.

To add the AAAA resource record `Host36` to map to IPv6 address `3ffe::1`, use the command:

```powershell
Add-DnsServerResourceRecordAAAA -Name "Host36" -ZoneName "contoso.com" -IPv6Address "3ffe::1" -TimeToLive 01:00:00
```

You can also add an IPv6 host (AAAA) record using the
[Add-DnsServerResourceRecord](/powershell/module/dnsserver/Add-DnsServerResourceRecord).

#### [GUI](#tab/gui)

Here's how to create an IPv6 host (AAAA) record for `Host34` mapped to the IPv6 address `3ffe::1` for
the zone `contoso.com` using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, right-click, then select **New Host (A or AAAA)**.

1. On the **New Host** screen, specify the name and IP address of the host record. For example,
   `Host34` and `3ffe::1`.

1. Select **Add Host** to create the record.

---

### CNAME records

To create an alias (CNAME) record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create a CNAME resource record using the
[Add-DnsServerResourceRecordCName](/powershell/module/dnsserver/Add-DnsServerResourceRecordCName)
PowerShell command.

To have the CNAME `labhost34` be created in the `contoso.com` zone and point to the existing DNS
record `Host34.lab.contoso.com`, use the following PowerShell command:

```powershell
Add-DnsServerResourceRecordCName -Name "labhost34" -HostNameAlias "Host34.lab.contoso.com" -ZoneName "contoso.com" -TimeToLive 01:00:00
```

#### [GUI](#tab/gui)

Here's how to create a CNAME resource record for `labhost34` in the `contoso.com` zone, pointing to
the existing DNS record `Host34.lab.contoso.com` using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, right-click, then select **New Alias (CNAME)**.

1. On the **New Resource Record** screen, specify the alias name and FQDN for the target host. For
   example, `labhost34` and `Host34.lab.contoso.com`.

1. Select **OK** to create the resource record.

---

### MX records

To create an MX record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create an MX resource record using the
[Add-DnsServerResourceRecordMX](/powershell/module/dnsserver/Add-DnsServerResourceRecordMX)
PowerShell command.

To add an MX record for the host `mail.contoso.com` with a preference set to `10` for the
`contoso.com` zone, use the following PowerShell command:

```powershell
Add-DnsServerResourceRecordMX -Preference 10 -Name "." -TimeToLive 01:00:00 -MailExchange "mail.contoso.com" -ZoneName "contoso.com"
```

#### [GUI](#tab/gui)

Here's how to create an MX resource record for the host `mail2.contoso.com` with a preference set to
`20` for the `contoso.com` zone using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, right-click, then select **New Mail Exchanger (MX)**.

1. On the **New Resource Record** screen, specify the host or child domain, if applicable, the FQDN
   of the mail server, and the mail server priority. For example, leave the host of child domain
   blank, enter `mail2.contoso.com` for the mail server and `20` for the mail server priority.

1. Select **OK** to create the resource record.

---

### PTR records

To create a PTR record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create a PTR resource record using the
[Add-DnsServerResourceRecordPtr](/powershell/module/dnsserver/Add-DnsServerResourceRecordPtr)
PowerShell command.

To add a pointer record named `host77.contoso.com` for the IP address `192.168.0.77` in the reverse
lookup zone `0.168.192.in-addr.arpa`, use the following PowerShell command:

```powershell
Add-DnsServerResourceRecord -Name "77" -Ptr -ZoneName "0.168.192.in-addr.arpa" -AllowUpdateAny -PtrDomainName "host77.contoso.com"
```

#### [GUI](#tab/gui)

Here's how to create a PTR record named `host77.contoso.com` for the IP address `192.168.0.77` in the reverse
lookup zone `0.168.192.in-addr.arpa` using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Reverse Lookup Zone, right-click, then select **New Pointer (PTR)**.

1. On the **New Resource Record** screen, specify the host IP address, and host name. For example,
   enter `192.168.0.77` for the host IP address and `host77.contoso.com` for the host name.

1. Select **OK** to create the resource record.

---

### SRV records

To create an SRV record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create an SRV resource record using the
[Add-DnsServerResourceRecord](/powershell/module/dnsserver/Add-DnsServerResourceRecord)
PowerShell command.

To add a service locator (SRV) resource record for the `_sip` service on port `5060` with a weight
and priority of `0` for the `contoso.com` domain pointing to `sipserver1.contoso.com`, use the
following PowerShell command:

```powershell
Add-DnsServerResourceRecord -Srv -Name "sip" -ZoneName "contoso.com" -DomainName "sipserver1.contoso.com" -Priority 0 -Weight 0 -Port 5060
```

#### [GUI](#tab/gui)

Here's how to create an SRV resource record for the `_sip` service on port `5060` with a weight and
priority of `0` for the `contoso.com` domain pointing to `sipserver1.contoso.com` using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, right-click, then select **Other New Records**.

1. Select **Service Locator (SRV)** from the list, then select **Create Record**.

1. On the **New Resource Record** screen, specify the service, protocol, priority, weight, port
   number, and host offering this service. For example, enter `_sip` for service, `5060` for the
   port, a weight and priority of `0`, and `sipserver1.contoso.com` as the host.

1. Select **OK** to create the resource record.

---

### TXT records

To create a TXT record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to create a TXT resource record using the
[Add-DnsServerResourceRecord](/powershell/module/dnsserver/Add-DnsServerResourceRecord)
PowerShell command.

To create a TXT record named example with the text value `Example DNS record text` in the
`contoso.com` zone, use the following PowerShell command:

```powershell
$recordtext = “Example DNS record text”
Add-DnsServerResourceRecord -DescriptiveText $recordtext -Name example -zonename contoso.com
```

#### [GUI](#tab/gui)

Here's how to create a TXT record named example with the text value `Example DNS record text` in the
`contoso.com` zone using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, right-click, then select **Other New Records**.

1. Select **Text (TXT)** from the list, then select **Create Record**.

1. On the **New Resource Record** screen, specify the record name and the text value. For example,
   leave the record name as blank to use the `contoso.com` parent domain, then enter the text
   `Example DNS record text`.

1. Select **OK** to create the resource record.

---

## Update resource records

To update a resource record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to modify the time to live (TTL) for a DNS resource record using the
[Get-DnsServerResourceRecord](/powershell/module/dnsserver/Get-DnsServerResourceRecord) and
[Set-DnsServerResourceRecord](/powershell/module/dnsserver/Set-DnsServerResourceRecord) PowerShell
commands.

The following example updates the resource record `host01.contoso.com` so that the TTL is now 2
hours. In this example, you use the **OldInputObject** parameter to specify a resource record object
that you want to change and the **NewInputObject** parameter to specify the updated values.

To update the resource record `host01.contoso.com` so that the TTL is now 2 hours, run the following
PowerShell commands:

```powershell
$OldObj = Get-DnsServerResourceRecord -Name "host01" -ZoneName "contoso.com" -RRType "A"
$NewObj = [ciminstance]::new($OldObj)
$NewObj.TimeToLive = [System.TimeSpan]::FromHours(2)
Set-DnsServerResourceRecord -NewInputObject $NewObj -OldInputObject $OldObj -ZoneName "contoso.com" -PassThru
```

The [Set-DnsServerResourceRecord](/powershell/module/dnsserver/Set-DnsServerResourceRecord)
PowerShell command can't change the **Name** or **Type** of a DNS server resource record object. If
you want to perform those actions, remove the existing resource record and create a new one.

#### [GUI](#tab/gui)

Here's how to modify the time to live (TTL) for a DNS resource record using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. Expand **View** menu from the menu bar, then select **Advanced**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, find and right-click the record, then select **Properties**.

1. On the **Properties** screen, specify the TTL value. For example, enter a TTL of 2 hours in the
   format `0:2:0:0`.

1. Select **OK** to update the resource record.

---

## Remove resource records

To remove a resource record, select the relevant method and follow the steps.

#### [PowerShell](#tab/powershell)

Here's how to remove a DNS resource record using the
[Remove-DnsServerResourceRecord](/powershell/module/dnsserver/Set-DnsServerResourceRecord)
PowerShell command.

To remove the DNS record `example.contoso.com`, run the following command:

```powershell
Remove-DnsServerResourceRecord -name "Example" -Zonename "contoso.com" -RRType A
```

#### [GUI](#tab/gui)

Here's how to remove a record named `example` in the `contoso.com` zone using DNS Manager.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools > DNS**.

1. Expand **View** menu from the menu bar, then select **Advanced**.

1. In the console tree, connect to the DNS server you wish to manage, expand the DNS server, expand
   your Forward Lookup Zone, find and right-click the record, then select **Delete**.

---
