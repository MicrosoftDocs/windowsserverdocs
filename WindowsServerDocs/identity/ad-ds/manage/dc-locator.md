---
title: Locating Active Directory Domain Controllers in Windows and Windows Server
description: Learn how domain controllers are located in Windows and Windows Server using the DC locator algorithm.
ms.date: 07/10/2025
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
---

# Locating domain controllers in Windows and Windows Server

Domain controller location refers to the algorithm the client machine uses to find a suitable domain controller. Domain controller location is a critical function in all enterprise environments to allow client authentication with Active Directory.

In this article, learn about the domain controller locator process, including discovery, closest site detection, and configuration of NetBIOS domain name mappings.

## Domain controller locator process

The domain controller locator (DC locator) algorithm consists of two parts:

- Locator finds which domain controllers are registered.

- Locator submits a query to locate a domain controller in the specified domain.

An LDAP User Datagram Protocol (UDP) lookup is then sent to one or more of the domain controllers listed in the response to ensure their availability. Finally, the _Netlogon service_ caches the discovered domain controller to aid in resolving future requests.

### Discovery process

Active Directory domains always have two distinct names: the DNS fully qualified domain name (FQDN) and the NetBIOS domain name. NetBIOS domain names have legacy length and other constraints. For example, NetBIOS domains are limited to 15 characters.

The NetBIOS domain name of an Active Directory domain doesn't need to be the same as the Active Directory domain's FQDN. For example, an Active Directory domain's FQDN might be `contoso.com`, but the domain might have a NetBIOS domain name of `fabrikam`.

DC location in Windows can operate in two basic modes:

- **DNS-based discovery** is based on domain controller advertisement using DNS.

  Domain controllers register various SRV records in DNS, such as records that represent key capabilities like Key Distribution Center or Global Catalog, and records that describe locality, like Active Directory site records. Clients query DNS for the appropriate SRV records and then ping those servers by using UDP-based LDAP pings.

  This mode is supported only when you use DNS domain names and your domain controllers are running Windows 2000 and later. Supported domain controllers run more optimally in this mode but can change to the other mode in certain scenarios.

- **NetBIOS-based discovery** involves domain controllers registering records in [Windows Internet Name Service (WINS)](/windows-server/networking/technologies/wins/wins-top). Clients query WINS for the appropriate records, followed by pinging the possible target candidate DCs. A variant of this mode uses a broadcast mechanism supported by [mailslot messages](/windows/win32/ipc/about-mailslots) where the client broadcasts packets on its local network to look for DCs.

> [!IMPORTANT]
> When an application requests a DC but specifies a short NetBIOS-style domain name, DC location always tries to map that short domain name to a DNS domain name. If DC location can map the domain names successfully, it uses DNS-based discovery with the mapped DNS domain name.

NetBIOS-style domain names are mapped to DNS domain names from multiple sources, in the following order:

1. Cached information from a previous lookup

1. All domains in the current forest

1. Top-level names (TLNs) for all trusting forest trusts and external trusts

1. For Windows Server 2025 and later:

   1. Administrator-configured domain name mappings

   1. Domain name mappings for all forests and child domains in trusting forest trusts

1. Sign-in sessions on the client machine

When none of these sources can find a DNS domain name, DC location can proceed with NetBIOS-based discovery by using the original NetBIOS-style short domain name

Beginning with Windows Server 2025, Netlogon downloads and caches naming information about domains and child domains in all trusting forests. This information is used when you're mapping NetBIOS-style domain names to DNS domain names.

We recommend using DNS-based discovery instead of NetBIOS-based discovery. DNS-based discovery is more reliable and secure. [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew) is the primary DC location API.

> [!IMPORTANT]
> Beginning with Windows Server 2025, DC locator doesn't allow the use of NetBIOS-style location. To learn how to configure this behavior, see the [NetBIOS discovery policy setting](#netbios-discovery-policy-setting) section in this article.

To learn about the discovery process, select the tab that corresponds to the method you want to learn about.

#### [DNS-based discovery](#tab/dns-based-discovery)

The process that the locator follows can be summarized as follows:

1. On the client (the computer that's locating the domain controller), the locator is initiated as a remote procedure call (RPC) to the local Netlogon service. The Netlogon service implements the Locator API (`DsGetDcName`).

1. The client collects the information that's needed to select a domain controller and passes the information to the Netlogon service by using the `DsGetDcName` API.

1. The Netlogon service on the client uses the collected information to look up a domain controller for the specified domain. The lookup process uses one of the following two methods:

1. Netlogon queries DNS by using the IP/DNS-compatible locator. `DsGetDcName` calls the DnsQuery call to read the Service Resource (SRV) records and A records from DNS after it appends the domain name to the appropriate string that specifies the SRV records.

   - When a workstation signs in to a Windows-based domain, it queries DNS for SRV records in the format `_<service>._<protocol>.<DnsDomainName>`. Clients querying DNS for an LDAP server for the domain using the following format, where `DnsDomainName` is the domain name.

     `_ldap._tcp.DnsDomainName`

1. The Netlogon service sends a datagram as an LDAP UDP search to the discovered domain controllers that register the name.

1. Each available domain controller responds to the datagram to indicate that it's currently operational and then returns the information to `DsGetDcName`.

1. The Netlogon service returns the information to the client from the domain controller that responds first.

1. The Netlogon service caches the domain controller information so that it isn't necessary to repeat the discovery process for subsequent requests. Caching this information encourages the consistent use of the same domain controller and, thus, a consistent view of Active Directory.

#### [NetBIOS-based discovery](#tab/netbios-based-discovery)

The process that the locator follows can be summarized as follows:

1. On the client (the computer that's locating the domain controller), the locator is initiated as a remote procedure call (RPC) to the local Netlogon service. The Netlogon service implements the Locator API (`DsGetDcName`).

1. The client collects the information that's needed to select a domain controller and passes the information to the Netlogon service by using the DsGetDcName API.

1. The Netlogon service on the client uses the collected information to look up a domain controller for the specified domain. The lookup process uses one of the following two methods:

1. For a single label name, Netlogon performs domain controller discovery by using the Windows NT 4.0–compatible locator. The Windows NT 4.0–compatible locator uses the transport-specific mechanism (for example, WINS).

1. The Netlogon service sends a datagram as a mailslot message to the discovered domain controllers that register the name.

   > [!IMPORTANT]
   > WINS and mailslots were deprecated in Windows Server 2022 and Windows Server 2025, respectively, because these legacy technologies are no longer secure in today's environments. To learn more, see [Features removed or no longer developed in Windows Server](../../../get-started/removed-deprecated-features-windows-server.md).

1. Each available domain controller responds to the datagram to indicate that it's currently operational and then returns the information to DsGetDcName.

1. The Netlogon service returns the information to the client from the domain controller that responds first.

1. The Netlogon service caches the domain controller information so that it isn't necessary to repeat the discovery process for subsequent requests. Caching this information encourages the consistent use of the same domain controller and, thus, a consistent view of Active Directory.

----

### NetBIOS discovery policy setting

Beginning with Windows Server 2025, DC locator doesn't allow the use of the NetBIOS-based discovery. `BlockNetBIOSDiscovery` is a new Group Policy setting for the Netlogon service that allows administrators to control this behavior. To access the policy in Group Policy Management Editor, go to **Computer Configuration** > **Administrative Templates** > **System** > **Net Logon** > **DC Locator DNS Records** > **Block NetBIOS-based discovery for domain controller location**.

The following settings apply to `BlockNetBIOSDiscovery`:

- `TRUE` (default): DC locator doesn't allow the use of NetBIOS-style DC location.
- `FALSE`: DC locator allows the use of WINS or mailslot-based discovery if all legacy constraints also allow it.

You use the `BlockNetBIOSDiscovery` setting to enforce a secure-by-default posture for DC location. We recommend that you keep it set to `TRUE`. Disable it only for temporary periods while you're pursuing other mitigations.

The new policy setting looks like this:

:::image type="content" source="./media/dc-locator-changes/dc-locator-changes-blocknetbiosdiscovery-policy.png" border="false" alt-text="Screenshot of the BlockNetBIOSDiscovery Group Policy setting, with default enabled.":::

> [!TIP]
> You can separately enable or disable the ability to use mailslots on a machine-wide basis by using the SMB `EnableMailslots` policy setting. For DC locator to be able to use mailslots for DC discovery, you must enable mailslots at the SMB level and disable `BlockNetBIOSDiscovery`. You can query and set the `EnableMailslots` setting by running the `Get-SmbClientConfiguration` and `Set-SmbClientConfiguration` PowerShell cmdlets.

## Closest Active Directory site

After the client locates a domain controller, it establishes communication by using LDAP to gain access to Active Directory. As part of that negotiation, the domain controller identifies which site the client is in based on the client's IP subnet.

If the client is communicating with a domain controller that isn't in the closest, most optimal site, the domain controller returns the name of the client's site. If the client has already tried to find domain controllers in that site, the client uses a domain controller in a less optimal site instead. For example, the client sends a DNS Lookup query to DNS to find domain controllers in the client's subnet. Otherwise, the client does a site-specific DNS lookup again with the new optimal site name. The domain controller uses some of the directory service information for identifying sites and subnets.

The client caches the domain controller entry. If the domain controller isn't in the optimal site, the client flushes the cache after 15 minutes and discards the cache entry. It then attempts to find an optimal domain controller in the same site as the client.

After the client establishes a communications path to the domain controller, it can establish the sign-in and authentication credentials. If necessary, the client can also set up a secure channel for Windows-based computers. The client is now ready to perform normal queries and search for information against the directory.

The client establishes an LDAP connection to a domain controller to sign in. The sign-in process uses _Security Accounts Manager_. The communications path uses the LDAP interface, and a domain controller authenticates the client. After that, the client account is verified and passed through Security Accounts Manager to the directory service agent, then to the database layer, and finally to the database in the Extensible Storage Engine (ESE).

## Configuring NetBIOS domain name mappings

Beginning with Windows Server 2025, forest administrators can configure custom mappings from DNS domain name to NetBIOS domain name. Administrator-configured mappings at the forest level are an optional mechanism that you should use only when all other options are insufficient. For example, if an application or environment requires other domain name mappings that other sources can't automatically provide.

The custom domain name mappings are stored in a `serviceConnectionPoint` object located in the naming context for the Active Directory configuration. For example:

`CN=DCLocatorDomainNameMappings,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com`

The `msDS-Setting`s attribute of this `serviceConnectionPoint` object can contain one or more values. Each value contains the DNS domain name and the NetBIOS domain name, separated by a semicolon, as in dnsdomainname.com:NetBIOSdomainname.

For example:

- `contoso.com:fabrikam`
- `tatertots.contoso.com:tots`
- `tailspintoys.com:tailspintoys`

You can configure these mappings in the Active Directory Domains and Trusts management settings by following these steps:

1. Right-click the domain.
1. Select **Properties**.
1. Select the **DC locator mappings** tab.

The Netlogon service on clients then downloads and caches the custom mappings in the `DCLocatorDomainNameMappings` object every 12 hours. The service automatically uses this information when you're mapping NetBIOS-style domain names to DNS domain names.

The new Active Directory Domains and Trusts management page looks like this:

:::image type="content" source="./media/dc-locator-changes/dc-locator-changes-addt-dc-locator-mappings-property-page.png" border="false" alt-text="Screenshot of the page for DC locator domain name mappings in the Active Directory Domains and Trusts snap-in.":::

> [!IMPORTANT]
> Configure administrator-configured forest-level domain name mappings only when you're sure that all other name mapping sources are insufficient. As a general rule, such arbitrary mappings are necessary only when no trust relationship exists between clients and the target domains, and client applications can't be migrated to specifying DNS-style domain names.

## Related content

- [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew)
- [How domain controllers are located in Windows](/troubleshoot/windows-server/identity/how-domain-controllers-are-located)
- [How to verify that SRV DNS records have been created for a domain controller](/troubleshoot/windows-server/networking/verify-srv-dns-records-have-been-created)
- [The Beginning of the end of Remote Mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots/ba-p/3762048)
- [Windows Internet Name Service (WINS)](/windows-server/networking/technologies/wins/wins-top)
- [About mailslots](/windows/win32/ipc/about-mailslots)
