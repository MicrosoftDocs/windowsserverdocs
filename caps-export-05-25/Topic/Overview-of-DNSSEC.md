---
title: Overview of DNSSEC
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7d965d5b-bcde-4db1-a438-542601f38e3f
author: vhorne
---
# Overview of DNSSEC
Domain Name System Security Extensions \(DNSSEC\) is a suite of extensions that add security to the Domain Name System \(DNS\) protocol by enabling DNS responses to be validated. Specifically, DNSSEC provides origin authority, data integrity, and authenticated denial of existence. With DNSSEC, the DNS protocol is much less susceptible to certain types of attacks, particularly DNS spoofing attacks.  
  
The core DNSSEC extensions are specified in the following Request for Comments \(RFCs\). Additional RFCs provide supporting information.  
  
-   [RFC 4033](http://www.rfc-editor.org/rfc/rfc4033.txt): "DNS Security Introduction and Requirements"  
  
-   [RFC 4034](http://www.rfc-editor.org/rfc/rfc4034.txt): "Resource Records for the DNS Security Extensions"  
  
-   [RFC 4035](http://www.rfc-editor.org/rfc/rfc4035.txt): "Protocol Modifications for the DNS Security Extensions"  
  
## In this section  
  
-   [How DNSSEC works](../Topic/Overview-of-DNSSEC.md#how)  
  
    -   [DNSSEC\-related resource records](../Topic/Overview-of-DNSSEC.md#RR)  
  
    -   [Validation of DNS responses](../Topic/Overview-of-DNSSEC.md#validation)  
  
    -   [Example DNS queries](../Topic/Overview-of-DNSSEC.md#example)  
  
    -   [DNSSEC scenarios](../Topic/Overview-of-DNSSEC.md#scenarios)  
  
## <a name="how"></a>How DNSSEC works  
If supported by an authoritative DNS server, a DNS zone can be secured with DNSSEC using a process called zone signing. Signing a zone with DNSSEC adds validation support to a zone without changing the basic mechanism of a DNS query and response.  
  
Validation of DNS responses occurs through the use of digital signatures that are included with DNS responses. These digital signatures are contained in new, DNSSEC\-related resource records that are generated and added to the zone during zone signing.  
  
The following figure shows DNS resource records in the zone contoso.com before and after zone signing.  
  
![](../Image/DNSSEC_intro.png)  
  
For more information about each of these resource records, see the following section, [DNSSEC\-related resource records](../Topic/Overview-of-DNSSEC.md#RR).  
  
When a DNSSEC\-aware recursive or forwarding DNS server receives a query from a DNS client for a DNSSEC\-signed zone, it will request that the authoritative DNS server also send DNSSEC records, and then attempt to validate the DNS response using these records. A recursive or forwarding DNS server recognizes that the zone supports DNSSEC if it has a DNSKEY, also called a trust anchor, for that zone.  
  
> [!NOTE]  
> A non\-authoritative DNS server might use recursion or forwarding to resolve a DNS query. This topic refers to the non\-authoritative server as a recursive DNS server; however, if the server uses forwarding, then the process used for DNSSEC validation of DNS responses is the same.  
  
**DNSSEC validation**  
  
A recursive DNS server uses the DNSKEY resource record to validate responses from the authoritative DNS server by decrypting digital signatures that are contained in DNSSEC\-related resource records, and then by computing and comparing hash values. If hash values are the same, it provides a reply to the DNS client with the DNS data that it requested, such as a host \(A\) resource record. If hash values are not the same, it replies with a SERVFAIL message. In this way, a DNSSEC\-capable, resolving DNS server with a valid trust anchor installed protects against DNS spoofing attacks whether or not DNS clients are DNSSEC\-aware.  
  
Additionally, if the DNS client is DNSSEC\-aware, it can be configured to require that the DNS server perform DNSSEC validation.  
  
The following figure shows the validation process.  
  
![](../Image/DNSSEC_validation.png)  
  
DNSKEYs are used to compute hash values and decrypt RRSIG records. The figure does not display all validation processes that are performed. Additional validation is also carried out to ensure the DNSKEYs are valid and that DS records are valid, if they exist \(not shown above\).  
  
For additional information about how DNSSEC data can be added to the DNS query and response process, see the following section, [Validation of DNS responses](../Topic/Overview-of-DNSSEC.md#validation).  
  
### <a name="RR"></a>DNSSEC\-related resource records  
The following table shows the new resource record types that are used with DNSSEC.  
  
|Resource record type|Description|  
|------------------------|---------------|  
|Resource record signature \(RRSIG\)|Signatures that are generated with DNSSEC are contained in RRSIG records. Each RRSIG record is matched to another record in the zone for which it provides a digital signature.<br /><br />When a resolver issues a query for a name, one or more RRSIG records are returned in the response.|  
|Next Secure \(NSEC\)|An NSEC record is used to prove nonexistence of a DNS name. NSEC records prevent spoofing attacks that are intended to fool a DNS client into believing that a DNS name does not exist.|  
|Next Secure 3 \(NSEC3\)|NSEC3 is a replacement or alternative to NSEC that has the additional benefit of preventing "zone walking" which is the process of repeating NSEC queries in order to retrieve all the names in a zone. A DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]or a later operating systemsupports both NSEC and NSEC3. A zone can be signed with either NSEC or NSEC3, but not both.|  
|Next Secure 3 Parameter \(NSEC3PARAM\)|The NSEC3PARAM record is used to determine which NSEC3 records to include in responses for non\-existing DNS names.|  
|DNS Key \(DNSKEY\)|A DNSKEY resource record stores a public cryptographic key that is used to verify a signature. The DNSKEY record is used by a DNS server during the validation process.<br /><br />DNSKEY records can store public keys for a zone signing key \(ZSK\) or a key signing key \(KSK\).|  
|Delegation Signer \(DS\)|A DS record is a DNSSEC record type that is used to secure a delegation. DS records are used to build authentication chains to child zones.|  
  
**Addition of DNSSEC\-related resource records**  
  
With the exception of the DS record, all of these records are added to a zone automatically when it is signed with DNSSEC. The DS record is a special record that can be manually added to a parent zone to create a secure delegation for a child zone. For example, the contoso.com zone can contain a DS record for secure.contoso.com; however this record must either be created in the parent zone, or created in a child zone and then propagated to the parent zone. The DS record is not automatically created when you sign a zone.  
  
NSEC or NSEC3 records are automatically added to a zone during zone signing. However, a signed zone cannot have both NSEC and NSEC3 records. The type of record \(NSEC or NSEC3\) added to the zone depends on how zone signing is configured. In the previous example, the zone is signed using NSEC3.  
  
**Trust anchors**  
  
DNSKEY and DS resource records are also called **trust anchors** or **trust points**. A trust anchor must be distributed to all nonauthoritative DNS servers that will perform DNSSEC validation of DNS responses for a signed zone. If the DNS server is running on a domain controller, trust anchors are stored in the forest directory partition in Active Directory Domain Services \(AD DS\) and can be replicated to all domain controllers in the forest. On standalone DNS servers, trust anchors are stored in a file named **TrustAnchors.dns**. A DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system also displays configured trust anchors in the DNS Manager console tree in the **Trust Points** container. You can also use Windows PowerShell or dnscmd.exe to view trust anchors \(note: dnscmd.exe is deprecated and might be removed in a future version of Windows Server\).  
  
The following example shows the Windows PowerShell cmdlet **Get\-DnsServerTrustAnchor**.  
  
```  
PS C:\> Get-DnsServerTrustAnchor -Name secure.contoso.com  
  
TrustAnchorName                TrustAnchorType      TrustAnchorState     TrustAnchorData  
---------------                ---------------      ----------------     ---------------  
secure.contoso.com.            DNSKEY               Valid                [15952][DnsSec][RsaSha256][AwEAAe3JOsLYe17k...  
secure.contoso.com.            DNSKEY               Valid                [38431][DnsSec][RsaSha256][AwEAAdsXYyqxjwBc...  
```  
  
To view all the current trust points on a server, you can use the **Get\-DnsServerTrustPoint** cmdlet.  
  
```  
PS C:\> Get-DnsServerTrustPoint  
  
TrustPointName                           TrustPointState      LastActiveRefreshTime     NextActiveRefreshTime  
--------------                           ---------------      ---------------------     ---------------------  
secure.contoso.com.                      Active               10/11/2013 4:44:21 PM     10/15/2013 11:22:27 AM  
```  
  
For information about how DNSSEC uses these new resource records to validate and secure DNS responses, see the following section.  
  
### <a name="validation"></a>Validation of DNS responses  
The following figure and table provide a simplified illustration of how DNSSEC can be incorporated into the DNS query and response process to provide validation.  
  
In the example, a DNS client computer queries a recursive \(caching\) DNS server, which in turn queries authoritative DNS servers before returning a response. This example assumes that DNS data is not yet cached on the client or server. If a zone is signed with DNSSEC, and if DNS servers and clients are DNSSEC\-aware, then DNSSEC data can be used to validate that DNS responses are genuine.  
  
The following figure shows the recursive DNS query process.  
  
![](../Image/DNSSEC_query3.png)  
  
The following table shows the steps in a DNS query and response with optional DNSSEC data.  
  
|Step|Query\-response|Optional DNSSEC data|  
|--------|-------------------|------------------------|  
|1|A DNS client sends a DNS query to a recursive DNS server.|The DNS client can indicate that it is DNSSEC\-aware \(DO\=1\).|  
|2|The recursive DNS server sends a DNS query to the root and top\-level domain \(TLD\) DNS servers.|The recursive DNS server can indicate that it is DNSSEC\-aware \(DO\=1\).|  
|3|The root and TLD servers return a DNS response to the recursive DNS server providing the IP address of the authoritative DNS server for the zone.|Authoritative servers for the parent zone can indicate that the child zone is signed using DNSSEC and include a secure delegation \(DS record\).|  
|4|The recursive DNS server sends a DNS query to the authoritative DNS server for the zone.|The recursive DNS server can indicate that it is DNSSEC\-aware \(DO\=1\) and capable of validating signed resource records \(CD\=1\) to be sent in the response.|  
|5|The authoritative DNS server returns a DNS response to the recursive DNS server, providing the resource record data.|The authoritative DNS server can include DNSSEC signatures in the form of RRSIG records in the DNS response, for use in validation.|  
|6|The recursive DNS server returns a DNS response to the DNS client, providing the resource record data.|The recursive DNS server can indicate whether or not the DNS response was validated \(AD\=1\) using DNSSEC.|  
  
**Including DNSSEC data:**  
  
Three important DNSSEC\-related flags \(bits\) that are mentioned in the preceding table and described in the following section are used in a DNS query and response to determine whether or not DNSSEC data is included and whether or not validation was performed. These flags are set by turning on or turning off extended data bits in the DNS packet header. When these flags are turned on, this is referred to as "setting" the bit which corresponds to a value of one \(1\). Turning a flag off is referred to as "clearing" the bit and corresponds to a value of zero \(0\).  
  
-   **DO**: The DO bit is included in a DNS query and is an abbreviation for "DNSSEC OK". If the DO bit is set \(DO\=1\), then the client is DNSSEC\-aware, and it is OK for the DNS server to return DNSSEC data in a response. If the DO bit is not set \(DO\=0\), then the client is not DNSSEC\-aware, and the DNS server must not include any DNSSEC data in a DNS response. DNS clients can still be protected by DNSSEC even if they are not DNSSEC\-aware. In this context, a DNS client is any computer that sends a DNS query. When a recursive DNS server sends a query to the authoritative DNS server, the recursive DNS server must indicate that it is DNSSEC\-aware so that the authoritative DNS server will send DNSSEC data in the response.  
  
-   **AD**: The AD bit is included in a DNS response and is an abbreviation for "authenticated data". If the AD bit is set \(AD\=1\), then it means the DNS response is authentic because it was validated using DNSSEC. A non\-validating DNSSEC\-aware computer, such as one running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], does not perform DNSSEC validation but can be configured to require that DNS responses are authentic. If the AD bit is not set \(AD\=0\), then the DNS response was not validated, either because validation was not attempted, or because validation failed.  
  
-   **CD**: The CD bit is included in a DNS query and is an abbreviation for "checking disabled". If the CD bit is set \(CD\=1\) in a query, then it means a DNS response should be sent whether or not validation was successfully performed. If the CD bit is not set \(CD\=0\), then a DNS response will not be sent if validation was required and failed. If the CD bit is clear \(CD\=0\), this essentially means “checking enabled” and DNSSEC validation can occur. The CD bit might be set \(CD\=1\) in a query because the host is capable of performing DNSSEC validation, such as a recursive DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. A non\-validating stub resolver, such as a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] will always set CD\=0.  
  
A fourth important flag \(bit\) that can be present in a DNS packet header is the AA bit. This flag is not new with DNSSEC, but it can be used when DNSSEC is deployed:  
  
-   **AA**: The AA bit is included in a DNS response and is an abbreviation for "authoritative answer". If the AA bit is set, it means that the DNS response is authentic because it came directly from an authoritative DNS server. A client that requires DNSSEC validation \(AD\=1\) will accept the AA bit instead \(AA\=1, AD\=0\) if the client directly queries an authoritative server because authoritative responses do not need to be validated. It would be redundant for an authoritative server to validate its own response.  
  
### <a name="example"></a>Example DNS queries  
The following examples display DNS query results that are performed from a DNS client computer running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] using the **Resolve\-DnsName** cmdlet. The [Resolve\-DnsName](http://technet.microsoft.com/library/jj590781.aspx) cmdlet was introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and can be used to display DNS queries that include DNSSEC data.  
  
> [!IMPORTANT]  
> Do not use the **nslookup** command\-line tool to test DNSSEC support for a zone. The **nslookup** tool uses an internal DNS client that is not DNSSEC\-aware.  
  
**Example 1**: In the following example, a query is sent to a recursive DNS server for an address \(A\) record in the signed zone **secure.contoso.com**with DO\=0.  
  
```  
PS C:\> Resolve-DnsName finance.secure.contoso.com –type A -server dns1.contoso.com  
  
Name                                           Type   TTL   Section    IPAddress  
----                                           ----   ---   -------    ---------  
finance.secure.contoso.com                     A      2848  Answer     192.168.0.200  
```  
  
In this example, the DO bit was not set because the **dnssecok** parameter was not included.  
  
**Example 2**: In the following example, the DO\=1 flag is set by adding the **dnssecok** parameter.  
  
```  
PS C:\> resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.com -dnssecok  
  
Name                                           Type   TTL   Section    IPAddress  
----                                           ----   ---   -------    ---------  
finance.secure.contoso.com                     A      2848  Answer     192.168.0.200  
  
Name        : finance.secure.contoso.com  
QueryType   : RRSIG  
TTL         : 2848  
Section     : Answer  
TypeCovered : A  
Algorithm   : 8  
LabelCount  : 4  
OriginalTtl : 3600  
Expiration  : 10/18/2013 8:23:41 PM  
Signed      : 10/8/2013 7:23:41 PM  
Signer      : secure.contoso.com  
Signature   : {86, 229, 217, 39...}  
  
Name      : .  
QueryType : OPT  
TTL       : 32768  
Section   : Additional  
Data      : {}  
```  
  
When DO\=0, the DNS server will not send DNSSEC data in the DNS reply. When DO\=1, the client indicates that it is able to receive DNSSEC data if available. Because the secure.contoso.com zone is signed, an RRSIG resource record was included with the DNS response when DO\=1.  
  
In both example 1 and example 2, validation is not required for the secure.contoso.com zone because the Name Resolution Policy Table \(NRPT\) is not configured to require validation.  
  
You can use the **Get\-DnsClientNrptPolicy** cmdlet to view current NRPT rules. For more information, see [Get\-DnsClientNrptPolicy](http://technet.microsoft.com/library/jj590779.aspx).  
  
**Example 3**: In the following example, an NRPT rule is displayed for secure.contoso.com.  
  
```  
PS C:\> Get-DnsClientNrptPolicy  
  
Namespace                        : .secure.contoso.com  
QueryPolicy                      :  
SecureNameQueryFallback          :  
DirectAccessIPsecCARestriction   :  
DirectAccessProxyName            :  
DirectAccessDnsServers           :  
DirectAccessEnabled              :  
DirectAccessProxyType            : NoProxy  
DirectAccessQueryIPsecEncryption :  
DirectAccessQueryIPsecRequired   : False  
NameServers                      :  
DnsSecIPsecCARestriction         :  
DnsSecQueryIPsecEncryption       :  
DnsSecQueryIPsecRequired         : False  
DnsSecValidationRequired         : False  
NameEncoding                     : Utf8WithoutMapping  
```  
  
In this example, the value for **DnsSecValidationRequired** is **False**. This means that DNSSEC validation is not required.  
  
**Example 4**: After enabling DNSSEC validation for secure.contoso.com, the NRPT displays **True** for **DnsSecValidationRequired**. This example only displays the secure.contoso.com namespace, and the **DnsSecValidationRequired** parameter.  
  
```  
PS C:\> (Get-DnsClientNrptPolicy -NameSpace secure.contoso.com).DnsSecValidationRequired  
True  
```  
  
If the value of **DnsSecValidationRequired** is **True**, then DNSSEC\-aware client computers will always send queries with DO\=1, even if the **dnssecok** parameter is not included.  
  
**Example 5**: When DNSSEC validation is required by the Name Resolution Policy Table \(NRPT\), the DNSSEC OK bit is automatically set \(DO\=1\) for DNSSEC\-aware clients.  
  
```  
PS C:\> resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.com  
  
Name                                           Type   TTL   Section    IPAddress  
----                                           ----   ---   -------    ---------  
finance.secure.contoso.com                     A      2848  Answer     192.168.0.200  
  
Name        : finance.secure.contoso.com  
QueryType   : RRSIG  
TTL         : 2848  
Section     : Answer  
TypeCovered : A  
Algorithm   : 8  
LabelCount  : 4  
OriginalTtl : 3600  
Expiration  : 10/18/2013 8:23:41 PM  
Signed      : 10/8/2013 7:23:41 PM  
Signer      : secure.contoso.com  
Signature   : {86, 229, 217, 39...}  
  
Name      : .  
QueryType : OPT  
TTL       : 32768  
Section   : Additional  
Data      : {}  
```  
  
In this example, an RRSIG record is sent in the DNS response in order to fulfill the validation requirements for secure.contoso.com. A valid trust anchor is also configured on the recursive DNS server \(dns1.contoso.com\).  
  
If a DNS client is not DNSSEC\-aware, the NRPT rule does not apply, and queries are sent with DO\=0, even if an NRPT rule exists that requires DNSSEC validation.  
  
**Example 6**: In the following example, the same query is performed as in example 5, but without a valid trust anchor configured on dns1.contoso.com.  
  
```  
PS C:\> resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.com  
resolve-dnsname : finance.secure.contoso.com : Unsecured DNS packet  
At line:1 char:1  
+ resolve-dnsname -name finance.secure.contoso.com -type A -server dns1.contoso.co ...  
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
    + CategoryInfo          : ResourceUnavailable: (finance.secure.contoso.com:String) [Resolve-DnsName], Win32Excepti  
   on  
    + FullyQualifiedErrorId : DNS_ERROR_UNSECURE_PACKET,Microsoft.DnsClient.Commands.ResolveDnsName  
```  
  
In this example, DNS resolution fails with the message DNS\_ERROR\_UNSECURE\_PACKET because validation is required by the NRPT but cannot be performed due to the lack of a valid trust anchor for the secure.contoso.com zone. The **Resolve\-DnsName** cmdlet reports detailed results for the type of failure encountered. If the DNS client attempts to resolve finance.secure.contoso.com in order to connect to this host, for example, to share a file, it fails.  
  
### <a name="scenarios"></a>DNSSEC scenarios  
Because DNSSEC can be deployed in many different environments with unique server and client settings, it is important to understand how DNS queries and responses are affected.  
  
Consider the following four DNSSEC\-related statements. Each statement affects how DNSSEC works in a given scenario:  
  
1.  The finance.secure.contoso.com resource record is correctly signed with DNSSEC.  
  
2.  A recursive DNS server is capable of validating responses to a query for finance.secure.contoso.com.  
  
3.  A DNS client is DNSSEC\-aware.  
  
4.  A DNS client is configured to require validation for all queries in the secure.contoso.com namespace.  
  
Let’s examine each of these conditions, and their consequences, in more detail:  
  
1.  **DNSSEC signing status**: Because DNSSEC signs all records in the zone, this condition refers to the state of the secure.contoso.com zone, and not just the finance.secure.contoso.com resource record. You cannot sign some records and not sign other records; therefore, the DNSSEC status of finance.secure.contoso.com depends on the DNSSEC status of secure.contoso.com.  
  
    -   **Signed correctly**: The secure.contoso.com zone can be signed in a valid manner, which enables finance.secure.contoso.com to be validated as genuine. To be valid, the zone must be signed with valid, unexpired keys, and all required DNSSEC\-related resource records must be present.  
  
    -   **Not signed**: The secure.contoso.com zone might not be signed, in which case there will be no RRSIG record associated with finance.secure.contoso.com, and DNS responses to queries for finance.secure.contoso.com cannot be validated. If a client requires validation \(condition \#4 below\) in this scenario, then a DNS query that is sent to a recursive DNS server will fail because the DNS client does not accept a non\-validated response. **Note**: If a client directly queries an authoritative server, it does not fail validation because the response is already considered authentic.  
  
    -   **Not signed correctly**: The secure.contoso.com zone might be signed, but not in a valid manner. For example, one or more DNSSEC signing keys might be expired. After initially signing a zone, the zone must periodically be re\-signed with new keys before the signing key validity period expires, in order to maintain a secure DNSSEC operational status. The validity period for DNSSEC signing keys should be short enough to maintain security, but long enough to enable easy administration. DNSSEC in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] supports automatic key rollover, providing both security and ease of administration for your DNSSEC\-signed zones.  
  
2.  **Validation status**: A recursive DNS server with a valid trust anchor \(public cryptographic key\) for the secure.contoso.com zone will be capable of validating a DNS response for the finance.secure.contoso.com resource record. A recursive DNS server must also support the DNSSEC standards and algorithms that are used to sign the zone.  
  
    -   **Can validate**: If the recursive DNS server supports all cryptographic algorithms used to sign the secure.contoso.com zone, and it has a valid trust anchor that it can use to decrypt the DNSSEC signature that is associated with the signed resource record, then it can validate the finance.secure.contoso.com resource record as genuine.  
  
    -   **Cannot validate**: A non\-DNSSEC aware DNS server is not capable of validation. Similarly, a DNS server that does not currently have a valid trust anchor for the secure.contoso.com zone will not be capable of validating a DNS response for finance.secure.contoso.com. Trust anchors must be updated when a zone is re\-signed, for example, during key rollover. DNSSEC in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] supports automatic update of trust anchors on key rollover per [RFC 5011](http://www.rfc-editor.org/rfc/rfc5011.txt), “Automated Updates of DNS Security \(DNSSEC\) Trust Anchors.”  
  
3.  **DNSSEC\-aware status**: The DNSSEC\-aware status of a DNS client depends on the operating system that it is running. **Note**: The Windows DNS Client service in [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]and later operating systems are DNSSEC\-aware, non\-validating stub resolvers. Previous Windows operating systems are non\-DNSSEC\-aware. The DNS client will inform a DNS server whether or not it is DNSSEC\-aware when it sends a DNS query.  
  
    -   **Both client and server are DNSSEC\-aware**: If both the client and the server are DNSSEC\-aware, then the DNS response from the server to the client will include the DNSSEC authenticated data \(AD\) flag. If the DNS response is validated with DNSSEC, then AD\=1 will be sent. If the DNS response was not validated, then AD\=0 will be sent.  
  
    -   **The DNS server is not DNSSEC\-aware**: If the DNS server is not DNSSEC\-aware, then no validation is performed, and the AD flag is not set \(AD\=0\) regardless of whether or not the DNS client is DNSSEC\-aware.  
  
    -   **The DNS client is not DNSSEC\-aware**: If the DNS client is not DNSSEC\-aware, the DNS server will not set the AD flag in its response to the client even if it understands DNSSEC. However, if the DNS server is DNSSEC\-aware and it has a trust anchor for the zone, the server will attempt to validate the response from the authoritative server. If the validation fails, it will return a DNS server failure to the DNS client. If the validation succeeds, it will return the query results to the client.  In this way, a DNSSEC\-aware recursive DNS server can protect non\-DNSSEC\-aware DNS clients. In this scenario, if the zone is not signed, no validation is attempted and the response is returned normally to the client.  
  
4.  **Validation requirement**: This setting determines the requirement of a DNSSEC\-aware DNS client for DNSSEC data \(the AD flag\) in a response from a DNS server. **Note**: In order for the DNS client to require validation, it must be DNSSEC\-aware. Non\-DNSSEC\-aware DNS clients cannot be forced to require DNSSEC validation. If the DNS client is directly querying an authoritative DNS server, the response will always appear to be validated, even if the zone is not signed. This is because authoritative DNS servers always return authentic responses.  
  
    -   **Validation is required**: If validation is required, the client must receive AD\=1 \(validation successful\) or it will reject the DNS response.  If validation was unsuccessful or not attempted \(AD\=0\) then DNS resolution will fail. This is true even if the zone is not signed. **Note**: This only applies to queries against a recursive, non\-authoritative DNS server.  
  
    -   **Validation is not required**: If validation is not required, the client will accept a response from a non\-DNSSEC\-aware recursive DNS server. However, if the recursive DNS server is DNSSEC\-aware and validation fails, it will return a server failover to the client even if the client does not require validation.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Deploy DNSSEC with Windows Server 2012](../Topic/Deploy-DNSSEC-with-Windows-Server-2012.md)  
  
[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)  
  
[Appendix B: Windows PowerShell for DNS Server](../Topic/Appendix-B--Windows-PowerShell-for-DNS-Server.md)  
  
[DNS Overview](assetId:///53305fd6-54fd-45ca-9ff0-19686f48257d)  
  
[Step-by-Step: Demonstrate DNSSEC in a Test Lab](../Topic/Step-by-Step--Demonstrate-DNSSEC-in-a-Test-Lab.md)  
  
