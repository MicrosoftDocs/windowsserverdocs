---
title: Procedure: Verify DNS Resolution
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c0407f8-1985-4e0e-9a26-23aca34ca120
---
# Procedure: Verify DNS Resolution
Use the following procedures to verify DNS resolution on a DNS client using Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
For information about configuring name resolution policy, see [The NRPT](../Topic/The-NRPT.md).  
  
Name resolution policy settings can only be applied to computers that are security\-aware. For more information about security\-aware computers, see [Security\-aware client](../Topic/DNS-Clients.md#sec_aware).  
  
Use the Verify DNSSEC validation procedure in this topic to verify that name resolution works as expected.  
  
## <a name="validation"></a>Verify DNSSEC validation  
To use the example Windows PowerShell commands that are provided, replace the server and zone names with the names of the servers and zones that are used in your environment.  
  
#### To verify DNSSEC validation  
  
1.  Open a Windows PowerShell prompt on a DNS client computer.  
  
2.  To verify DNSSEC validation, use the **Resolve\-DnsName** cmdlet. First, verify that name resolution is successful when querying an authoritative DNS server. See the following example.  
  
    ```  
    PS C:\> Resolve-DnsName secure.contoso.com -Server dc2.contoso.com -dnssecok  
  
    Name                        Type TTL   Section    PrimaryServer               NameAdministrator           SerialNumber  
    ----                        ---- ---   -------    -------------               -----------------           ------------  
    secure.contoso.com          SOA  3600  Authority  dc2.contoso.com             hostmaster.contoso.com      6  
  
    Name        : secure.contoso.com  
    QueryType   : RRSIG  
    TTL         : 3600  
    Section     : Authority  
    TypeCovered : SOA  
    Algorithm   : 8  
    LabelCount  : 3  
    OriginalTtl : 3600  
    Expiration  : 1/26/2014 10:27:53 PM  
    Signed      : 1/16/2014 9:27:53 PM  
    Signer      : secure.contoso.com  
    Signature   : {56, 217, 3, 225...}  
  
    Name      : vfo5uo7g4u40gj25v1s0p3mh3pp7aai2.secure.contoso.com  
    QueryType : NSEC3  
    TTL       : 3600  
    Section   : Authority  
  
    Name        : vfo5uo7g4u40gj25v1s0p3mh3pp7aai2.secure.contoso.com  
    QueryType   : RRSIG  
    TTL         : 3600  
    Section     : Authority  
    TypeCovered : NSEC3  
    Algorithm   : 8  
    LabelCount  : 4  
    OriginalTtl : 3600  
    Expiration  : 1/26/2014 10:27:53 PM  
    Signed      : 1/16/2014 9:27:53 PM  
    Signer      : secure.contoso.com  
    Signature   : {97, 195, 245, 11...}  
  
    Name      : .  
    QueryType : OPT  
    TTL       : 32768  
    Section   : Additional  
    Data      : {} PS C:\> Get-DnsServerZone -Name corp.contoso.com  
  
    ZoneName                            ZoneType        IsAutoCreated   IsDsIntegrated  IsReverseLookupZone  IsSigned  
    --------                            --------        -------------   --------------  -------------------  --------  
    corp.contoso.com                    Primary         False           False           False                True  
    ```  
  
    In this example, the primary authoritative DNS server *dc2.contoso.com* is queried. Since authoritative responses are always valid, the DNS query will succeed. DNSSEC\-related resource records are displayed because the zone is signed. If a zone is not signed, such as the contoso.com zone in the following example, RRSIG records are not displayed in the output.  
  
    ```  
    PS C:\> Resolve-DnsName contoso.com -Server dc2.contoso.com -dnssecok  
  
    Name                                           Type   TTL   Section    IPAddress  
    ----                                           ----   ---   -------    ---------  
    contoso.com                                    A      600   Answer     192.168.0.2  
    contoso.com                                    A      600   Answer     192.168.0.3  
    contoso.com                                    A      600   Answer     192.168.0.1  
  
    Name      : .  
    QueryType : OPT  
    TTL       : 32768  
    Section   : Additional  
    Data      : {}  
    ```  
  
3.  Next, use the **Resolve\-DnsName** cmdlet to query a nonauthoritative, resolving DNS server with a valid trust anchor installed. See the following example.  
  
    ```  
    PS C:\> Resolve-DnsName secure.contoso.com -Server 192.168.0.4 -dnssecok  
  
    Name                        Type TTL   Section    PrimaryServer               NameAdministrator           SerialNumber  
    ----                        ---- ---   -------    -------------               -----------------           ------------  
    secure.contoso.com          SOA  830   Authority  dc2.contoso.com             hostmaster.contoso.com      6  
  
    Name        : secure.contoso.com  
    QueryType   : RRSIG  
    TTL         : 830  
    Section     : Authority  
    TypeCovered : SOA  
    Algorithm   : 8  
    LabelCount  : 3  
    OriginalTtl : 3600  
    Expiration  : 1/26/2014 10:27:53 PM  
    Signed      : 1/16/2014 9:27:53 PM  
    Signer      : secure.contoso.com  
    Signature   : {56, 217, 3, 225...}  
  
    Name      : vfo5uo7g4u40gj25v1s0p3mh3pp7aai2.secure.contoso.com  
    QueryType : NSEC3  
    TTL       : 830  
    Section   : Authority  
  
    Name        : vfo5uo7g4u40gj25v1s0p3mh3pp7aai2.secure.contoso.com  
    QueryType   : RRSIG  
    TTL         : 830  
    Section     : Authority  
    TypeCovered : NSEC3  
    Algorithm   : 8  
    LabelCount  : 4  
    OriginalTtl : 3600  
    Expiration  : 1/26/2014 10:27:53 PM  
    Signed      : 1/16/2014 9:27:53 PM  
    Signer      : secure.contoso.com  
    Signature   : {97, 195, 245, 11...}  
  
    Name      : .  
    QueryType : OPT  
    TTL       : 32768  
    Section   : Additional  
    Data      : {}  
    ```  
  
    In this example, a non\-domain\-joined nonauthoritative, recursive DNS server at *192.168.0.4* is queried. Since this DNS server has a valid trust anchor installed for the *secure.contoso.com* zone, the DNS query will succeed. Again, DNSSEC\-related resource records are displayed because the zone is signed.  
  
    If DNSSEC validation does not succeed, an error will be displayed, see the following example.  
  
    ```  
    PS C:\> Resolve-DnsName secure.contoso.com -Server 192.168.0.4 -dnssecok  
    Resolve-DnsName : secure.contoso.com : DNS server failure  
    At line:1 char:1  
    + Resolve-DnsName secure.contoso.com -Server 192.168.0.4 -dnssecok  
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
        + CategoryInfo          : ResourceUnavailable: (secure.contoso.com:String) [Resolve-DnsName], Win32Exception  
        + FullyQualifiedErrorId : RCODE_SERVER_FAILURE,Microsoft.DnsClient.Commands.ResolveDnsName  
    ```  
  
    In the previous example, the DNS server at 192.168.0.4 does not have a valid trust anchor installed for the secure.contoso.com domain.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
