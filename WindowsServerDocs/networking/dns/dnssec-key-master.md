---
title: DNSSEC Key Master
description: Understand the role of the Key Master in DNSSEC deployments, including key management, server requirements, and transfer scenarios.
author: orin-thomas
ms.author: roharwoo
ms.topic: concept-article
ms.date: 07/08/2025
ms.custom: template-how-to, team=cloud_advocates
# Customer intent: As a DNS administrator, I want to understand the DNSSEC Key Master component so that I can implement DNSSEC.
---

# DNSSEC Key Master

The DNSSEC Key Master is a critical component in securing DNS zones with DNS Security Extensions (DNSSEC) on Windows Server. This article explains the role of the Key Master, how it manages cryptographic keys for DNSSEC-signed zones, and the considerations for configuring and maintaining the Key Master in different deployment scenarios. Use this information to help ensure the integrity and security of your DNS infrastructure.

In a Windows DNSSEC deployment, the Key Master is the authoritative primary DNS server responsible for key generation and key management for a DNSSEC-signed zone. When you use default settings to sign a zone, DNSSEC selects the local server as Key Master. You also have the option of choosing a different DNS server from a list of servers that support online DNSSEC signing. Only one DNS server can be the Key Master for a specific DNS zone at a time.

## Key Master role

The Key Master must be a primary, authoritative server for the zone that's also capable of online zone signing. However, in an Active Directory integrated zone where there are multiple authoritative primary DNS servers, the following exceptions are possible:

- You can transfer the Key Master role to a different authoritative name server after signing a DNS zone.
- You can transfer the Key Master role if the current Key Master is online. If the current Key Master is offline, you can also transfer the role as part of a disaster recovery process.
- One authoritative server can be the Key Master for multiple zones.
- Different authoritative servers can be Key Masters for different zones.

You can't transfer the Key Master role if a zone is file-backed, because these zones have only one primary, authoritative DNS server.

> [!IMPORTANT]
> If a zone is Active Directory-integrated, the Key Master is a domain controller and can benefit from the same enhanced security considerations you use for domain controllers. If the zone is file-backed, the Key Master might not also be a domain controller. In this scenario, we recommend you take extra security precautions to protect the Key Master from attack and protect private key material from becoming compromised. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed in order to limit its attack surface.

## Find the current Key Master

The name of the Key Master displays in the DNS Manager when you select **Forward Lookup Zones** or **Reverse Lookup Zones**. It also displays on the **Key Master** tab of the DNSSEC properties page. You can also run the `Get-DnsServerDnsSecZoneSetting` cmdlet in PowerShell to view the Key Master. The following example shows how to find the Key Master for a zone named `secure.contoso.com`:

```powershell
    Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer 
```

## Signing keys

The Key Master generates all keys for the DNS zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date.

You can also assign a Key Master to an unsigned zone. All zones that are signed have a Key Master setting, whether they're currently signed or not. A zone that hasn't been signed usually lacks a Key Master. You can assign a Key Master in advance using PowerShell to prepare for zone signing.

To perform its role, the Key Master must have access to private key for a DNSSEC-signed zone. The private key can be stored in several ways:

- **Active Directory**: If the Key Master is a domain controller, it can store private key material in Active Directory. This is the most secure option and allows for easy replication and access by other DNS servers in the domain.

- **Certificate store**: If the Key Master is not a domain controller, it can store private key material in the local certificate store. This requires careful management to ensure the private keys are secure and accessible.

- **Hardware Security Module (HSM)**: For high-security environments, private keys can be stored in an HSM. This provides strong protection against key compromise but requires additional configuration and management.

To learn more about how to create signing keys, see [DNSSEC Sign DNS Zones](dnssec-sign-zone.md).

## Related content

- [Overview of DNSSEC](dnssec-overview.md)