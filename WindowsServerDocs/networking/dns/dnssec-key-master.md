---
title: DNSSEC Key Master
description: Understand the role of the Key Master in DNSSEC deployments, including key management, server requirements, and transfer scenarios.
author: orin-thomas
ms.author: roharwoo
ms.topic: concept-article
ms.date: 08/01/2025
ms.custom: template-how-to, team=cloud_advocates
ai-usage: ai-assisted
# Customer intent: As a DNS administrator, I want to understand the DNSSEC Key Master component so that I can implement DNSSEC.
---

# DNSSEC Key Master

In this article, you'll learn about what the Key Master is, its role in DNS Security Extensions (DNSSEC) deployments, and how to manage it effectively.

## What is a DNSSEC Key Master?

The Key Master generates and manages cryptographic keys for DNSSEC-signed zones, ensuring the integrity and security of your DNS infrastructure. The role is crucial for maintaining the security of DNS zones, especially in environments that require high levels of trust and security.

The Key Master is:

- The authoritative primary DNS server responsible for key generation and management for DNSSEC-signed zones.
- Automatically selected as the Key Master when using default zone signing settings, unless specified otherwise.
- Transferable to a different DNS server that supports online DNSSEC signing, allowing flexibility in key management.
- Exclusive to one DNS server per zone, meaning only one DNS server can serve as the Key Master for a specific DNS zone at any given time.

This component is essential for maintaining secure DNS operations in environments requiring high levels of trust and security.

## Requirements

The Key Master must meet specific requirements to function correctly.

For all types of zones, the Key Master must be a primary, authoritative server for the zone that's also capable of online zone signing.

Active Directory integrated zones and file-backed zones have some exceptions. These exceptions are described in the following sections.

### Active Directory integrated zones

In an Active Directory integrated zone where there are multiple authoritative primary DNS servers, the following exceptions are possible:

- You can transfer the Key Master role to a different authoritative name server after signing a DNS zone.
- You can transfer the Key Master role if the current Key Master is online. If the current Key Master is offline, you can also transfer the role as part of a disaster recovery process.
- One authoritative server can be the Key Master for multiple zones.
- Different authoritative servers can be the Key Master for different zones.

### File-backed zones

You can't transfer the Key Master role if a zone is file-backed, because these zones have only one primary, authoritative DNS server.

## Security considerations

The security requirements for your Key Master depend on your zone type:

- **Active Directory-integrated zones**: The Key Master is a domain controller and benefits from the same enhanced security considerations you use for domain controllers.

- **File-backed zones**: The Key Master might not be a domain controller. In this scenario, take extra security precautions to protect the Key Master from attack and protect private key material from becoming compromised. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed to limit its attack surface.

## Zone signing

When you sign a zone with DNSSEC, the Key Master plays a central role in the process by generating and managing the cryptographic signing keys required for zone signing. Zone signing adds DNSSEC-specific resource records to your DNS zone that provide cryptographic proof of data integrity.

The Key Master handles the signing process differently depending on your zone type:

- **Active Directory-integrated zones**: Private signing keys automatically replicate to all primary DNS servers through Active Directory replication. Each Key Master signs its own copy of the zone in memory for optimal performance.

- **File-backed zones**: The signed zone is committed to disk on the single primary DNS server serving as the Key Master. Signing keys are stored in the local certificate store or a Hardware Security Module (HSM) if configured.

For detailed steps on how to sign DNS zones with DNSSEC, see [DNSSEC Sign DNS Zones](sign-dnssec-zone.md).

## Signing keys

The Key Master generates all keys for the DNS zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date.

### Unsigned zones

You can also assign a Key Master to an unsigned zone. All zones have a Key Master setting, whether they're currently signed or not. A zone that isn't signed also lacks a Key Master. You can assign a Key Master in advance using PowerShell to prepare for zone signing.

### Private key storage

To perform its role, the Key Master must have access to private key for a DNSSEC-signed zone. The private key can be stored in several ways:

- **Active Directory**: If the Key Master is a domain controller, it can store private key material in Active Directory. Using Active Directory is the most secure option and allows for easy replication and access by other DNS servers in the domain.

  **Best for:** Environments where DNS is Active Directory integrated, as it provides strong security and easy access to private keys.

- **Certificate store**: If the Key Master isn't a domain controller, it can store private key material in the local certificate store. Using a certificate store requires careful management to ensure the private keys are secure and accessible.

  **Best for:** Workgroup and standalone environments where you need to manage private keys locally.

- **Hardware Security Module (HSM)**: For high-security environments, private keys can be stored in an HSM. HSMs provides strong protection against key compromise but requires extra configuration and management.

  **Best for:** High-security environments where you need strong protection against key exfiltration and compromise.

To learn more about how to create signing keys, see [DNSSEC Sign DNS Zones](sign-dnssec-zone.md).

## Related content

- [Overview of DNSSEC](dnssec-overview.md)
