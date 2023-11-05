---
description: Learn about changes to the Active Directory domain controller (DC) location algorithm.
ms.assetid: c256176d-24ef-401a-8548-5176ac1f9f8b
title: Active Directory DC locator changes
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2023
ms.topic: article
---

# Active Directory DC locator changes

>Applies to: Windows Insider Preview Build 25921 and later

This article discusses changes to the Active Directory domain controller (DC) location algorithm, including deprecation announcements.

## Overview

Authentication is the first step in virtually all functional scenarios in an Active Directory enterprise environment. Authentication, in turn, can't occur unless the client can first communicate with an Active Directory DC.

*DC location* refers to the algorithm by which a client machine finds a suitable domain controller. DC location is a critical baseline functionality in all enterprise environments.

Active Directory domains always have two distinct names: the DNS fully qualified domain name (FQDN) and the NetBIOS domain name. NetBIOS domain names have legacy length and other constraints. For example, NetBIOS domains are limited to 15 characters.

The NetBIOS domain name of an Active Directory domain isn't required to be related in any way to the first component of the Active Directory domain's FQDN. For example, an Active Directory domain's FQDN might be `contoso.com` with a NetBIOS domain name of `fabrikam`.

DC location in Windows can operate in two basic modes:

- **DNS-based discovery**: This mode is based on domain controller advertisement via DNS.

  Domain controllers register various SRV records in DNS. Examples include records that represent key capabilities (Key Distribution Center or Global Catalog) or records that describe locality (Active Directory site records). Clients query DNS for the appropriate SRV records and then ping those servers by using UDP-based LDAP pings.

  This mode is supported only when you use DNS domain names. This mode is supported with Windows 2000 and later domain controllers. Windows 2000 and later clients prefer this mode, but they can fall back to the other mode under some circumstances.

- **NetBIOS-based discovery**: This mode is based on domain controllers first registering records in [Windows Internet Name Service (WINS)](/windows-server/networking/technologies/wins/wins-top). Clients query WINS for the appropriate records, followed by pinging the possible target candidate DCs.

  A variant of this mode uses a broadcast mechanism supported by [mailslot messages](/windows/win32/ipc/about-mailslots). In this mechanism, the client broadcasts packets on its local network to look for DCs. This mode is supported with legacy Windows NT 4 and earlier domain controllers, and it works only when you use short NetBIOS domain names.

Organizations prefer DNS-based discovery over NetBIOS-based discovery, for both reliability and security reasons.

[DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew) is the primary DC location API.

This description is only a brief overview. For more information about the DC location process, see [How domain controllers are located in Windows](/troubleshoot/windows-server/identity/how-domain-controllers-are-located).

## Deprecation of WINS and mailslots

Microsoft previously [announced the deprecation of both WINS and mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots/ba-p/3762048). These legacy technologies are no longer secure in today's environments.

This deprecation affects DC location. Later sections in this article describe mitigation steps.

## Mapping of NetBIOS domain names to DNS domain names

When an application requests a DC but specifies a short NetBIOS-style domain name, DC location always tries to map that short domain name to a DNS domain name. If DC location finds such a mapping, it then uses DNS-based discovery with the mapped DNS domain name.

NetBIOS-style domain names are historically mapped to DNS domain names via multiple sources in the following order:

1. Cached information from a previous lookup

1. All domains in the current forest

1. Top-level names (TLNs) for all trusting forest trusts and external trusts

1. Sign-in sessions on the client machine

When none of these sources can find a DNS domain name, DC location can proceed with NetBIOS-based discovery by using the original NetBIOS-style short domain name.

> [!IMPORTANT]
> We recommend that you migrate all applications to use only Active Directory DNS domain names for authentication or other purposes.

## DC locator improvements to accommodate WINS and mailslot deprecation

The deprecation of WINS and mailslot messages means that those mechanisms are longer available as a fallback option when applications specify short NetBIOS-style domain names. This deprecation can therefore cause disruption in some environments.

The following sections describe improvements in Windows Insider Preview Release build 25921.

### BlockNetBIOSDiscovery Netlogon policy setting

`BlockNetBIOSDiscovery` is a new Boolean Group Policy setting for the Netlogon service. To access the policy in Group Policy Management Editor, go to **Computer Configuration** > **Administrative Templates** > **System** > **Net Logon** > **DC Locator DNS Records** > **Block NetBIOS-based discovery for domain controller location**.

The following settings apply to `BlockNetBIOSDiscovery`:

- `TRUE` (default): DC locator doesn't allow the use of NetBIOS-style DC location.
- `FALSE`: DC locator allows the use of WINS/mailslot-based discovery, if all legacy constraints also allow it.

You use the `BlockNetBIOSDiscovery` setting to enforce a secure-by-default posture for DC location. We recommend that you keep it set to `TRUE`. Disable it only for temporary periods while you're pursuing other mitigations.

The new policy setting looks like this:

:::image type="content" source="./media/dc-locator-changes/dc-locator-changes-blocknetbiosdiscovery-policy.png" border="false" alt-text="Screenshot of the BlockNetBIOSDiscovery Group Policy setting.":::

> [!TIP]
> You separately enable or disable the ability to use mailslots on a machine-wide basis by using the SMB `EnableMailslots` policy setting. For DC locator to be able to use mailslots for DC discovery, you must enable mailslots at the SMB level, and you must disable `BlockNetBIOSDiscovery`. You can query and set the `EnableMailslots` setting by using the `Get-SmbClientConfiguration` and `Set-SmbClientConfiguration` PowerShell cmdlets.

### Downloading and caching of full domain information

Netlogon downloads and caches naming information about domains and child domains in all trusting forests. This information is used when you're mapping NetBIOS-style domain names to DNS domain names.

### Downloading and caching of administrator-configured domain name mappings

If an application or environment requires other domain name mappings that other sources don't automatically provide, forest administrators can configure custom mappings from DNS domain name to NetBIOS domain name at the forest level. Administrator-configured mappings are an optional mechanism that you should use only when all other options are insufficient.

The custom domain name mappings are stored in a `serviceConnectionPoint` object located in the naming context for the Active Directory configuration. For example:

`CN=DCLocatorDomainNameMappings,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com`

The `msDS-Setting`s attribute of this `serviceConnectionPoint` object can contain one or more values. Each value contains the DNS domain name and the NetBIOS domain name, separated by a semicolon:

`dnsdomainname.com:NetBIOSdomainname`

For example:

`contoso.com:fabrikam`
`tatertots.contoso.com:tots`
`tailspintoys.com:tailspintoys`

You can configure these mappings by using the Active Directory Domains and Trusts management snap-in as follows:

1. Right-click the domain.
1. Select **Properties**.
1. Select the **DC locator mappings** tab.

The Netlogon service on clients then downloads and caches the custom mappings in the `DCLocatorDomainNameMappings` object every 12 hours. This information is then automatically used when you're mapping NetBIOS-style domain names to DNS domain names.

The new Active Directory Domains and Trusts management page looks like this:

:::image type="content" source="./media/dc-locator-changes/dc-locator-changes-addt-dc-locator-mappings-property-page.png" border="false" alt-text="Screenshot of the page for DC locator domain name mappings in the Active Directory Domains and Trusts snap-in.":::

> [!IMPORTANT]
> Configure administrator-configured forest-level domain name mappings only when you're sure that all other name mapping sources are insufficient. As a general rule, such arbitrary mappings are necessary only when no trust relationship exists between clients and the target domains, and client applications can't be migrated over to specifying DNS-style domain names.

## New mapping of NetBIOS domain names to DNS domain names

When an application requests a DC but specifies a short NetBIOS-style domain name, DC location always tries to map that short domain name to a DNS domain name. If DC location finds such a mapping, it then uses DNS-based discovery with the mapped DNS domain name.

With the improvements described in this article, NetBIOS-style domain names are mapped to DNS domain names by using multiple sources in the following order:

1. Cached information from a previous lookup

1. All domains in the current forest

1. TLNs for all trusting forest trusts and external trusts

1. Administrator-configured domain name mappings

1. Domain name mappings for all forests and child domains in trusting forest trusts

1. Sign-in sessions on the client machine

When none of these sources can find a DNS domain name, DC location can proceed with NetBIOS-based discovery by using the original NetBIOS-style short domain name.

## Troubleshooting

You can use standard troubleshooting steps for DC location. See [ETW Tracing in DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew#etw-tracing-in-dsgetdcname).

## See also

- [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew)
- [How domain controllers are located in Windows](/troubleshoot/windows-server/identity/how-domain-controllers-are-located)
- [How to verify that SRV DNS records have been created for a domain controller](/troubleshoot/windows-server/networking/verify-srv-dns-records-have-been-created)
- [The Beginning of the end of Remote Mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots/ba-p/3762048)
- [Windows Internet Name Service (WINS)](/windows-server/networking/technologies/wins/wins-top)
- [About mailslots](/windows/win32/ipc/about-mailslots)
