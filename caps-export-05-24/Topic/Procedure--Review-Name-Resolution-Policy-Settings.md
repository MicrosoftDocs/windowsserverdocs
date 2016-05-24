---
title: Procedure: Review Name Resolution Policy Settings
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b046771c-5bd0-481d-aba2-2a81ebe489d9
---
# Procedure: Review Name Resolution Policy Settings
Use the following procedures to verify name resolution policy settings on a DNS server and a DNS client using Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
For information about configuring name resolution policy settings, see [The NRPT](../Topic/The-NRPT.md).  
  
Name resolution policy settings can only be applied to computers that are security\-aware. For more information about security\-aware computers, see [Security\-aware client](../Topic/DNS-Clients.md#sec_aware).  
  
Use the following procedures to review NRPT configuration and name resolution policy:  
  
-   [Review NRPT configuration](../Topic/Procedure--Verify-Name-Resolution-Policy.md#NRPT): Check settings in the Name Resolution Policy Table \(NRPT\).  
  
-   [Review effective name resolution policy](../Topic/Procedure--Verify-Name-Resolution-Policy.md#effective): Verify whether DNSSEC or not validation is required for a given namespace.  
  
## <a name="NRPT"></a>Review NRPT configuration  
Name resolution policy is configured in the NRPT, either in domain Group Policy, local Group Policy, or both. The NRPT can be configured to require or not require that DNSSEC validation be performed for DNS queries within a given namespace.  
  
Membership in the **Administrators** group, or equivalent, is the required minimum to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To review NRPT configuration  
  
1.  Open an elevated Windows PowerShell prompt on a computer with the Group Policy Management feature installed.  
  
2.  To view a list of Group Policy Objects \(GPOs\) in the domain, use the **Get\-GPO** cmdlet, as shown in the following example.  
  
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
  
3.  To review name resolution policy settings in a GPO, use the **Get\-DnsClientNrptRule** cmdlet, as shown in the following example.  
  
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
  
    In the previous example, the *secure.contoso.com* namespace displays **True** next to **DnsSecValidationRequired**, which means that all DNS clients that are security\-aware, and that have this GPO applied, will require that queries for the *secure.contoso.com* zone are validated.  
  
## <a name="effective"></a>Review effective name resolution policy  
Although a GPO can be configured with NRPT settings, these settings do not affect a DNS client unless they are correctly applied. To verify that settings are applied, review the effective name resolution policy.  
  
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
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
