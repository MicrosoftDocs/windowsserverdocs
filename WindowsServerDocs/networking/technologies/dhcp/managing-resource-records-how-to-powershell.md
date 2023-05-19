---
description: Learn more about how to manage DNS resource records in Windows Server
title: DNS resource records 
author: orrinthomas
ms.author: orrinthomas
ms.topic: quickstart
ms.date: 06/01/2023
---
# Manage DNS resource records

Applies to: Windows Server: (All supported versions)

Resource records contain the information that a zone maintains about the resources (such as hosts) that the zone contains. Resource record information includes record type, owner name, host address and other information. See [DNS resource records](managing-resource-records-conceptual.md) to learn more about resource records.

You can add resource records directly, or they can be added automatically when Windows-based, Dynamic Host Configuration Protocol (DHCP)–enabled clients join a network using dynamic update.

Managing of resource records includes creating new records, modifying existing records, and deleting records.

The most common resource records include the following:

- Host (A) resource records: for mapping a Domain Name System (DNS) domain name to an IP address that's used by a computer.
- Alias (CNAME) resource records: for mapping an alias DNS domain name to another primary or canonical name.
- Mail exchanger (MX) resource records: for mapping a DNS domain name to the name of a computer that exchanges or forwards mail.
- Pointer (PTR) resource records: for mapping a reverse DNS domain name that's based on the IP address of a computer that points to the forward DNS domain name of that computer.
- Service location (SRV) resource records: for mapping a DNS domain name to a specified list of DNS host computers that offer a specific type of service, such as Active Directory domain controllers.
- Name server (NS) resource records: for specifying the authoritative name servers for a delegated DNS zone.
- Text (TXT) record. Allows for publication of text in a DNS record.
- Delegation name (DNAME) resource record: Alias for a name and all subnames.
- Start of authority (SOA) resource record. Provides authoritative information about a DNS zone. This includes primary name server, contact of DNZ zone administrator, refresh information and other information.

## Add resource records

You can add resource records to an existing zone using the Add-DNSServerResourceRecord PowerShell cmdlet. Some common resource record types have additional PowerShell cmdlets where you don't need to specify the resource record type. You can also add some resource records using the DNS Manager console by right-selecting on the DNS zone you want to add the resource record to and selecting from one of the following options and completing the entries in the dialog box:

- New Host (A or AAAA)
- New Alias (CNAME)
- New Mail Exchanger (MX)
- New Domain
- New Delegation
- Other New Records

### Host record

Host records map DNS names to IPv4 addresses. To add a host record use the Add-DnsServerResourceRecord cmdlet with the -A parameter. For example, to add the host resource record Host34 mapped to IP address 10.17.1.34 to zone contoso.com, use the command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecord -ZoneName "Contoso.com" -A -Name "Host34" -AllowUpdateAny -IPv4Address "10.17.1.34" -TimeToLive 01:00:00 -AgeRecord
```

#### [GUI](#tab/gui)

You can also add a host record using the Add-DnsServerResourceRecordA cmdlet. For example, to add the record Host35 mapped to IP address 172.18.99.35 to zone contoso.com, use the command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecordA -Name "Host35" -ZoneName "contoso.com" -AllowUpdateAny -IPv4Address "172.18.99.35" -TimeToLive 01:00:00
```

#### [GUI](#tab/gui)

### AAAA resource record

AAAA resource records map DNS names to IPv6 addresses. To add a AAAA resource record use the Add-DNSServerResourceRecord cmdlet with the -AAAA parameter. For example, to add the AAAA resource record Host36 to map to IPv6 address 3ffe::1

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecord -AAAA -Name "Host36" -ZoneName "Contoso.com" -AllowUpdateAny -IPv6Address "3ffe::1" -TimeToLive 01:00:00 -AgeRecord
```
#### [GUI](#tab/gui)

As an alternative you can use the Add-DnsServerResourceRecordAAA cmdlet to map DNS names to IPv6 addresses. For example, to add the AAAA resource record Host36 to map to IPv6 address 3ffe::1

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecordAAAA -Name "Host37" -ZoneName "contoso.com" -AllowUpdateAny -IPv6Address "3ffe::1" -TimeToLive 01:00:00
```
#### [GUI](#tab/gui)

### CNAME records

Alias (CNAME) resource records are also termed canonical name resource records. With these records, you can use more than one DNS name to point to a single host. You can create CNAME records with the Add-DNSServerResourceRecord cmdlet with the -CNAME parameter. For example, to have the CNAME labhost34 be created in the contoso.com zone and point to the existing DNS record Host34.lab.contoso.com use the following PowerShell command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecord -CName -Name "labhost34" -HostNameAlias "Host34.lab.contoso.com" -ZoneName "Contoso.com" -AllowUpdateAny -TimeToLive 01:00:00
```

#### [GUI](#tab/gui)

You can also use the Add-DnsServerResourceRecordCName cmdlet to add CNAME records to a DNS zone. For example, to add the CNAME record labsvr1 to the contoso.com zone pointing at the existing DNS record srv1.lab.contoso.com, use the PowerShell command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecordCName -Name "labsrv1" -HostNameAlias "srv1.lab.contoso.com" -ZoneName "contoso.com"
```
#### [GUI](#tab/gui)

### MX records

E-mail applications use the mail exchanger (MX) resource record to locate a mail server based on a DNS domain name in the destination address for the e-mail recipient of a message. If multiple mail exchanger (MX) resource records exist, the DNS Client service attempts to contact mail servers in the order of preference from lowest value (highest priority) to highest value (lowest priority). You add MX records using the Add-DnsServerResourceRecord cmdlet and specifying the -MX parameter. For example, to add a MX record with preference set to 10 to the contoso.com zone that points to host mail.contoso.com, use the command:

#### [PowerShell](#tab/powershell)
```
Add-DnsServerResourceRecord -Name "." -MX -ZoneName "contoso.com" -MailExchange "mail.contoso.com" -Preference 10
```
#### [GUI](#tab/gui)

You can also use the Add-DnsServerResourceRecordMX cmdlet to perform this task. For example, to add a MX record with preference set to 20 to the contoso.com zone that points to host mail2.contoso.com, use the command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecordMX -Preference 20 -Name "." -TimeToLive 01:00:00 -MailExchange "mail2.contoso.com" -ZoneName "contoso.com"
```
#### [GUI](#tab/gui)

### PTR records

Pointer (PTR) resource records support the reverse lookup process, based on zones that are created and rooted in the in-addr.arpa domain. You need to have the appropriate reverse lookup zone present on your DNS server to create a PTR record that maps an IP address to a specific hostname. You create PTR records by using the Add-DnsServerResourceRecord cmdlet with the -PTR parameter. For example to add a pointer record named host77.contoso.com for the IP address 192.168.0.77 to the reverse lookup zone 0.168.192.in-addr.arpa use the command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecord -Name "77" -Ptr -ZoneName "0.168.192.in-addr.arpa" -AllowUpdateAny -PtrDomainName "host77.contoso.com"
```
#### [GUI](#tab/gui)

### SRV records

Service location (SRV) resource records are required when clients use DNS to locate location services such as Active Directory domain controllers. You can use the Add-DnsServerResourceRecord cmdlet with the SRV parameter to add a SRV resource record to a DNS zone. For example, to add a service locator (SRV) resource record for the \_sip service on port 5060 with a weight and priority of 0 to the contoso.com domain pointing to sipserver1.contoso.com use the command:

#### [PowerShell](#tab/powershell)

```
Add-DnsServerResourceRecord -Srv -Name "sip" -ZoneName "contoso.com" -DomainName "sipserver1.contoso.com" -Priority 0 -Weight 0 -Port 5060
```
#### [GUI](#tab/gui)

### TXT records

Text records allow you to add text information that can be returned by querying DNS. TXT records are often used to authenticate ownership of DNS zones. To create a TXT record use the Add-DnsServerResourceRecord cmdlet with both the -txt parameter and the DescriptiveText parameters. For example, to create a TXT record named example with the text value “Example DNS record text” in the contoso.com zone use the following PowerShell commands:

#### [PowerShell](#tab/powershell)

```
$recordtext = “Example DNS record text”
Add-DnsServerResourceRecord -DescriptiveText $recordtext -Name example -zonename contoso.com
```
#### [GUI](#tab/gui)

### Managing DNS Resource Records

You can use the Get-DnsServerResourceRecord command to view all of the DNS records in a specific zone or the properties of a specific resource record. For example, to view all the resource records associated with the contoso.com DNS zone, use the command:

#### [PowerShell](#tab/powershell)

```
Get-DnsServerResourceRecord contoso.com
```
#### [GUI](#tab/gui)

To view the properties of a specific DNS resource record, use the -Name and the -ZoneName parameters. For example to view the properties of the dc1.contoso.com resource record, use the command:

#### [PowerShell](#tab/powershell)

```
Get-DnsServerResourceRecord -name dc1 -zonename contoso.com
```
#### [GUI](#tab/gui)

You can use the Set-DnsServerResourceRecord cmdlet to modify an existing DNS server resource record. You can use the OldInputObject parameter to specify a resource record object that you want to change and NewInputObject to specify a new resource record.

For example, to update the resource record host01.contoso.com so that the TTL is now 2 hours, run the following commands:

#### [PowerShell](#tab/powershell)

```
$OldObj = Get-DnsServerResourceRecord -Name "Host01" -ZoneName "contoso.com" -RRType "A"
$NewObj = [ciminstance]::new(\$OldObj)
$NewObj.TimeToLive = [System.TimeSpan]::FromHours(2)
Set-DnsServerResourceRecord -NewInputObject $NewObj -OldInputObject $OldObj -ZoneName "contoso.com" -PassThru
```

#### [GUI](#tab/gui)

The Set-DnsServerResourceRecord cmdlet can't change the Name or Type of a DNS server resource record object. If you want to perform those actions, it's simpler to remove the existing resource record and create a new one. You remove a DNS record using the Remove-DnsServerResourceRecord cmdlet. For example, to remove the DNS record example.contoso.com use the following command:

#### [PowerShell](#tab/powershell)

```
Remove-DnsServerResourceRecord -name Example -Zonename "contoso.com" -RRType A
```
#### [GUI](#tab/gui)

## Related links

- [DNS resource records ](managing-resource-records-conceptual.md)