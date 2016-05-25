---
title: Procedure: Verify Name Resolution Policy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d8d49c9c-6d3c-4e2c-b766-d2fa6adef490
author: vhorne
---
# Procedure: Verify Name Resolution Policy
Use the following procedures to verify name resolution policy on a DNS server and a DNS client using Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
For information about configuring name resolution policy, see [The NRPT](../Topic/The-NRPT.md).  
  
Name resolution policy settings can only be applied to computers that are security\-aware. For more information about security\-aware computers, see [Security\-aware client](../Topic/DNS-Clients.md#sec_aware).  
  
See the following procedures:  
  
-   [Review NRPT configuration](../Topic/Procedure--Verify-Name-Resolution-Policy.md#NRPT): Check settings in the Name Resolution Policy Table \(NRPT\).  
  
-   [Review effective name resolution policy](../Topic/Procedure--Verify-Name-Resolution-Policy.md#effective): Verify whether or not DNSSEC validation is required for a given namespace.  
  
-   [Verify DNSSEC validation](../Topic/Procedure--Verify-Name-Resolution-Policy.md#validation): If DNSSEC validation has been enabled or disabled recently, verify that name resolution works as expected.  
  
## <a name="NRPT"></a>Review NRPT configuration  
Name resolution policy is configured in the NRPT, either in domain\-based Group Policy, local Group Policy, or both. The NRPT can be configured to require or not require that DNSSEC validation be performed for DNS queries within a given namespace.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To review NRPT configuration  
  
1.  Open an elevated Windows PowerShell prompt on a computer with the Group Policy Management feature installed.  
  
2.  To view a list of Group Policy Objects \(GPOs\) in the domain, use the **Get\-GPO** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-GPO -All -DomainName contoso.com | fl -Property DisplayName,GpoStatus  
  
    DisplayName : Default Domain Policy  
    GpoStatus   : AllSettingsEnabled  
  
    DisplayName : Default Domain Controllers Policy  
    GpoStatus   : AllSettingsEnabled  
  
    DisplayName : NRPT_settings  
    GpoStatus   : AllSettingsEnabled  
    ```  
  
    In the previous example, the **Format\-List** \(fl\) parameter is used to display only the **DisplayName** and **GpoStatus** properties. The **NRPT\_settings** GPO is a custom GPO that is created in this example to contain all name resolution policies for the domain. This GPO name is only an example. GPO names for your domain will be different. The example GPO is used in the following example.  
  
3.  To review name resolution policy settings in a GPO, use the **Get\-DnsClientNrptRule** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsClientNrptRule -GpoName contoso.com\NRPT_settings  
  
    Name                             : Rule1  
    Version                          : 1  
    Namespace                        : {.secure.contoso.com}  
    IPsecCARestriction               :  
    DirectAccessDnsServers           :  
    DirectAccessEnabled              : False  
    DirectAccessProxyType            :  
    DirectAccessProxyName            :  
    DirectAccessQueryIPsecEncryption :  
    DirectAccessQueryIPsecRequired   :  
    NameServers                      :  
    DnsSecEnabled                    : True  
    DnsSecQueryIPsecEncryption       :  
    DnsSecQueryIPsecRequired         : False  
    DnsSecValidationRequired         : True  
    NameEncoding                     : Disable  
    DisplayName                      :  
    Comment                          :  
    ```  
  
    In the previous example, the *secure.contoso.com* namespace displays **True** next to **DnsSecValidationRequired**, which means that all DNS clients that are security\-aware and that have this GPO applied, will require that queries for the *secure.contoso.com* zone are validated.  
  
## <a name="effective"></a>Review effective name resolution policy  
Although a GPO can be configured with NRPT settings, these settings will not affect a DNS client unless they are correctly applied. To verify that settings are applied, review the effective name resolution policy.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To review effective name resolution policy  
  
1.  Open a Windows PowerShell prompt on a DNS client computer.  
  
2.  To review effective name resolution policy, use the **Get\-DnsClientNrptPolicy** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsClientNrptPolicy -Effective  
  
    Namespace                        : .secure.contoso.com  
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
  
    In the previous example, **True** is displayed next to **DnsSecValidationRequired** for the *secure.contoso.com* namespace, which means that DNSSEC validation will be required for DNS queries in the *secure.contoso.com* zone. Output from the **Get\-DnsClientNrptPolicy** cmdlet also includes any name resolution policy that might be configured in local Group Policy.  
  
## <a name="validation"></a>Verify DNSSEC validation  
To use the Windows PowerShell examples that are provided, replace the server and zone names with the names of the servers and zones used in your environment.  
  
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
  
    In this example, the primary, authoritative DNS server *dc2.contoso.com* is queried. Since authoritative responses are always valid, the DNS query will succeed. DNSSEC\-related resource records are displayed because the zone is signed. If a zone is not signed, such as the contoso.com zone in the following example, RRSIG records are not displayed in the output.  
  
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
  
    In this example, a non\-domain\-joined, nonauthoritative, recursive DNS server at *192.168.0.4* is queried. Since this DNS server has a valid trust anchor installed for the *secure.contoso.com* zone, the DNS query will succeed. Again, DNSSEC\-related resource records are displayed because the zone is signed.  
  
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
  
