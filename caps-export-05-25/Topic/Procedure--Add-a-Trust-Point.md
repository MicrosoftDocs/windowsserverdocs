---
title: Procedure: Add a Trust Point
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75d9d13c-49fe-4356-9ea2-9c45e3ae4316
author: vhorne
---
# Procedure: Add a Trust Point
Use the following procedures to add a trust point for a zone that has been signed with DNSSEC. You can also import a trust point. To import a trust point, see [Procedure: Import a Trust Point](../Topic/Procedure--Import-a-Trust-Point.md).  
  
You can add a DNSKEY trust point, or a DS trust point. To add a DNSKEY trust point, you must be able to provide the zone name, cryptographic algorithm, and public key. To add a DS trust point, you must be able to provide the zone name, key tag, cryptographic algorithm, digest type, and digest. This information is provisioned in a trust point automatically when you import it from a file. For more information about trust points, see [Trust Anchors](../Topic/Trust-Anchors.md).  
  
Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose DNS Manager or Windows PowerShell to perform this procedure:  
  
-   [Add a trust point in DNS Manager](../Topic/Procedure--Add-a-Trust-Point.md#windows_ui)  
  
-   [Add a trust point in Windows PowerShell](../Topic/Procedure--Add-a-Trust-Point.md#PS)  
  
## <a name="windows_ui"></a>Add a trust point in DNS Manager  
The list of trust points on a DNS server is similar to a zone in DNS. If the DNS server is not Active Directory\-integrated, trust points are stored on the DNS server as a text file. By default, the list of trust points is stored in the file: **%windir%\\system32\\dns\\TrustAnchors.dns**. If the DNS server is also a domain controller, trust points are stored in Active Directory.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add a trust point in DNS Manager  
  
1.  Open DNS Manager on the DNS server where you wish to add the trust anchor, or connect to this DNS server using DNS Manager.  
  
2.  In the console tree, right\-click **Trust Points**, point to **Add**, and then click **DNSKEY** or click **DS**, depending on the type of trust point you wish to add.  
  
3.  Under **Name**, type the name of the zone.  
  
4.  Under **Algorithm**, select the cryptographic algorithm that is used for the signing key.  
  
5.  If the new trust anchor is a DS resource record, type the key tag next to **Key Tag**.  
  
6.  By default, both the **Zone Key** and **Secure Entry Point** check boxes are selected. If the signing key that is used is not a secure entry point \(SEP\), clear the **Secure Entry Point** check box.  
  
7.  Type the digest or public key under **Digest** or **Public Key** for a DNSKEY or a DS trust anchor, respectively, and then click **OK**.  
  
To view DNSKEY and DS resource record data on a DNS server, you can use the **Get\-DnsServerResourceRecord** cmdlet. See the following examples.  
  
```  
PS C:\> Get-DnsServerResourceRecord -ZoneName secure.contoso.com -RRType DNSKEY –ComputerName 192.168.0.2 | fl  
  
DistinguishedName : DC=@,DC=secure.contoso.com,cn=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com  
HostName          : @  
RecordType        : DNSKEY  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [SEP][ZoneKey][RsaSha256][1175][DnsSec][AwEAAat76D//jxQQHmPNhkfjufvoz74oj3qktZU7Byc+eD7e3OcVhmaA/p+vu+R86ei8r2GDp7EaYPZ  
                    PQMOUbNhrYPBp8GCliYq1tWy0N4tzL6mRKk+lflS6AG2guvvdCvk0VVQ14RXVggYY9y9/TDAVqOZVS4vpK2m9hdHK9dK81fMXoEcflDWYjSA7RGsZoDwW2c  
                    4Uozuopwi4AVW8g6ThfLwV7Q5rTp67IItqB3+7MgLfxmiHZZD33Xh3GAsbBhpvZF61ouLTMZJV/sOreyZT2ktvQm4YpDVzRoIfetChxnBzavcR19DbrJA/N  
                    57D0trxuoa3N9LDCfAhGENvgNSstNE=]  
  
DistinguishedName : DC=@,DC=secure.contoso.com,cn=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com  
HostName          : @  
RecordType        : DNSKEY  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [SEP][ZoneKey][RsaSha256][21046][DnsSec][AwEAAbOkjGoP3OJ1OhMqdPJHf5RnDE+QO/oP/iMkJnr3KI4SOoHgodgJb3a83mkDQp+jThxqxyTEPZ  
                    LxhIezCw5ZLmhTYPmAj66yU3iLSvj/W79ycfv5eToPCORq8q4THo60TItHQya4uR1Odp3gu22GWDFnFpor31s/DneroLLNzE447WqUq4SAvX8J00dcb2u82  
                    0sHyzzVXgo8CdNVCDNbImn9HI8/AdNlxDRwlogw+lDx4z4360rCXjuVsNsXcejua3Vz47Urf7wLiuqnq42C4JBGFkaypig21M7dUNCBHkr4ElkkaZvmzMtS  
                    N35rKOLQ//9AT1T77DxDh+1UPVlfcwE=]  
  
DistinguishedName : DC=@,DC=secure.contoso.com,cn=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com  
HostName          : @  
RecordType        : DNSKEY  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [ZoneKey][RsaSha256][24879][DnsSec][AwEAAbOHlfH8Zs2rKF7Kv+YckMsSF0p5r35iWn44fulAPLynqAJ+vjgrAomKrNfmYKLU0hchl8QZMKsv8Hi  
                    tUHDlg++esqvUvVdSatz9vXNgQsNDeGqgsl0SV1Uuqalh37j2d1r8xH7HK3TeppsPNU7MjC2bsqys0puoeMjaBxII+FgX]  
  
DistinguishedName : DC=@,DC=secure.contoso.com,cn=MicrosoftDNS,DC=DomainDnsZones,DC=contoso,DC=com  
HostName          : @  
RecordType        : DNSKEY  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [ZoneKey][RsaSha256][56980][DnsSec][AwEAAZ41CYznoxLtCU5wRGS3xK628ksj5BgisqVG2TUJPvxIEp9rY8NBWFwtdqETk/FK/owkJY9qNbeyMiV  
                    wUakGwsslXzh/hPsvb75lohKMsjSfgsvUV/E61EYlid68wBoy8Oxbf3sDFdIPmcDReQZ78ZnhCPAmRqa/seCsIjripjLx]  
  
```  
  
```  
PS C:\> Get-DnsServerResourceRecord -ZoneName adatum.com -RRType DS -ComputerName 192.168.0.2 | fl  
  
DistinguishedName : corp  
HostName          : corp  
RecordType        : DS  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [63513][RsaSha1NSec3][Sha256][E3F069CBEAC9C5168C4950FFE3E44B50E0BDB985CF2BC54D42C27CF3B80CAEF8]  
  
DistinguishedName : corp  
HostName          : corp  
RecordType        : DS  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [63513][RsaSha1NSec3][Sha1][ED0260968FF6ED47942E1993827145D54991E4CF]  
  
DistinguishedName : corp  
HostName          : corp  
RecordType        : DS  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [58555][RsaSha1NSec3][Sha256][6EBECD6D28399291D0BE4C20082C3FD1C9CDEE1A1E34E707ABD229771AE12D7E]  
  
DistinguishedName : corp  
HostName          : corp  
RecordType        : DS  
RecordClass       : IN  
TimeToLive        : 01:00:00  
Timestamp         : 0  
RecordData        : [58555][RsaSha1NSec3][Sha1][27468EAEA69B9E04C094478FD2D398B7AF7CD48A]  
  
```  
  
In the previous examples, the DNSKEY records are displayed for the zone *secure.contoso.com*, and the DS records are displayed for the zone *corp.adatum.com*.  
  
## <a name="PS"></a>Add a trust point in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
#### To add a trust point in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To add a trust point, use the **Add\-DnsServerTrustAnchor** cmdlet. See the following example.  
  
    ```  
    PS C:\> Add-DnsServerTrustAnchor -Name corp.adatum.com -KeyTag 63513 -CryptoAlgorithm RsaSha1NSec3 -DigestType Sha1 -Digest ED0260968FF6ED47942E1993827145D54991E4CF  
    ```  
  
    In this example, a DS trust point for the zone *corp.adatum.com* is added on the local DNS server.  
  
3.  Verify that the trust anchor was successfully added to the DNS server using the **Get\-DnsServerTrustAnchor** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerTrustAnchor -Name corp.adatum.com  
  
    TrustAnchorName                TrustAnchorType      TrustAnchorState     TrustAnchorData  
    ---------------                ---------------      ----------------     ---------------  
    corp.adatum.com.               DNSKEY               AddPending           [58555][DnsSec][RsaSha1NSec3][AwEAAe1ZjQR+f...  
    corp.adatum.com.               DNSKEY               Valid                [63513][DnsSec][RsaSha1NSec3][DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
