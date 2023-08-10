---
description: "Learn more about: DC locator changes"
ms.assetid: c256176d-24ef-401a-8548-5176ac1f9f8b
title: DC locator changes
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2023
ms.topic: article
---

# DC locator changes

>Applies to: Windows Insider Preview Builds 25921 and later

This article discusses upcoming changes to the domain controller (DC) location algorithm, including deprecation announcements and related changes.

## Overview

Authentication is the first step in virtually all functional scenarios in an Active Directory enterprise environment. Authentication in turn can't occur without the client first being able to communicate with an Active Directory domain controller (DC). “DC location” refers to the algorithm by which a client machine finds a suitable domain controller. DC location is therefore critical baseline functionality in all enterprise environments.

Active Directory domains always have two distinct names: the fully qualified DNS domain name (FQDN) and the NetBIOS domain name. NetBIOS domain names have legacy length and other constraints, for example are limited to a maximum of 15 characters. The NetBIOS domain name of an Active Directory domain isn't required to be related in any way to the first component of the Active Directory domain's FQDN. For example, an AD domain's FQDN might be `contoso.com` with a NetBIOS domain name of `fabrikam`.

DC location in Windows can operate in two basic modes that are briefly summarized as follows:

The first mode is based on domain controller advertisement via DNS. Domain controllers register various SRV records in DNS, for example records representing key capabilities (KDC or GC), or records describing locality (AD site records), etc. Clients then query DNS for the appropriate SRV records then ping those servers using UDP-based LDAP pings. This mode is only supported using DNS domain names. This mode is first supported with Windows 2000 and later domain controllers. Windows 2000 and later clients prefer this mode, but can fall back to the second mode under some circumstances (see next paragraph).

The second mode is based on domain controllers first registering records in [Windows Internet Name Service (WINS)](/windows-server/networking/technologies/wins/wins-top), with clients querying WINS for the appropriate records followed by “pinging” the possible target candidate DCs. A variant of this mode utilizes a broadcast mechanism supported by [mailslot messages](/windows/win32/ipc/about-mailslots), whereby the client broadcasts packets on its local network looking for DCs. This mode is first supported with legacy NT4 and prior domain controllers, and only works using short NetBIOS domain names.

DNS-based discovery (the first mode) is much preferred over NetBIOS-based discovery (the second mode) for both reliability and security reasons.

[DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew) is the primary DC location api.

This description is only a brief overview. For more information about the DC location process, see [How domain controllers are located in Windows](/troubleshoot/windows-server/identity/how-domain-controllers-are-located).

### Deprecation of WINS and mailslots

Microsoft has previously announced deprecation of both WINS and mailslots. These legacy technologies are no longer secure in today's environments. DC location is affected due to these deprecations; mitigation steps are described in later sections.

[The Beginning of the end of Remote Mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots/ba-p/3762048).

### Mapping of NetBIOS domain names to DNS domain names

When an application requests a DC but specifies a short NetBIOS-style domain name, DC location always attempts to map that short domain name to a DNS domain name. If such a mapping is found, DC location then proceeds using DNS-based discovery with the mapped DNS domain name.

NetBIOS-style domain names are historically mapped to DNS domain names using multiple sources in the following order:

1. Cached information from a previous lookup

1. All domains in the current forest

1. Top level names (TLNs) for all trusting forest trusts and external trusts

1. Sign-in sessions on the client machine

When none of these sources are able to find a DNS domain name, DC location may proceed with NetBIOS-based discovery using the original NetBIOS-style short domain name.

> [!IMPORTANT]
> Microsoft recommends that all applications be migrated to only use Active Directory DNS domain names for authentication or other purposes.

### DC locator improvements to accommodate WINS and mailslot deprecation

The deprecation of WINS and mailslot messages means that those mechanisms are longer available as a fallback option when applications specify short NetBIOS-style domain name. This deprecation can therefore cause disruption in some environments. The following sections describe various improvements that have been made as of Windows Insider Preview Release build 25921.

#### BlockNetbiosDiscovery Netlogon policy setting

BlockNetbiosDiscovery is a new boolean Group Policy setting for the Netlogon service.

When set to TRUE, DC locator doesn't allow the use of NetBIOS-style DC location.

When set to FALSE, DC locator allows the use of WINS\mailslot-based discovery, if also allowed by all legacy constraints.

When not explicitly set, the default setting is TRUE.

The BlockNetbiosDiscovery setting is used to enforce a secure-by-default posture for DC location. BlockNetbiosDiscovery should only be disabled for temporary periods while other mitigations are being pursued.

> [!IMPORTANT]
> Microsoft recommends that BlockNetbiosDiscovery always be set to TRUE.

> [!TIP]
> The ability to use mailslots is separately enabled or disabled on a machine-wide basis using the SMB `EnableMailslots` policy setting. In order for DC locator to use mailslots for DC discovery, mailslots must be 1) enabled at the SMB level AND 2) BlockNetbiosDiscovery must be disabled. You can query and set the `EnableMailslots` setting using the `Get-SmbClientConfiguration` and `Set-SmbClientConfiguration` PowerShell cmdlets.

#### Netlogon downloads\caches full domain information for all trusting forests

Netlogon downloads and caches naming information about domains and child domains in all trusting forests. This information is used when mapping NetBIOS-style domain names to DNS domain names.

#### Netlogon downloads\caches administrator-configured domain name mappings

If an application or environment requires other domain name mappings that aren't automatically provided by other sources, forest administrators may configure custom DNS-domain-name-to-NetBIOS-domain-name mappings at the forest level. Administrator-configured mappings are an optional mechanism that should only be used when all other options are insufficient.

The custom domain name mappings are stored in a serviceConnectionPoint object located in the AD configuration NC, for example:

`CN=DCLocatorDomainNameMappings,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com`

The `msDS-Setting`s attribute of this serviceConnectionPoint object may contain one or more values, where each value contains the DNS domain name and the NetBIOS domain name separated by a semi-colon:

`dnsdomainname.com:NetBIOSdomainname`

For example:

`contoso.com:fabrikam`
`tatertots.contoso.com:tots`
`tailspintoys.com:tailspintoys`

These mappings may be configured using the Active Directory Domains and Trusts management snap-in as follows:

- right-click on the domain
- select Properties
- select the "DC locator mappings" tab.

The Netlogon service downloads and caches the custom mappings in the DCLocatorDomainNameMappings object every 12 hours. This information is then automatically used when mapping NetBIOS-style domain names to DNS domain names.

> [!IMPORTANT]
> Administrator-configured forest-level domain name mappings should only be configured when it has been demonstrated that all other name mapping sources are insufficient. As a general rule, such arbitrary mappings will only be necessary when no trust relationship exists between clients and the target domains, and client applications can't be migrated over to specifying DNS-style domain names.

### New mapping of NetBIOS domain names to DNS domain names

When an application requests a DC but specifies a short NetBIOS-style domain name, DC location always attempts to map that short domain name to a DNS domain name. If such a mapping is found, DC location then proceeds using DNS-based discovery with the mapped DNS domain name.

With the improvements described in this article, NetBIOS-style domain names are mapped to DNS domain names using multiple sources in the following order:

1. Cached information from a previous lookup

1. All domains in the current forest

1. Top level names (TLNs) for all trusting forest trusts and external trusts

1. Administrator-configured domain name mappings

1. Domain name mappings for all forests and child domains in trusting forest trusts

1. Sign-in sessions on the client machine

When none of these sources are able to find a DNS domain name, DC location may proceed with NetBIOS-based discovery using the original NetBIOS-style short domain name.

> [!IMPORTANT]
> Microsoft recommends that all applications be migrated to only use Active Directory DNS domain names for authentication or other purposes.

### Troubleshooting

Standard DC-location troubleshooting steps may be used. See [ETW Tracing in DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew#etw-tracing-in-dsgetdcname).

## See Also

- [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew)
- [How domain controllers are located in Windows](/troubleshoot/windows-server/identity/how-domain-controllers-are-located)
- [How to verify that SRV DNS records have been created for a domain controller](/troubleshoot/windows-server/networking/verify-srv-dns-records-have-been-created)
- [The Beginning of the end of Remote Mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots/ba-p/3762048)
- [Windows Internet Name Service (WINS)](/windows-server/networking/technologies/wins/wins-top)
- [About mailslots](/windows/win32/ipc/about-mailslots)
