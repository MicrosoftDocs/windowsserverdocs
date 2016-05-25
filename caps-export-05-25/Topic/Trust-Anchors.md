---
title: Trust Anchors
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a3a8cf1f-dc7e-4eca-85f0-fa4f90a76b5e
author: vhorne
---
# Trust Anchors
A trust anchor \(or trust “point”\) is a public cryptographic key for a signed zone. Trust anchors must be configured on every non\-authoritative DNS server that will attempt to validate DNS data. This section discusses some key concepts about trust anchors.  
  
## In this section  
  
-   [Types of trust anchors](../Topic/Trust-Anchors.md#TAs)  
  
-   [Delegations and the chain of trust](../Topic/Trust-Anchors.md#chain)  
  
    -   [The delegation signer \(DS\) record](../Topic/Trust-Anchors.md#DS)  
  
-   [Working with trust anchors](../Topic/Trust-Anchors.md#working_with)  
  
-   [Trust anchor status](../Topic/Trust-Anchors.md#TA_status)  
  
## <a name="TAs"></a>Types of trust anchors  
Trust anchors can be of two types: DNSKEY or DS. Only DNSKEY trust anchors were supported in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Both DNSKEY and DS trust anchors are supported in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For more information about DNSKEY, DS, other DNSSEC\-related resource records, and how to view them, see [DNSSEC\-related resource records](../Topic/Overview-of-DNSSEC.md#RR).  
  
A DNSKEY trust anchor is a public key from a DNSKEY resource record. It is typically larger in size than a DS trust anchor. A DS trust anchor is a hash of a public key. Because it is only a hash, DS trust anchors are typically smaller. The following are examples of DS and DNSKEY trust anchors, respectively:  
  
```  
secure.contoso.com      DS   32801 8 1 (  
                        4E1FD2F988BC942E666132250395123B0A54  
                        D246 )  
                        DS   32801 8 2 (  
                        92838CE772067BF04FA942C44C952384267C  
                        8D8091A700278D9DC5244F973D88 )  
                        DS   53750 8 1 (  
                        1D423EBD2C45D7CD7B957C7D7E7795C1C726  
                        3275 )  
                        DS   53750 8 2 (  
                        1073224EBC9ECFEF5C335A4AD10721EA2894  
                        63A08CE5E820C511A48220067A2F )  
```  
  
```  
secure.contoso.com   1546847232   DNSKEY   257   3   7   (  
                        AwEAAb4v+rZFLosf4qV1/0KZrRcPdj/ljk+Y  
                        56XQtuIjGzZG+HH3ys8zhGwJ2WRH3AyRlzLQ  
                        5ebMVP12Fmacx5UjhLAydT3rrCbqmHvrrLq9  
                        7yJa9Sgeakb/0bwUIE2K2n/g73RFAu8eM0Ut  
                        geLZAGkRxdvS8tTAHgoeVCmwbZitxwjVSsZ1  
                        cEK7yQJKspwghszXBfonC202GvgCp6F30J4E  
                        1LjVJsqPo9ZrccFpFZS4kSEfEz45YXPP/VBx  
                        IFRgejdtBL9j6yqf4qo/GynjPSWJY3KOLn/r  
                        2wWzujxTLIdpXUdowXGPa8jJU/tDi9avo7+M  
                        XIF3LBpvF9derokq/3L6AmE=  
                        ) ; key tag = 37458  
                    1546847232   DNSKEY   257   3   7   (  
                        AwEAAdwL+faFmv/JToQFA94PnqfXI/ZCYvEq  
                        S5jxmLeZKjl5/xMA2hhaGeKtmS8yTMqeYWm5  
                        p0MkzDKFMyisjF03N7aBsgLy33GVAea2ipxt  
                        hjec14q/M37KTgAFh2OyjM4z+Rf+osip0dsv  
                        KVl5vXgYYFXqf52aEoYiYe2PfWM0mJtl1NlA  
                        uYAu4h3140AHynIIJYJkCV+ptHuSECEFYNBf  
                        aO1Qg9KKVvH7sH9Crfz2sHb0+sVsi2+IgBjD  
                        ILXCW8af7bowl0yhL1qB+njegKxzI8IpnOA+  
                        MDWZvaJCtTQGPUjTwG0qjWBzO4bONHTLqkyR  
                        /jvPTciJ+Qah3h5apITtwL8=  
                        ) ; key tag = 9468  
```  
  
For information about the components of a trust anchor, see [Working with trust anchors](../Topic/Trust-Anchors.md#working_with) in this topic.  
  
A validating DNS server that uses a DS trust anchor must query the authoritative DNS server to obtain the full DNSKEY resource record set \(RRSet\). This process is called "priming" of the trust anchor and can be an advantage because it forces the validating server to acquire up\-to\-date information.  
  
You can install one or both types of trust anchors on a validating DNS server. Active Directory\-integrated DNS servers store trust anchors in Active Directory. If a DNS server is not Active Directory\-integrated, trust anchors are stored in the text file: **%windir%\\system32\\dns\\TrustAnchors.dns**.  
  
DNSSEC validation is enabled by default on the **Advanced** tab of DNS server properties. You can modify and check the status of this setting with dnscmd.exe. See the following example.  
  
```  
PS C:\> dnscmd /info /enablednssec  
Query result:  
Dword:  0 (00000000)  
Command completed successfully.  
```  
  
In the previous example, DNSSEC validation is disabled. To enable DNSSEC validation, you must configure the value to 1.  
  
```  
PS C:\> dnscmd /config /enablednssec 1  
Registry property enablednssec successfully reset.  
Command completed successfully.  
  
PS C:\> dnscmd /info /enablednssec  
Query result:  
Dword:  1 (00000001)  
Command completed successfully.  
```  
  
You can modify this setting in DNS Manager or by using the dnscmd.exe tool.  
  
## <a name="chain"></a>Delegations and the chain of trust  
A delegation is a referral of authority from one DNS server to a different DNS server for a specific namespace. Delegations are commonly used to assign authority for child zones.  
  
For example, the Internet root DNS servers delegate DNS authority for .com to generic top\-level domain \(gTLD\) servers. See the following example using nslookup.exe.  
  
```  
PS C:\> nslookup -q=NS microsoft.com. a.root-servers.net  
com   nameserver = m.gtld-servers.net  
com   nameserver = l.gtld-servers.net  
com   nameserver = k.gtld-servers.net  
com   nameserver = j.gtld-servers.net  
com   nameserver = i.gtld-servers.net  
com   nameserver = h.gtld-servers.net  
com   nameserver = g.gtld-servers.net  
com   nameserver = f.gtld-servers.net  
com   nameserver = e.gtld-servers.net  
com   nameserver = d.gtld-servers.net  
com   nameserver = c.gtld-servers.net  
com   nameserver = b.gtld-servers.net  
com   nameserver = a.gtld-servers.net  
…  
```  
  
In turn, the gTLD servers delegate authority for microsoft.com to msft.net authoritative DNS servers. See the following example.  
  
```  
PS C:\> nslookup -q=NS microsoft.com. a.gtld-servers.net  
microsoft.com   nameserver = ns3.msft.net  
microsoft.com   nameserver = ns1.msft.net  
microsoft.com   nameserver = ns5.msft.net  
microsoft.com   nameserver = ns2.msft.net  
microsoft.com   nameserver = ns4.msft.net  
…  
```  
  
The following example uses the **Get\-DnsServerZoneDelegation** cmdlet to verify delegation for *corp.adatum.com* and *finance.corp.adatum.com*.  
  
```  
PS C:\> Get-DnsServerZoneDelegation -Name adatum.com -ChildZoneName corp -ComputerName dc2.contoso.com  
  
ZoneName                           ChildZoneName                      NameServer                         IPAddress  
--------                           -------------                      ----------                         ---------  
adatum.com                         corp.adatum.com.                   dc2.contoso.com.                   192.168.0.2  
  
PS C:\> Get-DnsServerZoneDelegation -Name corp.adatum.com -ChildZoneName finance -ComputerName dc2.contoso.com  
  
ZoneName                           ChildZoneName                      NameServer                         IPAddress  
--------                           -------------                      ----------                         ---------  
corp.adatum.com                    finance.corp.adatum.com.           dc2.contoso.com.                   192.168.0.2  
```  
  
Delegations are important because they establish a chain of authentication for child zones. If all zones in the chain are signed with DNSSEC, resolving DNS servers can have only a single delegation signer \(DS\) trust anchor installed, provided that appropriate DS records are available in the parent zone.  
  
With delegations, it is not always necessary to install a trust anchor for every zone that a caching DNS server can validate. Under certain conditions, you can build a chain of authentication \(a chain of trust\) where it is sufficient for the DNS server to have only a DS trust anchor installed for the parent zone.  
  
However, if the chain of trust is broken, then a child zone must have its own trust anchor installed. For example, DNS responses for the signed zone A.B.C.com can be validated using a trust anchor for the signed zone C.com, provided that B.C.com is also signed. If B.C.com is not signed, then C.com becomes an island of trust and requires its own trust anchor. The following diagram shows this scenario.  
  
![](../Image/DNSSEC_validation-tree.png)  
  
In scenarios where islands of trust are present, a trust anchor must be configured for the root of each island. In the preceding diagram, zones that are shown in blue are signed while those in white are not. The right side of the tree is completely signed; the left side of the tree is intermittently signed. In order for a DNS server to be able to perform DNSSEC validation for all the signed zones, you must configure trust anchors for the zones in yellow.  
  
Additional trust anchors for the other signed zones can be added to a DNS server, but the trust anchors for the zones in yellow are sufficient for full validation of all signed zones.  
  
After a zone is DNSSEC\-signed, and if the parent of the zone is also DNSSEC\-signed, the signed delegation records must be added to the parent zone, and the parent zone must be re\-signed. This process must be performed every time a new child zone is signed for the first time, or if a child zone is re\-signed with a new key signing key. If you own a signed zone but do not own the children of the zone, and if the children zones are in the process of being DNSSEC\-signed one at a time, you must re\-sign your zone after adding the delegation records each time a new child zone is signed. However, the process of signing multiple zones can be optimized if you own the parent as well as the children zones that are to be signed.  
  
### <a name="DS"></a>The delegation signer \(DS\) resource record  
Like the DNSKEY resource record, the delegation signer \(DS\) resource record can be used to create a trust anchor for a signed zone. The DS record is smaller in size than a DNSKEY record because it contains only a hash of the public key.  
  
The DS record is not added to a zone during the signing process like some DNSSEC\-related resource records, even if a delegation already exists in the zone. To add a DS record, you must manually add or import it. Fortunately, the DS resource record set \(DSSET\) is automatically added as a file to the Key Master when a zone is signed. You can use this file with the **Import\-DnsServerResourceRecordDS** cmdlet to import DS records to the parent zone. See the following example.  
  
```  
PS C:\> Import-DnsServerResourceRecordDS -ZoneName adatum.com -DSSetFile "c:\windows\system32\dns\dsset-corp.adatum.com"  
PS C:\> Get-DnsServerResourceRecord -ZoneName adatum.com -RRType DS  
  
HostName                  RecordType Timestamp            TimeToLive      RecordData  
--------                  ---------- ---------            ----------      ----------  
corp                      DS         0                    01:00:00        [58555][Sha1][RsaSha1NSec3]  
corp                      DS         0                    01:00:00        [58555][Sha256][RsaSha1NSec3]  
corp                      DS         0                    01:00:00        [63513][Sha1][RsaSha1NSec3]  
corp                      DS         0                    01:00:00        [63513][Sha256][RsaSha1NSec3]  
```  
  
In the previous example, DS records for the child zone, corp.adatum.com, were imported into the parent zone, adatum.com, by using the DSSET file that is located in the **c:\\windows\\system32\\dns** directory. The DSSET file was located in this directory because the local DNS server is the Key Master for the child zone. If the Key Master DNS server for a child zone is not the same computer as the primary authoritative DNS server for the parent zone where you are adding the DS record, you must obtain the DSSET file for the child zone and make it available to the primary authoritative server for the parent zone. Alternatively, you can manually add DS records.  
  
DS records must be added to each parent zone in a chain of authentication. For example, DS records for finance.corp.adatum.com must be added to corp.adatum.com to complete a chain of authentication from finance.corp.adatum.com to adatum.com. See the following example.  
  
```  
PS C:\> Import-DnsServerResourceRecordDS -ZoneName corp.adatum.com -DSSetFile "c:\windows\system32\dns\dsset-finance.corp.adatum.com"  
PS C:\> Get-DnsServerResourceRecord -ZoneName corp.adatum.com -RRType DS  
  
HostName                  RecordType Timestamp            TimeToLive      RecordData  
--------                  ---------- ---------            ----------      ----------  
finance                   DS         0                    01:00:00        [58990][Sha1][RsaSha256]  
finance                   DS         0                    01:00:00        [58990][Sha256][RsaSha256]  
finance                   DS         0                    01:00:00        [40231][Sha1][RsaSha256]  
finance                   DS         0                    01:00:00        [40231][Sha256][RsaSha256]  
```  
  
If the chain of authentication is completedwith proper delegations in each zone and DS records added to the parent, a recursive DNS server can have a trust anchor present for only the parent zone and provide validation for all child zones. In the following example, a DNS client requires validation for the *adatum.com* namespace.  
  
```  
PS C:\> Get-DnsClientNrptPolicy -Effective  
  
Namespace                        : .adatum.com  
QueryPolicy                      : QueryIPv6Only  
SecureNameQueryFallback          : FallbackPrivate  
DirectAccessIPsecCARestriction   :  
DirectAccessProxyName            :  
DirectAccessDnsServers           :  
DirectAccessEnabled              : False  
DirectAccessProxyType            :  
DirectAccessQueryIPsecEncryption :  
DirectAccessQueryIPsecRequired   :  
NameServers                      :  
DnsSecIPsecCARestriction         :  
DnsSecQueryIPsecEncryption       :  
DnsSecQueryIPsecRequired         : False  
DnsSecValidationRequired         : True  
NameEncoding                     :  
```  
  
A resolving DNS server with IP address of 192.168.0.4 has a trust anchor for *adatum.com*.  
  
```  
PS C:\> Get-DnsServerTrustPoint -ComputerName 192.168.0.4  
  
TrustPointName                           TrustPointState      LastActiveRefreshTime     NextActiveRefreshTime  
--------------                           ---------------      ---------------------     ---------------------  
adatum.com.                              Active               1/22/2014 2:05:50 PM      1/22/2014 2:06:06 PM  
```  
  
DNSSEC validation is successful for DNS queries in the *finance.corp.adatum.com* zone because this zone and *corp.adatum.com* have the appropriate delegations and DS records.  
  
```  
PS C:\> Resolve-DnsName -Name mail.finance.corp.adatum.com -Type A -Server 192.168.0.4 -dnssecok  
  
Name                                           Type   TTL   Section    IPAddress  
----                                           ----   ---   -------    ---------  
mail.finance.corp.adatum.com                   A      3599  Answer     192.168.0.150  
  
Name        : mail.finance.corp.adatum.com  
QueryType   : RRSIG  
TTL         : 3599  
Section     : Answer  
TypeCovered : A  
Algorithm   : 8  
LabelCount  : 5  
OriginalTtl : 3600  
Expiration  : 1/31/2014 10:03:18 PM  
Signed      : 1/21/2014 9:03:18 PM  
Signer      : finance.corp.adatum.com  
Signature   : {80, 88, 162, 208...}  
  
…  
```  
  
## <a name="working_with"></a>Working with trust anchors  
Because trust anchors represent public keys for corresponding zones, trust anchors must be updated if the public keys for a zone change, such as when a zone is re\-signed. Additionally, if trust anchors are distributed after a zone is signed and the zone becomes unsigned at a later date, trust anchors for the zone must be removed. If trust anchors are not removed when a zone is unsigned, DNS servers will continue to attempt validation of DNS responses for the zone, but this validation will fail and therefore DNS resolution for the zone will fail.  
  
You can update trust anchors manually, or you can use the automated update mechanism as described in [RFC 5011](http://tools.ietf.org/search/rfc5011) \(http:\/\/tools.ietf.org\/search\/rfc5011\).  
  
> [!IMPORTANT]  
> [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] fully support RFC 5011. Support for RFC 5011 is enabled on the authoritative DNS server on a zone\-by\-zone basis. However, trust anchor updates are only supported for automated key rollover. If you manually re\-sign or unsign a zone, or manually roll zone signing keys, trust anchors on validating DNS servers are not automatically updated.  
  
Trust anchors that have been enabled for RFC 5011 automatic updates have information that is stored in the file **%windir%\\system32\\dns\\RFC5011.csv** on the DNS server where the trust anchor is installed.  
  
When you sign a zone on a DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or later, the public DNSKEY and DS resource record sets \(the set of all resource records of that type, also known as the RRSET\) are stored as text files in the **%windir%\\system32\\dns** directory on the Key Master. The DNSKEY RRSET \(or KEYSET\) is stored as a file with the name *keyset\-<zone name>* and the DS RRSET \(or DSSET\) is stored as a file with the name *dsset\-<zone name>*.  
  
For example, after signing the secure.contoso.com zone, the following files are created on the Key Master.  
  
|Key type|File name|  
|------------|-------------|  
|DNSKEY|*keyset\-secure.contoso.com*|  
|DS|*dsset\-secure.contoso.com*|  
  
During zone signing, DNSKEY resource records are also added to the zone along with RRSIG, NSEC, and other records. DS records are not automatically added to a zone.  
  
These KEYSET and DSSET files can be used to export trust anchors for the zone and to manually add a trust anchor. For more information, see [Procedure: Export a Trust Point](../Topic/Procedure--Export-a-Trust-Point.md) and [Procedure: Add a Trust Point](../Topic/Procedure--Add-a-Trust-Point.md).  
  
The KEYSET \(DNSKEY\) file has the following format: <zone name> <TTL> IN DNSKEY <flags> <protocol> <algorithm> <Base64Data>; key tag \= <key tag>. See the following example.  
  
```  
  
secure.contoso.com.   3600   IN   DNSKEY   257 3 8 (  
                        AwEAAbMK6im/lrLB546v9jl41p/g7/30X9Cn  
                        k5anwOnQu8JBOYt0CUiXci1lxO/280NHB/Eu  
                        1r7Nk0AQPwvZ7Dqbdd7eqvKX/WJgK85UtONR  
                        PjhbCNe4vj7Qr8GmUW/aQdDIZqqdstLJINfE  
                        k3GgOFslSUkoWpP+z9BwnuEnv6jFkguLikj6  
                        X9aM1N0bjLMDvi34PlRKGxOA6WsDyN96abzz  
                        Iuj00LjKBL4+0JBwuRB+tIOAMLLsXtLI4Dby  
                        Zz6/ewZHI0FELbDnUDj5hqCWU+J2IBTbs4mW  
                        WKRHpTdZtNYda8Oy9+SMQJh/pIepKAjrJkzM  
                        wZWFgg0qqn5QXVIms3T/pZk=  
                        ) ; key tag = 62111  
                       3600   IN   DNSKEY   257 3 8 (  
                        AwEAAY/kENeHkSmtdBzPhiHiDGPcbwA7nkau  
                        MsASiXOMIM+2btAYq6GczO45kuemvXmJU1o6  
                        eyeJmphDGm649UOjOiebIokJ31m3K1mymrpF  
                        R6DfY2WTwLMtnPuiiyvif9qcF5yKoVthownG  
                        kG3/vJbDyRGONteTtJFOZZDtDHLOh624jz73  
                        KUds4uq6VWZ+UhCZFneNNtz2e4NyjxGSf5ZK  
                        kKOpmj/Q2veAbV8Ck5fieydOMvOi2HM6oop9  
                        YrAGRUvmwH2Bg/enDiWr7+FDCEzem4bP4QDT  
                        ng6qjSvNGfRTtq6x4zySPcd7BMv1Q5nBpdjU  
                        UCNXRU37nTXB7/sSKQCmFic=  
                        ) ; key tag = 8000  
  
```  
  
Two keys are present in the file. If the flag field is an odd number, the key represents a KSK \(secure entry point\). If the flag field is an even number, the key is a ZSK. In the previous example, both keys are KSKs because the flag field is 257. The protocol is always DNSSEC, which is represented by the number 3, and the algorithm is RSA\/SHA\-256 that corresponds to the number 8.  
  
The DSSET \(DS\) file has the following format: <zone name> <TTL> IN DS <key tag> <algorithm> <type> \( digest \). See the following example.  
  
```  
secure.contoso.com.   3600   IN   DS   16945 8 1 (  
                        86A50FB9A986CB32BF878FFFEF3DC00D5732  
                        3ED8 )  
                     3600   IN    DS   16945 8 2 (  
                        59FFBE7F9C06FC939C772DDAA8D7A5F3B316  
                        4082059FBC5D689DFD6B0290310E )  
                     3600   IN    DS   39301 8 1 (  
                        565B5B1FC1616CF84514D28814D34A1C2397  
                        8008 )  
                     3600   IN    DS   39301 8 2 (  
                        6A634D28ABF17E723EDBCD981120DC736A08  
                        CF7170E849303B9357B52D18F9D3 )  
```  
  
If you add a DS trust anchor to a DNS server and the DS record is present in the DNS zone—remember that DS records are not automatically added during zone signing—the DNS server uses the digest in the DS record to acquire a DNSKEY for the zone.  
  
## <a name="TA_status"></a>Trust anchor status  
To view the status of a trust anchor on a DNS server, you can use the DNS Manager console or Windows PowerShell. Trust anchors are organized and displayed in the DNS Manager console tree under **Trust Points**. The Windows PowerShell cmdlets **Get\-DnsServerTrustAnchor** and **Get\-DnsServerTrustPoint** can also provide status of trust anchors. The **Get\-DnsServerTrustAnchor** cmdlet requires that you specify a namespace, whereas **Get\-DnsServerTrustPoint** displays all configured trust anchors on the DNS server if a name is not specified. See the following examples.  
  
```  
PS C:\> Get-DnsServerTrustAnchor -Name adatum.com  
  
TrustAnchorName                TrustAnchorType      TrustAnchorState     TrustAnchorData  
---------------                ---------------      ----------------     ---------------  
adatum.com.                    DNSKEY               Valid                [48955][DnsSec][RsaSha256][AwEAAcTxpB/tf4DA...  
adatum.com.                    DNSKEY               Valid                [2504][DnsSec][RsaSha256][DNS Servers](../Topic/DNS-Servers.md)  
  
[DNS Clients](../Topic/DNS-Clients.md)  
  
[DNS Zones](../Topic/DNS-Zones.md)  
  
[The NRPT](../Topic/The-NRPT.md)  
  
