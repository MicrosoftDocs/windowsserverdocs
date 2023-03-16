---
title: #Required; page title is displayed in search results. Include the brand.
description: #Required; article description that is displayed in search results. 
author: #Required; your GitHub user alias, with correct capitalization.
ms.author: #Required; microsoft alias of author; optional team alias.
ms.service: #Required; service per approved list. slug assigned by ACOM.
ms.topic: how-to #Required; leave this attribute/value as-is.
ms.date: #Required; mm/dd/yyyy format.
ms.custom: template-how-to #Required; leave this attribute/value as-is.
---

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.
-->

<!--
This template provides the basic structure of a how-to article.
See the [how-to guidance](contribute-how-to-write-howto.md) in the contributor guide.

To provide feedback on this template contact 
[the templates workgroup](mailto:templateswg@microsoft.com).
-->

<!-- 1. H1
Required. Start your H1 with a verb. Pick an H1 that clearly conveys the task the 
user will complete.
-->

# [H1 heading here]

<!-- 2. Introductory paragraph 
Required. Lead with a light intro that describes, in customer-friendly language, 
what the customer will learn, or do, or accomplish. Answer the fundamental “why 
would I want to do this?” question. Keep it short.
-->

[Add your introductory paragraph]

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This quickstart shows you how to install and configure a DNS Server on Windows Server. You'll
install the DNS Server role to forward DNS queries to DNS root hint name servers, or optionally to an
upstream name server.

## Prerequisites

Before you can install and configure your DNS server, your computer must meet the following
prerequisites:

- A computer running a support version of Windows Server.
- A static IP.
- An account that is a member of the Administrators group, or equivalent.

### Primary zones

To create an Active Directory integrated primary zone, perform the following steps:

#### [PowerShell](#tab/powershell)

You add a forward lookup zone using Add-DnsServerPrimaryZone PowerShell cmdlet. For example to add the Active Directory Integrated DNS zone west01.contoso.com with the replication scope set to all DNS servers hosted on AD DS domain controllers in the forest, run the following command on a domain controller with the DNS server role installed:

```powershell
Add-DnsServerPrimaryZone -Name "west01.contoso.com" -ReplicationScope "Forest" -PassThru
```

To create a file based primary zone, perform the following steps:

PowerShell:

To add the file based DNS zone west02.contoso.com using the file west02.contoso.com.dns, run the following command on a computer with the DNS server role installed:

```powershell
Add-DnsServerPrimaryZone -Name "west02.contoso.com" -ZoneFile "west02.contoso.com.dns"
```

#### [GUI](#tab/gui)

To create a forward look up zone:

1.  Open DNS Manager console.
2.  In the console tree, right-click a DNS server, and then click New Zone to open the New Zone Wizard.
3.  On the Zone Type page, select Primary zone and ensure Store the zone in Active Directory is selected. This option will only be available of the DNS server is also an AD DS domain controller.
4.  On the Active Directory Zone Replication Scope page, choose between replicating between all DNS servers running on AD DS domain controllers in the forest, all DNS servers running on AD DS domain in the domain, all domain controllers in this domain (for Windows 2000 compatibility) or all domain controllers enrolled in a specific directory partition. The default is to all DNS servers running on domain controllers in the domain that the AD DS domain controller is a member of.
5.  On the Forward or Reverse Lookup Zone page, select Forward lookup zone.
6.  On the zone name page, specify the name of the DNS zone. For example west.contoso.com
7.  On the Dynamic Update page, select whether to allow only secure dynamic updates, nonsecure and secure dynamic updates, or to not allow dynamic updates. The default is only to allow secure dynamic updates.
8.  Click Finish to complete the New Zone Wizard.

To create a primary zone:

1.  Open DNS Manager console.
2.  In the console tree, right-click a DNS server, and then click New Zone to open the New Zone Wizard.
3.  On the Zone Type page, select Primary zone and ensure Store the zone in Active Directory is not selected. This option will only be available of the DNS server is also an AD DS domain controller.
4.  On the Forward or Reverse Lookup Zone page, select Forward lookup zone.
5.  On the zone name page, specify the name of the DNS zone. For example east.contoso.com
6.  On the Zone File page you will be provided with the option to specify a new file name, with the default being the zone name with the .dns extension. For example east.contoso.com.dns. You can also use an existing zone file that has been copied to the %SystemRoot%\\system32\\dns folder on the DNS server.
7.  On the Dynamic Update page select whether to allow nonsecure and secure dynamic updates, or to not allow dynamic updates. The default is to not allow dynamic updates.
8.  Click Finish to complete the New Zone Wizard.

---
### Secondary zone

To create a secondary zone, perform the following steps:

#### [PowerShell](#tab/powershell)

PowerShell:

To add the secondary zone western.contoso.com using the zone file name western.contoso.dns and using the primary zone server at IP address 172.23.90.124 use the following command:

Add-DnsServerSecondaryZone -Name "western.contoso.com" -ZoneFile "western.contoso.com.dns" -MasterServers 172.23.90.124

#### [GUI](#tab/gui)

1.  Open DNS Manager console.
2.  In the console tree, right-click a DNS server, and then click New Zone to open the New Zone Wizard.
3.  On the Zone Type page, select Secondary zone.
4.  On the Forward or Reverse Lookup Zone page, select Forward lookup zone.
5.  On the Zone Name page, specify the name of the secondary zone. This must match the name of the primary zone you will replicate from.
6.  On the Master DNS Servers page, specify the IP addresses of one or more DNS servers that host copies of the primary zone. You will need to ensure that the primary zone allows transfers to the DNS server that will host the secondary zone.
7.  Click Finish on the Completing the New Zone Wizard.

---

### Stub zone

To create a stub zone, perform the following steps:

PowerShell:

You add a stub zone using the Add-DnsServerStubZone PowerShell cmdlet. For example, to add a stub zone for the east02.contoso.com zone using the authoritative DNS server 172.23.90.124, run the following command:

Add-DnsServerStubZone -Name "east02.contoso.com" -MasterServers "172.23.90.124" -PassThru -ZoneFile "east02_contoso.dns"

DNS Console:

1.  Open DNS Manager.
2.  In the console tree, right-click a DNS server, and then click New Zone to open the New Zone Wizard.
3.  On the Zone Type page, select Stub zone. If the DNS server is also an AD DS domain controller, you will have the option to store the in Active Directory is selected.
4.  If you have chosen to store the zone data in AD DS, you will be able to choose whether to replicate to all DNS servers running on AD DS domain controllers in the forest, all AD DS servers running on domain controllers in the domain, or the Windows 2000 compatibility replication scope. The default is to replicate to all DNS servers running on AD DS domain controllers in the domain.
5.  Specify the zone name. This is the name of the remote zone that you which hosts the authoritative name servers you wish to store on your local DNS server.
6.  On the Master DNS Servers provide the IP address of a DNS server that is authoritative for the target zone.
7.  Click Finish on the Completing the New Zone Wizard.

### Reverse Lookup Zones

To create a reverse lookup zone, perform the following steps:

PowerShell:

Add a reverse lookup zone using the Add-DnsServerPrimaryZone PowerShell cmdlet you specify the IP address range using CIDR notation. For example, to add the reverse lookup zone for the 10.1.0.0/24 IPv4 address range, run the following command:

Add-DnsServerPrimaryZone -NetworkID "10.1.0.0/24" -ReplicationScope "Forest"

WAC:

DNS Console:

1.  Open DNS Manager.
2.  In the console tree, right-click a Domain Name System (DNS) server, and then click New Zone to open the New Zone Wizard.
3.  On the Zone Type page, select Primary zone and ensure Store the zone in Active Directory is selected. This option will only be available of the DNS server is also an AD DS domain controller.
4.  On the Active Directory Zone Replication Scope page, choose between replicating between all DNS servers running on AD DS domain controllers in the forest, all DNS servers running on AD DS domain in the domain, all domain controllers in this domain (for Windows 2000 compatibility) or all domain controllers enrolled in a specific directory partition. The default is to all DNS servers running on domain controllers in the domain that the AD DS domain controller is a member of.
5.  On the Forward or Reverse Lookup Zone page, select Reverse lookup zone.
6.  On the Reverse Lookup Zone Name page, select IPv4 Reverse Lookup Zone.
7.  On the Network ID page, enter the network ID in the normal (not the reversed) order. For example for network 192.168.220.0/24 enter the network ID as 192.168.220, The in-addr.arpa will automatically be appended to the zone name by the DNS server service.
8.  On the Dynamic Update page, select whether to allow only secure dynamic updates, nonsecure and secure dynamic updates, or to not allow dynamic updates. The default is only to allow secure dynamic updates.
9.  Click Finish to complete the New Zone Wizard.

## Zone Transfer Settings

You can use the following procedure to control whether a zone will be transferred to other servers and which servers can receive the zone transfer.

1.  Open DNS Manager.
2.  Right-click a DNS zone, and then click Properties.
3.  On the Zone Transfers tab, do one of the following:
-   To disable zone transfers, clear the Allow zone transfers check box.
-   To allow zone transfers, select the Allow zone transfers check box.
1.  If you allowed zone transfers, do one of the following:
-   To allow zone transfers to any server, click To any server.
-   To allow zone transfers only to the DNS servers that are listed on the Name Servers tab, click Only to servers listed on the Name Servers tab.
-   To allow zone transfers only to specific DNS servers, click Only to the following servers, and then add the IP address of one or more DNS servers.

## Zone Delegation

To create a zone delegation using PowerShell perform the following steps:

To create a zone delegation using the Windows interface use the following steps:

1.  Open DNS Manager.
2.  In the console tree, right-click the applicable subdomain, and then click New Delegation.
3.  Follow the instructions in the New Delegation Wizard to finish creating the new delegated domain.

All domains (or subdomains) that appear as part of the applicable zone delegation must be created in the current zone before delegation is performed as described here. As necessary, use DNS Manager to first add domains to the zone before you complete this procedure.


## Next steps
<!-- Add a context sentence for the following links -->
- [Write how-to guides](contribute-how-to-write-howto.md)
- [Links](links-how-to.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.
-->
