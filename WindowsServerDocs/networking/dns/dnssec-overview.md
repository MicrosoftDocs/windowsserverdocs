---
title: Overview of DNSSEC
description: Introduction to Domain Name System Security Extensions (DNSSEC) suite of extensions in Windows Server that add security to the DNS protocol.
ms.topic: conceptual
ms.author: jgerend
author: JasonGerend
ms.date: 06/01/2023
---

# Overview of DNSSEC

Applies To: Windows Server 2012 R2, Windows Server 2012

Domain Name System Security Extensions (DNSSEC) is a suite of extensions that add security to the Domain Name System (DNS) protocol by enabling DNS responses to be validated. Specifically, DNSSEC provides origin authority, data integrity, and authenticated denial of existence. With DNSSEC, the DNS protocol is much less susceptible to certain types of attacks, particularly DNS spoofing attacks.

## How DNSSEC works

If supported by an authoritative DNS server, a DNS zone can be secured with DNSSEC using a process called zone signing. Signing a zone with DNSSEC adds validation support to a zone without changing the basic mechanism of a DNS query and response.

Validation of DNS responses occurs through the use of digital signatures included with DNS responses. These digital signatures are contained in new, DNSSEC-related resource records generated and added to the zone during zone signing.

The following figure shows DNS resource records in the zone contoso.com before and after zone signing.

![DNS resource records](RackMultipart20230503-1-7urv46_html_49ac0cb03196381.gif) alt-text="Screenshot showing DNS resource records in the zone contoso.com before and after zone signing"

For more information about each of these resource records, see [DNSSEC-related resource records](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj200221(v=ws.11)).

When a DNSSEC-aware recursive or forwarding DNS server receives a query from a DNS client for a DNSSEC-signed zone, it requests that the authoritative DNS server also send DNSSEC records and then attempt to validate the DNS response using these records. A recursive or forwarding DNS server recognizes that the zone supports DNSSEC if it has a DNSKEY, also called a trust anchor, for that zone.

    > [!IMPORTANT]
    > A non-authoritative DNS server might use recursion or forwarding to resolve a DNS query. This topic refers to the non-authoritative server as a recursive DNS server; however, if the server uses forwarding, then the process used for DNSSEC validation of DNS responses is the same.

A recursive DNS server uses the DNSKEY resource record to validate responses from the authoritative DNS server by decrypting digital signatures contained in DNSSEC-related resource records, and then by computing and comparing hash values. If hash values are identical, it provides a reply to the DNS client with the DNS data that it requested, such as a host (A) resource record. If hash values don't match, it replies with a SERVFAIL message. In this way, a DNSSEC-capable, resolving DNS server with a valid trust anchor installed protects against DNS spoofing attacks whether or not DNS clients are DNSSEC-aware.

Additionally, if the DNS client is DNSSEC-aware, it can be configured to require that the DNS server perform DNSSEC validation.

The following figure shows the validation process.

![Validation process](RackMultipart20230503-1-7urv46_html_49ac0cb03196381.gif) alt-text="Screenshot showing validation process"

DNSKEYs are used to compute hash values and decrypt RRSIG records. The figure doesn't display all validation processes that are performed. Additional validation is also carried out to ensure the DNSKEYs are valid and that DS records are valid, if they exist (not shown above).

For information about how to add DNSSEC data to the DNS query and response process, see [Validate DNS responses](/validate-dns-responses.md).

### DNSSEC-related resource records

The following table shows the new resource record types that are used with DNSSEC.

| **Resource record type** | **Description** |
| --- | --- |
| Resource record signature (RRSIG) | Signatures generated with DNSSEC are contained in RRSIG records. Each RRSIG record is matched to another record in the zone for which it provides a digital signature.When a resolver issues a query for a name, one or more RRSIG records are returned in the response. |
| --- | --- |
| Next Secure (NSEC) | An NSEC record is used to prove nonexistence of a DNS name. NSEC records prevent spoofing attacks intended to fool a DNS client into believing that a DNS name doesn't exist. |
| Next Secure 3 (NSEC3) | NSEC3 is a replacement or alternative to NSEC that has the additional benefit of preventing "zone walking" which is the process of repeating NSEC queries in order to retrieve all the names in a zone. A DNS server running Windows Server 2012 or a later operating system supports both NSEC and NSEC3. A zone can be signed with either NSEC or NSEC3, but not both. |
| Next Secure 3 Parameter (NSEC3PARAM) | The NSEC3PARAM record is used to determine which NSEC3 records to include in responses for non-existing DNS names. |
| DNS Key (DNSKEY) | A DNSKEY resource record stores a public cryptographic key that is used to verify a signature. The DNSKEY record is used by a DNS server during the validation process.DNSKEY records can store public keys for a zone signing key (ZSK) or a key signing key (KSK). |
| Delegation Signer (DS) | A DS record is a DNSSEC record type that is used to secure a delegation. DS records are used to build authentication chains to child zones. |

### Addition of DNSSEC-related resource records

With the exception of the DS record, all of these records are added to a zone automatically when it is signed with DNSSEC. The DS record is a special record that can be manually added to a parent zone to create a secure delegation for a child zone. For example, the contoso.com zone can contain a DS record for secure.contoso.com; however this record must either be created in the parent zone, or created in a child zone and then propagated to the parent zone. The DS record is not automatically created when you sign a zone.

NSEC or NSEC3 records are automatically added to a zone during zone signing. However, a signed zone cannot have both NSEC and NSEC3 records. The type of record (NSEC or NSEC3) added to the zone depends on how zone signing is configured. In the previous example, the zone is signed using NSEC3.

### Trust anchors

>>GOOD OPENING PARAGRAPH FOR A CONCEPTUAL: DNSKEY and DS resource records are also called  **trust anchors**  or  **trust points**. A trust anchor must be distributed to all nonauthoritative DNS servers that will perform DNSSEC validation of DNS responses for a signed zone. If the DNS server is running on a domain controller, trust anchors are stored in the forest directory partition in Active Directory Domain Services (AD DS) and can be replicated to all domain controllers in the forest. On standalone DNS servers, trust anchors are stored in a file named  **TrustAnchors.dns**. A DNS server running Windows Server 2012 or a later operating system also displays configured trust anchors in the DNS Manager console tree in the  **Trust Points**  container. You can also use Windows PowerShell or dnscmd.exe to view trust anchors (note: dnscmd.exe is deprecated and might be removed in a future version of Windows Server).

The following example shows the Windows PowerShell cmdlet  **Get-DnsServerTrustAnchor**.

``

PS C:\\> Get-DnsServerTrustAnchor -Name secure.contoso.com

TrustAnchorName TrustAnchorType TrustAnchorState TrustAnchorData

--------------- --------------- ---------------- ---------------

secure.contoso.com. DNSKEY Valid [15952][DnsSec][RsaSha256][AwEAAe3JOsLYe17k...

secure.contoso.com. DNSKEY Valid [38431][DnsSec][RsaSha256][AwEAAdsXYyqxjwBc...

``

To view all the current trust points on a server, you can use the  **Get-DnsServerTrustPoint**  cmdlet.

``

PS C:\\> Get-DnsServerTrustPoint

TrustPointName TrustPointState LastActiveRefreshTime NextActiveRefreshTime

-------------- --------------- --------------------- ---------------------

secure.contoso.com. Active 10/11/2013 4:44:21 PM 10/15/2013 11:22:27 AM

``
## Related Links

The core DNSSEC extensions are specified in the following Request for Comments (RFCs). Additional RFCs provide supporting information.

- [RFC 4033](https://www.rfc-editor.org/rfc/rfc4033.txt): "DNS Security Introduction and Requirements"
- [RFC 4034](https://www.rfc-editor.org/rfc/rfc4034.txt): "Resource Records for the DNS Security Extensions"
- [RFC 4035](https://www.rfc-editor.org/rfc/rfc4035.txt): "Protocol Modifications for the DNS Security Extensions"
