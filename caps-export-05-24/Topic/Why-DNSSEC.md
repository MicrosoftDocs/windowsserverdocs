---
title: Why DNSSEC
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 94d5a6ea-1099-4d5b-afa0-ace204a718d4
---
# Why DNSSEC
A DNS zone that is signed with DNSSEC is more secure, but is also associated with more administrative tasks. Before you sign a zone with DNSSEC, consider both the potential advantages and disadvantages.  
  
## In this section  
  
-   [Why to deploy DNSSEC](../Topic/Why-DNSSEC.md#why)  
  
    -   [DNS spoofing](../Topic/Why-DNSSEC.md#spoof)  
  
-   [Signing domain zones](../Topic/Why-DNSSEC.md#domain)  
  
-   [Signed zones](../Topic/Why-DNSSEC.md#admin)  
  
## <a name="why"></a>Why to deploy DNSSEC  
In environments that do not employ security technologies such as IPsec or HTTPS, the DNS protocol can be vulnerable to attack due to an inherent lack of authentication and integrity checking of data that is exchanged between DNS servers or is sent to DNS clients. As originally designed, DNS itself does not offer any form of security and is vulnerable to spoofing and man\-in\-the\-middle attacks. An attacker that has compromised a DNS server can gain access to all network communications that are sent by a targeted host. If DNS servers are vulnerable to attack, it can be critical to secure them with DNSSEC.  
  
DNSSEC includes changes to client and server DNS components that enable DNS data to be cryptographically signed and to enforce name validation policies that protect DNS communications. With DNSSEC, a DNS server can validate responses that it receives as genuine. By validating DNS responses, DNS servers and clients are protected against the single greatest vulnerability in DNS: DNS spoofing.  
  
### <a name="spoof"></a>DNS spoofing  
DNS spoofing is the practice of assuming the DNS name of another system either by corrupting a name service cache or by compromising a DNS server for a valid domain. When a DNS resolver sends a remote query, it tags the query with a 16\-bit XID \(transaction ID\) value in the DNS packet header and expects that the remote DNS server will respond on the same port with the same XID value. The query is typically sent over UDP, which is more vulnerable to attacks than TCP because of TCP’s three step "handshake". Generally, TCP is only used after a UDP response has been truncated. When the resolver receives a UDP DNS response, it can only weakly verify that the response is authentic by matching the following parameters:  
  
-   **Remote DNS server address**: This check is often disabled by default because many network devices make it appear that valid responses come from a different address than the query was sent to, making it even easier to spoof a DNS response.  
  
-   **Port on which the packet was received**: The resolver typically sends from an ephemeral port to port 53. DNS servers respond from port 53 to whatever source port was used by the requestor.  
  
-   **Packet XID value**: The XID value is set in the request by the resolver and must match the value that is contained in the response. A strongly random value can and should be used for the XID, but it is only 16 bits long. The XID value, like the rest of the DNS packet, is sent in the clear \(unencrypted\).  
  
-   **Query name and type**: The DNS server echoes the query name and type in the question section of the DNS response.  
  
If attackers have access to a DNS client or server’s network traffic, they might be able to guess that a DNS client or server has sent a DNS query and is waiting for a DNS response. When they have determined this case to be true, the attackers can send one or more spoofed DNS response packets and attempt to beat the authentic response back to the requestor. An attacker \(or a botnet under their control\) can attack DNS clients and DNS servers that send remote DNS queries. Because the attacker controls the time\-to\-live \(TTL\) that is assigned to the spoofed response, once the attack is successful, it can persist for days, weeks, or even longer.  
  
The following figure shows how DNSSEC validation can be used to prevent spoofing attacks on DNS clients and recursive DNS servers that are meant to redirect client computers to malicious sites.  
  
![](../Image/DNSSEC_spoofing.gif)  
  
With DNSSEC, a DNS client computer can ignore DNS responses that are not validated as genuine by a recursive DNS server. Recursive DNS servers will also fail to validate non\-authentic DNS responses after checking digital signatures. In this way, DNSSEC can be an effective method to prevent DNS spoofing attacks.  
  
## <a name="domain"></a>Signing domain zones  
Public DNS zones that are connected to the Internet and must be available to customers and vendors are particularly vulnerable to attack. These kinds of zones can often benefit from DNSSEC protection. Usually these zones are not domain zones or are not otherwise part of an Active Directory Domain Services \(AD DS\) infrastructure.  
  
Internal zones are typically less vulnerable to attack, either because they are not exposed to the Internet or because other security protocols have been implemented to protect them. These zones might not benefit as much from signing with DNSSEC and might be associated with more of an administrative burden because of multiple domain\-joined client computers that require access to domain services such as LDAP, Net Logon, Kerberos, and others. However, some domain zones are required to be signed, such as those controlled by government agencies. Because internal domain zones often provide support for additional services that are not implemented by public DNS zones, it is even more important to appropriately manage your DNSSEC deployment when you sign these types of zones.  
  
In general, if an internal domain zone is not at risk for attack, it is not advisable to sign it with DNSSEC unless it is required by government or corporate policy.  
  
## <a name="admin"></a>Signed zones  
Because DNSSEC adds additional records to a zone and requires encryption and decryption of DNS messages, signing a zone with DNSSEC increases its administrative burden and is associated with a performance impact on DNS infrastructure. In addition, because any cryptographic security protocol like DNSSEC can be subject to brute force attacks, it is advisable to roll over \(replace\) cryptographic keys on a regular basis, which adds further to management requirements. For more information about requirements for signed zones, see [DNS Zones](../Topic/DNS-Zones.md).  
  
The length of a cryptographic key \(in DNSSEC, a KSK or ZSK\) also affects its ability to be compromised using brute force methods. Longer keys are more difficult to break, but they are also associated with a greater performance impact. For more information about the performance impact of different cryptographic algorithms and key lengths, see [DNSSEC Performance Considerations](../Topic/DNSSEC-Performance-Considerations.md).  
  
It is therefore necessary to balance security with manageability and performance when you configure zone signing parameters and decide whether or not to sign a zone. Do not sign a zone that will not benefit from enhanced security, and if you decide to sign a zone, make sure to stage your DNSSEC deployment carefully so that you fully understand the performance and administrative impacts. For more information about staging a DNSSEC deployment, see [Stage a DNSSEC Deployment](../Topic/Stage-a-DNSSEC-Deployment.md).  
  
If you decide to sign a zone, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] provide excellent DNSSEC support to simplify management tasks and integrate with other systems. They include:  
  
-   Support for Active Directory\-integrated DNS scenarios, which include DNS dynamic updates in DNSSEC\-signed zones.  
  
-   Support for updated DNSSEC standards, including NSEC3 and RSA\/SHA\-2.  
  
-   Automated trust anchor distribution through Active Directory.  
  
-   Automated trust anchor rollover support per RFC 5011.  
  
-   Updated user interface with deployment and management wizards.  
  
-   Validation of records that are signed with updated DNSSEC standards \(NSEC3 and RSA\/SHA\-2\).  
  
-   Easy extraction of the root trust anchor.  
  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], DNSSEC support is enhanced with additional Windows PowerShell and key management support. For more information, see [What's New in DNS Server in Windows Server 2012 R2](assetId:///e36880f8-70a1-41cd-8341-fb7a9d0c009c).  
  
## <a name="also"></a>See also  
[Stage a DNSSEC Deployment](../Topic/Stage-a-DNSSEC-Deployment.md)  
  
[DNSSEC Performance Considerations](../Topic/DNSSEC-Performance-Considerations.md)  
  
[DNSSEC Requirements](../Topic/DNSSEC-Requirements.md)  
  
