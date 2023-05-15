---
title: Validate DNS responses
description: Learn how to use DNSSEC resource records to validate and secure DNS responses.
ms.topic: how-to
ms.author: jgerend
author: JasonGerend
ms.date: 06/01/2023
---

# Validate DNS responses

Applies to: Windows Server 2012 R2, Windows Server 2012

This article provides guidance on how to use DNSSEC resource records to validate and secure DNS responses. For an introduction on how DNSSEC functions in Windows Server to enhance add security see [Overview of DNSSEC](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012(v=ws.11)).

DNS zones are secured with DNSSEC via zone signing. Signing a zone with DNSSEC adds validation support to a without changing the basic mechanism of a DNS query and response.

Validation of DNS responses occurs through the use of digital signatures that are included with DNS responses. These digital signatures are contained in new, DNSSEC-related resource records that are generated and added to the zone during zone signing.

When a DNSSEC-aware recursive or forwarding DNS server receives a query from a DNS client for a DNSSEC-signed zone, it requests the authoritative DNS server to also send DNSSEC records and then validate the DNS response. A recursive or forwarding DNS server recognizes that the zone supports DNSSEC if it has a DNSKEY, also called a trust anchor, for that zone.

    > [!IMPORTANT]
    > A non-authoritative DNS server might use recursion or forwarding to resolve a DNS query. This topic refers to the non-authoritative server as a recursive DNS server; however, if the server uses forwarding, then the process used for DNSSEC validation of DNS responses is the same.

## DNSSEC validation

A recursive DNS server uses the DNSKEY resource record to validate responses from the authoritative DNS server by decrypting digital signatures contained in DNSSEC-related resource records. The recursive DNS server then computes and compares hash values. If hash values are identical, the server provides a reply to the DNS client with the requested DNS data, such as a host (A) resource record. If hash values don't match, the server replies with a SERVFAIL message. In this way, a DNSSEC-capable, resolving DNS server with a valid trust anchor installed protects against DNS spoofing attacks whether or not DNS clients are DNSSEC-aware.

Additionally, if the DNS client is DNSSEC-aware, it can be configured to require that the DNS server perform DNSSEC validation.

## DNSSEC in the DNS query and response process

A simple example illustrates how you can incorporate DNSSEC into the DNS query-and-response process to provide validation.

In the following example, a DNS client computer queries a recursive (caching) DNS server, which in turn queries authoritative DNS servers before returning a response. This example assumes that DNS data isn't yet cached on the client or server. If a zone is signed with DNSSEC, and if DNS servers and clients are DNSSEC-aware, then DNSSEC data can be used to validate that DNS responses are genuine.

The following figure shows the recursive DNS query process.

![Recursive DNS query process](RackMultipart20230503-1-77xmoi_html_49ac0cb03196381.gif) alt-text="Screenshot shows the New Item option in Data Explorer in the Azure portal."

The following table shows the steps in a DNS query and response with optional DNSSEC data.

| **Step** | **Query-response** | **Optional DNSSEC data** |
| --- | --- | --- |
| 1 | A DNS client sends a DNS query to a recursive DNS server. | The DNS client can indicate that it's DNSSEC-aware (DO=1). |
| --- | --- | --- |
| 2 | The recursive DNS server sends a DNS query to the root and top-level domain (TLD) DNS servers. | The recursive DNS server can indicate that it's DNSSEC-aware (DO=1). |
| 3 | The root and TLD servers return a DNS response to the recursive DNS server providing the IP address of the authoritative DNS server for the zone. | Authoritative servers for the parent zone can indicate that the child zone is signed using DNSSEC and include a secure delegation (DS record). |
| 4 | The recursive DNS server sends a DNS query to the authoritative DNS server for the zone. | The recursive DNS server can indicate that it's DNSSEC-aware (DO=1) and capable of validating signed resource records (CD=1) to be sent in the response. |
| 5 | The authoritative DNS server returns a DNS response to the recursive DNS server, providing the resource record data. | The authoritative DNS server can include DNSSEC signatures in the form of RRSIG records in the DNS response, for use in validation. |
| 6 | The recursive DNS server returns a DNS response to the DNS client, providing the resource record data. | The recursive DNS server can indicate whether or not the DNS response was validated (AD=1) using DNSSEC. |

### Including DNSSEC data

Three important DNSSEC-related flags (bits) that are mentioned in the preceding table and described in the following section are used in a DNS query and response to determine whether or not DNSSEC data is included and whether or not validation was performed. These flags are set by turning on or turning off extended data bits in the DNS packet header. When these flags are turned on, this is referred to as "setting" the bit (value is set to 1). Turning a flag off is referred to as "clearing" the bit (value is set to 0).

- **DO** : The DO bit is included in a DNS query and is an abbreviation for "DNSSEC OK". If the DO bit is set (DO=1), then the client is DNSSEC-aware, and it's safe for the DNS server to return DNSSEC data in a response. If the DO bit isn't set (DO=0), then the client isn't DNSSEC-aware, and the DNS server can't include any DNSSEC data in a DNS response. DNS clients can still be protected by DNSSEC even if they're not DNSSEC-aware. In this context, a DNS client is any computer that sends a DNS query. When a recursive DNS server sends a query to the authoritative DNS server, the recursive DNS server must indicate that it's DNSSEC-aware so that the authoritative DNS server will send DNSSEC data in the response.
- **AD** : The AD bit is included in a DNS response and is an abbreviation for "authenticated data". If the AD bit is set (AD=1), then it means the DNS response is authentic because it was validated using DNSSEC. A non-validating DNSSEC-aware computer, such as one running Windows 8, doesn't perform DNSSEC validation but can be configured to require that DNS responses are authentic. If the AD bit isn't set (AD=0), then the DNS response wasn't validated, either because validation was not attempted, or because validation failed.
- **CD** : The CD bit is included in a DNS query and is an abbreviation for "checking disabled". If the CD bit is set (CD=1) in a query, then it means a DNS response should be sent whether or not validation was successfully performed. If the CD bit is't set (CD=0), then a DNS response won't be sent if validation was required and failed. If the CD bit is clear (CD=0), this essentially means "checking enabled" and DNSSEC validation can occur. The CD bit might be set (CD=1) in a query because the host is capable of performing DNSSEC validation, such as a recursive DNS server running Windows Server 2012. A non-validating stub resolver, such as a computer running Windows 8 will always set CD=0.

A fourth important flag (bit) that can be present in a DNS packet header is the AA bit. This flag isn't new with DNSSEC, but it can be used when DNSSEC is deployed:

- **AA** : The AA bit is included in a DNS response and is an abbreviation for "authoritative answer". If the AA bit is set, it means that the DNS response is authentic because it came directly from an authoritative DNS server. A client that requires DNSSEC validation (AD=1) will accept the AA bit instead (AA=1, AD=0) if the client directly queries an authoritative server because authoritative responses don't need to be validated. It would be redundant for an authoritative server to validate its own response.

## Example DNS queries

The following examples display DNS query results that are performed from a DNS client computer running Windows 8.1 using the  **Resolve-DnsName**  cmdlet. The [Resolve-DnsName](https://technet.microsoft.com/library/jj590781.aspx) cmdlet was introduced in Windows Server 2012 and Windows 8 and can be used to display DNS queries that include DNSSEC data.

    > [!IMPORTANT]
    > Do not use the  **nslookup**  command-line tool to test DNSSEC support for a zone. The  **nslookup**  tool uses an internal DNS client that isn't DNSSEC-aware.

**Example 1** : In the following example, a query is sent to a recursive DNS server for an address (A) record in the signed zone  **secure.contoso.com**  with DO=0.

``

PS C:\\> Resolve-DnsName finance.secure.contoso.com –type A -server dns1.contoso.com

Name Type TTL Section IPAddress

---- ---- --- ------- ---------

finance.secure.contoso.com A 2848 Answer 192.168.0.200

``

In this example, the DO bit isn't set because the  **dnssecok**  parameter wasn't included.

**Example 2** : In the following example, the DO=1 flag is set by adding the  **dnssecok**  parameter.

``

PS C:\\> resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.com -dnssecok

Name Type TTL Section IPAddress

---- ---- --- ------- ---------

finance.secure.contoso.com A 2848 Answer 192.168.0.200

Name : finance.secure.contoso.com

QueryType : RRSIG

TTL : 2848

Section : Answer

TypeCovered : A

Algorithm : 8

LabelCount : 4

OriginalTtl : 3600

Expiration : 10/18/2013 8:23:41 PM

Signed : 10/8/2013 7:23:41 PM

Signer : secure.contoso.com

Signature : {86, 229, 217, 39...}

Name : .

QueryType : OPT

TTL : 32768

Section : Additional

Data : {}

``

When DO=0, the DNS server won't send DNSSEC data in the DNS reply. When DO=1, the client indicates that it's able to receive DNSSEC data if available. Because the secure.contoso.com zone is signed, an RRSIG resource record was included with the DNS response when DO=1.

In both example 1 and example 2, validation isn't required for the secure.contoso.com zone because the Name Resolution Policy Table (NRPT) isn't configured to require validation.

You can use the  **Get-DnsClientNrptPolicy**  cmdlet to view current NRPT rules. For more information, see [Get-DnsClientNrptPolicy](https://technet.microsoft.com/library/jj590779.aspx).

**Example 3** : In the following example, an NRPT rule is displayed for secure.contoso.com.

``

PS C:\\> Get-DnsClientNrptPolicy

Namespace : .secure.contoso.com

QueryPolicy :

SecureNameQueryFallback :

DirectAccessIPsecCARestriction :

DirectAccessProxyName :

DirectAccessDnsServers :

DirectAccessEnabled :

DirectAccessProxyType : NoProxy

DirectAccessQueryIPsecEncryption :

DirectAccessQueryIPsecRequired : False

NameServers :

DnsSecIPsecCARestriction :

DnsSecQueryIPsecEncryption :

DnsSecQueryIPsecRequired : False

DnsSecValidationRequired : False

NameEncoding : Utf8WithoutMapping

``

In this example, the value for  **DnsSecValidationRequired**  is  **False**. This means that DNSSEC validation isn't required.

**Example 4** : After enabling DNSSEC validation for secure.contoso.com, the NRPT displays  **True**  for  **DnsSecValidationRequired**. This example only displays the secure.contoso.com namespace, and the  **DnsSecValidationRequired**  parameter.

``

PS C:\\> (Get-DnsClientNrptPolicy -NameSpace secure.contoso.com).DnsSecValidationRequired

True

``

If the value of  **DnsSecValidationRequired**  is  **True** , then DNSSEC-aware client computers will always send queries with DO=1, even if the  **dnssecok**  parameter isn't included.

**Example 5** : When DNSSEC validation is required by the Name Resolution Policy Table (NRPT), the DNSSEC OK bit is automatically set (DO=1) for DNSSEC-aware clients.

``

PS C:\\> resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.com

Name Type TTL Section IPAddress

---- ---- --- ------- ---------

finance.secure.contoso.com A 2848 Answer 192.168.0.200

Name : finance.secure.contoso.com

QueryType : RRSIG

TTL : 2848

Section : Answer

TypeCovered : A

Algorithm : 8

LabelCount : 4

OriginalTtl : 3600

Expiration : 10/18/2013 8:23:41 PM

Signed : 10/8/2013 7:23:41 PM

Signer : secure.contoso.com

Signature : {86, 229, 217, 39...}

Name : .

QueryType : OPT

TTL : 32768

Section : Additional

Data : {}

``

In this example, an RRSIG record is sent in the DNS response in order to fulfill the validation requirements for secure.contoso.com. A valid trust anchor is also configured on the recursive DNS server (dns1.contoso.com).

If a DNS client isn't DNSSEC-aware, the NRPT rule does not apply, and queries are sent with DO=0, even if an NRPT rule exists that requires DNSSEC validation.

**Example 6** : In the following example, the same query is performed as in example 5, but without a valid trust anchor configured on dns1.contoso.com.

``

PS C:\\> resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.com

resolve-dnsname : finance.secure.contoso.com : Unsecured DNS packet

At line:1 char:1

+ resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.co ...

+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+ CategoryInfo : ResourceUnavailable: (finance.secure.contoso.com:String) [Resolve-DnsName], Win32Excepti

on

+ FullyQualifiedErrorId : DNS\_ERROR\_UNSECURE\_PACKET,Microsoft.DnsClient.Commands.ResolveDnsName

``

In this example, DNS resolution fails with the message DNS\_ERROR\_UNSECURE\_PACKET because validation is required by the NRPT but can't be performed due to the lack of a valid trust anchor for the secure.contoso.com zone. The  **Resolve-DnsName**  cmdlet reports detailed results for the type of failure encountered. If the DNS client attempts to resolve finance.secure.contoso.com in order to connect to this host, for example, to share a file, it fails.

## DNSSEC scenarios

Because DNSSEC can be deployed in many different environments with unique server and client settings, it's important to understand how DNS queries and responses are affected.

Consider the following four DNSSEC-related statements. Each statement affects how DNSSEC works in a given scenario:

- The finance.secure.contoso.com resource record is correctly signed with DNSSEC.
- A recursive DNS server is capable of validating responses to a query for finance.secure.contoso.com.
- A DNS client is DNSSEC-aware.
- A DNS client is configured to require validation for all queries in the secure.contoso.com namespace.

Let's consider each of these four statements in more detail.

**DNSSEC signing status** : Because DNSSEC signs all records in the zone, this condition refers to the state of the secure.contoso.com zone -- not just the finance.secure.contoso.com resource record. You can't sign some records and not sign other records. Therefore, the DNSSEC status of finance.secure.contoso.com depends on the DNSSEC status of secure.contoso.com.

- **Signed correctly** : The secure.contoso.com zone can be signed in a valid manner, which enables finance.secure.contoso.com to be validated as genuine. To be valid, the zone must be signed with valid, unexpired keys, and all required DNSSEC-related resource records must be present.

- **Not signed** : The secure.contoso.com zone might not be signed, in which case there'll be no RRSIG record associated with finance.secure.contoso.com, and DNS responses to queries for finance.secure.contoso.com can't be validated. If a client requires validation (condition #4, below) in this scenario, then a DNS query that's sent to a recursive DNS server will fail because the DNS client doesn't accept a non-validated response.  **Note** : If a client directly queries an authoritative server, it doesn't fail validation because the response is already considered authentic.

- **Not signed correctly** : The secure.contoso.com zone might be signed, but not in a valid manner. For example, one or more DNSSEC signing keys might be expired. After initially signing a zone, the zone must periodically be re-signed with new keys before the signing key validity period expires, in order to maintain a secure DNSSEC operational status. The validity period for DNSSEC signing keys should be short enough to maintain security, but long enough to enable easy administration. DNSSEC in Windows Server 2012 and Windows Server 2012 R2 supports automatic key rollover, providing both security and ease of administration for your DNSSEC-signed zones.

**Validation status** : A recursive DNS server with a valid trust anchor (public cryptographic key) for the secure.contoso.com zone will be capable of validating a DNS response for the finance.secure.contoso.com resource record. A recursive DNS server must also support the DNSSEC standards and algorithms that are used to sign the zone.

- **Can validate** : If the recursive DNS server supports all cryptographic algorithms used to sign the secure.contoso.com zone, and it has a valid trust anchor that it can use to decrypt the DNSSEC signature that is associated with the signed resource record, then it can validate the finance.secure.contoso.com resource record as genuine.

- **Cannot validate** : A non-DNSSEC aware DNS server is not capable of validation. Similarly, a DNS server that doesn't currently have a valid trust anchor for the secure.contoso.com zone won't be capable of validating a DNS response for finance.secure.contoso.com. Trust anchors must be updated when a zone is re-signed, for example, during key rollover. DNSSEC in Windows Server 2012 and Windows Server 2012 R2 supports automatic update of trust anchors on key rollover per [RFC 5011](https://www.rfc-editor.org/rfc/rfc5011.txt), "Automated Updates of DNS Security (DNSSEC) Trust Anchors."

**DNSSEC-aware status** : The DNSSEC-aware status of a DNS client depends on the operating system that it's running.  **Note** : The Windows DNS Client service in Windows 7 or Windows Server 2008 R2 and later operating systems are DNSSEC-aware, non-validating stub resolvers. Previous Windows operating systems are non-DNSSEC-aware. The DNS client will inform a DNS server whether or not it's DNSSEC-aware when it sends a DNS query.

- **Both client and server are DNSSEC-aware** : If both the client and the server are DNSSEC-aware, then the DNS response from the server to the client includes the DNSSEC authenticated data (AD) flag. If the DNS response is validated with DNSSEC, then AD=1 is sent. If the DNS response wasn't validated, then AD=0 will be sent.

- **The DNS server is not DNSSEC-aware** : If the DNS server isn't DNSSEC-aware, then no validation is performed, and the AD flag isn't set (AD=0) regardless of whether or not the DNS client is DNSSEC-aware.

- **The DNS client is not DNSSEC-aware** : If the DNS client isn't DNSSEC-aware, the DNS server won't set the AD flag in its response to the client even if it understands DNSSEC. However, if the DNS server is DNSSEC-aware and it has a trust anchor for the zone, the server will attempt to validate the response from the authoritative server. If the validation fails, it returns a DNS server failure to the DNS client. If the validation succeeds, it returns the query results to the client. In this way, a DNSSEC-aware recursive DNS server can protect non-DNSSEC-aware DNS clients. In this scenario, if the zone isn't signed, no validation is attempted and the response is returned normally to the client.

**Validation requirement** : This setting determines the requirement of a DNSSEC-aware DNS client for DNSSEC data (the AD flag) in a response from a DNS server.  **Note** : In order for the DNS client to require validation, it must be DNSSEC-aware. Non-DNSSEC-aware DNS clients cannot be forced to require DNSSEC validation. If the DNS client is directly querying an authoritative DNS server, the response will always appear to be validated, even if the zone isn't signed. This is because authoritative DNS servers always return authentic responses.

- **Validation is required** : If validation is required, the client must receive AD=1 (validation successful) or it rejects the DNS response. If validation was unsuccessful or not attempted (AD=0) then DNS resolution will fail. This is true even if the zone isn't signed.  **Note** : This only applies to queries against a recursive, non-authoritative DNS server.

- **Validation isn't required** : If validation isn't required, the client will accept a response from a non-DNSSEC-aware recursive DNS server. However, if the recursive DNS server is DNSSEC-aware and validation fails, it returns a server failover to the client even if the client doesn't require validation.

## Related links