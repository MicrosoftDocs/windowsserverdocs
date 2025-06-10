---
title: DNSSEC Key Master
description: Learn about the DNSSEC Key master role in DNS Server and Windows Server
author: orin-thomas
ms.author: orthomas
ms.topic: conceptual
ms.date: 04/20/2025
ms.custom: template-how-to, team=cloud_advocates #Required; leave this attribute/value as-is.
# Customer intent: As a DNS administrator, I want to understand the DNSSEC Key Master component so that I can implement DNSSEC.
---

# DNSSEC Key Master

In a Windows DNSSEC deployment, the Key Master is the authoritative primary DNS server responsible for key generation and key management for a DNSSEC-signed zone. When you use default settings to sign a zone, DNSSEC selects the local server as Key Master. You also have the option of choosing a different DNS server from a list of servers that support online DNSSEC signing. Only one DNS server can be the Key Master for a specific DNS zone at a time.

The Key Master must be a primary, authoritative server for the zone that's also capable of online zone signing. However, in an Active Directory integrated zone where there are multiple authoritative primary DNS servers, the following exceptions are possible:

- You can transfer the Key Master role to a different authoritative name server after signing a DNS zone. You can transfer the role if the current Key Master is online, or you can do it as part of a disaster recovery scenario if the current Key Master is offline.
- One authoritative server can be the Key Master for multiple zones.
- Different authoritative servers can be Key Masters for different zones.

You can't transfer the Key Master role if a zone is file-backed, because these zones have only one primary, authoritative DNS server.

> [!IMPORTANT]
> If a zone is Active Directory-integrated, the Key Master is a domain controller and can benefit from the same enhanced security considerations you use for domain controllers. If the zone is file-backed, the Key Master might not also be a domain controller. In this scenario, we recommend you take additional security precautions to protect the Key Master from attack and protect private key material from becoming compromised. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed in order to limit its attack surface.

The name of the Key Master displays in the DNS Manager when you select **Forward Lookup Zones** or **Reverse Lookup Zones**. It also displays on the **Key Master** tab of the DNSSEC properties page. You can also run the `Get-DnsServerDnsSecZoneSetting` cmdlet in PowerShell to view the Key Master, as shown in the following example:

```powershell
    Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer 
```

The Key Master generates all keys for the DNS zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date.

> [!NOTE]
> You can also assign a Key Master to an unsigned zone. All zones that have been signed have a Key Master setting, whether they're currently signed or not. A zone that's never been signed typically doesn't have a Key Master, but you can configure it with a Key Master in preparation for zone signing with PowerShell.

## Related content

- [Overview of DNSSEC](dnssec-overview.md)
